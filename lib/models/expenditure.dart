import 'package:expenditure_management/models/expenditure_model.dart';
import 'package:intl/intl.dart';

class Expenditure {
  String? docId;
  String? month;
  ExpenditureModel? expm;

  Expenditure({this.docId, this.month, this.expm});

  Expenditure.fromJson(Map<String, dynamic> json) {
    docId = json['docId'];
    month = json['expm']['updated_date'] != null
        ? DateFormat('MMM-yyyy')
            .format(DateTime.parse(json['expm']['updated_date']))
            .toString()
        : '';
    expm =
        json['expm'] != null ? ExpenditureModel.fromJson(json['expm']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['docId'] = docId;
    if (expm != null) {
      data['expm'] = expm!.toJson();
    }
    return data;
  }
}