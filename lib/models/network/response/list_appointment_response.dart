class ListAppointment {
  List<Appointment> data;

  ListAppointment({this.data});

  ListAppointment.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Appointment>();
      json['data'].forEach((v) {
        data.add(new Appointment.fromJson(v));
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

class Appointment {
  String doctorName;
  String doctorAvatar;
  String status;
  String dateTime;
  String startTime;
  String appointmentTime;

  Appointment(
      {this.doctorName,
        this.doctorAvatar,
        this.status,
        this.dateTime,
        this.startTime,
        this.appointmentTime});

  Appointment.fromJson(Map<String, dynamic> json) {
    doctorName = json['doctor_name'];
    status = json['status'];
    dateTime = json['date_time'];
    startTime = json['start_time'];
    appointmentTime = json['appointment_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_name'] = this.doctorName;
    data['status'] = this.status;
    data['date_time'] = this.dateTime;
    data['start_time'] = this.startTime;
    data['appointment_time'] = this.appointmentTime;
    return data;
  }
}
