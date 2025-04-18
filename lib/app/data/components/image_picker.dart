import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CommonImagePicker extends StatefulWidget {
  const CommonImagePicker({
    super.key,
    required this.onItemSelected,
    required this.child,
  });
  final dynamic Function(File? selectedValue) onItemSelected;
  final Widget child;

  @override
  State<CommonImagePicker> createState() => _CommonImagePickerState();
}

class _CommonImagePickerState extends State<CommonImagePicker> {
  final picker = ImagePicker();
  File? image;
  String imagePath = "";

  Future getGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedFile!.path);
      if (image != null) {
        imagePath = image!.path;
      }
    });
  }

  Future getCamara() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      image = File(pickedFile!.path);
      if (image != null) {
        imagePath = image!.path;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext bc) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            getCamara().then((value) {
                              Get.back();
                              widget.onItemSelected(image);
                            });
                          },
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                              color: Color(0xffd7d7d7),
                            ),
                            child: const Center(
                              child: Text(
                                'Take a photo',
                                style: TextStyle(
                                  color: Color(0xff007AFF),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Divider(height: 0.5),
                        InkWell(
                          onTap: () {
                            getGallery().then((value) {
                              Get.back();
                              widget.onItemSelected(image);
                            });
                          },
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              color: Color(0xffd7d7d7),
                            ),
                            child: const Center(
                              child: Text(
                                'Choose from library',
                                style: TextStyle(
                                  color: Color(0xff007AFF),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Color(0xff007AFF),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        child: widget.child);
  }
}


