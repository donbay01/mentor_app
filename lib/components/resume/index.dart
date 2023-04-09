import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/services/picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io' show File;

class Resume extends StatelessWidget {
  final UserModel user;
  final Function(File) onFileChanged;
  final UploadTask? task;

  const Resume({
    super.key,
    required this.user,
    required this.onFileChanged,
    this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (task != null) ...[
          StreamBuilder(
            stream: task!.snapshotEvents,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!;
                var progress = data.bytesTransferred / data.totalBytes;
                return LinearProgressIndicator(
                  value: progress,
                );
              }

              return SizedBox.shrink();
            },
          ),
        ],
        TextButton(
          onPressed: () async {
            var file = await Picker.pickFile();
            return onFileChanged(file!);
          },
          child: Text('Upload a file'),
        ),
      ],
    );
  }
}
