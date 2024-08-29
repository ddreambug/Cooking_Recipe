import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_demo/models/meal.dart';
import 'package:image_picker/image_picker.dart';

class NewMeal extends ConsumerStatefulWidget {
  const NewMeal({super.key});

  @override
  ConsumerState<NewMeal> createState() {
    return _NewMealState();
  }
}

class _NewMealState extends ConsumerState<NewMeal> {
  final _formKey = GlobalKey<FormState>();
  late String _enteredTitle;
  late int _enteredDuration;
  late List<String> _enteredIngridients;
  late List<String> _enteredSteps;
  late Affordability _enteredAffordability;
  late Complexity _enteredComplexity;
  final Map<String, bool> _enteredCategory = {
    'isGlutenFree': false,
    'isLactoseFree': false,
    'isVegan': false,
    'isVegetarian': false
  };
  late String _enteredPhotos;
  File? _selectedImage;

  void _onsave() {}

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (pickedImage == null) {
      return;
    }
    _selectedImage = File(pickedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    Widget imageContent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: _takePicture,
            child: const Text('Add a Photo (Optional)'))
      ],
    );
    //conditionally render the widget
    if (_selectedImage != null) {
      imageContent = Image.file(
        _selectedImage!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      final screenWidth = constraints.maxWidth; //640
      final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

      return SizedBox(
        height: double.infinity,
        width: (screenWidth * (8.3 / 10)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lunch_dining_outlined),
                      Text(
                        ' NEW DISH ',
                        style: TextStyle(fontSize: 25),
                      ),
                      Icon(Icons.lunch_dining_outlined),
                    ],
                  ),
                  const Divider(),
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Title')),
                    validator: (value) {
                      if (value == null) {
                        return 'Menu Name must be filled!';
                      }
                      return null;
                    },
                    onSaved: ((newValue) {
                      _enteredTitle = newValue!;
                    }),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        label: Text('Duration (estimate min)')),
                    validator: (value) {
                      if (value == null) {
                        return 'Estimate Duration must be filled!';
                      }
                      return null;
                    },
                    onSaved: ((newValue) {
                      _enteredDuration = int.parse(newValue!);
                    }),
                  ),
                  TextFormField(
                    minLines: 1,
                    maxLines: null,
                    decoration:
                        const InputDecoration(label: Text('Ingridients')),
                    validator: (value) {
                      if (value == null) {
                        return 'Ingridients must be filled!';
                      }
                      return null;
                    },
                    onSaved: ((newValue) => _enteredTitle = newValue!),
                  ),
                  TextFormField(
                    minLines: 1,
                    maxLines: null,
                    decoration: const InputDecoration(label: Text('Steps')),
                    validator: (value) {
                      if (value == null) {
                        return 'Steps must be filled!';
                      }
                      return null;
                    },
                    onSaved: ((newValue) => _enteredTitle = newValue!),
                  ),
                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                          alignment: Alignment.center,
                          isExpanded: true,
                          hint: const Text('Affordability'),
                          items: [
                            for (final affordability in Affordability.values)
                              DropdownMenuItem(
                                alignment: Alignment.center,
                                value: affordability,
                                child: Text(affordability.name),
                              )
                          ],
                          onChanged: (value) {
                            _enteredAffordability = value!;
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Select Affordability';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: DropdownButtonFormField(
                          alignment: Alignment.center,
                          isExpanded: true,
                          hint: const Text(
                            'Complexity',
                            textAlign: TextAlign.center,
                          ),
                          items: [
                            for (final complexity in Complexity.values)
                              DropdownMenuItem(
                                alignment: Alignment.center,
                                value: complexity,
                                child: Text(complexity.name),
                              )
                          ],
                          onChanged: (value) {
                            _enteredComplexity = value!;
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Select Complexity';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  //filter category
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text('Gluten-Free'),
                            const Spacer(),
                            Switch(
                                value: _enteredCategory['isGlutenFree']!,
                                onChanged: (bool value) {
                                  setState(() {
                                    _enteredCategory['isGlutenFree'] = value;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text('Lactose-Free'),
                            const Spacer(),
                            Switch(
                                value: _enteredCategory['isLactoseFree']!,
                                onChanged: (bool value) {
                                  setState(() {
                                    _enteredCategory['isLactoseFree'] = value;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text('Vegan'),
                            const Spacer(),
                            Switch(
                                value: _enteredCategory['isVegan']!,
                                onChanged: (bool value) {
                                  setState(() {
                                    _enteredCategory['isVegan'] = value;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text('Vegetarian'),
                            const Spacer(),
                            Switch(
                                value: _enteredCategory['isVegetarian']!,
                                onChanged: (bool value) {
                                  setState(() {
                                    _enteredCategory['isVegetarian'] = value;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                      ),
                    ),
                    height: 100,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: imageContent,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          _onsave();
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
