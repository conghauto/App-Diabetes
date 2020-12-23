import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:share_extend/share_extend.dart';

class PdfViewerPage extends StatelessWidget {
  final String path;
  final String name;
  const PdfViewerPage({Key key, this.path, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {
            Navigator.pop(context)
          },
        ),
        title: Text(name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              final File file = File(path);
              ShareExtend.share(path, "file");
            },
          )
        ]
      ),
      path: path,
    );
  }
}