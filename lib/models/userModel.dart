class UserModel{
 late final String userName;
 late final String email;
 late final String uId;
 late final String profileImage;
 UserModel({required this.userName,required this.profileImage,required this.email,required this.uId});

 UserModel.formJson(Map<String,dynamic>json)
 :userName=json['userName'],
 email=json['email'],
 uId=json['uId'],
 profileImage=json['profileImage'];

 Map<String,dynamic>toMap(){
  return {
   'userName':userName,
   'email':email,
   'uId':uId,
   'profileImage':profileImage,
  };
 }

}