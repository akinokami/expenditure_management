class ExpenditureModel {
  String? docId;
  String? note;
  int? amount;
  PaymentModel? payment;
  CategoryModel? category;
  TypeModel? type;
  String? createdDate;
  String? updatedDate;

  ExpenditureModel({
    this.docId,
    this.note,
    this.amount,
    this.payment,
    this.category,
    this.type,
    this.createdDate,
    this.updatedDate,
  });

  ExpenditureModel.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    amount = json['amount'];
    payment =
        json['payment'] != null ? PaymentModel.fromJson(json['payment']) : null;
    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;
    type = json['type'] != null ? TypeModel.fromJson(json['type']) : null;
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['note'] = note;
    data['amount'] = amount;
    if (payment != null) {
      data['payment'] = payment!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (type != null) {
      data['type'] = type!.toJson();
    }
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    return data;
  }
}

class CategoryModel {
  String? name;
  int? id;
  String? nameVn;

  CategoryModel({this.name, this.id, this.nameVn});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    nameVn = json['name_vn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['name_vn'] = nameVn;
    return data;
  }
}

class PaymentModel {
  String? name;
  int? id;
  String? nameVn;

  PaymentModel({this.name, this.id, this.nameVn});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    nameVn = json['name_vn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['name_vn'] = nameVn;
    return data;
  }
}

class TypeModel {
  int? id;
  String? name;
  String? nameVn;

  TypeModel({this.id, this.name, this.nameVn});

  TypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameVn = json['name_vn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['name_vn'] = nameVn;
    return data;
  }
}
