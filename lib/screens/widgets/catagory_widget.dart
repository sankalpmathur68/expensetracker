import 'package:expensetracker/screens/widgets/input_widget.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class CategoryWidget extends StatelessWidget {
  final inputTitle;
  final inputIcon;
  final selectedIcon;
  final onInputUpdate;
  final List categories;
  final Map iconMap;
  final state;
  final onTapblock;
  final selectedCategory;
  final onDeleteblock;
  final OnEmptyListTitle;
  const CategoryWidget(
      {required this.inputTitle,
      required this.iconMap,
      required this.state,
      this.inputIcon,
      this.selectedIcon,
      required this.selectedCategory,
      required this.onTapblock,
      required this.onDeleteblock,
      this.OnEmptyListTitle,
      required this.categories,
      required this.onInputUpdate,
      super.key});

  @override
  Widget build(BuildContext context) {
    if (state == 'initial') {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TakeInput(
                icon: inputIcon,
                inputTitle: inputTitle,
                onUpdate: (value) {
                  // BlocProvider.of<CategoryCubit>(context).sortedList(value);
                  onInputUpdate(value);
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LimitedBox(
              maxHeight: 215,
              child: Container(
                // duration: const Duration(seconds: 1),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 0),
                          spreadRadius: 1,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1)),
                      BoxShadow(
                          offset: const Offset(0, 0),
                          spreadRadius: 1,
                          blurRadius: 10,
                          color: Colors.blue.withOpacity(0.2)),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Wrap(
                        spacing: 15,
                        runSpacing: 5,
                        clipBehavior: Clip.hardEdge,
                        children: categories.isEmpty
                            ? [IndividualCatagory(title: "$OnEmptyListTitle")]
                            : categories
                                .map((e) => IndividualCatagory(
                                      title: e,
                                      prefixicon: iconMap.containsKey(e)
                                          ? iconMap['$e'].runtimeType == Image
                                              ? iconMap['$e']
                                              : Icon(
                                                  iconMap['$e'],
                                                  color: Colors.grey,
                                                )
                                          : const SizedBox(),
                                      onTap: () {
                                        // print(e);
                                        onTapblock(e);
                                        // BlocProvider.of<CategoryCubit>(
                                        //         context)
                                        //     .updateToSelected(e);
                                      },
                                    ))
                                .toList()),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    if (state == 'selected') {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: IndividualCatagory(
              prefixicon: selectedIcon,
              mainAxixSize: MainAxisSize.max,
              color: Colors.blue.shade200,
              title: selectedCategory,
              onDelete: () {
                onDeleteblock();
              },
            ),
          ),
        ],
      );
    }
    return const SizedBox();
  }
}

class IndividualCatagory extends StatelessWidget {
  final String title;
  final Color? color;
  final mainAxixSize;
  final Function? onTap;
  final Function? onDelete;
  final Widget? prefixicon;
  const IndividualCatagory({
    super.key,
    this.color,
    this.mainAxixSize,
    this.prefixicon,
    required this.title,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        decoration: BoxDecoration(
            color: color != null ? color! : Color(int.parse("0X007E6363")),
            border: color != null ? const Border() : Border.all(),
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: mainAxixSize ?? MainAxisSize.min,
          children: [
            prefixicon != null ? prefixicon! : const SizedBox(),
            Text(
              title,
              style: GoogleFonts.roboto(
                  color: color != null
                      ? Colors.white
                      : Color(int.parse("0XFF3E3232")),
                  fontSize: 23),
              textAlign: TextAlign.center,
            ),
            onDelete != null
                ? const SizedBox(
                    width: 5,
                  )
                : const SizedBox(
                    width: 0,
                  ),
            onDelete != null
                ? GestureDetector(
                    onTap: () {
                      onDelete!();
                    },
                    child: const Icon(
                      Icons.cancel,
                      size: 30,
                      color: Colors.white,
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
