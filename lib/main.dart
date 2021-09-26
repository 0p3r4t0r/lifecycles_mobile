import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('LifeCycles'),
        ),
        body: const ActivityListView(),
      ),
    );
  }
}

class Activity {
  String exerciseName = '';
  int weight = 0;
  int reps = 0;
  int sets = 0;
}

class ActivityListItem extends StatefulWidget {
  final int index;
  final Activity activity;

  const ActivityListItem(
      {required this.index, required this.activity, Key? key})
      : super(key: key);

  @override
  State<ActivityListItem> createState() => _ActivityListItemState();
}

class _ActivityListItemState extends State<ActivityListItem> {
  @override
  Widget build(BuildContext context) {
    // Text Controllers ========================================================
    final exerciseNameController = TextEditingController(
      text: widget.activity.exerciseName,
    );
    final weightController = TextEditingController(
      text: widget.activity.weight.toString(),
    );
    final repsController = TextEditingController(
      text: widget.activity.reps.toString(),
    );
    final setsController = TextEditingController(
      text: widget.activity.sets.toString(),
    );

    // Colors ==================================================================
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color eventItemColor = colorScheme.primary.withOpacity(0.15);
    return Container(
      key: Key('$widget.index'),
      color: widget.index.isOdd ? oddItemColor : eventItemColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              controller: exerciseNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Exercise Name',
              ),
              onSubmitted: (String value) {
                widget.activity.exerciseName = value;
                exerciseNameController.text = value;
              },
            ),
          ),
          Expanded(
            child: TextField(
              controller: weightController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'kg',
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (String value) {
                widget.activity.weight = int.parse(value);
                weightController.text = value;
              },
            ),
          ),
          Expanded(
            child: TextField(
              controller: repsController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Reps',
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (String value) {
                widget.activity.reps = int.parse(value);
                repsController.text = value;
              },
            ),
          ),
          Expanded(
            child: TextField(
              controller: setsController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Sets',
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (String value) {
                widget.activity.sets = int.parse(value);
                setsController.text = value;
              },
            ),
          ),
          Expanded(
            child: Icon(Icons.drag_handle),
          )
        ],
      ),
    );
  }
}

class ActivityListView extends StatefulWidget {
  const ActivityListView({Key? key}) : super(key: key);

  @override
  State<ActivityListView> createState() => _ActivityListViewState();
}

class _ActivityListViewState extends State<ActivityListView> {
  final _activities = List<Activity>.generate(10, (int _) => Activity());

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children: <Widget>[
        for (int index = 0; index < _activities.length; index++)
          ActivityListItem(
            key: Key("$index"),
            index: index,
            activity: _activities[index],
          )
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final Activity activity = _activities.removeAt(oldIndex);
          _activities.insert(newIndex, activity);
        });
      },
    );
  }
}
