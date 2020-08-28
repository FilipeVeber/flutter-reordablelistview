import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_reordablelistview/entity/task.dart';
import 'package:flutter_reordablelistview/store/task_store.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TaskStore store;

  @override
  void initState() {
    store = TaskStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reordable List View"),
        actions: <Widget>[
          IconButton(
            tooltip: "Reset list",
            icon: Icon(Icons.sync),
            onPressed: store.resetTaskList,
          )
        ],
      ),
      body: Observer(
        builder: (BuildContext context) {
          return ReorderableListView(
            scrollDirection: Axis.vertical,
            children: _buildList(),
            onReorder: store.onReorder,
          );
        },
      ),
    );
  }

  List<Widget> _buildList() {
    return store.tasks
        .map((task) => Card(
              key: ValueKey(task),
              child: InkWell(
                child: _buildListTile(task),
                onTap: () {},
              ),
            ))
        .toList();
  }

  Widget _buildListTile(Task task) {
    return ListTile(
      key: ValueKey(task),
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: Icon(Icons.reorder),
    );
  }
}
