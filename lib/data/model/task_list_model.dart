class TaskListModel {
  String? title;
  String? description;
  String? status;
  String? email;
  String? createdDate;
  String? sId;

  TaskListModel(
      {this.title,
        this.description,
        this.status,
        this.email,
        this.createdDate,
        this.sId});

  TaskListModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    status = json['status'];
    email = json['email'];
    createdDate = json['createdDate'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['email'] = email;
    data['createdDate'] = createdDate;
    data['_id'] = sId;
    return data;
  }

}