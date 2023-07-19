class SliderObject {
  String title;
  String subTitle;
  String image;
  SliderObject(
      {required this.title, required this.subTitle, required this.image});
}

class SliderViewObject {
  int numOfSlides;
  int currentSlideIndex;
  SliderObject sliderObject;
  SliderViewObject({
    required this.numOfSlides,
    required this.currentSlideIndex,
    required this.sliderObject,
  });
}

//Login Models

class Customer {
  String id;
  String name;
  int numberOfNotifications;
  Customer({
    required this.id,
    required this.name,
    required this.numberOfNotifications,
  });
}



class Contacts {
  String link;
  String phone;
  String email;
  Contacts({
    required this.link,
    required this.phone,
    required this.email,
  });
}


class Authentication {
  Customer? customer;
  Contacts? contacts;
  Authentication({
    required this.customer,
    required this.contacts,
  });
}


//forgot password model

class ForgotPassword {
  String suuport;
  ForgotPassword({
    required this.suuport,
  });
}
