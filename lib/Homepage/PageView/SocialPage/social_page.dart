import 'package:edupay/Homepage/PageView/SocialPage/gallery_image.dart';
import 'package:edupay/Homepage/PageView/SocialPage/post_detail.dart';
import 'package:edupay/Homepage/PageView/SocialPage/social_page_controller.dart';
import 'package:edupay/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../../models/Social/social_model.dart';
import 'build_gallery_image.dart';

class SocialListView extends StatelessWidget {
  final SocialPageController postController = Get.put(SocialPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          leading: SizedBox(),
          actions: [],
          foregroundColor: Colors.white,
          backgroundColor: Colors.white,
          title: Text('EduPay', style: TextStyle(color: kPrimaryColor))),
      body: Obx(() {
        if (postController.posts.isEmpty && postController.isLoading.value) {
          return Center(
              child:
                  CircularProgressIndicator()); // Hiển thị loading khi chưa có bài viết
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            // Kiểm tra nếu cuộn gần cuối danh sách thì load thêm bài viết
            if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                !postController.isLoading.value) {
              postController.loadPosts();
            }
            return true;
          },
          child: ListView.builder(
            itemCount: postController.posts.length +
                (postController.hasMore.value ? 1 : 0), // Thêm item nếu còn bài
            itemBuilder: (context, index) {
              if (index == postController.posts.length) {
                return Center(
                    child:
                        CircularProgressIndicator()); // Hiển thị loading khi cuộn đến cuối
              }

              final post = postController.posts[index];
              return PostItem(post: post);
            },
          ),
        );
      }),
    );
  }
}

class PostItem extends StatelessWidget {
  final SocialModel post;
  final SocialPageController postController = Get.find<SocialPageController>();

  PostItem({required this.post});

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('dd/MM HH:mm');
    return GestureDetector(
      onTap: () {
        // Chuyển đến màn hình chi tiết bài viết
        Get.to(() => PostDetailScreen(post: post));
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(color: Colors.white),
        // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor:
                        Colors.grey[200], // Placeholder background color
                    child: ClipOval(
                      child: Image.network(
                        "",
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.person,
                              size: 30, color: Colors.grey); // Fallback icon
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.author,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Text(
                        dateFormat.format(post.createdAt),
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(post.content),
              SizedBox(height: 10),
              if (post.imageUrls.isNotEmpty) PostContainer(post: post),
              Divider(),
              Obx(() {
                final isLiked = postController.isLiked.value;
                return Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.redAccent : Colors.grey,
                      ),
                      onPressed: () {
                        postController.toggleLike(post.id);
                      },
                    ),
                    Text('${postController.likeCount.value}'),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(Icons.comment_outlined),
                      onPressed: () {
                        _showCommentsBottomSheet(context, post.id);
                      },
                    ),
                    Text('${postController.comments.length}'),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Hiển thị Bottom Sheet để xem và thêm bình luận
  void _showCommentsBottomSheet(BuildContext context, int postId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Obx(() {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: postController.comments.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(postController.comments[index]),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Viết bình luận...',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        // Gửi bình luận
                        postController.addComment(postId, 'Nội dung bình luận');
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        });
      },
    );
  }
}
