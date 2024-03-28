import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planet_phone_dashboard/utils/images/app_images.dart';

import '../../../../utils/size/app_size.dart';
import '../../../../utils/styles/app_text_styles.dart';

class ProfilePhotoView extends StatefulWidget {
  const ProfilePhotoView({super.key, required this.photoUrl});

  final String? photoUrl;

  @override
  State<ProfilePhotoView> createState() => _ProfilePhotoViewState();
}

class _ProfilePhotoViewState extends State<ProfilePhotoView> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Stack(children: [
      CircleAvatar(
        radius: 40.w,
        child: ClipOval(
          child: widget.photoUrl == null
              ? SvgPicture.asset(AppImages.profilePhoto)
              : Image.network(
                  widget.photoUrl!,
                ),
        ),
      ),
      Positioned(
        bottom: -5,
        right: -5,
        child: Material(
          color: Colors.transparent,
          child: IconButton(
            splashRadius: 20,
            onPressed: () {
              showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  XFile? pickedFile = await _picker.pickImage(
                                    maxWidth: 1920,
                                    maxHeight: 2000,
                                    source: ImageSource.camera,
                                  );
                                },
                                icon: const Icon(Icons.camera_alt),
                              ),
                              Text(
                                'Camera',
                                style: AppTextStyles.sfProRoundedSemiBold
                                    .copyWith(fontSize: 14),
                              )
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  XFile? pickedFile = await _picker.pickImage(
                                    maxWidth: 1000,
                                    maxHeight: 1000,
                                    source: ImageSource.gallery,
                                  );
                                },
                                icon: const Icon(Icons.photo),
                              ),
                              Text(
                                'Gallery',
                                style: AppTextStyles.sfProRoundedSemiBold
                                    .copyWith(fontSize: 14),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  });
            },
            icon: const Icon(Icons.camera_alt),
          ),
        ),
      )
    ]);
  }
}
