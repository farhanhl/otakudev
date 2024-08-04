import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:otakudev/app/data/dtos/anime_list_model.dart';
import 'package:otakudev/app/modules/dashboard/service/dashboard_service.dart';

class DashboardController extends GetxController {
  int currentPage = 1;
  bool isSuccess = true;
  bool isLoading = false;
  bool isFirstLoading = true;
  List<AnimeList> animeList = [];
  final DashboardService service;
  DashboardController(this.service);
  final ScrollController animeListController = ScrollController();
  final PagingController<int, AnimeList> pagingController = PagingController(
    firstPageKey: 1,
  );

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      getListAnime(pageKey);
    });
    getListAnime(currentPage);
  }

  @override
  void onClose() {
    super.onClose();
    pagingController.dispose();
  }

  Future<void> getListAnime(int? page) async {
    isLoading = true;
    update();
    try {
      final data = await service.getListAnime(page);
      Document document = parser.parse(data);
      List<AnimeList> newAnimeList = [];
      var elements = document.querySelectorAll('.venz .detpost');

      for (int i = 0; i < elements.length; i++) {
        var element = elements[i];
        String title = element.querySelector('.jdlflm')?.text.trim() ?? '';
        String image = element.querySelector('img')?.attributes['src'] ?? '';
        String url =
            element.querySelector('.thumb > a')?.attributes['href'] ?? '';
        newAnimeList.add(
          AnimeList(
            id: "$page-$i-${DateTime.now().millisecondsSinceEpoch}",
            title: title,
            image: image,
            url: url,
          ),
        );
      }

      final isLastPage = newAnimeList.length < 6;
      if (isLastPage) {
        pagingController.appendLastPage(newAnimeList);
      } else {
        final nextPageKey = page! + 1;
        pagingController.appendPage(newAnimeList, nextPageKey);
      }

      animeList.addAll(newAnimeList);
      currentPage = page ?? currentPage;
      isLoading = false;
      isSuccess = true;
      isFirstLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      isSuccess = false;
      pagingController.error = e;
      update();
    }
  }
}
