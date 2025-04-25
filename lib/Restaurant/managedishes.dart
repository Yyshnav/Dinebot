// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ManageDishesScreen extends StatelessWidget {
//   final List<Map<String, String>> dishes = [
//     {'name': 'Grilled Steak', 'image': 'assets/dishh.jpeg'},
//     {'name': 'Pasta Carbonara', 'image': 'assets/dishh.jpeg'},
//     {'name': 'Caesar Salad', 'image': 'assets/dishh.jpeg'},
//     {'name': 'Margherita Pizza', 'image': 'assets/dishh.jpeg'},
//     {'name': 'Cheesecake', 'image': 'assets/dishh.jpeg'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Manage Dishes',
//           style: GoogleFonts.pacifico(fontSize: 24, color: Colors.white),
//         ),
//         backgroundColor: Colors.black,
//         centerTitle: true,
//       ),
//       backgroundColor: Colors.black,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: dishes.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     color: Colors.grey[900],
//                     margin: EdgeInsets.symmetric(vertical: 10),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: ListTile(
//                       contentPadding: EdgeInsets.all(12),
//                       leading: ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.asset(
//                           dishes[index]['image']!,
//                           width: 80,
//                           height: 80,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       title: Text(
//                         dishes[index]['name']!,
//                         style: GoogleFonts.inter(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                       trailing: IconButton(
//                         icon: Icon(Icons.delete, color: Colors.redAccent),
//                         onPressed: () {
//                           // Handle dish deletion
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.amber,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 minimumSize: Size(double.infinity, 50),
//               ),
//               onPressed: () {
//                 // Add new dish action
//               },
//               child: Text(
//                 'Add New Dish',
//                 style: GoogleFonts.inter(
//                   fontSize: 18,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';

// import '../api/loginApi.dart'; // Ensure baseurl and lid are defined
// import '../api/registerApi.dart';

// class ManageDishesScreen extends StatefulWidget {
//   @override
//   _ManageDishesScreenState createState() => _ManageDishesScreenState();
// }

// class _ManageDishesScreenState extends State<ManageDishesScreen> {
//   List<Map<String, dynamic>> dishes = [];
//   final _dio = Dio();

//   final _nameController = TextEditingController();
//   final _priceController = TextEditingController();
//   final _descriptionController = TextEditingController();

//   File? _selectedImage;
//   final ImagePicker _picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     fetchDishes();
//   }

//   Future<void> fetchDishes() async {
//     try {
//       final response = await _dio.get('$baseurl/viewdishes/$lid');
//       print(response);
//       if (response.statusCode == 200) {
//         setState(() {
//           dishes = List<Map<String, dynamic>>.from(response.data);
//         });
//       }
//     } catch (e) {
//       print('Error fetching dishes: $e');
//     }
//   }

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> addDish() async {
//     if (_selectedImage == null) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Please select an image')));
//       return;
//     }

//     try {
//       String fileName = _selectedImage!.path.split('/').last;
//       FormData data = FormData.fromMap({
//         'name': _nameController.text,
//         'price': _priceController.text,
//         'description': _descriptionController.text,
//         'image': await MultipartFile.fromFile(
//           _selectedImage!.path,
//           filename: fileName,
//         ),
//         "lid": lid,
//       });

//       final response = await _dio.post('$baseurl/adddishes', data: data);

//       if (response.statusCode == 201 || response.statusCode == 200) {
//         await fetchDishes(); // refresh dishes
//         _nameController.clear();
//         _priceController.clear();
//         _descriptionController.clear();
//         _selectedImage = null;
//         Navigator.pop(context);
//       }
//     } catch (e) {
//       print('Error adding dish: $e');
//     }
//   }

//   void _showAddDishBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       backgroundColor: Colors.black,
//       context: context,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//             left: 20,
//             right: 20,
//             top: 20,
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Text(
//                   'Add New Dish',
//                   style: GoogleFonts.pacifico(
//                     fontSize: 24,
//                     color: Colors.amber,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 _buildTextField(_nameController, 'Dish Name'),
//                 _buildTextField(_priceController, 'Price'),
//                 _buildTextField(
//                   _descriptionController,
//                   'Description',
//                   maxLines: 3,
//                 ),
//                 GestureDetector(
//                   onTap: _pickImage,
//                   child: Container(
//                     height: 150,
//                     margin: EdgeInsets.only(top: 15),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[900],
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.amber),
//                     ),
//                     child:
//                         _selectedImage == null
//                             ? Center(
//                               child: Text(
//                                 'Tap to select image',
//                                 style: TextStyle(color: Colors.white70),
//                               ),
//                             )
//                             : ClipRRect(
//                               borderRadius: BorderRadius.circular(12),
//                               child: Image.file(
//                                 _selectedImage!,
//                                 fit: BoxFit.cover,
//                                 width: double.infinity,
//                               ),
//                             ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.amber,
//                     minimumSize: Size(double.infinity, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   onPressed: addDish,
//                   child: Text(
//                     'Add Dish',
//                     style: GoogleFonts.inter(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildTextField(
//     TextEditingController controller,
//     String label, {
//     int maxLines = 1,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 15.0),
//       child: TextField(
//         controller: controller,
//         maxLines: maxLines,
//         style: TextStyle(color: Colors.white),
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: TextStyle(color: Colors.amber),
//           filled: true,
//           fillColor: Colors.grey[900],
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(
//       //     'Manage Dishes',
//       //     style: GoogleFonts.pacifico(fontSize: 24, color: Colors.white),
//       //   ),
//       //   backgroundColor: Colors.black,
//       //   centerTitle: true,
//       // ),
//       backgroundColor: Colors.black,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child:
//             dishes.isEmpty
//                 ? Center(child: CircularProgressIndicator(color: Colors.amber))
//                 : ListView.builder(
//                   itemCount: dishes.length,
//                   itemBuilder: (context, index) {
//                     final dish = dishes[index];
//                     return Card(
//                       color: Colors.grey[900],
//                       margin: EdgeInsets.symmetric(vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: ListTile(
//                         contentPadding: EdgeInsets.all(12),
//                         leading: ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: Image.network(
//                             baseurl + dish['image'] ?? '',
//                             width: 80,
//                             height: 80,
//                             fit: BoxFit.cover,
//                             errorBuilder:
//                                 (_, __, ___) => Icon(
//                                   Icons.broken_image,
//                                   color: Colors.white,
//                                 ),
//                           ),
//                         ),
//                         title: Text(
//                           dish['name'] ?? '',
//                           style: GoogleFonts.inter(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         ),
//                         subtitle: Text(
//                           '₹${dish['price'] ?? ''}\n${dish['description'] ?? ''}',
//                           style: TextStyle(color: Colors.white70),
//                         ),
//                         isThreeLine: true,
//                       ),
//                     );
//                   },
//                 ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.amber,
//         onPressed: () => _showAddDishBottomSheet(context),
//         child: Icon(Icons.add, color: Colors.black),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:dinebot/user/togleloginui.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../api/loginApi.dart';
import '../api/registerApi.dart';

class ManageDishesScreen extends StatefulWidget {
  @override
  _ManageDishesScreenState createState() => _ManageDishesScreenState();
}

class _ManageDishesScreenState extends State<ManageDishesScreen> {
  List<Map<String, dynamic>> dishes = [];
  final _dio = Dio();

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool isLoading = true;

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    fetchDishes();
  }

  Future<void> fetchDishes() async {
    try {
      final response = await _dio.get('$baseurl/viewdishes/$lid');
      print(response);

      if (response.statusCode == 200) {
        setState(() {
          dishes = List<Map<String, dynamic>>.from(response.data);isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching dishes: $e');
      setState(() {
    isLoading = false;
  });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> addDish() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select an image')));
      return;
    }

    try {
      String fileName = _selectedImage!.path.split('/').last;
      FormData data = FormData.fromMap({
        'name': _nameController.text,
        'price': _priceController.text,
        'description': _descriptionController.text,
        'image': await MultipartFile.fromFile(
          _selectedImage!.path,
          filename: fileName,
        ),
        'lid': lid,
      });

      final response = await _dio.post('$baseurl/adddishes', data: data);
      print(response);

      if (response.statusCode == 201 || response.statusCode == 200) {
        await fetchDishes();
        _nameController.clear();
        _priceController.clear();
        _descriptionController.clear();
        _selectedImage = null;
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error adding dish: $e');
    }
  }

  Future<void> _updateDish(int id) async {
    try {
      FormData data = FormData.fromMap({
        'id': id,
        'name': _nameController.text,
        'price': _priceController.text,
        'description': _descriptionController.text,
        'lid': lid,
        if (_selectedImage != null)
          'image': await MultipartFile.fromFile(_selectedImage!.path),
      });

      final response = await _dio.post('$baseurl/editdishes', data: data);
      print(response);

      if (response.statusCode == 200) {
        await fetchDishes();
        _nameController.clear();
        _priceController.clear();
        _descriptionController.clear();
        _selectedImage = null;
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error updating dish: $e');
    }
  }

  Future<void> _deleteDish(int id) async {
    try {
      final response = await _dio.post('$baseurl/deletedish/$id');
      print(response);
      if (response.statusCode == 200) {
        fetchDishes();
      }
    } catch (e) {
      print('Error deleting dish: $e');
    }
  }

  void _showAddDishBottomSheet(
    BuildContext context, {
    bool isEdit = false,
    Map<String, dynamic>? dish,
  }) {
    if (isEdit && dish != null) {
      _nameController.text = dish['name'];
      _priceController.text = dish['price'].toString();
      _descriptionController.text = dish['description'];
      _selectedImage = null;
    }

    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  isEdit ? 'Edit Dish' : 'Add New Dish',
                  style: GoogleFonts.pacifico(
                    fontSize: 24,
                    color: Colors.amber,
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField(_nameController, 'Dish Name'),
                _buildTextField(_priceController, 'Price'),
                _buildTextField(
                  _descriptionController,
                  'Description',
                  maxLines: 3,
                ),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amber),
                    ),
                    child:
                        _selectedImage == null
                            ? Center(
                              child: Text(
                                'Tap to select image',
                                style: TextStyle(color: Colors.white70),
                              ),
                            )
                            : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed:
                      () =>
                          isEdit && dish != null
                              ? _updateDish(dish['id'])
                              : addDish(),
                  child: Text(
                    isEdit ? 'Update Dish' : 'Add Dish',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.amber),
          filled: true,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   // actions: [
      //   //   IconButton(
      //   //     onPressed: () {
      //   //       Navigator.pushAndRemoveUntil(
      //   //         context,
      //   //         MaterialPageRoute(builder: (context) => ToggleLoginPage()),
      //   //         (Route) => false,
      //   //       );
      //   //     },
      //   //     icon: Icon(Icons.logout, size: 30, color: Colors.white),
      //   //   ),
      //   // ],
      // ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.amber))
                : dishes.isEmpty
                ? Center(
                  child: Text(
                    'No dishes found',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                )
                : ListView.builder(
                  itemCount: dishes.length,
                  itemBuilder: (context, index) {
                    final dish = dishes[index];
                    return Card(
                      color: Colors.grey[900],
                      margin: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(12),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            baseurl + dish['image'],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (_, __, ___) => Icon(
                                  Icons.broken_image,
                                  color: Colors.white,
                                ),
                          ),
                        ),
                        title: Text(
                          dish['name'] ?? '',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          '₹${dish['price'] ?? ''}\n${dish['description'] ?? ''}',
                          style: TextStyle(color: Colors.white70),
                        ),
                        isThreeLine: true,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.amber),
                              onPressed:
                                  () => _showAddDishBottomSheet(
                                    context,
                                    isEdit: true,
                                    dish: dish,
                                  ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteDish(dish['id']),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () => _showAddDishBottomSheet(context),
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
