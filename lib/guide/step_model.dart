class StepModel {
  final int id;
  final String text;

  StepModel({this.id, this.text});

  static List<StepModel> list = [
    StepModel(
      id: 1,
      text: "Bienvenue\!\nEBS est une application mobile à pour but d'échanger les connaissances entre les étudiants.  ",
    ),
    StepModel(
      id: 2,
      text:
          "EBS\nVous aide à trouver des étudiants qui peuvent vous accompagner à résoudres vos problèmes",
    ),
    StepModel(
      id: 3,
      text: "Economisez du temps et de l'énergie tout en utilisant EBS dans vos études\!",
    ),
  ];
}
