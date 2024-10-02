class ProductModel{
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rate;
  final int rateCount;

  ProductModel({
    required this.id,
    required this.title, 
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rate,
    required this.rateCount
  });

  factory ProductModel.fromJson( Map<String, dynamic> resp){
    return ProductModel(
      id: resp["id"],
      title: resp["title"],
      price: double.parse(resp["price"].toString()),
      description: resp["description"],
      category: resp["category"],
      image: resp["image"],
      rate: double.parse(resp["rating"]["rate"].toString()),
      rateCount: resp["rating"]["count"]
    );
  }

  Map<String, dynamic> toJson() => {
    "id" : id,
    "title" : title,
    "price" : price,
    "description" : description,
    "category" : category,
    "image" : image,
    "rate" : rate,
    "rateCount" : rateCount,
  };

}