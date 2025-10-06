import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:kshk/core/utils/constants.dart';
import 'package:kshk/core/utils/helper_functions/get_user_data.dart';
import 'package:kshk/core/utils/models/address_model.dart';
import 'package:kshk/core/widgets/custom_button.dart';
import 'package:kshk/core/widgets/custom_text_form_field.dart';
import 'package:kshk/generated/l10n.dart';

class AddressView extends StatefulWidget {
  const AddressView({super.key, required this.pageController});

  @override
  State<AddressView> createState() => _AddressViewState();
  final PageController pageController;
}

class _AddressViewState extends State<AddressView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedAddress();
  }

  Future<void> _loadSavedAddress() async {
    try {
      var box = Hive.box<AddressModel>(kAddressBox);
      if (box.isNotEmpty) {
        // Get the last saved address
        final savedAddress = box.getAt(box.length - 1);
        if (savedAddress != null) {
          _nameController.text = savedAddress.name ?? getUserData().fullName;
          _phoneController.text = savedAddress.phoneNumber ?? "";
          _addressController.text = savedAddress.address ?? "";
          _cityController.text = savedAddress.city ?? "";
          _streetAddressController.text = savedAddress.streetAddress ?? "";
          _countryController.text = savedAddress.country ?? "";
          _postalCodeController.text = savedAddress.postalCode ?? "";
        }
      }
    } catch (e) {
      log('Error loading address: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveAddress() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final addressModel = AddressModel(
        name: _nameController.text.trim(),
        phoneNumber: _nameController.text.trim(),
        address: _addressController.text.trim(),
        city: _cityController.text.trim(),
        streetAddress: _streetAddressController.text.trim(),
        country: _countryController.text.trim(),
        postalCode: _postalCodeController.text.trim(),
      );

      try {
        var box = Hive.box<AddressModel>(kAddressBox);
        await box.clear();
        await box.add(addressModel);
        widget.pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error saving address: $e')));
        }
      }
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _streetAddressController.dispose();
    _countryController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  String? name, address, city, streetAddress, country, postalCode, phoneNumber;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 20,
            children: [
              SizedBox(height: 20),
              CustomTextFormField(
                controller: _nameController,
                prefixIcon: null,
                hintText: S.of(context).name,
                onSaved: (val) {
                  name = val;
                },
              ),
              CustomTextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                prefixIcon: null,
                hintText: S.of(context).phone_number,
                onSaved: (val) {
                  phoneNumber = val;
                },
              ),
              CustomTextFormField(
                controller: _addressController,
                prefixIcon: null,
                hintText: S.of(context).address,
                onSaved: (val) {
                  address = val;
                },
              ),
              CustomTextFormField(
                controller: _cityController,
                prefixIcon: null,
                hintText: S.of(context).city,
                onSaved: (val) {
                  city = val;
                },
              ),
              CustomTextFormField(
                controller: _streetAddressController,
                prefixIcon: null,
                hintText: S.of(context).street_address,
                onSaved: (val) {
                  streetAddress = val;
                },
              ),
              CustomTextFormField(
                controller: _countryController,
                prefixIcon: null,
                hintText: S.of(context).country,
                onSaved: (val) {
                  country = val;
                },
              ),
              CustomTextFormField(
                controller: _postalCodeController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                prefixIcon: null,
                hintText: S.of(context).postal_code,
                onSaved: (val) {
                  postalCode = val;
                },
              ),

              CustomButton(
                text: S.of(context).continue_button,
                onPressed: () async {
                  await _saveAddress();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
