// import 'package:flutter/material.dart';

// class AppsGrid extends StatelessWidget {
//   final List<Map<String, String>> apps;

//   const AppsGrid({
//     Key? key,
//     required this.apps,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 25.0),
//         child: GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, // 2 columns
//             crossAxisSpacing: 30,
//             mainAxisSpacing: 15,
//           ),
//           itemCount: apps.length,
//           itemBuilder: (context, index) {
//             final app = apps[index];
//             return GestureDetector(
//               onTap: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('${app['name']} pressed')),
//                 );
//               },
//               child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(15),
                    
//                   ),
//                   child: Column(
                    
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         app['icon']!,
//                         height: 60,
//                         width: 60,
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         app['name']!,
                        
//                         style: const TextStyle(color: Colors.black,
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class AppsGrid extends StatelessWidget {
  final List<Map<String, String>> apps;

  const AppsGrid({
    Key? key,
    required this.apps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 30,
          mainAxisSpacing: 15,
        ),
        itemCount: apps.length,
        itemBuilder: (context, index) {
          final app = apps[index];
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${app['name']} pressed')),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[400] : Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    app['icon']!,
                    height: 60,
                    width: 60,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    app['name']!,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white60 : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

