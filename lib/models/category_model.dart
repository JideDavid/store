class ProductsCategory{
  final int id;
  final String name;
  final String image;

  ProductsCategory({required this.id, required this.name, required this.image});

  factory ProductsCategory.fromJson( Map<String, dynamic> resp){
    return ProductsCategory(
        id: resp["id"],
        name: resp["name"],
        image: resp["image"]);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
  };

}