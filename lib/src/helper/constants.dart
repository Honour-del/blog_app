import 'package:explore_flutter_with_dart_3/src/helper/screen_size.dart';
import 'package:explore_flutter_with_dart_3/src/services/url_launcher/url_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';



final dateTime = DateTime.now();


final loadingProvider = StateProvider.autoDispose<bool>((ref) => false);




const String avatar = 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAHYAsQMBIgACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwUBAgQHBv/EACoQAQACAgECBQMEAwAAAAAAAAABAgMREgQhBRMxQVEGImFxgcHRMkKR/8QAFwEBAQEBAAAAAAAAAAAAAAAAAAIBA//EABwRAQACAgMBAAAAAAAAAAAAAAABEQIhIjFBEv/aAAwDAQACEQMRAD8A8NAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABnQMAAAAAAAAAAAAAAAAAAAAAA2pG5dVcMzG+KDDWbTqEvHJjneO0zpWLJbWwR2b4eki860zTqPNjWSv3R+2209X5M6pXv+jpx7TvpJk8NtWvLj2+Vdnx8La9JWWGMvVRa2TJER+e8y4utx+XbjvevdymFQ5QGNAAAAAAAAAAAAAAAAT9PWb241nUynydNmpPad/mHLjtMTuHZTq7f495/Dpj81tM20wYrTnxxff3WiH0X1D9NdT0FsWTpOn8zpsmGk8+0zFpjcqTFblmw2ntHOP2eqeP5b5vpnBn6SkZ5pjpFscW1Mx6dv0dJxikXt5z4b4N1mW8+ZPkU9edp/j3/AOKzxbH5Wfy4vziv+3ysL+K5q5ON8eWmt/baNeip6683y8rTO59XLKvFxbmAQoAAAAAAAAAAAAAAABmJ1O4T0m24tTW59pc7eltdvZsEpL3vy9OK98I8X62vHFGDJnpjrNcVad4rv1n4/pSXyWrXdbO/o8mTJg55c1prHbjvULvaUvX5MmTPfJ1PGMkx3rWdxSvxv5lS5rc8kz+U/VZ+czFff1cqJbAAxoAAAAAAAAAAAAAAAAADblOtN4zWjFwjtCIBlgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAf/Z';
const String body = '''
INTRODUCTION
The Student Industrial Work Experience Scheme is six months programme to enable students on the acquisition of some practical skills and experience. This serves as a vital means in contributing immensely to the practical training of young Engineers and also the production of quality manpower for the nation in the nearest future. It is important as well that students are exposed to latest developments and technological innovations in their chosen professions.
INDUCTION INTO OAPNL
My first week between the dates of 6th of July to 10th of July was used for the induction of the new interns which included;
•	Office orientation, introduction to ARUP team, relevant ARUP procedures & policies and identification of job numbers.
•	Health and Safety induction as regards safety in the office and on site.
•	Introduction to Quality Management System (QMS) in OAPNL.
•	IT procedure induction.
•	Disciplines in ARUP such as civil & infrastructures, building & industrial structures, geotechnical and project management. 
After the general induction ceremony, I was scheduled for different departments for the period of my industrial training so as to make efficient use of the allocated time and have enough experience in the various branches of civil engineering which included;
1.	Site supervision / Site Health & Safety
2.	Building and Industrial Structures
3.	Computer Aided Design / Drafting Works
4.	Civil Infrastructure
5.	Geotechnical Engineering
6.	Project Management / Site Management

1.	SITE VISITS & SUPERVISION (13th July – 21st August,2015)
•	City Of David (Trinity Towers, N4659). Facilitator – Engr. Obinna Ndukwu
Knowledge gained on site includes; Health Safety and Environment precautions on site. Introduction to pile foundation construction, types of piles, installation of secant pile walls using Continuous Flight Auger (CFA) method, interpretation of pile layout drawings, pile load test, use of bentonite. I also had practical activities of the test carried out on site such as the concrete slump test and the concrete cube test.
•	Alliance Place (Kingsway Tower, N4758). Facilitator – Engr. Emeka Mbogu
Knowledge gained on site includes; Interpretation of construction drawings for slab reinforcement layouts, beams, columns, parapets and wall detailing. Identification of reinforcement sizes, placement reinforcements and formwork for construction. I learnt on the surveying operations carried out on site. I was also opportune to attend one of the Site Progress Meetings which took place.
•	Marriot Hotel, Ikeja (N4780). Facilitator – Engr. Adesina Alabi
Knowledge gained on site includes; Introduction to raft foundation construction, blinding of the hardcore, check for defects on structural elements on site with the preventive measures/remedies. I was also opportune to witness the construction of retaining walls and method of waterproofing.

•	Oando Wings (Commercial Building). Facilitator – Engr. Austin Kpando
Knowledge gained on site includes; Identification of bond walls, waffle slab, expansion joints, mezzanine level, column head and drop panels on site. Introduction to construction and expansion joints construction. Preparation and placement of post tensioning reinforcement, preparation of bending schedules.

     ''';

void showSnackBar(
    BuildContext context, {
      required String text,
    }) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 2,
    backgroundColor: Colors.white10,
    duration: const Duration(seconds: 3),
    margin: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(30.0),
        vertical: getProportionateScreenWidth(20.0)),
    behavior: SnackBarBehavior.floating,
    content: Text(
      text,
      style: TextStyle(
          color: Colors.white,
          fontSize: getFontSize(16),
          fontWeight: FontWeight.w500),
    ),
  ));
}


final usersRef = FirebaseFirestore.instance.collection("users");
final postsRef= FirebaseFirestore.instance.collection("posts");
final advertsRef= FirebaseFirestore.instance.collection("adverts");
final commentsRef = FirebaseFirestore.instance.collection("comments");
var storageRef = FirebaseStorage.instance.ref();

Center kProgressIndicator = const Center(
  child: Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: CircularProgressIndicator(
      color: Colors.deepOrange,
    ),
  ),
);


/* Function to convert UintList to File */
Future<File> convertUint8List(Uint8List data, String fileName) async{
  // final tempDir = await getTemporaryDirectory();
  // final file = File('${tempDir.path}/$fileName');
  final file = File.fromRawPath(data);
  await file.writeAsBytes(data);
  return file;
}


/* Function to compress images before uploading */
Future<File> compressImage(File file) async{
  Im.Image? image = Im.decodeImage(file.readAsBytesSync());
  // Im.Image? compressedImage = Im.copyResize(image!, width: 1080);
  File compressedFile = File('${file.path}_compressed.jpg')
    ..writeAsBytesSync(Im.encodeJpg(image!, quality: 70));
  return compressedFile;
}


kPrint(toPrint){
  if(kDebugMode) {
    print(toPrint);
  }
}


launchURL(String url) async{
  final uri = Uri.parse(url);
  if(await canLaunchUrl(uri)){
    await launchUrl(uri);
  }else{
    throw 'Could not launch';
  }
}

//
//  List<Widget> socials(context, WidgetRef ref) => [
//   Padding(
//     padding: const EdgeInsets.all(10.0),
//     child: GestureDetector(
//       onTap: (){
//         final launcher = ref.read(urlControllerProvider.notifier);
//         String facebook = 'https://www.facebook.com/profile.php?.id=100074370350219'; //TODO
//         launcher.launchUrl(facebook);
//       },
//       child: const FaIcon(
//         FontAwesomeIcons.facebook, size: 30,
//       ),
//     ),
//   ),
//
//    Padding(
//      padding: const EdgeInsets.all(10.0),
//      child: GestureDetector(
//        onTap: (){
//          final launcher = ref.read(urlControllerProvider.notifier);
//          String whatsapp = 'https://wa.me/+2349037806442'; //TODO
//          launcher.launchUrl(whatsapp);
//        },
//        child: const FaIcon(
//          FontAwesomeIcons.whatsapp, size: 30,
//        ),
//      ),
//    ),
//
//    Padding(
//      padding: const EdgeInsets.all(10.0),
//      child: GestureDetector(
//        onTap: (){
//          final launcher = ref.read(urlControllerProvider.notifier);
//          String telegram = 'https://instagram.com/campus_latestgister?igshid=YmMyMTA2M2Y='; //TODO
//          launcher.launchUrl(telegram);
//        },
//        child: const FaIcon(
//          FontAwesomeIcons.instagram, size: 30,
//        ),
//      ),
//    ),
//
// ];


final List<String> categoryItems = [
  'All News',
  'Education',
  'Relationship & Lifestyle',
  'Gist',
  'Sports',
];


final List<String> advertCategoryItems = [
  '1 day',
  '3 days',
  'A week',
];



/* Function to select multiple images */
Future<List<dynamic>> pickImages(
    List<dynamic> images
    ) async{
  // List<File> images = [];
  final ImagePicker picker = ImagePicker();
  final imageFiles = await picker.pickMultiImage();
  if(imageFiles.isNotEmpty){
    for(final image in imageFiles){
      // images.add(image.path);
      images.add(File(image.path));
    }
  }
  print(images.length);
  return images;
}


Widget emptyWidget(context) => Center(
  child: Text(
    'This category is currently empty',
    style: TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 30,
    ),
  ),
);

var uuid = const Uuid()..v4().toString();

final padding = Padding(
  padding: EdgeInsets.only(
      left: getProportionateScreenWidth(30),
      right: getProportionateScreenWidth(30),
      top: getProportionateScreenHeight(65),
      bottom: getProportionateScreenHeight(65)  //70
  ),
);


/* Navigation animation */
class BouncyPageRoute extends PageRouteBuilder{
  final Widget widget;

  BouncyPageRoute({ required this.widget}): super(
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (BuildContext context,Animation<double> animation,Animation<double>  secAnimation, Widget child){
        animation = CurvedAnimation(parent: animation, curve: Curves.easeOut);
        return ScaleTransition(scale: animation,
          alignment: Alignment.center,
          child: child,
        );
      },
      pageBuilder: (BuildContext context,Animation<double> animation,Animation<double>  secAnimation ){
        return widget;
      }
  );
}

push(context, route){
  Navigator.of(context).push(BouncyPageRoute(widget: route));
}

pushReplacement(context, route){
  Navigator.of(context).pushReplacement(BouncyPageRoute(widget: route));
}

pop(context){
  Navigator.of(context).pop();
}

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}

final notice = ChangeNotifierProvider<MenuController>(((ref) {
  return MenuController();
}));

// Color kGrey =  #707070;
Color kGrey2 = const Color(0xFF334055);
Color kGrey = const Color.fromRGBO(112, 112, 112, 100);
// Color kGrey =  const Color.fromRGBO(255, 255, 255, 0.4);
Color kWhiteText =  const Color.fromRGBO(255, 255, 255, 1);
Color kBlue =  const Color.fromRGBO(38, 153, 251, 1);
// Color kBlue =  Colors.blue;



container(BuildContext context, Widget child){

  // double w = MediaQuery.of(context).size.width * 1;
  // double h = MediaQuery.of(context).size.width * 1;
  return Scaffold(
    body: SingleChildScrollView(
      // physics: const NeverScrollableScrollPhysics(),
      child: Container(
        // constraints:  BoxConstraints(
        //   maxHeight: h * 3,
        // ),
        // height: h*1.5,
        // width: w,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(
              "images/bg.jpg"
          ),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    ),
  );
}

// launchURL(String url) async{
//   final uri = Uri.parse(url);
//   if(await canLaunchUrl(uri)){
//     await launchUrl(uri);
//   }else{
//     throw 'Could not launch';
//   }
// }

PreferredSizeWidget appBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: 80,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    shadowColor: Colors.transparent,
    flexibleSpace: const Center(
      child: Padding(
        padding: EdgeInsets.only(
            left: 20
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Alienwear',
            style: TextStyle(
                fontSize: 35,
                fontFamily: "MISTRAL",
                // fontWeight: FontWeight.w500,
                color: Colors.white
            ),
          ),
        ),
      ),
    ),
  );
}


/*
Platform  Firebase App Id
web       1:986081970428:web:b2e5438b466740d214ef79
android   1:986081970428:android:3585c882b5849a9014ef79
*/