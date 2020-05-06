class Item{
  String id;
  String cardId;
  String title;
  String status;
  String qtytype;
  String qtysize;


  Item(this.id, this.cardId, this.title, this.status, this.qtytype,
      this.qtysize);

  Item.formMap (Map snapshot, String id):
        id = id ?? '',
        cardId = snapshot['cardid'] ?? '',
        title = snapshot['title'] ?? '',
        status = snapshot['status'] ?? '',
        qtytype = snapshot['qtytype'] ?? '',
        qtysize = snapshot['qtysize'] ?? '';

  toJson(){
    return{
      "cardid":cardId,
      "title":title,
      "status":status,
      "qtytype":qtytype,
      "qtysize":qtysize,
    };
  }


}