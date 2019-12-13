import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:final_mwinda_app/pages/blog/post.dart';
import 'package:sqflite/sqflite.dart';

class PostDatabaseProvider {
  PostDatabaseProvider._();

  static final PostDatabaseProvider db = PostDatabaseProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "post.db");
    return await openDatabase(path, version: 5,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Post ("
          "id integer primary key AUTOINCREMENT,"
          "title TEXT, "
          "category TEXT, "
          "text TEXT, "
          "image TEXT"
          ")");
    });
  }

  addPostToDatabase(Post post) async {
    final db = await database;
    var raw = await db.insert(
      "Post",
      post.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint("RAW Inserted Post " + raw.toString());

    return raw;
  }

  updatePost(Post post) async {
    final db = await database;
    var response = await db.update("Post", post.toMap(),
        where: "id = ?", whereArgs: [post.id]);
    return response;
  }

  Future<Post> getPostWithId(int id) async {
    final db = await database;
    var response = await db.query("Post", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? Post.fromMap(response.first) : null;
  }

  Future<List<Post>> getAllPosts() async {
    final db = await database;
    var response = await db.query("Post");
    List<Post> list = response.map((c) => Post.fromMap(c)).toList();
    debugPrint("All Post " + list.toString());
    return list;
  }

  deletePostWithId(int id) async {
    final db = await database;
    return db.delete("Post", where: "id = ?", whereArgs: [id]);
  }

  deleteAllPosts() async {
    final db = await database;
    db.delete("Post");
  }
}