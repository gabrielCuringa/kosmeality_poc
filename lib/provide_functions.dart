import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showLoader(BuildContext context) {
  Provider.of<List<Function>>(context)[0]();
}

void hideLoader(BuildContext context) {
  Provider.of<List<Function>>(context)[1]();
}
