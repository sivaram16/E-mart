const String getCustomerInfo = """query GetCustomerInfo(\$customerId:String){
  getCustomerInfo(customerId:\$customerId){
    user{
      address
    }
    
  }
}""";
