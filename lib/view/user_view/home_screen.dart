// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:todo_list/View/auth_view/login_in_Screen.dart';
import 'package:todo_list/View/user_view/add_note_screen.dart';
import 'package:todo_list/constant/app_colors.dart';
import 'package:todo_list/models/note_model.dart';
import 'package:todo_list/provider/feature_provider.dart/auth_provider.dart';
import 'package:todo_list/provider/feature_provider.dart/note_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 229.h,
            decoration: BoxDecoration(color: AppColors.profileBackGround),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 285.w),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },
                    icon: Icon(Icons.logout, color: AppColors.primaryColor),
                  ),
                ),

                CircleAvatar(
                  radius: 50.r,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                Text(
                  'Welcome , Oliva Grace',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Task List',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp),
              ),
            ),
          ),

          Expanded(
            child: Consumer<NoteProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (provider.noteList.isEmpty) {
                  return Center(child: Text('Note list is empty'));
                } else if (provider.noteList.isNotEmpty) {
                  return ListView.builder(
                    itemCount:
                        provider.noteList.length, // Adjust based on your model
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 20.w,
                      ),
                      child: Card(
                        color: AppColors.tileColor.withValues(alpha: .3),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 15.h,
                          ),
                          leading: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: AppColors.profileBackGround,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddNoteScreen(
                                    description:
                                        provider.noteList[index].description,
                                    title: provider.noteList[index].title,
                                    edit: true,
                                    docId: provider.noteList[index].id,
                                  ),
                                ),
                              );
                            },
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: AppColors.profileBackGround,
                            ),
                            onPressed: () {
                              provider.deleteNote(
                                context,
                                provider.noteList[index].id,
                              );
                            },
                          ),
                          title: Text(
                            provider.noteList[index].title.toString(),
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            provider.noteList[index].description.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (provider.noteList == null) {
                  return const Center(child: Text('No data found.'));
                }
                return Container();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.buttonBackGround,
        onPressed: () {
          // noteProvider.getNotes(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNoteScreen(edit: false)),
          );
        },
        child: Icon(Icons.add, color: AppColors.primaryColor),
      ),
    );
  }
}
