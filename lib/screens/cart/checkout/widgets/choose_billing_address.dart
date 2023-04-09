// Copyright (c) 2020 Aniket Malik [aniketmalikwork@gmail.com]
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

// @dart=2.9

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';

import '../../../../controllers/uiController.dart';
import '../../../../developer/dev.log.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../models/address.model.dart';
import '../../../../services/woocommerce/models/models.dart';
import '../../../../shared/widgets/textInput/label.dart';
import '../../../../shared/widgets/textInput/phone_number_text_input.dart';
import '../viewModel/checkout_native_view_model.dart';
import 'bottomButtons.dart';
import 'headline.dart';

class ChooseBillingAddress extends StatelessWidget {
  const ChooseBillingAddress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 20,
            right: 20,
          ),
          child: Headline(title: '${lang.billing} ${lang.address}'),
        ),
        const Divider(
          endIndent: 20,
          indent: 20,
          height: 30,
          thickness: 2.5,
        ),
        const Expanded(child: Body()),
      ],
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BillingAddress address = const BillingAddress.empty();
    if (isNotBlank(LocatorService.userProvider().user.id) &&
        LocatorService.userProvider().user.wooCustomer != null &&
        LocatorService.userProvider().user.wooCustomer.billing != null &&
        isNotBlank(
            LocatorService.userProvider().user.wooCustomer.billing.country) &&
        isNotBlank(
            LocatorService.userProvider().user.wooCustomer.billing.address1) &&
        isNotBlank(
            LocatorService.userProvider().user.wooCustomer.billing.postcode)) {
      address = BillingAddress.fromWooAddress(
        billing: LocatorService.userProvider().user.wooCustomer.billing,
      );
    }

    if (BillingAddress.isValid(
        Provider.of<CheckoutNativeViewModel>(context, listen: false)
            .billingAddress)) {
      address = Provider.of<CheckoutNativeViewModel>(context, listen: false)
          .billingAddress;
    }
    return _AddressForm(address: address);
  }
}

class _AddressForm extends StatefulWidget {
  const _AddressForm({
    Key key,
    @required this.address,
  }) : super(key: key);

  final BillingAddress address;

  @override
  __AddressFormState createState() => __AddressFormState();
}

class __AddressFormState extends State<_AddressForm> {
  GlobalKey<FormBuilderState> _fKey = GlobalKey<FormBuilderState>();
  GlobalKey<FormState> _f2Key = GlobalKey<FormState>();

  BillingAddress newAddress;

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
    countries = null;
    newAddress = null;
    _fKey = null;
    _f2Key = null;

    countries = null;
    selectedCountryStates = null;
    super.dispose();
  }

  Future<void> _loadCountries() async {
    try {
      final result =
          await LocatorService.wooService().getCountriesFromLocalAsset();

      // Set the selected country
      final WooCountry _selectedCountry = result.firstWhere(
          (element) => element.code == widget.address.country,
          orElse: () => WooCountry.empty(code: widget.address.country));

      // Update the country field
      selectedCountry = _selectedCountry;

      if (isBlank(_selectedCountry.code)) {
        selectedCountry = result.first;
      }

      // Set the selected country states
      final List<WooState> _selectedCountryStates =
          _selectedCountry.states ?? const [];

      // Set the selected state
      final WooState _selectedState = _selectedCountryStates.isNotEmpty
          ? _selectedCountryStates.firstWhere(
              (element) => element.code == widget.address.state,
              orElse: () => WooState.empty(code: widget.address.state))
          : WooState.empty(code: widget.address.state);

      // Update the state field
      selectedState = _selectedState;

      setState(() {
        countries = result;
        selectedCountryStates = _selectedCountryStates;

        // Set the country and state.
        newAddress = newAddress.copyWith(
          country: selectedCountry.code,
          state: selectedState.code,
        );
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
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Form(
              key: _f2Key,
              child: FormBuilder(
                key: _fKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextInputLabel(label: lang.firstName),
                                FormBuilderTextField(
                                  name: lang.firstName,
                                  maxLines: 1,
                                  initialValue:
                                      Provider.of<CheckoutNativeViewModel>(
                                    context,
                                    listen: false,
                                  ).firstName,
                                  onChanged: (val) {
                                    Provider.of<CheckoutNativeViewModel>(
                                      context,
                                      listen: false,
                                    ).setFirstName = val;
                                  },
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextInputLabel(label: lang.lastName),
                                FormBuilderTextField(
                                  name: lang.lastName,
                                  maxLines: 1,
                                  initialValue:
                                      Provider.of<CheckoutNativeViewModel>(
                                    context,
                                    listen: false,
                                  ).lastName,
                                  onChanged: (val) {
                                    Provider.of<CheckoutNativeViewModel>(
                                      context,
                                      listen: false,
                                    ).setLastName = val;
                                  },
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextInputLabel(label: lang.emailLabel),
                      FormBuilderTextField(
                        name: lang.emailLabel,
                        maxLines: 1,
                        initialValue: newAddress.email,
                        onChanged: (val) =>
                            newAddress = newAddress.copyWith(email: val),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ]),
                      ),
                      const SizedBox(height: 16),
                      TextInputLabel(label: lang.phone),
                      PhoneNumberTextField(
                        initialValue: (widget.address).phone,
                        onChange: (val) =>
                            newAddress = newAddress.copyWith(phone: val),
                      ),
                      if (widget.address is BillingAddress)
                        const SizedBox(height: 16),
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
                          label:
                              '${lang.apartment}, ${lang.unit}, ${lang.etc}'),
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
                        onChanged: (val) =>
                            newAddress = newAddress.copyWith(city: val),
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
                          if (isBlank(val.code)) {
                            return lang.errorEmptyInput;
                          }
                          return null;
                        },
                        popupProps: const PopupProps.dialog(
                          dialogProps:
                              DialogProps(barrierColor: Color(0x50000000)),
                          showSearchBox: true,
                        ),
                        selectedItem: selectedCountry,
                        items: countries,
                        itemAsString: (obj) {
                          var result = obj.name;
                          if (obj.name != null && obj.name.isNotEmpty) {
                            result += ' ';
                            if (obj.code != null && obj.code.isNotEmpty) {
                              result += '( ${obj.code} )';
                            }
                          } else {
                            result = obj.code;
                          }
                          return result;
                        },
                        onChanged: (val) {
                          newAddress = newAddress.copyWith(country: val.code);

                          if (val.states.isNotEmpty) {
                            selectedState = val.states.first;
                          } else {
                            selectedState = const WooState.empty();
                          }
                          // set the states
                          setState(() {
                            selectedCountry = val;
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
                          if (isBlank(val.code)) {
                            return lang.errorEmptyInput;
                          }
                          return null;
                        },
                        popupProps: const PopupProps.dialog(
                          dialogProps:
                              DialogProps(barrierColor: Color(0x50000000)),
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
                          if (obj.name != null && obj.name.isNotEmpty) {
                            result += ' ';
                            if (obj.code != null && obj.code.isNotEmpty) {
                              result += '( ${obj.code} )';
                            }
                          } else {
                            result = obj.code;
                          }
                          return result;
                        },
                        onChanged: (val) {
                          selectedState = val;
                          newAddress = newAddress.copyWith(state: val.code);
                        },
                      ),
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        BottomButtons(
          next: onSubmit,
          showBack: false,
        ),
      ],
    );
  }

  Future<void> onSubmit() async {
    if (_fKey.currentState.saveAndValidate() &&
        _f2Key.currentState.validate()) {
      try {
        final provider =
            Provider.of<CheckoutNativeViewModel>(context, listen: false);

        // Set the new billing address
        provider.setBillingAddress = newAddress;

        if (BillingAddress.isValid(provider.billingAddress)) {
          try {
            FocusScope.of(context).unfocus();
          } catch (_) {}
          provider.next();
          return;
        }
        final lang = S.of(context);
        UiController.showErrorNotification(
          context: context,
          title: '${lang.invalid} ${lang.billing} ${lang.address}',
          message: lang.somethingWentWrong,
        );
      } catch (e, s) {
        Dev.error('Submit Billing Address Checkout', error: e, stackTrace: s);
      }
    }
  }
}
