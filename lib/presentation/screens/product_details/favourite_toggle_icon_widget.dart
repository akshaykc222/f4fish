import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/presentation/controller/product_controller.dart';

class Heart extends StatefulWidget {
  const Heart({
    Key? key,
  }) : super(key: key);

  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;
  final controller = Get.find<ProductController>();
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    _colorAnimation = ColorTween(begin: Colors.white70, end: Colors.red)
        .animate(_controller);

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 18, end: 30),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 30, end: 18),
        weight: 50,
      ),
    ]).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.expandResponse.value.data?.isFavourite = true;
        setState(() {});
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          controller.expandResponse.value.data?.isFavourite = false;
        });
      }
    });
  }

  // dismiss the animation when widgit exits screen
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, _) {
          return
            GestureDetector(
              onTap: (){
                controller.expandResponse.value.data?.isFavourite == true
                    ? _controller.reverse()
                    : _controller.forward();
              },
              child:CircleAvatar(
                backgroundColor: Colors.black12,
                radius: 20,
                child: Icon(
                  Icons.favorite_outlined,
                  color: _colorAnimation.value,
                  size: _sizeAnimation.value,
                ),
              ),
            );
        });
  }
}
