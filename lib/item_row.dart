import 'package:flutter/material.dart';

import 'item_data.dart';

typedef void ItemRowActionCallback(Item item);

class ItemRow extends StatelessWidget {
  ItemRow({
    this.item,
    this.onPressed,
    this.onDoubleTap,
    this.onLongPress,
    this.onIncreaseQuantity,
    this.onDecreaseQuantity,
  }) : super(key: new ObjectKey(item));

  final Item item;
  final ItemRowActionCallback onPressed;
  final ItemRowActionCallback onDoubleTap;
  final ItemRowActionCallback onLongPress;
  final ItemRowActionCallback onIncreaseQuantity;
  final ItemRowActionCallback onDecreaseQuantity;

  static const double kHeight = 150.0;

  GestureTapCallback _getHandler(ItemRowActionCallback callback) {
    return callback == null ? null : () => callback(item);
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: _getHandler(onPressed),
      onDoubleTap: _getHandler(onDoubleTap),
      onLongPress: _getHandler(onLongPress),
      child: new Container(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 20.0),
        decoration: new BoxDecoration(
          border: new Border(
            bottom: new BorderSide(color: Theme.of(context).dividerColor)
          )
        ),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    flex: 2,
                    child: new Text(
                      item.name
                    )
                  ),
                  new Column(
                    children: <Widget>[
                      new IconButton(
                        icon: const Icon(Icons.keyboard_arrow_up),
                        onPressed: _getHandler(onIncreaseQuantity),
                      ),
                      new Text(
                        item.quantity.toString(),
                      ),
                      new IconButton(
                        icon: const Icon(Icons.keyboard_arrow_down),
                        onPressed: _getHandler(onDecreaseQuantity),
                      ),
                    ]
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}