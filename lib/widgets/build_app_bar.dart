import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(

    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: const Text(
      'Quote in Note',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    ),
  );
}