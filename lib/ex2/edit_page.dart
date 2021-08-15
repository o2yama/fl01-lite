import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'model/memo.dart';

final memoController = TextEditingController();

class EditPage extends HookWidget {
  const EditPage({Key? key, this.memo}) : super(key: key);
  final Memo? memo;

  static Route<Widget> route(Memo? memo) {
    if (memo != null) {
      memoController.text = memo.content;
    } else {
      memoController.clear();
    }
    return MaterialPageRoute<Widget>(
      builder: (_) => EditPage(memo: memo),
      fullscreenDialog: memo == null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _dbModel = useProvider(dbProvider);
    var saveButtonColor = useState((Colors.grey[300]!));

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          leading: TextButton(
            onPressed: () {
              memoController.clear();
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          middle: Text(
            'Edit Memo',
            style: Theme.of(context).textTheme.headline1,
          ),
          trailing: TextButton(
            onPressed: () {
              if (memoController.text.isNotEmpty && this.memo != null) {
                _dbModel.updateMemo(
                  memo!.id,
                  MemosCompanion(content: Value(memoController.text)),
                );
              } else if (memoController.text.isNotEmpty) {
                _dbModel.insertMemo(
                  MemosCompanion(content: Value(memoController.text)),
                );
              }
              Navigator.pop(context);
            },
            child: Text(
              'Save',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: saveButtonColor.value,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
          child: CupertinoTextField(
            minLines: 1,
            maxLines: 1,
            controller: memoController,
            onChanged: (text) {
              if (memoController.text.isEmpty) {
                saveButtonColor.value = Colors.grey;
              } else {
                saveButtonColor.value = Colors.blue;
              }
            },
          ),
        ),
      ),
    );
  }
}
