import 'package:smartbridge/ui/widgets/hr_resume_list/hr_resume_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:smartbridge/ui/navigation/main_navigation.dart';
import 'package:provider/provider.dart';
import 'package:smartbridge/ui/utils.dart';

class HrResumeListWidget extends StatelessWidget {
  const HrResumeListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ResumeListHRViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Результат поиска"),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemExtent: 140,
          itemCount: viewModel.resume.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                //print("Tapped $")
                try {
                  Navigator.of(context).pushNamed(
                    MainNavigationRouteNames.userResumeView,
                    arguments: viewModel.resume[index],
                  );
                } catch (_) {}
              },
              child: Card(
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    width: 3,
                    color: Colors.red,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.person_pin,
                              size: 100,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  viewModel.resume[index].specName,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  viewModel.resume[index].qualification
                                      .toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 200.0,
                                  child: Text(
                                    viewModel.resume[index].geoName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        //fontSize: 20.0
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Footer with data and salary
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Обновлено: ${getStringDate(viewModel.resume[index].updatedAt)}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              "ЗП от ${viewModel.resume[index].lowerSalary.toString()} Р",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
            // return Container(
            //   padding: const EdgeInsets.symmetric(vertical: 10),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(viewModel.resume[index].qualification,
            //           style: const TextStyle(fontSize: 22)),
            //       Text("Возраст: ${viewModel.resume[index].specName}",
            //           style: const TextStyle(fontSize: 18))
            //     ],
            //   ),
            // );
          }),
      //),
    );
  }
}
