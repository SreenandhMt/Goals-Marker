import 'package:flutter/material.dart';
import 'package:goal_marker/services/auth/auth_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

const height10 = SizedBox(height: 10);

TextEditingController _email =TextEditingController();
TextEditingController _password =TextEditingController();
TextEditingController _confromPass =TextEditingController();

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.ontap,
  });
  final Function() ontap;

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> authForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<AuthServices>(
      builder: (context,state,_) {
        return Form(
          key: authForm,
          child: Scaffold(
            body: Center(
              child: Container(
                width: size.width>600?size.width*0.3:double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Welcome",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 30),
                      TextFormField(validator: (value) {
                        if(value==null)return "Enter Email";
                        if(value.isEmpty)return "Enter Email";
                        if(!(value.endsWith("@gmail.com")))return "Invalid  Email";
                        final split = value.split("@");
                        if(split.first.length<=3)return "Invalid Email";
                        return null;
                      },controller: _email,decoration: InputDecoration(hintText: "Email",border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))),),
                      height10,
                      TextFormField(validator: (value) {
                        if(value==null)return "Enter Password";
                        if(value.isEmpty)return "Enter Password";
                        if(value.length < 8)return "Invalid Password";
                        return null;
                      },controller: _password,decoration: InputDecoration(hintText: "Password",border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))),),
                      const SizedBox(height: 20),
                       MaterialButton(onPressed: () async {
                       if(authForm.currentState!.validate())
                       {
                         final error = await state.signIn(email: _email.text, password: _password.text);
                            if(error!=null)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(error),
                                backgroundColor: Colors.lightBlue,
                              ));
                            }
                       }
                       },color: Colors.green,padding: const EdgeInsets.all(0),child: const SizedBox(width: double.infinity,height: 50,child: Center(child: Text("LogIn",style: TextStyle(),)),),),
                       height10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("No Account",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                          const SizedBox(width: 6,),
                          GestureDetector(onTap: widget.ontap,child: const Text("SignUp",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color:Colors.green),)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

class SigninPage extends StatefulWidget {
  const SigninPage({
    super.key,
    required this.ontap,
  });
  final Function() ontap;

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    GlobalKey<FormState> authForm = GlobalKey<FormState>();
   return Consumer<AuthServices>(
     builder: (context,state,_) {
       return Form(
        key: authForm,
         child: Scaffold(
           body: Center(
             child: Container(
                width: size.width>600?size.width*0.3:double.infinity,
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Get Started",style: GoogleFonts.aDLaMDisplay(fontSize: 40)),
                      const SizedBox(height: 30),
                      TextFormField(validator: (value) {
                        if(value==null)return "Enter Email";
                        if(value.isEmpty)return "Enter Email";
                        if(!(value.endsWith("@gmail.com")))return "Invalid Email";
                        final split = value.split("@");
                        if(split.first.length<=3)return "Invalid Email";
                        return null;
                      },controller: _email,decoration: InputDecoration(hintText: "Email",border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))),),
                      height10,
                      TextFormField(validator: (value) {
                        if(value==null)return "Enter Password";
                        if(value.isEmpty)return "Enter Password";
                        if(value.length < 8)return "Invalid Password";
                        return null;
                      },controller: _password,decoration: InputDecoration(hintText: "Password",border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))),),
                      height10,
                      TextFormField(validator: (value) {
                        if(value==null)return "Enter Password";
                        if(value.isEmpty)return "Enter Password";
                        if(value != _password.text)return "Invalid Conform";
                        return null;
                      },controller: _confromPass,decoration: InputDecoration(hintText: "Confrom Password",border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))),),
                      const SizedBox(height: 20),
                      MaterialButton(onPressed: ()async{
                        if (authForm.currentState!.validate()) {
                          final error = await state.signUp(
                              email: _email.text, password: _password.text);
                          if (error != null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(error),
                              backgroundColor: Colors.lightBlue,
                            ));
                          }
                        }
                      },color: Colors.green,padding: const EdgeInsets.all(0),child: const SizedBox(width: double.infinity,height: 50,child: Center(child: Text("SignUp",style: TextStyle(),)),),),
                      height10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Account already exists?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                          const SizedBox(width: 6,),
                          GestureDetector(onTap: widget.ontap,child: const Text("Login",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color:Colors.green),)),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
               ),
             ),
           ),
         ),
       );
     }
   );
  }
}

class AuthRoute extends StatefulWidget {
  const AuthRoute({super.key});

  @override
  State<AuthRoute> createState() => _AuthRouteState();
}

class _AuthRouteState extends State<AuthRoute> {
  bool loginPage = true;
  void onTap(){
    setState(() {
      loginPage=!loginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(loginPage)
    {
      return LoginPage(ontap: onTap,);
    }else{
      return SigninPage(ontap: onTap,);
    }
  }
}