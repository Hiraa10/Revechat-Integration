class VisitorModel {
  String? visitorName;
  String? visitorEmail;
  String? visitorNumber;

  VisitorModel({this.visitorName, this.visitorEmail, this.visitorNumber});

  VisitorModel.fromJson(Map<String, dynamic> json) {
    visitorName = json['visitorName'];
    visitorEmail = json['visitorEmail'];
    visitorNumber = json['visitorNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['visitorName'] = visitorName;
    data['visitorEmail'] = visitorEmail;
    data['visitorNumber'] = visitorNumber;
    return data;
  }
}