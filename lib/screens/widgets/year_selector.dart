import 'package:expensetracker/APIs/whole_app_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class yearSelector extends StatelessWidget {
  final Function onChanged;
  const yearSelector({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    List years = AppData().year();
    return Container(
      height: 100,
      width: 140,
      decoration: BoxDecoration(
          border: const Border.symmetric(vertical: BorderSide.none),
          borderRadius: BorderRadius.circular(10),
          // color:  Color.fromARGB(189, 146, 219, 232),
          color: Colors.transparent),
      child: ListWheelScrollView(
          physics: const FixedExtentScrollPhysics(),
          diameterRatio: 1.5,
          // clipBehavior: Clip.hardEdge,
          perspective: 0.01,

          //  overAndUnderCenterOpacity: 0.9,
          useMagnifier: true,
          magnification: 1.5,
          onSelectedItemChanged: (int index) {
            onChanged(years[index]);
            // .selectYearHandler("${int.parse("$index") + 1}");
          },
          itemExtent: 35,
          children: List<Widget>.generate(years.length, (index) {
            // if (index == 0) {
            //   final year = years[DateTime.now().year - 1947];
            // }
            final year = years[index];
            return Container(
                // height: 80,
                alignment: Alignment.center,
                // width: 70,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    backgroundBlendMode: BlendMode.darken),
                child: Center(
                    child: Text(
                  "$year",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(color: Colors.black),
                )));
          })),
    );
  }
}
