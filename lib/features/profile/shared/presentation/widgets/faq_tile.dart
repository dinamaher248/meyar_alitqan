import 'package:flutter/material.dart';

import '../../../../../core/helper/responsive_size.dart';
import 'faq_item.dart';

class FaqTile extends StatefulWidget {
  final FaqItem item;
  const FaqTile({super.key, required this.item});

  @override
  State<FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<FaqTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:  8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                widget.item.question,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: RS.font(context, 14).clamp(13, 16),
                ),
              ),
              trailing: Icon(
                expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 18,
              ),
              onTap: () => setState(() => expanded = !expanded),
            ),
            if (expanded)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(widget.item.answer, style: TextStyle(fontSize: RS.font(context, 13).clamp(12, 15))),
              ),
          ],
        ),
      ),
    );
  }
}
