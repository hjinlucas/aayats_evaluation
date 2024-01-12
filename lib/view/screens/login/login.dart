import 'package:aayats_evaluation/view/screens/base_screen.dart';
import 'package:aayats_evaluation/view/widgets/text_field/text_field.dart';
import 'package:aayats_evaluation/view/widgets/toast/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String name = 'Login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hasAppBar: false,
      widget: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 180.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 40.0),
                    _buildUsernameTF(context),
                    const SizedBox(
                      height: 20.0,
                    ),
                    _buildPasswordTF(context),
                    const SizedBox(
                      height: 5.0,
                    ),
                    _buildLoginBtn(context),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Trigger an error
                        if (kDebugMode) {
                          print('A simulated error go to error handler screen');
                        }
                        //********************************
                        // Error objects could be created
                        // ********************************/
                        throw Exception('Simulated error in Login screen');
                      },
                      child: const Text('Testing a Global Error'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUsernameTF(BuildContext context) {
    return MyTextField(
      textFieldController: usernameController,
      inputType: TextInputType.emailAddress,
      icon: Icons.email,
      textFieldName: 'Username',
    );
  }

  Widget _buildPasswordTF(BuildContext context) {
    return MyTextField(
      textFieldController: passwordController,
      inputType: TextInputType.text,
      icon: Icons.lock,
      textFieldName: 'Password',
    );
  }

  Widget _buildLoginBtn(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          padding: const EdgeInsets.all(15.0),
        ),
        onPressed: () async {
          if (usernameController.text.isEmpty ||
              passwordController.text.isEmpty) {
            if (kDebugMode) {
              print('Field empty');
            }
            context.showToast('Fields must not be empty.. try again!',
                style: const TextStyle());
          } else {
            if (kDebugMode) {
              print('Connecting with services');
            }
            Navigator.pushReplacementNamed(context, 'home');
          }
        },
        child: const Text(
          'Login',
          style: TextStyle(
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController?.dispose();
    passwordController?.dispose();
    super.dispose();
  }
}
