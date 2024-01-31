import 'package:expensetracker/cubit/auth_cubit.dart';
import 'package:expensetracker/cubit/password_visiblity_cubit.dart';
import 'package:expensetracker/screens/widgets/input_widget.dart';
import 'package:expensetracker/screens/widgets/styled_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Image.asset(
                "assets/images/wallet-svgrepo-com.png",
                color: Colors.black,
                fit: BoxFit.cover,
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                // "S p e n d w i s e",
                "S P E N D w i s e",
                style: GoogleFonts.roboto(
                    color: Colors.blue.shade400,
                    fontWeight: FontWeight.w300,
                    fontSize: 30),
              ),
              Text(
                "Track All Your Expenses",
                style: GoogleFonts.roboto(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 50,
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        const SizedBox(height: 20),
                        StyledButton(
                            onTap: () async {
                              await BlocProvider.of<AuthCubit>(context)
                                  .signInWithEmailAndPassword(
                                      context.read<AuthCubit>().email_cubit,
                                      context.read<AuthCubit>().password_cubit);
                            },
                            child: Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: 20, color: Colors.blue.shade400),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Do not have an account ? ",
                              style: GoogleFonts.roboto(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                            InkWell(
                              onTap: () {
                                // BlocProvider.of<AuthCubit>(context)
                                //     .register();
                                context.go('/register');
                              },
                              child: Text(
                                "Create one ",
                                style: GoogleFonts.roboto(
                                    fontSize: 17, color: Colors.blue.shade400),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context_) {
                                  return MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                        create: (context) => AuthCubit(),
                                      ),
                                      BlocProvider(
                                        create: (context) =>
                                            PasswordVisibilityCubit(),
                                      ),
                                    ],
                                    child: AlertDialog(
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            TakeInput(
                                                inputTitle: "Registered Email",
                                                onUpdate: (value) {
                                                  BlocProvider.of<AuthCubit>(
                                                          context)
                                                      .email_cubit = value;
                                                }),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            StyledButton(
                                                onTap: () {
                                                  BlocProvider.of<AuthCubit>(
                                                          context)
                                                      .sendPasswordResetLink();
                                                  Navigator.pop(context_);
                                                },
                                                child: Text(
                                                  "Continue",
                                                  style: GoogleFonts.roboto(
                                                      color:
                                                          Colors.blue.shade400),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Text(
                            "Forgot Password ?",
                            style:
                                GoogleFonts.roboto(color: Colors.blue.shade400),
                          ),
                        )
                      ]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
