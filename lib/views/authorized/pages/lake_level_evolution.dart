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
                children: const [],
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
