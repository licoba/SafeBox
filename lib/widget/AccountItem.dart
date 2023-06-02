import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../model/LeftImageObject.dart';

class AccountItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final VoidCallback? onLongTap;

  const AccountItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.onTap,
      this.onLongTap})
      : super(key: key);

  @override
  State<AccountItem> createState() => _AccountItemState();
}

class _AccountItemState extends State<AccountItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onLongPress: widget.onLongTap,
      // child: ListTile(
      //   title: Text(widget.title, style: const TextStyle(color: Colors.black)),
      //   subtitle: Text(widget.subtitle.isNotEmpty ? widget.subtitle : "无" ,
      //       style: const TextStyle(color: Colors.grey)),
      // ),
      child: Container(
        height: 80,
        child: InkWell(
          onTap: widget.onTap,
          child: Row(
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ItemLeftImage(title: widget.title)),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade400,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle.isNotEmpty ? widget.subtitle : "无",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(width: 32)
            ],
          ),
        ),
      ),
    );
  }
}

// 左边的图片
class ItemLeftImage extends StatefulWidget {
  final String title;

  const ItemLeftImage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<ItemLeftImage> createState() => _ItemLeftImageState();
}

class _ItemLeftImageState extends State<ItemLeftImage> {
  @override
  Widget build(BuildContext context) {
    String imageUrl = LeftImageObject.getImgUrl(widget.title);

    return Container(
      width: 64,
      height: 64,
      decoration: imageUrl.isEmpty
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(width: 1.0, color: Colors.grey.shade400),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
      child: imageUrl.isEmpty // 没有链接
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: Text(
                    widget.title.trimLeft()[0],
                    style: const TextStyle(fontSize: 30, color: Colors.grey),
                  ),
                ),
              ),
            )
          : imageUrl.toLowerCase().endsWith('.svg')
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: SvgPicture.asset(
                    imageUrl,
                    fit: BoxFit.fitWidth,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.fitWidth,
                  ),
                ),
    );
  }
}
