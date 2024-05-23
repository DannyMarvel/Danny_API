import 'package:danny_api/screens/authentication/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/authProvider/auth_provider.dart';
import '../../utils/routers.dart';
import '../../utils/snack_message.dart';
import '../../widgets/button.dart';
import '../../widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.clear();
    _password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login ')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    customTextField(
                      title: 'Email',
                      
                      controller: _email,
                      hint: 'Enter you valid email address',
                    ),
                    customTextField(
                      title: 'Password',
                      controller: _password,
                      hint: 'Enter your secured password',
                    ),

                    ///Button
                    Consumer<AuthenticationProvider>(
                        builder: (context, auth, child) {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        if (auth.resMessage != '') {
                          showMessage(
                              message: auth.resMessage, context: context);

                          ///Clear the response message to avoid duplicate
                          auth.clear();
                        }
                      });
                      return customButton(
                        text: 'Login',
                        tap: () {
                          if (_email.text.isEmpty || _password.text.isEmpty) {
                            showMessage(
                                message: "All fields are required",
                                context: context);
                          } else {
                            auth.loginUser(
                                context: context,
                                email: _email.text.trim(),
                                password: _password.text.trim());
                          }
                        },
                        context: context,
                        status: auth.isLoading,
                      );
                    }),

                    const SizedBox(
                      height: 10,
                    ),
                  Text(''),
                
                  Text(''),
                  Text(''),
                  Text(''),
          
              
              
                
                
                
      
                 
      
                  
                  
        
      
                  
                
              
                
              
            
                  
                
                
              

                    GestureDetector(
                      onTap: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: const RegisterPage());
                      },
                      child: const Text('Register Instead'),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
