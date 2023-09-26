import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/services/auth/bloc/auth_event.dart';
import 'package:flutter_application_1/services/auth/bloc/auth_state.dart';
import 'package:flutter_application_1/utilities/dialogs/error_dialog.dart';
import 'package:flutter_application_1/utilities/dialogs/password_reset_email_sent_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/constants/const.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthStateForgotPassword) {
            if (state.hasSentEmail) {
              _controller.clear();
              await showPasswordResetSentDialog(context);
            }
            if (state.exception != null) {
              // ignore: use_build_context_synchronously
              await showErrorDialog(context,
                  'We could not process your request. Please make sure you are a registered user.');
            }
          }
        },
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: const Color.fromRGBO(140, 162, 217, 1),
                title: const Text(
                  'Forgot Password',
                )),
            body: Container(
              height: double.maxFinite,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [g1, g2],
                ),
              ),
              child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, bottom: 20, right: 20, top: 30),
                      child: OverflowBar(
                        overflowAlignment: OverflowBarAlignment.center,
                        overflowSpacing: size.height * 0.014,
                        children: [
                          const Text(
                            'If you forgot your password, simply enter your email and we will send you a change password link',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: kWhiteColor,
                            ),
                          ),
                          SizedBox(height: size.height * 0.024),
                          TextField(
                            controller: _controller,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(color: kInputColor),
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 25.0),
                              filled: true,
                              hintText: "Enter your email",
                              prefixIcon: IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(userIcon),
                              ),
                              fillColor: kWhiteColor,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(37),
                              ),
                            ),
                          ),
                          CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: size.height * 0.080,
                                decoration: BoxDecoration(
                                  color: kButtonColor,
                                  borderRadius: BorderRadius.circular(37),
                                ),
                                child: const Text(
                                  "Send password reset link",
                                  style: TextStyle(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                final email = _controller.text;
                                context
                                    .read<AuthBloc>()
                                    .add(AuthEventForgotPassword(email: email));
                              }),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.centerRight,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              context
                                  .read<AuthBloc>()
                                  .add(const AuthEventLogOut());
                            },
                            child: const Text('Back to Login'),
                          )
                        ],
                      ))),
            )));
  }
}
