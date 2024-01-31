import 'dart:async';

import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isRight = true;
  bool _startLoading = false;
  final List colors_ = ['A87C7C', '7E6363', '503C3C', '3E3232'];
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
        _isRight = !_isRight;

        {
          if (_isRight) {
            _startLoading = true;
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
    Timer.periodic(const Duration(milliseconds: 800), (timer) {
      _togglePosition();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        AnimatedContainer(
          // margin: const EdgeInsets.all(0),
          duration: const Duration(milliseconds: 3000),
          height: _startLoading ? 200 : 0,
          // width: _startLoading ? 200 : 0,
          decoration: BoxDecoration(
              color: Colors.blue.shade200,
              // color: Color(int.parse("0XFF${colors_[3]}")),
              borderRadius: BorderRadius.circular(30)),
        ),
        for (int i = 0; i < imagepaths.length; i++) ...[
          ArthmaticSymbols(
            // color: Colors.blue.shade300,
            // Colors.black,
            color: Colors.black,
            left: double.parse(
                "${pos[i + index > 3 ? (i + index) - 4 : index + i][0]}"),
            top: double.parse(
                "${pos[i + index > 3 ? (i + index) - 4 : index + i][1]}"),
            imagepath: imagepaths[i],
          ),
        ],
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
      duration: const Duration(milliseconds: 300),
      // curve: Curves.easeInOut,
      left: left,
      top: top,
      child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              imagepath,
              height: 20,
              width: 20,
              color: color,
            ),
          )),
    );
  }
}
