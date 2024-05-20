import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_demo/home/home.dart';
import 'package:flutter_application_bloc_demo/login/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_strength/password_strength.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String myNumber = '';
  double passwordStrength = 0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listenWhen: (previous, current) =>
            current is LoginSuccessState || current is LoginErrorState,
        listener: (context, state) {
          // TODO: implement listener
          if (state is LoginSuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
                (route) => false);
          }
          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          var loginBloc = context.read<LoginBloc>();

          if (state is LoginLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://img.freepik.com/free-vector/network-mesh-wire-digital-technology-background_1017-27428.jpg?w=740&t=st=1709029614~exp=1709030214~hmac=ac0c557ceb40ed98f251f46f9e01b2d9ac92de7f371d64a1cd5a106204a2b80b'),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    loginBloc.isLogIn ? 'LOGIN' : 'CREATE ACCOUNT',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            labelText: 'Email',
                            counterText: '',
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.name,
                        onChanged: (v) {
                          passwordStrength = estimatePasswordStrength(v);
                        },
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            counterText: '',
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      LinearProgressIndicator(
                        value: passwordStrength,
                        color: passwordStrength < 0.3
                            ? Colors.red
                            : passwordStrength < 0.7
                                ? Colors.yellow
                                : Colors.green,
                      )
                    ],
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      if (emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Enter Email')));
                      } else {
                        loginBloc.add(LoginResetClickedEvent(
                            email: emailController.text));
                      }
                    },
                    child: const Text('Forget Password?')),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 55,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: const MaterialStatePropertyAll(1),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)))),
                      onPressed: () {
                        loginBloc.add(LoginButtonClickedEvent(
                            email: emailController.text,
                            password: passwordController.text));
                      },
                      child: Text(loginBloc.isLogIn ? 'Login in' : 'Register')),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    loginBloc.add(LoginStateChangeEvent());
                  },
                  child: Center(
                    child:
                        Text(loginBloc.isLogIn ? 'Create Account?' : 'Login!'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
