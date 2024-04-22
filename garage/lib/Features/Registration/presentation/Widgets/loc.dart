import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:garage/Features/Registration/presentation/Widgets/GeoLocation_service.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/core/Dataset/Address.dart';

// LocationSelectorButton(
//           onSelectionDone: (selectedVillage) {
//  ?\ context.read<SignupBloc>().add(villagegot(SelectedvillageS))

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
  String? _selectedVillage;
  void _openSelectionDialog() async {
    String? result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => SelectionDialog(),
    );
    if (result != null) {
      setState(() {
        _selectedVillage = result;
      });
    }
    if (result != null) {
      widget.onSelectionDone(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _openSelectionDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: Kcolor.button,
            shadowColor: Kcolor.button,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
          ),
          child: Text(
            'Select Location',
            style: TextStyle(fontFamily: fontstyles.Gpop, color: Kcolor.bg),
          ),
        ),
        SizedBox(height: 10),
        _selectedVillage != null
            ? Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Kcolor.primary,
                  borderRadius: BorderRadius.circular(
                      5), // Adjust the radius for round edges
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.thumb_up,
                      color: Kcolor.bg,
                    ),
                    SizedBox(
                        width:
                            5), // Adjust the spacing between the icon and text
                    Text(
                      'Selected Village: $_selectedVillage',
                      style: TextStyle(
                          fontFamily: fontstyles.Gpop, color: Kcolor.bg),
                    ),
                  ],
                ),
              )
            : SizedBox.shrink(),
        SizedBox(height: 10),
      ],
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
      elevation: 10,
      scrollable: true,
      surfaceTintColor: Kcolor.bg,
      backgroundColor: Kcolor.bg,
      title: Text('Select Location',
          style: TextStyle(
            color: Kcolor.TextB,
            fontFamily: fontstyles.Gpop,
            fontWeight: FontWeight.w500,
            fontSize: 25,
          )),
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
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Kcolor.button,
                shadowColor: Kcolor.button,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
              ),
              child: Text(
                'Submit',
                style: TextStyle(fontFamily: fontstyles.Gpop, color: Kcolor.bg),
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
      autofocus: true,
      isExpanded: true,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Kcolor.button),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Kcolor.button),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Kcolor.button, width: 2.0),
        ),
      ),
      value: itemKey != null ? eval(itemKey) : _selectedVillage,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((dynamic value) {
        return DropdownMenuItem<String>(
          value: itemKey != null ? value[itemKey] : value,
          child: Text(
            itemKey != null ? value[itemKey] : value,
            style: TextStyle(
              color: Kcolor.TextB,
              fontFamily: fontstyles.Gpop,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
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
