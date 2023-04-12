import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartbridge/ui/locales/locale_switcher.dart';
import 'package:smartbridge/ui/widgets/forgot/forgot_view_model.dart';

class ForgotWidget extends StatelessWidget {
  const ForgotWidget({super.key});

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
          child: const _ListForgotFields(),
        ),
      ),
    );
  }
}

class _ListForgotFields extends StatelessWidget {
  const _ListForgotFields({Key? key}) : super(key: key);

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
          _ResetButton(),
          _LoginRegister(),
        ],
      ),
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

class _TitleInfo extends StatelessWidget {
  const _TitleInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleSwitcher.of(context)!.forgotmessage,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
    );
  }
}

class _LoginRegister extends StatelessWidget {
  const _LoginRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/auth');
          },
          child: Text(LocaleSwitcher.of(context)!.signinbut),
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

  bool validateEmail(String email) {
    int firstAtSign = email.indexOf("@");
    int lastAtSign = email.lastIndexOf("@");
    int dot = email.lastIndexOf(".");
    return firstAtSign != -1 &&
        firstAtSign == lastAtSign &&
        dot > firstAtSign &&
        dot != email.length - 1 &&
        dot != 0 &&
        !email.contains(" ") &&
        email[lastAtSign + 1] != ".";
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<ForgotViewModel>();
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
    ]);
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select((ForgotViewModel m) => m.errorMessage);
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

class _ResetButton extends StatelessWidget {
  const _ResetButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ForgotViewModel>();
    final child = Text(LocaleSwitcher.of(context)!.reset);
    return ElevatedButton(
      onPressed: () {
        model.auth(context);
        // showDialog(
        //   context: context,
        //   builder: (BuildContext ctx) {
        //     return AlertDialog(
        //       title: Text(LocaleSwitcher.of(context)!.help),
        //       content: Text(LocaleSwitcher.of(context)!.helpbody),
        //       actions: <Widget>[
        //         TextButton(
        //           child: const Text('Отправить'),
        //           onPressed: () {
        //             Navigator.pop(ctx);
        //             model.auth(context);
        //           },
        //         ),
        //       ],
        //     );
        //   },
        // );
      },
      child: child,
    );
  }
}
