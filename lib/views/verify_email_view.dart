import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/services/auth/bloc/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/constants/const.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VerifyEmailViewState createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
              //padding: EdgeInsets.all(size.height * 0.030),
              padding: const EdgeInsets.only(
                  left: 20, bottom: 20, right: 20, top: 150),
              child: OverflowBar(
                overflowAlignment: OverflowBarAlignment.center,
                overflowSpacing: size.height * 0.014,
                children: [
                  const Text(
                    "We have sent you an email verification. Please open it to verify your account",
                  ),
                  const Text(
                    "If you haven't received a verification email yet, press the button below",
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
                        "Send Email Verification",
                        style: TextStyle(
                          color: kWhiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            const AuthEventSendEmailVerification(),
                          );
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerRight,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            const AuthEventLogOut(),
                          );
                    },
                    child: const Text('Return to Login Page'),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
