class Post {
  int id;
  String title, category, text, image;
  bool isDeleted;
  Post({this.id, this.title, this.category, this.text, this.image});

  factory Post.fromMap(Map<String, dynamic> json) => new Post(
        id: json["id"],
        title: json['title'], 
        category: json['category'], 
        text: json['text'],
        image: json['image']
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        'title' : title,
        'category': category,   
        'text' : text,  
        'image' : image 
      };

   
  /*Map<String, dynamic> toMap() {  
    //var map = <String, dynamic>{  
      'id': id,  
      'title' : title,
      'category': category,   
      'text' : text,  
      'image' : image 
    //};  
    //return map;  
  }  
   
  Post.fromMap(Map<String, dynamic> map) {  
    id = map['id'];  
    title = map['title']; 
    category = map['category']; 
    text = map['text'];  
    image = map['image']; 
  } */ 
  

}