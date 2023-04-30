import 'package:career_paddy/services/progress.dart';
import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  void initState() {
    ProgressService.show(context);
    super.initState();
  }

  @override
  void dispose() {
    ProgressService.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
