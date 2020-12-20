import 'package:vn_dental/models/network/response/billing_address.dart';
import 'package:vn_dental/models/network/response/list_case_response.dart';
import 'package:vn_dental/models/network/response/list_doctor_response.dart';
import 'package:vn_dental/models/network/response/list_prescription.dart';

class HistoryDetailResponse {
  CaseData caseData;
  DoctorData doctorData;
  DateTime dateTime;
  BillingAddress billingAddress;
  String name;
  String gender;
  String age;
  String email;
  String phone;
  Prescription prescription;

  HistoryDetailResponse(
      {this.caseData,
      this.doctorData,
      this.dateTime,
      this.billingAddress,
      this.name,
      this.gender,
      this.age,
      this.email,
      this.phone,
      this.prescription});
}

