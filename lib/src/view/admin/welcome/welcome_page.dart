import 'package:explore_flutter_with_dart_3/src/controllers/auth.dart';
import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:explore_flutter_with_dart_3/src/helper/screen_size.dart';
import 'package:explore_flutter_with_dart_3/src/view/admin/dashboard/dashboard.dart';
import 'package:explore_flutter_with_dart_3/src/widgets/cards.dart';
import 'package:explore_flutter_with_dart_3/src/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<WelcomePage> createState() => _WelcomePageState();
}
TextEditingController _password = TextEditingController();
TextEditingController _email = TextEditingController();
bool loading = false;
final loginKey = GlobalKey<FormState>();

class _WelcomePageState extends ConsumerState<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: loginKey,
        child: Stack(
          children: [
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                height: getProportionateScreenHeight(500),
                width: getProportionateScreenWidth(300),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Center(
                        child: Text(
                          "Welcome to CLG",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),

                      InputField(label: "Email", hint: '',
                          keyboardType: TextInputType.emailAddress,
                        controller: _email
                      ),

                      InputField(label: "Password", hint: '',
                          keyboardType: TextInputType.visiblePassword,
                          controller: _password
                      ),
                      const SizedBox(height: 20,),

                      RectangularTextButton(
                        title: 'Login',
                        bgColor: Theme.of(context).cardColor,
                        height: getProportionateScreenHeight(75),
                        width: getProportionateScreenWidth(120),
                        style: TextStyle(
                            fontSize: getFontSize(10),
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).scaffoldBackgroundColor
                        ),
                        onTap: (){
                          loginAction();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if(loading)
              kProgressIndicator,
          ],
        ),
      ),
    );
  }

  void loginAction() async{ //TODO: I need to change this to login
    if(loginKey.currentState!.validate()){
      loginKey.currentState!.save();
      setState(() {
        loading = true;
      });
      ref.read(loadingProvider.notifier).state = true;
      final auth  = await ref.read(authControllerProvider.notifier);
      final response = await auth.login(_email.text, _password.text);
      // final response = await auth.login(_email.text, _password.text);
      //// after login function is completed
      response.fold((e) {
        //// if error is detected loading will stop and this task will come to live
        ref.read(loadingProvider.notifier).state =false;
        setState(() {
          loading = false;
        });
        if (e is FirebaseAuthException) {
          showSnackBar(context, text: e.toString());
        }
        showSnackBar(context, text: 'Error: $e');
        debugPrint('Error: $e');
      }, (tokens) async{
        ref.read(loadingProvider.notifier).state =false;
        setState(() {
          loading = false;
        });
        push(context, const Dashboard());
      });
    }
  }

}
