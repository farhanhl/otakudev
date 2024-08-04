import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:otakudev/app/data/dtos/anime_info_model.dart';
import 'package:otakudev/app/data/dtos/anime_list_model.dart';
import 'package:otakudev/app/data/dtos/download_model.dart';
import 'package:otakudev/app/data/dtos/episode_list_model.dart';
import 'package:otakudev/app/routes/app_pages.dart';
import 'package:otakudev/app/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otakudev/app/widgets/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu {
  static Widget homeMenu(AnimeList animeList) {
    return InkWell(
      splashColor: transparent,
      highlightColor: transparent,
      enableFeedback: false,
      onTap: () => Get.toNamed(Routes.DETAIL_ANIME, arguments: animeList.url),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0.r),
          border: Border.all(
            color: shadowColor,
            width: 0.5.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 180.h,
              width: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0.r),
                border: Border.all(
                  color: shadowColor,
                  width: 0.5.w,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0.r),
                child: CachedNetworkImage(
                  imageUrl: '${animeList.image}',
                  fit: BoxFit.fill,
                  placeholder: (context, url) {
                    return ShimmerWidget.rectangular(
                      width: 50.w,
                      height: 50.h,
                    );
                  },
                  errorWidget: ((context, url, error) {
                    return Lottie.asset(
                      "assets/lotties/failed.json",
                      width: 50.w,
                      height: 50.h,
                    );
                  }),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.h, left: 8.w, right: 8.w),
              child: Text(
                '${animeList.title}',
                style: const TextStyle(fontWeight: FontWeight.w800),
                maxLines: 2,
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget episodeList({
    required EpisodeList episodeList,
    required AnimeInfo animeInfo,
  }) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.WATCH_ANIME,
        arguments: {
          'episodeUrl': episodeList.url,
          'animeInfo': animeInfo,
        },
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        color: primaryColor,
        child: ListTile(
          title: Text(
            "${episodeList.title}",
            maxLines: 3,
            style: TextStyle(
              fontSize: 18.sp,
              color: lightColor,
            ),
          ),
          subtitle: Text(
            "${episodeList.date}",
            maxLines: 3,
            style: const TextStyle(
              color: lightColor,
            ),
          ),
        ),
      ),
    );
  }

  static Widget downloadList(DownloadOption downloadOption) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: primaryColor,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${downloadOption.format} ",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: darkColor,
                  ),
                ),
                TextSpan(
                  text: "${downloadOption.quality}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: darkColor,
                  ),
                ),
                TextSpan(
                  text: " | ",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: darkColor,
                  ),
                ),
                TextSpan(
                  text: "${downloadOption.size}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: darkColor,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.left,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 50.h,
            width: Get.width.w,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return false;
              },
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                controller: ScrollController(),
                shrinkWrap: true,
                itemCount: downloadOption.links?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: ElevatedButton(
                      onPressed: () => openDownloadLink(
                        downloadOption.links?[index].url ?? "",
                      ),
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        backgroundColor:
                            WidgetStateProperty.all<Color?>(primaryColor),
                      ),
                      child: Text(
                        downloadOption.links?[index].server ?? "",
                        style: const TextStyle(
                          color: lightColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void openDownloadLink(String download) async {
  final Uri downloadUrl = Uri.parse(download);

  if (await canLaunchUrl(downloadUrl)) {
    await launchUrl(downloadUrl);
  } else {
    throw 'Could not launch $downloadUrl';
  }
}
