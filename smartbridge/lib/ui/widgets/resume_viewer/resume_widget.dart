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
            actions: const [
              Padding(
                padding: EdgeInsets.only(left:15, right: 15.0),
                child: Icon(Icons.edit),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15.0),
                child: Icon(Icons.delete),
              ),
            ]),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                viewModel.canStartShow
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const CircleAvatar(),
                Text(viewModel.resume!.specName),
                Text(viewModel.resume!.qualification),
                //Text(viewModel.resume!)
                Text(viewModel.resume!.about),
                Text(viewModel.resume!.experience),
                Text(viewModel.resume!.experienceYears.toString()),
                Text(viewModel.resume!.geoName),
                Text(viewModel.resume!.schedule),
                Text(viewModel.resume!.companyType),
                Text(viewModel.resume!.employment),
                Text(viewModel.resume!.industry),
                Text(viewModel.resume!.specName),
              ],
            ),
          ),
        ));
  }
}
