class QuizItem{
  final dynamic img;
  final dynamic answer;
  final dynamic choice;

  QuizItem({
    required this.img,
    required this.answer,
    required this.choice
  });

  factory QuizItem.fromJson(Map<String, dynamic> json){
    return QuizItem(
        img: json['image_url'],
        answer: json['answer'],
        choice: json['choice_list']
    );
  }

}