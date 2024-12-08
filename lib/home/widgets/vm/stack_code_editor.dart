import 'package:allium/constants.dart';
import 'package:flutter/material.dart';

class StackCodeEditor extends StatefulWidget {
  const StackCodeEditor({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<StackCodeEditor> createState() => _StackCodeEditorState();
}

class _StackCodeEditorState extends State<StackCodeEditor> {
  late ScrollController _scrollController;
  late TextEditingController _lineNumberController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _lineNumberController = TextEditingController();

    _updateLineNumbers();

    widget.controller.addListener(_updateLineNumbers);
  }

  void _updateLineNumbers() {
    final lines = widget.controller.text.split('\n').length;
    
    _lineNumberController.text = List.generate(lines, (index) => (index + 1).toString())
        .join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: 340,
          width: 600,
          decoration: BoxDecoration(
            color: lightGrey,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          width: 60,
                          padding: const EdgeInsets.all(8.0),
                          color: lightGrey,
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: TextField(
                              textAlign: TextAlign.right,
                              controller: _lineNumberController,
                              readOnly: true,
                              maxLines: null,
                              style: font(
                                color: const Color.fromARGB(255, 68, 68, 68),
                                fontSize: 14,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: TextField(
                            controller: widget.controller,
                            maxLines: null,
                            cursorColor: Colors.grey,
                            style: font(
                              color: const Color.fromARGB(255, 81, 81, 81),
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(8.0),
                              isDense: true,
                              hintText: 'Enter code here...',
                              hintStyle: font(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 8),
                child: Text(
                  "editor",
                  style: font(
                    fontSize: 14,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
