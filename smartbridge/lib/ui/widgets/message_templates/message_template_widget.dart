import 'package:flutter/material.dart';
import 'package:smartbridge/ui/navigation/main_navigation.dart';
import 'package:smartbridge/domain/models/template.dart';
import 'package:smartbridge/domain/repositories/message_repository.dart';
import 'package:clipboard/clipboard.dart';

class MessageTemplateWidget extends StatefulWidget {
  const MessageTemplateWidget({super.key});

  @override
  TemplateWidgetState createState() => TemplateWidgetState();
}

class TemplateWidgetState extends State<MessageTemplateWidget> {
  int stub = 0;
  final _messageService = MessageRepository();

  Future<void> _deleteTemplate(int templateId) async {
    await _messageService.deleteTemplate(templateId);
    setState(() {
      stub = 0;
    });
  }

  Future<void> _someFunc() async {
    stub = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          try {
            Navigator.of(context).pushNamed(
              MainNavigationRouteNames.hrAddTemplate,
            );
          } catch (_) {}
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {});
          return _someFunc();
        },
        child: FutureBuilder<List<Template>>(
            future: _messageService.getTemplates(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8, top: 8),
                        child: ListTile(
                          onLongPress: () {
                            FlutterClipboard.copy(snapshot.data![index].body);
                          },
                          onTap: () {
                            _deleteTemplate(snapshot.data![index].template_id);
                          },
                          trailing: const Icon(Icons.delete),
                          title: Text(
                            snapshot.data![index].title,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 118, 118, 118),
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data![index].body,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
