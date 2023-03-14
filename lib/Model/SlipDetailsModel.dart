class SlipDetails {
  EmpsalReg? empsalReg;
  EmpsalRegTotal? empsalRegTotal;
  Employee? employee;

  SlipDetails({this.empsalReg, this.empsalRegTotal, this.employee});

  SlipDetails.fromJson(Map<String, dynamic> json) {
    empsalReg = json['empsal_reg'] != null
        ? new EmpsalReg.fromJson(json['empsal_reg'])
        : null;
    empsalRegTotal = json['empsal_reg_total'] != null
        ? new EmpsalRegTotal.fromJson(json['empsal_reg_total'])
        : null;
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.empsalReg != null) {
      data['empsal_reg'] = this.empsalReg!.toJson();
    }
    if (this.empsalRegTotal != null) {
      data['empsal_reg_total'] = this.empsalRegTotal!.toJson();
    }
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    return data;
  }
}

class EmpsalReg {
  var id;
  var uniqueGenNo;
  var empNm;
  var empCode;
  var joindt;
  var designation;
  var location;
  var daysPresent;
  var basic;
  var hra;
  var conveyance;
  var medical;
  var educationAllow;
  var lta;
  var otherAllow;
  var arrears;
  var incent;
  var miscallow;
  var mobileAllow;
  var monthlybonus;
  var commallow;
  var foodallow;
  var othrs;
  var otrate;
  var otamount;
  var specialAllow;
  var revgross;
  var pf12;
  var esic175;
  var ptax;
  var retnamt;
  var otherDeduct;
  var mlwf1;
  var totalDeduct;
  var netPay;
  var pf1315;
  var esic475;
  var insurance;
  var statbonus;
  var leaveload;
  var gratuity;
  var pbonus;
  var ctc;
  var mlwf2;
  var remarks;
  var netpayinwords;

  EmpsalReg({
    this.id,
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
    this.netpayinwords,
  });

  EmpsalReg.fromJson(Map<String, dynamic> json) {
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
    revgross = json['revgross'] != null ? json['revgross'].toString() : '';
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
    netpayinwords = json['net_pay_in_words'];
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
    data['net_pay_in_words'] = this.netpayinwords;
    return data;
  }
}

class EmpsalRegTotal {
  var id;
  var sheetNo;
  var uniqueGenNo;
  var principalComp;
  var compNm;
  var grade;
  var month;
  var year;
  var totalamt;
  var totalemp;
  var payStatus;
  var publishstatus;

  EmpsalRegTotal(
      {this.id,
      this.sheetNo,
      this.uniqueGenNo,
      this.principalComp,
      this.compNm,
      this.grade,
      this.month,
      this.year,
      this.totalamt,
      this.totalemp,
      this.payStatus,
      this.publishstatus});

  EmpsalRegTotal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sheetNo = json['sheet_no'];
    uniqueGenNo = json['unique_gen_no'];
    principalComp = json['principal_comp'];
    compNm = json['comp_nm'];
    grade = json['grade'];
    month = json['month'];
    year = json['year'];
    totalamt = json['totalamt'];
    totalemp = json['totalemp'];
    payStatus = json['pay_status'];
    publishstatus = json['publishstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sheet_no'] = this.sheetNo;
    data['unique_gen_no'] = this.uniqueGenNo;
    data['principal_comp'] = this.principalComp;
    data['comp_nm'] = this.compNm;
    data['grade'] = this.grade;
    data['month'] = this.month;
    data['year'] = this.year;
    data['totalamt'] = this.totalamt;
    data['totalemp'] = this.totalemp;
    data['pay_status'] = this.payStatus;
    data['publishstatus'] = this.publishstatus;
    return data;
  }
}

class Employee {
  var id;
  var empNm;
  var officialemail;
  var email;
  var altemail;
  var mobileno;
  var altmobileno;
  var address;
  var empCode;
  var password;
  var category;
  var grade;
  var esicNo;
  var education;
  var dob;
  var age;
  var cenddt;
  var state;
  var designation;
  var joindt;
  var resigndt;
  var leavedt;
  var location;
  var zone;
  var banknm;
  var accno;
  var bankcity;
  var branch;
  var micr;
  var cctype;
  var ifsc;
  var division;
  var supervisor;
  var seniorSupervisor;
  var workingFor;
  var pfno;
  var panNo;
  var gender;
  var principalComp;
  var otp;
  var accountStatus;
  var dayInMonth;
  var companyLogo;
  var companyName;
  var companyAddress;

  Employee(
      {this.id,
      this.empNm,
      this.officialemail,
      this.email,
      this.altemail,
      this.mobileno,
      this.altmobileno,
      this.address,
      this.empCode,
      this.password,
      this.category,
      this.grade,
      this.esicNo,
      this.education,
      this.dob,
      this.age,
      this.cenddt,
      this.state,
      this.designation,
      this.joindt,
      this.resigndt,
      this.leavedt,
      this.location,
      this.zone,
      this.banknm,
      this.accno,
      this.bankcity,
      this.branch,
      this.micr,
      this.cctype,
      this.ifsc,
      this.division,
      this.supervisor,
      this.seniorSupervisor,
      this.workingFor,
      this.pfno,
      this.panNo,
      this.gender,
      this.principalComp,
      this.otp,
      this.accountStatus,
      this.dayInMonth,
      this.companyLogo,
      this.companyName,
      this.companyAddress});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    empNm = json['emp_nm'];
    officialemail = json['officialemail'];
    email = json['email'];
    altemail = json['altemail'];
    mobileno = json['mobileno'];
    altmobileno = json['altmobileno'];
    address = json['address'];
    empCode = json['emp_code'];
    password = json['password'];
    category = json['category'];
    grade = json['grade'];
    esicNo = json['esic_no'];
    education = json['education'];
    dob = json['dob'];
    age = json['age'];
    cenddt = json['cenddt'];
    state = json['state'];
    designation = json['designation'];
    joindt = json['joindt'];
    resigndt = json['resigndt'];
    leavedt = json['leavedt'];
    location = json['location'];
    zone = json['zone'];
    banknm = json['banknm'];
    accno = json['accno'];
    bankcity = json['bankcity'];
    branch = json['branch'];
    micr = json['micr'];
    cctype = json['cctype'];
    ifsc = json['ifsc'];
    division = json['division'];
    supervisor = json['supervisor'];
    seniorSupervisor = json['senior_supervisor'];
    workingFor = json['working_for'];
    pfno = json['pfno'];
    panNo = json['pan_no'];
    gender = json['gender'];
    principalComp = json['principal_comp'];
    otp = json['otp'];
    accountStatus = json['account_status'];
    dayInMonth = json['day_in_month'];
    companyLogo = json['company_logo'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emp_nm'] = this.empNm;
    data['officialemail'] = this.officialemail;
    data['email'] = this.email;
    data['altemail'] = this.altemail;
    data['mobileno'] = this.mobileno;
    data['altmobileno'] = this.altmobileno;
    data['address'] = this.address;
    data['emp_code'] = this.empCode;
    data['password'] = this.password;
    data['category'] = this.category;
    data['grade'] = this.grade;
    data['esic_no'] = this.esicNo;
    data['education'] = this.education;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['cenddt'] = this.cenddt;
    data['state'] = this.state;
    data['designation'] = this.designation;
    data['joindt'] = this.joindt;
    data['resigndt'] = this.resigndt;
    data['leavedt'] = this.leavedt;
    data['location'] = this.location;
    data['zone'] = this.zone;
    data['banknm'] = this.banknm;
    data['accno'] = this.accno;
    data['bankcity'] = this.bankcity;
    data['branch'] = this.branch;
    data['micr'] = this.micr;
    data['cctype'] = this.cctype;
    data['ifsc'] = this.ifsc;
    data['division'] = this.division;
    data['supervisor'] = this.supervisor;
    data['senior_supervisor'] = this.seniorSupervisor;
    data['working_for'] = this.workingFor;
    data['pfno'] = this.pfno;
    data['pan_no'] = this.panNo;
    data['gender'] = this.gender;
    data['principal_comp'] = this.principalComp;
    data['otp'] = this.otp;
    data['account_status'] = this.accountStatus;
    data['day_in_month'] = this.dayInMonth;
    data['company_logo'] = this.companyLogo;
    data['company_name'] = this.companyName;
    data['company_address'] = this.companyAddress;
    return data;
  }
}
