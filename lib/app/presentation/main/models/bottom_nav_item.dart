import 'package:flutter/material.dart';
import 'package:pubchem/app/core/values/app_icons.dart';
import 'menu_code.dart';

class BottomNavItem {
  final String navTitle;
  late final bool _isIconFromIconData;
  bool get isIconFromIconData => _isIconFromIconData;
  IconData? _activeIconData;
  IconData get activeIconData =>
      _activeIconData ?? Icons.image_not_supported_outlined;
  IconData? _regularIconData;
  IconData get regularIconData =>
      _regularIconData ?? Icons.image_not_supported_outlined;
  String? _activeAssetIcon;
  String get activeAssetIcon => _activeAssetIcon ?? AppIcons.placeholder;
  String? _regularAssetIcon;
  String get regularAssetIcon => _regularAssetIcon ?? AppIcons.placeholder;
  final MenuCode menuCode;

  BottomNavItem.fromIconData({
    required this.navTitle,
    required IconData activeIcon,
    required IconData regularIcon,
    required this.menuCode,
  }) {
    _isIconFromIconData = true;
    _activeIconData = activeIcon;
    _regularIconData = regularIcon;
  }

  BottomNavItem.fromAsset({
    required this.navTitle,
    required String activeIcon,
    required String regularIcon,
    required this.menuCode,
  }) {
    _isIconFromIconData = false;
    _activeAssetIcon = activeIcon;
    _regularAssetIcon = regularIcon;
  }
}
