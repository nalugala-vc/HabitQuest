import 'dart:io';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutech/utils/app_colors.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class ProfileImageWidget extends StatefulWidget {
  final String userName;
  final String imageUrl;

  const ProfileImageWidget({
    super.key,
    required this.userName,
    required this.imageUrl,
  });

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  late String currentImageUrl;

  File? image;

  @override
  void initState() {
    super.initState();
    currentImageUrl = widget.imageUrl; // Initialize with the provided image URL
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    } else {
      // Optional: Handle the case where no image is selected
      debugPrint("No image selected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: _pickImageFromGallery,
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.purple500,
                      width: 2.0,
                    ),
                  ),
                  child: image == null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(currentImageUrl),
                          backgroundColor: Colors.transparent,
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(image!),
                          backgroundColor: Colors.transparent,
                        )),
              const Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: HeroIcon(
                    HeroIcons.pencil,
                    color: AppColors.purple500,
                    style: HeroIconStyle.solid,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        spaceW15,
        RobotoCondensed(
          text: widget.userName,
          fontSize: 24,
        ),
      ],
    );
  }
}
