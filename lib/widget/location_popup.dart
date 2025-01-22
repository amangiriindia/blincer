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
      initialChildSize: 0.5, // Start at 50% of screen height.
      minChildSize: 0.4, // Minimum height is 40% of screen height.
      maxChildSize: 0.85, // Maximum height is 85% of screen height.
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHandleBar(),
                const SizedBox(height: 24),
                _buildTitle(),
                const SizedBox(height: 20),
                _buildCurrentLocationButton(),
                const SizedBox(height: 24),
                if (currentAddress != null) _buildCurrentAddressDisplay(),
                const SizedBox(height: 24),
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
          gradient: LinearGradient(
            colors: [AppColor.primary, AppColor.secondary],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      "Set Your Location",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColor.primary,
      ),
    );
  }

  Widget _buildCurrentLocationButton() {
    return ElevatedButton.icon(
      onPressed: () {
        // Handle "Get Current Location" logic here.
      },
      icon: Icon(Icons.my_location_rounded, color: Colors.white),
      label: Text(
        "Get Current Location",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5,
        shadowColor: AppColor.secondary.withOpacity(0.5),
      ),
    );
  }

  Widget _buildCurrentAddressDisplay() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.location_on_rounded, color: AppColor.primary, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              currentAddress!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.edit_location_alt_rounded, color: AppColor.primary),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }
}
