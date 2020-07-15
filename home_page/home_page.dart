import 'package:apod_nasa/bloc/apod_bloc.dart';
import 'package:apod_nasa/bloc/home_page_bloc.dart';
import 'package:apod_nasa/model/apod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime now = new DateTime.now();
  DateTime selectedDate = DateTime.now();

  //final bloc = APODBloc();
  APODBloc bloc = new APODBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
            child: Container(
          padding: EdgeInsets.all(10),
          child: StreamBuilder<Object>(
              initialData: bloc.getLatestAPOD(),
              stream: bloc.ouput, //"2020-07-08",
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return new Text('Error: ${snapshot.error}');
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    //return Center(child: CircularProgressIndicator());
                    return Center(
                      child: Text("Loading..."),
                    );
                  default:
                    APOD apod = new APOD();
                    apod = snapshot.data;

                    return Column(children: <Widget>[
                      AspectRatio(
                        child: apod.mediaType == "image"
                            ? Image.network(apod.url, fit: BoxFit.cover)
                            : Image.network(apod.thumbnailUrl,
                                fit: BoxFit.cover),
                        aspectRatio: 2 / 1.5,
                      ),
                      Text(
                        apod.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        apod.date,
                        style: TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        apod.description,
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                      ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('DETAILS'),
                            textColor: Colors.grey.shade800,
                            onPressed: () {/* ... */},
                          ),
                          FlatButton(
                            child: const Text('SHARE'),
                            textColor: Colors.grey.shade800,
                            onPressed: () {/* ... */},
                          ),
                        ],
                      )
                    ]);
                }
              }),
        )),
        SizedBox(
          height: 20.0,
        ),
        RaisedButton(
          onPressed: () => buildDatePicker(context),
          child: Text('Select date'),
        ),
      ],
    );
  }

  buildImage() {}

  buildTitleImage() {}

  buildDescription() {}

  Future<Null> buildDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        // First APOD.
        firstDate: DateTime(1995, 6, 20),
        lastDate: now);

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      bloc.input.add(picked);
    }
  }

  @override
  void dispose() {
    bloc.closeStream();
    super.dispose();
  }
}
