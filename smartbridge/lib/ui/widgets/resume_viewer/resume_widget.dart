import 'package:smartbridge/ui/widgets/resume_viewer/resume_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResumeWidget extends StatelessWidget {
  const ResumeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ResumeViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Анкета"),
        backgroundColor: Colors.red,
        actions: viewModel.is_hr
            ? [
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15.0),
                  child: Icon(Icons.favorite),
                ),
              ]
            : [
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15.0),
                  child: Icon(Icons.edit),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15.0),
                  child: Icon(Icons.delete),
                ),
              ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  minRadius: 70,
                  maxRadius: 95,
                  backgroundImage: viewModel.avatar.image),
              const SizedBox(height: 15),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text("О себе",
                    style:
                        TextStyle(color: Color.fromARGB(255, 104, 103, 103))),
                subtitle: Text(
                  viewModel.resume!.about,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: const Icon(Icons.school),
                title: const Text("Образование",
                    style:
                        TextStyle(color: Color.fromARGB(255, 104, 103, 103))),
                subtitle: Text(
                  viewModel.resume!.education,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: const Icon(Icons.folder_shared),
                title: const Text("Опыт и проекты",
                    style:
                        TextStyle(color: Color.fromARGB(255, 104, 103, 103))),
                subtitle: Text(
                  viewModel.resume!.experience,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: const Icon(Icons.telegram),
                title: Text(
                  viewModel.resume!.telegram,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              )
              // Text(viewModel.resume!.specName),
              // Text(viewModel.resume!.qualification),
              // //Text(viewModel.resume!)
              // Text(viewModel.resume!.about),
              // Text(viewModel.resume!.experience),
              // Text(viewModel.resume!.experienceYears.toString()),
              // Text(viewModel.resume!.geoName),
              // Text(viewModel.resume!.schedule),
              // Text(viewModel.resume!.companyType),
              // Text(viewModel.resume!.employment),
              // Text(viewModel.resume!.industry),
              // Text(viewModel.resume!.specName),
            ],
          ),
        ),
      ),
    );
  }
}
