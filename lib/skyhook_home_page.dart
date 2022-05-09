import 'package:flutter/material.dart';
import 'package:skyhook/skyhook_api.dart';
import 'package:skyhook/snackbar_helper.dart';

class SkyhookHomePage extends StatefulWidget {
  const SkyhookHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SkyhookHomePage> createState() => _SkyhookHomePageState();
}

class _SkyhookHomePageState extends State<SkyhookHomePage> {

  List<String> _providers = List.empty();

  @override
  void initState() {
    super.initState();
    _loadProviders();
  }

  void _loadProviders() {
    SkyhookApi.providers()
        .then((value) => _setProviders(value))
        .catchError(_onError);

  }

  void _onError(Object error) {
    print(error);
    SnackBarHelper.show(context, "Something went wrong");
  }


  void _setProviders(List<String> providers) {
    setState(() {
      _providers = providers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'skyhook parses webhooks from various services and forwards them in the proper format to Discord.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              'In order to have skyhook parse your webhooks properly, you must first generate a webhook URL. Once you have the URL generated, you can pass it along to the provider you selected.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
    );
  }
}