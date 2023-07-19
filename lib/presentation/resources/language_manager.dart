enum LanguageTypes { ENGLISH, ARABIC }




const String arabic = 'ar';
const String english = 'en';
extension LanguageTypeExtention on LanguageTypes {
  String getValue(){
   switch(this) {
     case LanguageTypes.ENGLISH:
       return english;
       
     case LanguageTypes.ARABIC:
       return arabic;
       
   }
  }
}
