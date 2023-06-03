import 'package:flutter/material.dart';
import 'package:photos_api/data/response/status.dart';
import 'package:photos_api/view_model/Home_model.dart';
import 'package:provider/provider.dart';

List homeList = [
  SendData(),
  GetData(),
];

class SendData extends StatelessWidget {
  const SendData({super.key});

  @override
  Widget build(BuildContext context) {
    final uploadFile = Provider.of<HomeModel>(context);
    return Container(
      child: Text(""),
    );
  }
}

class GetData extends StatefulWidget {
  const GetData({super.key});

  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final auth =
          Provider.of<HomeModel>(context, listen: false).getAllFileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final uploadFile = Provider.of<HomeModel>(context);
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: uploadFile.allFiles.length,
          itemBuilder: (context, index) {
            return uploadFile.allFiles.length == 0
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    margin: EdgeInsets.all(20),
                    height: 200,
                    width: 200,
                    child: Image.network(
                      uploadFile.allFiles[index]["filePath"].toString(),
                      loadingBuilder:
                          (BuildContext context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      fit: BoxFit.cover,
                    ),
                  );
          }),
    );
  }
}
