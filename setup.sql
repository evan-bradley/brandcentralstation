/* Create database and use it for subsequent commands */
-- DROP DATABASE IF EXISTS BRAND_CENTRAL;
CREATE DATABASE IF NOT EXISTS BRAND_CENTRAL;
USE BRAND_CENTRAL;

/* Setup tables for database. */

/* Tables for students and meetings. */
CREATE TABLE IF NOT EXISTS USER (
    USER_ID        INTEGER(8) UNIQUE NOT NULL AUTO_INCREMENT,
    USERNAME       VARCHAR(35) NOT NULL,
    USER_LNAME     VARCHAR(35) NOT NULL,
    USER_FNAME     VARCHAR(35) NOT NULL,
    USER_EMAIL     VARCHAR(35) UNIQUE NOT NULL,
    USER_PASS_HASH VARCHAR(100) NOT NULL,
    USER_PICT_URL  VARCHAR(100) DEFAULT NULL,
    USER_MODEL	   VARCHAR(35) DEFAULT NULL,
    LAST_SEEN      DATETIME DEFAULT NULL,
    PASS_ATTEMPTS  INTEGER(1) DEFAULT 0,
    VERIFICATION   VARCHAR(100) DEFAULT NULL,
    VERIFIED       BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (USER_ID)
);

CREATE TABLE IF NOT EXISTS PRODUCT	 (
    PRODUCT_ID    INTEGER(8) NOT NULL AUTO_INCREMENT,
    PROD_NAME     VARCHAR(250) NOT NULL,
    -- PROD_MFCTR    VARCHAR(35) DEFAULT NULL,
    PROD_DESC     MEDIUMTEXT DEFAULT NULL,
    PROD_PICT_URL VARCHAR(250) NOT NULL,
    PROD_MODEL    VARCHAR(35) DEFAULT NULL,
    PRIMARY KEY (PRODUCT_ID)
);

CREATE TABLE IF NOT EXISTS CHANNEL (
	CHANNEL_ID		INTEGER(8) UNIQUE NOT NULL AUTO_INCREMENT,
	CHANNEL_NAME	VARCHAR(35) NOT NULL,
    PRIMARY KEY (CHANNEL_ID)
);

CREATE TABLE IF NOT EXISTS TAG (
	TAG_ID		INTEGER(8) UNIQUE NOT NULL AUTO_INCREMENT,
    TAG_DESC	VARCHAR(35) NOT NULL,
    PRIMARY KEY (TAG_ID)
);

CREATE TABLE IF NOT EXISTS CHANNEL_TAG_ASSIGN (
	CHANNEL_ID	INTEGER(8) NOT NULL,
    TAG_ID		INTEGER(8) NOT NULL,
    PRIMARY KEY (CHANNEL_ID, TAG_ID),
    FOREIGN KEY (CHANNEL_ID) REFERENCES CHANNEL(CHANNEL_ID),
    FOREIGN KEY (TAG_ID) REFERENCES TAG(TAG_ID)
);

CREATE TABLE IF NOT EXISTS CHANNEL_USER_ASSIGN (
	CHANNEL_ID	INTEGER(8) NOT NULL,
    USER_ID		INTEGER(8) NOT NULL,
    PRIMARY KEY (CHANNEL_ID, USER_ID),
    FOREIGN KEY (CHANNEL_ID) REFERENCES CHANNEL(CHANNEL_ID),
    FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID)
);

CREATE TABLE IF NOT EXISTS FOLLOWING (
	FOLLOWER_ID 		INTEGER(8) NOT NULL,
    USER_FOLLOWED_ID	INTEGER(8) NOT NULL,
    PRIMARY KEY (FOLLOWER_ID, USER_FOLLOWED_ID),
    FOREIGN KEY (FOLLOWER_ID) REFERENCES USER(USER_ID),
    FOREIGN KEY (USER_FOLLOWED_ID) REFERENCES USER(USER_ID)
);

CREATE TABLE IF NOT EXISTS LIKES (
	USER_ID		INTEGER(8) NOT NULL,
    PRODUCT_ID	INTEGER(8) NOT NULL,
    PRIMARY KEY (USER_ID, PRODUCT_ID),
    FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID)
);

CREATE TABLE IF NOT EXISTS DISLIKES (
	USER_ID		INTEGER(8) NOT NULL,
    PRODUCT_ID	INTEGER(8) NOT NULL,
    PRIMARY KEY (USER_ID, PRODUCT_ID),
    FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID)
);

CREATE TABLE IF NOT EXISTS PROD_TAG_ASSIGN (
	PRODUCT_ID		INTEGER(8) NOT NULL,
    TAG_ID			INTEGER(8) NOT NULL,
    PROD_TAG_STR	INTEGER(8) NOT NULL,
    PRIMARY KEY (PRODUCT_ID, TAG_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID),
    FOREIGN KEY (TAG_ID) REFERENCES TAG(TAG_ID)
);

/* Create database for session storage. */
CREATE DATABASE IF NOT EXISTS SESSION_STORE;
