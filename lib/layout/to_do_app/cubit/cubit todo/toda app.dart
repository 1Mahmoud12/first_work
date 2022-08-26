import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/layout/to_do_app/cubit/cubit%20todo/states.dart';
import 'package:to_do_app/module/to_do_app/archive/archive.dart';
import 'package:to_do_app/module/to_do_app/done/done.dart';
import 'package:to_do_app/module/to_do_app/tasks/tasks.dart';
import 'package:to_do_app/shared/network/local/Cach_helper.dart';




class AppCubit extends Cubit<Appstates> {
  AppCubit() : super(AppIntialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentState = 0;

  List<Widget> screens = [
     tasks(),
     Done(),
     archive(),
  ];
  List<String> titles = ['New Task', 'Time Task', 'Date Task'];

  late Database database;
  List<Map> newTask = [];
  List<Map> doneTask = [];
  List<Map> archiveTask = [];

  IconData icona = Icons.edit;
  bool editcheck = false;

  void changebottomsheet({@required bool? edit, @required IconData? icon}) {
    editcheck = edit!;
    icona = icon!;
    emit(AppbottomNavBarState());
  }

   void createdatabase() {
    openDatabase(
        'todoo.db', version: 1,
        onCreate: ( Database,version) {

       Database.execute(
              'CREATE TABLE tasks (ID INTEGER PRIMARY KEY,title TEXT, date TEXT ,time TEXT,status TEXT)')
          .then((value) {
            database=Database;
            print('create succsess');
          })
          .catchError((Error) {
        print('error WHEN create table ${Error.toString()}');
      });
      print('database created');
    },
        onOpen: (Database) {
      emit(Appgetdatabase());
      getDataBase(Database);
      //print('opened database');
    }).then((value) {
      database=value;
      emit(Appcreatedatabase());
    });

  }

   insertdatabase({
    @required String? title,
    @required String? date,
    @required String? time,
  }) async {
    await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO tasks(title, date ,time ,status) VALUES("${title}","${date}","${time}","new" )')
          .then((value) {
        print('$value insert success');

        emit(Appinsertdatabase());
        getDataBase(database);
      })
          .catchError((Error) {
        print('error WHEN insertNew Record ${Error.toString()}');
      });
    });// }).then((value){
    //   database=value;
    //   emit(Appgetdatabase());
    // });
  }

   getDataBase(Databases) async {
      newTask = [];
      doneTask = [];
      archiveTask = [];
      emit(AppGetDatabaseLoadingState());
    //print(Database);
   await Databases.rawQuery('SELECT * FROM tasks').then((value) {

      value.forEach((element) {
        if(element['status']=='new'){newTask.add(element);}
        else if(element['status']=='done'){doneTask.add(element);}
        else{archiveTask.add(element);}
      });
      // print(NewTask);
      // print(doneTask);
      // print(archiveTask);

      emit(Appgetdatabase());
    });
          return null;
  }
 void updatedata ({@required String? status,@required int? id})
  async{
      database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE ID = ?',
      [status,id]).then((value) {
       getDataBase(database);
       emit(AppUpdatedatabase());
      });

}
  void deletedata ({@required int? id})
  async{
    database.rawDelete(
        'DELETE FROM tasks WHERE ID = ?', [id]
    ).then((value) {
      getDataBase(database);
      emit(AppDeleteDatabaseState());
    });

  }
  void changeindex(int index) {
    currentState = index;
    emit(AppbottomNavBarState());
  }
  bool isDark =false;
  void modeAppNews(){                 // true is Dark
                                                  // false is Light
        isDark=!isDark;
        print(isDark);
        emit(AppGetMode());
  }

}
