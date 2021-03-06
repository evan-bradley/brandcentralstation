"use strict";
exports.__esModule = true;
var Classes;
(function (Classes) {
    var User = /** @class */ (function () {
        function User(id, userName, email, password, firstName, lastName) {
            if (id === void 0) { id = ""; }
            if (userName === void 0) { userName = ""; }
            if (email === void 0) { email = ""; }
            if (password === void 0) { password = ""; }
            if (firstName === void 0) { firstName = ""; }
            if (lastName === void 0) { lastName = ""; }
            this.Id = id;
            this.FirstName = firstName;
            this.LastName = lastName;
            this.UserName = userName;
            this.Email = email;
            this.Password = password;
        }
        return User;
    }());
    Classes.User = User;
    var PasswordVerification = /** @class */ (function () {
        function PasswordVerification(currentPassword, newPassword, verifyNewPassword) {
            if (currentPassword === void 0) { currentPassword = ""; }
            if (newPassword === void 0) { newPassword = ""; }
            if (verifyNewPassword === void 0) { verifyNewPassword = ""; }
            this.CurrentPassword = currentPassword;
            this.NewPassword = newPassword;
            this.VerifyNewPassword = verifyNewPassword;
        }
        PasswordVerification.prototype.Verify = function (currentPassword) {
            return (this.CurrentPassword === currentPassword && this.NewPassword === this.VerifyNewPassword);
        };
        return PasswordVerification;
    }());
    Classes.PasswordVerification = PasswordVerification;
    var Product = /** @class */ (function () {
        function Product(id, name, description, pictureUrl, productUrl) {
            if (name === void 0) { name = ""; }
            if (description === void 0) { description = ""; }
            if (productUrl === void 0) { productUrl = ""; }
            this.id = id;
            this.name = name;
            this.description = description;
            this.pictureUrl = pictureUrl;
            this.productUrl = productUrl;
        }
        return Product;
    }());
    Classes.Product = Product;
  var ChannelProduct = /** @class */ (function () {
    function ChannelProduct(id, name, description, pictureUrl, productUrl, channelid, tagid) {
      if (name === void 0) { name = ""; }
      if (description === void 0) { description = ""; }
      if (productUrl === void 0) { productUrl = ""; }
      if (channelid === void 0) { channelid = ""; }
      if (tagid === void 0) { tagid = ""; }
      this.id = id;
      this.name = name;
      this.description = description;
      this.pictureUrl = pictureUrl;
      this.productUrl = productUrl;
      this.channelid = channelid;
      this.tagid = tagid;
    }
    return ChannelProduct;
  }());
  Classes.ChannelProduct = ChannelProduct;
})(Classes = exports.Classes || (exports.Classes = {}));
