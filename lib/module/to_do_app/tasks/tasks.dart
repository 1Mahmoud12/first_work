
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/layout/to_do_app/cubit/cubit%20todo/states.dart';
import 'package:to_do_app/layout/to_do_app/cubit/cubit%20todo/toda%20app.dart';



import '../../../shared/components/components.dart';


class tasks extends StatelessWidget {
  const tasks({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,Appstates>(
        builder: (context, state) {
          var tasks =AppCubit.get(context).newTask;
          return ListView.separated(
              itemBuilder:(context,index){
                return buildTaskItem(tasks[index],context );} ,
              separatorBuilder:(context,index) {return Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              );},
              itemCount: tasks.length
          );
        }, listener: (context,state){});
  }
}

