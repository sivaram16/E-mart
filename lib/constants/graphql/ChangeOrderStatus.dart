const String changeOrder =
    """mutation ChangeOrderStatus(\$status:String,\$orderId:String){
  changeOrderStatus(status:\$status,orderId:\$orderId){
   orders{
    status
  }
    error{
      path
      message
    }
    
  }
  }""";
