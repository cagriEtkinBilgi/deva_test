import 'package:deva_test/components/appbar_flexible_background/flexible_space_background.dart';
import 'package:deva_test/models/activity_models/activity_list_model.dart';
import 'package:flutter/material.dart';
import 'activiti_layouts/activity_detail_main_layout.dart';
import 'activiti_layouts/activity_file_layout.dart';
import 'activiti_layouts/activity_image_layout.dart';
import 'activiti_layouts/activity_note_layout.dart';
import 'activiti_layouts/activity_participant_layout.dart';

class ActivityDetailPage extends StatelessWidget {
  int id;
  String title;
  ActivityDetailPage({Map args}){
    if(args["id"]!=null)
      id=args["id"];
    if(args["title"]!=null)
      title=args["title"];
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            title: Text("${title}"),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Faaliyet",
                ),
                Tab(
                  text: "Katılımcılar",
                ),
                Tab(
                  text: "Notlar",
                ),
                Tab(
                  text: "Dosyalar",
                ),
                Tab(
                  text: "Resimler",
                ),
              ],
            ),
          ),
         resizeToAvoidBottomInset: false,
          body: TabBarView(
            children: [
              ActivityDetailMainLayout(
                id: id,
              ),
              ActivityParticipantLayout(
                id: id,
              ),
              ActivityNoteLayout(
                id: id,
              ),
              ActivityFileLayout(
                id: id,
              ),
              ActivityImageLayout(
                id: id,
              )
            ],
          ),
        ),
    );

  }

}


