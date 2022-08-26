// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/layout/to_do_app/cubit/cubit%20todo/states.dart';

import '../../shared/components/components.dart';
import 'cubit/cubit todo/toda app.dart';


class Navigation extends StatelessWidget {
  //Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var task = TextEditingController();
  var time = TextEditingController();
  var date = TextEditingController();

  Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppCubit()..createdatabase(),
        child: BlocConsumer<AppCubit, Appstates>(
          listener: (context, state) {
            if((state is Appinsertdatabase))
            {Navigator.pop(context);}

          },
          builder: (context, state) {
            bool isDark=AppCubit.get(context).isDark;

            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: const Text('ToDo'),
                actions:  [
                  Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: IconButton(onPressed: () {AppCubit.get(context).modeAppNews();}, icon:  const Icon(Icons.dark_mode_outlined) )
                                   // IconButton(onPressed: (){AppCubit.get(context).modeAppNews(mode: true);}, icon: const Icon(Icons.dark_mode),)

                    // true is Dark
                    // false is Light
            )
                ],
              ),
              body: ConditionalBuilder(
                  condition: state is! AppGetDatabaseLoadingState,
                  builder: (context) => cubit.screens[cubit.currentState],
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator())),

              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.editcheck) {
                    if (formKey.currentState!.validate()) {

                        cubit.insertdatabase(
                          date: date.text,
                          time: time.text,
                          title: task.text)
                          .then((value) {
                        return 'Insert sucsess';
                      });
                    }
                  }
                  else {
                    scaffoldKey.currentState!
                        .showBottomSheet((context) => Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[200]),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultTextFromField(
                                        text:
                                            cubit.titles[0],
                                        controller: task,
                                        prefix: Icons.menu,
                                        inputKeyboardType: TextInputType.text,
                                        validate: (value) {
                                          if (value.isEmpty) {
                                            return 'you must input Time';
                                          }
                                        }),
                                    const SizedBox(height: 30.0),
                                    defaultTextFromField(
                                        text:
                                            cubit.titles[1],
                                        prefix: Icons.watch_later_outlined,
                                        controller: time,
                                        inputKeyboardType: TextInputType.none,
                                        validate: (value) {
                                          if (value.isEmpty) {
                                            return 'you must input Time';
                                          }
                                        },
                                        onTap: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now())
                                              .then((value) {
                                            time.text = value
                                                !.format(context)
                                                .toString();
                                          });
                                        }),
                                    const SizedBox(height: 30.0),
                                    defaultTextFromField(
                                        text:
                                            cubit.titles[2],
                                        prefix: Icons.calendar_today,
                                        controller: date,
                                        inputKeyboardType: TextInputType.none,
                                        validate: (value) {
                                          if (value.isEmpty) {
                                            return 'you must input Date';
                                          }
                                        },
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.parse(
                                                      "2023-12-30"))
                                              .then((value) {
                                            date.text = DateFormat.yMMMd()
                                                .format(value!);
                                          });
                                        }),
                                  ],
                                ),
                              ),
                            ))
                        .closed.then((value) {
                      cubit.changebottomsheet(icon: Icons.edit,edit: false);});
                    cubit.changebottomsheet(icon: Icons.add,edit: true);
                  }
                },
                child: Icon(cubit.icona),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  currentIndex: cubit.currentState,
                  onTap: (index) {
                    cubit.changeindex(index);
                  },
                  items: const [
                    BottomNavigationBarItem(
                        label: 'tasks', icon: Icon(Icons.menu)),
                    BottomNavigationBarItem(
                        label: 'Done', icon: Icon(Icons.check_circle)),
                    BottomNavigationBarItem(
                        label: 'Archive', icon: Icon(Icons.archive_outlined)),
                  ]),
            );
          },
        ));
  }


}
