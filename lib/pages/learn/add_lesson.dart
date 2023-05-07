import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_paddy/components/input/textfield.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/lesson_model.dart';
import 'package:firebase_storage/firebase_storage.dart' show UploadTask;
import 'package:flutter/material.dart';
import '../../services/picker.dart';
import '../../services/upload.dart';
import '../../theme/color.dart';
import 'package:path/path.dart';

class AddLesson extends StatefulWidget {
  final String courseName;

  const AddLesson({
    super.key,
    required this.courseName,
  });

  @override
  State<AddLesson> createState() => _AddLessonState();
}

class _AddLessonState extends State<AddLesson> {
  LessonModel? lesson;
  final key = GlobalKey<FormFieldState>();
  final name = TextEditingController();
  final description = TextEditingController();

  UploadTask? task;
  String? url;

  pickImage(BuildContext context) async {
    try {
      var file = await Picker.pickImage();
      task = UploadService.upload('courses/${basename(file!.path)}', file);
      setState(() {});

      await task;
      url = await task!.snapshot.ref.getDownloadURL();
      setState(() {});
    } catch (e) {
      var err = e as dynamic;
      setState(() {
        task = null;
        url = null;
      });
      SnackBarHelper.displayToastMessage(
        context,
        err.message,
        primaryBlue,
      );
    }
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    super.dispose();
  }

  save(BuildContext context) {
    if (task == null) {
      return Navigator.pop(context);
    }

    if (url == null && task == null) {
      return SnackBarHelper.displayToastMessage(
        context,
        'Pick a file and upload',
        primaryBlue,
      );
    }

    if (task != null && url == null) {
      return SnackBarHelper.displayToastMessage(
        context,
        'Please wait... File is still uploading',
        primaryBlue,
      );
    }

    lesson = LessonModel(
      name: name.text,
      description: description.text,
      image: url!,
    );
    Navigator.pop(context, lesson);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new lesson to ${widget.courseName}'),
        leading: IconButton(
          onPressed: () => save(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryBlue,
            size: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (task == null) ...[
                GestureDetector(
                  onTap: () => pickImage(context),
                  child: Text('Pick an image'),
                ),
              ] else ...[
                if (url == null) ...[
                  Text('Uploading...'),
                ] else ...[
                  CachedNetworkImage(
                    imageUrl: url!,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  )
                ],
              ],
              CustomTextField(
                label: 'Name',
                controller: name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lesson must have a name';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lesson must have a description';
                  }
                },
                label: 'Description',
                controller: description,
                minLines: 2,
                maxLines: 4,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                  onPressed: () => save(context),
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
