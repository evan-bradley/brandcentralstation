# Loads necessary packages into the system.
load_packages <- function() {
    needed <- c("DBI", "RMySQL", "e1071", "rpart")
    lapply(needed, require, character.only = TRUE)
}
load_packages()

# Connects to the MySQL database.
connect_to_db <- function() {
    lapply(dbListConnections(dbDriver( drv = "MySQL")), dbDisconnect)
    dbConnect(MySQL(), user='root', password='somethingeasy', dbname='BRAND_CENTRAL', host='138.197.85.34')
}
mysqldb <- connect_to_db()

# Returns a matrix of tags.
get_tags <- function(db) {
    tag_query <- dbSendQuery(db, "select * from TAG where TAG_ACTIVE = 'YES'")
    tags <- fetch(tag_query, n=-1)
    # write.csv(tags, file = "tags.csv")
    return(tags)
}

get_product_tags <- function(db) {
    prod_tag_assign_query <- dbSendQuery(db, "select product_id, tag_id from PROD_TAG_ASSIGN")
    prod_tags <- fetch(prod_tag_assign_query, n=-1)
    # write.csv(prod_tags, file = "prod_tags.csv")
    return(prod_tags)
}

make_tag_matrix <- function(likes, tags, prod_tags) {
    for(product in likes$PRODUCT_ID) {
        product_id <- product
        prod_tag_list <- as.matrix((tags$TAG_ID %in% prod_tags[prod_tags$product_id == product_id,]$tag_id)*1)
        if(!exists("like_tag_matrix")) {
            like_tag_matrix <- t(prod_tag_list)
        } else {
            like_tag_matrix <- rbind(like_tag_matrix, t(prod_tag_list))
        }
    }

    return(like_tag_matrix)
}

get_likes <- function(db, id) {
    likes_query <- dbSendQuery(db, paste("select * from LIKES WHERE USER_ID =", id, sep = " "))
    likes <- fetch(likes_query, n=-1)
    # write.csv(likes, file = "likes.csv")

    return(likes)
}

get_dislikes <- function(db, id) {
    dislikes_query <- dbSendQuery(db, paste("select * from DISLIKES WHERE USER_ID =", id, sep = " "))
    dislikes <- fetch(dislikes_query, n=-1)
    # write.csv(dislikes, file = "dislikes.csv")

    return(dislikes)
}

get_training_data <- function(id) {
    mydb = mysqldb
    tags <- get_tags(mydb)
    prod_tags <- get_product_tags(mydb)
    likes <- get_likes(mydb, id)
    dislikes <- get_dislikes(mydb, id)

    like_tag_matrix <- make_tag_matrix(likes, tags, prod_tags)
    dislike_tag_matrix <- make_tag_matrix(dislikes, tags, prod_tags)

    class_1 <- cbind(like_tag_matrix, 1)
    class_2 <- cbind(dislike_tag_matrix, 2)

    tag_matrix <- data.frame(rbind(class_1, class_2))

    # write.csv(tag_matrix, file = "tag_matrix.csv")
    return(tag_matrix)
}

classify_naive_bayes <- function(id) {
    tag_matrix <- get_training_data(id)

    ## 75% of the sample size
    smp_size <- floor(0.75 * nrow(tag_matrix))

    ## set the seed to make your partition reproductible
    set.seed(123)
    train_ind <- sample(seq_len(nrow(tag_matrix)), size = smp_size)

    train <- tag_matrix[train_ind, ]
    test <- tag_matrix[-train_ind, ]

    x <- train[,-ncol(train)]
    y <- train[,ncol(train)]

    m <- naiveBayes(train[,-ncol(train)], as.factor(train[,ncol(train)]))
    p <- predict(m, test[,-ncol(test)])

    # Previously X2380
    m <- naiveBayes(X975 ~ ., data.frame(train))
    p <- predict(m, data.frame(test[,-ncol(test)]))

    table(p, as.factor(test[,ncol(test)]))
}

classify_decision_tree <- function(id) {
    tag_matrix <- get_training_data(id)

    ## 75% of the sample size
    smp_size <- floor(0.75 * nrow(tag_matrix))

    ## set the seed to make your partition reproductible
    set.seed(123)
    train_ind <- sample(seq_len(nrow(tag_matrix)), size = smp_size)

    train <- tag_matrix[train_ind, ]
    test <- tag_matrix[-train_ind, ]

    fit <- rpart(X975 ~ ., data.frame(train), method="class")
    p <- predict(fit, data.frame(test[,-ncol(test)]), type = "class")

    table(p, test[,ncol(test)])
    return(fit)
}
