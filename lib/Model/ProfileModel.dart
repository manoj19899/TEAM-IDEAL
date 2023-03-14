class ProfileData {
  Employee? employee;
  List<EduDetail>? eduDetail;
  List<EmpDetail>? empDetail;
  List<RefEmergency>? refEmergengy;
  List<RefPersons>? refPersons;
  Documents? documents;

  ProfileData(
      {this.employee,
      this.eduDetail,
      this.empDetail,
      this.refEmergengy,
      this.refPersons,
      this.documents});

  ProfileData.fromJson(Map<String, dynamic> json) {
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
    if (json['edu_detail'] != null) {
      eduDetail = <EduDetail>[];
      json['edu_detail'].forEach((v) {
        eduDetail!.add(new EduDetail.fromJson(v));
      });
    }
    if (json['emp_detail'] != null) {
      empDetail = <EmpDetail>[];
      json['emp_detail'].forEach((v) {
        empDetail!.add(new EmpDetail.fromJson(v));
      });
    }
    if (json['ref_emergengy'] != null) {
      refEmergengy = <RefEmergency>[];
      json['ref_emergengy'].forEach((v) {
        refEmergengy!.add(new RefEmergency.fromJson(v));
      });
    }
    if (json['ref_persons'] != null) {
      refPersons = <RefPersons>[];
      json['ref_persons'].forEach((v) {
        refPersons!.add(new RefPersons.fromJson(v));
      });
    }
    documents = json['documents'] != null
        ? new Documents.fromJson(json['documents'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    if (this.eduDetail != null) {
      data['edu_detail'] = this.eduDetail!.map((v) => v.toJson()).toList();
    }
    if (this.empDetail != null) {
      data['emp_detail'] = this.empDetail!.map((v) => v.toJson()).toList();
    }
    if (this.refEmergengy != null) {
      data['ref_emergengy'] =
          this.refEmergengy!.map((v) => v.toJson()).toList();
    }
    if (this.refPersons != null) {
      data['ref_persons'] = this.refPersons!.map((v) => v.toJson()).toList();
    }
    if (this.documents != null) {
      data['documents'] = this.documents!.toJson();
    }
    return data;
  }
}

class Employee {
  String? id;
  String? firstNm;
  String? middleNm;
  String? lastNm;
  String? empNm;
  String? officialemail;
  String? email;
  String? altemail;
  String? mobileno;
  String? altmobileno;
  String? curaddress;
  String? address;
  String? empCode;
  String? password;
  String? grade;
  String? pfno;
  String? esicNo;
  String? education;
  String? dob;
  String? age;
  String? cenddt;
  String? state;
  String? designation;
  String? joindt;
  String? resigndt;
  String? leavedt;
  String? location;
  String? zone;
  String? banknm;
  String? accno;
  String? bankcity;
  String? branch;
  String? aadharno;
  String? remarks;
  String? ifsc;
  String? supervisor;
  String? seniorSupervisor;
  String? workingFor;
  String? panNo;
  String? gender;
  String? principalComp;
  String? otp;
  String? accountStatus;
  String? rephrName;
  String? rephrNo;
  String? repmngrName;
  String? repmngrNo;
  String? nomiName;
  String? nomiNo;
  String? nomiRel;
  String? nomineedt;
  String? nomiAdd;
  String? interviewed;
  String? interviewdet;
  String? treatment;
  String? treatmentdet;
  String? is_approved;
  String? emergency_contact_person;
  String? emergency_contact_no;

  Employee({
    this.id,
    this.firstNm,
    this.middleNm,
    this.lastNm,
    this.empNm,
    this.officialemail,
    this.email,
    this.altemail,
    this.mobileno,
    this.altmobileno,
    this.curaddress,
    this.address,
    this.empCode,
    this.password,
    this.grade,
    this.pfno,
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
    this.aadharno,
    this.remarks,
    this.ifsc,
    this.supervisor,
    this.seniorSupervisor,
    this.workingFor,
    this.panNo,
    this.gender,
    this.principalComp,
    this.otp,
    this.accountStatus,
    this.rephrName,
    this.rephrNo,
    this.repmngrName,
    this.repmngrNo,
    this.nomiName,
    this.nomiNo,
    this.nomiRel,
    this.nomineedt,
    this.nomiAdd,
    this.interviewed,
    this.interviewdet,
    this.treatment,
    this.treatmentdet,
    this.is_approved,
    this.emergency_contact_person,
    this.emergency_contact_no,
  });

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstNm = json['first_nm'];
    middleNm = json['middle_nm'];
    lastNm = json['last_nm'];
    empNm = json['emp_nm'];
    officialemail = json['officialemail'];
    email = json['email'];
    altemail = json['altemail'];
    mobileno = json['mobileno'];
    altmobileno = json['altmobileno'];
    curaddress = json['curaddress'];
    address = json['address'];
    empCode = json['emp_code'];
    password = json['password'];
    grade = json['grade'];
    pfno = json['pfno'];
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
    aadharno = json['aadharno'];
    remarks = json['remarks'];
    ifsc = json['ifsc'];
    supervisor = json['supervisor'];
    seniorSupervisor = json['senior_supervisor'];
    workingFor = json['working_for'];
    panNo = json['pan_no'];
    gender = json['gender'];
    principalComp = json['principal_comp'];
    otp = json['otp'];
    accountStatus = json['account_status'];
    rephrName = json['rephr_name'];
    rephrNo = json['rephr_no'];
    repmngrName = json['repmngr_name'];
    repmngrNo = json['repmngr_no'];
    nomiName = json['nomi_name'];
    nomiNo = json['nomi_no'];
    nomiRel = json['nomi_rel'];
    nomineedt = json['nomineedt'];
    nomiAdd = json['nomi_add'];
    interviewed = json['interviewed'];
    interviewdet = json['interviewdet'];
    treatment = json['treatment'];
    treatmentdet = json['treatmentdet'];
    is_approved = json['is_approved'];
    emergency_contact_person = json['emergency_contact_person'];
    emergency_contact_no = json['emergency_contact_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_nm'] = this.firstNm;
    data['middle_nm'] = this.middleNm;
    data['last_nm'] = this.lastNm;
    data['emp_nm'] = this.empNm;
    data['officialemail'] = this.officialemail;
    data['email'] = this.email;
    data['altemail'] = this.altemail;
    data['mobileno'] = this.mobileno;
    data['altmobileno'] = this.altmobileno;
    data['curaddress'] = this.curaddress;
    data['address'] = this.address;
    data['emp_code'] = this.empCode;
    data['password'] = this.password;
    data['grade'] = this.grade;
    data['pfno'] = this.pfno;
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
    data['aadharno'] = this.aadharno;
    data['remarks'] = this.remarks;
    data['ifsc'] = this.ifsc;
    data['supervisor'] = this.supervisor;
    data['senior_supervisor'] = this.seniorSupervisor;
    data['working_for'] = this.workingFor;
    data['pan_no'] = this.panNo;
    data['gender'] = this.gender;
    data['principal_comp'] = this.principalComp;
    data['otp'] = this.otp;
    data['account_status'] = this.accountStatus;
    data['rephr_name'] = this.rephrName;
    data['rephr_no'] = this.rephrNo;
    data['repmngr_name'] = this.repmngrName;
    data['repmngr_no'] = this.repmngrNo;
    data['nomi_name'] = this.nomiName;
    data['nomi_no'] = this.nomiNo;
    data['nomi_rel'] = this.nomiRel;
    data['nomineedt'] = this.nomineedt;
    data['nomi_add'] = this.nomiAdd;
    data['interviewed'] = this.interviewed;
    data['interviewdet'] = this.interviewdet;
    data['treatment'] = this.treatment;
    data['treatmentdet'] = this.treatmentdet;
    data['is_approved'] = this.is_approved;
    data['emergency_contact_person'] = this.emergency_contact_person;
    data['emergency_contact_no'] = this.emergency_contact_no;
    return data;
  }
}

class EduDetail {
  String? id;
  String? empCode;
  String? exampass;
  String? instnm;
  String? passyear;
  String? passperc;

  EduDetail(
      {this.id,
      this.empCode,
      this.exampass,
      this.instnm,
      this.passyear,
      this.passperc});

  EduDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    empCode = json['emp_code'];
    exampass = json['exampass'];
    instnm = json['instnm'];
    passyear = json['passyear'];
    passperc = json['passperc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emp_code'] = this.empCode;
    data['exampass'] = this.exampass;
    data['instnm'] = this.instnm;
    data['passyear'] = this.passyear;
    data['passperc'] = this.passperc;
    return data;
  }
}

class EmpDetail {
  String? id;
  String? empCode;
  String? prevorg;
  String? prevpos;
  String? prevsal;
  String? reasonleave;
  String? periodofemp;

  EmpDetail(
      {this.id,
      this.empCode,
      this.prevorg,
      this.prevpos,
      this.prevsal,
      this.reasonleave,
      this.periodofemp});

  EmpDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    empCode = json['emp_code'];
    prevorg = json['prevorg'];
    prevpos = json['prevpos'];
    prevsal = json['prevsal'];
    reasonleave = json['reasonleave'];
    periodofemp = json['periodofemp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emp_code'] = this.empCode;
    data['prevorg'] = this.prevorg;
    data['prevpos'] = this.prevpos;
    data['prevsal'] = this.prevsal;
    data['reasonleave'] = this.reasonleave;
    data['periodofemp'] = this.periodofemp;
    return data;
  }
}

class RefEmergency {
  String? id;
  String? empCode;
  String? emergname;
  String? emergrel;
  String? emergno;

  RefEmergency(
      {this.id, this.empCode, this.emergname, this.emergrel, this.emergno});

  RefEmergency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    empCode = json['emp_code'];
    emergname = json['emergname'];
    emergrel = json['emergrel'];
    emergno = json['emergno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emp_code'] = this.empCode;
    data['emergname'] = this.emergname;
    data['emergrel'] = this.emergrel;
    data['emergno'] = this.emergno;
    return data;
  }
}

class RefPersons {
  String? id;
  String? empCode;
  String? refname;
  String? addconemail;
  String? occupation;
  String? yrsofacq;

  RefPersons(
      {this.id,
      this.empCode,
      this.refname,
      this.addconemail,
      this.occupation,
      this.yrsofacq});

  RefPersons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    empCode = json['emp_code'];
    refname = json['refname'];
    addconemail = json['addconemail'];
    occupation = json['occupation'];
    yrsofacq = json['yrsofacq'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emp_code'] = this.empCode;
    data['refname'] = this.refname;
    data['addconemail'] = this.addconemail;
    data['occupation'] = this.occupation;
    data['yrsofacq'] = this.yrsofacq;
    return data;
  }
}

class Documents {
  String? id;
  String? empCode;
  String? esicupld;
  String? form2upld;
  String? form11upld;
  String? tiplinfo;
  String? tiplkit;
  String? panupld;
  String? aadharupld;
  String? cchqupld;
  String? reletterupld;
  String? pastcerupld;
  String? passportupld;
  String? addproofupld;

  Documents(
      {this.id,
      this.empCode,
      this.esicupld,
      this.form2upld,
      this.form11upld,
      this.tiplinfo,
      this.tiplkit,
      this.panupld,
      this.aadharupld,
      this.cchqupld,
      this.reletterupld,
      this.pastcerupld,
      this.passportupld,
      this.addproofupld});

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    empCode = json['emp_code'];
    esicupld = json['esicupld'];
    form2upld = json['form2upld'];
    form11upld = json['form11upld'];
    tiplinfo = json['tiplinfo'];
    tiplkit = json['tiplkit'];
    panupld = json['panupld'];
    aadharupld = json['aadharupld'];
    cchqupld = json['cchqupld'];
    reletterupld = json['reletterupld'];
    pastcerupld = json['pastcerupld'];
    passportupld = json['passportupld'];
    addproofupld = json['addproofupld'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emp_code'] = this.empCode;
    data['esicupld'] = this.esicupld;
    data['form2upld'] = this.form2upld;
    data['form11upld'] = this.form11upld;
    data['tiplinfo'] = this.tiplinfo;
    data['tiplkit'] = this.tiplkit;
    data['panupld'] = this.panupld;
    data['aadharupld'] = this.aadharupld;
    data['cchqupld'] = this.cchqupld;
    data['reletterupld'] = this.reletterupld;
    data['pastcerupld'] = this.pastcerupld;
    data['passportupld'] = this.passportupld;
    data['addproofupld'] = this.addproofupld;
    return data;
  }
}
