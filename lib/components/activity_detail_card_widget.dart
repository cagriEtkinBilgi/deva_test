import 'package:flutter/material.dart';


class ActivityDetailCardWidget extends StatelessWidget {
  String title;
  String desc;
  String workGroupName;
  String location;
  String categoriName;
  String planetStartDate;
  String planetStartEnd;


  ActivityDetailCardWidget({
      this.title,
      this.desc,
      this.workGroupName,
      this.location,
      this.categoriName,
      this.planetStartDate,
      this.planetStartEnd});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Text(title??'default value',style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(desc,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(workGroupName,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(location??'default value',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(categoriName??'default value',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(planetStartDate??'default value',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(planetStartEnd??'default value',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
