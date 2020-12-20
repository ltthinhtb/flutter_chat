class ListDoctorResponse {
  String status;
  String messages;
  List<HistoryData> data;

  ListDoctorResponse({this.status, this.messages, this.data});
}

class HistoryData {
  String doctorImg;
  String doctorName;
  String expensive;
  String dateTime;
  String status;

  HistoryData({
    this.doctorImg,
    this.doctorName,
    this.status,
    this.dateTime,
    this.expensive,
  });
}
