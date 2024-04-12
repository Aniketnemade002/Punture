import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:garage/Features/Registration/presentation/page/GeoLocation_service.dart';
import 'package:garage/core/Dataset/Address.dart';

// LocationSelectorButton(
//           onSelectionDone: (selectedVillage) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Selected Village: $selectedVillage'),
//                 duration: Duration(seconds: 2),
//               ),
//             );
//           },
//         )

class LocationSelectorButton extends StatefulWidget {
  final Function(String) onSelectionDone;

  const LocationSelectorButton({Key? key, required this.onSelectionDone})
      : super(key: key);

  @override
  _LocationSelectorButtonState createState() => _LocationSelectorButtonState();
}

class _LocationSelectorButtonState extends State<LocationSelectorButton> {
  void _openSelectionDialog() async {
    String? result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => SelectionDialog(),
    );
    if (result != null) {
      widget.onSelectionDone(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _openSelectionDialog,
      child: Text('Select Location'),
    );
  }
}

class SelectionDialog extends StatefulWidget {
  @override
  _SelectionDialogState createState() => _SelectionDialogState();
}

class _SelectionDialogState extends State<SelectionDialog> {
  String? _selectedState;
  String? _selectedCity;
  String? _selectedSubCity;
  String? _selectedVillage;
  bool _showError = false;
  late List<dynamic> _states = SetOfAddress['states'];
  List<dynamic> _cities = [];
  List<dynamic> _subCities = [];
  List<String> _villages = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Location'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDropdown(_states, 'state', 'Select State', (value) {
              setState(() {
                _selectedState = value;
                _cities = _states.firstWhere(
                    (item) => item['state'] == _selectedState)['cities'];
                _selectedCity = null;
                _selectedSubCity = null;
                _selectedVillage = null;
              });
            }),
            if (_selectedState != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: _buildDropdown(_cities, 'city', 'Select City', (value) {
                  setState(() {
                    _selectedCity = value;
                    _subCities = _cities.firstWhere(
                        (item) => item['city'] == _selectedCity)['subCities'];
                    _selectedSubCity = null;
                    _selectedVillage = null;
                  });
                }),
              ),
            if (_selectedCity != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: _buildDropdown(_subCities, 'subCity', 'Select SubCity',
                    (value) {
                  setState(() {
                    _selectedSubCity = value;
                    _villages = _subCities.firstWhere((item) =>
                        item['subCity'] == _selectedSubCity)['villages'];
                    _selectedVillage = null;
                  });
                }),
              ),
            if (_selectedSubCity != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child:
                    _buildDropdown(_villages, null, 'Select Village', (value) {
                  setState(() {
                    _selectedVillage = value;
                  });
                }, isVillage: true),
              ),
            if (_showError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Please select a village',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
          ],
        ),
      ),
      actions: <Widget>[
        ButtonBar(
          alignment: MainAxisAlignment.center,
          buttonMinWidth: double.infinity,
          children: [
            ElevatedButton(
              onPressed: () {
                if (_selectedVillage != null) {
                  Navigator.of(context).pop(_selectedVillage);
                } else {
                  setState(() {
                    _showError = true;
                  });
                }
              },
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      0), // Optional: if you want it fully rectangular
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdown(List<dynamic> items, String? itemKey, String hintText,
      void Function(String?) onChanged,
      {bool isVillage = false}) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple.shade800),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple.shade800),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple.shade800, width: 2.0),
        ),
      ),
      value: itemKey != null ? eval(itemKey) : _selectedVillage,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((dynamic value) {
        return DropdownMenuItem<String>(
          value: itemKey != null ? value[itemKey] : value,
          child: Text(itemKey != null ? value[itemKey] : value),
        );
      }).toList(),
      hint: Text(hintText),
    );
  }

  eval(String key) {
    switch (key) {
      case 'state':
        return _selectedState;
      case 'city':
        return _selectedCity;
      case 'subCity':
        return _selectedSubCity;
      default:
        return null;
    }
  }
}
