import 'package:flutter/material.dart';
import 'package:pubchem/flavors/build_config.dart';
import 'package:logger/logger.dart';


mixin BaseWidgetMixin on StatelessWidget {
  final Logger logger = BuildConfig.instance.config.logger;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: body(context),
    );
  }

  Widget body(BuildContext context);
}
