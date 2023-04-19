import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:smartbridge/ui/utils.dart';
import 'package:smartbridge/ui/locales/locale_switcher.dart';
import 'package:smartbridge/ui/widgets/add_resume/add_resume_view_model.dart';
import 'package:dropdown_search/dropdown_search.dart';

// class AddResumeWidget extends StatefulWidget {
//   const AddResumeWidget({super.key});

//   @override
//   AddResumeState createState() => AddResumeState();
// }

// class AddResumeState extends State<AddResumeWidget> {
class AddResumeWidget extends StatelessWidget{

  const AddResumeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<AddResumeViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Добавить анкету"),
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
              const RegionWidget(),
              const SizedBox(height: 15),
              const SpecializationWidget(),
              const SizedBox(height: 15),
              const QualificationWidget(),
              const SizedBox(height: 15),
              const ScheduleWidget(),
              const SizedBox(height: 15),
              const IndustryWidget(),
              const SizedBox(height: 15),
              const CompanyTypeWidget(),
              const SizedBox(height: 15),
              const EmploymentWidget(),
              const SizedBox(height: 15),
              const SkillsWidget(),
              const SizedBox(height: 15),
              const SalaryWidget(),
              const SizedBox(height: 15),
              AboutField(controller: model.aboutInputController),
              const SizedBox(height: 15),
              ExperienceField(controller: model.experienceInputController),
              const SizedBox(height: 15),
              EducationField(controller: model.educationInputController),
              const SizedBox(height: 15),
              TelegramField(controller: model.telegramInputController),
              const SizedBox(height: 15),
              PhoneField(controller: model.phoneInputController),
              const SizedBox(height: 15),
              const DisabledWidget(),
              const _ErrorMessageWidget(),
              const _SaveButton(),
              //_buildSaveButton(context),
            ],
          ),
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<AddResumeViewModel>();
    final onPressed =
        model.canStartAdd ? () => model.saveResume(context, ) : null;
    final child = model.isAddProgress
        ? const SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(LocaleSwitcher.of(context)!.save);
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

class IndustryWidget extends StatelessWidget {
  const IndustryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AddResumeViewModel>();
    return DropdownSearch<String>(
      dropdownDecoratorProps: DropDownDecoratorProps(
        textAlignVertical: TextAlignVertical.center,
        dropdownSearchDecoration: InputDecoration(
          labelStyle: const TextStyle(fontSize: 17),
          labelText: "Индустрия",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onChanged: (value) {
        viewModel.updateIndustry(value.toString());
      },
      selectedItem: '---',
      items: const [
        'IT',
        'Finance',
        'Electronics',
        'Industrial',
        'Telecommunications',
        'Business',
        'Education'
      ],
    );
  }
}

class CompanyTypeWidget extends StatelessWidget {
  const CompanyTypeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AddResumeViewModel>();
    return DropdownSearch<String>(
      dropdownDecoratorProps: DropDownDecoratorProps(
        textAlignVertical: TextAlignVertical.center,
        dropdownSearchDecoration: InputDecoration(
          labelStyle: const TextStyle(fontSize: 17),
          labelText: "Тип компании",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onChanged: (value) {
        viewModel.updateCompanyType(value.toString());
      },
      selectedItem: '---',
      items: const ['startup', 'gov', 'accredited', 'commercialized'],
    );
  }
}

class EmploymentWidget extends StatelessWidget {
  const EmploymentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AddResumeViewModel>();
    return DropdownSearch<String>(
      dropdownDecoratorProps: DropDownDecoratorProps(
        textAlignVertical: TextAlignVertical.center,
        dropdownSearchDecoration: InputDecoration(
          labelStyle: const TextStyle(fontSize: 17),
          labelText: "Трудоустройство",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onChanged: (value) {
        viewModel.updateEmployment(value.toString());
      },
      selectedItem: '---',
      items: const ['full', 'partial', 'internship'],
    );
  }
}

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AddResumeViewModel>();
    return DropdownSearch<String>(
        dropdownDecoratorProps: DropDownDecoratorProps(
          textAlignVertical: TextAlignVertical.center,
          dropdownSearchDecoration: InputDecoration(
            labelStyle: const TextStyle(fontSize: 17),
            labelText: "График работы",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onChanged: (value) {
          viewModel.updateSchedule(value.toString());
        },
        selectedItem: '---',
        items: const [
          'full time',
          'epoch',
          'flexible',
          'part-time',
          'remote',
          'shift'
        ]);
  }
}

class QualificationWidget extends StatelessWidget {
  const QualificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AddResumeViewModel>();
    return DropdownSearch<String>(
      dropdownDecoratorProps: DropDownDecoratorProps(
        textAlignVertical: TextAlignVertical.center,
        dropdownSearchDecoration: InputDecoration(
          labelStyle: const TextStyle(fontSize: 17),
          labelText: "Квалификация",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onChanged: (value) {
        viewModel.updateQulification(value.toString());
      },
      selectedItem: "---",
      items: viewModel.qualifications,
    );
  }
}

class SkillsWidget extends StatelessWidget {
  const SkillsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AddResumeViewModel>();
    return DropdownSearch<String>.multiSelection(
      dropdownDecoratorProps: DropDownDecoratorProps(
        textAlignVertical: TextAlignVertical.center,
        dropdownSearchDecoration: InputDecoration(
          labelText: "Навыки",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onChanged: (value) {
        viewModel.updateSkills(value);
      },
      items: viewModel.skillsName,
    );
  }
}

class SpecializationWidget extends StatelessWidget {
  const SpecializationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AddResumeViewModel>();
    return DropdownSearch<String>(
      dropdownDecoratorProps: DropDownDecoratorProps(
        textAlignVertical: TextAlignVertical.center,
        dropdownSearchDecoration: InputDecoration(
          labelStyle: const TextStyle(fontSize: 17),
          labelText: "Специализация",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      popupProps: const PopupProps.menu(
        showSearchBox: true,
      ),
      onChanged: (value) {
        viewModel.updateSpecId(value.toString());
      },
      selectedItem: "---",
      items: viewModel.specializations,
    );
  }
}

class DisabledWidget extends StatelessWidget {
  const DisabledWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddResumeViewModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("Инвалидность"),
        Checkbox(
          value: viewModel.isDisabled,
          onChanged: (value) {
            viewModel.updateDisabled(value ?? false);
          },
        ),
      ],
    );
  }
}

class RegionWidget extends StatelessWidget {
  const RegionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddResumeViewModel>();
    return DropdownSearch<String>(
      dropdownDecoratorProps: DropDownDecoratorProps(
        textAlignVertical: TextAlignVertical.center,
        dropdownSearchDecoration: InputDecoration(
          labelText: "Регион",
          labelStyle: const TextStyle(fontSize: 17),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      popupProps: const PopupProps.menu(
        showSearchBox: true,
      ),
      onChanged: (value) {
        viewModel.updateRegionID(value.toString());
      },
      selectedItem: "---",
      items: viewModel.regions,
    );
  }
}

class SalaryWidget extends StatelessWidget {
  const SalaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        LowerSalary(),
        UpperSalary(),
      ],
    );
  }
}

class LowerSalary extends StatelessWidget {
  const LowerSalary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddResumeViewModel>();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 1),
          padding: const EdgeInsets.symmetric(vertical: 1),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: viewModel.onDecrementLowerButtonPressed,
                icon: const Icon(Icons.remove),
                color: Colors.white,
              ),
              Text(
                viewModel.lowerSalary.toString(),
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              IconButton(
                onPressed: viewModel.onIncrementLowerButtonPressed,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const Text("Минимальная ЗП"),
      ],
    );
  }
}

class UpperSalary extends StatelessWidget {
  const UpperSalary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddResumeViewModel>();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 1),
          padding: const EdgeInsets.symmetric(vertical: 1),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: viewModel.onDecrementUpperButtonPressed,
                icon: const Icon(Icons.remove),
                color: Colors.white,
              ),
              Text(
                viewModel.upperSalary.toString(),
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              IconButton(
                  onPressed: viewModel.onIncrementUpperButtonPressed,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
        const Text("Максимальная ЗП"),
      ],
    );
  }
}

class PhoneField extends StatelessWidget {
  final TextEditingController? controller;
  const PhoneField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: 'Phone: 7ХХХ*******',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      keyboardType: TextInputType.number,
      validator: (val) {
        if (val != null && val.isNotEmpty && (val.length != 11 || val[0] != '7')) {
          return "Некорректный номер телефона!";
        }
        return null;
      },
    );
  }
}

class TelegramField extends StatelessWidget {
  final TextEditingController? controller;
  const TelegramField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: '@Telegram',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (val) {
        if (val != null &&
            val.isNotEmpty &&
            (val.length > 33 || val.length < 6 || val[0] != "@")) {
          return "Некорректный ник telegram!";
        }
        return null;
      },
    );
  }
}

class EducationField extends StatelessWidget {
  final TextEditingController? controller;
  const EducationField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: 5,
      decoration: InputDecoration(
        //contentPadding: const EdgeInsets.symmetric(vertical: 40),
        hintText: 'Образование',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return LocaleSwitcher.of(context)!.emptyfield;
        } else if (val.length > 1000) {
          return LocaleSwitcher.of(context)!.toolong;
        }
        return null;
      },
    );
  }
}

class ExperienceField extends StatelessWidget {
  final TextEditingController? controller;
  const ExperienceField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: 5,
      decoration: InputDecoration(
        //contentPadding: const EdgeInsets.symmetric(vertical: 40),
        hintText: 'Опыт работы и проекты',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return LocaleSwitcher.of(context)!.emptyfield;
        } else if (val.length > 1000) {
          return LocaleSwitcher.of(context)!.toolong;
        }
        return null;
      },
    );
  }
}

class AboutField extends StatelessWidget {
  final TextEditingController? controller;
  const AboutField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: 5,
      decoration: InputDecoration(
        //contentPadding: const EdgeInsets.symmetric(vertical: 40),
        hintText: 'О себе',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return LocaleSwitcher.of(context)!.emptyfield;
        } else if (val.length > 1000) {
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
    final errorMessage =
        context.select((AddResumeViewModel m) => m.errorMessage);
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
