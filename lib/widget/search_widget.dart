// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:restaurants_apps/bloc/search/search_api.dart';
import 'package:restaurants_apps/bloc/search/search_bloc.dart';
import 'package:restaurants_apps/bloc/search/search_state.dart';
import 'package:restaurants_apps/data/api/api.dart';
import 'package:restaurants_apps/data/model/restaurantresults.dart';
import 'package:restaurants_apps/utils/styles.dart';
import 'package:restaurants_apps/widget/empty_result_widget.dart';
import 'package:restaurants_apps/widget/search_error_widget.dart';
import 'package:restaurants_apps/widget/search_intro_widget.dart';
import 'package:restaurants_apps/widget/search_loading_widget.dart';
import 'package:restaurants_apps/widget/search_result_widget.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  final Api api;

  SearchScreen({Key? key, Api? api})
      : this.api = api ?? Api(),
        super(key: key);

  @override
  SearchScreenState createState() {
    return SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen> {
  SearchBloc? bloc;
  TextEditingController? _searchQueryController;

  @override
  void initState() {
    super.initState();

    _searchQueryController = TextEditingController();
    bloc = SearchBloc(widget.api);
  }

  @override
  void dispose() {
    bloc?.dispose();
    _searchQueryController?.dispose();
    super.dispose();
  }

  void _clearSearchQuery() {
    _searchQueryController?.clear();
    bloc?.onTextChanged.add("");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SearchState>(
      stream: bloc?.state,
      initialData: SearchNoTerm(),
      builder: (BuildContext context, AsyncSnapshot<SearchState> snapshot) {
        final state = snapshot.data;
        print(snapshot.data);
        return Scaffold(
          // backgroundColor: MyColors.backgroundApp,
          appBar: AppBar(
            elevation: 1,
            backgroundColor: toolBarApp,
            leading: const BackButton(color: black),
            title: Container(
              // padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
              child: TextField(
                controller: _searchQueryController,
                autofocus: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search...',
                ),
                style: const TextStyle(
                  decoration: TextDecoration.none,
                ),
                onChanged: bloc?.onTextChanged.add,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: appPrimaryText,
                ),
                onPressed: () {
                  _clearSearchQuery();
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                Flex(direction: Axis.vertical, children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        // Fade in an intro screen if no term has been entered
                        SearchIntro(visible: state is SearchNoTerm),

                        // Fade in an Empty Result screen if the search contained
                        // no items
                        EmptyWidget(visible: state is SearchEmpty),

                        // Fade in a loading screen when results are being fetched
                        // from Github
                        LoadingWidget(visible: state is SearchLoading),

                        // Fade in an error if something went wrong when fetching
                        // the results
                        SearchErrorWidget(
                            visible: state is SearchError, onRefresh: null),

                        // Fade in the Result if available
                        SearchResultWidget(
                          items: state is SearchPopulated
                              ? state.result.restaurants
                              : []
                        ),
                      ],
                    ),
                  )
                ])
              ],
            ),
          ),
        );
      },
    );
  }
}
