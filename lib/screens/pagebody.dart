// import 'package:flutter/material.dart';

// import '../models/fixture.dart';
// import '../widgets/matchtile.dart';

// Widget PageBody(List<Fixture> allmatches,int round) {
//   return Expanded(
//     flex: 5,
//     child: Container(
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         color: Color(0xFF4373D9),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(40.0),
//           topRight: Radius.circular(40.0),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text(
//               "MATCHES",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24.0,
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: allmatches.length,
//                 itemBuilder: (context, index) {
//                   return matchTile(allmatches[index],round,context);
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }
