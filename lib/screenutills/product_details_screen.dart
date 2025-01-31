import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';
import '../constant/app_color.dart';
import '../service/product_service.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({required this.productId, Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isLoading = true;
  bool isLiked = false;
  Map<String, dynamic>? productDetails;
  List<Uint8List> imageList = [];

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  Future<void> _fetchProductDetails() async {
    try {
      final product = await ProductService().fetchSingleProduct(widget.productId);
      setState(() {
        productDetails = product;
        isLoading = false;
        _processImages();
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void _processImages() {
    if (productDetails != null) {
      imageList.clear();
      if (productDetails!['itemImage'] != null) {
        imageList.add(Uint8List.fromList(List<int>.from(productDetails!['itemImage']['data'])));
      }
      if (productDetails!['thumbnailImage'] != null) {
        imageList.add(Uint8List.fromList(List<int>.from(productDetails!['thumbnailImage']['data'])));
      }
    }
  }

  void _openFullScreenGallery(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImageGallery(images: imageList, initialIndex: index),
      ),
    );
  }

  void _shareProduct() {
    if (productDetails != null) {
      Share.share('Check out this product: ${productDetails!['name']} - ₹${productDetails!['price']}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: AppColor.primary,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: isLiked ? Colors.red : Colors.grey),
            onPressed: () {
              setState(() {
                isLiked = !isLiked;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareProduct,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : productDetails == null
              ? Center(child: Text('Failed to load product details.'))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (imageList.isNotEmpty)
                          CarouselSlider.builder(
                            itemCount: imageList.length,
                            options: CarouselOptions(
                              height: 250,
                              enlargeCenterPage: true,
                              autoPlay: true,
                            ),
                            itemBuilder: (context, index, _) {
                              return GestureDetector(
                                onTap: () => _openFullScreenGallery(index),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.memory(
                                    imageList[index],
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          )
                        else
                          Container(
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(Icons.image, size: 50, color: Colors.grey[700]),
                          ),

                        SizedBox(height: 16),
                        if (productDetails!['name'] != null)
                          Text(
                            productDetails!['name'],
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        SizedBox(height: 8),
                        if (productDetails!['description'] != null)
                          Text(
                            productDetails!['description'],
                            style: TextStyle(fontSize: 16),
                          ),
                        SizedBox(height: 8),
                        if (productDetails!['status'] != null)
                          Text(
                            'Status: ${productDetails!['status'] ? 'Available' : 'Unavailable'}',
                            style: TextStyle(
                              fontSize: 16,
                              color: productDetails!['status'] ? Colors.green : Colors.red,
                            ),
                          ),
                        SizedBox(height: 8),
                        if (productDetails!['price'] != null)
                          Text(
                            'Price: ₹${productDetails!['price']}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.shopping_cart, color: Colors.white),
                                label: Text("Add to Cart", style: TextStyle(fontSize: 18, color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primary,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.flash_on, color: Colors.white),
                                label: Text("Buy Now", style: TextStyle(fontSize: 18, color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}


// Full-Screen Image Viewer
class FullScreenImageGallery extends StatelessWidget {
  final List<Uint8List> images;
  final int initialIndex;

  const FullScreenImageGallery({required this.images, required this.initialIndex, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: PhotoViewGallery.builder(
        itemCount: images.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: MemoryImage(images[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(color: Colors.black),
        pageController: PageController(initialPage: initialIndex),
      ),
    );
  }
}
