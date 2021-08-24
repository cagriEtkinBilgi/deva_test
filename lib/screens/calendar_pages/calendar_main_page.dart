import 'package:deva_test/components/build_progress_widget.dart';
import 'package:deva_test/components/error_widget.dart';
import 'package:deva_test/components/navigation_bar.dart';
import 'package:deva_test/components/navigation_drawer.dart';
import 'package:deva_test/data/view_models/calendar_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/calendar_models/calendar_event_model.dart';
import 'package:deva_test/screens/base_class/base_view.dart';
import 'package:deva_test/tools/activity_color.dart';
import 'package:deva_test/tools/date_parse.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarMainPage extends StatefulWidget {
  @override
  _CalendarMainPageState createState() => _CalendarMainPageState();
}

class _CalendarMainPageState extends State<CalendarMainPage> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  bool lodingCtrl=false;

  @override
  void initState() {
    super.initState();

    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    setState(() {
      _selectedEvents = events;
    });
  }


  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed('/MainPage');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Takvim"),
        ),
        body: buildBody(),
        drawer: NavigationDrawer(),
        bottomNavigationBar: NavigationBar(selectedIndex: 0,),
      ),
    );
  }

  Widget buildBody() {
    return BaseView<CalendarViewModel>(
      onModelReady: (model){
         model.getCalenderTasks("","");
      },
      builder: (context,model,child){
        if(model.apiState==ApiStateEnum.LodingState){
          return ProgressWidget();
        }else if(model.apiState==ApiStateEnum.ErorState){
          return CustomErrorWidget(model.onError);
        }else{
          return buildCalendarBody(context,model);
        }
      },
    );
  }
  Widget buildCalendarBody(BuildContext context,CalendarViewModel model){
    _events=model.events;
    _selectedEvents = model.selectedEvents;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[

        _buildTableCalendarWithBuilders(model),
        //ProgressWidget(),

        SizedBox(height: 8.0),
        Expanded(child: _buildEventList()),
      ],
    );
  }

  Widget _buildTableCalendarWithBuilders(CalendarViewModel model) {
    if(lodingCtrl){
      return ProgressWidget();
    }else{
      return TableCalendar(
        locale: 'tr_TR',
        calendarController: _calendarController,
        events: _events,
        //holidays: _holidays,
        initialCalendarFormat: CalendarFormat.month,
        formatAnimation: FormatAnimation.slide,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        availableGestures: AvailableGestures.all,
        availableCalendarFormats: const {
          CalendarFormat.month: 'Ay',
          CalendarFormat.week: 'Hafta',
          CalendarFormat.twoWeeks:'2 Hafta'
        },
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
          holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
        ),
        builders: CalendarBuilders(
          selectedDayBuilder: (context, date, _) {
            return FadeTransition(
              opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
              child: Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                color: Colors.deepOrange[300],
                width: 100,
                height: 100,
                child: Text(
                  '${date.day}',
                  style: TextStyle().copyWith(fontSize: 16.0),
                ),
              ),
            );
          },
          todayDayBuilder: (context, date, _) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.amber[400],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            );
          },
          markersBuilder: (context, date, events, holidays) {
            final children = <Widget>[];
            if (events.isNotEmpty) {
              children.add(
                Positioned(
                  right: 1,
                  bottom: 1,
                  child: _buildEventsMarker(date, events),
                ),
              );
            }
            if (holidays.isNotEmpty) {
              children.add(
                Positioned(
                  right: -2,
                  top: -2,
                  child: _buildHolidaysMarker(),
                ),
              );
            }
            return children;
          },
        ),
        onDaySelected: (date, events, holidays) {
          _selectedEvents=model.changeSelectedEvent(date);
          _animationController.forward(from: 0.0);
        },
        onVisibleDaysChanged: (
            DateTime first, DateTime last, CalendarFormat format){
          model.getCalenderTasks(DateParseTools.instance.DateToStr(first),
              DateParseTools.instance.DateToStr(last));
        },
        onCalendarCreated: _onCalendarCreated,
      );
    }

  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
            ? Colors.brown[300]
            : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

/* Buttonlar Appbar Actionsa çekşlecek
  Widget _buildButtons() {
    final dateTime = _events.keys.elementAt(_events.length - 2);

    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('Ay'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            RaisedButton(
              child: Text('2 Hafta'),
              onPressed: () {
                setState(() {
                  _calendarController
                      .setCalendarFormat(CalendarFormat.twoWeeks);
                });
              },
            ),
            RaisedButton(
              child: Text('Hafta'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.week);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        RaisedButton(
          child: Text(
              'Set day ${dateTime.day}-${dateTime.month}-${dateTime.year}'),
          onPressed: () {
            _calendarController.setSelectedDay(
              DateTime(dateTime.year, dateTime.month, dateTime.day),
              runCallback: true,
            );
          },
        ),
      ],
    );
  }
*/

  Widget _buildEventList() {
    List _selectedObject=_selectedEvents
        .map((event)=>CalendarEventModel().fromMap(event)).toList();
    return ListView.separated(
      itemCount: _selectedObject.length,
      itemBuilder: (context,i){
        CalendarEventModel event=_selectedObject[i];
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200
          ),
          child: ListTile(
            leading: Container(
              child: Text(event.timeText??"",
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
            ),
            title: Text(event.title),
            subtitle: Text(event.startDateStr+"-"+event.endDateStr),
            trailing: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: ActicityColors.getActivityColorData(event.type),
                shape: BoxShape.circle
              ),
            ),
            onTap: () => {
              if(event.type==2){
                Navigator.pushNamed<dynamic>(context,'/TaskDetailPage',arguments: {
                  "id":event.id,
                  "title":event.title
                 })
              }else{
                Navigator.pushNamed<dynamic>(context,'/ActivitiesDetailPage',arguments: {
                  "id":event.id,
                  "title":event.title})
              }
            },
          ),
        );
      },
      separatorBuilder: (context,i)=>Divider(),
    );
    }

}
