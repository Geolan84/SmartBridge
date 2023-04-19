import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:smartbridge/ui/locales/locale_switcher.dart';
import 'package:smartbridge/domain/repositories/auth_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartbridge/ui/navigation/main_navigation.dart';
import 'package:provider/provider.dart';
import 'package:smartbridge/ui/widgets/settings/settings_view_model.dart';
import 'dart:async';
import 'dart:io';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SettingsViewModel>();
    return Column(children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: GestureDetector(
            onTap: () {
              _getFromGallery(context);
            },
            child: CircleAvatar(
              minRadius: 50,
              maxRadius: 75,
              backgroundImage: model.avatar.image,
            ),
          ),
        ),
      ),
      const _ErrorMessageWidget(),
      Expanded(
        child: SettingsList(
          lightTheme: const SettingsThemeData(
              settingsListBackground: Color.fromARGB(1, 250, 250, 250)),
          sections: [
            SettingsSection(
                title: const Text('Настройки профиля'),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                      leading: const Icon(Icons.settings),
                      title: const Text("Изменить данные профиля"),
                      onPressed: (context) {
                        try {
                          Navigator.of(context).pushNamed(
                            MainNavigationRouteNames.userProfileSettings,
                          );
                        } catch (_) {}
                      }),
                  SettingsTile.navigation(
                    leading: const Icon(Icons.delete_forever),
                    title: const Text("Удалить профиль"),
                    onPressed: (context) {
                      //model.deleteProfile(context);
                      _dialogBuilder(context);
                    },
                  )
                ]),
            SettingsSection(
              title: const Text('Прочие'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: const Icon(Icons.info),
                  title: Text(LocaleSwitcher.of(context)!.help),
                  onPressed: (context) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(LocaleSwitcher.of(context)!.help),
                          content: Text(LocaleSwitcher.of(context)!.helpbody),
                        );
                      },
                    );
                  },
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.exit_to_app),
                  title: Text(LocaleSwitcher.of(context)!.quit),
                  onPressed: (context) {
                    var authService = AuthRepository();
                    authService.logout();
                    Navigator.of(context).pushReplacementNamed(
                        MainNavigationRouteNames.loaderWidget);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ]);
  }

  Future<void> _dialogBuilder(BuildContext context) {
    final model = context.read<SettingsViewModel>();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Удаление профиля'),
          content: const Text(
              'Ваш профиль будет безвозвратно удалён вместе со всеми анкетами. Вы уверены, что хотите удалить свой профиль?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Удалить'),
              onPressed: () {
                model.deleteProfile(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Future<XFile?> _getFromGallery(BuildContext context) async {
  //   final ImagePicker picker = ImagePicker();
  //   final img = await picker.pickImage(source: ImageSource.gallery);
  //   final model = context.read<SettingsViewModel>();
  //   print(await model.uploadPhoto(img));
  //   if (img != null) {
  //     setState(() {
  //       _image = File(img.path);
  //     });
  //   }
  // }

  Future<void> _getFromGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    final model = context.read<SettingsViewModel>();
    await model.uploadPhoto(img);
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage =
        context.select((SettingsViewModel m) => m.errorMessage);
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
