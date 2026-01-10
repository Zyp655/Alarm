import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class SubjectEndpoint extends Endpoint {

  Future<List<Subject>> getSubjects(Session session) async {
    return await Subject.db.find(
      session,
      orderBy: (t) => t.name,
    );
  }

  Future<bool> addSubject(Session session, Subject subject) async {
    try {
      await Subject.db.insertRow(session, subject);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateAbsence(Session session, Subject subject) async {
    await Subject.db.updateRow(session, subject);
  }

  Future<bool> updateSubject (Session session , Subject subject) async{
    try{
      await Subject.db.updateRow(session, subject);
      return true;
    }catch(e){
      return false;
    }
  }

  Future<bool> deleteSubject (Session session , int id)async{
    try{
      await Subject.db.deleteWhere(session, where: (t) => t.id.equals(id));
      return true;
    }catch(e){
      return false;
    }
  }
}