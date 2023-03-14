class WorkingForModel {
  String? id;
  String? compNm;
  String? status;

  WorkingForModel({this.id, this.compNm, this.status});

  WorkingForModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    compNm = json['comp_nm'].toString();
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comp_nm'] = this.compNm;
    data['status'] = this.status;
    return data;
  }
}