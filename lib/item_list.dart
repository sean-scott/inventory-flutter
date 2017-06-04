import 'package:flutter/material.dart';

import 'item_data.dart';
import 'item_row.dart';

class ItemList extends StatelessWidget {
  const ItemList({Key key, this.items, this.onOpen, this.onShow, this.onAction, this.onQuantityUp, this.onQuantityDown}) : super(key: key);

  final List<Item> items;
  final ItemRowActionCallback onOpen;
  final ItemRowActionCallback onShow;
  final ItemRowActionCallback onAction;
  final ItemRowActionCallback onQuantityUp;
  final ItemRowActionCallback onQuantityDown;

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      key: const ValueKey<String>('item-list'),
      itemExtent: ItemRow.kHeight,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return new ItemRow(
          item: items[index],
          onPressed: onOpen,
          onDoubleTap: onShow,
          onLongPress: onAction,
          onIncreaseQuantity: onQuantityUp,
          onDecreaseQuantity: onQuantityDown,
        );
      },
    );
  }
}