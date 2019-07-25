const String createNewOrder =
    """mutation createNewOrder(\$address:AddressType,\$cartItems:[CartItemInput]){
  createNewOrder(address:\$address,cartItems:\$cartItems){
    error{
      path
      message
    }
    orders{
      id
      orderNo
      address
      staff{
        name
        id
        phoneNumber
      }
      customer
      {
        phoneNumber
        name
        address
      }
      cartItems
      status
      datePlaced
      updatedDate
      totalPrice
      
    }
  }
}""";
