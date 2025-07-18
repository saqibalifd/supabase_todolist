// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabasetodolist/constant/app_colors.dart';
import 'package:supabasetodolist/provider/feature_provider.dart/note_provider.dart';
import 'package:supabasetodolist/widgets/custom_field_widget.dart';
import 'package:supabasetodolist/widgets/main_button_widget.dart';

class AddNoteScreen extends StatefulWidget {
  final String? title;
  final String? description;
  bool? edit;
  String? docId;
  AddNoteScreen({
    super.key,
    this.title,
    this.description,
    this.edit,
    this.docId,
  });

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController titleControler = TextEditingController();

  TextEditingController descriptionControler = TextEditingController();
  @override
  void initState() {
    super.initState();
    titleControler = TextEditingController(text: widget.title);
    descriptionControler = TextEditingController(text: widget.description);
  }

  @override
  Widget build(BuildContext context) {
    NoteProvider noteProvider = context.read<NoteProvider>();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.edit == false || widget.edit == null
                  ? 'Create Note'
                  : 'Edit Note',
              style: TextStyle(
                color: AppColors.buttonBackGround,
                fontSize: 29.sp,
              ),
            ),
            SizedBox(height: 30.h),
            CustomFieldWidget(text: 'Title', controller: titleControler),
            SizedBox(height: 10.h),
            CustomFieldWidget(
              text: 'Dscription',

              controller: descriptionControler,
            ),
            SizedBox(height: 30.h),
            Consumer<NoteProvider>(
              builder: (context, provider, child) => MainButtonWidget(
                text: widget.edit == false || widget.edit == null
                    ? 'Add'
                    : 'Edit',
                isLoading: provider.isLoading,
                ontap: () {
                  widget.edit == false || widget.edit == null
                      ? noteProvider.addNote(
                          context,
                          titleControler.text.toString(),
                          descriptionControler.text.toString(),
                        )
                      : noteProvider.updateNote(
                          context,
                          widget.docId.toString(),
                          titleControler.text.toString(),
                          descriptionControler.text.toString(),
                          widget.docId.toString(),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
