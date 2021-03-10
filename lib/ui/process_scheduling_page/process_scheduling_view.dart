import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'processes_manager.dart';

part 'widgets/process_form.dart';
part 'widgets/processes_table.dart';
part 'widgets/schedule_result_widget.dart';

class ProcessSchedulingView extends StatefulWidget {
  @override
  _ProcessSchedulingViewState createState() => _ProcessSchedulingViewState();
}

class _ProcessSchedulingViewState extends State<ProcessSchedulingView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _anim;

  @override
  void initState() {
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _anim = CurvedAnimation(parent: _animController, curve: Curves.easeInOut);

    super.initState();
  }

  bool get _isAddOpen {
    switch (_animController.status) {
      case AnimationStatus.forward:
      case AnimationStatus.completed:
        return true;
      case AnimationStatus.reverse:
      case AnimationStatus.dismissed:
        return false;
    }
  }

  void _toggleAdd() {
    if (_isAddOpen) {
      _animController.reverse();
    } else {
      _animController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Process Scheduling'),
        elevation: 2,
        actions: [
          IconButton(
            onPressed: _toggleAdd,
            icon: RotationTransition(
              turns: _anim.drive(Tween(begin: 0, end: 3 / 8)),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Consumer<ProcessesManager>(
          builder: (context, manager, formWidget) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                formWidget!,
                ScheduleResultWidget(result: manager.result),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: ProcessesTable(
                        processes: manager.processes,
                        scheduledProcesses: manager.result.scheduledProcesses,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          child: SizeTransition(
            sizeFactor: _anim,
            axisAlignment: 1,
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: ProcessForm(),
            ),
          ),
        ),
      ),
    );
  }
}
