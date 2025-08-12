import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/course_model.dart';

class CourseSelectionPage extends StatefulWidget {
  @override
  _CourseSelectionPageState createState() => _CourseSelectionPageState();
}

class _CourseSelectionPageState extends State<CourseSelectionPage> {
  List<Course> _allCourses = []; // Stores all courses fetched from API
  List<Course> _filteredCourses =
      []; // Stores courses to be displayed (Search Feature)
  bool _isLoading = true;
  String? _error;
  final Set<String> _selectedCourseCodes = {};
  bool _isSubmitting = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCourses();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        _filteredCourses = List.from(_allCourses);
      } else {
        _filteredCourses = _allCourses.where((course) {
          final courseNameLower = course.name.toLowerCase();
          final courseCodeLower = course.code.toLowerCase();
          return courseNameLower.contains(query) ||
              courseCodeLower.contains(query);
        }).toList();
      }
    });
  }

  Future<void> _fetchCourses() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final response = await http
          .get(Uri.parse('https://timetable-ky2z.onrender.com/api/courses'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
        final List<dynamic> coursesData =
            decodedResponse['courses'] as List<dynamic>;
	
        final SharedPreferences prefs = await SharedPreferences.getInstance();
	List<String>? storedCourses = prefs.getStringList('courses');
	if (storedCourses != null) {
		for (int i = 0; i < storedCourses!.length; i++) {
			_selectedCourseCodes.add(storedCourses![i]);
		}
	}
	print(storedCourses);
	print(_selectedCourseCodes);


        setState(() {
          _allCourses =
              coursesData.map((json) => Course.fromJson(json)).toList();
          _filteredCourses =
              List.from(_allCourses); //search list for all courses initially
          _isLoading = false;
        });
      } else {
        _error = 'Failed to load courses (Status code: ${response.statusCode})';
        throw Exception(_error);
      }
    } catch (e) {
      setState(() {
        _error = _error ?? e.toString();
        _isLoading = false;
      });
      print("Error fetching courses, Contact Metis Team: $e");
    }
  }

  Future<void> _submitSelection() async {
    if (_selectedCourseCodes.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select at least one course.')),
        );
      }
      return;
    }

    setState(() {
      _isSubmitting = true;
      _error = null;
    });

    try {
      final response = await http.post(
        Uri.parse('https://timetable-ky2z.onrender.com/api/timetable'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'courses': _selectedCourseCodes.toList()}),
      );

      setState(() {
        _isSubmitting = false;
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final String responseBody = response.body;
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('timetable', responseBody);
	await prefs.setStringList('courses', _selectedCourseCodes.toList());

        if (!mounted) return;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext alertContext) {
            return AlertDialog(
              title: const Text('Success'),
              content:
                  const Text('Timetable generated and saved successfully!'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(alertContext).pop();
                    Navigator.of(context)
                        .pop(true); // Pop CourseSelectionPage, pass true
                  },
                ),
              ],
            );
          },
        );
      } else {
        String errorMessage =
            'Failed to generate timetable. Status: ${response.statusCode}';
        try {
          final errorData = jsonDecode(response.body);
          errorMessage =
              'Failed to generate timetable: ${errorData['message'] ?? response.body}';
        } catch (_) {
          errorMessage =
              'Failed to generate timetable. Server returned: ${response.body.isNotEmpty ? response.body : "Unknown server error"}';
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      setState(() {
        _isSubmitting = false;
        _error = e.toString();
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
      print("Error submitting selection: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Courses'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by course name or code',
                hintText: 'Enter course name or code...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          // _onSearchChanged will be called by the listener
                        },
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Loading courses, please wait...',
                            style: TextStyle(fontSize: 16)),
                        SizedBox(height: 16),
                      ]))
                : _error != null
                    ? Center(
                        child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Error: $_error\nPlease try again later.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.red.shade700, fontSize: 16)),
                      ))
                    : _allCourses
                            .isEmpty // Check if there were any courses fetched at all
                        ? const Center(
                            child: Text('No courses available from the server.',
                                style: TextStyle(fontSize: 16)))
                        : _filteredCourses.isEmpty
                            ? Center(
                                child: Text(
                                    'No courses match your search criteria "${_searchController.text}".',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16)))
                            : SingleChildScrollView(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: DataTable(
                                    columnSpacing: 20.0,
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Theme.of(context)
                                                .colorScheme
                                                .secondaryContainer),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondaryContainer),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    columns: const [
                                      DataColumn(
                                          label: Text('Name',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      DataColumn(
                                          label: Text('Code',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      DataColumn(
                                          label: Text('Credits',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      DataColumn(
                                          label: Text('Select',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ],
                                    rows: _filteredCourses.map((course) {
                                      return DataRow(
                                        selected: _selectedCourseCodes
                                            .contains(course.code),
                                        onSelectChanged: (bool? selected) {
                                          setState(() {
                                            if (selected == true) {
                                              _selectedCourseCodes
                                                  .add(course.code);
                                            } else {
                                              _selectedCourseCodes
                                                  .remove(course.code);
                                            }
                                          });
                                        },
                                        cells: [
                                          DataCell(SizedBox(
                                              width: 200,
                                              child: Text(course.name,
                                                  overflow: TextOverflow
                                                      .ellipsis))), // Constrain width and handle overflow
                                          DataCell(Text(course.code)),
                                          DataCell(Text(course.credits
                                              .toStringAsFixed(1))),
                                          DataCell(
                                            Checkbox(
                                              value: _selectedCourseCodes
                                                  .contains(course.code),
                                              activeColor: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              onChanged: (bool? selected) {
                                                setState(() {
                                                  if (selected == true) {
                                                    _selectedCourseCodes
                                                        .add(course.code);
                                                  } else {
                                                    _selectedCourseCodes
                                                        .remove(course.code);
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
          ),
          if (!_isLoading && _error == null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _isSubmitting
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _selectedCourseCodes.isEmpty
                          ? null
                          : _submitSelection,
                      child: const Text('Submit Selected Courses'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        minimumSize: const Size(double.infinity, 50),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
            ),
        ],
      ),
    );
  }
}
