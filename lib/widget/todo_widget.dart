import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/page/edit_todo_page.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/utils.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Slidable(
          startActionPane: ActionPane(motion: ScrollMotion(), children: [
            SlidableAction(
              onPressed: (context) {
                editTodo(context, todo);
              },
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              label: 'Edit',
              icon: Icons.edit,
            )
          ]),
          endActionPane: ActionPane(motion: ScrollMotion(), children: [
            SlidableAction(
              onPressed: (context) {
                deleteTodo(context, todo);
                //ScaffoldMessenger.of(context).showSnackBar(
                //SnackBar(content: Text('Removed \"${todo.title}\"')));
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'Remove',
              icon: Icons.delete,
            )
          ]),
          // key: Key(todo.id),

          child: buildTodo(context),
        ),
      );

  Widget buildTodo(BuildContext context) => GestureDetector(
        onTap: () => editTodo(context, todo),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                value: todo.isDone,
                onChanged: (_) {
                  final provider =
                      Provider.of<TodosProvider>(context, listen: false);
                  final isDone = provider.toggleTodoStatus(todo);

                  Utils.showSnackBar(
                    context,
                    isDone ? 'Task completed' : 'Task marked incomplete',
                  );
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    if (todo.description.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          todo.description,
                          style: TextStyle(fontSize: 20, height: 1.5),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      );
  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context, 'Deleted the task');
  }

  void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTodoPage(todo: todo),
        ),
      );
}

//   @override
//   Widget build(BuildContext context) => ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Slidable(
//           startActionPane: ActionPane(motion: ScrollMotion(), children: [
//             SlidableAction(
//               onPressed: (context) {
//                 // editTodo(context, todo);
//               },
//               backgroundColor: Colors.green,
//               foregroundColor: Colors.white,
//               label: 'Edit',
//               icon: Icons.edit,
//             )
//           ]),
//           endActionPane: ActionPane(motion: ScrollMotion(), children: [
//             SlidableAction(
//               onPressed: (context) {
//                 //deleteTodo(context, todo);
//                 //ScaffoldMessenger.of(context).showSnackBar(
//                 //SnackBar(content: Text('Removed \"${todo.title}\"')));
//               },
//               backgroundColor: Colors.red,
//               foregroundColor: Colors.white,
//               label: 'Remove',
//               icon: Icons.delete,
//             )
//           ]),
//           key: Key(todo.id.toString()),
//           child: buildTodo(context),
//         ),
//       );

//   Widget buildTodo(BuildContext context) => Container(
//         color: Colors.white,
//         padding: EdgeInsets.all(20),
//         child: Row(
//           children: [
//             Checkbox(
//               activeColor: Theme.of(context).primaryColor,
//               checkColor: Colors.white,
//               value: todo.isDone,
//               onChanged: (_) {},
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     todo.title,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Theme.of(context).primaryColor,
//                       fontSize: 22,
//                     ),
//                   ),
//                   if (todo.description.isNotEmpty)
//                     Container(
//                       margin: EdgeInsets.only(top: 4),
//                       child: Text(
//                         todo.description,
//                         style: TextStyle(fontSize: 20, height: 1.5),
//                       ),
//                     )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
// }
