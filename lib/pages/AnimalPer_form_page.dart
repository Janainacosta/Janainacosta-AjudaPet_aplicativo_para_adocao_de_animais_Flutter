import 'dart:io';
import 'dart:math';

import 'package:ajudapet/models/animalPer_list.dart';
import 'package:ajudapet/models/animalPer_model.dart';
import 'package:ajudapet/models/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AnimalPerFormPage extends StatefulWidget {
  const AnimalPerFormPage({super.key});

  @override
  State<AnimalPerFormPage> createState() => _AnimalPerFormPageState();
}

class _AnimalPerFormPageState extends State<AnimalPerFormPage> {
  final _contatoRespFocus = FocusNode();
  final _descriptionsFocus = FocusNode();
  final _endFocus = FocusNode();
  final _imgFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  final FirebaseStorage storage = FirebaseStorage.instance;
  List<Reference> refs = [];
  List<String> arquivos = [];
  //bool loading = true;
  var urlImage = 'vazio';
   String? emailUser = Auth.emailUserForm;


  bool _isloading = false;


  @override
  void initState(){
    super.initState();
    _imgFocus.addListener(updateImage);
    loadImages();
  }
  loadImages()async{
    refs = (await storage.ref('imagesAnimalPer').listAll()).items;
    for(var ref in refs){
      var arquivo = await ref.getDownloadURL();
      arquivos.add(arquivo);
      // urlImage = arquivo;
    }
    
  }
  
  Future<XFile?> getImage() async{
    await Firebase.initializeApp();
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<UploadTask> upload(String path) async{
    await Firebase.initializeApp();
    File file = File(path);
    try{
      String ref = 'imagesAnimalPer/img-${DateTime.now().toString()}.jpg';
      return storage.ref(ref).putFile(file);
    } on FirebaseException catch (e){
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  pickAndUploadImage() async{
    await Firebase.initializeApp();
    XFile? file = await getImage();
    if(file != null){
      UploadTask task = await upload(file.path);

       task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.running) {
          // setState(() {
          //   uploading = true;
          //   total = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          // });
        } else if (snapshot.state == TaskState.success) {
          final photoRef = snapshot.ref;

          arquivos.add(await photoRef.getDownloadURL());
          refs.add(photoRef);
          urlImage = arquivos[arquivos.length-1];
         
          //setState(() => uploading = false);
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if(_formData.isEmpty){
      final arg = ModalRoute.of(context)?.settings.arguments;

      if(arg != null){
        final  animalPer = arg as AnimalPerModel;
        if(animalPer.imagem != null)
        urlImage = animalPer.imagem;
        _formData['idAnimalPer'] = animalPer.idAnimalPer;
        _formData['emailUser'] = animalPer.emailUser == null || animalPer.emailUser == ''  ? emailUser.toString() : animalPer.emailUser;
        _formData['nome'] = animalPer.nome;
        _formData['nomeResp'] = animalPer.nomeResp;
        _formData['contatoResp'] = animalPer.contatoResp;
        _formData['descricao'] = animalPer.descricao;
        _formData['imagem'] = urlImage;

        _imageUrlController.text  = animalPer.imagem;
      }
    }
  }

  @override
  void dispose(){
    super.dispose();
    _contatoRespFocus.dispose();
    _descriptionsFocus.dispose();
    _endFocus.dispose();
    _imgFocus.removeListener(updateImage);
    _imgFocus.dispose();
  }

  void updateImage(){
    setState(() {});
  }

  bool isValidImageUrl(String url){
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') || url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  Future<void> _submitForm() async{
    final isValid = _formKey.currentState?.validate() ?? false;

    if(!isValid){
      return;
    }
    _formData['imagem'] = urlImage;

    _formKey.currentState?.save();

   setState(() => _isloading = true);

    try{
      await Provider.of<AnimalPerList>(
      context, 
      listen: false,
      ).saveAnimalPer(_formData);

      Navigator.of(context).pop();
      
    } catch(error){
      await showDialog<void>(
        context: context, 
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro ao salvar.'),
          actions: [
            TextButton( 
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ],
        ),
      );
    } finally{
      setState(() => _isloading = false);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal Perdidos'),
        actions: [
          IconButton(
            onPressed: _submitForm, 
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextButton.icon(
                icon: Icon(Icons.camera_alt), 
                label: Text('Insira uma foto do pet'),
                onPressed: pickAndUploadImage, 
              ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     Expanded(
              //       child: TextFormField(
              //         //decoration: InputDecoration(labelText: 'Foto do pet'),
              //         keyboardType: TextInputType.url,
              //         focusNode: _imgFocus, 
              //         controller: _imageUrlController,  
              //        //onFieldSubmitted: (_) => _submitForm(), 
              //         onSaved: (imagem) => _formData['imagem'] = urlImage, 
              //        validator: (_urlImage){
              //         final urlImage = _urlImage ?? '';
              //           return null;
              //         },               
              //       ),
              //     ),
              //     // Container(
              //     //   height: 100,
              //     //   width: 100,
              //     //   margin: const EdgeInsets.only(
              //     //     top: 10,
              //     //     left: 10,
              //     //   ),
              //     //   decoration: BoxDecoration(border: Border.all(
              //     //     color: Colors.grey,
              //     //     width: 1
              //     //   ),
              //     //   ),
              //     //   alignment: Alignment.center,
              //     //   child: _imageUrlController.text.isEmpty ? Text('Informe a Url') : Container(
              //     //     width: 100,
              //     //     height: 100,
              //     //     child: FittedBox(
              //     //       child: Image.network(_imageUrlController.text),
              //     //       fit: BoxFit.cover,
              //     //     ),
              //     //   ),
              //     // ),
              //   ],
              // ),
              TextFormField(
                initialValue: _formData['nome']?.toString(),
                decoration: InputDecoration(labelText: 'Nome do pet'),
                textInputAction: TextInputAction.next,
                onSaved: (nome) => _formData['nome'] = nome ?? '',
                validator: (_nome){
                  final nome = _nome ?? '';

                  if(nome.trim().isEmpty){
                    return 'O nome não pode ser vazio!';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['nomeResp']?.toString(),
                decoration: InputDecoration(labelText: 'Nome do responsável'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_contatoRespFocus);
                },
                onSaved: (nomeResp) => _formData['nomeResp'] = nomeResp ?? '',
                validator: (_nomeResp){
                  final nomeResp = _nomeResp ?? '';

                  if(nomeResp.trim().isEmpty){
                    return 'O nome do responsável não pode ser vazio!';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['contatoResp']?.toString(),
                decoration: InputDecoration(labelText: 'Contato do responsável com o DDD e o número'),
                keyboardType: TextInputType.number,
                focusNode: _contatoRespFocus,  
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionsFocus);
                },
                onSaved: (contatoResp) => _formData['contatoResp'] = contatoResp ?? '', 
                validator: (_contatoResp){
                  final contatoResp = _contatoResp ?? '';

                  if(contatoResp.trim().isEmpty){
                    return 'O contato não pode ser vazio!';
                  }

                  return null;
                },           
              ),
              // TextFormField(
              //   initialValue: _formData['enderecoResp']?.toString(),
              //   decoration: InputDecoration(labelText: 'Endereço do responsável'),
              //   textInputAction: TextInputAction.next,
              //   focusNode: _endFocus,  
              //   onFieldSubmitted: (_) {
              //     FocusScope.of(context).requestFocus(_descriptionsFocus);
              //   },
              //   onSaved: (enderecoResp) => _formData['enderecoResp'] = enderecoResp ?? '',
              //   validator: (_enderecoResp){
              //     final enderecoResp = _enderecoResp ?? '';

              //     if(enderecoResp.trim().isEmpty){
              //       return 'O endereço não pode ser vazio!';
              //     }

              //     return null;
              //   },             
              // ),
              TextFormField(
                initialValue: _formData['descricao']?.toString(),
                decoration: InputDecoration(labelText: 'Descrição do pet'),
                focusNode: _descriptionsFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                textInputAction: TextInputAction.done,
                onSaved: (descricao) => _formData['descricao'] = descricao ?? '',
                validator: (_descricao){
                  final descricao = _descricao ?? '';

                  if(descricao.trim().isEmpty){
                    return 'A descrição não pode ser vazia!';
                  }

                  return null;
                },             
              ),
            ],
          ),
        ),
      ),
    );
  }
}