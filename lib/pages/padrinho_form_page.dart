import 'dart:io';
import 'dart:math';
import 'package:ajudapet/models/auth.dart';
import 'package:ajudapet/models/padrinho_list.dart';
import 'package:ajudapet/models/padrinho_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PadrinhoFormPage extends StatefulWidget {
  const PadrinhoFormPage({super.key});

  @override
  State<PadrinhoFormPage> createState() => _PadrinhoFormPageState();
}

class _PadrinhoFormPageState extends State<PadrinhoFormPage> {
  final _contatoRespFocus = FocusNode();
  final _descriptionsFocus = FocusNode();
  final _endFocus = FocusNode();
  final _cidadeFocus = FocusNode();
  final _contaFocus = FocusNode();
  final _imgFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  final FirebaseStorage storage = FirebaseStorage.instance;
  List<Reference> refs = [];
  List<String> arquivos = [];
  bool loading = true;
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
    refs = (await storage.ref('imagesSejaPadrinho').listAll()).items;
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
      String ref = 'imagesSejaPadrinho/img-${DateTime.now().toString()}.jpg';
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
        final  padrinho = arg as PadrinhoModel;
         if(padrinho.imagem != null)
        urlImage = padrinho.imagem;
        _formData['idPadrinho'] = padrinho.idPadrinho;
        _formData['emailUser'] = padrinho.emailUser == null || padrinho.emailUser == ''  ? emailUser.toString() : padrinho.emailUser;
        _formData['nome'] = padrinho.nome;
        _formData['nomeResp'] = padrinho.nomeResp;
        _formData['contatoResp'] = padrinho.contatoResp;
        _formData['cidade'] = padrinho.cidade;
        _formData['descricao'] = padrinho.descricao;
        _formData['contaBancaria'] = padrinho.contaBancaria;
        _formData['imagem'] = urlImage;

        _imageUrlController.text  = padrinho.imagem;
      }
    }
  }

  @override
  void dispose(){
    super.dispose();
    _contatoRespFocus.dispose();
    _descriptionsFocus.dispose();
    _endFocus.dispose();
    _cidadeFocus.dispose();
    _contaFocus.dispose();
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
      await Provider.of<PadrinhoList>(
      context, 
      listen: false,
      ).savePadrinho(_formData);

      Navigator.of(context).pop();
      
    } catch(error){
      await showDialog<void>(
        context: context, 
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro para salvar o produto.'),
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
        title: Text('Cadastre animais que precisam' '\n' 
        ' de ajuda financeira',
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: _submitForm, 
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: _isloading ? Center(
        child: CircularProgressIndicator(),
        ) : Padding(
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
              //         validator: (_urlImage){
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
                decoration: InputDecoration(labelText: 'Contato do responsável'),
                keyboardType: TextInputType.number,
                focusNode: _contatoRespFocus,  
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_cidadeFocus);
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
              TextFormField(
                initialValue: _formData['cidade']?.toString(),
                decoration: InputDecoration(labelText: 'Cidade em que o animal está'),
                textInputAction: TextInputAction.next,
                focusNode: _cidadeFocus,  
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_endFocus);
                },
                onSaved: (cidade) => _formData['cidade'] = cidade ?? '',
                validator: (_cidade){
                  final cidade = _cidade ?? '';

                  if(cidade.trim().isEmpty){
                    return 'A cidade não pode ser vazia!';
                  }

                  return null;
                },             
              ),
              TextFormField(
                initialValue: _formData['enderecoResp']?.toString(),
                decoration: InputDecoration(labelText: 'Endereço do responsável'),
                textInputAction: TextInputAction.next,
                focusNode: _endFocus,  
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_contaFocus);
                },
                onSaved: (enderecoResp) => _formData['enderecoResp'] = enderecoResp ?? '',
                validator: (_enderecoResp){
                  final enderecoResp = _enderecoResp ?? '';

                  if(enderecoResp.trim().isEmpty){
                    return 'O endereço não pode ser vazio!';
                  }

                  return null;
                },             
              ),
               TextFormField(
                initialValue: _formData['contaBancaria']?.toString(),
                decoration: InputDecoration(labelText: 'Conta bancária da ONG'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _contaFocus,  
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionsFocus);
                },
                onSaved: (contaBancaria) => _formData['contaBancaria'] = contaBancaria ?? '',
                validator: (_contaBancaria){
                  final contaBancaria = _contaBancaria ?? '';

                  if(contaBancaria.trim().isEmpty){
                    return 'A conta bancária não pode ser vazia!';
                  }

                  return null;
                },             
              ),
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