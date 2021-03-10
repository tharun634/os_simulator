import 'schedule_result.dart';

ScheduleResult fcfs(List<Process> processes) {
  final sortedProcesses = List.of(processes)
    ..sort((p1, p2) => p1.arrivalTime.compareTo(p2.arrivalTime));

  if (sortedProcesses.isEmpty) {
    return ScheduleResult.zero();
  }

  var totalTurnAroundTime = 0;
  var totalWaitingTime = 0;

  final ganttChart = <Gantt>[];
  final scheduledProcesses = <int, ScheduledProcess>{};

  var time = 0;

  for (final process in sortedProcesses) {
    if (time < process.arrivalTime) {
      ganttChart.add(Gantt.idle(
        startTime: time,
        stopTime: process.arrivalTime,
      ));
      time = process.arrivalTime;
    }

    final stopTime = time + process.burstTime;

    ganttChart.add(Gantt(
      processId: process.id,
      startTime: time,
      stopTime: stopTime,
    ));

    final scheduledProcess = ScheduledProcess(
      process: process,
      completionTime: stopTime,
    );

    scheduledProcesses[process.id] = scheduledProcess;

    time = stopTime;
    totalTurnAroundTime += scheduledProcess.turnAroundTime;
    totalWaitingTime += scheduledProcess.waitingTime;
  }

  return ScheduleResult(
    scheduledProcesses: scheduledProcesses,
    ganttChart: ganttChart,
    totalWaitingTime: totalWaitingTime,
    totalTurnAroundTime: totalTurnAroundTime,
  );
}
