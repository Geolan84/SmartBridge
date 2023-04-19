import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:smartbridge/ui/locales/locale_switcher.dart';
import 'package:smartbridge/ui/widgets/hr_search/hr_search_view_model.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<SearchViewModel>();
    return SingleChildScrollView(
        //reverse: true,
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(padding: EdgeInsets.only(bottom: 50, top: 40), child: Text("Найти соискателя", textAlign: TextAlign.center, style: TextStyle(fontSize: 30),),),
              RegionWidget(),
              SizedBox(height: 15),
              SpecializationWidget(),
              SizedBox(height: 15),
              QualificationWidget(),
              SizedBox(height: 15),
              ScheduleWidget(),
              SizedBox(height: 15),
              IndustryWidget(),
              SizedBox(height: 15),
              CompanyTypeWidget(),
              SizedBox(height: 15),
              EmploymentWidget(),
              SizedBox(height: 15),
              SkillsWidget(),
              SizedBox(height: 15),
              SalaryWidget(),
              SizedBox(height: 15),
              DisabledWidget(),
              _ErrorMessageWidget(),
              _SaveButton(),
            ],
          ),
        ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<SearchViewModel>();
    return ElevatedButton(
      onPressed: () {
        model.searchResumes(context);
      },
      child: const Text("Найти"),
    );
  }
}

class IndustryWidget extends StatelessWidget {
  const IndustryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<SearchViewModel>();
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
    final viewModel = context.read<SearchViewModel>();
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
    final viewModel = context.read<SearchViewModel>();
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
    final viewModel = context.read<SearchViewModel>();
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
    final viewModel = context.read<SearchViewModel>();
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
    final viewModel = context.read<SearchViewModel>();
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
    final viewModel = context.read<SearchViewModel>();
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
    final viewModel = context.watch<SearchViewModel>();
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
    final viewModel = context.watch<SearchViewModel>();
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
    final viewModel = context.watch<SearchViewModel>();
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
    final viewModel = context.watch<SearchViewModel>();
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

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select((SearchViewModel m) => m.errorMessage);
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
