import 'package:edupay/Homepage/PageView/SocialPage/gallery_image.dart';
import 'package:edupay/Homepage/PageView/SocialPage/social_page_controller.dart';
import 'package:edupay/models/Social/social_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class PostDetailScreen extends StatelessWidget {
  final SocialModel post;
  final SocialPageController postController = Get.find<SocialPageController>();

  PostDetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết bài viết'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.author,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              post.createdAt.toString(),
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 10),

            // Gallery ảnh
            if (post.imageUrls.isNotEmpty)
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Số lượng ảnh trên một hàng
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: post.imageUrls.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Khi bấm vào ảnh, mở xem toàn màn hình
                        Get.to(() => FullScreenGallery(
                              images: post.imageUrls,
                              initialIndex: index,
                            ));
                      },
                      child: CachedNetworkImage(
                        imageUrl: post.imageUrls[index],
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            SizedBox(height: 10),
            Text(post.content),
            Divider(),
            Obx(() {
              final isLiked = postController.isLiked.value;
              return Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                      color: isLiked ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () {
                      postController.toggleLike(post.id);
                    },
                  ),
                  Text('${postController.likeCount.value} lượt thích'),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.comment_outlined),
                    onPressed: () {
                      _showCommentsBottomSheet(context, post.id);
                    },
                  ),
                  Text('${postController.comments.length} bình luận'),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

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
