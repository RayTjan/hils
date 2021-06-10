//Controlers and etc, to the database
import 'dart:io';
import 'dart:ui';
import 'dart:convert';

import 'package:hils/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hils/shared/shared.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

part 'auth_services.dart';
part 'activity_services.dart';
part 'product_services.dart';
part 'spoon_services.dart';
part 'diet_services.dart';
