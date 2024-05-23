class BookTotalReview {
  int? totalReview;
  ListReviewRate? listReviewRate;

  BookTotalReview({this.totalReview, this.listReviewRate});

  BookTotalReview.fromJson(Map<String, dynamic> json) {
    totalReview = json['totalReview'];
    listReviewRate = json['listReviewRate'] != null
        ? ListReviewRate.fromJson(json['listReviewRate'])
        : null;
  }
}

class ListReviewRate {
  int? totalRate4;
  int? totalRate5;
  int? totalRate1;
  int? totalRate2;
  int? totalRate3;

  ListReviewRate(
      {this.totalRate4,
      this.totalRate5,
      this.totalRate1,
      this.totalRate2,
      this.totalRate3});

  ListReviewRate.fromJson(Map<String, dynamic> json) {
    totalRate4 = json['totalRate4'];
    totalRate5 = json['totalRate5'];
    totalRate1 = json['totalRate1'];
    totalRate2 = json['totalRate2'];
    totalRate3 = json['totalRate3'];
  }
}
