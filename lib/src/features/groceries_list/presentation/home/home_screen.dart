import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopper/src/features/groceries_list/presentation/widgets/groceries_list_widget.dart';
import 'package:shopper/src/features/main_menu/main_menu.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _editMode = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;

      final Drawer? drawer;
      final Widget body;

      if (width > 600) {
        drawer = null;
        body = Row(
          children: [
            const SizedBox(
              width: 250,
              child: MenuList(),
            ),
            const VerticalDivider(
              width: 1,
            ),
            Expanded(child: GroceriesListWidget(editMode: _editMode, context: context)),
          ],
        );
      } else {
        drawer = const Drawer(
          child: MenuList(),
        );
        body = GroceriesListWidget(editMode: _editMode, context: context);
      }

      return Scaffold(
        drawer: drawer,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.appTitle),
          actions: [
            if (!_editMode)
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _toggleEditMode();
                },
              ),
            if (_editMode)
              TextButton(
                child: Text(AppLocalizations.of(context)!.doneButtonLabel,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary)),
                onPressed: () {
                  _toggleEditMode();
                },
              ),
          ],
        ),
        body: body,
      );
    });
  }

  void _toggleEditMode() {
    setState(() {
      _editMode = !_editMode;
    });
  }
}


