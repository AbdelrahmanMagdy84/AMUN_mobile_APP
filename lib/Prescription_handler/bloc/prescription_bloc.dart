import 'package:amun/Prescription_handler/event/add_prescription.dart';
import 'package:amun/Prescription_handler/event/delete_prescription.dart';
import 'package:amun/Prescription_handler/event/precription_event.dart';
import 'package:amun/Prescription_handler/event/set_prescriptions.dart';
import 'package:amun/Prescription_handler/event/update_prescription.dart';
import 'package:amun/models/Prescription.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrescriptionBloc extends Bloc<PrescriptionEvent, List<Prescription>> {
  @override
  List<Prescription> get initialState => List<Prescription>();

  @override
  Stream<List<Prescription>> mapEventToState(PrescriptionEvent event) async* {
    if (event is SetPrescription) {
      yield event.prescriptionList;
    } else if (event is AddPrescription) {
      List<Prescription> newState = List.from(state);
      if (event.newPrescription != null) {
        newState.add(event.newPrescription);
      }
      yield newState;
    } else if (event is DeletePrescription) {
      List<Prescription> newState = List.from(state);
      newState.removeAt(event.prescriptionIndex);
      yield newState;
    } else if (event is UpdatePrescription) {
      List<Prescription> newState = List.from(state);
      newState[event.prescriptionIndex] = event.newPrescription;
      yield newState;
    }
  }
}
