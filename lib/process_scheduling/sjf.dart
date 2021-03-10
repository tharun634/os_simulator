import 'schedule_result.dart';

ScheduleResult sjf(List<Process> processes) {
  final sortedProcesses = List.of(processes)
    ..sort((p1, p2) {
      return p1.burstTime.compareTo(p2.burstTime);
    });

  final ganttChart = <Gantt>[];
  final scheduledProcesses = <int, ScheduledProcess>{};

  var totalTurnAroundTime = 0;
  var totalWaitingTime = 0;

  var time = 0;

  while (scheduledProcesses.length != sortedProcesses.length) {
    var didScheduleProcess = false;

    for (final process in sortedProcesses) {
      if (process.arrivalTime <= time &&
          !scheduledProcesses.containsKey(process.id)) {
        final stopTime = time + process.burstTime;

        ganttChart.add(Gantt(
          processId: process.id,
          startTime: time,
          stopTime: stopTime,
        ));

        time = stopTime;

        final scheduledProcess = ScheduledProcess(
          process: process,
          completionTime: time,
        );

        totalTurnAroundTime += scheduledProcess.turnAroundTime;
        totalWaitingTime += scheduledProcess.waitingTime;

        scheduledProcesses[process.id] = scheduledProcess;
        didScheduleProcess = true;
        break;
      }
    }

    if (!didScheduleProcess) {
      final stopTime = time + 1;
      ganttChart.add(Gantt(processId: -1, startTime: time, stopTime: stopTime));
      time = stopTime;
    }
  }

  return ScheduleResult(
    scheduledProcesses: scheduledProcesses,
    ganttChart: ganttChart,
    totalWaitingTime: totalWaitingTime,
    totalTurnAroundTime: totalTurnAroundTime,
  );
}
