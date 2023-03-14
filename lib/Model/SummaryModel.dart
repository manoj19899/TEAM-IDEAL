class SummaryModel {
  String? id;
  String? compNm;
  String? grade;
  String? category;
  String? empNm;
  String? empCode;
  String? plopenbal;
  String? avlbpl;
  String? plavailed;
  String? pllapsed;
  String? plbal;
  String? plcfw;
  String? clopenbal;
  String? avlbcl;
  String? clavailed;
  String? cllapsed;
  String? clbal;
  String? clcfw;
  String? slopenbal;
  String? avlbsl;
  String? slavailed;
  String? sllapsed;
  String? slbal;
  String? slcfw;
  String? allocleave;
  String? avlbleave;

  SummaryModel(
      {this.id,
        this.compNm,
        this.grade,
        this.category,
        this.empNm,
        this.empCode,
        this.plopenbal,
        this.avlbpl,
        this.plavailed,
        this.pllapsed,
        this.plbal,
        this.plcfw,
        this.clopenbal,
        this.avlbcl,
        this.clavailed,
        this.cllapsed,
        this.clbal,
        this.clcfw,
        this.slopenbal,
        this.avlbsl,
        this.slavailed,
        this.sllapsed,
        this.slbal,
        this.slcfw,
        this.allocleave,
        this.avlbleave});

  SummaryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    compNm = json['comp_nm'];
    grade = json['grade'];
    category = json['category'];
    empNm = json['emp_nm'];
    empCode = json['emp_code'];
    plopenbal = json['plopenbal'];
    avlbpl = json['avlbpl'];
    plavailed = json['plavailed'];
    pllapsed = json['pllapsed'];
    plbal = json['plbal'];
    plcfw = json['plcfw'];
    clopenbal = json['clopenbal'];
    avlbcl = json['avlbcl'];
    clavailed = json['clavailed'];
    cllapsed = json['cllapsed'];
    clbal = json['clbal'];
    clcfw = json['clcfw'];
    slopenbal = json['slopenbal'];
    avlbsl = json['avlbsl'];
    slavailed = json['slavailed'];
    sllapsed = json['sllapsed'];
    slbal = json['slbal'];
    slcfw = json['slcfw'];
    allocleave = json['allocleave'];
    avlbleave = json['avlbleave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comp_nm'] = this.compNm;
    data['grade'] = this.grade;
    data['category'] = this.category;
    data['emp_nm'] = this.empNm;
    data['emp_code'] = this.empCode;
    data['plopenbal'] = this.plopenbal;
    data['avlbpl'] = this.avlbpl;
    data['plavailed'] = this.plavailed;
    data['pllapsed'] = this.pllapsed;
    data['plbal'] = this.plbal;
    data['plcfw'] = this.plcfw;
    data['clopenbal'] = this.clopenbal;
    data['avlbcl'] = this.avlbcl;
    data['clavailed'] = this.clavailed;
    data['cllapsed'] = this.cllapsed;
    data['clbal'] = this.clbal;
    data['clcfw'] = this.clcfw;
    data['slopenbal'] = this.slopenbal;
    data['avlbsl'] = this.avlbsl;
    data['slavailed'] = this.slavailed;
    data['sllapsed'] = this.sllapsed;
    data['slbal'] = this.slbal;
    data['slcfw'] = this.slcfw;
    data['allocleave'] = this.allocleave;
    data['avlbleave'] = this.avlbleave;
    return data;
  }
}