class LeaveModel {
  String? id;
  String? leavetype;
  String? fromdt;
  String? todt;
  String? noOfDays;
  String? pl;
  String? cl;
  String? sl;
  String? description;
  String? image;
  String? status;
  String? empCode;
  String? todaydate;

  LeaveModel(
      {this.id,
        this.leavetype,
        this.fromdt,
        this.todt,
        this.noOfDays,
        this.pl,
        this.cl,
        this.sl,
        this.description,
        this.image,
        this.status,
        this.empCode,
        this.todaydate});

  LeaveModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leavetype = json['leavetype'];
    fromdt = json['fromdt'];
    todt = json['todt'];
    noOfDays = json['no_of_days'];
    pl = json['pl'];
    cl = json['cl'];
    sl = json['sl'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    empCode = json['emp_code'];
    todaydate = json['todaydate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leavetype'] = this.leavetype; 
    data['fromdt'] = this.fromdt;
    data['todt'] = this.todt;
    data['no_of_days'] = this.noOfDays;
    data['pl'] = this.pl;
    data['cl'] = this.cl;
    data['sl'] = this.sl;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    data['emp_code'] = this.empCode;
    data['todaydate'] = this.todaydate;
    return data;
  }
}