import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:newproject/provider/auth_provider.dart';
import 'package:newproject/provider/categioryProduct_provider.dart';
import 'package:newproject/ui/home_screen.dart';
import 'package:newproject/utilites/router.dart';
import 'package:provider/provider.dart';

// class MapSample extends StatefulWidget {
//   @override
//   State<MapSample> createState() => MapSampleState();
// }

// class MapSampleState extends State<MapSample> {
//   Completer<GoogleMapController> _controller = Completer();

//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   static final CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: Text('To the lake!'),
//         icon: Icon(Icons.directions_boat),
//       ),
//     );
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }
class MapScreen extends StatefulWidget {
  static String routeName = "/map";

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Select Your Address'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onTap: (latLng) async {
// From coordinates
            final coordinates = Coordinates(latLng.latitude, latLng.longitude);
            var addresses =
                await Geocoder.local.findAddressesFromCoordinates(coordinates);
            var first = addresses.first;
            print("${first.featureName} : ${first.addressLine}");

            Provider.of<AuthProvider>(context, listen: false).userModel.city =
                first.addressLine;
            // Provider.of<CartProvider>(context, listen: false)
            //     .setAddress(first.addressLine);
            User user = FirebaseAuth.instance.currentUser;
            CategioryProductProvider productProvider;

            // bool boo = await FireStoreHelper.fireStoreHelper.addOrder(context);

            //  if (boo) {
            // Provider.of<CartProvider>(context, listen: false).clearAll();
            // SQLHelper.helper.deleteAll();
            Fluttertoast.showToast(
                msg: "Data added successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                fontSize: 16.0);
            if (productProvider.getCheckOutModelList.isNotEmpty) {
              //add order
              FirebaseFirestore.instance.collection("Order").add({
                "Product": productProvider.getCheckOutModelList
                    .map((c) => {
                          "ProductName": c.ordername,
                          "ProductPrice": c.price,
                          "ProductQuetity": c.quentity,
                          "ProductImage": c.image,
                          "Product Color": c.color,
                          "Product Size": c.size,
                        })
                    .toList(),
                "TotalPrice":
                    productProvider.checkOutModel.price.toStringAsFixed(2),
                "UserName": Provider.of<AuthProvider>(context, listen: false)
                    .userModel
                    .fullName,
                "UserEmail": user.email,
                "UserNumber": Provider.of<AuthProvider>(context, listen: false)
                    .userModel
                    .phoneNumber,
                "Useraddress": Provider.of<AuthProvider>(context, listen: false)
                    .userModel
                    .city,
                "UserId": user.uid,
              });

              Fluttertoast.showToast(
                  msg: "Data added successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  fontSize: 16.0);
              // NavigationService.navigationService
              //     .navigateTo(HomeScreen.routeName);
              AppRouter.router.pushToNewWidget(HomeScreen());
            } else {
              Fluttertoast.showToast(
                  msg: "Error",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
