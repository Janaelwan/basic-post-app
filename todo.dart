import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/cubit/States.dart';
import 'package:posts/cubit/cubit.dart';


class ToDoApp extends StatelessWidget {
  ToDoApp({Key? key}) : super(key: key);
  var ScaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (context) =>
      AppCubit()
        ..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
              key: ScaffoldKey,
              body: SafeArea(
                // child: Text("JANA JANJON",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 45),),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                child: Text(
                                  "${cubit.data[index]['time']}",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${cubit.data[index]['title']}",
                                      style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${cubit.data[index]['date']}",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    cubit.deleteFromDatabase(
                                        cubit.data[index]["id"]);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.green,
                                  )),
                              Checkbox(
                                value: cubit.isDone,
                                onChanged: (value) {
                                  cubit.IsDone(value!);
                                },
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(
                              height: 10,
                            ),
                        itemCount: cubit.data.length)),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  // cubit.ShowEditIcon(true);
                  // ScaffoldKey.currentState?.showBottomSheet((context) =>
                  //     SafeArea(
                  //       child: Container(
                  //         width: double.infinity,
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Form(
                  //             key: formKey,
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.end,
                  //               mainAxisAlignment: MainAxisAlignment.end,
                  //               children: [
                  //                 TextFormField(
                  //                   validator: (value) {
                  //                     if (value!.isEmpty) {
                  //                       return "Title must not be empty";
                  //                     }
                  //                   },
                  //                   controller: cubit.title,
                  //                   decoration: InputDecoration(
                  //                       hintText: "title",
                  //                       prefixIcon: Icon(Icons.text_fields),
                  //                       border: OutlineInputBorder(
                  //                           borderRadius:
                  //                           BorderRadius.circular(12))),
                  //                 ),
                  //                 SizedBox(
                  //                   height: 10,
                  //                 ),
                  //                 TextFormField(
                  //                   validator: (value) {
                  //                     if (value!.isEmpty) {
                  //                       return "value must not be empty";
                  //                     }
                  //                   },
                  //                   controller: cubit.date,
                  //                   decoration: InputDecoration(
                  //                       hintText: "date",
                  //                       prefixIcon: Icon(Icons.date_range),
                  //                       border: OutlineInputBorder(
                  //                           borderRadius:
                  //                           BorderRadius.circular(12))),
                  //                 ),
                  //                 SizedBox(
                  //                   height: 10,
                  //                 ),
                  //                 TextFormField(
                  //                   validator: (value) {
                  //                     if (value!.isEmpty) {
                  //                       return "Must be written";
                  //                     }
                  //                   },
                  //                   controller: cubit.time,
                  //                   decoration: InputDecoration(
                  //                       hintText: "time",
                  //                       prefixIcon: Icon(Icons.timelapse),
                  //                       border: OutlineInputBorder(
                  //                           borderRadius:
                  //                           BorderRadius.circular(12))),
                  //                 ),
                  //                 SizedBox(
                  //                   height: 10,
                  //                 ),
                  //                 ElevatedButton(
                  //                     onPressed: () {
                  //                       if (cubit.show) {
                  //                         if (formKey.currentState!.validate()) {
                  //                           cubit.insertIntoDatabase(
                  //                               cubit.title.text,
                  //                               cubit.date.text,
                  //                               cubit.time.text);
                  //                         }
                  //                       }
                  //                     },
                  //                     child: Text(
                  //                       "Done",
                  //                       style: TextStyle(
                  //                           fontSize: 25,
                  //                           fontWeight: FontWeight.bold),
                  //                     )),
                  //                 ElevatedButton(
                  //                     onPressed: () {
                  //                       cubit.editTodo(true);
                  //                     },
                  //                     child: Text(
                  //                       "Edit",
                  //                       style: TextStyle(
                  //                           fontWeight: FontWeight.bold,
                  //                           fontSize: 27),
                  //                     )),
                  //
                  //
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ));

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      String newTask = '';

                      return AlertDialog(
                        title: Text('Add Todo'),
                        content: Column(
                          children: [
                            TextFormField(controller: cubit.title,
                              onChanged: (value) {
                                newTask = value;
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter a task',
                              ),
                            ),
                            TextButton(onPressed: () {
                              showDatePicker(context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2027));
                            }, child: Text("Select the date"),),


                          ],
                        ),
                        actions: [
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Add'),
                            onPressed: () {
                              cubit.insertIntoDatabase(
                                  cubit.title.text, cubit.date.text,
                                  cubit.time.text);

                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },

                child: cubit.show ? Icon(Icons.edit) : Icon(Icons.add),
              )
          );
        }
        ,

      ),


    );
  }
}
