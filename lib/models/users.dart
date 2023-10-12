class Users {
  static String? _id;
  static String? _profileImage;
  static String? _name;
  static String? _email;
  static String? _password;
  static String? _phoneNumber;
  static String? _cnicNumber;
  static String? _userCreatedDate;
  static int? _status;
  static String? _address;
  static List? _rating;

  Users({
    String? id,
    String? profileImage,
    String? name,
    String? email,
    String? password,
    String? phoneNumber,
    String? cnicNumber,
    String? userCreatedDate,
    String? address,
    int? status,
    List? rating,
  }) {
    _id = id;
    _profileImage = profileImage;
    _name = name;
    _email = email;
    _password = password;
    _phoneNumber = phoneNumber;
    _cnicNumber = cnicNumber;
    _userCreatedDate = userCreatedDate;
    _status = status;
    _address = address;
    _rating = rating;
  }

  factory Users.fromMap({
    required Map<String, dynamic> map,
  }) {
    return Users(
      name: map["name"],
      email: map["email"],
      password: map["password"],
      phoneNumber: map["phoneNumber"],
      cnicNumber: map["cnic"],
      profileImage: map["profileImage"],
      userCreatedDate: map["createdDate"],
      status: map['status'],
      id: map['userID'],
      address: map['address'],
      rating: map['rating'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      "email": _email,
      "password": _password,
      "phoneNumber": _phoneNumber,
      "cnic": _cnicNumber,
      "profileImage": _profileImage,
      "createdDate": _userCreatedDate,
      "status": _status,
      "address": _address,
      "rating": _rating,
    };
  }

  factory Users.setAllFieldsNull() {
    return Users(
      name: "",
      email: "",
      password: "",
      phoneNumber: "",
      cnicNumber: "",
      profileImage: "",
      userCreatedDate: "",
      status: 0,
      id: "",
      address: "",
      rating: [],
    );
  }

  static String? get getUserId => _id;
  static String? get getName => _name;
  static String? get getEmail => _email;
  static String? get getPassword => _password;
  static String? get getCnic => _cnicNumber;
  static String? get getPhoneNumber => _phoneNumber;
  static String? get getProfileImageURL => _profileImage;
  static int? get getStatus => _status;
  static String? get getAddress => _address;
  static List? get getRating => _rating;

  static setprofileImage({required String? newProfileImage}) {
    _profileImage = newProfileImage;
  }

  static setName({required String? newName}) {
    _name = newName;
  }

  static setEmail({required String? newEmail}) {
    _email = newEmail;
  }

  static setPhoneNumber({required String? newPhoneNumber}) {
    _phoneNumber = newPhoneNumber;
  }

  static setPassword({required String? newPassword}) {
    _password = newPassword;
  }

  static setAddress({required String? newAddress}) {
    _address = newAddress;
  }
}
