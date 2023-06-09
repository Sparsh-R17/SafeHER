import 'package:flutter/material.dart';

class ItemChecklistTile extends StatefulWidget {
  const ItemChecklistTile({
    super.key,
    required List<List<String>> items,
    required this.pageIndex,
    required this.isSelected,
  }) : _items = items;

  final List<List<String>> _items;
  final int pageIndex;
  final List<List<bool>> isSelected;

  @override
  State<ItemChecklistTile> createState() => _ItemChecklistTileState();
}

class _ItemChecklistTileState extends State<ItemChecklistTile> {
  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: widget._items[widget.pageIndex].length,
      itemBuilder: (context, index) {
        return Dismissible(
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) {
            return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      title: const Text('Are you sure ?'),
                      content: const Text(
                          'Do you want to remove the item from the list?'),
                      actions: [
                        TextButton(
                          child: const Text('NO'),
                          onPressed: () => Navigator.pop(context, false),
                        ),
                        TextButton(
                          child: const Text('YES'),
                          onPressed: () {
                            widget._items[widget.pageIndex].removeAt(index);
                            Navigator.pop(context, true);
                          },
                        ),
                      ],
                    ));
          },
          background: Container(
            alignment: Alignment.centerRight,
            color: Theme.of(context).colorScheme.error,
            child: Padding(
              padding: EdgeInsets.only(right: pageWidth * 0.04),
              child: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.onError,
              ),
            ),
          ),
          key: UniqueKey(),
          child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: widget.isSelected[widget.pageIndex][index],
            onChanged: (value) {
              setState(() {
                widget.isSelected[widget.pageIndex][index] = value!;
              });
            },
            title: Text(
              widget._items[widget.pageIndex][index],
              style: TextStyle(
                fontStyle: widget.isSelected[widget.pageIndex][index]
                    ? FontStyle.italic
                    : FontStyle.normal,
                decoration: widget.isSelected[widget.pageIndex][index]
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
        );
      },
    );
  }
}
