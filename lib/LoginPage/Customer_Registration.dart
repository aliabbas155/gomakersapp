import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomakersapp/LoginPage/verifyemail.dart';

import 'package:image_picker/image_picker.dart';

import 'login_page.dart';

class UserModel {
  String? uid;
  String? email;
  String? name;
  String? selectedCity;
  String? imageUrl; // Add this property for the image URL

  UserModel({
    this.uid,
    this.email,
    this.name,
    this.selectedCity,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'selectedCity': selectedCity,
      'imageUrl': imageUrl, // Include it in the map
    };
  }
}

class CustomerRegistrationScreen extends StatefulWidget {
  const CustomerRegistrationScreen({
    super.key,
  });

  @override
  _CustomerRegistrationScreenState createState() =>
      _CustomerRegistrationScreenState();
}

class _CustomerRegistrationScreenState
    extends State<CustomerRegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> cities = [
    "Abbottabad",
    "Arifwala",
    "Abdul Hakim",
    "Alipur",
    "Ahmad pur Sial",
    "Astore",
    "Attock",
    "Awaran",
    "Azad-Kashmir",
    "Balakot",
    "Badin",
    "Bagh",
    "Bahawalnagar",
    "Bahawalpur",
    "Bannu",
    "Bhai Pheru",
    "Bhera",
    "Bhawana",
    "Bhakkar",
    "Bhalwal",
    "Bhimber",
    "Buner",
    "Boorewala",
    "Burewala",
    "Chaghi",
    "Chakwal",
    "Chowk Azam",
    "Choa Saidan Shah",
    "Charsadda",
    "Chichawatni",
    "Chiniot",
    "Chishtian Sharif",
    "Chaubara",
    "Chitral",
    "Chawinda",
    "Chunian",
    "Challas",
    "Dadu",
    "Dina",
    "Daska",
    "Depalpur",
    "Dera Ghazi Khan",
    "Dera Ismail Khan",
    "Dijkot",
    "Duniya Pur",
    "FATA",
    "Faisalabad",
    "Fateh jang",
    "Fateh Pur",
    "Fort Abbas",
    "Feroz wala",
    "Fort Menro",
    "Gaarho",
    "Gadoon",
    "Galyat",
    "Gharo",
    "Ghotki",
    "Gilgit",
    "Gojra",
    "Gujar Khan",
    "Gujranwala",
    "Gwadar",
    "Hafizabad",
    "Hangu",
    "Hazroo",
    "Harappa",
    "Hujra Shah Muqeem",
    "Haripur",
    "Haroonabad",
    "Hasilpur",
    "Hasan Abdal",
    "Haveli Lakha",
    "Hub (Hub Chowki)",
    "Hunza",
    "Hyderabad",
    "Islamabad",
    "Isa Khel",
    "Jand",
    "Jacobabad",
    "Jahanian",
    "Jalalpur Jattan",
    "Jatoi",
    "Jampur",
    "Jauharabad",
    "Jhang",
    "Jhelum",
    "Jaranwala",
    "Karachi",
    "Kaghan",
    "Kahror Pakka",
    "Kalat",
    "Kamalia",
    "Kamoki",
    "Karak",
    "Kasur",
    "Khairpur",
    "Khanewal",
    "Khanpur",
    "Kharian",
    "Kalar kahar",
    "Kallakand",
    "Karor lal esan",
    "Khushab",
    "Khuzdar",
    "Kohat",
    "Kot Addu",
    "Kotli",
    "kot Radha kishan",
    "Lahore",
    "Lakki Marwat",
    "Lalamusa",
    "Larkana",
    "Lasbela",
    "Layyah",
    "Liaquatpur",
    "Lawa",
    "Lodhran",
    "Loralai",
    "Lower Dir",
    "Laliyan",
    "Mailsi",
    "Makran",
    "Malakand",
    "Mandi Bahauddin",
    "Mansehra",
    "Mardan",
    "Matiari",
    "Mian Channu",
    "Mianwali",
    "Minchan abad",
    "Muzaffarabad",
    "Mirpur Khas",
    "Mirpur Sakro",
    "Mirpur",
    "Multan",
    "Murree",
    "Muzaffargarh",
    "Mureedky",
    "Mureedwala",
    "Malakwala",
    "Mankera",
    "Kalur kot",
    "Kot Abdul Malik",
    "Kabir wala",
    "Kher pur",
    "Nankana Sahib",
    "Naran",
    "Narowal",
    "Nasirabad",
    "Nurpur Thal",
    "Naushahro Feroze",
    "Nandi Pur",
    "Noshki",
    "Nawabshah",
    "Neelum",
    "Nowshera",
    "Others Azad Kashmir",
    "Others Balochistan",
    "Others Gilgit Baltistan",
    "Okara",
    "Others Khyber Pakhtunkhwa",
    "Others Punjab",
    "Others Sindh",
    "Others",
    "Pakpattan",
    "Peshawar",
    "Pasroor",
    "Piplan",
    "Pind Dadan Khan",
    "Pindi Gheb",
    "Phool Nagar",
    "Pir Mahal",
    "Pisheen",
    "Pindi Bhattian",
    "Phaliya",
    "Quetta",
    "Qila Didar Snigh",
    "Quidabad",
    "Rawalpindi",
    "Rojhan",
    "Rahim Yar Khan",
    "Rajanpur",
    "Ratwal",
    "Rawalkot",
    "Rohri",
    "Sehwan",
    "Sargodha",
    "Sadiqabad",
    "Sahiwal",
    "Samundri",
    "Sanghar",
    "Shahdadpur",
    "Shahkot",
    "Sheikhupura",
    "Sambrial",
    "Sohawa",
    "Shikarpur",
    "Shorkkot",
    "Sialkot",
    "Soon Valley",
    "Sibi",
    "Skardu",
    "Sukheki",
    "Sudhnoti",
    "Sukkur",
    "Saray Alamgir",
    "Swabi",
    "Swat",
    "Shakargarh",
    "Safdarabad",
    "Sharakpur",
    "Tando Adam",
    "Tando Allah Yar",
    "Tando Bago",
    "Taxila",
    "Thatta",
    "Toba Tek Singh",
    "Taunsa",
    "Tandlianwala",
    "Vehari",
    "Wah Cantt",
    "Wazirabad",
    "Waziristan",
    "Yazman",
    "Zohb",
    "Zafarwal"
  ];
  String? selectedCity;
  bool showPassword = false;
  bool isRegistering = false;
  Image? _selectedImage;
  File? _imageFile;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      setState(() {
        _imageFile = imageFile;
        _selectedImage = Image.file(imageFile);
      });
    }
  }

  Future<String?> uploadImageToFirebaseStorage() async {
    if (_imageFile == null) {
      return null;
    }

    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child('${_auth.currentUser!.uid}.jpg');

    final UploadTask uploadTask = storageReference.putFile(_imageFile!);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    if (taskSnapshot.state == TaskState.success) {
      final imageUrl = await storageReference.getDownloadURL();
      return imageUrl;
    }

    return null;
  }

  Future<void> postDetailsToFirestore(User user) async {
    UserModel userModel = UserModel();
    userModel.uid = user.uid;
    userModel.email = emailController.text;
    userModel.name = nameController.text;
    userModel.selectedCity = selectedCity;

    final imageUrl = await uploadImageToFirebaseStorage();
    if (imageUrl != null) {
      userModel.imageUrl = imageUrl;
    }

    await _firestore
        .collection('ascustomer')
        .doc(user.uid)
        .set(userModel.toMap());

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ));
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Image.asset('assets/images/logo.png'),
              ),
              const SizedBox(height: 10),
              const Text(
                'GoMakers',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(255, 46, 13, 1),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                hint: const Text('Select City'),
                value: selectedCity,
                items: cities.map((city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedCity = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              if (_selectedImage != null)
                Column(
                  children: [
                    _selectedImage!,
                    const SizedBox(height: 10),
                  ],
                ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        _pickImage();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(15, 175, 150,
                            1), // Sets the background color to red
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons
                                .add_a_photo, // Replace this with the icon you want
                            color: Colors.white, // Sets the icon color to white
                          ),
                          SizedBox(
                              width:
                                  8), // Add some spacing between the icon and text
                          Text(
                            'Add Image',
                            style: TextStyle(
                              color:
                                  Colors.white, // Sets the text color to white
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: isRegistering
                    ? const CircularProgressIndicator(
                        color: Colors.green,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: isRegistering
                                ? null
                                : () async {
                                    setState(() {
                                      isRegistering = true;
                                    });

                                    try {
                                      UserCredential userCredential =
                                          await _auth
                                              .createUserWithEmailAndPassword(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                      );

                                      if (userCredential.user != null) {
                                        await postDetailsToFirestore(
                                            userCredential.user!);

                                        // Send verification email
                                        await userCredential.user!
                                            .sendEmailVerification();

                                        await Fluttertoast.showToast(
                                            msg:
                                                'Verification Email Sent, Check Your Email!');

                                        // Navigate to VerifyEmail screen
                                        Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                          builder: (context) =>
                                              const VerifyEmail(),
                                        ));
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      String errorMessage =
                                          'No Internet Access';
                                      switch (e.code) {
                                        case 'invalid-email':
                                          errorMessage =
                                              'Your email address appears to be malformed.';
                                          break;
                                        case 'weak-password':
                                          errorMessage =
                                              'The password is too weak.';
                                          break;
                                        case 'email-already-in-use':
                                          errorMessage =
                                              'The email address is already in use by another account.';
                                          break;
                                        default:
                                          errorMessage = e.code;
                                      }
                                      await Fluttertoast.showToast(
                                          msg: errorMessage);
                                    } catch (e) {
                                      print('Error Posting Details: $e');
                                      await Fluttertoast.showToast(
                                        msg: 'We are Working ',
                                      );
                                    } finally {
                                      setState(() {
                                        isRegistering = false;
                                      });
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(15, 175, 150, 1),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.compare_arrows_sharp,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Register Now',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
