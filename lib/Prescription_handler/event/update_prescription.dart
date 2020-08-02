
import 'package:amun/Prescription_handler/event/precription_event.dart';
import 'package:amun/models/Prescription.dart';

class UpdatePrescription extends PrescriptionEvent {
  Prescription newPrescription;
  int prescriptionIndex
  ;

  UpdatePrescription(int index, Prescription prescription) {
    newPrescription = prescription;
    prescriptionIndex = index;
  }
}