import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/providers/products_data.dart';

class AddNewProductPage extends StatefulWidget {
  static const route = "AddProductPage";

  @override
  _AddNewProductPageState createState() => _AddNewProductPageState();
}

class _AddNewProductPageState extends State<AddNewProductPage> {
  final priceFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final imageController = TextEditingController();
  final imageFocusNode = FocusNode();
  final formData = GlobalKey<FormState>();
  var isLoading = false;
  var error = false;
  Product newItem =
      Product(description: "", id: null, imageUrl: "", price: 0, title: "");

  void updateImage() {
    if (imageFocusNode.hasFocus) {
      return;
    }
    if (imageController.text.isEmpty) {
      return;
    } else {
      setState(() {});
    }
  }

  productImageUrlCheck(String value) {
    if (value.contains(RegExp(r"[\.com]")) == false) {
      return "An invalid URL has been entered";
    }
    if (value.contains(RegExp(r"[\.com]$"))) {
      return "An invalid URL has been entered";
    }
  }

  @override
  void initState() {
    imageFocusNode.addListener(() {
      updateImage();
    });
    super.initState();
  }

  @override
  void dispose() {
    imageFocusNode.removeListener(() {
      updateImage();
    });
    priceFocusNode.dispose();
    descriptionFocusNode.dispose();
    imageFocusNode.dispose();
    super.dispose();
  }

  saveProduct() async{
    if (formData.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      formData.currentState!.save();
      try {
        await Provider.of<ProductData>(context, listen: false).addProduct(newItem);
      } catch (error) {
        print(error);
        Navigator.of(context).pop();
      } finally {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Successfully added new product"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ));
        Navigator.of(context).pop();
      }
    } else {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              "Error: Save Failed, please ensure no field is left empty"),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          elevation: 2,
          dismissDirection: DismissDirection.horizontal,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.all(10),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Product"),
        actions: [
          IconButton(
            onPressed: () => saveProduct(),
            icon: const Icon(Icons.check_rounded),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  Text("Saving"),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formData,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            hintText: "Product Title",
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[A-Za-z ]")),
                          ],
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please provide a title";
                            }
                            if (!value.startsWith(RegExp(r"[A-Z]"))) {
                              return "First character should be in UpperCase";
                            }
                            if (value.contains(RegExp(r"[A-Z]+[a-z]+[A-Z]"))) {
                              return "Only the first character should be in UpperCase";
                            }
                            if (value.contains(RegExp(r"[A-Z][A-Z]"))) {
                              return "Only the first character should be in UpperCase";
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(priceFocusNode),
                          onSaved: (value) {
                            newItem = Product(
                                description: newItem.description,
                                id: newItem.id,
                                imageUrl: newItem.imageUrl,
                                price: newItem.price,
                                title: value!);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          decoration: const InputDecoration(labelText: 'Price'),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: priceFocusNode,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[0-9.]")),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a price";
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(descriptionFocusNode),
                          onSaved: (value) {
                            newItem = Product(
                                description: newItem.description,
                                id: newItem.id,
                                imageUrl: newItem.imageUrl,
                                price: double.parse(value!),
                                title: newItem.title);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            hintText: "Enter Product Details",
                            helperText: "Your Can Enter Multiple Lines",
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[a-z, A-Z '.]")),
                          ],
                          maxLength: 120,
                          maxLines: 2,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.multiline,
                          focusNode: descriptionFocusNode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please provide product details";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            newItem = Product(
                                description: value!,
                                id: newItem.id,
                                imageUrl: newItem.imageUrl,
                                price: newItem.price,
                                title: newItem.title);
                          },
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.only(top: 8, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            child: imageController.text.isNotEmpty
                                ? Image.network(
                                    imageController.text,
                                    fit: BoxFit.cover,
                                  )
                                : const Text("Image Preview"),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Image Url'),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter a valid URL";
                                  }
                                  if (!value.contains(RegExp(r"[\.com]"))) {
                                    return "Invalid url format";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                controller: imageController,
                                onFieldSubmitted: (_) {
                                  setState(() {
                                    saveProduct();
                                  });
                                },
                                focusNode: imageFocusNode,
                                onSaved: (value) {
                                  newItem = Product(
                                      description: newItem.description,
                                      id: newItem.id,
                                      imageUrl: value!,
                                      price: newItem.price,
                                      title: newItem.title);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                        onPressed: () {
                          saveProduct();
                        },
                        icon: const Icon(
                          Icons.save_rounded,
                          size: 40,
                        ),
                        label: const Text(
                          " Save",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
