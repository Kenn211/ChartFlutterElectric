import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_chart/controllers/drawer/marginal_price_controller.dart';
import 'package:intl/intl.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({super.key, this.restorationId, this.day});

  final String? restorationId, day;

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> with RestorationMixin {
  var controller = Get.put(MarginalPriceController());
  var formatter = DateFormat('yyyy-MM-dd');

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2023),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        controller.dateSelected = formatter.format(_selectedDate.value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _restorableDatePickerRouteFuture.present();
        },
        child: Container(
          width: 165,
          height: 60,
          padding: const EdgeInsets.all(5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border:
                  Border.all(width: 1, color: Colors.black.withOpacity(0.5))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.calendar,
                color: Colors.black.withOpacity(0.6),
              ),
              const SizedBox(width: 10),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    child: Text(
                  '${widget.day} ngày',
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                  overflow: TextOverflow.visible,
                )),
                const SizedBox(height: 5),
                Container(
                  child: Text(
                      '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}',
                      style: TextStyle(color: Colors.black.withOpacity(0.6))),
                )
              ])
            ],
          ),
        ));
  }
}


// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class SelectDate extends StatefulWidget {
//   SelectDate({required Key key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   SelectDateState createState() => _SelectDateState();
// }

// class _SelectDateState extends State<SelectDate> {
//   int _counter = 0;
//   var formatter = DateFormat('yyyy-MM-dd');
//   DateTime fromDate =
//       DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
//   DateTime toDate =
//       DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   Future<DateTime> selectDate(BuildContext context, DateTime _date) async {
//     DateTime picked = await showDatePicker(
//       context: context,
//       initialDate: _date,
//       firstDate: DateTime(2018),
//       lastDate: DateTime(2030),
//     );

//     if (picked != null) {
//       _date = picked;
//     }
//     return _date;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Text(
//                   'From:',
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.calendar_today),
//                   onPressed: () async {
//                     fromDate = await selectDate(context, fromDate);
//                     setState(() {});
//                   },
//                 ),
//                 Text('${formatter.format(fromDate)}'),
//               ],
//             ),
//             Row(
//               children: <Widget>[
//                 Text(
//                   'To:',
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.calendar_today),
//                   onPressed: () async {
//                     toDate = await selectDate(context, toDate);
//                     setState(() {});
//                   },
//                 ),
//                 Text('${formatter.format(toDate)}'),
//               ],
//             ),
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.display1,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
