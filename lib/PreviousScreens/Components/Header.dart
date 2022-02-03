import 'dart:io';

import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_file_manager/flutter_file_manager.dart';

import '../../Database.dart';

class Header extends StatelessWidget {
  final File files;
  final int index;

  Header(this.index, this.files);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        children: [
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              "Image Preview ${1 + 1} of ${1}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          Container(
            width: 450,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.5)),
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      // var dirs, files;
                      // List dirsWithFiles = [];
                      // var fm = FileManager(root: Directory(accessiblePath!));
                      // dirs = await fm.dirsTree();
                      // for (var dir in dirs) {
                      //   bool condition = false;
                      //   files = await FileManager(root: Directory(dir.path))
                      //       .filesTree(
                      //     excludedPaths: [],
                      //     extensions: ["png", "jpg"],
                      //   );
                      //   for (int i = 0; i < dir.path.split("\\").length; i++) {
                      //     if (dir.path.split("\\")[i] == "Clustured Image") {
                      //       condition = true;
                      //     }
                      //     if (dir.path.split("\\")[i] == "Others") {
                      //       condition = true;
                      //     }
                      //     if (dir.path.split("\\")[i] == "Confused") {
                      //       condition = true;
                      //     }
                      //   }
                      //   if (files.length != 0) {
                      //     if (condition) {
                      //       dirsWithFiles.add(dir);
                      //     }
                      //   }
                      // }
                      // currentItem = "";
                      // currentIndex = 0;
                      // // Navigator.push(
                      // //   context,
                      // //   MaterialPageRoute(
                      // //     builder: (context) {
                      // //       return DirectoryScreen(dirsWithFiles);
                      // //     },
                      // //   ),
                      // // );
                    },
                    child: Text(
                      "Folder Path",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.centerLeft,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.5)),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
<<<<<<< HEAD
                      files.path
                          .split("\\")
                          .sublist(files.path.split("\\").length - 1,
                          files.path.split("\\").length)
                          .join("\\"),
=======
                      // accessibleFilePath!
                      //     .split("\\")
                      //     .sublist(accessiblePath!.split("\\").length - 1,
                      //         accessibleFilePath!.split("\\").length)
                      //     .join("\\"),
                      "here it is",
>>>>>>> f863f6648d8f228269429c87e2edde90ab7a2895
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            width: 12,
          ),
        ],
      ),
    );
  }
}
