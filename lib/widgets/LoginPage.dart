import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final String title;

  const LoginPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const _usernameLabel = 'Username:';
    const _passwordLabel = 'Password:';

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                CustomLoginInput(labelText: _usernameLabel),
                const SizedBox(
                  height: 30,
                ),
                CustomLoginInput(labelText: _passwordLabel),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login...')));
                            //Add database login
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomLoginInput extends StatefulWidget {
  final String labelText;
  final String? Function(String?)? validator;


  CustomLoginInput({
    Key? key,
    required this.labelText,
    this.validator,
  }) : super(key: key);

  @override
  _CustomLoginInputState createState() => _CustomLoginInputState();
}

class _CustomLoginInputState extends State<CustomLoginInput> {

  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    //Obtaining values from the CustomLoginInput
    final String labelText = widget.labelText;
    final String? Function(String?)? validator = widget.validator;

    if (labelText == 'Username:') {
      return SizedBox(
        width: 300,
        child: TextFormField(
          validator: (value) {
            if (validator != null) {
              return validator(value);
            } else {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty.';
              }
              return null;
            }
          },
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'RobotoSlab',
            fontStyle: FontStyle.italic,
          ),
          decoration: InputDecoration(labelText: labelText),
        ),
      );
    } else {
      return SizedBox(
        width: 300,
        child: TextFormField(
          obscureText: isObscured,
          validator: (value) {
            if (validator != null) {
              return validator(value);
            } else {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty.';
              }
              return null;
            }
          },
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'RobotoSlab',
            fontStyle: FontStyle.italic,
          ),
          decoration: InputDecoration(
            labelText: labelText,
            suffixIcon: IconButton(
            icon: Icon(
              isObscured ? Icons.visibility : Icons.visibility_off,
            ),
              onPressed: () {
                setState(() {
                  isObscured = !isObscured;
                });
              },
            ),
          ),
        ),
      );
    }
  }
}
