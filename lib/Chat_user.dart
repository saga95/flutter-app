import 'package:flutter/material.dart';


void main() {
  runApp(new ProjectHaloChat());
}

class ProjectHaloChat extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "Halo Chat app",
      home: new ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {

  @override
  State createState() => new ChatScreenState();
// TODO: implement createState
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin{

  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _editingController = new TextEditingController();
  bool _composing = false;

  @override
  void dispose(){
    for(ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text){
    _editingController.clear();

    setState(() {
      _composing = false;
    });
    ChatMessage message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
        duration: new Duration(microseconds: 700),
        vsync: this,
      ),
    );

    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Halo Chat App"),
          leading: IconButton(
              icon: new Icon(Icons.first_page),
              onPressed: (){
                _nextPage(-1);
              }
          ),
          actions: <Widget>[
            IconButton(
                tooltip: 'Add Members',
                icon: new Icon(Icons.person_add),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserList()),
                  );
                }
            ),
          ]
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),

          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(
                color: Theme.of(context).cardColor
            ),
            child: _buildTComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _editingController,
                onChanged: (String text){
                  setState(() {
                    _composing = text.length > 0;
                  });
                },
                onSubmitted: _handleSubmitted,
                decoration: new InputDecoration.collapsed(
                    hintText: "Send a message"),
              ),
            ),

            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.chat),
                onPressed: _composing
                    ?() => _handleSubmitted(_editingController.text)
                    :null,
              ),
            ),

            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.insert_emoticon),
                  onPressed: (){}
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _nextPage(int i) {}
}

class ChatMessage extends StatelessWidget{
  ChatMessage({this.text, this.animationController});
  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    const String _name= "projecthalo";
    return new SizeTransition(
        sizeFactor: new CurvedAnimation(
            parent: animationController,
            curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: new Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(right: 15.0),
                child: new CircleAvatar(child: new Text(_name[0])),
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(_name, style: Theme.of(context).textTheme.subhead),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new Text(text),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}

class UserList extends StatefulWidget{
  @override
  _State createState() => new _State();
// TODO: implement createState

}

class _State extends State<UserList>{

  List<bool> _data = new List<bool> ();

  @override
  void initState(){
    setState((){
      for(int i = 0; i<1000; i++){
        _data.add(false);
      }
    });
  }

  void _onChange(bool value, int index){
    setState(() {
      _data[index] = value;
    });
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("User List"),
        leading: IconButton(
            icon: new Icon(Icons.first_page),
            onPressed: (){
              Navigator.pop(context);
            }
        ),

        actions: <Widget>[
          IconButton(
            tooltip: 'Add Members',
            icon: new Icon(Icons.add),
            onPressed: (){
            },
          ),
        ],
      ),
      body: new ListView.builder(
          itemCount: _data.length,
          itemBuilder: (BuildContext context, int index){
            return new Card(
              child: new Container(
                padding: new EdgeInsets.all(5.0),
                child: new Column(
                  children: <Widget>[
                    new Text("User 01"),
                    new CheckboxListTile(
                      value: _data[index],
                      controlAffinity: ListTileControlAffinity.leading,
                      title: new Text("Add User"),
                      onChanged: (bool value){
                        _onChange(value, index);
                      },
                    )
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}


