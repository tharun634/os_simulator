part of '../process_scheduling_view.dart';

extension on SchedulingAlgo {
  String get title {
    switch (this) {
      case SchedulingAlgo.sjf:
        return 'SJF';
      case SchedulingAlgo.fcfs:
        return 'FCFS';
      case SchedulingAlgo.srtf:
        return 'SRTF';
      case SchedulingAlgo.rr:
        return 'Round Robin';
    }
  }
}

class ProcessForm extends StatefulWidget {
  const ProcessForm({
    Key? key,
  }) : super(key: key);

  @override
  _ProcessFormState createState() => _ProcessFormState();
}

class _ProcessFormState extends State<ProcessForm>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProcessesManager>(
      builder: (context, manager, processAdder) {
        final isRrAlgo = manager.algo == SchedulingAlgo.rr;
        return Row(
          children: [
            Flexible(
              child: DropdownButtonFormField<SchedulingAlgo>(
                items: SchedulingAlgo.values
                    .map((a) => DropdownMenuItem(
                          value: a,
                          child: Text(a.title),
                        ))
                    .toList(),
                value: manager.algo,
                onChanged: (v) => manager.algo = v!,
              ),
            ),
            SizedBox(width: isRrAlgo ? 10 : 0),
            Flexible(
              flex: 0,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                vsync: this,
                child: isRrAlgo
                    ? NumberPicker(
                        minValue: 1,
                        value: manager.timeQuanta,
                        onChanged: (v) => manager.timeQuanta = v,
                      )
                    : const SizedBox(),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 2,
              child: processAdder!,
            ),
          ],
        );
      },
      child: const _ProcessAdder(),
    );
  }
}

class _ProcessAdder extends StatefulWidget {
  const _ProcessAdder({Key? key}) : super(key: key);

  @override
  __ProcessAdderState createState() => __ProcessAdderState();
}

class __ProcessAdderState extends State<_ProcessAdder> {
  final _formKey = GlobalKey<FormState>();

  int _arrivalTime = 0;
  int _burstTime = 0;

  bool _validate() {
    return _formKey.currentState?.validate() ?? false;
  }

  bool _validateAndAdd() {
    if (!_validate()) {
      return false;
    }

    _formKey.currentState!.save();
    context.read<ProcessesManager>().add(
          arrivalTime: _arrivalTime,
          burstTime: _burstTime,
        );

    return true;
  }

  String? _numberValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Field cannot be empty';
    }

    final number = int.tryParse(value!);
    if (number == null) {
      return 'Please enter a number';
    } else if (number.isNegative) {
      return 'Please enter a non-negative number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Arrival Time'),
              validator: _numberValidator,
              onSaved: (v) => _arrivalTime = int.parse(v!),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Burst Time',
                border: OutlineInputBorder(),
              ),
              validator: _numberValidator,
              onSaved: (v) => _burstTime = int.parse(v!),
            ),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: _validateAndAdd,
            child: const Icon(Icons.done),
          ),
        ],
      ),
    );
  }
}

class NumberPicker extends StatelessWidget {
  const NumberPicker({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.minValue,
  }) : super(key: key);

  final int value;
  final Function(int) onChanged;
  final int minValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: value == minValue ? null : () => onChanged(value - 1),
          child: const Icon(Icons.remove),
        ),
        Text('Time Quanta: $value'),
        TextButton(
          onPressed: () => onChanged(value + 1),
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
