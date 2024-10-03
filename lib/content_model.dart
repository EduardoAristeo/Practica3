class UnbordingContent {
  final String image;
  final String title;
  final String discription;

  UnbordingContent({
    required this.image,
    required this.title,
    required this.discription,
  });
}

List<UnbordingContent> contents = [
  UnbordingContent(
    title: 'Compra a distancia',
    image: 'assets/quality.svg',
    discription: "Compra iPhones de última generación, MacBooks, iPads, Apple Watch y más. "
    "Compra en línea y recibe en la puerta de tu casa."

  ),
  UnbordingContent(
    title: 'Entregas Rapidas',
    image: 'assets/delevery.svg',
    discription: "Te enviamos tus productos en el menor tiempo posible. "
    "Compra en línea y recibe en la puerta de tu casa."

  ),
  UnbordingContent(
    title: 'Gana Premios',
    image: 'assets/reward.svg',
    discription: "Compra en línea y recibe en la puerta de tu casa. "
    "Puedes ganar premios y descuentos en tus próximas compras.")
];
