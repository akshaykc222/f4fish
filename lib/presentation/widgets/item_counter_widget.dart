import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/presentation/controller/product_controller.dart';

import '../../styles/themes.dart';
import '../styles/colors.dart';

class ItemCounterWidget extends StatefulWidget {
  final Function? onAmountChanged;
  final int? quantity;
  final Function? onIncrement;
  final Function? onDecrement;

  const ItemCounterWidget(
      {Key? key,
      this.onAmountChanged,
      this.quantity,
      this.onIncrement,
      this.onDecrement})
      : super(key: key);

  @override
  _ItemCounterWidgetState createState() => _ItemCounterWidgetState();
}

class _ItemCounterWidgetState extends State<ItemCounterWidget> {
  int amount = 1;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    return Row(
      children: [
        iconWidget(Icons.remove,
            iconColor: Colors.green.shade700,
            onPressed: () =>
                widget.onDecrement == null ? {} : widget.onDecrement!()),
        SizedBox(width: 10),
        Container(
            width: 30,
            child: Center(
                child: getText(
                    text: "${widget.quantity ?? "0"}",
                    fontSize: 18,
                    isBold: true))),
        SizedBox(width: 10),
        iconWidget(Icons.add,
            iconColor: Colors.green.shade700,
            onPressed: () =>
                widget.onIncrement == null ? {} : widget.onIncrement!())
      ],
    );
  }

  Widget iconWidget(IconData iconData,
      {required Color iconColor, required Function onPressed}) {
    return GestureDetector(
      onTap: () {
        debugPrint("pressing");
        debugPrint("pressing91");
        onPressed();
      },
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.green.shade700,
          ),
        ),
        child: Center(
          child: Icon(
            iconData,
            color: iconColor,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget getText(
      {required String text,
      required double fontSize,
      bool isBold = false,
      color = Colors.green}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color,
      ),
    );
  }
}

class ItemCounterWidgetNew extends StatefulWidget {
  final Function onAmountChanged;
  final Function incrementFunction;
  final Function decrementFunction;
  final int qty;

  const ItemCounterWidgetNew(
      {Key? key,
      required this.onAmountChanged,
      required this.incrementFunction,
      required this.decrementFunction,
      required this.qty})
      : super(key: key);

  @override
  _ItemCounterWidgetNewState createState() => _ItemCounterWidgetNewState();
}

class _ItemCounterWidgetNewState extends State<ItemCounterWidgetNew> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        iconWidget(Icons.remove,
            iconColor: AppColors.primaryColor,
            onPressed: () => widget.decrementFunction()),
        SizedBox(width: 10),
        Container(
            width: 30,
            child: Center(
                child: getText(
                    text: widget.qty.toString(), fontSize: 18, isBold: true))),
        SizedBox(width: 10),
        iconWidget(Icons.add,
            iconColor: AppColors.primaryColor,
            onPressed: () => widget.incrementFunction())
      ],
    );
  }

  Widget iconWidget(IconData iconData,
      {required Color iconColor, required Function onPressed}) {
    return GestureDetector(
      onTap: () {
        debugPrint("pressing");
        debugPrint("pressing91");
        onPressed();
      },
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.green.shade700,
          ),
        ),
        child: Center(
          child: Icon(
            iconData,
            color: iconColor,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget getText(
      {required String text,
      required double fontSize,
      bool isBold = false,
      color = Colors.green}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color,
      ),
    );
  }
}

class ItemAddWidget extends StatelessWidget {
  final Function? onAmountChanged;

  ItemAddWidget({Key? key, this.onAmountChanged}) : super(key: key);

  int amount = 1;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    return Center(
      child: GestureDetector(
          onTap: () => onAmountChanged == null ? {} : onAmountChanged!(),
          child: Container(
              height: 30,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.green.shade700),
              child: Center(
                  child: Text(
                "ADD",
                style: Add,
              )))),
    );
  }

  Widget iconWidget(IconData iconData,
      {required Color iconColor, required Function onPressed}) {
    return GestureDetector(
      onTap: () {
        debugPrint("pressing");
        debugPrint("pressing91");
        onPressed();
      },
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.green.shade700,
          ),
        ),
        child: Center(
          child: Icon(
            iconData,
            color: iconColor,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget getText(
      {required String text,
      required double fontSize,
      bool isBold = false,
      color = Colors.green}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color,
      ),
    );
  }
}
