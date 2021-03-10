import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'process_scheduling_view.dart';
import 'processes_manager.dart';

class ProcessSchedulingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProcessesManager(),
      child: ProcessSchedulingView(),
    );
  }
}
