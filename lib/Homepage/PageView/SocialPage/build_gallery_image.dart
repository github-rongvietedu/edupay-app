import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edupay/models/Social/social_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class PostContainer extends StatelessWidget {
  final SocialModel post;

  const PostContainer({
    Key? key,
    required this.post,
  }) : super(key: key);

  _showGralleyPhotos(BuildContext context, List<String> attachments, index) {
    PageController pageController = PageController(initialPage: index);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 1,
        decoration: const BoxDecoration(
          color: Colors.black,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(10.0),
          //   topRight: Radius.circular(10.0),
          // ),
        ),
        child: Container(
          child: PageView(
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) {},
            controller: pageController,
            children: attachments
                .asMap()
                .entries
                .map((e) => CachedNetworkImage(
                      imageUrl: e.value,
                      fit: BoxFit.contain,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(
                                value: downloadProgress.progress)
                          ],
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ))
                .toList(),
          ),
        ),
      ),
    ).then((value) {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.white));
    });
  }

  Widget _buildAttachmentGalery(BuildContext context, SocialModel post) {
    List<String> attachments = post.imageUrls;
    switch (attachments.length) {
      case 1:
        return InkWell(
            onTap: () {
              _showGralleyPhotos(context, attachments, 0);
            },
            child: Stack(
              children: [
                Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7.5)),
                    ),
                    margin: const EdgeInsets.only(bottom: 5),
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(7.5)),
                      child: attachments[0].contains('http')
                          ? CachedNetworkImage(
                              imageUrl: attachments[0],
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: Column(
                                  children: [
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress)
                                  ],
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          //Image.network(attachments[0])
                          : Image.file(
                              File(attachments[0]),
                              fit: BoxFit.cover,
                            ),
                    )),
              ],
            ));
      case 2:
        return Column(
          children: [
            InkWell(
                onTap: () {
                  _showGralleyPhotos(context, attachments, 0);
                },
                child: Stack(children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      height:
                          MediaQuery.of(context).size.width / 1.777777777777778,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7.5)),
                        child: attachments[0].contains('http')
                            ? CachedNetworkImage(
                                imageUrl: attachments[0],
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: Column(
                                    children: [
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress)
                                    ],
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )
                            : Image.file(
                                File(attachments[0]),
                                fit: BoxFit.cover,
                              ),
                      )),
                ])),
            InkWell(
                onTap: () {
                  _showGralleyPhotos(context, attachments, 1);
                },
                child: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    height:
                        MediaQuery.of(context).size.width / 1.777777777777778,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(7.5)),
                      child: attachments[1].contains('http')
                          ? CachedNetworkImage(
                              imageUrl: attachments[1],
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: Column(
                                  children: [
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress)
                                  ],
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : Image.file(
                              File(attachments[1]),
                              fit: BoxFit.cover,
                            ),
                    )))
          ],
        );
      case 3:
        return Column(
          children: [
            InkWell(
                onTap: () {
                  _showGralleyPhotos(context, attachments, 0);
                },
                child: Row(
                  children: [
                    Expanded(
                        child: Stack(
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.5)),
                            ),
                            margin: const EdgeInsets.only(bottom: 5),
                            height: MediaQuery.of(context).size.width /
                                1.777777777777778,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(7.5)),
                              child: attachments[0].contains('http')
                                  ? CachedNetworkImage(
                                      imageUrl: attachments[0],
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: Column(
                                          children: [
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress)
                                          ],
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )
                                  : Image.file(
                                      File(attachments[0]),
                                      fit: BoxFit.cover,
                                    ),
                            )),
                      ],
                    ))
                  ],
                )),
            Row(
              children: [
                Expanded(
                    child: InkWell(
                        onTap: () {
                          _showGralleyPhotos(context, attachments, 1);
                        },
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7.5)),
                                        ),
                                        margin: const EdgeInsets.only(
                                            bottom: 5, right: 2.5),
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        //   width: MediaQuery.of(context).size.width / 2,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(7.5)),
                                          child: attachments[1].contains('http')
                                              ? CachedNetworkImage(
                                                  imageUrl: attachments[1],
                                                  fit: BoxFit.cover,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Center(
                                                    child: Column(
                                                      children: [
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress)
                                                      ],
                                                    ),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                )
                                              : Image.file(
                                                  File(attachments[1]),
                                                  fit: BoxFit.cover,
                                                ),
                                        )))
                              ],
                            ),
                          ],
                        ))),
                Expanded(
                    child: InkWell(
                        onTap: () {
                          _showGralleyPhotos(context, attachments, 2);
                        },
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7.5)),
                                        ),
                                        margin: const EdgeInsets.only(
                                            bottom: 5, left: 2.5),
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        //  width: MediaQuery.of(context).size.width / 2,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(7.5)),
                                          child: attachments[2].contains('http')
                                              ? CachedNetworkImage(
                                                  imageUrl: attachments[2],
                                                  fit: BoxFit.cover,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Center(
                                                    child: Column(
                                                      children: [
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress)
                                                      ],
                                                    ),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                )
                                              : Image.file(
                                                  File(attachments[2]),
                                                  fit: BoxFit.cover,
                                                ),
                                        )))
                              ],
                            ),
                          ],
                        ))),
              ],
            ),
          ],
        );
      case 4:
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: InkWell(
                        onTap: () {
                          _showGralleyPhotos(context, attachments, 0);
                        },
                        child: Stack(
                          children: [
                            Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.5)),
                                ),
                                margin: const EdgeInsets.only(bottom: 5),
                                height: MediaQuery.of(context).size.width /
                                    1.777777777777778,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7.5)),
                                  child: attachments[0].contains('http')
                                      ? CachedNetworkImage(
                                          imageUrl: attachments[0],
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: Column(
                                              children: [
                                                CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress)
                                              ],
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        )
                                      : Image.file(
                                          File(attachments[0]),
                                          fit: BoxFit.cover,
                                        ),
                                )),
                          ],
                        )))
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: InkWell(
                        onTap: () {
                          _showGralleyPhotos(context, attachments, 1);
                        },
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7.5)),
                                        ),
                                        margin: const EdgeInsets.only(
                                            bottom: 5, right: 2.5),
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        //   width: MediaQuery.of(context).size.width / 2,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(7.5)),
                                          child: attachments[1].contains('http')
                                              ? CachedNetworkImage(
                                                  imageUrl: attachments[1],
                                                  fit: BoxFit.cover,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Center(
                                                    child: Column(
                                                      children: [
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress)
                                                      ],
                                                    ),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                )
                                              : Image.file(
                                                  File(attachments[1]),
                                                  fit: BoxFit.cover,
                                                ),
                                        )))
                              ],
                            ),
                          ],
                        ))),
                Expanded(
                    child: InkWell(
                        onTap: () {
                          _showGralleyPhotos(context, attachments, 2);
                        },
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7.5)),
                                        ),
                                        margin: const EdgeInsets.only(
                                            bottom: 5, left: 2.5),
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        //  width: MediaQuery.of(context).size.width / 2,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(7.5)),
                                          child: attachments[2].contains('http')
                                              ? CachedNetworkImage(
                                                  imageUrl: attachments[2],
                                                  fit: BoxFit.cover,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Center(
                                                    child: Column(
                                                      children: [
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress)
                                                      ],
                                                    ),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                )
                                              : Image.file(
                                                  File(attachments[2]),
                                                  fit: BoxFit.cover,
                                                ),
                                        )))
                              ],
                            ),
                          ],
                        ))),
                Expanded(
                    child: InkWell(
                        onTap: () {
                          _showGralleyPhotos(context, attachments, 3);
                        },
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7.5)),
                                        ),
                                        margin: const EdgeInsets.only(
                                            bottom: 5, left: 2.5),
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        //  width: MediaQuery.of(context).size.width / 2,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(7.5)),
                                          child: attachments[3].contains('http')
                                              ? CachedNetworkImage(
                                                  imageUrl: attachments[3],
                                                  fit: BoxFit.cover,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Center(
                                                    child: Column(
                                                      children: [
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress)
                                                      ],
                                                    ),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                )
                                              : Image.file(
                                                  File(attachments[3]),
                                                  fit: BoxFit.cover,
                                                ),
                                        )))
                              ],
                            ),
                          ],
                        ))),
              ],
            ),
          ],
        );
      case 5:
        return Container();
      case 6:
        return Container();
      case 7:
        return Container();
      case 8:
        return Container();
      case 9:
        return Container();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildAttachmentGalery(context, post);
  }
}
