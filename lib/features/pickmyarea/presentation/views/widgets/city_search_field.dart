import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key, required this.onChanged});
  final void Function(String) onChanged;
  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final FocusNode _searchFocus = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _searchFocus.addListener(() {
      setState(() {}); // Rebuild when focus changes
    });
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            focusNode: _searchFocus,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: S.of(context).search_city,
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ),
        ),
        if (_searchFocus.hasFocus || _searchController.text.isNotEmpty)
          TextButton(
            onPressed: () {
              _searchController.clear();
              _searchFocus.unfocus();
              widget.onChanged('');
            },
            child: Text(S.of(context).cancel),
          ),
      ],
    );
  }
}
