class Rating{
  final double rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson( Map<String, dynamic> resp){
    return Rating(
      rate: double.parse(resp["rate"].toString()),
      count: resp["count"],
    );
  }

  Map<String, dynamic> toJson() => {
    "rate" : rate,
    "count" : count,
  };

}