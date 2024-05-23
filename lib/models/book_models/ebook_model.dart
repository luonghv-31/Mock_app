class EbookModel {
  List<BookContentDTO>? bookContentDTO;
  BooksDetailsDTO? booksDetailsDTO;

  EbookModel({this.bookContentDTO, this.booksDetailsDTO});

  EbookModel.fromJson(Map<String, dynamic> json) {
    if (json['bookContentDTO'] != null) {
      bookContentDTO = <BookContentDTO>[];
      json['bookContentDTO'].forEach((v) {
        bookContentDTO!.add(BookContentDTO.fromJson(v));
      });
    }
    booksDetailsDTO = json['booksDetailsDTO'] != null
        ?  BooksDetailsDTO.fromJson(json['booksDetailsDTO'])
        : null ;
  }

 
  
}

class BookContentDTO {
  int? bookContentId;
  String? bookContentName;
  int? bookContentOrder;
  String? filePath;
  String? fileId;
  String? fileName;
  String? fileSize;
  int? type;
  int? value;
  dynamic inPurchase;

  BookContentDTO(
      {this.bookContentId,
      this.bookContentName,
      this.bookContentOrder,
      this.filePath,
      this.fileId,
      this.fileName,
      this.fileSize,
      this.type,
      this.value,
      this.inPurchase});

  BookContentDTO.fromJson(Map<String, dynamic> json) {
    bookContentId = json['bookContentId'];
    bookContentName = json['bookContentName'];
    bookContentOrder = json['bookContentOrder'];
    filePath = json['filePath'];
    fileId = json['fileId'];
    fileName = json['fileName'];
    fileSize = json['fileSize'];
    type = json['type'];
    value = json['value'];
    inPurchase = json['inPurchase'];
  }

 
}

class BooksDetailsDTO {
  int? id;
  String? code;
  String? name;
  dynamic topicBookId;
  String? avatar;
  double? avgRate;
  int? totalSold;
  int? totalReview;
  String? author;
  String? publisher;
  String? bookDetailsCode;
  dynamic bookDetailsId;
  String? bookTypes;
  String? bookPrices;
  String? sellersName;
  dynamic issuer;
  dynamic translator;
  dynamic pageNumber;
  dynamic publicationTime;
  dynamic coverType;
  dynamic dimension;
  dynamic description;
  dynamic sellerIsdn;
  dynamic sellerAvatar;
  dynamic sellerFullname;
  dynamic sellerSubject;
  dynamic sellerSpecializeLevel;
  dynamic sellerExp;
  dynamic sellerDepartment;
  dynamic sellerIntro;
  dynamic inCart;
  dynamic inPurchase;
  dynamic inWishlist;
  bool? haveHot;
  bool? haveBestSeller;
  dynamic hardBook;
  dynamic audioBook;
  dynamic topicBookName;
  dynamic ebook;

  BooksDetailsDTO(
      {this.id,
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
      this.topicBookName,
      this.ebook});

  BooksDetailsDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    topicBookId = json['topicBookId'];
    avatar = json['avatar'];
    avgRate = json['avgRate'];
    totalSold = json['totalSold'];
    totalReview = json['totalReview'];
    author = json['author'];
    publisher = json['publisher'];
    bookDetailsCode = json['bookDetailsCode'];
    bookDetailsId = json['bookDetailsId'];
    bookTypes = json['bookTypes'];
    bookPrices = json['bookPrices'];
    sellersName = json['sellersName'];
    issuer = json['issuer'];
    translator = json['translator'];
    pageNumber = json['pageNumber'];
    publicationTime = json['publicationTime'];
    coverType = json['coverType'];
    dimension = json['dimension'];
    description = json['description'];
    sellerIsdn = json['sellerIsdn'];
    sellerAvatar = json['sellerAvatar'];
    sellerFullname = json['sellerFullname'];
    sellerSubject = json['sellerSubject'];
    sellerSpecializeLevel = json['sellerSpecializeLevel'];
    sellerExp = json['sellerExp'];
    sellerDepartment = json['sellerDepartment'];
    sellerIntro = json['sellerIntro'];
    inCart = json['inCart'];
    inPurchase = json['inPurchase'];
    inWishlist = json['inWishlist'];
    haveHot = json['haveHot'];
    haveBestSeller = json['haveBestSeller'];
    hardBook = json['hardBook'];
    audioBook = json['audioBook'];
    topicBookName = json['topicBookName'];
    ebook = json['ebook'];
  }

 
}
