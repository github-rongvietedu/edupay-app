import 'package:edupay/models/Social/social_model.dart';
import 'package:edupay/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../../core/base/base_controller.dart';

class SocialPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SocialPageController());
  }
}

class SocialPageController extends BaseController {
  var posts = <SocialModel>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  var page = 1;

  var likeCount = 0.obs;
  var isLiked = false.obs;
  var comments = <String>[].obs;

  // Gọi API để lấy bài viết
  void loadPosts() async {
    if (isLoading.value || !hasMore.value) return;
    isLoading.value = true;

    List<SocialModel> newPosts = await fetchPostsFromApi(page);
    if (newPosts.isEmpty) {
      hasMore.value = false;
    } else {
      posts.addAll(newPosts);
      page++;
    }

    isLoading.value = false;
  }

  // Tắt/Bật Like
  void toggleLike(int postId) {
    isLiked.value = !isLiked.value;
    likeCount.value += isLiked.value ? 1 : -1;
  }

  // Thêm bình luận
  void addComment(int postId, String comment) {
    comments.add(comment);
  }

  Future<List<SocialModel>> fetchPostsFromApi(int page) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(
      10,
      (index) => SocialModel(
        id: index,
        author: 'Tác giả $index',
        imageUrls: [
          'https://picsum.photos/seed/picsum/200/300',
          'https://picsum.photos/200/300'
        ],
        content: 'Nội dung bài viết $index',
        createdAt: DateTime.now().subtract(Duration(hours: index)),
      ),
    );
  }

  @override
  void onInit() async {
    loadPosts();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
