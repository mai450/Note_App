import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:note/models/note_model.dart';
import 'package:note/views/widgets/custom_button.dart';
import 'package:note/views/widgets/custom_text_feild.dart';
import 'package:note/views/widgets/pick_color.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({
    super.key,
  });

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? title, content;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          CustomTextfield(
            hintText: 'Title',
            onSave: (value) {
              title = value;
            },
          ),
          SizedBox(
            height: 12,
          ),
          CustomTextfield(
            hintText: 'Content',
            onSave: (value) {
              content = value;
            },
            maxLine: 5,
          ),
          SizedBox(
            height: 20,
          ),
          PickColor(),
          SizedBox(
            height: 20,
          ),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              return CustomButton(
                buttonText: 'Add',
                isLoading: state is AddNoteLoading ? true : false,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    var currentDate = DateTime.now();
                    var formattedDate =
                        DateFormat('dd-MM-yyyy').format(currentDate);
                    var note = NoteModel(
                        title: title!,
                        content: content!,
                        date: formattedDate,
                        color:
                            BlocProvider.of<AddNoteCubit>(context).color.value);
                    BlocProvider.of<AddNoteCubit>(context).addNote(note);
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
