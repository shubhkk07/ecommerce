import 'package:form_field_validator/form_field_validator.dart';

String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp( pattern );
    if (!regex.hasMatch( value ))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validateName(String name) {
    if (name.length <= 1) {
      return "Enter your name";
    }
  }

  final passwordValidator = MultiValidator( [
    RequiredValidator( errorText: 'password is required' ),
    MinLengthValidator(
        8, errorText: 'password must be at least 8 digits long' ),
    PatternValidator( r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must contain one uppercase letter, numeric and one special character' )
  ] );

  String phoneValidation(String phone){
    if(phone.toString().length==10)
    {
      return 'Enter valid number';
    }
  }