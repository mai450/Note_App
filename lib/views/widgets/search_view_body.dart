import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/cubits/search_cubit/search_cubit.dart';
import 'package:note/views/widgets/search_result_listview.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    textEditingController.addListener(
      () {
        BlocProvider.of<SearchCubit>(context)
            .getNotes(searchText: textEditingController.text);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 16),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  25,
                ),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  25,
                ),
                borderSide: BorderSide(color: Colors.grey),
              ),
              hintText: 'Search..',
            ),
            onChanged: (value) {
              if (value.trim().isNotEmpty) {
                BlocProvider.of<SearchCubit>(context).search(searchText: value);
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: SearchResultListview(),
          ),
        ],
      ),
    );
  }
}
