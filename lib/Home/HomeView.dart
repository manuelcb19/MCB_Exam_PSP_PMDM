
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examenmcb/FirebaseObjects/FbUsuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../CustomViews/CustomButton.dart';
import '../CustomViews/CustomCellView.dart';
import '../CustomViews/CustomDrawer.dart';
import '../CustomViews/CustomGredCellView.dart';
import '../FirebaseObjects/FbPostId.dart';
import '../Singletone/DataHolder.dart';
import '../onBoarding/LoginView.dart';

class HomeView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {


  TextEditingController bdUsuarioNombre = TextEditingController();
  TextEditingController bdUsuarioEdad = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;
  DataHolder dataHolder = DataHolder();
  late FbUsuario perfil;
  int _selectedIndex = 0;
  bool bIsList = false;
  final Map<String,FbPostId> mapPosts = Map();

  final List<FbPostId> posts = [];
  //final List<FbPostId> postsId = [];
  final List<FbUsuario> listaUsuarios = [];


  Map<String, dynamic> miDiccionario = {};




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    conseguirUsuario();
    descargarPosts();
  }

  void descargarPosts() async{

    posts.clear();

    CollectionReference<FbPostId> postsRef = db.collection("PostUsuario")
        .withConverter(
      fromFirestore: FbPostId.fromFirestore,
      toFirestore: (FbPostId post, _) => post.toFirestore(),);

    postsRef.snapshots().listen(datosDescargados, onError: descargaPostError,);

  }

  void datosDescargados(QuerySnapshot<FbPostId> postsdescargados)
  {
    print("NUMERO DE POSTS ACTUALIZADOS>>>> "+postsdescargados.docChanges.length.toString());

    for(int i=0;i<postsdescargados.docChanges.length;i++){
      FbPostId temp = postsdescargados.docChanges[i].doc.data()!;
      mapPosts[postsdescargados.docChanges[i].doc.id]=temp;
    }
    setState(() {
      posts.clear();
      posts.addAll(mapPosts.values);
    });
  }

  void descargaPostError(error){
    print("Listen failed: $error");
  }

  void descargarPostsMej() async {

    CollectionReference<FbPostId> postsRef = db.collection("PostUsuario")
        .withConverter(
      fromFirestore: FbPostId.fromFirestore,
      toFirestore: (FbPostId post, _) => post.toFirestore(),);

    QuerySnapshot<FbPostId> querySnapshot = await postsRef.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      setState(() {
        posts.add(querySnapshot.docs[i].data());
      });
    }
    print("la lista tiene este " + posts.length.toString());
  }

  void uploadImageToFirebase(File imageFile) async {
    if (imageFile != null) {
      // Obtiene la referencia de Firebase Storage
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('user_profile_images/${DateTime.now()}.png');

      // Sube la imagen
      UploadTask uploadTask = storageReference.putFile(imageFile);

      // Monitorea el progreso de la carga
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        print('Progreso: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100}%');
      });

      // Espera a que se complete la carga
      await uploadTask.whenComplete(() {
        print('Carga completada');
      });

      // Obtiene la URL de la imagen después de cargarla
      String downloadURL = await storageReference.getDownloadURL();

      // Guarda esta URL en tu base de datos si es necesario.
    }
  }



  void conseguirUsuario() async {

    perfil = await dataHolder.fbadmin.conseguirUsuario();
  }

  void onItemListClicked(int index){
    DataHolder().selectedPost=posts[index];

    //DataHolder().Usuario=perfil;
    Navigator.of(context).pushNamed("/usuarioview");

  }


  void onBottonMenuPressed(int indice) {
    setState(() {
      switch(indice)
      {
        case 0:
          descargarPosts();
          print("casa");
          if(posts.isEmpty)
          {
            print("la lista esta vacia");
          }
          bIsList = true;

          break;
        case 1:
          bIsList = false;
          break;
        case 2:
          exit(0);
        case 3:
          Navigator.of(context).pushNamed("/usuarioview");
          break;
      }
    });

    void onClickAceptar() {
      setState(() {
        miDiccionario = {
          'Nombre': perfil.nombre,
          'Edad': perfil.edad,
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("ExamenManuelCarrizosa"),
        shadowColor: Colors.orangeAccent, // Color de sombra del AppBar
        backgroundColor: Colors.orangeAccent,),
      backgroundColor: Colors.amber[200],// Color de fondo del AppBar
      body: Center(

        child: celdasOLista(bIsList),
      ),
      bottomNavigationBar: CustomButton(onBotonesClicked: this.onBottonMenuPressed, texto: 'botonnavegacion',),
      drawer: CustomDrawer(onItemTap: fHomeViewDrawerOnTap,),
      floatingActionButton:FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/postcreateview");
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      /**/
    );
  }


  String recorrerDiccionario(Map diccionario) {
    String valores = '';

    for (String p in diccionario.keys) {
      dynamic valor = diccionario[p];
      valores += p + " : " + valor.toString() + " ";
    }
    return valores;
  }

  void fHomeViewDrawerOnTap(int indice){
    print("---->>>> "+indice.toString());
    if(indice==0){
      FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil (
        MaterialPageRoute (builder: (BuildContext context) =>  LoginView()),
        ModalRoute.withName('/loginview'),
      );
    }
    else if(indice==1){
      exit(0);
    }
  }

  Widget? creadorDeItemLista(BuildContext context, int index) {
    return CustomCellView(sTexto: recorrerDiccionario(miDiccionario) + " " +
        posts[index].post,
        iCodigoColor: 50,
        dFuenteTamanyo: 20,
        iPosicion: index,
        imagen: posts[index].sUrlImg,
        onItemListClickedFun:onItemListClicked);
  }


  Widget? creadorDeItemMatriz(BuildContext context, int index) {
    return CustomGredCellView(
      sText: recorrerDiccionario(miDiccionario) + " " + posts[index].post,
      dFontSize: 20,
      imagen: posts[index].sUrlImg,
      iColorCode: 0,
    );
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index) {
    return Column(
      children: [
        Divider(),
      ],
    );
  }

  Widget celdasOLista(bool isList) {
    if (isList) {
      return ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: posts.length,
        itemBuilder: creadorDeItemLista,
        separatorBuilder: creadorDeSeparadorLista,
      );
    } else {
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5),
          itemCount: posts.length,
          itemBuilder: creadorDeItemMatriz
      );
    }
  }
}