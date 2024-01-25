import 'package:expensetracker/cubit/auth_cubit.dart';
import 'package:expensetracker/screens/widgets/input_widget.dart';
import 'package:expensetracker/screens/widgets/styled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/spendwise_light_theme_logo.png",
                  // filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  // colorBlendMode: BlendMode.dstATop,
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TakeInput(
                            onUpdate: (value) {
                              context.read<AuthCubit>().email_cubit = value;
                            },
                            inputTitle: "Email",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TakeInput(
                            onUpdate: (value) {
                              context.read<AuthCubit>().password_cubit = value;
                            },
                            // provider: passwordProvider,
                            obsecureText: true,
                            inputTitle: "Password",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TakeInput(
                            onUpdate: (value) {
                              context.read<AuthCubit>().rePassword_cubit =
                                  value;
                            },
                            // provider: passwordProvider,
                            obsecureText: true,
                            inputTitle: "Re-Enter Password",
                          ),
                          const SizedBox(height: 20),
                          StyledButton(
                              onTap: () async {
                                await BlocProvider.of<AuthCubit>(context)
                                    .registerWithEmailAndPassword(
                                        context.read<AuthCubit>().email_cubit,
                                        context
                                            .read<AuthCubit>()
                                            .password_cubit);
                              },
                              child: Text(
                                "Register",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: Color(int.parse('0xbfF05941'))),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account ? ",
                                style: GoogleFonts.roboto(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                              Text(
                                "Login",
                                style: GoogleFonts.roboto(
                                    fontSize: 17,
                                    color: Color(int.parse('0xFFF05941'))),
                              ),
                            ],
                          )
                        ]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
