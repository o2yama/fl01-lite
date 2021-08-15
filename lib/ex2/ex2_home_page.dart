import 'package:fl01_lite/ex2/edit_page.dart';
import 'package:fl01_lite/ex2/model/memo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Ex2HomePage extends HookWidget {
  const Ex2HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _dbModel = useProvider(dbProvider);

    Widget memoTile(Memo memo) {
      return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        secondaryActions: [
          SlideAction(
            onTap: () => _dbModel.deleteMemo(memo.id),
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.red,
          ),
        ],
        child: ListTile(
          onTap: () => Navigator.push(context, EditPage.route(memo)),
          title: Text(
            memo.content,
            style: Theme.of(context).textTheme.headline2,
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(
          'My Homes',
          style: Theme.of(context).textTheme.headline1,
        ),
        trailing: GestureDetector(
          onTap: () {
            Navigator.push(context, EditPage.route(null));
          },
          child: Icon(Icons.add, color: Colors.blue),
        ),
      ),
      body: StreamBuilder<List<Memo>>(
          stream: _dbModel.watchMemos(),
          builder: (BuildContext context, AsyncSnapshot<List<Memo>> snapshot) {
            return !snapshot.hasData
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return memoTile(snapshot.data![index]);
                      },
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(height: 1, color: Colors.grey),
                    ),
                  );
          }),
    );
  }
}
