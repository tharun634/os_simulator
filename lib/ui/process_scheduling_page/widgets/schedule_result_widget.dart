part of '../process_scheduling_view.dart';

class ScheduleResultWidget extends StatelessWidget {
  const ScheduleResultWidget({Key? key, required this.result})
      : super(key: key);

  final ScheduleResult result;

  Color _getColor(int processId) {
    return Colors.accents[
        (processId + (processId.isEven ? 2 : 7)) % Colors.accents.length];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          Flexible(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.black,
              ),
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(4),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey.shade200,
                ),
                clipBehavior: Clip.antiAlias,
                child: Row(
                  children: [
                    for (final gantt in result.ganttChart)
                      Flexible(
                        flex: gantt.stopTime - gantt.startTime,
                        child: gantt.processId == -1
                            ? Container()
                            : Container(
                                color: _getColor(gantt.processId),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    gantt.processId.toString(),
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                              ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: _InfoTile(
                      label: 'Avg. Turn Around Time',
                      value: result.averageTurnAroundTime.toStringAsFixed(2),
                    ),
                  ),
                  Expanded(
                    child: _InfoTile(
                      label: 'Avg. Waiting Time',
                      value: result.averageWaitingTime.toStringAsFixed(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      title: Text(
        label,
        overflow: TextOverflow.ellipsis,
        style: textTheme.headline6,
      ),
      trailing: Text(
        value,
        style: textTheme.headline6,
      ),
    );
  }
}
