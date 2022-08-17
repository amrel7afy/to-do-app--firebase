class TaskModel{

  late final String text;
  late final String taskId;
  late bool status;
  late final String date;
  late final String time;
  TaskModel({required this.text,required this.status,required this.date,required this.time,required this.taskId});

  TaskModel.fromJson(Map<String,dynamic>json) :
  text=json['text'],
  taskId=json['taskId'],
  status=json['status'],
  time=json['time'],
  date=json['date'];

  Map<String,dynamic> toMap(){
    return {
      'text':text,
      'taskId':taskId,
      'status':status,
      'time':time,
      'date':date,
    };
  }
}