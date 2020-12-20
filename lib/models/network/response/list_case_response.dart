class ListCaseResponse {
  List<CaseData> data;

  ListCaseResponse({this.data});

  ListCaseResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<CaseData>();
      json['data'].forEach((v) {
        data.add(new CaseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CaseData {
  String caseName;
  String description;
  String price;
  bool isExpanded;
  int doctorId;
  List<Treatment> treatment;

  CaseData(
      {this.caseName,
      this.description,
      this.price,
      this.treatment,
      this.doctorId,
      this.isExpanded = false});

  CaseData.fromJson(Map<String, dynamic> json) {
    caseName = json['case_name'];
    description = json['description'];
    price = json['price'];
    if (json['treatment'] != null) {
      treatment = new List<Treatment>();
      json['treatment'].forEach((v) {
        treatment.add(new Treatment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['case_name'] = this.caseName;
    data['description'] = this.description;
    data['price'] = this.price;
    if (this.treatment != null) {
      data['treatment'] = this.treatment.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Treatment {
  String treatment;
  String price;
  String id;
  String dateTime;

  Treatment({this.treatment, this.price, this.dateTime, this.id});

  Treatment.fromJson(Map<String, dynamic> json) {
    treatment = json['treatment'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['treatment'] = this.treatment;
    data['price'] = this.price;
    return data;
  }
}
