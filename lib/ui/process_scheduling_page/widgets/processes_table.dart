part of '../process_scheduling_view.dart';

class ProcessesTable extends StatelessWidget {
  const ProcessesTable({
    Key? key,
    required this.processes,
    required this.scheduledProcesses,
  }) : super(key: key);

  final List<Process> processes;
  final Map<int, ScheduledProcess> scheduledProcesses;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataCol('ID'),
        DataCol('Arrival Time'),
        DataCol('Burst Time'),
        DataCol('Completion Time'),
        DataCol('Turn Around Time'),
        DataCol('Waiting Time'),
      ],
      rows: [
        for (var i = 0; i < processes.length; ++i)
          DataRow(
            cells: [
              DataCell(Text(i.toString())),
              DataCell(Text('${processes[i].arrivalTime}')),
              DataCell(Text('${processes[i].burstTime}')),
              DataCell(Text('${scheduledProcesses[i]!.completionTime}')),
              DataCell(Text('${scheduledProcesses[i]!.turnAroundTime}')),
              DataCell(Text('${scheduledProcesses[i]!.waitingTime}')),
            ],
          ),
      ],
    );
  }
}

class DataCol extends DataColumn {
  DataCol(String title)
      : super(label: Text(title, overflow: TextOverflow.ellipsis));
}
