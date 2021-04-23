class Users {
  final String email;
  final String password;
  final int phone;
  final String name;
  Users({this.name, this.email, this.phone, this.password});

  Map<String,dynamic> toMap(){
    return{
      'email':email,
      'password':password,
      'phone':phone,
      'name':name,
    };
  }

  factory Users.fromJson(Map<String,dynamic> map){
    return Users(
      email: map['email'],
      name: map['name'],
      password: map['password'],
      phone: int.parse(map['phone'])
    );
  }
}
