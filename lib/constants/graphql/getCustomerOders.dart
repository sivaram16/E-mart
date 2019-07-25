const String getCustomerOrders = """
query getCustomerOrders{
  getCustomerOrders{
    orders{
      id
      orderNo
      address
      staff{
        phoneNumber
      }
      cartItems
      status
      datePlaced
      updatedDate
      totalPrice
      
    }
    
  }
}""";
