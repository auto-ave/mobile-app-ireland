import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/shimmer_placeholder.dart';
import 'package:themotorwash/utils/utils.dart';

class StoreGalleryViewScreen extends StatefulWidget {
  static const String route = "/storeGalleryView";
  final List<String> images;
  StoreGalleryViewScreen({Key? key, required this.images}) : super(key: key);

  @override
  State<StoreGalleryViewScreen> createState() {
    FlutterUxcam.tagScreenName(route);
    return _StoreGalleryViewScreenState();
  }
}

class _StoreGalleryViewScreenState extends State<StoreGalleryViewScreen> {
  bool _showPhoto = false;
  String _currentUrl = "";
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_showPhoto) {
          setState(() {
            _showPhoto = false;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: getAppBarWithBackButton(
            context: context,
            title: Text(
              'Store Gallery',
              style: SizeConfig.kStyle14Bold.copyWith(color: Colors.black),
            )),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 100.w,
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 32),
                child: Wrap(
                  // crossAxisAlignment: WrapCrossAlignment.start,
                  // runAlignment: WrapAlignment.start,
                  alignment: WrapAlignment.spaceEvenly,
                  runSpacing: 16,

                  spacing: 4,
                  children: widget.images
                      .map((e) => ImageTile(
                          onTap: (url) {
                            setState(() {
                              _showPhoto = true;
                              _currentUrl = url;
                            });
                            _pageController
                                .jumpToPage(widget.images.indexOf(url));
                          },
                          url: e))
                      .toList(),
                ),
              ),
            ),
            Visibility(
              visible: _showPhoto,
              maintainState: true,
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider:
                        CachedNetworkImageProvider(widget.images[index]),
                    initialScale: PhotoViewComputedScale.contained * 0.8,
                    // heroAttributes: PhotoViewHeroAttributes(
                    //     tag: galleryItems[index].id),
                  );
                },
                itemCount: widget.images.length,

                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                        // value: event == null
                        //     ? 0
                        //     : event.cumulativeBytesLoaded /
                        //         event.expectedTotalBytes,
                        ),
                  ),
                ),
                // backgroundDecoration: widget.backgroundDecoration,
                pageController: _pageController,
                // onPageChanged: onPageChanged,
              ),
            )
          ],
        ),
      ),
    );

    //     Stack(
    //   children: [
    //     Positioned.fill(
    //       child:
    // _showPhoto
    //     ? PhotoView(
    //         imageProvider: NetworkImage(images[0]),
    //       )
    //     : SizedBox.shrink()
    //   ],
    // ))
    // ;
  }
}

class ImageTile extends StatelessWidget {
  final String url;
  final Function(String url) onTap;

  const ImageTile({Key? key, required this.onTap, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(url),
      child: CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, prov) {
          return Container(
              height: 30.w,
              width: 30.w,
              decoration: BoxDecoration(
                  image: DecorationImage(image: prov, fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(4)));
        },
        placeholder: (context, string) {
          return Container(
            height: 30.w,
            width: 30.w,
            child: ShimmerPlaceholder(
              borderRadius: BorderRadius.circular(4),
            ),
          );
        },
      ),
    );
  }
}
