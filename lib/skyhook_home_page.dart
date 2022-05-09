import 'package:flutter/material.dart';
import 'package:skyhook/provider.dart';
import 'package:skyhook/skyhook_api.dart';
import 'package:skyhook/snackbar_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class SkyhookHomePage extends StatefulWidget {
  const SkyhookHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SkyhookHomePage> createState() => _SkyhookHomePageState();
}

class _SkyhookHomePageState extends State<SkyhookHomePage> {
  List<Provider> _providers = List.empty();
  Provider? _selectedProvider = null;

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

  void _setProviders(List<Provider> providers) {
    setState(() {
      _providers = providers;
    });
  }

  void _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      SnackBarHelper.show(context, 'Could not launch $url');
    }
  }

  void _generate() {
    if (_selectedProvider == null) {
      SnackBarHelper.show(context, 'Please select a provider');
    } else {
      Clipboard.setData(ClipboardData(text: _selectedProvider?.name));
      SnackBarHelper.show(context, 'Copied to clipboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.code),
            onPressed: () {
              _launchUrl("https://github.com/Commit451/skyhook");
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Text(
            'skyhook parses webhooks from various services and forwards them in the proper format to Discord.',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Text(
            'In order to have skyhook parse your webhooks properly, you must first generate a webhook URL. Once you have the URL generated, you can pass it along to the provider you selected.',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          _providerList(_providers),
          ElevatedButton(
              onPressed: _generate,
              child: Container(
                margin: const EdgeInsets.only(
                    left: 40.0, right: 40.0, top: 20.0, bottom: 20.0),
                child: const Text("Generate"),
              )),
        ],
      ),
    );
  }

  Widget _providerList(List<Provider> providers) {
    if (_providers.isEmpty) {
      return const Text("Empty");
    }
    return ListView(
        shrinkWrap: true,
        children: providers.map((provider) {
          var widget = ListTile(
            title: Text(provider.name),
            leading: Radio<Provider>(
              value: provider,
              groupValue: _selectedProvider,
              onChanged: (Provider? value) {
                setState(() {
                  _selectedProvider = value;
                });
              },
            ),
          );
          return widget;
        }).toList());
  }
}
