class HomeModel {
  final String imgPath;
  final bool isLiked;
  final String title;
  final String autor;
  final String shortAutor;
  final String time;
  final String text;

  const HomeModel(
      {required this.imgPath,
      required this.isLiked,
      required this.title,
      required this.autor,
      required this.shortAutor,
      required this.time,
      required this.text});
}
