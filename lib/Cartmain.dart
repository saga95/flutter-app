import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        // ignore: argument_type_not_assignable
        //primarySwatch: Colors.blueAccent,
        buttonColor: Colors.blueAccent,
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class Event{
  const Event({this.name, this.description, this.timeleft, this.imageUrl});

  final String name;
  final String description;
  final int timeleft;
  final String imageUrl;

}

  final List<Event> _events = <Event>[
  Event(
    name: 'FIFA 2020',
    description: 'Football world cup!',
     timeleft: 10,
    imageUrl : 'assets/images/imgc1.jpg'),
  Event(
      name: 'Trumps Guide',
      description: 'Get ready for next election',
      imageUrl : 'assets/images/imgc2.jpg'),
  Event(
      name: 'Mirissa 2019',
      description: 'Visit Sri Lanka 2020!',
      imageUrl : 'assets/images/imgc3.jpg'),
  Event(
      name: 'Mr.PRESINDENT!',
      description: 'Make Americe greate again!',
      imageUrl : 'assets/images/imgc4.jpg'),
  ];
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget _dialogBuilder(BuildContext context, Event event) {
    ThemeData localtheme = Theme.of(context);
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: <Widget>[
        Image.asset(
          event.imageUrl,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(event.name,
                    style: localtheme.textTheme.display1,),
              Text('${event.timeleft} days left',
                    style: localtheme.textTheme.subhead.copyWith(
                        fontStyle: FontStyle.italic,
                    ),
              ),
              SizedBox(height: 16.0),
              Text(event.description,
                    style: localtheme.textTheme.body1,),
              Align(
                alignment: Alignment.centerRight,
                child: Wrap(children: <Widget>[
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop('');
                    },
                    child: const Text('Ignore'),
                  ),
                  RaisedButton(
                    onPressed: (){},
                    child: const Text('Buy Tickets Now'),
                  )
                ],
              ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _listItemBuilder(BuildContext context,int index){
    return new GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => _dialogBuilder(context, _events[index])),
      child : Container(
        padding: const EdgeInsets.only(left: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(_events[index].name,
          style: Theme.of(context).textTheme.headline),
    ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Events'),
      ),
      body: ListView.builder(
          itemCount: _events.length,
          itemExtent: 60.0,
          itemBuilder: _listItemBuilder),
    );
  }
}
