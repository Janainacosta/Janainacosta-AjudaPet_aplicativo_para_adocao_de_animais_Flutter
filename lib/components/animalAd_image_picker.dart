import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AnimalAdImagePicker extends StatefulWidget {
  final void Function(File image) onImagePick;

  const AnimalAdImagePicker({required this.onImagePick, super.key});

  @override
  State<AnimalAdImagePicker> createState() => _AnimalAdImagePickerState();
}

class _AnimalAdImagePickerState extends State<AnimalAdImagePicker> {
  File? _imagem;

  Future<void> _pickImage() async{
    final picker = ImagePicker();
    final pickedImage =  await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth:  150,
    );
    if (pickedImage != null){
      setState(() {
        _imagem = File(pickedImage.path);
      });

      widget.onImagePick(_imagem!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _imagem != null ?  FileImage(_imagem!) : null,
        ),
        TextButton(
          onPressed: _pickImage, 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image,
              color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 10),
              Text('Insira a imagem do Pet')
            ],
          ),
        ),
      ],
    );
  }
}

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart' as syspaths;

// class AnimalAdImagePicker extends StatefulWidget {
//   final Function onSelectImage;

//   AnimalAdImagePicker(this.onSelectImage);

//   @override
//   _AnimalAdImagePickerState createState() => _AnimalAdImagePickerState();
// }

// class _AnimalAdImagePickerState extends State<AnimalAdImagePicker> {
//   File _storedImage;

//   _takePicture() async {
//     final ImagePicker _picker = ImagePicker();
//     final PickedFile imageFile = await _picker.getImage(
//       source: ImageSource.camera,
//       maxWidth: 600,
//     );

//     if (imageFile == null) return;

//     setState(() {
//       _storedImage = File(imageFile.path);
//     });

//     final appDir = await syspaths.getApplicationDocumentsDirectory();
//     String fileName = path.basename(_storedImage.path);
//     final savedImage = await _storedImage.copy(
//       '${appDir.path}/$fileName',
//     );
//     widget.onSelectImage(savedImage);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         Container(
//           width: 180,
//           height: 100,
//           decoration: BoxDecoration(
//             border: Border.all(width: 1, color: Colors.grey),
//           ),
//           alignment: Alignment.center,
//           child: _storedImage != null
//               ? Image.file(
//                   _storedImage,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 )
//               : Text('Nenhuma imagem!'),
//         ),
//         SizedBox(width: 10),
//         Expanded(
//           child: TextButton.icon(
//             icon: Icon(Icons.camera,
//             color: Theme.of(context).primaryColor,),
//             label: Text('Tirar Foto'),
//             onPressed: _takePicture,
//           ),
//         )
//       ],
//     );
//   }
// }


