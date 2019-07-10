const customerLogin =
    """ mutation CustomerLogin(\$phoneNumber:String,\$password:String){
  customerLogin(phoneNumber:\$phoneNumber,password:\$password){
    user{
      id
      name
      phoneNumber

    }
    error{
      path
      message
    }
    jwtToken
  }
}""";
