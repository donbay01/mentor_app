import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_paddy/providers/course.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../services/picker.dart';
import '../../services/upload.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';
import 'package:path/path.dart';

class AddImage extends StatelessWidget {
  const AddImage({super.key});

  pickImage(CourseProvider provider) async {
    var file = await Picker.pickImage();
    var task = UploadService.upload('courses/${basename(file!.path)}', file);

    provider.setTask(task);
    await task;
  }

  @override
  Widget build(BuildContext context) {
    var prov = context.watch<CourseProvider>();

    return Row(
      children: [
        GestureDetector(
          onTap: () => pickImage(prov),
          child: Stack(
            children: [
              if (prov.task == null) ...[
                Container(
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/course.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ] else ...[
                FutureBuilder(
                  future: prov.task!.snapshot.ref.getDownloadURL(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('Uploading...');
                    }

                    return CachedNetworkImage(
                      width: 100,
                      height: 80,
                      fit: BoxFit.cover,
                      imageUrl: snapshot.data!,
                    );
                  },
                ),
              ],
              Positioned(
                top: 0,
                right: 0,
                child: ClipOval(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.white.withOpacity(0.8),
                    child: Icon(FontAwesomeIcons.camera),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        TextButton(
          onPressed: () => pickImage(prov),
          child: Text(
            'Add Image',
            style: mediumText(primaryBlue),
          ),
        ),
      ],
    );
  }
}
