// Copyright (c) 2022 Aniket Malik [aniketmalikwork@gmail.com]
// All Rights Reserved.
//
// NOTICE: All information contained herein is and remains the
// property of Aniket Malik. The intellectual and technical concepts
// contained herein are proprietary to Aniket Malik and are protected
// by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material
// is strictly forbidden unless prior written permission is obtained from
// Aniket Malik.

import 'dart:io';

import 'package:am_common_packages/am_common_packages.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' show basename;
import 'package:quiver/strings.dart';
import 'package:woocommerce/models/woo_product_add_on.dart';

import '../../../../app_builder/app_builder.dart';
import '../../../../controllers/uiController.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/models.dart';
import '../../viewModel/productViewModel.dart';
import '../shared.dart';

class PSProductAddOnSectionLayout extends ConsumerWidget {
  const PSProductAddOnSectionLayout({
    super.key,
    required this.data,
  });

  final PSProductAddOnSectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<WooProductAddOn>? productAddOns = ref
        .read(providerOfProductViewModel)
        .currentProduct
        .wooProduct
        .productAddOns;
    if (productAddOns == null || productAddOns.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: productAddOns
          .map((e) => _ProductAddOnItem(
                data: e,
                sectionData: data,
              ))
          .toList(),
    );
  }
}

class _ProductAddOnItem extends StatelessWidget {
  const _ProductAddOnItem({
    Key? key,
    required this.data,
    required this.sectionData,
  }) : super(key: key);
  final WooProductAddOn data;
  final PSProductAddOnSectionData sectionData;

  @override
  Widget build(BuildContext context) {
    if (data.type == WooProductAddOnType.multipleChoice) {
      return PSStyledContainerLayout(
        styledData: sectionData.styledData,
        child: _MultipleChoiceAddOn(
          addOn: data,
          sectionData: sectionData,
        ),
      );
    }

    if (data.type == WooProductAddOnType.checkbox) {
      return PSStyledContainerLayout(
        styledData: sectionData.styledData,
        child: _CheckboxAddOn(
          addOn: data,
          sectionData: sectionData,
        ),
      );
    }

    if (data.type == WooProductAddOnType.shortText) {
      return PSStyledContainerLayout(
        styledData: sectionData.styledData,
        child: _ShortTextAddOn(
          addOn: data,
          sectionData: sectionData,
        ),
      );
    }

    if (data.type == WooProductAddOnType.longText) {
      return PSStyledContainerLayout(
        styledData: sectionData.styledData,
        child: _LongTextAddOn(
          addOn: data,
          sectionData: sectionData,
        ),
      );
    }

    if (data.type == WooProductAddOnType.fileUpload) {
      return PSStyledContainerLayout(
        styledData: sectionData.styledData,
        child: _FileUploadAddOn(
          addOn: data,
          sectionData: sectionData,
        ),
      );
    }

    return const SizedBox();
  }
}

class _MultipleChoiceAddOn extends ConsumerStatefulWidget {
  const _MultipleChoiceAddOn({
    Key? key,
    required this.addOn,
    required this.sectionData,
  }) : super(key: key);
  final WooProductAddOn addOn;
  final PSProductAddOnSectionData sectionData;

  @override
  ConsumerState<_MultipleChoiceAddOn> createState() =>
      _MultipleChoiceAddOnState();
}

class _MultipleChoiceAddOnState extends ConsumerState<_MultipleChoiceAddOn> {
  WooProductAddOn get addOn => widget.addOn;

  // For single selection
  WooProductAddOnOption? selectedValue;

  String? imagePriceRender;

  WooProductAddOn get addon => widget.addOn;

  @override
  void initState() {
    super.initState();

    // check if the add on is already selected
    final product = ref.read(providerOfProductViewModel).currentProduct;
    if (product.selectedProductAddons.isNotEmpty) {
      // check if the addon is selected
      for (final selectedAddon in product.selectedProductAddons) {
        if (selectedAddon.name == addon.name) {
          // loop through the options and set the selected option if the widget
          for (final option in addon.options) {
            if (option.label == selectedAddon.value) {
              selectedValue = option;
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeadingAndClearButton(
            heading: addOn.name,
            required: addOn.required > 0,
            onClear: _onClear,
            enableClearButton: selectedValue != null,
          ),
          if (isNotBlank(imagePriceRender)) const SizedBox(height: 10),
          AnimatedContainer(
            height: isNotBlank(imagePriceRender) ? 15 : 0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.fastLinearToSlowEaseIn,
            child: isNotBlank(imagePriceRender)
                ? Text(imagePriceRender!)
                : const SizedBox(),
          ),
          const SizedBox(height: 15),
          _MultipleChoiceOptions(
            addOn: widget.addOn,
            onSelected: _onSelected,
            selectedValue: selectedValue,
            sectionData: widget.sectionData,
          ),
        ],
      ),
    );
  }

  void _onSelected(WooProductAddOnOption? val) {
    if (val == null) {
      return;
    }

    selectedValue = val;

    if (val.label == 'None') {
      _onClear();
      return;
    }

    if (widget.addOn.display == WooProductAddOnDisplayType.images) {
      imagePriceRender = val.renderLabel(currency: ParseEngine.currencySymbol);
    }

    final product = ref.read(providerOfProductViewModel).currentProduct;
    product.addProductAddon(
      ProductSelectedAddon(
        name: addon.name,
        value: val.label,
        price: val.price,
        priceType: val.priceType,
        fieldType: addOn.type,
      ),
    );
    if (mounted) {
      setState(() {});
    }
  }

  void _onClear() {
    if (selectedValue == null) {
      return;
    }
    final product = ref.read(providerOfProductViewModel).currentProduct;

    product.removeProductAddon(addon.name);

    selectedValue = null;
    imagePriceRender = null;

    if (mounted) {
      setState(() {});
    }
  }
}

class _MultipleChoiceOptions extends StatelessWidget {
  const _MultipleChoiceOptions({
    Key? key,
    required this.addOn,
    this.selectedValue,
    required this.onSelected,
    required this.sectionData,
  }) : super(key: key);
  final WooProductAddOn addOn;
  final WooProductAddOnOption? selectedValue;
  final void Function(WooProductAddOnOption?) onSelected;
  final PSProductAddOnSectionData sectionData;

  @override
  Widget build(BuildContext context) {
    if (addOn.display == WooProductAddOnDisplayType.dropdown) {
      final list = addOn.required <= 0
          ? [const WooProductAddOnOption(label: 'None'), ...addOn.options]
          : addOn.options;
      return DropdownButton<WooProductAddOnOption>(
        value: selectedValue ?? const WooProductAddOnOption(label: 'None'),
        borderRadius: ThemeGuide.borderRadius10,
        isExpanded: true,
        underline: const SizedBox(),
        onChanged: onSelected,
        items: list
            .map<DropdownMenuItem<WooProductAddOnOption>>(
              (e) => DropdownMenuItem<WooProductAddOnOption>(
                child: Text(
                  e.renderLabel(currency: ParseEngine.currencySymbol),
                  style: sectionData.styledData.textStyleData.createTextStyle(),
                ),
                value: e,
              ),
            )
            .toList(),
      );
    }

    if (addOn.display == WooProductAddOnDisplayType.radioButton) {
      return Column(
        children: addOn.options
            .map<Widget>(
              (e) => RadioListTile<String?>(
                selectedTileColor: Colors.red,
                tileColor: Colors.red,
                groupValue: selectedValue?.label,
                title: Text(
                  e.renderLabel(currency: ParseEngine.currencySymbol),
                  style: sectionData.styledData.textStyleData.createTextStyle(),
                ),
                contentPadding: const EdgeInsets.all(0),
                value: e.label,
                onChanged: (val) {
                  onSelected(e);
                },
              ),
            )
            .toList(),
      );
    }

    if (addOn.display == WooProductAddOnDisplayType.images) {
      final theme = Theme.of(context);
      return Wrap(
        children: addOn.options
            .map(
              (e) => GestureDetector(
                onTap: () => onSelected(e),
                child: AnimatedContainer(
                  margin: ThemeGuide.marginH5,
                  padding: ThemeGuide.padding5,
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: ThemeGuide.borderRadius10,
                    border: Border.all(
                      color: selectedValue == e
                          ? theme.colorScheme.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  height: sectionData.multipleChoiceImageDimensions.height,
                  width: sectionData.multipleChoiceImageDimensions.width,
                  child: ExtendedCachedImage(imageUrl: e.imageUrl),
                ),
              ),
            )
            .toList(),
      );
    }
    return const SizedBox();
  }
}

class _CheckboxAddOn extends ConsumerStatefulWidget {
  const _CheckboxAddOn({
    Key? key,
    required this.addOn,
    required this.sectionData,
  }) : super(key: key);

  final WooProductAddOn addOn;
  final PSProductAddOnSectionData sectionData;

  @override
  ConsumerState<_CheckboxAddOn> createState() => _CheckboxAddOnState();
}

class _CheckboxAddOnState extends ConsumerState<_CheckboxAddOn> {
  // For multiple selection
  Set<WooProductAddOnOption>? selectedValues;

  WooProductAddOn get addon => widget.addOn;

  @override
  void initState() {
    super.initState();

    // check if the add on is already selected
    final Product product = ref.read(providerOfProductViewModel).currentProduct;
    if (product.selectedProductAddons.isNotEmpty) {
      // check if the addon values is selected
      for (final selectedAddon in product.selectedProductAddons) {
        if (selectedAddon.name == addon.name) {
          // loop through the options and set the selected option in the widget
          for (final option in addon.options) {
            if (option.label == selectedAddon.value) {
              selectedValues ??= {};
              selectedValues!.add(option);
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HeadingAndClearButton(
          heading: widget.addOn.name,
          required: widget.addOn.required > 0,
          onClear: _onClear,
          enableClearButton: selectedValues?.isNotEmpty ?? false,
        ),
        ...widget.addOn.options
            .map<Widget>(
              (e) => CheckboxListTile(
                title: Text(
                  e.renderLabel(currency: ParseEngine.currencySymbol),
                  style: widget.sectionData.styledData.textStyleData
                      .createTextStyle(),
                ),
                contentPadding: const EdgeInsets.all(0),
                value: selectedValues?.contains(e) ?? false,
                onChanged: (bool? val) {
                  final Set<WooProductAddOnOption> tempSet =
                      selectedValues ?? {};
                  if (val != null && val) {
                    // add to list
                    tempSet.add(e);
                  } else {
                    // remove
                    tempSet.remove(e);
                  }
                  _onSelectCheckbox(tempSet);
                },
              ),
            )
            .toList()
      ],
    );
  }

  void _onSelectCheckbox(Set<WooProductAddOnOption> val) {
    final Set<ProductSelectedAddon> temp = {};
    for (final option in val) {
      temp.add(
        ProductSelectedAddon(
          name: addon.name,
          value: option.label,
          price: option.price,
          priceType: option.priceType,
          fieldType: addon.type,
        ),
      );
    }

    final Product product = ref.read(providerOfProductViewModel).currentProduct;
    product.addCheckboxProductAddons(temp);

    selectedValues = val;

    if (mounted) {
      setState(() {});
    }
  }

  void _onClear() {
    if (selectedValues == null) {
      return;
    }

    final Product product = ref.read(providerOfProductViewModel).currentProduct;
    product.removeProductAddon(addon.name);
    selectedValues = null;
    if (mounted) {
      setState(() {});
    }
  }
}

class _ShortTextAddOn extends ConsumerStatefulWidget {
  const _ShortTextAddOn({
    Key? key,
    required this.addOn,
    required this.sectionData,
  }) : super(key: key);
  final WooProductAddOn addOn;
  final PSProductAddOnSectionData sectionData;

  @override
  ConsumerState<_ShortTextAddOn> createState() => _ShortTextAddOnState();
}

class _ShortTextAddOnState extends ConsumerState<_ShortTextAddOn> {
  final TextEditingController shortText = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  WooProductAddOn get addon => widget.addOn;

  @override
  void initState() {
    super.initState();

    // check if the add on is already selected
    final Product product = ref.read(providerOfProductViewModel).currentProduct;
    if (product.selectedProductAddons.isNotEmpty) {
      // check if the addon is added
      for (final selectedAddon in product.selectedProductAddons) {
        if (selectedAddon.name == addon.name) {
          shortText.text = selectedAddon.value;
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HeadingAndClearButton(
          heading: widget.addOn.name,
          required: widget.addOn.required > 0,
          onClear: () {
            final Product product =
                ref.read(providerOfProductViewModel).currentProduct;
            product.removeProductAddon(addon.name);

            shortText.text = '';
            if (_focusNode.hasFocus) {
              _focusNode.unfocus();
            }
            if (mounted) {
              setState(() {});
            }
          },
          enableClearButton: shortText.text.isNotEmpty,
        ),
        const SizedBox(height: 10),
        TextFormField(
          focusNode: _focusNode,
          controller: shortText,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose([
            if (addon.required > 0) FormBuilderValidators.required(),
            if (widget.addOn.min > 0)
              FormBuilderValidators.minLength(widget.addOn.min),
            if (widget.addOn.max > 0)
              FormBuilderValidators.maxLength(widget.addOn.max),
          ]),
          buildCounter: (
            context, {
            int? currentLength,
            bool? isFocused,
            int? maxLength,
          }) {
            String buffer = currentLength.toString();
            if (maxLength != null) {
              buffer += '/$maxLength';
            }
            return Text(
              buffer,
              style: const TextStyle(color: Colors.grey),
            );
          },
          maxLength: widget.addOn.max > 0 ? widget.addOn.max : null,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(
            fillColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          onChanged: (val) {
            if (isBlank(val)) {
              final Product product =
                  ref.read(providerOfProductViewModel).currentProduct;
              product.removeProductAddon(addon.name);
              return;
            }

            if (val.length > addon.min) {
              final Product product =
                  ref.read(providerOfProductViewModel).currentProduct;
              product.addProductAddon(
                ProductSelectedAddon(
                  name: addon.name,
                  value: val,
                  price: addon.price,
                  priceType: addon.priceType,
                  fieldType: addon.type,
                ),
              );

              if (mounted) {
                setState(() {});
              }
            }
          },
          onEditingComplete: () {
            if (shortText.text.length < addon.min) {
              // show error notification
              UiController.showErrorNotification(
                context: context,
                title: S.of(context).invalid,
                message:
                    'Value must be in the range ${addon.min} - ${addon.max}',
              );
            }
            if (_focusNode.hasFocus) {
              _focusNode.unfocus();
            }
          },
        ),
      ],
    );
  }
}

class _LongTextAddOn extends ConsumerStatefulWidget {
  const _LongTextAddOn({
    Key? key,
    required this.addOn,
    required this.sectionData,
  }) : super(key: key);
  final WooProductAddOn addOn;
  final PSProductAddOnSectionData sectionData;

  @override
  ConsumerState<_LongTextAddOn> createState() => _LongTextAddOnState();
}

class _LongTextAddOnState extends ConsumerState<_LongTextAddOn> {
  final TextEditingController longText = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  WooProductAddOn get addon => widget.addOn;

  @override
  void initState() {
    super.initState();

    // check if the add on is already selected
    final Product product = ref.read(providerOfProductViewModel).currentProduct;
    if (product.selectedProductAddons.isNotEmpty) {
      // check if the addon is added
      for (final selectedAddon in product.selectedProductAddons) {
        if (selectedAddon.name == addon.name) {
          longText.text = selectedAddon.value;
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HeadingAndClearButton(
          heading: widget.addOn.name,
          required: widget.addOn.required > 0,
          onClear: () {
            final Product product =
                ref.read(providerOfProductViewModel).currentProduct;
            product.removeProductAddon(addon.name);

            longText.text = '';
            if (_focusNode.hasFocus) {
              _focusNode.unfocus();
            }
            if (mounted) {
              setState(() {});
            }
          },
          enableClearButton: longText.text.isNotEmpty,
        ),
        const SizedBox(height: 10),
        TextFormField(
          minLines: 3,
          maxLines: 6,
          focusNode: _focusNode,
          controller: longText,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose([
            if (addon.required > 0) FormBuilderValidators.required(),
            if (widget.addOn.min > 0)
              FormBuilderValidators.minLength(widget.addOn.min),
            if (widget.addOn.max > 0)
              FormBuilderValidators.maxLength(widget.addOn.max),
          ]),
          buildCounter: (
            context, {
            int? currentLength,
            bool? isFocused,
            int? maxLength,
          }) {
            String buffer = currentLength.toString();
            if (maxLength != null) {
              buffer += '/$maxLength';
            }
            return Text(
              buffer,
              style: const TextStyle(color: Colors.grey),
            );
          },
          maxLength: widget.addOn.max > 0 ? widget.addOn.max : null,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(
            fillColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          onChanged: (val) {
            if (isBlank(val)) {
              final Product product =
                  ref.read(providerOfProductViewModel).currentProduct;
              product.removeProductAddon(addon.name);
              if (mounted) {
                setState(() {});
              }
              return;
            }
            // Check for the min max before saving the text
            if (val.length > addon.min) {
              final Product product =
                  ref.read(providerOfProductViewModel).currentProduct;
              product.addProductAddon(
                ProductSelectedAddon(
                  name: addon.name,
                  value: val,
                  price: addon.price,
                  priceType: addon.priceType,
                  fieldType: addon.type,
                ),
              );
            }
            if (mounted) {
              setState(() {});
            }
          },
        ),
        if (isNotBlank(longText.text))
          TextButton(
            child: Text(S.of(context).submit),
            onPressed: () {
              if (longText.text.length < addon.min) {
                // show error notification
                UiController.showErrorNotification(
                  context: context,
                  title: S.of(context).invalid,
                  message:
                      'Value must be in the range ${addon.min} - ${addon.max}',
                );
              }
              if (_focusNode.hasFocus) {
                _focusNode.unfocus();
              }
            },
          ),
      ],
    );
  }
}

class _FileUploadAddOn extends ConsumerStatefulWidget {
  const _FileUploadAddOn({
    Key? key,
    required this.addOn,
    required this.sectionData,
  }) : super(key: key);
  final WooProductAddOn addOn;
  final PSProductAddOnSectionData sectionData;

  @override
  ConsumerState<_FileUploadAddOn> createState() => _FileUploadAddOnState();
}

class _FileUploadAddOnState extends ConsumerState<_FileUploadAddOn> {
  File? file;
  XFile? mediaFile;
  bool isImageFileType = false;
  String? error;

  @override
  void initState() {
    super.initState();

    final Product product = ref.read(providerOfProductViewModel).currentProduct;
    if (product.fileUploadAddonData != null) {
      if (product.fileUploadAddonData!.file.existsSync()) {
        final String? mimeStr = lookupMimeType(
          product.fileUploadAddonData!.file.path,
        );
        if (isBlank(mimeStr)) {
          file = product.fileUploadAddonData!.file;
          isImageFileType = false;
        } else {
          final fileTypeArray = mimeStr!.split('/');
          if (fileTypeArray.contains('image')) {
            mediaFile = XFile(product.fileUploadAddonData!.file.path);
            isImageFileType = true;
          } else {
            file = product.fileUploadAddonData!.file;
            isImageFileType = false;
          }
        }
      } else {
        // selected file does not exist so show an error
        error = 'Cannot find file: ${product.fileUploadAddonData!.name}';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Icon(
            EvaIcons.cloudUploadOutline,
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.addOn.name,
                style: const TextStyle(color: Colors.grey),
              ),
              if (widget.addOn.required > 0) const SizedBox(width: 5),
              if (widget.addOn.required > 0)
                const Text(
                  '*',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          if (file == null && mediaFile == null)
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                InkWell(
                  onTap: pickImage,
                  child: _FileUploadAddOnItemButton(
                    icon: const Icon(
                      EvaIcons.imageOutline,
                      size: 30,
                    ),
                    text: lang.image,
                  ),
                ),
                InkWell(
                  onTap: pickFile,
                  child: _FileUploadAddOnItemButton(
                    icon: const Icon(
                      EvaIcons.fileTextOutline,
                      size: 30,
                    ),
                    text: lang.file,
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                _FileUploadPreviewWidget(
                  file: file ?? File(mediaFile!.path),
                  isImageFileType: isImageFileType,
                ),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  onPressed: () {
                    final Product product =
                        ref.read(providerOfProductViewModel).currentProduct;
                    if (product.fileUploadAddonData != null) {
                      // remove this
                      product.fileUploadAddonData = null;
                    }

                    file = null;
                    mediaFile = null;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Text(lang.remove),
                ),
              ],
            ),
          if (isNotBlank(error)) const SizedBox(height: 10),
          if (isNotBlank(error))
            Text(
              error!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
        ],
      ),
    );
  }

  Future<void> pickImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final Product product =
            ref.read(providerOfProductViewModel).currentProduct;
        product.fileUploadAddonData = ProductFileUploadAddon(
          file: File(image.path),
          name: widget.addOn.name,
          price: widget.addOn.price,
          priceType: widget.addOn.priceType,
          // value should be added at the checkout
        );

        setState(() {
          isImageFileType = true;
          mediaFile = image;
          file = null;
          error = null;
        });
      }
    } catch (e, s) {
      Dev.error('Image picker error', error: e, stackTrace: s);
      UiController.showErrorNotification(
        context: context,
        title: 'Issue encountered',
        message: ExceptionUtils.renderException(e),
      );
    }
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result;

      if (widget.sectionData.allowedExtensions?.isNotEmpty ?? false) {
        result = await FilePicker.platform.pickFiles(
          allowedExtensions: widget.sectionData.allowedExtensions!.toList(),
          type: FileType.custom,
        );
      } else {
        result = await FilePicker.platform.pickFiles();
      }
      if (result != null) {
        final File temp = File(result.files.single.path!);
        final Product product =
            ref.read(providerOfProductViewModel).currentProduct;
        product.fileUploadAddonData = ProductFileUploadAddon(
          file: temp,
          name: widget.addOn.name,
          price: widget.addOn.price,
          priceType: widget.addOn.priceType,
          // value should be added at the checkout
        );
        setState(() {
          file = temp;
          isImageFileType = false;
          mediaFile = null;
          error = null;
        });
      }
    } catch (e, s) {
      Dev.error('Pick file error', error: e, stackTrace: s);
      UiController.showErrorNotification(
        context: context,
        title: 'Issue encountered',
        message: ExceptionUtils.renderException(e),
      );
    }
  }
}

class _FileUploadPreviewWidget extends StatelessWidget {
  const _FileUploadPreviewWidget({
    Key? key,
    this.file,
    this.isImageFileType = false,
  }) : super(key: key);
  final File? file;
  final bool isImageFileType;

  @override
  Widget build(BuildContext context) {
    if (file == null) {
      return const SizedBox();
    }

    if (isImageFileType) {
      return ClipRRect(
        borderRadius: ThemeGuide.borderRadius10,
        child: Image.file(
          file!,
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        ),
      );
    }
    return Container(
      padding: ThemeGuide.padding20,
      decoration: BoxDecoration(
        borderRadius: ThemeGuide.borderRadius10,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Text(
        basename(file!.path),
        style: const TextStyle(fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _FileUploadAddOnItemButton extends StatelessWidget {
  const _FileUploadAddOnItemButton({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);
  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withAlpha(150),
        borderRadius: ThemeGuide.borderRadius,
      ),
      width: 80,
      child: Column(
        children: [
          icon,
          const SizedBox(height: 10),
          Text(text),
        ],
      ),
    );
  }
}

class _HeadingAndClearButton extends StatelessWidget {
  const _HeadingAndClearButton({
    Key? key,
    required this.heading,
    required this.required,
    required this.onClear,
    this.enableClearButton = false,
  }) : super(key: key);

  final String heading;
  final bool required, enableClearButton;
  final void Function() onClear;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: const TextStyle(color: Colors.grey),
        ),
        if (required) const SizedBox(width: 5),
        if (required)
          const Text(
            '*',
            style: TextStyle(
              fontSize: 12,
              color: Colors.red,
            ),
          ),
        if (!required) const Spacer(),
        if (!required)
          GestureDetector(
            onTap: onClear,
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastLinearToSlowEaseIn,
              child: Text(S.of(context).clear),
              style: enableClearButton
                  ? const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    )
                  : const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
            ),
          ),
      ],
    );
  }
}
