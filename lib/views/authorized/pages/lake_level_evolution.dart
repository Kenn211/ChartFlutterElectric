import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_chart/shared/constants/colors.dart';
import 'package:test_chart/shared/widgets/app_bar_custom.dart';

class LakeLevelEvolution extends StatefulWidget {
  const LakeLevelEvolution({super.key});

  @override
  State<LakeLevelEvolution> createState() => _LakeLevelEvolutionState();
}

class _LakeLevelEvolutionState extends State<LakeLevelEvolution> {
  String dropdownvalue = 'Hồ chứa';

  var items = [
    'Hồ chứa',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: const AppBarCustom(
          canBack: true,
          title: 'Diễn biến mức hồ nước',
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text('Nhà máy',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                        width: 1, color: Colors.black.withOpacity(0.5))),
                child: DropdownButton(
                    isExpanded: true,
                    value: dropdownvalue,
                    focusColor: Colors.transparent,
                    // Down Arrow Icon
                    icon: Container(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.primaryColor,
                      ),
                    ),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5))),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    }),
              ),
              const SizedBox(height: 30),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text('Ngày',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_SelectDate(), _SelectDate(fromDay: false)],
              ),
              const SizedBox(height: 15),
              Container(
                width: 140,
                height: 55,
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(CupertinoIcons.refresh_circled),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Lấy dữ liệu')
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectDate extends StatefulWidget {
  const _SelectDate({super.key, this.restorationId, this.fromDay = true});

  final String? restorationId;
  final bool fromDay;

  @override
  State<_SelectDate> createState() => __SelectDateState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class __SelectDateState extends State<_SelectDate> with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2022, 1, 1));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: __selectDate,
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

  void __selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
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
                  '${widget.fromDay == true ? 'Từ ngày' : 'Đến ngày'}: ',
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
