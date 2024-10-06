class CartModel{
  final int id;
  int units;

  CartModel({
    required this.id,
    required this.units,
  });

  factory CartModel.fromJson( Map<String, dynamic> resp){
    return CartModel(
      id: resp["id"],
      units: resp["units"]
    );
  }

  Map<String, dynamic> toJson() => {
    "id" : id,
    "units": units,
  };

  @override
  String toString() {
    return 'CartModel{id: $id, units: $units}';
  }
}