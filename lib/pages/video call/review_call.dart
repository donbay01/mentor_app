import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';

class ReviewCall extends StatefulWidget {
  const ReviewCall({Key? key}) : super(key: key);

  @override
  State<ReviewCall> createState() => _ReviewCallState();
}

class _ReviewCallState extends State<ReviewCall> {
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Rate your session with your paddy',
                style: medium(),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.star_border_outlined,size: 40,color: textGrey,),
                  Icon(Icons.star_border_outlined,size: 40,color: textGrey,),
                  Icon(Icons.star_border_outlined,size: 40,color: textGrey,),
                  Icon(Icons.star_border_outlined,size: 40,color: textGrey,),
                  Icon(Icons.star_border_outlined,size: 40,color: textGrey,),

                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Message (Optional)',
                style: smallText(textGrey),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: reviewController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Leave a review message',
                  hintStyle: smallText(greyText),
                  suffixIcon: reviewController.text.isEmpty
                      ? Container(
                          width: 0,
                        )
                      : IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            reviewController.clear();
                          },
                        ),
                  filled: true,
                  fillColor: primaryWhite,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: greyText,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: primaryBlue,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: (){}, child: Text('Not now',style: medium(),)),
                  ElevatedButton(onPressed: (){}, child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Submit',style: medium(),),
                  ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(32)
                      )
                    ),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
