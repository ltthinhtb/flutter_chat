class Prescription {
  String doctor;
  String prescriptionId;
  String facilityName;
  String createDay;
  String amount;
  List<Medicine> data;

  Prescription(
      {this.doctor,
        this.prescriptionId,
        this.facilityName,
        this.createDay,
        this.amount,
        this.data});

  Prescription.fromJson(Map<String, dynamic> json) {
    doctor = json['doctor'];
    prescriptionId = json['prescription_id'];
    facilityName = json['facilityName'];
    createDay = json['create_day'];
    amount = json['amount'];
    if (json['data'] != null) {
      data = new List<Medicine>();
      json['data'].forEach((v) {
        data.add(new Medicine.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor'] = this.doctor;
    data['prescription_id'] = this.prescriptionId;
    data['facilityName'] = this.facilityName;
    data['create_day'] = this.createDay;
    data['amount'] = this.amount;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Medicine {
  String medicineName;
  String medicineQuantity;
  String medicineUsing;
  String medicinePrice;
  String medicineId;

  Medicine(
      {this.medicineName,
        this.medicineQuantity,
        this.medicineUsing,
        this.medicinePrice,
        this.medicineId});

  Medicine.fromJson(Map<String, dynamic> json) {
    medicineName = json['medicine_name'];
    medicineQuantity = json['medicine_quantity'];
    medicineUsing = json['medicine_using'];
    medicinePrice = json['medicine_price'];
    medicineId = json['medicine_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medicine_name'] = this.medicineName;
    data['medicine_quantity'] = this.medicineQuantity;
    data['medicine_using'] = this.medicineUsing;
    data['medicine_price'] = this.medicinePrice;
    data['medicine_id'] = this.medicineId;
    return data;
  }
}
