import 'package:flutter/material.dart';
import 'package:wtfc_provider_app/auth/model/auth_menu_item_model.dart';

//https://youtu.be/JggTBrvVrk8
class AuthMenuItems {
  static final List<AuthMenuItemModel> itemsFirst = [
    itemSettings,
    itemShare,
  ];
  //separate this, because we want to add a border above this line
  static final List<AuthMenuItemModel> itemsSecond = [itemSignOut];

  static const itemSettings = AuthMenuItemModel(
    text: 'Settings',
    icon: Icons.settings,
  );
  static const itemShare = AuthMenuItemModel(
    text: 'Share',
    icon: Icons.share,
  );
  static const itemSignOut = AuthMenuItemModel(
    text: 'Sign Out',
    icon: Icons.logout,
  );
}
