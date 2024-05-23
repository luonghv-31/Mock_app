class BookModel {
  BookModel({
    required this.id,
    required this.code,
    required this.name,
    required this.topicBookName,
    required this.avatar,
    required this.bookTypes,
    required this.bookDetailsCode,
    required this.bookDetailsId,
    required this.bookPrices,
    required this.minPrice,
    required this.view,
    required this.sellersName,
    required this.author,
    required this.avgRate,
    required this.totalSold,
    required this.totalReview,
    required this.hot,
    required this.inWishlist,
    required this.inCart,
    required this.inPurchase,
    required this.haveHot,
    required this.haveBestSeller,
    required this.hardBook,
    required this.audioBook,
  });

  final int? id;
  final String? code;
  final String? name;
  final String? topicBookName;
  final String? avatar;
  final String? bookTypes;
  final String? bookDetailsCode;
  final String? bookDetailsId;
  final String? bookPrices;
  final int? minPrice;
  final int? view;
  final String? sellersName;
  final String? author;
  final int? avgRate;
  final int? totalSold;
  final int? totalReview;
  final int? hot;
  final dynamic inWishlist;
  final dynamic inCart;
  final dynamic inPurchase;
  final bool? haveHot;
  final bool? haveBestSeller;
  final dynamic hardBook;
  final dynamic audioBook;

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json["id"],
      code: json["code"],
      name: json["name"],
      topicBookName: json["topicBookName"],
      avatar: json["avatar"],
      bookTypes: json["bookTypes"],
      bookDetailsCode: json["bookDetailsCode"],
      bookDetailsId: json["bookDetailsId"],
      bookPrices: json["bookPrices"],
      minPrice: json["minPrice"],
      view: json["view"],
      sellersName: json["sellersName"],
      author: json["author"],
      avgRate: json["avgRate"],
      totalSold: json["totalSold"],
      totalReview: json["totalReview"],
      hot: json["hot"],
      inWishlist: json["inWishlist"],
      inCart: json["inCart"],
      inPurchase: json["inPurchase"],
      haveHot: json["haveHot"],
      haveBestSeller: json["haveBestSeller"],
      hardBook: json["hardBook"],
      audioBook: json["audioBook"],
    );
  }
}
