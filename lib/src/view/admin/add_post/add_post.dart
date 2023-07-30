import 'package:explore_flutter_with_dart_3/src/controllers/create_post.dart';
import 'package:explore_flutter_with_dart_3/src/helper/constants.dart';
import 'package:explore_flutter_with_dart_3/src/helper/responsive.dart';
import 'package:explore_flutter_with_dart_3/src/helper/screen_size.dart';
import 'package:explore_flutter_with_dart_3/src/services/auth/auths_impl.dart';
import 'package:explore_flutter_with_dart_3/src/view/admin/add_post/component/dropdown.dart';
import 'package:explore_flutter_with_dart_3/src/widgets/cards.dart';
import 'package:explore_flutter_with_dart_3/src/widgets/text_field.dart';
import 'package:flutter/foundation.dart';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker_web/image_picker_web.dart';


class AddPost extends ConsumerStatefulWidget {
  const AddPost({Key? key, this.initialPostId}) : super(key: key);

  final String? initialPostId; // if there's initialPostId then edit post

  @override
  ConsumerState<AddPost> createState() => _AddPostState();
}


TextEditingController _title = TextEditingController();
TextEditingController _category = TextEditingController();
TextEditingController _body = TextEditingController();
TextEditingController _author = TextEditingController();
TextEditingController _description = TextEditingController();



class _AddPostState extends ConsumerState<AddPost> {

  // List<int>? _selectedFile;
  final List<dynamic> _pickedImages = [];
  Uint8List? _bytesData;
  String? selectedValue;

  bool isLoading = false;
  final initialDirectoryController = TextEditingController();
  final fileExtensionController = TextEditingController();
  bool lockParentWindow = false;
  final postKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: postKey,
          child: Responsive(
              mobile: _mobile(),
              desktop: _desktop(),
            tablet: _tablet(),
          ),
        ),
      ),
    );
  }




  Widget _tablet() => Padding(
    padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: 20
    ),
    child: Column(
      children: [
        const SizedBox(height: 20,),

        Center(
          child: Text(
            'Create a post',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: getFontSize(20),
                fontWeight: FontWeight.w700
            ),
          ),
        ),
        const SizedBox(height: 20,),

        Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: InputField(
                label: 'Title',
                hint: '',
                x: 1,
                keyboardType: TextInputType.text,
                controller: _title,
              ),
            ),
            const SizedBox(width: 25,),
            Expanded(
              flex: 1,
              child: InputField(
                label: 'Author Name',
                hint: '',
                keyboardType: TextInputType.text,
                controller: _author,
              ),
            ),
            const SizedBox(width: 25,),
            Expanded(
              child: DropDownk(
                  hint: 'Select category',
                  value: selectedValue,
                  dropdownItems: categoryItems,
                  onChanged: (value){
                    setState(() {
                      selectedValue = value;
                      value = _category.text;/////This will save the selected value as text
                      ////// set the value of the editing controller to the selected value
                    });
                  }
              ),
            ),

          ],
        ),

        SizedBox(height: getProportionateScreenHeight(12),),

        InputField(
          label: 'Content/Body',
          hint: '',
          height: 150,
          x: 30,
          keyboardType: TextInputType.multiline,
          controller: _body,
        ),
        // SizedBox(height: getProportionateScreenHeight(19),),


        SizedBox(height: getProportionateScreenHeight(19),),

        GestureDetector(
          onTap: (){
            startWebFilePicker();
          },
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.all(Radius.circular(12))
            ),
            height: getProportionateScreenHeight(200),
            width: getProportionateScreenWidth(200),
            child: const Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 19,
                  ),
                  SizedBox(height: 15,),

                  Text(
                    'Add Image(s)',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // if(_bytesData != null)
        //   Image.memory(_bytesData!, width: 200, height: 200,),

        (_pickedImages != null) ?
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            //     height: 80,
            height: getProportionateScreenHeight(400),
            width: MediaQuery.sizeOf(context).width * 0.35,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, int index){
                return Image.memory(_pickedImages[index]);
              },
              separatorBuilder: (context, index){
                return const SizedBox(width: 5,);
              },
              itemCount: _pickedImages.length,
            ),
          ),
        ) : const SizedBox.shrink(),

        SizedBox(height: getProportionateScreenHeight(18),),
        SizedBox(height: getProportionateScreenHeight(18),),

        RectangularTextButton(
          title: 'Post',
          bgColor: Theme.of(context).cardColor,
          height: getProportionateScreenHeight(75),
          width: getProportionateScreenWidth(120),
          style: TextStyle(
              fontSize: getFontSize(10),
              fontWeight: FontWeight.w700,
              color: Theme.of(context).scaffoldBackgroundColor
          ),
          onTap: (){
            createPost();
          },
        ),

      ],
    ),
  );


  createPost() async{
    if(widget.initialPostId!.isNotEmpty){
      /// TODO update post
    }
    else{
      // Create post
      if(_body.text.isNotEmpty || _title.text.isNotEmpty || selectedValue!.isNotEmpty || _author.text.isNotEmpty){
        postKey.currentState!.save();
        setState(() {
          isLoading = true;
        });
        final user = ref.read(userDetailProvider).value; //TODO: await removed
        final post = ref.read(createPostProvider.notifier);
        debugPrint('Uploading post');
        if(_pickedImages  != null){
          debugPrint('Path: ${_pickedImages.length}');
          await post.uploadPost(
            caption: _body.text,
            url: _pickedImages.first, // upload only the first image
            title: _title.text,
            category: selectedValue!,
            uid: user!.id, username: _author.text,  avatarUrl: user.avatarUrl,
          ).catchError((err){
            showSnackBar(context, text: "Error: $err");
            throw err;
          });
        } else{
          debugPrint('Media-less post');
          await post.uploadTextPost(uid: user!.id, username: user.username,
            title: _title.text,
            category: selectedValue!,
            avatarUrl: user.avatarUrl,
            caption: _body.text,
          ).catchError((err){
            showSnackBar(context, text: "Error: $err");
            throw err;
          });
        }
        setState(() {
          isLoading = false;
        });
        if(!mounted) return;
        showSnackBar(context, text: "Post successfully uploaded");
      } else{
        showSnackBar(context, text: "Title, Author, Content and Category field can't be empty");
      }
    }
  }

  Widget _mobile()=> Padding(
    padding: const EdgeInsets.only(
      top: 20,
      left: 20,
      right: 20,
      bottom: 20
    ),
    child: Column(
      children: [
        const SizedBox(height: 20,),

         Center(
          child: Text(
            'Create a post',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: getFontSize(20),
              fontWeight: FontWeight.w700
            ),
          ),
        ),
        const SizedBox(height: 20,),
        InputField(
          label: 'Title',
          hint: '',
          x: 1,
          keyboardType: TextInputType.text,
          controller: _title,
        ),
        SizedBox(height: getProportionateScreenHeight(12),),

        InputField(
          label: 'Content/Body',
          hint: '',
          height: 150,
          x: 30,
          keyboardType: TextInputType.multiline,
          controller: _body,
        ),
        SizedBox(height: getProportionateScreenHeight(19),),
        Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: InputField(
                label: 'Author Name',
                hint: '',
                keyboardType: TextInputType.text,
                controller: _author,
              ),
            ),
            const SizedBox(width: 25,),
            Expanded(
              child: DropDownk(
                  hint: 'Select category',
                  value: selectedValue,
                  dropdownItems: categoryItems,
                  onChanged: (value){
                    setState(() {
                      selectedValue = value;
                      value = _category.text;/////This will save the selected value as text
                      ////// set the value of the editing controller to the selected value
                    });
                  }
              ),
            ),

          ],
        ),

        SizedBox(height: getProportionateScreenHeight(19),),

        GestureDetector(
          onTap: (){
            startWebFilePicker();
          },
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.all(Radius.circular(12))
            ),
            height: getProportionateScreenHeight(200),
            width: getProportionateScreenWidth(200),
            child: const Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 19,
                  ),
                  SizedBox(height: 15,),

                  Text(
                    'Add Image(s)',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // if(_bytesData != null)
        //   Image.memory(_bytesData!, width: 200, height: 200,),

        (_pickedImages != null) ?
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            //     height: 80,
            height: getProportionateScreenHeight(400),
            width: MediaQuery.sizeOf(context).width * 0.35,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, int index){
                return Image.memory(_pickedImages[index]);
              },
              separatorBuilder: (context, index){
                return const SizedBox(width: 5,);
              },
              itemCount: _pickedImages.length,
            ),
          ),
        ) : const SizedBox.shrink(),

        const SizedBox(height: 20,),

        RectangularTextButton(
          title: 'Post',
          bgColor: Theme.of(context).cardColor,
          height: getProportionateScreenHeight(75),
          width: getProportionateScreenWidth(120),
          style: TextStyle(
              fontSize: getFontSize(10),
              fontWeight: FontWeight.w700,
              color: Theme.of(context).scaffoldBackgroundColor
          ),
          onTap: (){
            createPost();
          },
        ),
      ],
    ),
  );



  Widget _desktop() => Padding(
    padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: 20
    ),
    child: Column(
      children: [
        const SizedBox(height: 20,),

        Center(
          child: Text(
            'Create a post',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: getFontSize(20),
                fontWeight: FontWeight.w700
            ),
          ),
        ),
        const SizedBox(height: 20,),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: InputField(
                label: 'Title',
                hint: '',
                x: 1,
                keyboardType: TextInputType.text,
                controller: _title,
              ),
            ),


            // SizedBox(width: getProportionateScreenHeight(7),),


            const SizedBox(width: 25,),
            Expanded(
              flex: 1,
              child: InputField(
                label: 'Author Name',
                hint: '',
                keyboardType: TextInputType.text,
                controller: _author,
              ),
            ),
          ],
        ),

        InputField(
          label: 'Content/Body',
          hint: '',
          height: 150,
          x: 30,
          keyboardType: TextInputType.multiline,
          controller: _body,
        ),

        SizedBox(height: getProportionateScreenHeight(19),),

        Row(
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: (){
                  startWebFilePicker();
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  height: getProportionateScreenHeight(200),
                  width: getProportionateScreenWidth(200),
                  child: const Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 19,
                        ),
                        SizedBox(height: 15,),

                        Text(
                          'Add Image(s)',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        //TODO
            const SizedBox(width: 20,),
            Expanded(
              child: DropDownk(
                  hint: 'Select category',
                  value: selectedValue,
                  dropdownItems: categoryItems,
                  onChanged: (value){
                    setState(() {
                      selectedValue = value;
                      value = _category.text;/////This will save the selected value as text
                      ////// set the value of the editing controller to the selected value
                    });
                  }
              ),
            ),
          ],
        ),

        // if(_bytesData != null)
        //   Image.memory(_bytesData!, width: 200, height: 200,),

        (_pickedImages != null) ?
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
                padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                  //     height: 80,
              height: getProportionateScreenHeight(400),
              width: MediaQuery.sizeOf(context).width * 0.35,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, int index){
                  return Image.memory(_pickedImages[index]);
                },
                separatorBuilder: (context, index){
                  return const SizedBox(width: 5,);
                },
                itemCount: _pickedImages.length,
              ),
            ),
          ) : const SizedBox.shrink(),

        SizedBox(height: getProportionateScreenHeight(18),),
        SizedBox(height: getProportionateScreenHeight(18),),

        RectangularTextButton(
          title: 'Post',
          bgColor: Theme.of(context).cardColor,
          height: getProportionateScreenHeight(75),
          width: getProportionateScreenWidth(120),
          style: TextStyle(
              fontSize: getFontSize(10),
              fontWeight: FontWeight.w700,
              color: Theme.of(context).scaffoldBackgroundColor
          ),
          onTap: (){
            createPost();
          },
        ),

      ],
    ),
  );
  
  startWebFilePicker() async{
    if(kIsWeb){
      html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
      uploadInput.accept = 'image/*'; // accept only Image files
      uploadInput.multiple = true;
      uploadInput.draggable = true;
      uploadInput.click();

      uploadInput.onChange.listen((event) {
        final files = uploadInput.files;
        final reader = html.FileReader();
        if(files!.length == 1){
          final file = files[0];
          reader.onLoad.listen((event) {
            final result = reader.result;
            if(result is Uint8List){
              setState(() {
                _pickedImages.add(result);
              });
            }
          });
          reader.readAsArrayBuffer(file);
        } else{
          for(var file in files){
            reader.onLoad.listen((event) {
              final result = reader.result;
              if(result is Uint8List){
                setState(() {
                  _pickedImages.add(result);
                });
              }
            });
            reader.readAsArrayBuffer(file);
          }
        }
      });
    }else{
      pickImages(_pickedImages);
    }
  }
}
