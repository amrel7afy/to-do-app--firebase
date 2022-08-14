class TaskModel{

  late final String text;
  late final bool status;
  late final String date;
  late final String time;
  TaskModel({required this.text,required this.status,required this.date,required this.time});

  TaskModel.fromJson(Map<String,dynamic>json) :
  text=json['text'],
  status=json['status'],
  time=json['time'],
  date=json['date'];

  Map<String,dynamic> toMap(){
    return {
      'text':text,
      'status':status,
      'time':time,
      'date':date,
    };
  }
}