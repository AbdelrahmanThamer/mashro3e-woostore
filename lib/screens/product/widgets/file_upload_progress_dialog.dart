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
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quiver/strings.dart';

import '../../../controllers/navigationController.dart';
import '../../../generated/l10n.dart';
import '../../../locator.dart';
import '../../../models/models.dart';

class FileUploadProgressDialog extends StatefulWidget {
  const FileUploadProgressDialog({
    Key? key,
    required this.addon,
  }) : super(key: key);
  final ProductFileUploadAddon addon;

  @override
  State<FileUploadProgressDialog> createState() =>
      _FileUploadProgressDialogState();
}

class _FileUploadProgressDialogState extends State<FileUploadProgressDialog> {
  File? selectedFile;
  Response? response;
  String? progress;
  String? error;
  bool success = false;

  /// The url where the file is stored
  String? value;
  Exception? exception;

  @override
  void initState() {
    super.initState();
    selectedFile = widget.addon.file;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      uploadFile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Icon(Icons.cloud_upload_outlined),
              Text(
                '${lang.uploading} ${lang.file}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              if (!success && isBlank(error)) const LinearProgressIndicator(),
              if (isNotBlank(error)) const SizedBox(height: 10),
              if (isNotBlank(error))
                Text(
                  error!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 10),
              if (!success)
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  onPressed: () {
                    NavigationController.navigator.pop(
                      exception ?? Exception('Cancelled by user'),
                    );
                  },
                  child: Text(lang.cancel),
                )
              else
                TextButton(
                  onPressed: () {
                    if (isNotBlank(value)) {
                      NavigationController.navigator.pop(
                        {'value': value},
                      );
                    } else {
                      NavigationController.navigator.pop(
                        Exception(
                          'File upload url is empty, please upload the file again',
                        ),
                      );
                    }
                  },
                  child: Text(lang.done),
                )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> uploadFile() async {
    try {
      // Function Log
      Dev.debugFunction(
        functionName: 'uploadFile',
        className: '_FileUploadProgressDialogState',
        fileName: 'file_upload_progress_dialog.dart',
        start: true,
      );

      if (selectedFile == null) {
        // show a file picker again to select a file
        throw Exception('No file selected to upload');
      }

      final response = await LocatorService.cartViewModel()
          .wooService
          .cart
          .uploadProductAddonFile(
            file: selectedFile!,
            onSendProgress: (int sent, int total) {
              final String percentage = (sent / total * 100).toStringAsFixed(2);
              setState(() {
                progress = '$sent Bytes of ' '$total Bytes\n' +
                    percentage +
                    ' % uploaded';
              });
            },
          );

      if (response.statusCode == 200) {
        // add the returned file upload response URL value to the
        setState(() {
          value = response.data['url'];
          success = true;
          error = null;
          exception = null;
        });
      }
    } catch (e, s) {
      Dev.error('File upload error', error: e, stackTrace: s);
      if (mounted) {
        setState(() {
          error = ExceptionUtils.renderException(e);
          success = false;
          exception = e as Exception;
        });
      }
    }
  }

// Future<void> pickImage() async {
//   try {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         fileType = ProductAddOnFileType.image;
//         mediaFile = image;
//         file = null;
//       });
//     }
//   } catch (e, s) {
//     Dev.error('Image picker error', error: e, stackTrace: s);
//     UiController.showErrorNotification(
//       context: context,
//       title: 'Issue encountered',
//       message: ExceptionUtils.renderException(e),
//     );
//   }
// }
//
// Future<void> pickFile() async {
//   try {
//     FilePickerResult? result;
//
//     if (widget.sectionData.allowedExtensions.isNotEmpty) {
//       result = await FilePicker.platform.pickFiles(
//         allowedExtensions: widget.sectionData.allowedExtensions.toList(),
//         type: FileType.custom,
//       );
//     } else {
//       result = await FilePicker.platform.pickFiles();
//     }
//     if (result != null) {
//       final File temp = File(result.files.single.path!);
//       setState(() {
//         file = temp;
//         fileType = ProductAddOnFileType.any;
//         mediaFile = null;
//       });
//     }
//   } catch (e, s) {
//     Dev.error('Pick file error', error: e, stackTrace: s);
//     UiController.showErrorNotification(
//       context: context,
//       title: 'Issue encountered',
//       message: ExceptionUtils.renderException(e),
//     );
//   }
// }
}
