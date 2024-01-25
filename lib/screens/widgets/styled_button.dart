import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  final Widget child;
  final Function onTap;
  const StyledButton({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: InkWell(
              // hoverDuration: Duration(milliseconds: 10),
              borderRadius: BorderRadius.circular(20),
              focusColor: Colors.white,
              // overlayColor:
              //     MaterialStateProperty.all(Color.fromARGB(255, 166, 73, 20)),
              // splashColor: Color(int.parse("0xff22092C")),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(int.parse("0xff22092C"))),
                      // border: Border.all(color: Colors.black),
                      // color: Color(
                      //   int.parse('0xFFF05941'),
                      // )),
                    ),
                    child: Center(
                      child: child,
                    )),
              ),
              onTap: () async {
                await onTap();
              }),
        ),
      ],
    );
  }
}
