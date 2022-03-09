import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuList extends StatelessWidget {
  const MenuList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      style: ListTileStyle.drawer,
      child: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: DrawerHeader(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,

                  image: const DecorationImage(
                      image: AssetImage("assets/images/shopper-256.png"))),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  AppLocalizations.of(context)!.appTitle,
                  style: Theme.of(context).textTheme.headline5?.copyWith(shadows: [const Shadow(color: Colors.black, blurRadius: 3.0)]),
                ),
              ),
            ),
          ),
          ListTile(title: Text('Shopping List'), onTap: () {},),
          ListTile(title: Text(AppLocalizations.of(context)!.settings), onTap: () {},),
          ListTile(title: Text('About'), onTap: () {},),
        ],
      ),
    );
  }
}
