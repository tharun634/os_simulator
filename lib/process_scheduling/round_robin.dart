import 'dart:collection';

import 'schedule_result.dart';

ScheduleResult roundRobin(List<Process> processes, int timeQuanta) {
  if (processes.isEmpty) {
    return ScheduleResult.zero();
  }

  final sortedProcesses = List.of(processes)
    ..sort((p1, p2) => p1.arrivalTime.compareTo(p2.arrivalTime));

  var totalTurnAroundTime = 0;
  var totalWaitingTime = 0;

  final scheduledProcesses = <int, ScheduledProcess>{};
  final ganttChart = <Gantt>[];

  final processQ = Queue<Process>();
  final processesAddedToQ = <int>{};

  final remainingBurstTime = {
    for (final process in sortedProcesses) process.id: process.burstTime
  };

  var time = 0;

  while (scheduledProcesses.length != sortedProcesses.length) {
    for (final process in sortedProcesses) {
      if (process.arrivalTime <= time &&
          !processesAddedToQ.contains(process.id)) {
        processQ.addLast(process);
        processesAddedToQ.add(process.id);
      }
    }

    late final int stopTime;

    if (processQ.isEmpty) {
      stopTime = time + 1;
      ganttChart.add(Gantt.idle(startTime: time, stopTime: stopTime));
    } else {
      final process = processQ.removeFirst();
      final remainingBt = remainingBurstTime[process.id]!;
      if (remainingBt <= timeQuanta) {
        stopTime = time + remainingBt;

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
        stopTime = time + timeQuanta;
        remainingBurstTime[process.id] = remainingBt - timeQuanta;

        ganttChart.add(Gantt(
          processId: process.id,
          startTime: time,
          stopTime: stopTime,
        ));

        processQ.addLast(process);
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
