import 'package:flutter/material.dart';

// class FavoriteWidget extends StatelessWidget{
//   const FavoriteWidget({super.key});

//   @override
//   Widget build(BuildContext context){
//     return Scaffold(body: const Center(child: CircularProgressIndicator(),));
//   }
// }

import 'package:smartbridge/domain/models/resume.dart';
//import 'package:smartbridge/ui/widgets/resume_list/resume_list_view_model.dart';
import 'package:smartbridge/domain/repositories/resume_repository.dart';
import 'package:smartbridge/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class FavoriteResumeList extends StatefulWidget {
  const FavoriteResumeList({super.key});

  @override
  FavoriteResumeListState createState() => FavoriteResumeListState();
}

class FavoriteResumeListState extends State<FavoriteResumeList> {
  int stub = 0;

  Future<void> _someFunc() async {
    stub = 1;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        setState(() {});
        return _someFunc();
      },
      child: FutureBuilder<List<Resume>>(
        future: ResumeRepository().getFavoriteResumes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemExtent: 170,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    //print("Tapped $")
                    try {
                      Navigator.of(context).pushNamed(
                        MainNavigationRouteNames.userResumeView,
                        arguments: snapshot.data![index],
                      );
                    } catch (_) {}
                  },
                  child: Card(
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3,
                        color: Colors.green,
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
                                      snapshot.data![index].specName,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      snapshot.data![index].qualification
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child:
                                          Text(snapshot.data![index].geoName),
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
                            color: Colors.green,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Обновлено: ${getStringDate(snapshot.data![index].updatedAt)}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "ЗП от ${snapshot.data![index].lowerSalary.toString()} Р",
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
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  String getStringDate(String utcDate) {
    var castedDate = DateTime.parse(utcDate);
    return "${castedDate.day}/${castedDate.month}/${castedDate.year}";
  }
}
