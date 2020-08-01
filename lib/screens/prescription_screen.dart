// import 'package:amun/Prescription_handler/bloc/prescription_bloc.dart';
// import 'package:amun/Prescription_handler/event/set_prescriptions.dart';
// import 'package:amun/db/database_provider.dart';
// import 'package:amun/input_widgets/new_prescription.dart';
// import 'package:amun/items/prescription_item.dart';
// import 'package:amun/models/Prescription.dart';
// import 'package:flutter/material.dart';
//// import 'package:flutter_bloc/flutter_bloc.dart';

// class PrescriptionScreen extends StatefulWidget {
//   static final routeName = 'route name';
//   @override
//   _PrescriptionScreenState createState() => _PrescriptionScreenState();
// }

// class _PrescriptionScreenState extends State<PrescriptionScreen> {
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   DatabaseProvider.db.getPrescriptions().then(
//   //     (prescriptionList) {
//   //       BlocProvider.of<PrescriptionBloc>(context)
//   //           .add(SetPrescription(prescriptionList));
//   //     },
//   //   );
//   // }

//   void startAddNewRecord(BuildContext ctx) {
//     showModalBottomSheet(
//         context: ctx,
//         builder: (_) {
//           return GestureDetector(
//             child: NewPrescriptionOrRadiograph("Prescription"),
//             onTap: () {},
//             behavior: HitTestBehavior.opaque,
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Prescription")),
//       body: Container(
//         child: BlocConsumer<PrescriptionBloc, List<Prescription>>(
//           builder: (context, prescriptionList) {
//             return ListView.separated(
//               itemBuilder: (BuildContext context, int index) {
//                 return PrescriptionItemOrRadiograph();
//               },
//               itemCount: prescriptionList.length,
//               separatorBuilder: (BuildContext context, int index) =>
//                   Divider(color: Colors.black),
//             );
//           },
//           listener: (BuildContext context, prescriptionList) {},
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () => startAddNewRecord(context),
//       ),
//     );
//   }
// }
