import 'package:expenditure_management/custom_widgets/custom_text.dart';
import 'package:expenditure_management/models/expenditure_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controller/home_controller.dart';

class ExpenditureCalendar extends StatefulWidget {
  final String userId;

  ExpenditureCalendar({required this.userId});

  @override
  _ExpenditureCalendarState createState() => _ExpenditureCalendarState();
}

class _ExpenditureCalendarState extends State<ExpenditureCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<ExpenditureModel>> _expenditures = {};

  @override
  void initState() {
    super.initState();
    _loadExpenditures();
  }

  void _loadExpenditures() async {
    // Simulating fetching data from Firestore
    List<ExpenditureModel> data = await fetchExpenditures(widget.userId);
    Map<DateTime, List<ExpenditureModel>> groupedExpenditures = _groupByDate(data);
    setState(() {
      _expenditures = groupedExpenditures;
    });
    print("zzzzzzzz ${data.length}");
  }

  Map<DateTime, List<ExpenditureModel>> _groupByDate(List<ExpenditureModel> expenditures) {
    Map<DateTime, List<ExpenditureModel>> grouped = {};

    for (var exp in expenditures) {
      DateTime date = DateTime.parse(exp.updatedDate??"");
      DateTime formattedDate = DateTime.utc(date.year, date.month, date.day); // Only keep year, month, day
print("FormateeDate $formattedDate ");
      if (!grouped.containsKey(formattedDate)) {
        grouped[formattedDate] = [];
      }
      grouped[formattedDate]!.add(exp);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenditures Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
                print("Select Day $_selectedDay");
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) {
              return _expenditures[day] ?? [];
            },
          ),
          const SizedBox(height: 8.0),
          _buildExpenditureList(),
        ],
      ),
    );
  }

  Widget _buildExpenditureList() {
    List<ExpenditureModel> selectedExpenditures = _expenditures[_selectedDay] ?? [];

    if((selectedExpenditures.isNotEmpty)){
      print("${selectedExpenditures[0].updatedDate} xxxxxxxx");
      return Expanded(
        child: ListView.builder(
          itemCount: selectedExpenditures.length,
          itemBuilder: (context, index) {
            var exp = selectedExpenditures[index];
            print("${exp.updatedDate} xxxxxxxx");
            return ListTile(
              title: Text(exp.payment?.name??""),
              subtitle: Text(exp.category?.name??""),
              trailing: Text('\$${exp.type?.name??""}'),
            );
          },
        ),
      );
    }
    else{
      return CustomText(text: "NoData");
    }


  }
}

Future<List<ExpenditureModel>> fetchExpenditures(String userId) async {
  // Simulate fetching data from Firestore
  await Future.delayed(Duration(seconds: 1)); // Simulate delay
return Get.find<HomeController>().expList;
  // Example data
  // return [
  //   {
  //     'description': 'Groceries',
  //     'category': 'Food',
  //     'amount': 50.0,
  //     'date': DateTime.now(),
  //   },
  //   {
  //     'description': 'Bus Ticket',
  //     'category': 'Transport',
  //     'amount': 2.5,
  //     'date': DateTime.now(),
  //   },
  //   {
  //     'description': 'Coffee',
  //     'category': 'Food',
  //     'amount': 5.0,
  //     'date': DateTime.now(),
  //   },
  // ];
}
