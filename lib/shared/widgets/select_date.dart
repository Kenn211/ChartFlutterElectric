import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_chart/controllers/drawer/marginal_price_controller.dart';
import 'package:intl/intl.dart';
import 'package:test_chart/controllers/drawer/source_plan_controller.dart';
import 'package:test_chart/controllers/drawer/tonnage_controller.dart';
import 'package:test_chart/core.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({super.key, this.restorationId, this.isStack = false});

  final String? restorationId;
  final bool? isStack;

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> with RestorationMixin {
  // final controllerMarginal = Get.put(MarginalPriceController());
  // final controllerTonnage = Get.put(TonnageController());
  // final controllerPlan = Get.put(SourcePlanController());
  // var formatter = DateFormat('yyyy-MM-dd');

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
          lastDate: DateTime(2024),
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
        // controllerMarginal.dateSelectSnackbar =
        //     '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';

        // controllerMarginal.dateSelected = formatter.format(_selectedDate.value);
        // controllerTonnage.dateSelected = formatter.format(_selectedDate.value);
        // controllerPlan.dateSelected = formatter.format(_selectedDate.value);

        // controllerMarginal.dateSelectedNextDay =
        //     formatter.format(_selectedDate.value.add(const Duration(days: 1)));
        // controllerTonnage.dateSelectedNextDay =
        //     formatter.format(_selectedDate.value.add(const Duration(days: 1)));
        // controllerPlan.dateSelectedNextDay =
        //     formatter.format(_selectedDate.value.add(const Duration(days: 1)));
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
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(width: 1, color: AppColors.secondColor)),
          child: Row(
            mainAxisAlignment: widget.isStack == false
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Icon(
                CupertinoIcons.calendar,
                color: Colors.black.withOpacity(0.6),
              ),
              const SizedBox(width: 5),
              Row(children: [
                Container(
                  child: Text(
                      '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}',
                      style: TextStyle(color: Colors.black.withOpacity(0.6))),
                ),
              ])
            ],
          ),
        ));
  }
}
