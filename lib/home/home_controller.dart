import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:paginatedtable_example/model/holiday_model.dart';

class HomeController extends GetxController {
  int currentPage = 1;
  List<HolidayModel> holidays = [];
  bool isDataFetched = false;
  int allDataCount = 0;
  int rowsPerPage = 10;

  bool sortAscending = true;
  int sortColumnIndex = 0;

  getHoliday({required int cPage}) async {
    isDataFetched = false;
    update();
    String url =
        "https://demo.softcodix.com/attendance/api/holiday/?page=$cPage";
    // String url = "https://jsonplaceholder.typicode.com/posts?_start=${(cPage - 1) * rowsPerPage}&_limit=$rowsPerPage"; // (Testing with different rowsPerPage)
    // String url = "https://jsonplaceholder.typicode.com/posts/"; // (Testing without pagination: no need to change in code)
    print(url);
    Uri uri = Uri.parse(url);
    var response = await http.get(uri, headers: {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzMzNzQwMDA4LCJpYXQiOjE3MzM2NTM2MDgsImp0aSI6IjdkODgwY2E1MThiODQ2YmE4MjM1NjM4NjNlYTFiNzI3IiwidXNlcl9pZCI6MX0.W7VjHM3iK6MXomJB9PFuukg1vp5zCGccHy0pxnrZZl8"
    });
    var body = jsonDecode(response.body);
    // allDataCount = 100; // JsonPlaceHolder has 100 data
    allDataCount = body["count"];
    List<HolidayModel> holidayResults = [];
    // for JsonPlaceHolder
    // for (var holiday in body) {
    //  holidayResults.add(HolidayModel.jsonplaceholderApi(holiday));
    // }
    for (var holiday in body["results"]) {
      holidayResults.add(HolidayModel.fromJson(holiday));
    }
    holidays.addAll(holidayResults);
    // sortData(); // skip this line if API has sorting parameters.
    // manual sorting is not effective as compare to API sorting
    isDataFetched = true;
    update();
  }

  sortData() {
    if (sortColumnIndex == 0) {
      // for int.parse is required to solve error in sorting (1, 10, 2, 20, ..,) (string wise sorting instead of number wis)
      // holidays.sort((a, b) => sortAscending
      //     ? int.parse(a.date).compareTo(int.parse(b.date))
      //     : int.parse(b.date).compareTo(int.parse(a.date)));
      holidays.sort((a, b) =>
          sortAscending ? a.date.compareTo(b.date) : b.date.compareTo(a.date));
    } else if (sortColumnIndex == 1) {
      holidays.sort((a, b) => sortAscending
          ? a.description.compareTo(b.description)
          : b.description.compareTo(a.description));
    }
  }
}
