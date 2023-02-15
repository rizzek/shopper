import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:shopper/src/app_state/remote_credential_store.dart';
import 'package:webdav_client/webdav_client.dart' as webdav;

class SyncSelectionDialog extends StatefulWidget {
  const SyncSelectionDialog({Key? key, required this.storedSettings})
      : super(key: key);

  final StorageSettings storedSettings;

  @override
  State<SyncSelectionDialog> createState() => _SyncSelectionDialogState();
}

class _SyncSelectionDialogState extends State<SyncSelectionDialog> {
  late RemoteStore _selectedStore;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedStore = widget.storedSettings.store;
    _urlController.text = widget.storedSettings.url;
    _userNameController.text = widget.storedSettings.username;
    _passwordController.text = widget.storedSettings.password;
  }

  @override
  Widget build(BuildContext context) {
    final Widget dialogContent;
    switch (_selectedStore) {
      case RemoteStore.webdav:
      case RemoteStore.nextcloud:
        dialogContent = _buildEditor(context);
        break;
      case RemoteStore.none:
        dialogContent = _buildSelection(context);
        break;
    }

    return AnimatedSize(
      clipBehavior: Clip.antiAlias,
      duration: const Duration(milliseconds: 200),
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Set Up Sync", style: Theme.of(context).textTheme.headline3),
              const Text("Set up a service to use for synchronization."),
              const SizedBox(
                height: 12.0,
              ),
              AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: dialogContent),

              // ElevatedButton(
              //     onPressed: () async {
              //       // var client = webdav.newClient(
              //       //     "https://rizzek.com/nextcloud/remote.php/dav/files/rizzek/",
              //       //     user: "rizzek",
              //       //     password: "5%6udLZ6o%w^xGVHnMPKmmiCvb&pzo^P7U6Bi%A!");
              //       // // client.ping();
              //       // final files = await client.readDir("/");
              //       // print("Accessing WebDAV root...");
              //       // files.forEach((element) {
              //       //   print(element.path);
              //       // });
              //     },
              //     child: Text("Disable")),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelection(BuildContext context) {
    return Column(
      key: const ValueKey(3),
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedStore = RemoteStore.webdav;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Center(
              child: Row(
                children: const [
                  Icon(
                    Icons.folder_rounded,
                    size: 64,
                  ),
                  SizedBox(width: 12.0),
                  Text(
                    "WebDav",
                    textScaleFactor: 1.2,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedStore = RemoteStore.nextcloud;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Center(
              child: Row(
                children: const [
                  Icon(
                    Icons.cloud_circle,
                    size: 64,
                  ),
                  SizedBox(width: 12.0),
                  Text(
                    "NextCloud",
                    textScaleFactor: 1.2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditor(BuildContext context) {
    final String urlLabel;
    switch (_selectedStore) {
      case RemoteStore.webdav:
        urlLabel = AppLocalizations.of(context)!.webdavUrl;
        break;
      case RemoteStore.nextcloud:
        urlLabel = AppLocalizations.of(context)!.nextcloudUrl;
        break;
      case RemoteStore.none:
        urlLabel = "";
        break;
    }

    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: Text(urlLabel),
              ),
              controller: _urlController,
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: Text(AppLocalizations.of(context)!.username),
              ),
              controller: _userNameController,
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: Text(AppLocalizations.of(context)!.password),
              ),
              controller: _passwordController,
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () {},
                label: Text(AppLocalizations.of(context)!.syncButton_test),
                icon: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(
                    Icons.check_circle_rounded,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                      onPressed: null,
                      label: Text(AppLocalizations.of(context)!.cancel),
                      icon: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Icon(
                          Icons.cancel,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).errorColor)),
                ),
                const SizedBox(
                  width: 24.0,
                ),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: null,
                    label: Text(AppLocalizations.of(context)!.save),
                    icon: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Icon(
                        Icons.save_rounded,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
