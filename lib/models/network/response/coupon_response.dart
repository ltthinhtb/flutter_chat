class CouponData {
  String code;
  num amount;
  num amountCp;
  String type;
  num value;
  num minCartTotal;
  num maxDiscountValue;
  String description;

  CouponData(
      {this.code,
        this.amount,
        this.amountCp,
        this.type,
        this.value,
        this.minCartTotal,
        this.maxDiscountValue,
        this.description});

  CouponData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    amountCp = json['amount_cp'];
    type = json['type'];
    value = json['value'];
    minCartTotal = json['min_cart_total'];
    maxDiscountValue = json['max_discount_value'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['amount_cp'] = this.amountCp;
    data['type'] = this.type;
    data['value'] = this.value;
    data['min_cart_total'] = this.minCartTotal;
    data['max_discount_value'] = this.maxDiscountValue;
    data['description'] = this.description;
    return data;
  }
}