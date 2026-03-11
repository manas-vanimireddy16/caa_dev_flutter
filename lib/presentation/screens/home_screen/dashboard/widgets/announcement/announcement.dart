import 'package:carousel_slider/carousel_slider.dart';
import 'package:code_setup/presentation/common_widgets/header.dart';
import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/models/announcementsModels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnnouncementWidget extends ConsumerStatefulWidget {
  final List<AnnouncementModel> announcements;
  final String? title;
  final String? subtitle;
  final IconData? icon;
  final String? imageUrl;
  final DateTime? date;

  const AnnouncementWidget({
    super.key,
    required this.announcements,
    this.title,
    this.subtitle,
    this.icon,
    this.imageUrl,
    this.date,
  });

  @override
  ConsumerState<AnnouncementWidget> createState() => _AnnouncementWidgetState();
}

class _AnnouncementWidgetState extends ConsumerState<AnnouncementWidget> {
  int _activeIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                HeaderSection(
                  title: widget.title ?? 'Announcements',
                  subtitle:
                      widget.subtitle ?? 'Stay updated with the latest news',
                  icon: widget.icon ?? Icons.announcement,
                ),
                const SizedBox(height: 10),

                CarouselSlider.builder(
                  carouselController: _controller,
                  itemCount: widget.announcements.length,
                  options: CarouselOptions(
                    height: 350,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) {
                      setState(() => _activeIndex = index);
                    },
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final ann = widget.announcements[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: KImageProvider(
                                  image:
                                      'https://drupal.swiftinsights.ai${ann.fieldBanner}',
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),

                                //  Image.network(
                                //   "https://drupal.swiftinsights.ai${ann.fieldBanner}",
                                //   fit: BoxFit.cover,
                                //   height: 200,
                                //   width: double.infinity,
                                // ),
                              ),
                              const SizedBox(height: 8),

                              // Title
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  ann?.title ?? '',
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Color(0xFF1E1E1E),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),

                              // Subtitle
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  ann.fieldAnnouncementCaaTitle ?? '',
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color(0xFF808080),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Footer row with badge
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Announcement',
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Color(0xFF1E1E1E),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFEDE8),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        'New',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          color: Color(0xFF8D2814),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Date
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4,
                                ),
                                child: Text(
                                  'posted on ${ann.fieldActiveAnnouncementFrom}',
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w200,
                                    fontSize: 10,
                                    color: Color(0xFF808080),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Dot indicator container
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.announcements.length, (index) {
                  final isActive = index == _activeIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: isActive ? 24 : 8,
                    decoration: BoxDecoration(
                      color: isActive ? Colors.black : Colors.black26,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
