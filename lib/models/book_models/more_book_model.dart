class BookRelateModel {
  int? id;
  String? code;
  String? name;
  String? topicBookName;
  String? avatar;
  String? bookTypes;
  String? bookDetailsCode;
  String? bookDetailsId;
  String? bookPrices;
  int? minPrice;
  int? view;
  String? sellersName;
  String? author;
  double? avgRate;
  int? totalSold;
  int? totalReview;
  double? hot;
  dynamic inWishlist;
  dynamic inCart;
  dynamic inPurchase;
  bool? haveHot;
  bool? haveBestSeller;
  dynamic hardBook;
  AudioBook? audioBook;
  AudioBook? ebook;

  BookRelateModel(
      {this.id,
      this.code,
      this.name,
      this.topicBookName,
      this.avatar,
      this.bookTypes,
      this.bookDetailsCode,
      this.bookDetailsId,
      this.bookPrices,
      this.minPrice,
      this.view,
      this.sellersName,
      this.author,
      this.avgRate,
      this.totalSold,
      this.totalReview,
      this.hot,
      this.inWishlist,
      this.inCart,
      this.inPurchase,
      this.haveHot,
      this.haveBestSeller,
      this.hardBook,
      this.audioBook,
      this.ebook});

  BookRelateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    topicBookName = json['topicBookName'];
    avatar = json['avatar'];
    bookTypes = json['bookTypes'];
    bookDetailsCode = json['bookDetailsCode'];
    bookDetailsId = json['bookDetailsId'];
    bookPrices = json['bookPrices'];
    minPrice = json['minPrice'];
    view = json['view'];
    sellersName = json['sellersName'];
    author = json['author'];
    avgRate = json['avgRate'];
    totalSold = json['totalSold'];
    totalReview = json['totalReview'];
    hot = json['hot'];
    inWishlist = json['inWishlist'];
    inCart = json['inCart'];
    inPurchase = json['inPurchase'];
    haveHot = json['haveHot'];
    haveBestSeller = json['haveBestSeller'];
    hardBook = json['hardBook'] ?? "";
    audioBook = json['audioBook'] != null
        ? AudioBook.fromJson(json['audioBook'])
        : null;
    ebook = json['ebook'] != null ? AudioBook.fromJson(json['ebook']) : null;
  }
}

class AudioBook {
  int? id;
  String? code;
  int? type;
  int? price;
  Null inCart;
  Null inPurchase;
  Null totalSold;
  Null purchasedProductId;

  AudioBook(
      {this.id,
      this.code,
      this.type,
      this.price,
      this.inCart,
      this.inPurchase,
      this.totalSold,
      this.purchasedProductId});

  AudioBook.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    type = json['type'];
    price = json['price'];
    inCart = json['inCart'];
    inPurchase = json['inPurchase'];
    totalSold = json['totalSold'];
    purchasedProductId = json['purchasedProductId'];
  }
}
