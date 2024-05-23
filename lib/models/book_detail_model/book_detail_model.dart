


class BookDetail {
  int? id;
  String? code;
  String? name;
  int? topicBookId;
  String? avatar;
  double? avgRate;
  int? totalSold;
  int? totalReview;
  String? author;
  String? publisher;
  String? bookDetailsCode;
  String? bookDetailsId;
  String? bookTypes;
  String? bookPrices;
  String? sellersName;
  String? issuer;
  String? translator;
  int? pageNumber;
  String? publicationTime;
  int? coverType;
  String? dimension;
  String? description;
  String? sellerIsdn;
  String? sellerAvatar;
  String? sellerFullname;
  String? sellerSubject;
  String? sellerSpecializeLevel;
  String? sellerExp;
  String? sellerDepartment;
  String? sellerIntro;
  bool? inCart;
  bool? inPurchase;
  bool? inWishlist;
  bool? haveHot;
  bool? haveBestSeller;
  HardBook? hardBook;
  AudioBook? audioBook;
  EBook? ebook;

  BookDetail({
    this.id,
    this.code,
    this.name,
    this.topicBookId,
    this.avatar,
    this.avgRate,
    this.totalSold,
    this.totalReview,
    this.author,
    this.publisher,
    this.bookDetailsCode,
    this.bookDetailsId,
    this.bookTypes,
    this.bookPrices,
    this.sellersName,
    this.issuer,
    this.translator,
    this.pageNumber,
    this.publicationTime,
    this.coverType,
    this.dimension,
    this.description,
    this.sellerIsdn,
    this.sellerAvatar,
    this.sellerFullname,
    this.sellerSubject,
    this.sellerSpecializeLevel,
    this.sellerExp,
    this.sellerDepartment,
    this.sellerIntro,
    this.inCart,
    this.inPurchase,
    this.inWishlist,
    this.haveHot,
    this.haveBestSeller,
    this.hardBook,
    this.audioBook,
    this.ebook,
  });

  factory BookDetail.fromJson(Map<String, dynamic> json) {
    return BookDetail(
      id: json['data']['id'],
      code: json['data']['code'],
      name: json['data']['name'],
      topicBookId: json['data']['topicBookId'],
      avatar: json['data']['avatar'],
      avgRate: json['data']['avgRate'],
      totalSold: json['data']['totalSold'],
      totalReview: json['data']['totalReview'],
      author: json['data']['author'],
      publisher: json['data']['publisher'],
      bookDetailsCode: json['data']['bookDetailsCode'],
      bookDetailsId: json['data']['bookDetailsId'],
      bookTypes: json['data']['bookTypes'],
      bookPrices: json['data']['bookPrices'],
      sellersName: json['data']['sellersName'],
      issuer: json['data']['issuer'],
      translator: json['data']['translator'],
      pageNumber: json['data']['pageNumber'],
      publicationTime: json['data']['publicationTime'],
      coverType: json['data']['coverType'],
      dimension: json['data']['dimension'],
      description: json['data']['description'],
      sellerIsdn: json['data']['sellerIsdn'],
      sellerAvatar: json['data']['sellerAvatar'],
      sellerFullname: json['data']['sellerFullname'],
      sellerSubject: json['data']['sellerSubject'],
      sellerSpecializeLevel: json['data']['sellerSpecializeLevel'],
      sellerExp: json['data']['sellerExp'],
      sellerDepartment: json['data']['sellerDepartment'],
      sellerIntro: json['data']['sellerIntro'],
      inCart: json['data']['inCart'],
      inPurchase: json['data']['inPurchase'],
      inWishlist: json['data']['inWishlist'],
      haveHot: json['data']['haveHot'],
      haveBestSeller: json['data']['haveBestSeller'],
      hardBook: json['data']['hardBook'] != null ? HardBook.fromJson(json['data']['hardBook']) : null,
      audioBook: json['data']['audioBook']  != null ? AudioBook.fromJson(json['data']['audioBook']) : null,
      ebook: json['data']['ebook']  != null ? EBook.fromJson(json['data']['ebook']) : null,
    );
  }
}

class HardBook {
  int? id;
  String? code;
  int? type;
  int? price;
  bool? inCart;
  bool? inPurchase;

  HardBook({
    this.id,
    this.code,
    this.type,
    this.price,
    this.inCart,
    this.inPurchase,
  });

  factory HardBook.fromJson(Map<String, dynamic> json) {
    return HardBook(
      id: json['id'],
      code: json['code'],
      type: json['type'],
      price: json['price'],
      inCart: json['inCart'],
      inPurchase: json['inPurchase'],
    );
  }
}
class EBook {
  int? id;
  String? code;
  int? type;
  int? price;
  bool? inCart;
  int? inPurchase;

  EBook({
    this.id,
    this.code,
    this.type,
    this.price,
    this.inCart,
    this.inPurchase,
  });

  factory EBook.fromJson(Map<String, dynamic> json) {
    return EBook(
      id: json['id'],
      code: json['code'],
      type: json['type'],
      price: json['price'],
      inCart: json['inCart'],
      inPurchase: json['inPurchase'],
    );
  }
}

class AudioBook {
  int? id;
  String? code;
  int? type;
  int? price;
  bool? inCart;
  int? inPurchase;

  AudioBook({
    this.id,
    this.code,
    this.type,
    this.price,
    this.inCart,
    this.inPurchase,
  });

  factory AudioBook.fromJson(Map<String, dynamic> json) {
    return AudioBook(
      id: json['id'],
      code: json['code'],
      type: json['type'],
      price: json['price'],
      inCart: json['inCart'],
      inPurchase: json['inPurchase'],
    );
  }
}
