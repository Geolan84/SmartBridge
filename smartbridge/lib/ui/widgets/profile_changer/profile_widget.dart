import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartbridge/ui/locales/locale_switcher.dart';
import 'package:smartbridge/ui/widgets/profile_changer/profile_view_model.dart';
import 'package:smartbridge/ui/utils.dart';
import 'package:intl/intl.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  ProfileWidgetState createState() => ProfileWidgetState();
}

class ProfileWidgetState extends State<ProfileWidget> {
  DateTime? selectedDate;

  @override
  void initState(){
    print("InitState!");
    super.initState();
    Future.delayed(Duration.zero,() {
      initFields(context);
    });
  }

  Future<void> initFields(BuildContext context) async{
    final model = context.watch<ProfileViewModel>();
    await model.loadDetails(context);
  }

  _selectDate(BuildContext context) async {
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
        Text(
            " Select birthday: ${selectedDate == null ? '' : DateFormat.yMd().format(selectedDate!.toLocal())}"),
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
      appBar: AppBar(title: Text(LocaleSwitcher.of(context)!.editprofile), backgroundColor: Colors.red,),
      backgroundColor: Colors.white,
      body: //Center(child: 
      SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const _RegisterForm(),
                _buildBirthday(context),
                const _ErrorMessageWidget(),
                buildUpdateButton(context),
              ],
            ),
          ),
        ),
      //),
    );
  }

  Widget buildUpdateButton(BuildContext context) {
    final model = context.watch<ProfileViewModel>();
    return ElevatedButton(
      onPressed: () {
        //model.update(context, selectedDate);
      },
      child: Text(LocaleSwitcher.of(context)!.save),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<ProfileViewModel>();
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

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select((ProfileViewModel m) => m.errorMessage);
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
