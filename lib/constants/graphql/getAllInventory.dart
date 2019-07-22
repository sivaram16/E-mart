const getAllInventory = """
query GetAllInventory{
  getAllInventory{
    inventory{
      id,
      name,
      price,
      perUnit,
      unit,
      category,
      inStock,
      photoUrl
    }
  }
}""";
