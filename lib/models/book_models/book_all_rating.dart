class BookAllRating {
  int? id;
  int? rate;
  String? contentBuyer;
  dynamic parentId;
  String? createTime;
  String? createName;
  int? productType;
  String? productCode;
  dynamic purchaseDetailsId;
  String? filePathBuyer;
  String? fileIdBuyer;
  String? fileNameBuyer;
  List<ListFileBuyer>? listFileBuyer;
  String? avatarBuyer;
  String? fullNameBuyer;
  String? contentSeller;
  String? filePathSeller;
  String? fileIdSeller;
  String? fileNameSeller;
  List<ListFileSeller>? listFileSeller;
  String? avatarSeller;
  String? fullNameSeller;

  BookAllRating(
      {this.id,
      this.rate,
      this.contentBuyer,
      this.parentId,
      this.createTime,
      this.createName,
      this.productType,
      this.productCode,
      this.purchaseDetailsId,
      this.filePathBuyer,
      this.fileIdBuyer,
      this.fileNameBuyer,
      this.listFileBuyer,
      this.avatarBuyer,
      this.fullNameBuyer,
      this.contentSeller,
      this.filePathSeller,
      this.fileIdSeller,
      this.fileNameSeller,
      this.listFileSeller,
      this.avatarSeller,
      this.fullNameSeller});

  BookAllRating.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rate = json['rate'];
    contentBuyer = json['contentBuyer'];
    parentId = json['parentId'];
    createTime = json['createTime'];
    createName = json['createName'];
    productType = json['productType'];
    productCode = json['productCode'];
    purchaseDetailsId = json['purchaseDetailsId'];
    filePathBuyer = json['filePathBuyer'];
    fileIdBuyer = json['fileIdBuyer'];
    fileNameBuyer = json['fileNameBuyer'];
    if (json['listFileBuyer'] != null) {
      listFileBuyer = <ListFileBuyer>[];
      json['listFileBuyer'].forEach((v) {
        listFileBuyer!.add(ListFileBuyer.fromJson(v));
      });
    }
    avatarBuyer = json['avatarBuyer'];
    fullNameBuyer = json['fullNameBuyer'];
    contentSeller = json['contentSeller'];
    filePathSeller = json['filePathSeller'];
    fileIdSeller = json['fileIdSeller'];
    fileNameSeller = json['fileNameSeller'];
    if (json['listFileSeller'] != null) {
      listFileSeller = <ListFileSeller>[];
      json['listFileSeller'].forEach((v) {
        listFileSeller!.add(ListFileSeller.fromJson(v));
      });
    }
    avatarSeller = json['avatarSeller'];
    fullNameSeller = json['fullNameSeller'];
  }
}

class ListFileBuyer {
  String? fileId;
  String? fileName;
  String? path;
  int? type;

  ListFileBuyer({this.fileId, this.fileName, this.path, this.type});

  ListFileBuyer.fromJson(Map<String, dynamic> json) {
    fileId = json['fileId'];
    fileName = json['fileName'];
    path = json['path'];
    type = json['type'];
  }
}

class ListFileSeller {
  String? fileId;
  String? fileName;
  String? path;
  int? type;

  ListFileSeller({this.fileId, this.fileName, this.path, this.type});

  ListFileSeller.fromJson(Map<String, dynamic> json) {
    fileId = json['fileId'];
    fileName = json['fileName'];
    path = json['path'];
    type = json['type'];
  }
}
