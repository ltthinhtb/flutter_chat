// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Đóng`
  String get close {
    return Intl.message(
      'Đóng',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Chưa đặt`
  String get status_pending {
    return Intl.message(
      'Chưa đặt',
      name: 'status_pending',
      desc: '',
      args: [],
    );
  }

  /// `Bắt đầu xử lý`
  String get status_starting {
    return Intl.message(
      'Bắt đầu xử lý',
      name: 'status_starting',
      desc: '',
      args: [],
    );
  }

  /// `Đang đánh giá`
  String get status_reviewing {
    return Intl.message(
      'Đang đánh giá',
      name: 'status_reviewing',
      desc: '',
      args: [],
    );
  }

  /// `Chờ tiếp nhận`
  String get status_waiting {
    return Intl.message(
      'Chờ tiếp nhận',
      name: 'status_waiting',
      desc: '',
      args: [],
    );
  }

  /// `Quá hạn`
  String get status_over_date {
    return Intl.message(
      'Quá hạn',
      name: 'status_over_date',
      desc: '',
      args: [],
    );
  }

  /// `Đã tiếp nhận`
  String get status_confirmed {
    return Intl.message(
      'Đã tiếp nhận',
      name: 'status_confirmed',
      desc: '',
      args: [],
    );
  }

  /// `Đang xử lý`
  String get status_processing {
    return Intl.message(
      'Đang xử lý',
      name: 'status_processing',
      desc: '',
      args: [],
    );
  }

  /// `Từ chối`
  String get status_refuse {
    return Intl.message(
      'Từ chối',
      name: 'status_refuse',
      desc: '',
      args: [],
    );
  }

  /// `Đã đặt`
  String get status_submitted {
    return Intl.message(
      'Đã đặt',
      name: 'status_submitted',
      desc: '',
      args: [],
    );
  }

  /// `Đã hoàn thành`
  String get status_completed {
    return Intl.message(
      'Đã hoàn thành',
      name: 'status_completed',
      desc: '',
      args: [],
    );
  }

  /// `Đã hủy`
  String get status_canceled {
    return Intl.message(
      'Đã hủy',
      name: 'status_canceled',
      desc: '',
      args: [],
    );
  }

  /// `Đã thanh toán`
  String get payment_paid {
    return Intl.message(
      'Đã thanh toán',
      name: 'payment_paid',
      desc: '',
      args: [],
    );
  }

  /// `Chưa thanh toán`
  String get payment_not_paid {
    return Intl.message(
      'Chưa thanh toán',
      name: 'payment_not_paid',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập số điện thoại`
  String get please_input_phone_number {
    return Intl.message(
      'Vui lòng nhập số điện thoại',
      name: 'please_input_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại không hợp lệ`
  String get phone_not_valid {
    return Intl.message(
      'Số điện thoại không hợp lệ',
      name: 'phone_not_valid',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập tên khách hàng`
  String get please_enter_customer_name {
    return Intl.message(
      'Vui lòng nhập tên khách hàng',
      name: 'please_enter_customer_name',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập địa chỉ`
  String get please_enter_address {
    return Intl.message(
      'Vui lòng nhập địa chỉ',
      name: 'please_enter_address',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập tên`
  String get please_enter_name {
    return Intl.message(
      'Vui lòng nhập tên',
      name: 'please_enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập họ`
  String get please_enter_name_1 {
    return Intl.message(
      'Vui lòng nhập họ',
      name: 'please_enter_name_1',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập thời gian đặt dịch vụ`
  String get please_enter_delivery_time {
    return Intl.message(
      'Vui lòng nhập thời gian đặt dịch vụ',
      name: 'please_enter_delivery_time',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập địa chỉ cụ thể`
  String get please_enter_delivery_address {
    return Intl.message(
      'Vui lòng nhập địa chỉ cụ thể',
      name: 'please_enter_delivery_address',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng chấp nhận điều khoản dịch vụ của FAS để đặt dịch vụ.`
  String get please_accept_rule_fas {
    return Intl.message(
      'Vui lòng chấp nhận điều khoản dịch vụ của FAS để đặt dịch vụ.',
      name: 'please_accept_rule_fas',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập OTP để xác minh SĐT`
  String get please_enter_otp {
    return Intl.message(
      'Vui lòng nhập OTP để xác minh SĐT',
      name: 'please_enter_otp',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập mật khẩu`
  String get please_enter_password {
    return Intl.message(
      'Vui lòng nhập mật khẩu',
      name: 'please_enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập xác thực mật khẩu`
  String get please_input_re_password {
    return Intl.message(
      'Vui lòng nhập xác thực mật khẩu',
      name: 'please_input_re_password',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập email`
  String get please_input_email {
    return Intl.message(
      'Vui lòng nhập email',
      name: 'please_input_email',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập Họ tên`
  String get please_input_username {
    return Intl.message(
      'Vui lòng nhập Họ tên',
      name: 'please_input_username',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập Địa Chỉ`
  String get please_input_address {
    return Intl.message(
      'Vui lòng nhập Địa Chỉ',
      name: 'please_input_address',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập Thành Phố`
  String get please_enter_city {
    return Intl.message(
      'Vui lòng nhập Thành Phố',
      name: 'please_enter_city',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập Quận/Huyện`
  String get please_enter_district {
    return Intl.message(
      'Vui lòng nhập Quận/Huyện',
      name: 'please_enter_district',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập Phường/Xã`
  String get please_enter_ward {
    return Intl.message(
      'Vui lòng nhập Phường/Xã',
      name: 'please_enter_ward',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ không thể lớn hơn 100 ký tự`
  String get address_max_length {
    return Intl.message(
      'Địa chỉ không thể lớn hơn 100 ký tự',
      name: 'address_max_length',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập mối quan hệ`
  String get please_input_relationship {
    return Intl.message(
      'Vui lòng nhập mối quan hệ',
      name: 'please_input_relationship',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu không trùng nhau!`
  String get password_not_match {
    return Intl.message(
      'Mật khẩu không trùng nhau!',
      name: 'password_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Email không hợp lệ`
  String get email_not_valid {
    return Intl.message(
      'Email không hợp lệ',
      name: 'email_not_valid',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu phải có ít nhất 4 ký tự`
  String get password_least_character {
    return Intl.message(
      'Mật khẩu phải có ít nhất 4 ký tự',
      name: 'password_least_character',
      desc: '',
      args: [],
    );
  }

  /// `Thay đổi mật khẩu`
  String get change_password {
    return Intl.message(
      'Thay đổi mật khẩu',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu hiện tại`
  String get curr_password {
    return Intl.message(
      'Mật khẩu hiện tại',
      name: 'curr_password',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu mới`
  String get new_password {
    return Intl.message(
      'Mật khẩu mới',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Nhập lại mật khẩu mới`
  String get confirm_new_password {
    return Intl.message(
      'Nhập lại mật khẩu mới',
      name: 'confirm_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập Ghi chú`
  String get please_enter_note {
    return Intl.message(
      'Vui lòng nhập Ghi chú',
      name: 'please_enter_note',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập Mật Khẩu Mới`
  String get please_enter_new_password {
    return Intl.message(
      'Vui lòng nhập Mật Khẩu Mới',
      name: 'please_enter_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập xác thực Mật Khẩu Mới`
  String get please_enter_confirm_password {
    return Intl.message(
      'Vui lòng nhập xác thực Mật Khẩu Mới',
      name: 'please_enter_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập mật khẩu hiện tại`
  String get please_enter_curr_password {
    return Intl.message(
      'Vui lòng nhập mật khẩu hiện tại',
      name: 'please_enter_curr_password',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu mới không thể giống mật khẩu hiện tại`
  String get cannot_same_current_password {
    return Intl.message(
      'Mật khẩu mới không thể giống mật khẩu hiện tại',
      name: 'cannot_same_current_password',
      desc: '',
      args: [],
    );
  }

  /// `Tiếp theo`
  String get continueStep {
    return Intl.message(
      'Tiếp theo',
      name: 'continueStep',
      desc: '',
      args: [],
    );
  }

  /// `Bước`
  String get stepOf {
    return Intl.message(
      'Bước',
      name: 'stepOf',
      desc: '',
      args: [],
    );
  }

  /// `Chọn mục khám`
  String get select_case {
    return Intl.message(
      'Chọn mục khám',
      name: 'select_case',
      desc: '',
      args: [],
    );
  }

  /// `Chọn thời gian`
  String get select_time {
    return Intl.message(
      'Chọn thời gian',
      name: 'select_time',
      desc: '',
      args: [],
    );
  }

  /// `Chọn giờ hẹn`
  String get select_times {
    return Intl.message(
      'Chọn giờ hẹn',
      name: 'select_times',
      desc: '',
      args: [],
    );
  }

  /// `Chọn bác sĩ`
  String get select_doctor {
    return Intl.message(
      'Chọn bác sĩ',
      name: 'select_doctor',
      desc: '',
      args: [],
    );
  }

  /// `Họ tên`
  String get name {
    return Intl.message(
      'Họ tên',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại`
  String get phone_number_1 {
    return Intl.message(
      'Số điện thoại',
      name: 'phone_number_1',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin bệnh nhân`
  String get patient_info {
    return Intl.message(
      'Thông tin bệnh nhân',
      name: 'patient_info',
      desc: '',
      args: [],
    );
  }

  /// `Mã giảm giá`
  String get coupons {
    return Intl.message(
      'Mã giảm giá',
      name: 'coupons',
      desc: '',
      args: [],
    );
  }

  /// `Áp dụng`
  String get apply {
    return Intl.message(
      'Áp dụng',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Thành phố`
  String get city {
    return Intl.message(
      'Thành phố',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Quận/Huyện`
  String get district {
    return Intl.message(
      'Quận/Huyện',
      name: 'district',
      desc: '',
      args: [],
    );
  }

  /// `Xã/Phường`
  String get ward {
    return Intl.message(
      'Xã/Phường',
      name: 'ward',
      desc: '',
      args: [],
    );
  }

  /// `Giới tính`
  String get gender {
    return Intl.message(
      'Giới tính',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ`
  String get address {
    return Intl.message(
      'Địa chỉ',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin cá nhân`
  String get see_profile {
    return Intl.message(
      'Thông tin cá nhân',
      name: 'see_profile',
      desc: '',
      args: [],
    );
  }

  /// `Giá tiền`
  String get price {
    return Intl.message(
      'Giá tiền',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin chi tiết`
  String get more {
    return Intl.message(
      'Thông tin chi tiết',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Tuổi`
  String get age {
    return Intl.message(
      'Tuổi',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập tuổi`
  String get please_enter_age {
    return Intl.message(
      'Vui lòng nhập tuổi',
      name: 'please_enter_age',
      desc: '',
      args: [],
    );
  }

  /// `Lưu mới người dùng`
  String get save_new_patient {
    return Intl.message(
      'Lưu mới người dùng',
      name: 'save_new_patient',
      desc: '',
      args: [],
    );
  }

  /// `Liên hệ với chúng tôi`
  String get contact {
    return Intl.message(
      'Liên hệ với chúng tôi',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Đăng xuất`
  String get log_out {
    return Intl.message(
      'Đăng xuất',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Tin nhắn`
  String get message {
    return Intl.message(
      'Tin nhắn',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Tìm kiếm`
  String get search {
    return Intl.message(
      'Tìm kiếm',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Buổi sáng`
  String get morning {
    return Intl.message(
      'Buổi sáng',
      name: 'morning',
      desc: '',
      args: [],
    );
  }

  /// `Buổi trưa`
  String get day {
    return Intl.message(
      'Buổi trưa',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Buổi chiều`
  String get evening {
    return Intl.message(
      'Buổi chiều',
      name: 'evening',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu`
  String get password {
    return Intl.message(
      'Mật khẩu',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận mật khẩu`
  String get confirm_password {
    return Intl.message(
      'Xác nhận mật khẩu',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập`
  String get sign_in {
    return Intl.message(
      'Đăng nhập',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Quên mật khẩu`
  String get forgot_password {
    return Intl.message(
      'Quên mật khẩu',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Hoặc đăng nhập bằng`
  String get or_connect_with {
    return Intl.message(
      'Hoặc đăng nhập bằng',
      name: 'or_connect_with',
      desc: '',
      args: [],
    );
  }

  /// `Facebook`
  String get facebook {
    return Intl.message(
      'Facebook',
      name: 'facebook',
      desc: '',
      args: [],
    );
  }

  /// `Google`
  String get google {
    return Intl.message(
      'Google',
      name: 'google',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập`
  String get login {
    return Intl.message(
      'Đăng nhập',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký`
  String get sign_up {
    return Intl.message(
      'Đăng ký',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin tài khoản`
  String get account_info {
    return Intl.message(
      'Thông tin tài khoản',
      name: 'account_info',
      desc: '',
      args: [],
    );
  }

  /// `Hoàn thành`
  String get done {
    return Intl.message(
      'Hoàn thành',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Chỉnh sửa`
  String get edit {
    return Intl.message(
      'Chỉnh sửa',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Tên tài khoản`
  String get account_name {
    return Intl.message(
      'Tên tài khoản',
      name: 'account_name',
      desc: '',
      args: [],
    );
  }

  /// `Lưu`
  String get save {
    return Intl.message(
      'Lưu',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Ngày sinh`
  String get birthday {
    return Intl.message(
      'Ngày sinh',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `Lịch hẹn của tôi`
  String get my_appointment {
    return Intl.message(
      'Lịch hẹn của tôi',
      name: 'my_appointment',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập ngày sinh`
  String get please_input_date {
    return Intl.message(
      'Vui lòng nhập ngày sinh',
      name: 'please_input_date',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin gia đình`
  String get member_info {
    return Intl.message(
      'Thông tin gia đình',
      name: 'member_info',
      desc: '',
      args: [],
    );
  }

  /// `Mối quan hệ`
  String get relationship {
    return Intl.message(
      'Mối quan hệ',
      name: 'relationship',
      desc: '',
      args: [],
    );
  }

  /// `Sửa thông tin gia đình`
  String get edit_member {
    return Intl.message(
      'Sửa thông tin gia đình',
      name: 'edit_member',
      desc: '',
      args: [],
    );
  }

  /// `Thêm`
  String get add {
    return Intl.message(
      'Thêm',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Thêm thành viên`
  String get add_member {
    return Intl.message(
      'Thêm thành viên',
      name: 'add_member',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa có tài khoản?`
  String get not_account {
    return Intl.message(
      'Bạn chưa có tài khoản?',
      name: 'not_account',
      desc: '',
      args: [],
    );
  }

  /// `Cuộc hẹn `
  String get appointment {
    return Intl.message(
      'Cuộc hẹn ',
      name: 'appointment',
      desc: '',
      args: [],
    );
  }

  /// `Gửi`
  String get send {
    return Intl.message(
      'Gửi',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Chi tiết cuộc hẹn`
  String get detail_appointment {
    return Intl.message(
      'Chi tiết cuộc hẹn',
      name: 'detail_appointment',
      desc: '',
      args: [],
    );
  }

  /// `Khôi phục lại lịch`
  String get reset {
    return Intl.message(
      'Khôi phục lại lịch',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Bắt đầu`
  String get start {
    return Intl.message(
      'Bắt đầu',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Kết thúc`
  String get end {
    return Intl.message(
      'Kết thúc',
      name: 'end',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng chọn mục khám`
  String get please_choose_case {
    return Intl.message(
      'Vui lòng chọn mục khám',
      name: 'please_choose_case',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng chọn thời gian`
  String get please_choose_time {
    return Intl.message(
      'Vui lòng chọn thời gian',
      name: 'please_choose_time',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng chọn bác sĩ`
  String get please_choose_doctor {
    return Intl.message(
      'Vui lòng chọn bác sĩ',
      name: 'please_choose_doctor',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập giới tính`
  String get please_enter_gender {
    return Intl.message(
      'Vui lòng nhập giới tính',
      name: 'please_enter_gender',
      desc: '',
      args: [],
    );
  }

  /// `Summary`
  String get summary {
    return Intl.message(
      'Summary',
      name: 'summary',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin bác sĩ`
  String get doctor_infomation {
    return Intl.message(
      'Thông tin bác sĩ',
      name: 'doctor_infomation',
      desc: '',
      args: [],
    );
  }

  /// `Phòng khám`
  String get clinics {
    return Intl.message(
      'Phòng khám',
      name: 'clinics',
      desc: '',
      args: [],
    );
  }

  /// `Ngày giờ`
  String get date_day {
    return Intl.message(
      'Ngày giờ',
      name: 'date_day',
      desc: '',
      args: [],
    );
  }

  /// `Bệnh nhân`
  String get patient {
    return Intl.message(
      'Bệnh nhân',
      name: 'patient',
      desc: '',
      args: [],
    );
  }

  /// `Đặt lịch hẹn`
  String get book_appointment {
    return Intl.message(
      'Đặt lịch hẹn',
      name: 'book_appointment',
      desc: '',
      args: [],
    );
  }

  /// `Thông báo`
  String get notification {
    return Intl.message(
      'Thông báo',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `ID Cuộc hẹn: `
  String get appointment_id {
    return Intl.message(
      'ID Cuộc hẹn: ',
      name: 'appointment_id',
      desc: '',
      args: [],
    );
  }

  /// `Điều trị: `
  String get treatment {
    return Intl.message(
      'Điều trị: ',
      name: 'treatment',
      desc: '',
      args: [],
    );
  }

  /// `Trạng thái`
  String get status {
    return Intl.message(
      'Trạng thái',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Chấp thuận`
  String get approve {
    return Intl.message(
      'Chấp thuận',
      name: 'approve',
      desc: '',
      args: [],
    );
  }

  /// `Giá tiền điều trị`
  String get treatment_cost {
    return Intl.message(
      'Giá tiền điều trị',
      name: 'treatment_cost',
      desc: '',
      args: [],
    );
  }

  /// `Cuộc hẹn tiếp theo`
  String get next_appointment {
    return Intl.message(
      'Cuộc hẹn tiếp theo',
      name: 'next_appointment',
      desc: '',
      args: [],
    );
  }

  /// `Lịch sử cuộc hẹn`
  String get history {
    return Intl.message(
      'Lịch sử cuộc hẹn',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Xem chi tiết`
  String get extract_view {
    return Intl.message(
      'Xem chi tiết',
      name: 'extract_view',
      desc: '',
      args: [],
    );
  }

  /// `Chi tiết lịch sử`
  String get detail_history_appointment {
    return Intl.message(
      'Chi tiết lịch sử',
      name: 'detail_history_appointment',
      desc: '',
      args: [],
    );
  }

  /// `Đánh giá dịch vụ?`
  String get rate_service {
    return Intl.message(
      'Đánh giá dịch vụ?',
      name: 'rate_service',
      desc: '',
      args: [],
    );
  }

  /// `Lịch trình trị liệu`
  String get treatment_timeline {
    return Intl.message(
      'Lịch trình trị liệu',
      name: 'treatment_timeline',
      desc: '',
      args: [],
    );
  }

  /// `Nhắc nhở từ bác sĩ`
  String get note_from_doctor {
    return Intl.message(
      'Nhắc nhở từ bác sĩ',
      name: 'note_from_doctor',
      desc: '',
      args: [],
    );
  }

  /// `Đơn thuốc`
  String get medicines_totake {
    return Intl.message(
      'Đơn thuốc',
      name: 'medicines_totake',
      desc: '',
      args: [],
    );
  }

  /// `Xem tất cả`
  String get see_all {
    return Intl.message(
      'Xem tất cả',
      name: 'see_all',
      desc: '',
      args: [],
    );
  }

  /// `Thu gọn`
  String get see_less {
    return Intl.message(
      'Thu gọn',
      name: 'see_less',
      desc: '',
      args: [],
    );
  }

  /// `Cá nhân`
  String get profile {
    return Intl.message(
      'Cá nhân',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Đơn thuốc`
  String get prescription {
    return Intl.message(
      'Đơn thuốc',
      name: 'prescription',
      desc: '',
      args: [],
    );
  }

  /// `Cài đặt`
  String get setting {
    return Intl.message(
      'Cài đặt',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Tìm kiếm phòng khám`
  String get search_clinic {
    return Intl.message(
      'Tìm kiếm phòng khám',
      name: 'search_clinic',
      desc: '',
      args: [],
    );
  }

  /// `Không có dữ liệu`
  String get no_data {
    return Intl.message(
      'Không có dữ liệu',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Chọn cơ sở`
  String get select_clinic {
    return Intl.message(
      'Chọn cơ sở',
      name: 'select_clinic',
      desc: '',
      args: [],
    );
  }

  /// `Tên thuốc`
  String get prescription_name {
    return Intl.message(
      'Tên thuốc',
      name: 'prescription_name',
      desc: '',
      args: [],
    );
  }

  /// `Số lượng`
  String get quantity {
    return Intl.message(
      'Số lượng',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Bác sỹ`
  String get doctor_name {
    return Intl.message(
      'Bác sỹ',
      name: 'doctor_name',
      desc: '',
      args: [],
    );
  }

  /// `Ngày kê đơn`
  String get prescription_day {
    return Intl.message(
      'Ngày kê đơn',
      name: 'prescription_day',
      desc: '',
      args: [],
    );
  }

  /// `Không thể gửi yêu cầu đến máy chủ`
  String get request_send_timeout {
    return Intl.message(
      'Không thể gửi yêu cầu đến máy chủ',
      name: 'request_send_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Yêu cầu gửi đến máy chủ bị huỷ`
  String get request_cancelled {
    return Intl.message(
      'Yêu cầu gửi đến máy chủ bị huỷ',
      name: 'request_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Không thể kết nối đến máy chủ`
  String get request_connect_timeout {
    return Intl.message(
      'Không thể kết nối đến máy chủ',
      name: 'request_connect_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Kết nối đến máy chủ không thành công do kết nối internet`
  String get request_fail_due_internet {
    return Intl.message(
      'Kết nối đến máy chủ không thành công do kết nối internet',
      name: 'request_fail_due_internet',
      desc: '',
      args: [],
    );
  }

  /// `Máy chủ không phản hồi yêu cầu`
  String get request_receive_timeout {
    return Intl.message(
      'Máy chủ không phản hồi yêu cầu',
      name: 'request_receive_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Lỗi kết nối mã: {errorCode}`
  String request_error_code(Object errorCode) {
    return Intl.message(
      'Lỗi kết nối mã: $errorCode',
      name: 'request_error_code',
      desc: '',
      args: [errorCode],
    );
  }

  /// `Có lỗi xảy ra.`
  String get error {
    return Intl.message(
      'Có lỗi xảy ra.',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Thông báo`
  String get notice {
    return Intl.message(
      'Thông báo',
      name: 'notice',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn đăng xuất?`
  String get confirm_logout {
    return Intl.message(
      'Bạn có muốn đăng xuất?',
      name: 'confirm_logout',
      desc: '',
      args: [],
    );
  }

  /// `Có`
  String get yes {
    return Intl.message(
      'Có',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập thành công`
  String get login_success {
    return Intl.message(
      'Đăng nhập thành công',
      name: 'login_success',
      desc: '',
      args: [],
    );
  }

  /// `Đặt lại mật khẩu`
  String get reset_password {
    return Intl.message(
      'Đặt lại mật khẩu',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng điền email để lấy lại mật khẩu`
  String get input_email_to_reset {
    return Intl.message(
      'Vui lòng điền email để lấy lại mật khẩu',
      name: 'input_email_to_reset',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập thất bại`
  String get login_error {
    return Intl.message(
      'Đăng nhập thất bại',
      name: 'login_error',
      desc: '',
      args: [],
    );
  }

  /// `Apple`
  String get apple {
    return Intl.message(
      'Apple',
      name: 'apple',
      desc: '',
      args: [],
    );
  }

  /// `Bạn cần đăng nhập để sử dụng`
  String get login_toUse {
    return Intl.message(
      'Bạn cần đăng nhập để sử dụng',
      name: 'login_toUse',
      desc: '',
      args: [],
    );
  }

  /// `Sao chép`
  String get copy {
    return Intl.message(
      'Sao chép',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `Trả lời`
  String get rep {
    return Intl.message(
      'Trả lời',
      name: 'rep',
      desc: '',
      args: [],
    );
  }

  /// `Gỡ bỏ`
  String get delete {
    return Intl.message(
      'Gỡ bỏ',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Thư viện`
  String get lib {
    return Intl.message(
      'Thư viện',
      name: 'lib',
      desc: '',
      args: [],
    );
  }

  /// `Quay lại`
  String get back {
    return Intl.message(
      'Quay lại',
      name: 'back',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}