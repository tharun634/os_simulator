import 'package:flutter/foundation.dart';

import '../../process_scheduling/process_scheduling.dart';
export '../../process_scheduling/process_scheduling.dart';

enum SchedulingAlgo {
  sjf,
  fcfs,
  srtf,
  rr,
}

class ProcessesManager extends ChangeNotifier {
  final _processes = <Process>[];
  List<Process> get processes => List.of(_processes);

  ScheduleResult result = ScheduleResult.zero();

  SchedulingAlgo _algo = SchedulingAlgo.sjf;
  SchedulingAlgo get algo => _algo;
  set algo(SchedulingAlgo v) {
    if (algo != v) {
      _algo = v;
      notifyListeners();
    }
  }

  int _timeQuanta = 1;
  int get timeQuanta => _timeQuanta;
  set timeQuanta(int v) {
    if (timeQuanta != v) {
      _timeQuanta = v;
      notifyListeners();
    }
  }

  void add({required int arrivalTime, required int burstTime}) {
    _processes.add(Process(
      id: _processes.length,
      arrivalTime: arrivalTime,
      burstTime: burstTime,
    ));
    notifyListeners();
  }

  @override
  void notifyListeners() {
    switch (algo) {
      case SchedulingAlgo.sjf:
        result = sjf(_processes);
        break;
      case SchedulingAlgo.fcfs:
        result = fcfs(_processes);
        break;
      case SchedulingAlgo.srtf:
        result = srtf(_processes);
        break;
      case SchedulingAlgo.rr:
        result = roundRobin(_processes, timeQuanta);
        break;
      default:
    }
    super.notifyListeners();
  }
}
