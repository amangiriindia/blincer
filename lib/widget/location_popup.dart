import 'package:blinker/constant/app_color.dart';
import 'package:flutter/material.dart';

void showLocationModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return LocationModalContent();
    },
  );
}

class LocationModalContent extends StatefulWidget {
  @override
  _LocationModalContentState createState() => _LocationModalContentState();
}

class _LocationModalContentState extends State<LocationModalContent> {
  String? currentAddress;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.4, // Initial height of modal (40% of screen height).
      minChildSize: 0.3, // Minimum height of modal.
      maxChildSize: 0.8, // Maximum height of modal.
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHandleBar(),
                SizedBox(height: 16),
                _buildTitle(),
                SizedBox(height: 16),
                _buildCurrentLocationButton(),
                SizedBox(height: 16),
                if (currentAddress != null) _buildCurrentAddressDisplay(),
                SizedBox(height: 16),
                _buildManualAddressInput(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHandleBar() {
    return Center(
      child: Container(
        width: 50,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      "Set Your Location",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCurrentLocationButton() {
    return ElevatedButton.icon(
      onPressed: () {
        // Handle "Get Current Location" logic here.
      },
      icon: Icon(Icons.location_on),
      label: Text("Get Current Location"),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary, // Button color.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _buildCurrentAddressDisplay() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.home, color: Colors.blue),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              currentAddress!,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManualAddressInput() {
    return TextField(
      onSubmitted: (value) {
        setState(() {
          currentAddress = value;
        });
        Navigator.pop(context);
      },
      decoration: InputDecoration(
        hintText: "Enter Address Manually",
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.search, color: Colors.grey),
      ),
    );
  }
}
