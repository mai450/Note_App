import 'package:flutter/material.dart';
import 'package:note/constants/const.dart';
import 'package:note/models/note_model.dart';
import 'package:note/views/widgets/pick_color.dart';

class EditNoteColor extends StatefulWidget {
  const EditNoteColor({super.key, required this.note});

  final NoteModel note;

  @override
  State<EditNoteColor> createState() => _EditNoteColorState();
}

class _EditNoteColorState extends State<EditNoteColor> {
  late int currentIndex;

  @override
  void initState() {
    currentIndex = kColors.indexOf(Color(widget.note.color));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 39 * 2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: kColors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                currentIndex = index;
                widget.note.color = kColors[index].value;
                setState(() {});
              },
              child: ColorItem(
                color: kColors[index],
                isSelected: currentIndex == index,
              ));
        },
      ),
    );
  }
}
