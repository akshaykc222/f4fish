import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/core/api_provider.dart';
import 'package:grocery_app/data/remote/model/time_slot_model.dart';
import 'package:grocery_app/presentation/controller/cart_controller.dart';
import 'package:intl/intl.dart';

import '../injecter.dart';

Future<void> main() async {
  await init();
  runApp(MaterialApp(
    home: DateTimeSlot(),
  ));
}

ValueNotifier<TimeSlotModel?> selectedDate = ValueNotifier(null);

class DateTimeSlot extends StatefulWidget {
  const DateTimeSlot();

  @override
  State<DateTimeSlot> createState() => _DateTimeSlotState();
}

class _DateTimeSlotState extends State<DateTimeSlot> {
  DateTime? selDate;
  List<TimeSlotModel> timeSlots = [];
  final controller = Get.find<CartController>();

  @override
  void initState() {
    fetchTimeSlots(selected: DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            SizedBox(
              height: 10,
            ),
            dateSelection(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Choose Time",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TimeSlotMenu(
              selected: timeSlots,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchTimeSlots({DateTime? selected}) async {
    final dio = sl<ApiProvider>();
    var date = DateFormat("yyyy-MM-dd").format(selected ?? DateTime.now());

    var data = await dio.get('api/v1/time_slots/?date=$date');
    setState(() {
      timeSlots = List<TimeSlotModel>.from(
          data["results"].map((x) => TimeSlotModel.fromJson(x)));
    });
  }

  dateSelection() {
    return EasyDateTimeLine(
      initialDate: controller.cartListTemp
              .where((p0) => p0.product.preOrder == true)
              .isEmpty
          ? DateTime.now()
          : DateTime.now().add(Duration(days: 1)),
      onDateChange: (selectedDate) {
        fetchTimeSlots(selected: selectedDate);
      },
      headerProps: const EasyHeaderProps(
        monthPickerType: MonthPickerType.switcher,
        selectedDateFormat: SelectedDateFormat.fullDateDMY,
      ),
      dayProps: const EasyDayProps(
        dayStructure: DayStructure.dayStrDayNum,
        activeDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff3371FF),
                Color(0xff8426D6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimeSlotMenu extends StatefulWidget {
  final List<TimeSlotModel> selected;
  const TimeSlotMenu({required this.selected});

  @override
  State<TimeSlotMenu> createState() => _TimeSlotMenuState();
}

class _TimeSlotMenuState extends State<TimeSlotMenu> {
  List<TimeSlotModel> timeslotList = [];

  @override
  void initState() {
    super.initState();
    // Fetch time slots when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.selected.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 25 / 9,
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return TimeSlotItem(
          timeSlotModal: widget.selected[index],
        );
      },
    );
  }
}

class TimeSlotItem extends StatelessWidget {
  const TimeSlotItem({required this.timeSlotModal});
  final TimeSlotModel timeSlotModal;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: () {
        selectedDate.value = timeSlotModal;
        selectedDate.notifyListeners();
        Get.back();
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(2, 1),
            ),
          ],
          border: Border.all(color: Colors.black),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "${timeSlotModal.startTime}-${timeSlotModal.endTime}",
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
