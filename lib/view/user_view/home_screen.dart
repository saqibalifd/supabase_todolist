// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:supabasetodolist/constant/app_colors.dart';
import 'package:supabasetodolist/provider/feature_provider.dart/auth_provider.dart';
import 'package:supabasetodolist/provider/feature_provider.dart/note_provider.dart';
import 'package:supabasetodolist/provider/feature_provider.dart/profile_provider.dart';
import 'package:supabasetodolist/view/user_view/add_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      NoteProvider noteProvider = Provider.of<NoteProvider>(
        context,
        listen: false,
      );
      ProfileProvider profileProvider = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );

      noteProvider.getNotes(context);
      profileProvider.fetchUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = context.read<AuthProvider>();

    ProfileProvider profileProvider = context.read<ProfileProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.profileBackGround,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.save)),
          IconButton(
            onPressed: () {
              authProvider.signOut(context);
            },
            icon: Icon(Icons.logout, color: AppColors.primaryColor),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 229.h,
            decoration: BoxDecoration(color: AppColors.profileBackGround),
            child: Consumer<ProfileProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (provider.userList.isEmpty) {
                  return Text('user not found');
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50.r,

                            backgroundImage: NetworkImage(
                              profileProvider.userList.first.image.toString(),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                _showImagePickerBottomSheet(context);
                              },
                              child: Icon(
                                Icons.add_a_photo,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Welcome , ${profileProvider.userList.first.name}',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  );
                }
              },
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
                  return Center(child: CircularProgressIndicator());
                } else if (provider.noteList.isEmpty) {
                  return Center(child: Text('Note list is empty'));
                } else if (provider.noteList.isNotEmpty) {
                  return ListView.builder(
                    itemCount: provider.noteList.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Card(
                        color: AppColors.tileColor,
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

  void _showImagePickerBottomSheet(BuildContext context) {
    ProfileProvider profileProvider = context.read<ProfileProvider>();
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: AppColors.greenColor),
                title: Text('Select from Camera'),
                onTap: () {
                  profileProvider.updateProfilePicture(
                    ImageSource.camera,
                    context,
                  );
                  // _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: AppColors.buttonBackGround,
                ),
                title: Text('Select from Gallery'),
                onTap: () {
                  profileProvider.updateProfilePicture(
                    ImageSource.gallery,
                    context,
                  );

                  // _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
