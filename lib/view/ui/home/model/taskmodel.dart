// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'dart:convert';

List<Task> taskFromJson(String str) => List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) => json.encode(List<dynamic>.from(data.map((x) => x.toInsert())));

class Task {
    int? id;
    String? title;
    String? desc;
    int? iscomplete=0;

    Task({
        this.id,
        this.title,
        this.desc,
        this.iscomplete
    });

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        iscomplete: json["complete"],
    );

    Map<String, dynamic> toUpdate() => {
        "id":id,
        "title": title,
        "desc": desc,
        "complete": iscomplete,
        "status":1
    };
    Map<String, dynamic> toInsert() => {
        
        "title": title,
        "desc": desc,
        "complete": iscomplete,
        "status":1
    };
}
