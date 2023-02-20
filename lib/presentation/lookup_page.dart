import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gigabank/models/address.dart';
import 'package:gigabank/presentation/widgets/country_dropdown.dart';

class AddressLookupForm extends StatefulWidget {
  const AddressLookupForm({super.key});

  @override
  _AddressLookupFormState createState() => _AddressLookupFormState();
}

class _AddressLookupFormState extends State<AddressLookupForm> {
  final _formKey = GlobalKey<FormState>();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _countryController = TextEditingController();
  final Address _address = Address();

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      // Do something with the address data, like save it to a database
      print(_address);
    }
  }

  String? _validateStreetAddress(String? value) {
// Validate the street address format. Assumes "subarea-block-house" format.
    if (value?.isEmpty ?? true) {
      return 'Please enter a street address';
    }
    final parts = value?.split('-');
    if (parts?.length != 3) {
      return 'Please enter a valid street address in the "subarea-block-house" format';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address Lookup Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CountryDropdown(onCountrySelected: (onCountrySelected) {}),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a city';
                  }
                  return null;
                },
                onSaved: (value) => _address.city = value ?? '',
              ),
              TextFormField(
                controller: _streetController,
                decoration: const InputDecoration(
                  labelText: 'Street Address',
                ),
                validator: _validateStreetAddress,
                onSaved: (value) => _address.street = value ?? '',
              ),
              TextFormField(
                controller: _zipCodeController,
                decoration: const InputDecoration(
                  labelText: 'Zip Code',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a zip code';
                  }
                  return null;
                },
                onSaved: (value) => _address.zipCode = value!,
              ),
              CupertinoButton(
                onPressed: _submitForm,
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
