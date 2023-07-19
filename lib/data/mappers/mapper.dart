import 'package:advanced_course/app/constants.dart';
import 'package:advanced_course/app/extentions.dart';
import 'package:advanced_course/data/responses/responses.dart';
import 'package:advanced_course/domain/models/models.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        id: this?.id.orEmpty() ?? AppConstants.empty,
        name: this?.name.orEmpty() ?? AppConstants.empty,
        numberOfNotifications:
            this?.numberOfNotifications.orZero() ?? AppConstants.zero);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
        phone: this?.phone.orEmpty() ?? AppConstants.empty,
        email: this?.email.orEmpty() ?? AppConstants.empty,
        link: this?.link.orEmpty() ?? AppConstants.empty);
  }
}

extension AuthenticationResponeMapper on AuthenticationRespone? {
  Authentication toDomain() {
    return Authentication(
        customer: this?.customer.toDomain(),
        contacts: this?.contacts.toDomain());
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  ForgotPassword toDomain() {
    return ForgotPassword(
        suuport: this?.support.orEmpty() ?? AppConstants.empty);
  }
}
