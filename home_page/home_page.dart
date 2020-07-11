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
  //HomePageBloc bloc = HomePageBloc();

  DateTime selectedDate = DateTime.now();

  //final bloc = APODBloc();
  APODBloc bloc = new APODBloc();

  // void _incrementCounter() {
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            buildBody2(context),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () => _buildDatePicker(context),
              child: Text('Select date'),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // Botar na inicialização do app (não muda com estado).
  DateTime now = new DateTime.now();

  testCard() {}

  Widget buildBody2(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                  'https://apod.nasa.gov/apod/image/2007/Neowise_Moophz_960.jpg', fit: BoxFit.fill,),
              Text(
                "Flutter - 2019 - Macoratti.net quase tudo para .NET",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "http://www.macoratti.net",
                style: TextStyle(fontSize: 14),
              ),
              ButtonTheme.bar(
                  child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('DETALHES'),
                    onPressed: () {/* ... */},
                  ),
                  FlatButton(
                    child: const Text('SHARE'),
                    onPressed: () {/* ... */},
                  ),
                ],
              ))
            ]),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return StreamBuilder<APOD>(
        stream: bloc.ouput,
        initialData: APOD(
            date:
                "2020-07-08" /*new DateTime(now.year, now.month, now.day).toString()*/), //"2020-07-08",
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return new Text('Erro na consulta: ${snapshot.error}');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              //return Center(child: CircularProgressIndicator());
              return Center(
                child: Text("Carregando..."),
              );
            default:
              APOD apod = new APOD();
              apod = snapshot.data;

              return Card(
                  color: Colors.grey[100],
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          apod.mediaType == "image"
                              ? Image.network(apod.url)
                              : Image.network(apod.thumbnailUrl),
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
                          ButtonTheme.bar(
                              child: ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                child: const Text('DETALHES'),
                                onPressed: () {/* ... */},
                              ),
                              FlatButton(
                                child: const Text('SHARE'),
                                onPressed: () {/* ... */},
                              ),
                            ],
                          ))
                        ]),
                  ));

            // return Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: <Widget>[
            //     Text("Título: ${apod?.title}"),
            //     Expanded(
            //         child: apod.mediaType == "image"
            //             ? Image.network(apod.url)
            //             : Column(children: <Widget>[Text("Media link: ${apod.url}"), Image.network(apod.thumbnailUrl)],) ),
            //   ],
            // );
          }
        });
  }

  buildImage() {}

  buildTitleImage() {}

  buildDescription() {}

  Future<Null> _buildDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1995, 6, 20),
        lastDate: now);
    //lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      // bloc.getAPOD(picked);
      bloc.input.add(picked);
    }

    // setState(() {
    //   selectedDate = picked;
    // });
  }

  @override
  void dispose() {
    bloc.closeStream();
    super.dispose();
  }
}
