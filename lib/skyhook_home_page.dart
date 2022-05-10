import 'package:flutter/material.dart';
import 'package:skyhook/loading_widget_factory.dart';
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
  Provider? _selectedProvider;
  String? _currentErrorMessage;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_onTyped);
    _loadProviders();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTyped() {
    if (_currentErrorMessage != null) {
      setState(() {
        _currentErrorMessage = null;
      });
    }
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
    String domain = "discord.com";
    String path = _selectedProvider?.path ?? "";
    if (path.isEmpty) {
      SnackBarHelper.show(context, 'Please select a provider');
      return;
    }
    String url = _controller.text;
    if (url.isEmpty) {
      setState(() {
        _currentErrorMessage = "Please paste your Discord Webhook URL here";
      });
      return;
    }
    if (!url.contains(domain)) {
      setState(() {
        _currentErrorMessage = "Not a valid Discord Webhook URL";
      });
      return;
    }
    String generatedUrl = "";

    generatedUrl = url.replaceAll(domain, "skyhookapi.com");
    generatedUrl += "/" + path;

    Clipboard.setData(ClipboardData(text: generatedUrl));
    SnackBarHelper.show(context, 'URL generated. Copied to clipboard',
        action: SnackBarAction(
          label: 'Test',
          onPressed: () {
            test(generatedUrl);
          },
        ));
  }

  void test(String generatedUrl) {
    SkyhookApi.testProvider(generatedUrl)
        .then((value) => SnackBarHelper.show(context, "Test message sent"))
        .catchError(_onError);
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
        padding: const EdgeInsets.all(40.0),
        children: <Widget>[
          Text(
            'skyhook parses webhooks from various services and forwards them in the proper format to Discord.',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          verticalSeparator(),
          Text(
            'In order to have skyhook parse your webhooks properly, you must first generate a webhook URL. Once you have the URL generated, you can pass it along to the provider you selected.',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          verticalSeparator(),
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Discord Webhook URL',
              errorText: _currentErrorMessage,
              border: const OutlineInputBorder(),
              suffixIcon: errorIcon(),
            ),
          ),
          verticalSeparator(),
          _providerList(_providers),
          verticalSeparator(),
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

  Widget? errorIcon() {
    if (_currentErrorMessage == null) {
      return null;
    } else {
      return const Icon(Icons.error);
    }
  }

  Widget _providerList(List<Provider> providers) {
    if (_providers.isEmpty) {
      return LoadingWidgetFactory.centeredIndicator();
    }
    return Wrap(
        spacing: 8.0, // gap between adjacent chips
        runSpacing: 4.0, // gap between lines
        children: providers.map((provider) {
          var widget = InkWell(
              onTap: () {
                setState(() {
                  _selectedProvider = provider;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<Provider>(
                    value: provider,
                    groupValue: _selectedProvider,
                    onChanged: (Provider? value) {
                      setState(() {
                        _selectedProvider = value;
                      });
                    },
                  ),
                  Text(provider.name),
                  horizontalSeparator()
                ],
              ));
          return widget;
        }).toList());
  }

  Widget verticalSeparator() {
    return const SizedBox(
      height: 20.0,
    );
  }

  Widget horizontalSeparator() {
    return const SizedBox(
      width: 10.0,
    );
  }
}
