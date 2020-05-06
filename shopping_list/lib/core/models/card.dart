class CardData{
  String id;
  String dateOfCard;
  String title;
  String description;
  String color;
  String iconicSymbol;

  CardData(this.id, this.dateOfCard, this.title, this.description, this.color,
      this.iconicSymbol);

  CardData.fromMap (Map snapshot, String id):
        id = id ?? '',
        dateOfCard = snapshot['dateofcard'] ?? '',
        title = snapshot['title'] ?? '',
        description = snapshot['description'] ?? '',
        color = snapshot['color'] ?? '',
        iconicSymbol = snapshot['iconicsymbol'] ?? '';

  toJson(){
    return{
      "dateofcard":dateOfCard,
      "title":title,
      "description":description,
      "color":color,
      "iconicsymbol":iconicSymbol
    };
  }

}