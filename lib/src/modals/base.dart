abstract class BaseModel {
  final int id;
  BaseModel({required this.id});
}

class Annonymous extends BaseModel {
  Annonymous({required id}) : super(id: id);
}
