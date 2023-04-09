// Copyright (c) 2022 Aniket Malik [aniketmalikwork@gmail.com]
// All Rights Reserved.
//
// NOTICE: All information contained herein is, and remains the
// property of Aniket Malik. The intellectual and technical concepts
// contained herein are proprietary to Aniket Malik and are protected
// by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material
// is strictly forbidden unless prior written permission is obtained from
// Aniket Malik.

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:quiver/strings.dart';

import '../../developer/dev.log.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../models/address.model.dart';
import '../../services/woocommerce/woocommerce.service.dart';
import '../../shared/authScreenWidgets/authSreenWidgets.dart';
import '../../shared/widgets/textInput/label.dart';
import '../../shared/widgets/textInput/phone_number_text_input.dart';
import '../../utils/utils.dart';

///
/// ## `Description`
///
/// Update the given address.
///
class UpdateAddress extends StatelessWidget {
  const UpdateAddress({
    Key? key,
    required this.address,
    required this.isShipping,
  }) : super(key: key);

  final Address address;
  final bool isShipping;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    Text _title = Text('${lang.update} ${lang.address}');
    if (isShipping) {
      if (isBlank(address.address1)) {
        _title = Text('${lang.add} ${lang.shipping} ${lang.address}');
      } else {
        _title = Text('${lang.update} ${lang.shipping} ${lang.address}');
      }
    } else {
      if (isBlank(address.address1)) {
        _title = Text('${lang.add} ${lang.billing} ${lang.address}');
      } else {
        _title = Text('${lang.update} ${lang.billing} ${lang.address}');
      }
    }
    return Scaffold(
      appBar: AppBar(title: _title),
      body: _UpdateAddressForm(address: address),
    );
  }
}

class _UpdateAddressForm extends StatefulWidget {
  const _UpdateAddressForm({
    Key? key,
    required this.address,
  }) : super(key: key);

  final Address address;

  @override
  __UpdateAddressFormState createState() => __UpdateAddressFormState();
}

class __UpdateAddressFormState extends State<_UpdateAddressForm> {
  final GlobalKey<FormBuilderState> _fKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormState> _f2Key = GlobalKey<FormState>();

  late Address newAddress;

  bool isLoading = false;
  String errorText = '';

  List<WooCountry> countries = [];
  List<WooState> selectedCountryStates = [];

  WooCountry selectedCountry = const WooCountry.empty();
  WooState selectedState = const WooState.empty();

  @override
  void initState() {
    super.initState();

    newAddress = widget.address;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _loadCountries();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadCountries() async {
    try {
      final result =
          await LocatorService.wooService().getCountriesFromLocalAsset();

      // Set the selected country
      final WooCountry _selectedCountry = result.firstWhere(
          (element) => element.code == widget.address.country,
          orElse: () => WooCountry.empty(code: widget.address.country ?? ''));

      // Update the country field
      selectedCountry = _selectedCountry;

      if (isBlank(_selectedCountry.code)) {
        selectedCountry = result.first;
      }

      // Set the selected country states
      final List<WooState> _selectedCountryStates = _selectedCountry.states;

      // Set the selected state
      final WooState _selectedState = _selectedCountryStates.isNotEmpty
          ? _selectedCountryStates.firstWhere(
              (element) => element.code == widget.address.state,
              orElse: () => WooState.empty(code: widget.address.state ?? ''))
          : WooState.empty(code: widget.address.state ?? '');

      // Update the state field
      selectedState = _selectedState;

      setState(() {
        countries = result;
        selectedCountryStates = _selectedCountryStates;
      });
    } catch (e, s) {
      setState(() {
        countries = [];
        selectedCountryStates = [];
      });
      Dev.error('_loadCountries', error: e, stackTrace: s);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _f2Key,
        child: FormBuilder(
          key: _fKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 50),
            children: <Widget>[
              if (widget.address is BillingAddress) const SizedBox(height: 16),
              if (widget.address is BillingAddress)
                TextInputLabel(label: lang.emailLabel),
              if (widget.address is BillingAddress)
                FormBuilderTextField(
                  name: lang.emailLabel,
                  maxLines: 1,
                  initialValue: (widget.address as BillingAddress).email,
                  onChanged: (val) => newAddress =
                      (newAddress as BillingAddress).copyWith(email: val),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
              if (widget.address is BillingAddress) const SizedBox(height: 16),
              if (widget.address is BillingAddress)
                TextInputLabel(label: lang.phone),
              if (widget.address is BillingAddress)
                PhoneNumberTextField(
                  initialValue: (widget.address as BillingAddress).phone,
                  onChange: (val) => newAddress =
                      (newAddress as BillingAddress).copyWith(phone: val),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(6),
                    FormBuilderValidators.maxLength(12),
                  ]),
                ),
              if (widget.address is BillingAddress) const SizedBox(height: 16),
              TextInputLabel(label: lang.street),
              FormBuilderTextField(
                name: lang.street,
                maxLines: 5,
                minLines: 1,
                initialValue: widget.address.address1,
                onChanged: (val) =>
                    newAddress = newAddress.copyWith(address1: val),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.min(3),
                  FormBuilderValidators.maxLength(100),
                ]),
              ),
              const SizedBox(height: 16),
              TextInputLabel(
                  label: '${lang.apartment}, ${lang.unit}, ${lang.etc}'),
              FormBuilderTextField(
                name: lang.apartment,
                maxLines: 5,
                minLines: 1,
                initialValue: widget.address.address2,
                onChanged: (val) =>
                    newAddress = newAddress.copyWith(address2: val),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.min(2),
                  FormBuilderValidators.maxLength(50),
                ]),
              ),
              const SizedBox(height: 16),
              TextInputLabel(label: lang.city),
              FormBuilderTextField(
                name: lang.city,
                maxLines: 1,
                initialValue: widget.address.city,
                onChanged: (val) => newAddress = newAddress.copyWith(city: val),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.min(2),
                  FormBuilderValidators.maxLength(50),
                ]),
              ),
              const SizedBox(height: 16),
              TextInputLabel(label: lang.postCode),
              FormBuilderTextField(
                name: lang.postCode,
                maxLines: 1,
                initialValue: widget.address.postCode,
                onChanged: (val) =>
                    newAddress = newAddress.copyWith(postCode: val),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.min(5),
                  FormBuilderValidators.maxLength(16),
                ]),
              ),
              const SizedBox(height: 16),
              TextInputLabel(label: lang.country),
              DropdownSearch<WooCountry>(
                validator: (val) {
                  if (isBlank(val?.code)) {
                    return lang.errorEmptyInput;
                  }
                  return null;
                },
                popupProps: const PopupProps.dialog(
                  dialogProps: DialogProps(barrierColor: Color(0x50000000)),
                  showSearchBox: true,
                ),
                selectedItem: selectedCountry,
                items: countries,
                itemAsString: (obj) {
                  String result = obj.name;
                  if (isNotBlank(obj.name)) {
                    result += ' ';
                    if (isNotBlank(obj.code)) {
                      result += '( ${obj.code} )';
                    }
                  } else {
                    result = obj.code;
                  }
                  return result;
                },
                onChanged: (val) {
                  newAddress = newAddress.copyWith(country: val?.code);

                  if (val?.states.isNotEmpty ?? false) {
                    selectedState = val!.states.first;
                  } else {
                    selectedState = const WooState.empty();
                  }
                  // set the states
                  setState(() {
                    selectedCountry = val!;
                    selectedCountryStates = val.states;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextInputLabel(label: lang.state),
              DropdownSearch<WooState>(
                validator: (val) {
                  if (selectedCountryStates.isEmpty) {
                    return null;
                  }
                  if (isBlank(val?.code)) {
                    return lang.errorEmptyInput;
                  }
                  return null;
                },
                popupProps: const PopupProps.dialog(
                  dialogProps: DialogProps(barrierColor: Color(0x50000000)),
                  showSearchBox: true,
                ),
                selectedItem: selectedState,
                enabled: selectedCountryStates.isNotEmpty,
                dropdownButtonProps: DropdownButtonProps(
                  icon: selectedCountryStates.isNotEmpty
                      ? const Icon(Icons.arrow_drop_down)
                      : const SizedBox(),
                ),
                items: selectedCountryStates,
                itemAsString: (obj) {
                  var result = obj.name;
                  if (isNotBlank(obj.name)) {
                    result += ' ';
                    if (isNotBlank(obj.code)) {
                      result += '( ${obj.code} )';
                    }
                  } else {
                    result = obj.code;
                  }
                  return result;
                },
                onChanged: (val) {
                  selectedState = val!;
                  newAddress = newAddress.copyWith(state: val.code);
                },
              ),
              if (errorText.isNotEmpty)
                ShowError(text: errorText)
              else
                const SizedBox(height: 30),
              Submit(
                isLoading: isLoading,
                onPress: onSubmit,
                label: lang.save,
              ),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSubmit() async {
    if (_fKey.currentState!.saveAndValidate() &&
        _f2Key.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
          errorText = '';
        });

        final Map<String, dynamic> updatedInfo = {};

        if (newAddress is BillingAddress) {
          updatedInfo['billing'] = newAddress.toMap();
        } else {
          updatedInfo['shipping'] = newAddress.toMap();
        }

        final result = await LocatorService.userProvider()
            .updateShippingOrBilling(updatedInfo, context: context);

        // If the update action failed
        if (!result) {
          setState(() {
            isLoading = false;
            errorText = S.of(context).somethingWentWrong;
          });
          return;
        }

        setState(() {
          isLoading = false;
          errorText = '';
        });
      } catch (e, s) {
        Dev.error('Submit Update address', error: e, stackTrace: s);
        setState(() {
          isLoading = false;
          errorText = e is WooCommerceError
              ? e.message ?? Utils.renderException(e)
              : Utils.renderException(e);
        });
      }
    }
  }
}
