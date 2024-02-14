// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:posts/cubit/States.dart';
// import 'package:posts/cubit/cubit.dart';
//
// class PostsPage extends StatelessWidget {
//   var ScaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<AppCubit>(
//         create: (BuildContext context) {
//           return AppCubit()..createDatabase();
//         },
//         child: BlocConsumer<AppCubit, AppStates>(
//           listener: (context, state) {},
//           builder: (context, state) {
//
//             AppCubit cubit = AppCubit.get(context);
//             return Scaffold(key: ScaffoldKey,
//               body: SafeArea(
//                   child:
//               Container(
//                 child: ListView.separated(itemBuilder: (context, index) {
//                   return Container(
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Container(
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     CircleAvatar(
//                                       child: Icon(Icons.person),
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       "${cubit.data[index]['name']}",
//                                       style: TextStyle(
//                                           fontSize: 26,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                                 Text("${cubit.data[index]['post']}"),
//                                 SizedBox(
//                                   height: 30,
//                                 ),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       color: Colors.blueGrey,
//                                       borderRadius: BorderRadius.circular(12)),
//                                   child: IconButton(
//                                       onPressed: () {},
//                                       icon: Icon(
//                                         Icons.favorite_border,
//                                         color: Colors.white,
//                                       )),
//                                 ),
//                                 ElevatedButton(onPressed: (){
//                                   cubit.deleteFromDatabase(cubit.data[index]['id']);
//                                 }, child: Text("Delete post"))
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 }, separatorBuilder:(context, index) => SizedBox(height: 10,), itemCount: cubit.data.length),
//               )
//               ),
//               floatingActionButton: FloatingActionButton(onPressed: (){
//                ScaffoldKey.currentState!.showBottomSheet((context) => Column(
//                   children: [
//                     TextFormField(controller: cubit.name,
//                       decoration: InputDecoration(
//                           hintText: "Write Your Name",
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12)),
//                           prefix: CircleAvatar(
//                             child: Icon(Icons.person),
//                           )),
//                     ),
//                     TextFormField(controller: cubit.post,
//                       decoration: InputDecoration(
//                           hintText: "Write Your Post",
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12)),
//                           prefix: CircleAvatar(
//                             child: Icon(Icons.person),
//                           )),
//
//                     ),
//
//                     ElevatedButton(onPressed: () {
//                       cubit.insertIntoDatabase(cubit.name.text, cubit.post.text);
//                     }, child: Text('Post')),
//                   ],
//                 ));
//               },child: Icon(Icons.add)),
//             );
//           },
//         ));
//   }
// }
