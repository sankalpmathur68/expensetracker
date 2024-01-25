import 'package:expensetracker/cubit/password_visiblity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TakeInput extends StatelessWidget {
  final String inputTitle;
  final bool? obsecureText;
  final Function onUpdate;
  final Widget? icon;

  const TakeInput(
      {super.key,
      this.icon,
      this.obsecureText,
      required this.inputTitle,
      required this.onUpdate});
  // TextEditingController _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
        height: 55,
        // width: ,
        // padding: EdgeInsets.all(6),
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
                  color: Colors.blue.withOpacity(0.2))
            ],
            color: Colors.white,
            // color: Color(int.parse('0xbfF05941')),
            borderRadius: BorderRadius.circular(30)),
        child: BlocBuilder<PasswordVisibilityCubit, PasswordVisibilityState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LimitedBox(
                    maxWidth: screenWidth - 50,
                    child: TextField(
                      focusNode: FocusNode(skipTraversal: true),
                      onChanged: (value) {
                        onUpdate(value);
                        // ref.read(provider.notifier).state = value;
                      },
                      textAlign: TextAlign.center,
                      // controller: _inputController,
                      obscureText:
                          state is PasswordNotVisible && obsecureText != null
                              ? obsecureText!
                              : false,
                      decoration: InputDecoration(
                          suffixIcon: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<PasswordVisibilityCubit>(
                                          context)
                                      .changeVisiblity();
                                },
                                child: icon ??
                                    (obsecureText != null
                                        ? state is PasswordNotVisible
                                            ? Image.asset(
                                                'assets/images/eye-closed-svgrepo-com.png',
                                                width: 20,
                                                height: 20,
                                              )
                                            : Image.asset(
                                                'assets/images/eye-svgrepo-com.png',
                                                width: 20,
                                                height: 20,
                                              )
                                        : const SizedBox(
                                            width: 0,
                                          ))),
                          ),
                          suffixIconColor: Colors.black,
                          hintText: inputTitle,
                          // labelText: '$inputTitle',
                          hintStyle: GoogleFonts.roboto(
                              color: Color(int.parse("0xff22092C"))),
                          border: InputBorder.none
                          // border: OutlineInputBorder(
                          //     borderSide: const BorderSide(color: Colors.white, width: 10),
                          //     borderRadius: BorderRadius.circular(30))
                          ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
