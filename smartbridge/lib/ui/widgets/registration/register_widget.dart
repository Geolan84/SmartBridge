import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartbridge/ui/widgets/registration/register_view_model.dart';
import 'package:smartbridge/ui/locales/locale_switcher.dart';
import 'package:smartbridge/ui/utils.dart';
import 'package:intl/intl.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  RegisterWidgetState createState() => RegisterWidgetState();
}

class RegisterWidgetState extends State<RegisterWidget> {
  final List<bool> _selections = [true, false];
  DateTime? selectedDate;

  _selectDate(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget _buildBirthday(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        //Text(" Select birthday: ${selectedDate?.day} ${selectedDate?.month} ${selectedDate?.year}"),
        Text(" Select birthday: ${selectedDate==null ? '' : DateFormat.yMd().format(selectedDate!.toLocal())}"),
        IconButton(
          onPressed: () => _selectDate(context),
          color: Colors.greenAccent,
          icon: const Icon(Icons.calendar_today),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          //reverse: true,
          child: Container(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const _LogoImage(),
                const _TitleInfo(),
                _buildRoleButtons(context),
                const _RegisterForm(),
                _buildBirthday(context),
                //const _RegisterButton(),
                const _ErrorMessageWidget(),
                buildRegisterButton(context),
                const _LoginForgot()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRegisterButton(BuildContext context) {
    final model = context.watch<RegisterViewModel>();
    //final model = context.watch<RegisterViewModel>();
    // final onPressed = model.canStartAuth ? () => model.auth(context) : null;
    // final child = model.isAuthProgress
    //     ? const SizedBox(
    //         width: 15,
    //         height: 15,
    //         child: CircularProgressIndicator(strokeWidth: 2),
    //       )
    //     : Text(LocaleSwitcher.of(context)!.signinbut);
    // return ElevatedButton(
    //   onPressed: onPressed,
    //   child: child,
    // );
    return ElevatedButton(
      onPressed: () {
        model.register(context, selectedDate, _selections[1]);
      },
      child: const Text("Register"),
    );
  }

  Widget _buildRoleButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ToggleButtons(
        isSelected: _selections,
        selectedBorderColor: Colors.red,
        selectedColor: Colors.white,
        fillColor: Colors.red,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        onPressed: (int index) {
          setState(() {
            for (int i = 0; i < _selections.length; i++) {
              _selections[i] = (i == index);
            }
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: const[
                Icon(Icons.assignment_ind),
                //Text(LocaleSwitcher.of(context)!.applicant),
                Text("    Соискатель  "),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: const [
                Icon(Icons.card_travel),
                //Text(LocaleSwitcher.of(context)!.employer),
                Text("HR-специалист"),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<RegisterViewModel>();
    return Column(
      children: [
        const SizedBox(height: 15),
        _EmailField(controller: model.emailTextInputController),
        const SizedBox(height: 15),
        _PasswordField(controller: model.passwordTextInputController),
        const SizedBox(height: 15),
        _FirstNameField(controller: model.firstNameTextInputController),
        const SizedBox(height: 15),
        _SecondNameField(controller: model.secondNameTextInputController),
        const SizedBox(height: 15),
        _PatronymicField(controller: model.patronymicTextInputController),
        const SizedBox(height: 15),
      ],
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController? controller;
  const _PasswordField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
    );
  }
}

class _EmailField extends StatelessWidget {
  final TextEditingController? controller;
  const _EmailField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
    );
  }
}

class _FirstNameField extends StatelessWidget {
  final TextEditingController? controller;
  const _FirstNameField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: LocaleSwitcher.of(context)!.firstname,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return LocaleSwitcher.of(context)!.emptyfield;
        } else if (val.length > 50) {
          return LocaleSwitcher.of(context)!.toolong;
        }
        return null;
      },
    );
  }
}

class _SecondNameField extends StatelessWidget {
  final TextEditingController? controller;
  const _SecondNameField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: LocaleSwitcher.of(context)!.secondname,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return LocaleSwitcher.of(context)!.emptyfield;
        } else if (val.length > 50) {
          return LocaleSwitcher.of(context)!.toolong;
        }
        return null;
      },
    );
  }
}

class _PatronymicField extends StatelessWidget {
  final TextEditingController? controller;
  const _PatronymicField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: LocaleSwitcher.of(context)!.patronymic,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return LocaleSwitcher.of(context)!.emptyfield;
        } else if (val.length > 50) {
          return LocaleSwitcher.of(context)!.toolong;
        }
        return null;
      },
    );
  }
}

// class _RegisterButton extends StatelessWidget {
//   const _RegisterButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final model = context.watch<RegisterViewModel>();
//     //final model = context.watch<RegisterViewModel>();
//     //await model.addDate(selectedDate!);
//     // final onPressed = model.canStartAuth ? () => model.auth(context) : null;
//     // final child = model.isAuthProgress
//     //     ? const SizedBox(
//     //         width: 15,
//     //         height: 15,
//     //         child: CircularProgressIndicator(strokeWidth: 2),
//     //       )
//     //     : Text(LocaleSwitcher.of(context)!.signinbut);
//     // return ElevatedButton(
//     //   onPressed: onPressed,
//     //   child: child,
//     // );
//     return ElevatedButton(
//       onPressed: () {
//         model.register(context);
//       },
//       child: const Text("Register"),
//     );
//   }
// }

class _TitleInfo extends StatelessWidget {
  const _TitleInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleSwitcher.of(context)!.signuptitle,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage =
        context.select((RegisterViewModel m) => m.errorMessage);
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

class _LoginForgot extends StatelessWidget {
  const _LoginForgot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/forgot');
          },
          //onPressed: () {GoRouter.of(context).go('/forgot');},
          child: Text(LocaleSwitcher.of(context)!.forgot),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/auth');
          },
          //onPressed: () {GoRouter.of(context).go('/');},
          child: Text(LocaleSwitcher.of(context)!.signinbut),
        ),
      ],
    );
  }
}
