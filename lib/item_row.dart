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

  static const double kHeight = 120.0;

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
        decoration: new BoxDecoration(
          border: new Border(
            bottom: new BorderSide(color: Theme.of(context).dividerColor)
          )
        ),
        child: new Row(
          children: <Widget>[
            new Expanded(
              flex: 3,
              child: new Container(
                child: new Icon(Icons.photo),
              )
            ),
            new Expanded(
              flex: 6,
              child: new Container(
                child: new Column(
                  children: [
                    new Expanded(
                      child: new Container(
                        // empty for spacing
                      )
                    ),
                    new Expanded(
                      child: new Container(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Text(item.name,
                              style: new TextStyle(
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Expanded(
                      child: new Container(
                        child: new Row(
                          children: [
                            new Expanded(
                              child: new Icon(Icons.date_range, color: Colors.black54),
                            ),
                            new Expanded(
                              flex: 2,
                              child: new Text("12/31/2001", 
                                style: new TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            new Expanded(
                              child: new Container(
                                // empty for spacing
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new Expanded(
              flex: 3,
              child: new Container(
                child: new Column(
                  children: [
                    new Expanded(
                      child: new Container(
                        child: new IconButton(
                          icon: const Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.black54,
                          ), 
                          onPressed: _getHandler(onIncreaseQuantity)
                        ),
                      ),
                    ),
                    new Expanded(
                      child: new Container(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Text(item.quantity.toString(), 
                              style: new TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Expanded(
                      child: new Container(
                        child: new IconButton(
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black54,
                          ), 
                          onPressed: _getHandler(onDecreaseQuantity)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]
        )
      )
    );
  }
}