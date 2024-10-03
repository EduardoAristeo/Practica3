import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override



  
final conUser = TextEditingController();
final conPwd = TextEditingController();
bool isLooading = false;

  Widget build(BuildContext context) {

    TextFormField txtUser = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: conUser,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person)
      ),
    );

    final txtPwd = TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: conPwd,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.lock)
      ),
    );

    final ctnCredentials = Positioned(
      top: 300,
      child: Container(
        width: MediaQuery.of(context).size.width*.9,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
          
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            txtUser,
            txtPwd,
          ],
        ),
      ),
    );

final btnLogin = Positioned(
  bottom: 250,
  width: MediaQuery.of(context).size.width*.9,
  child: ElevatedButton(
    onPressed: (){
      isLooading=true;

    setState(() {});
    Future.delayed(
      const Duration(milliseconds: 4000)
    ).then((value)=>{
      isLooading = false,
      setState((){}),
      Navigator.pushNamed(context, "/onBoarding")
    });


    },
    child: const Text("VALIDAR USUARIO"),
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 255, 223, 152),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      )
      
    ),
    
  ),
);

final gifLoading = Positioned(
  top: 350,
  left: 100,
  child:  Image.asset('assets/load.gif'), height: 100,

);


    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit:BoxFit.cover,
            image: AssetImage('assets/fondo.jpg'),
          )

        ),
        child: Stack(
            children: [
              Positioned(
                top: 100,
                left: 100,
                child: Image.asset("assets/logo.png", width: 200,),
                
              ),
              ctnCredentials,
              btnLogin,
              isLooading ? gifLoading:Container()
            ],
        ),
      ),
    );
  
   
  }
}