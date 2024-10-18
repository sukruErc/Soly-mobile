import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:solyticket/constants/themes.dart';

String? nameValidator(String? value) {
  if (value!.isEmpty) {
    return "Please enter name";
  }
  return null;
}
String? dobValidator(String? dob) {
  if (dob!.isEmpty) {
    return "Please select date of birth";
  }
  return null;
}

String? emailValidator(String? email) {
  if (email!.isEmpty) {
    return "Please enter email";
  } else {
    if (RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email.toString())) {
      return null;
    } else {
      return "Enter a valid email";
    }
  }
}

String? phoneValidator(String? number) {
  if (number!.isEmpty) {
    return "Please enter telephone";
  } else {
    if (RegExp(r"^[0-9]*$").hasMatch(number.toString())) {
      return null;
    } else {
      return "Enter a valid telephone";
    }
  }
}

//
// String parseTime(DateTime time) {
//   return DateFormat.jm().format(time);
// }
//
// String parseDateTime(DateTime date) {
//   return "${parseDate(date)} ${parseTime(date)}";
// }

void pushNamed(BuildContext context, String routeName) =>
    Navigator.pushNamed(context, routeName);

String? passwordValidator(String? password) {
  if (password!.isEmpty) {
    return "Please enter password";
  } else {
    if (password.length < 8) {
      return "Password too short";
    }
  }
  return null;
}

String? validateConfirmPassword(String password, String? confirm) {
  if (password != confirm) {
    return "Passwords don't match";
  }
  final err = passwordValidator(confirm);
  if (err != null) {
    return err;
  } else {
    return null;
  }
}

String standardFormatTime(DateTime dataTime) {
  final DateFormat formatter = DateFormat('h:mm a');
  return formatter.format(dataTime);
}

Future<File?> pickImage(ImageSource source) async {
  final pickedImage =
      await ImagePicker().pickImage(source: source, imageQuality: 30);
  if (pickedImage != null) {
    return File(pickedImage.path);
  } else {
    // ignore: unnecessary_statements
    ("image is not selected");
  }
  return null;
  // final bytes = await pickedImage!.readAsBytes();
  // return base64Encode(bytes);
}

Future<T?> push<T>(BuildContext context, Widget child) =>
    Navigator.of(context).push<T>(MaterialPageRoute(builder: (_) => child));

void replace(BuildContext context, Widget child) => Navigator.of(context)
    .pushReplacement(MaterialPageRoute(builder: (_) => child));

void pop(BuildContext context) => Navigator.of(context).pop();

void popToMain(BuildContext context) =>
    Navigator.of(context).popUntil((route) => route.isFirst);

snack(String message, {bool isError = false}) {
  return Get.showSnackbar(GetSnackBar(
    backgroundColor: isError ? Colors.red : Colors.green,
    message: message,
    duration: const Duration(seconds: 3),
    snackStyle: SnackStyle.FLOATING,
    margin: const EdgeInsets.all(12),
    borderRadius: 5,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
  ));
}

horizontalGap(double size) {
  return SizedBox(
    width: size,
  );
}

verticalGap(double size) {
  return SizedBox(
    height: size,
  );
}

// Future<File?> pickImage(ImageSource source) async {
//   final pickedImage =
//       await ImagePicker().pickImage(source: source, imageQuality: 30);
//   if (pickedImage != null) {
//     return File(pickedImage.path);
//   } else {
//     // ignore: unnecessary_statements
//     ("image is not selected");
//   }
//   return null;
//   // final bytes = await pickedImage!.readAsBytes();
//   // return base64Encode(bytes);
// }

String parseDate(DateTime date) {
  return DateFormat.yMMMd().format(date);
}

Future<dynamic> showDialogOf(context, Widget child,
    {isDismissible = true}) async {
  showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return child;
      });
}

RoundedRectangleBorder getRoundShape({double? val}) =>
    RoundedRectangleBorder(borderRadius: getRoundBorder(val: val));

BorderRadius getRoundBorder({double? val}) => BorderRadius.circular(val ?? 30);

Widget getLoader() => const Center(child: CircularProgressIndicator());

void alert(BuildContext context, String message,
    {bool info = false, IconData? icon, String? title}) {
  debugPrint(message);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      actionsPadding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20) -
          const EdgeInsets.only(top: 40),
      actionsAlignment: MainAxisAlignment.center,
      title: info
          ? Icon(
              icon ?? Icons.check_circle_outline,
              color: DefaultTheme().greenColor,
              size: 90,
            )
          : Icon(
              icon ?? Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
              size: 90,
            ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title ?? (info ? "Success" : "Error"),
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("Okay"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}

void sureAlert({
  required BuildContext context,
  required String message,
  required void Function() onYes,
}) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 40, horizontal: 120),
        actionsPadding:
            const EdgeInsets.symmetric(vertical: 40, horizontal: 120) -
                const EdgeInsets.only(top: 40),
        actionsAlignment: MainAxisAlignment.center,
        title: Icon(
          Icons.help_outline,
          color: Theme.of(context).primaryColor,
          size: 90,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Are you sure?",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text("Yes"),
            onPressed: () {
              onYes();
              pop(context);
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: const Text("No"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );

// Widget getErrorMessage(BuildContext context, e) {
//   debugPrint(e);
//
//   return Center(
//     child: Text(
//       e is FirebaseException ? e.message ?? e.code : e,
//       style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.red),
//       textAlign: TextAlign.center,
//     ),
//   );
// }

Widget getShimmer({double width = 40, height = 12}) {
  return Container(
    color: Colors.grey,
    height: height,
    width: width,
  );
}

// Widget getFirebaseError(BuildContext context, error) {
//   return getErrorMessage(context,
//       error is FirebaseException ? error.message ?? error.code : '$error');
// }

bool isKeyboardOpen(BuildContext context) =>
    MediaQuery.of(context).viewInsets.bottom != 0;

Future<String?> alertInput(BuildContext context, String title, String hint,
    {String doneText = "Done"}) async {
  final controller = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      actionsAlignment: MainAxisAlignment.center,
      title: Text(title),
      content: SizedBox(
        width: 500,
        child: TextField(
          decoration: InputDecoration(hintText: hint),
          controller: controller,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Text("Cancel", style: TextStyle(color: Colors.orange)),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text(doneText),
          onPressed: () => Navigator.of(context).pop(controller.text),
        ),
      ],
    ),
  );
}
