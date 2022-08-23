import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class TestAnimaiton extends StatefulWidget {
  const TestAnimaiton({ Key? key }) : super(key: key);

  @override
  _TestAnimaitonState createState() => _TestAnimaitonState();
}

class _TestAnimaitonState extends State<TestAnimaiton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this
    );
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomePage(
      controller: _controller,
    );
  }
}

class HomePage extends StatelessWidget {
   HomePage({Key? key, required AnimationController controller}) : animation = HomePageEnterAnimation(controller) ,super(key: key);
  final HomePageEnterAnimation animation;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
        animation: animation.controller,
        builder: (context, child) => _buildAnimation(context, child ?? Container(), size)
      )
    );
  }
  Container topbar(double height){
    return Container(
      height:  height,
      width: double.infinity,
      color: Colors.blue,
    );
  }
  Positioned circle(Size size, double animationValue){
    return Positioned(
      top: 200,
      left: size.width/2-50,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.diagonal3Values(animationValue, animationValue, 1.0),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.blue.shade700
          ),
        ),
      ), 
    );
  }
  Align placeholderBox(double height, double width, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey.shade300
        ),
      ),
    );
  }
  Widget _buildAnimation(BuildContext context,  Widget child, Size size){
    return Column(
        children: <Widget>[
          SizedBox(
            height: 250,
            child: Stack(
              children: <Widget>[
                topbar(animation.barHeight.value),
                 circle(
                   size,
                   animation.avaterSize.value,
                 )
              ],
            ),
          ),
          Padding(
              padding:  const EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 60,),
                  Opacity(
                    opacity: animation.titleOpacity.value,
                    child: placeholderBox(28, 150, Alignment.centerLeft),
                  ),
                  const SizedBox(height: 8,),
                  Opacity(
                    opacity: animation.textOpacity.value,
                    child: placeholderBox(100, double.infinity, Alignment.centerLeft),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: animation.trasl.value,
                      child: Transform(
                        transform: Matrix4.rotationY(animation.rot.value),
                        alignment: Alignment.center,
                        child: const Text("Hello", style: TextStyle(color: Colors.blue, fontSize: 25))
                      )
                    )
                  ],
                ),
            )
        ],
      );
  }
}

class HomePageEnterAnimation {

  HomePageEnterAnimation(this.controller)
    : barHeight = Tween<double>(begin: 0, end: 250).animate(
      CurvedAnimation(
        parent: controller, 
        curve: const Interval(0, 0.3, curve: Curves.easeIn),
      )
    ),
      avaterSize = Tween<double>(begin: 0, end: 1 ).animate(
        CurvedAnimation(
          parent: controller, 
          curve: const Interval(0.3, 0.6, curve: Curves.elasticInOut)
        )
      ),
      titleOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller, 
          curve: const Interval(0.6, 0.65, curve: Curves.easeIn)
        )
      ),
      textOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller, 
          curve: const Interval(0.65, 0.8)
        )
      ),
      rot = Tween<double>(
      begin: 0,
      end: 2 * 3.14,
      ).animate(CurvedAnimation(parent: controller, curve: const Interval(0.8, 1, curve: Curves.easeIn))),
      
    trasl = Tween<double>(
      begin: 0,
      end: 100,
    ).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.7, 1, curve: Curves.easeIn))
    );

  final AnimationController controller;
  final Animation<double> barHeight;
  final Animation<double> avaterSize;
  final Animation<double> titleOpacity;
  final Animation<double> textOpacity;
  final Animation<double> rot;
  final Animation<double> trasl;
}