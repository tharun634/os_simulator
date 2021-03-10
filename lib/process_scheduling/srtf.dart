import 'package:collection/collection.dart';

import 'schedule_result.dart';

ScheduleResult srtf(List<Process> processes) {
  final sortedProcesses = List.of(processes)
    ..sort((p1, p2) => p1.arrivalTime.compareTo(p2.arrivalTime));

  final remainingBurstTime = {
    for (final process in sortedProcesses) process.id: process.burstTime
  };

  final priorityQ = PriorityQueue<Process>((p1, p2) =>
      remainingBurstTime[p1.id]!.compareTo(remainingBurstTime[p2.id]!));
  final processesAddedToQ = <int>{};

  final ganttChart = <Gantt>[];
  final scheduledProcesses = <int, ScheduledProcess>{};

  var totalTurnAroundTime = 0;
  var totalWaitingTime = 0;

  var time = 0;

  while (scheduledProcesses.length != sortedProcesses.length) {
    for (final process in sortedProcesses) {
      if (process.arrivalTime <= time &&
          !processesAddedToQ.contains(process.id)) {
        priorityQ.add(process);
        processesAddedToQ.add(process.id);
      }
    }

    final stopTime = time + 1;

    if (priorityQ.isEmpty) {
      ganttChart.add(Gantt.idle(startTime: time, stopTime: stopTime));
    } else {
      final process = priorityQ.removeFirst();
      final remainingBt = remainingBurstTime[process.id]!;
      if (remainingBt == 1) {
        ganttChart.add(Gantt(
          processId: process.id,
          startTime: time,
          stopTime: stopTime,
        ));

        remainingBurstTime[process.id] = 0;

        final scheduledProcess = ScheduledProcess(
          process: process,
          completionTime: stopTime,
        );

        scheduledProcesses[process.id] = scheduledProcess;

        totalTurnAroundTime += scheduledProcess.turnAroundTime;
        totalWaitingTime += scheduledProcess.waitingTime;
      } else {
        remainingBurstTime[process.id] = remainingBt - 1;

        ganttChart.add(Gantt(
          processId: process.id,
          startTime: time,
          stopTime: stopTime,
        ));

        priorityQ.add(process);
      }
    }

    time = stopTime;
  }

  return ScheduleResult(
    scheduledProcesses: scheduledProcesses,
    ganttChart: ganttChart,
    totalWaitingTime: totalWaitingTime,
    totalTurnAroundTime: totalTurnAroundTime,
  );
}
