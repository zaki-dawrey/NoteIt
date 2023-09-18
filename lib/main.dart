import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/helpers/loading/loading_screen.dart';
import 'package:flutter_application_1/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/services/auth/bloc/auth_event.dart';
import 'package:flutter_application_1/services/auth/bloc/auth_state.dart';
import 'package:flutter_application_1/services/auth/firebase_auth_provider.dart';
import 'package:flutter_application_1/views/forgot_password_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/login_view.dart';
import 'package:flutter_application_1/views/notes/create_update_note_view.dart';
import 'package:flutter_application_1/views/notes/notes_view.dart';
import 'package:flutter_application_1/views/register_view.dart';
import 'package:flutter_application_1/views/verify_email_view.dart';
import 'constants/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  String? apiKey = dotenv.env['FIREBASE_API_KEY'];

  if (apiKey != null) {
    final FirebaseOptions options = getFirebaseOptions(apiKey);

    await Firebase.initializeApp(
      options: options,
    );

    runApp(
      MaterialApp(
        title: 'Notes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(FirebaseAuthProvider()),
          child: const HomePage(),
        ),
        routes: {
          createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
        },
      ),
    );
  } else {
    print("Error: FIREBASE_API_KEY not found in .env file.");
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
