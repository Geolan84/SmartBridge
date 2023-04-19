import 'package:smartbridge/ui/widgets/resume_viewer/resume_view_model.dart';
import 'package:smartbridge/ui/navigation/main_navigation.dart';
import 'package:url_launcher/url_launcher.dart';
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
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15.0),
                  child: InkWell(
                    child: const Icon(Icons.favorite),
                    onTap: (){
                      viewModel.changeFavorite();
                    })
                ),
              ]
            : [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15.0),
                  child: InkWell(
                    child: const Icon(Icons.edit),
                    onTap: (){
                      try {
                        Navigator.of(context).pushNamed(
                          MainNavigationRouteNames.userAddResume,
                        );
                      } catch (_) {}
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15.0),
                  child: InkWell(
                    child: const Icon(Icons.delete),
                    onTap: () {},
                  ),
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
                title: Text(
                  "${viewModel.resume!.qualification.toUpperCase()} ${viewModel.resume!.specName}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  "${viewModel.resume!.surname} ${viewModel.resume!.name} ${viewModel.resume?.patronymic}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text("Регион",
                    style:
                        TextStyle(color: Color.fromARGB(255, 104, 103, 103))),
                subtitle: Text(
                  viewModel.resume!.geoName,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.currency_ruble),
                title: const Text("Ожидаемая зарплата",
                    style:
                        TextStyle(color: Color.fromARGB(255, 104, 103, 103))),
                subtitle: Text(
                  "${viewModel.resume!.lowerSalary}-${viewModel.resume!.upperSalary}P",
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
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
              // ListTile(
              //   leading: const Icon(Icons.maximize),
              //   title: Text(
              //     "Опыт в годах: ${viewModel.resume!.experienceYears}",
              //     textAlign: TextAlign.start,
              //     style: const TextStyle(fontSize: 18, color: Colors.black),
              //   ),
              // ),
              ListTile(
                leading: const Icon(Icons.maximize),
                title: Text(
                  "Тип компании: ${viewModel.resume!.companyType}",
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.maximize),
                title: Text(
                  "График работы: ${viewModel.resume!.schedule}",
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.maximize),
                title: Text(
                  "Трудоустройство: ${viewModel.resume!.employment}",
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.maximize),
                title: Text(
                  "Индустрия: ${viewModel.resume!.industry}",
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.telegram),
                title: const Text("Telegram",
                    style:
                        TextStyle(color: Color.fromARGB(255, 104, 103, 103))),
                subtitle: InkWell(
                    child: Text(
                      viewModel.resume!.telegram,
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    onTap: () {
                      if (viewModel.resume!.telegram.isNotEmpty) {
                        var a =
                            "https://t.me/${viewModel.resume!.telegram.substring(1)}";
                        launchUrl(
                          Uri.parse(a),
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    }),
              ),
              ListTile(
                leading: const Icon(Icons.alternate_email),
                title: const Text("Email",
                    style:
                        TextStyle(color: Color.fromARGB(255, 104, 103, 103))),
                subtitle: InkWell(
                  child: Text(
                    viewModel.resume!.email,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  onTap: () {
                    final Uri params = Uri(
                        scheme: 'mailto',
                        path: viewModel.resume!.email,
                        queryParameters: {
                          'subject': 'SmartBridge',
                        });
                    launchUrl(params);
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.call),
                title: const Text("Телефон",
                    style:
                        TextStyle(color: Color.fromARGB(255, 104, 103, 103))),
                subtitle: InkWell(
                    child: Text(
                      "+${viewModel.resume!.phone}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    onTap: () {
                      if (viewModel.resume!.phone.isNotEmpty) {
                        final call =
                            Uri.parse('tel:+${viewModel.resume!.phone}');
                        launchUrl(
                          call,
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
