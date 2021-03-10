class ScheduleResult {
  ScheduleResult({
    required this.scheduledProcesses,
    required this.ganttChart,
    required this.totalWaitingTime,
    required this.totalTurnAroundTime,
  });

  factory ScheduleResult.zero() {
    return ScheduleResult(
      scheduledProcesses: const {},
      ganttChart: const [],
      totalWaitingTime: 0,
      totalTurnAroundTime: 0,
    );
  }

  final Map<int, ScheduledProcess> scheduledProcesses;
  final List<Gantt> ganttChart;
  final int totalWaitingTime;
  final int totalTurnAroundTime;

  double get averageWaitingTime => totalWaitingTime / scheduledProcesses.length;

  double get averageTurnAroundTime =>
      totalTurnAroundTime / scheduledProcesses.length;
}

class Gantt {
  const Gantt({
    required this.processId,
    required this.startTime,
    required this.stopTime,
  });

  factory Gantt.idle({
    required int startTime,
    required int stopTime,
  }) {
    return Gantt(
      processId: kIdleProcessId,
      startTime: startTime,
      stopTime: stopTime,
    );
  }

  static const kIdleProcessId = -1;

  bool get isIdle => processId == kIdleProcessId;

  final int processId;
  final int startTime;
  final int stopTime;
}

class ScheduledProcess {
  ScheduledProcess({
    required this.process,
    required this.completionTime,
  });

  final Process process;
  final int completionTime;

  int get turnAroundTime => completionTime - process.arrivalTime;
  int get waitingTime => turnAroundTime - process.burstTime;
}

class Process {
  Process({
    required this.id,
    required this.arrivalTime,
    required this.burstTime,
  });

  final int id;
  final int arrivalTime;
  final int burstTime;
}
