import 'dart:async';

import 'package:etkinlikapp/core/constants/constants.dart';
import 'package:etkinlikapp/core/widgets/custom_sizedbox_height.dart';
import 'package:etkinlikapp/features/event_room/domain/models/event_rooms_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventDetail extends StatefulWidget {
  final EventRoomModel event;
  const EventDetail({required this.event, super.key});

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  String mapTheme = '';
  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context).loadString('assets/json/dark_map_theme.json').then((value) {
      mapTheme = value;
    });
  }

  final Completer<GoogleMapController> googleMapController = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 15, 15),
      appBar: AppBar(
        title: Text('Etkinlik Detayları'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/login_background.jpg',
                ),
              ),
              const HeightBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.event.eventName,
                    style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: appBarColor,
                    ),
                    height: 60,
                    width: 125,
                    child: Center(
                      child: Text(
                        widget.event.approvedUsers.length.toString() + ' Katılımcı',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              HeightBox(height: 25),
              Text(
                widget.event.eventDetail,
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 1),
              ),
              HeightBox(height: 25),
              ListTile(
                contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: appBarColor,
                  ),
                  height: 50,
                  width: 50,
                  child: Icon(
                    Icons.location_on,
                    color: buttonColor,
                  ),
                ),
                title: Text(
                  widget.event.province + ' / ' + widget.event.district,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  widget.event.addressDetail,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: appBarColor,
                  ),
                  height: 50,
                  width: 50,
                  child: Icon(
                    Icons.date_range,
                    color: buttonColor,
                  ),
                ),
                title: Text(
                  'Tarih: ' + widget.event.eventDate,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  'Saat: ' + widget.event.eventTime,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              HeightBox(height: 15),
              Text(
                'Konum',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
              ),
              HeightBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                height: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: InteractiveViewer(
                    child: GoogleMap(
                      onMapCreated: (GoogleMapController controller) {
                        controller.setMapStyle(mapTheme);
                        googleMapController.complete(controller);
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(41.3766, 33.7765),
                        zoom: 16,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId('_currentLocation'),
                          position: LatLng(41.3766, 33.7765),
                        ),
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
