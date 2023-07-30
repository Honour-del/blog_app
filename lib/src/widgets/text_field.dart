import 'package:flutter/material.dart';


class InputField extends StatelessWidget {
  const InputField({Key? key, required this.label, required this.hint, this.suffixIcon, required this.keyboardType, this.controller, this.height, this.validator, this.x,}) : super(key: key);

  final String? Function(String?)? validator;
  final String label;
  final String hint;
  final int? x;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SizedBox(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(label,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 15,
                ),
              ),
            ),

            const SizedBox(height: 19,),

            Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(14, 32, 51, 1),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      width: 0, color: Colors.transparent,
                    ),
                  ),
                  hintText: hint,
                  hintStyle: const TextStyle(
                      color: Color.fromRGBO(139, 139, 139, 1)
                  ),
                  suffixIcon: suffixIcon,
                ),
                style: const TextStyle(color: Colors.white),
                controller: controller,
                maxLines: x,
                validator: validator,
                // obscureText: obscure,
                keyboardType: keyboardType,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
