import 'dart:async';

import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isRight = true;
  final List _colors = ['A87C7C', '7E6363', '503C3C', '3E3232'];
  List pos = [
    [50, 50],
    [50, 50],
    [50, 50],
    [50, 50]
  ];
  List imagepaths = [
    'assets/images/plus-large-svgrepo-com.png',
    'assets/images/minus-svgrepo-com.png',
    'assets/images/multiply-svgrepo-com.png',
    'assets/images/divide-straight-svgrepo-com.png',
  ];
  int index = 0;
  void _togglePosition() {
    if (mounted) {
      setState(() {
        {
          _isRight = !_isRight;
          if (_isRight) {
            pos = [
              [0, 0],
              [100, 0],
              [100, 100],
              [0, 100]
            ];
          }
          index = index == 3 ? 0 : index + 1;
        }
      });
    }
  }

  @override
  void initState() {
    // WidgetsFlutterBinding.ensureInitialized();
    _togglePosition();
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      _togglePosition();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        for (int i = 0; i < imagepaths.length; i++) ...[
          ArthmaticSymbols(
            color: Color(int.parse("0XFF${_colors[1]}")),
            // color: Colors.black,
            left: double.parse(
                "${pos[i + index > 3 ? (i + index) - 4 : index + i][0]}"),
            top: double.parse(
                "${pos[i + index > 3 ? (i + index) - 4 : index + i][1]}"),
            imagepath: imagepaths[i],
          ),
        ],
        AnimatedContainer(
          // margin: const EdgeInsets.all(0),
          duration: const Duration(milliseconds: 1000),
          height: 10,
          width: _isRight ? 0 : 200,
          decoration: BoxDecoration(
              //color:Colors.black,
              color: Color(int.parse("0XFF${_colors[3]}")),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                height: 10,
                width: _isRight ? 0 : 100,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(0.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(0.0),
                    ),
                    gradient: LinearGradient(colors: [
                      Color(int.parse("0XFF${_colors[2]}")),
                      Color(int.parse("0XFF${_colors[_isRight ? 1 : 0]}")),
                    ])
                    // color: Color(int.parse("0XFF${_colors[1]}")),
                    ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                height: 10,
                width: _isRight ? 0 : 100,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    gradient: LinearGradient(colors: [
                      Color(int.parse("0XFF${_colors[_isRight ? 1 : 0]}")),
                      Color(int.parse("0XFF${_colors[2]}")),
                    ])
                    // color: Color(int.parse("0XFF${_colors[1]}")),
                    ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ArthmaticSymbols extends StatelessWidget {
  final Color color;
  final double left;
  final double top;
  final String imagepath;
  const ArthmaticSymbols(
      {super.key,
      required this.color,
      required this.imagepath,
      required this.top,
      required this.left});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      left: left,
      top: top,
      child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagepath,
                height: 50,
                width: 50,
                color: color,
              )
            ],
          ))),
    );
  }
}
