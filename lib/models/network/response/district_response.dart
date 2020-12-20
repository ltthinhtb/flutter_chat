class DistrictResponse {
  int type;
  String solrID;
  int iD;
  String title;
  int sTT;
  int tinhThanhID;
  String tinhThanhTitle;
  String tinhThanhTitleAscii;
  Null created;
  Null updated;

  DistrictResponse(
      {this.type,
        this.solrID,
        this.iD,
        this.title,
        this.sTT,
        this.tinhThanhID,
        this.tinhThanhTitle,
        this.tinhThanhTitleAscii,
        this.created,
        this.updated});

  DistrictResponse.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    solrID = json['SolrID'];
    iD = json['ID'];
    title = json['Title'];
    sTT = json['STT'];
    tinhThanhID = json['TinhThanhID'];
    tinhThanhTitle = json['TinhThanhTitle'];
    tinhThanhTitleAscii = json['TinhThanhTitleAscii'];
    created = json['Created'];
    updated = json['Updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Type'] = this.type;
    data['SolrID'] = this.solrID;
    data['ID'] = this.iD;
    data['Title'] = this.title;
    data['STT'] = this.sTT;
    data['TinhThanhID'] = this.tinhThanhID;
    data['TinhThanhTitle'] = this.tinhThanhTitle;
    data['TinhThanhTitleAscii'] = this.tinhThanhTitleAscii;
    data['Created'] = this.created;
    data['Updated'] = this.updated;
    return data;
  }
}
