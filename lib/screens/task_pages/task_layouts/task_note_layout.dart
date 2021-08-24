import 'package:deva_test/components/build_progress_widget.dart';
import 'package:deva_test/components/error_widget.dart';
import 'package:deva_test/components/message_dialog.dart';
import 'package:deva_test/components/note_add_dialog.dart';
import 'package:deva_test/data/view_models/task_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/component_models/note_add_model.dart';
import 'package:deva_test/models/task_note_models/task_note_list_model.dart';
import 'package:deva_test/screens/base_class/base_view.dart';
import 'package:flutter/material.dart';

class TaskNoteLayout extends StatelessWidget {
  int id;
  TaskNoteLayout({this.id});
  @override
  Widget build(BuildContext context) {
    return buildBody();
  }
  Widget buildBody() {
    return BaseView<TaskViewModel>(
      onModelReady: (model){
        model.getTaskNotes(id);
      },
      builder: (context,model,child){
        if(model.apiState==ApiStateEnum.LodingState){
          return ProgressWidget();
        }else if(model.apiState==ApiStateEnum.ErorState){
          return CustomErrorWidget(model.onError);
        }else{
          return Stack(
            children: [
              buildDetailCard(context,model),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 25,bottom: 25),
                    child: FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: (){
                        addNoteDialogForm(context,model);
                      },
                    ),
                  )
              )
            ],
          );
        }
      },
    );
  }

  Widget buildDetailCard(BuildContext context, TaskViewModel model) {
    var notes=model.taskNotes;
    if(notes !=null&&notes.length!=0){
      return Container(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context,i){
                var item=notes[i];
                return Card(
                  child: ListTile(
                      title: Text(item.desc),
                      trailing: PopupMenuButton<String>(
                        onSelected: (e){
                          deleteAndUpdateTaskNote(context,e,item,model);
                        },
                        itemBuilder: (_)=>[
                          PopupMenuItem(
                            child: Text("Sil"),
                            value: "1",
                          ),
                          PopupMenuItem(
                            child: Text("Düzenle"),
                            value: "2",
                          ),
                        ],
                      )
                  ),
                );
              },
            ),
          );
    }else{
      return Container(
        child: Center(child: Text("Gösterilecek Note Bulunamadı")),
      );
    }
  }

  Future<bool> addNoteDialogForm(BuildContext context,TaskViewModel model, {NoteAddDialogModel note})async {
    return await showDialog(
        context:context,
        builder: (context){
          return AlertDialog(
            content: NoteAddDialog(
              initModel: note,
              onNoteSaveAsyc: (NoteAddDialogModel dialogModel) async {
                dialogModel.taskID=id;
                return await  model.addTaskNote(dialogModel);
              },
            ),
          );
        }
    );
  }

  deleteAndUpdateTaskNote(BuildContext context,String selectedID,TaskNoteListModel item, TaskViewModel model){
    print(selectedID);
    if(selectedID=="1"){
      CustomDialog.instance.confirmeMessage(
        context,
        title: "Not Sil",
        cont: "Not Silmek İstediğiniz Eminmisiniz?",
        confirmBtnTxt:"Evet",
        unConfirmeBtnTxt:"Hayır",
      ).then((value){
        if(value){
          model.deleteTaskNote(item);
        }
      });
    }else{
      addNoteDialogForm(context,model,note: NoteAddDialogModel(
          desc: item.desc,activityID:id,id: item.id ));
    }
  }

}
