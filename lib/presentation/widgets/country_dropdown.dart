import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CountryDropdown extends StatefulWidget {
  final Function(String) onCountrySelected;

  const CountryDropdown({super.key, required this.onCountrySelected});

  @override
  _CountryDropdownState createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  final _controller = TextEditingController();
  final List<String> _countries = [
    'Afghanistan',
    'Albania',
    'Algeria',
    // and so on...
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: 'Country',
          suffixIcon: Icon(Icons.arrow_drop_down),
        ),
      ),
      suggestionsCallback: (pattern) {
        return _countries
            .where((country) =>
                country.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: Image.asset(
            'assets/flags/${suggestion.toLowerCase()}.png',
            width: 32.0,
          ),
          title: Text(suggestion),
        );
      },
      onSuggestionSelected: (suggestion) {
        _controller.text = suggestion;
        widget.onCountrySelected(suggestion);
      },
    );
  }
}
