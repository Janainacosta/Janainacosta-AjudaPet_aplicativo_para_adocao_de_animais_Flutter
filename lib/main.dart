import 'package:ajudapet/models/animalAd_list.dart';
import 'package:ajudapet/models/animalPer_list.dart';
import 'package:ajudapet/models/auth.dart';
import 'package:ajudapet/models/cart.dart';
import 'package:ajudapet/models/order_list.dart';
import 'package:ajudapet/models/padrinho_list.dart';
import 'package:ajudapet/pages/AnimalAd_form_page.dart';
import 'package:ajudapet/pages/animalAd_page.dart';
import 'package:ajudapet/pages/auth_or_home_page.dart';
import 'package:ajudapet/pages/cart_page.dart';
import 'package:ajudapet/pages/conta_ong_page.dart';
import 'package:ajudapet/pages/detalhesAnimalAd_page.dart';
import 'package:ajudapet/pages/detalhesPadrinho_page.dart';
import 'package:ajudapet/pages/gerenciar_usuarios_page.dart';
import 'package:ajudapet/pages/gridAnimalPer.dart';
import 'package:ajudapet/pages/gridPadrinho.dart';
import 'package:ajudapet/pages/order_page.dart';
import 'package:ajudapet/pages/padrinho_form_page.dart';
import 'package:ajudapet/pages/padrinho_page.dart';
import 'package:ajudapet/pages/sobre_page.dart';
import 'package:ajudapet/utils/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/AnimalPer_form_page.dart';
import 'pages/animalPer_page.dart';
import 'pages/detalhesAnimalPer_page.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, AnimalAdList>(
          create: (_) => AnimalAdList('', [],[]),
          update: (ctx, auth, previous){
            return AnimalAdList(auth.token ?? '', previous?.items ?? [], previous?.users ?? []);
          },
        ),
        ChangeNotifierProxyProvider<Auth, AnimalPerList>(
          create: (_) => AnimalPerList('', []),
          update: (ctx, auth, previous){
            return AnimalPerList(auth.token ?? '', previous?.items ?? []);
          },
        ),
          ChangeNotifierProxyProvider<Auth, PadrinhoList>(
          create: (_) => PadrinhoList('', []),
          update: (ctx, auth, previous){
            return PadrinhoList(auth.token ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.deepOrange,
        ),
        //home: GridAnimalAd(),
        routes: {
          AppRoutes.AUTH_OR_HOME: (ctx) => AuthOrHomePage(),
          //AppRoutes.HOME: (ctx) => GridAnimalAd(),
          AppRoutes.DETALHES_ANIMALAD: (ctx) => DetalhesAnimalAdPage(),
          AppRoutes.CART: (ctx) => CartPage(),
          AppRoutes.ORDERS: (ctx) => OrdersPage(),
          AppRoutes.ANIMALADPAGE: (ctx) => AnimalAdPage(),
          AppRoutes.ANIMALADFORM: (ctx) => AnimalAdFormPage(),

          AppRoutes.HOMEANIMAISPER: (ctx) => GridAnimalPer(),
          AppRoutes.DETALHES_ANIMALPER: (ctx) => DetalhesAnimalPerPage(),
          // AppRoutes.CART2: (ctx) => CartPage(),
          // AppRoutes.ORDERS2: (ctx) => OrdersPage(),
          AppRoutes.ANIMALPERPAGE: (ctx) => AnimalPerPage(),
          AppRoutes.ANIMALPERFORM: (ctx) => AnimalPerFormPage(),

          AppRoutes.CONTAONGPAGE: (ctx) => ContaOngPage(),
          AppRoutes.SOBREPAGE: (ctx) => SobrePage(),

          AppRoutes.GRIDPADRINHO: (ctx) => GridPadrinho(),
          AppRoutes.PADRINHOPAGE: (ctx) => PadrinhoPage(),
          AppRoutes.DETALHESPADRINHOPAGE: (ctx) => DetalhesPadrinhoPage(),
          AppRoutes.PADRINHOFORM: (ctx) => PadrinhoFormPage(),

          AppRoutes.GERENCIARUSUARIOS: (ctx) => GerenciarUsuariosPage(),

        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

