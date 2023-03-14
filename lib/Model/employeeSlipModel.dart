class EmployeeSlip {
  String? id;
  String? uniqueGenNo;
  String? empNm;
  String? empCode;
  String? joindt;
  String? designation;
  String? location;
  String? daysPresent;
  String? basic;
  String? hra;
  String? conveyance;
  String? medical;
  String? educationAllow;
  String? lta;
  String? otherAllow;
  String? arrears;
  String? incent;
  String? miscallow;
  String? mobileAllow;
  String? monthlybonus;
  String? commallow;
  String? foodallow;
  String? othrs;
  String? otrate;
  String? otamount;
  String? specialAllow;
  String? revgross;
  String? pf12;
  String? esic175;
  String? ptax;
  String? retnamt;
  String? otherDeduct;
  String? mlwf1;
  String? totalDeduct;
  String? netPay;
  String? pf1315;
  String? esic475;
  String? insurance;
  String? statbonus;
  String? leaveload;
  String? gratuity;
  String? pbonus;
  String? ctc;
  String? mlwf2;
  String? remarks;
  String? payMonth;
  String? payYear;

  EmployeeSlip(
      {this.id,
        this.uniqueGenNo,
        this.empNm,
        this.empCode,
        this.joindt,
        this.designation,
        this.location,
        this.daysPresent,
        this.basic,
        this.hra,
        this.conveyance,
        this.medical,
        this.educationAllow,
        this.lta,
        this.otherAllow,
        this.arrears,
        this.incent,
        this.miscallow,
        this.mobileAllow,
        this.monthlybonus,
        this.commallow,
        this.foodallow,
        this.othrs,
        this.otrate,
        this.otamount,
        this.specialAllow,
        this.revgross,
        this.pf12,
        this.esic175,
        this.ptax,
        this.retnamt,
        this.otherDeduct,
        this.mlwf1,
        this.totalDeduct,
        this.netPay,
        this.pf1315,
        this.esic475,
        this.insurance,
        this.statbonus,
        this.leaveload,
        this.gratuity,
        this.pbonus,
        this.ctc,
        this.mlwf2,
        this.remarks,
        this.payMonth,
        this.payYear});

  EmployeeSlip.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    uniqueGenNo = json['unique_gen_no'];
    empNm = json['emp_nm'];
    empCode = json['emp_code'];
    joindt = json['joindt'];
    designation = json['designation'];
    location = json['location'];
    daysPresent = json['days_present'];
    basic = json['basic'];
    hra = json['hra'];
    conveyance = json['conveyance'];
    medical = json['medical'];
    educationAllow = json['education_allow'];
    lta = json['lta'];
    otherAllow = json['other_allow'];
    arrears = json['arrears'];
    incent = json['incent'];
    miscallow = json['miscallow'];
    mobileAllow = json['mobile_allow'];
    monthlybonus = json['monthlybonus'];
    commallow = json['commallow'];
    foodallow = json['foodallow'];
    othrs = json['othrs'];
    otrate = json['otrate'];
    otamount = json['otamount'];
    specialAllow = json['special_allow'];
    revgross = json['revgross'];
    pf12 = json['pf12'];
    esic175 = json['esic175'];
    ptax = json['ptax'];
    retnamt = json['retnamt'];
    otherDeduct = json['other_deduct'];
    mlwf1 = json['mlwf1'];
    totalDeduct = json['total_deduct'];
    netPay = json['net_pay'];
    pf1315 = json['pf1315'];
    esic475 = json['esic_475'];
    insurance = json['insurance'];
    statbonus = json['statbonus'];
    leaveload = json['leaveload'];
    gratuity = json['gratuity'];
    pbonus = json['pbonus'];
    ctc = json['ctc'];
    mlwf2 = json['mlwf2'];
    remarks = json['remarks'];
    payMonth = json['pay_month'];
    payYear = json['pay_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unique_gen_no'] = this.uniqueGenNo;
    data['emp_nm'] = this.empNm;
    data['emp_code'] = this.empCode;
    data['joindt'] = this.joindt;
    data['designation'] = this.designation;
    data['location'] = this.location;
    data['days_present'] = this.daysPresent;
    data['basic'] = this.basic;
    data['hra'] = this.hra;
    data['conveyance'] = this.conveyance;
    data['medical'] = this.medical;
    data['education_allow'] = this.educationAllow;
    data['lta'] = this.lta;
    data['other_allow'] = this.otherAllow;
    data['arrears'] = this.arrears;
    data['incent'] = this.incent;
    data['miscallow'] = this.miscallow;
    data['mobile_allow'] = this.mobileAllow;
    data['monthlybonus'] = this.monthlybonus;
    data['commallow'] = this.commallow;
    data['foodallow'] = this.foodallow;
    data['othrs'] = this.othrs;
    data['otrate'] = this.otrate;
    data['otamount'] = this.otamount;
    data['special_allow'] = this.specialAllow;
    data['revgross'] = this.revgross;
    data['pf12'] = this.pf12;
    data['esic175'] = this.esic175;
    data['ptax'] = this.ptax;
    data['retnamt'] = this.retnamt;
    data['other_deduct'] = this.otherDeduct;
    data['mlwf1'] = this.mlwf1;
    data['total_deduct'] = this.totalDeduct;
    data['net_pay'] = this.netPay;
    data['pf1315'] = this.pf1315;
    data['esic_475'] = this.esic475;
    data['insurance'] = this.insurance;
    data['statbonus'] = this.statbonus;
    data['leaveload'] = this.leaveload;
    data['gratuity'] = this.gratuity;
    data['pbonus'] = this.pbonus;
    data['ctc'] = this.ctc;
    data['mlwf2'] = this.mlwf2;
    data['remarks'] = this.remarks;
    data['pay_month'] = this.payMonth;
    data['pay_year'] = this.payYear;
    return data;
  }
}