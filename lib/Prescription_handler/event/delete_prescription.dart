import 'package:amun/Prescription_handler/event/precription_event.dart';

class DeletePrescription extends PrescriptionEvent {
  int prescriptionIndex;

  DeletePrescription(int index) {
    prescriptionIndex = index;
  }
}