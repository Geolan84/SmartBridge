import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartbridge/ui/utils.dart';
import 'package:smartbridge/ui/locales/locale_switcher.dart';
import 'package:smartbridge/ui/widgets/login/login_view_model.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: const _ListBodyFields(),
        ),
      ),
    );
  }
}

class _ListBodyFields extends StatelessWidget {
  const _ListBodyFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _LogoImage(),
          _TitleInfo(),
          _LoginForm(),
          _LoginButton(),
          _RegisterForgot()
        ],
      ),
    );
  }
}

class _TitleInfo extends StatelessWidget {
  const _TitleInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleSwitcher.of(context)!.signintitle,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthViewModel>();
    final onPressed = model.canStartAuth ? () => model.auth(context) : null;
    final child = model.isAuthProgress
        ? const SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(LocaleSwitcher.of(context)!.signinbut);
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

class _LogoImage extends StatelessWidget {
  const _LogoImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(15),
      child: Image(
        image: AssetImage(
          "assets/images/logo.png",
        ),
      ),
    );
  }
}

class _RegisterForgot extends StatelessWidget {
  const _RegisterForgot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/forgot');
          },
          child: Text(LocaleSwitcher.of(context)!.forgot),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/register');
          },
          child: Text(LocaleSwitcher.of(context)!.signupbut),
        ),
      ],
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthViewModel>();
    return Column(children: [
      const _ErrorMessageWidget(),
      TextFormField(
        controller: model.emailTextInputController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        keyboardType: TextInputType.emailAddress,
        validator: (val) {
          if (val == null || val.isEmpty) {
            return LocaleSwitcher.of(context)!.emptyfield;
          } else if (!validateEmail(val)) {
            return LocaleSwitcher.of(context)!.invalidemail;
          }
          return null;
        },
      ),
      const SizedBox(height: 15),
      TextFormField(
        controller: model.passwordTextInputController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: LocaleSwitcher.of(context)!.password,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        obscureText: true,
        validator: (val) {
          if (val == null || val.isEmpty) {
            return LocaleSwitcher.of(context)!.emptyfield;
          } else if (!validatePassword(val)) {
            return LocaleSwitcher.of(context)!.invalidpass;
          }
          return null;
        },
      )
    ]);
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select((AuthViewModel m) => m.errorMessage);
    if (errorMessage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMessage,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.red,
        ),
      ),
    );
  }
}
