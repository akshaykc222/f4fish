enum ProductStatus {
  ORDERED,
  CANCELLED,
  PENDING,
  DELIVERED,
  SHIPPED,
}


getProductStatusFromJson(String json) {
  return ProductStatus.values.firstWhere((element) => element.name == json);
}

enum AddressType { HOME, OFFICE }
