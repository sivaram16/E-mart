const String customerRegister = """
  mutation CustomerRegister(\$phoneNumber:String,\$name:String,\$password:String
){
  customerRegister(phoneNumber:\$phoneNumber,name:\$name,password:\$password){
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
}
""";
