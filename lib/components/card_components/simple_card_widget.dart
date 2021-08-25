import 'package:flutter/material.dart';

class SimpleCardWidget extends StatelessWidget {

  Color decorationColor=Colors.white;
  Color textColor;
  String title;
  int count;
  IconData icon;
  String subTitle;
  Function onClick;

  SimpleCardWidget({
    this.title,
    this.subTitle,
    this.onClick,
    this.icon,
    this.count,
    this.textColor,
    this.decorationColor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
            color: decorationColor,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(10, 2),
              )
            ]
        ),
        child: Padding(
          padding:EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child:Center(
                    child: Icon(icon,size: 43,color: textColor,),
                  )
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor
                        )
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(subTitle,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: textColor
                        )
                    ),

                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text((count==0)?"":count.toString(),
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



}
