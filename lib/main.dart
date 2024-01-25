import 'package:expensetracker/cubit/all_Expense_cubit.dart';
import 'package:expensetracker/cubit/auth_cubit.dart';
import 'package:expensetracker/cubit/catagories_cubit.dart';
import 'package:expensetracker/cubit/expense_cubit.dart';
import 'package:expensetracker/cubit/password_visiblity_cubit.dart';
import 'package:expensetracker/firebase_options.dart';
import 'package:expensetracker/screens/add_expense_screen.dart';
import 'package:expensetracker/screens/home_page.dart';
import 'package:expensetracker/screens/loading_screen.dart';
import 'package:expensetracker/screens/login_screen.dart';
import 'package:expensetracker/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    GoRouter router = GoRouter(routes: [
      GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => AuthCubit(),
                  ),
                  BlocProvider(
                    create: (context) => PasswordVisibilityCubit(),
                  ),
                  BlocProvider(
                    create: (context) => CategoryCubit(),
                  ),
                  BlocProvider(
                    create: (context) => ExpenseCubit(),
                  ),
                ],
                // create: (context) => AuthCubit(),
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    // log("$state");
                    if (state is Authenticated) {
                      return const HomePage();
                    }
                    if (state is NotAuthenticated ||
                        state is Autherror ||
                        state is AuthRegister) {
                      return const LoginPage();
                    }
                    if (state is AuthLoading || state is AuthInitial) {
                      return const LoadingScreen();
                    }
                    return Text("$state");
                  },
                ));
          },
          routes: [
            GoRoute(
                path: 'register',
                builder: (BuildContext context, GoRouterState state) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => AuthCubit(),
                      ),
                      BlocProvider(
                        create: (context) => PasswordVisibilityCubit(),
                      ),
                      BlocProvider(
                        create: (context) => CategoryCubit(),
                      ),
                    ],
                    child: BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        if (state is Authenticated || state is Autherror) {
                          return const LoginPage();
                        }
                        if (state is AuthRegister || state is Autherror) {
                          return const Register();
                        }
                        if (state is NotAuthenticated || state is Autherror) {
                          return const LoginPage();
                        }
                        if (state is AuthLoading || state is AuthInitial) {
                          return const LoadingScreen();
                        }
                        return Text("$state");
                      },
                    ),
                  );
                }),
            GoRoute(
                path: 'add_expenses',
                builder: ((BuildContext context, GoRouterState state) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => CategoryCubit(),
                      ),
                      BlocProvider(
                        create: (context) => PasswordVisibilityCubit(),
                      ),
                      BlocProvider(
                        create: (context) => ExpenseCubit(),
                      ),
                      BlocProvider(
                        create: (context) => AuthCubit(),
                      ),
                    ],
                    child: BlocConsumer<CategoryCubit, CategoryState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return const AddExpenxe();
                      },
                    ),
                  );
                }))
          ])
    ]);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SpendWise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
      // home: MultiBlocProvider(
      //     providers: [
      //       BlocProvider(
      //         create: (context) => AuthCubit(),
      //       ),
      //       // BlocProvider(
      //       //   create: (context) => SubjectBloc(),
      //       // ),
      //     ],
      //     child: BlocConsumer<AuthCubit, AuthState>(
      //       listener: (context, state) {
      //         // TODO: implement listener
      //       },
      //       builder: (context, state) {
      //         log(state);

      //         if (state is Authenticated || state is Autherror) {
      //           return HomePage();
      //         }
      //         if (state is NotAuthenticated || state is Autherror) {
      //           return loginPage();
      //         }
      //         if (state is AuthLoading || state is AuthInitial) {
      //           return LoadingScreen();
      //         }
      //         return Text("$state");
      //       },
      //     )));
    );
  }
}


// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // void _incrementCounter() {
//   //   setState(() {
//   //     _counter++;
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // int _counter = context.read(CounterProvider);

//     return Consumer(builder: (context, ref, _) {
//       return Scaffold(
//           appBar: AppBar(
//             backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//             title: Text(widget.title),
//           ),
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 const Text(
//                   'You have pushed the button this many times:',
//                 ),
//                 Text(
//                   '${ref.watch(CounterProvider)}',
//                   style: Theme.of(context).textTheme.headlineMedium,
//                 ),
//               ],
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {},
//             tooltip: 'Increment',
//             child: const Icon(Icons.add),
//           ));
//     });
//   }
// }
