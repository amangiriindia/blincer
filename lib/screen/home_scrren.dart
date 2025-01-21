import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';
import '../constant/app_color.dart';
import '../constant/voice_to_text.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final VoiceToText _voiceToText = VoiceToText();
  final TextEditingController _searchController = TextEditingController();
  bool _isListening = false;
  String name = 'HackHustler';

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      title: Text("Blincer", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
      headerWidget: _buildHeaderWidget(),
      body: [_buildBodyContent()],
    );
  }

  Widget _buildHeaderWidget() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColor.primary,
                  AppColor.secondary]),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to Blincer", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Your one-stop shop for everything!", style: TextStyle(color: Colors.white70, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          SizedBox(height: 20),
          Text("Hello, $name!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
          SizedBox(height: 16),
          Text("Start Shopping", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey[800])),
          SizedBox(height: 16),
          _buildProductGrid(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: "Search products...",
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(_isListening ? Icons.mic_off : Icons.mic, color: _isListening ? Colors.red : Colors.grey),
          onPressed: () {
            if (_isListening) {
              _stopVoiceInput();
            } else {
              _startVoiceInput();
            }
          },
        ),
      ],
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 3 / 4,
      ),
      itemCount: 8, // Example item count
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 8, spreadRadius: 2)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network("https://via.placeholder.com/150", fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Product ${index + 1}", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text("\$${(index + 1) * 10}", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _startVoiceInput() {
    _voiceToText.startListening(onResult: (recognizedText) {
      setState(() {
        _searchController.text = recognizedText;
      });
    }, onError: (String error) {  }, onStop: () {  });
    setState(() {
      _isListening = true;
    });
  }

  void _stopVoiceInput() {
    _voiceToText.stopListening(onStop: () {  });
    setState(() {
      _isListening = false;
    });
  }
}
