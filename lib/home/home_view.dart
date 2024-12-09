import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginatedtable_example/home/home_controller.dart';
import 'package:paginatedtable_example/model/holiday_model.dart';
import 'package:paginatedtable_example/widgets/custom_paginated_table.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeController controller;

  @override
  void initState() {
    controller = Get.put(HomeController());
    controller.getHoliday(cPage: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Paginated Data Table"),
            GetBuilder<HomeController>(builder: (_) {
              if (!controller.isDataFetched) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return CustomPaginatedTable(
                // new parameter
                currentPage: controller.currentPage,
                // new parameter
                onPageChanged: (page) {
                  // initialize new variable 'currentPage' in controller with value 1
                  controller.currentPage = page;
                  controller.update();
                },
                columns: [
                  {
                    'headerTitle': 'Date',
                    'headerWidth':
                        (context.width <= 1370) ? 250 : context.width * 0.182,
                  },
                  {
                    'headerTitle': 'Description',
                    'headerWidth':
                        (context.width <= 1370) ? 600 : context.width * 0.438
                  },
                  // add action key with true value to get row content from getCellValueForAction function
                  // add center key with true value to center the header
                  // {
                  //   'headerTitle': 'Actions',
                  //   'headerWidth': (context.width <= 1370)
                  //       ? 150
                  //       : context.width * 0.147,
                  //     'action': true,
                  //     'center': true,
                  // }, 
                ],
                data: controller.holidays,
                totalDataCount: controller.allDataCount,
                getCellValue: (e, i) {
                  final holiday = e as HolidayModel;
                  switch (i) {
                    // case 0:
                    //   return (i+1).toString();
                    case 0:
                      return holiday.date;
                    case 1:
                      return holiday.description;
                    default:
                      return 'Unexpected column index';
                  }
                },
                rowsPerPage: controller.rowsPerPage,
                onNewPageFetched: (nextPage) async {
                  // new: update currentPage
                  controller.currentPage = nextPage;
                  await controller.getHoliday(cPage: nextPage);
                },
                // optional parameters (for change rows per page) (API must have option to change rows per page)
                onRowsPerPageChanged: (value) {
                  if (value == null) return;
                  controller.rowsPerPage = value;
                  controller.currentPage = 1;
                  controller.holidays.clear();
                  controller.getHoliday(cPage: 1);
                },
                // optional parameters (for sorting)
                // sortAscending: controller.sortAscending,
                // sortColumnIndex: controller.sortColumnIndex,
                // onSort: (columnIndex, ascending) {
                //   controller.sortColumnIndex = columnIndex;
                //   controller.sortAscending = ascending;
                //   controller.holidays.clear();
                //   controller.currentPage = 1;
                //   controller.getHoliday(cPage: 1);
                // },
              );
            }),
          ],
        ),
      ),
    );
  }
}
