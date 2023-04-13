import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartbridge/ui/widgets/add_template/add_template_view_model.dart';

class AddTemplateWidget extends StatelessWidget {
  const AddTemplateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<AddTemplateViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Добавить шаблон"),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //reverse: true,
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 15),
              TitleField(controller: model.titleInputController),
              const SizedBox(height: 15),
              BodyField(controller: model.bodyInputController),
              const SizedBox(height: 15),
              const _ErrorMessageWidget(),
              const SizedBox(height: 15),
              const _SaveButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleField extends StatelessWidget {
  final TextEditingController? controller;
  const TitleField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: 'Название',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (val) {
        if (val != null &&
            val.isNotEmpty &&
            (val.length > 100)) {
          return "Слишком длинное!";
          //return LocaleSwitcher.of(context)!.toolong;
        }
        return null;
      },
    );
  }
}

class BodyField extends StatelessWidget {
  final TextEditingController? controller;
  const BodyField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 10,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: 'Текст',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (val) {
        if (val != null &&
            val.isNotEmpty &&
            (val.length > 1000)) {
          return "Слишком длинное!";
          //return LocaleSwitcher.of(context)!.toolong;
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
    final errorMessage =
        context.select((AddTemplateViewModel m) => m.errorMessage);
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

class _SaveButton extends StatelessWidget {
  const _SaveButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<AddTemplateViewModel>();
    return ElevatedButton(
      onPressed: (){model.saveTemplate(context);},
      child: const Text("Сохранить"),
    );
  }
}