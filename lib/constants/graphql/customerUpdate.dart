const String customerUpdateAddress =
    """mutation updatecustomerAccount(\$name:String,\$phoneNumber:String,\$address:AddressType,\$customerId:String){
  updateCustomerAccount(name:\$name,phoneNumber:\$phoneNumber,address:\$address,customerId:\$customerId){
    error{
      path
      message
    }
    jwtToken
  }
}""";
