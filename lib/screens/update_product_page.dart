import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/product.dart';

import '../providers/products_data.dart';

class UpdateProduct extends StatefulWidget {
  static const route = "UpdateProduct";

  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final priceFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  // ignore: prefer_typing_uninitialized_variables
  late var imageController;
  final imageFocusNode = FocusNode();
  final formData = GlobalKey<FormState>();
  var isLoading = false;
  var error = false;
  late Product existingItem;
  late Product newItem;

  void updateImage() {
    if (imageController.text.isEmpty) {
      return;
    } else {
      setState(() {});
    }
  }

  productImageUrlCheck(String value) {
    if (value.isNotEmpty) {
      if (value.contains(RegExp(r"[\.com]")) == false) {
        return "An invalid URL has been entered";
      }
      if (value.contains(RegExp(r"[\.com]$"))) {
        return "An invalid URL has been entered";
      }
    }
  }

  productTitleCheck(String value) {
    if (value.isNotEmpty) {
      if (value.contains(RegExp(r"[0-9]"))) {
        return "Numbers are not allowed here";
      }
    }
  }

  productPriceCheck(value) {
    if (value.contains(RegExp(r"[a-z, A-Z]"))) {
      return "Only numbers can be entered here";
    }
  }

  productDescriptionCheck(value) {}
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

  @override
  void didChangeDependencies() {
    if (isLoading == false) {
      setState(() {
        existingItem = ModalRoute.of(context)!.settings.arguments as Product;
        newItem = existingItem;
        imageController = TextEditingController(text: existingItem.imageUrl);
      });
    }
    super.didChangeDependencies();
  }

  saveProduct() async {
    if (formData.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      formData.currentState!.save();
      try {
        await Provider.of<ProductData>(context, listen: false)
            .editProduct(existingItem, newItem);
      } catch (error) {
        Navigator.of(context).pop();
      } finally {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Successfully edited ${existingItem.title}"),
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
              "Error: Save Failed, please enter valid details into the fields above "),
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
    // setState(() {
    //   existingItem = ModalRoute.of(context)!.settings.arguments as Product;
    //   newItem = existingItem;
    // });
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit " + newItem.title),
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
                          textInputAction: TextInputAction.next,
                          initialValue: existingItem.title,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => productTitleCheck(value!),
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(priceFocusNode),
                          onSaved: (value) {
                            if (value!.isNotEmpty) {
                              newItem = Product(
                                description: newItem.description,
                                id: newItem.id,
                                imageUrl: newItem.imageUrl,
                                price: newItem.price,
                                title: value,
                              );
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          decoration: const InputDecoration(labelText: 'Price'),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          initialValue: existingItem.price.toString(),
                          keyboardType: TextInputType.number,
                          focusNode: priceFocusNode,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp("[0-9.]"),
                            ),
                          ],
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(descriptionFocusNode),
                          onSaved: (value) {
                            if (value!.isNotEmpty) {
                              newItem = Product(
                                description: newItem.description,
                                id: newItem.id,
                                imageUrl: newItem.imageUrl,
                                price: double.parse(value),
                                title: newItem.title,
                              );
                            }
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
                          maxLength: 200,
                          maxLines: 2,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.multiline,
                          focusNode: descriptionFocusNode,
                          initialValue: existingItem.description,
                          validator: (value) => productDescriptionCheck(value),
                          onSaved: (value) {
                            if (value!.isNotEmpty) {
                              newItem = Product(
                                description: value,
                                id: newItem.id,
                                imageUrl: newItem.imageUrl,
                                price: newItem.price,
                                title: newItem.title,
                              );
                            }
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
                                validator: (value) =>
                                    productImageUrlCheck(value!),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                controller: imageController,
                                focusNode: imageFocusNode,
                                onSaved: (value) {
                                  if (value!.isNotEmpty) {
                                    newItem = Product(
                                      description: newItem.description,
                                      id: newItem.id,
                                      imageUrl: value,
                                      price: newItem.price,
                                      title: newItem.title,
                                    );
                                  }
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
                        onPressed: () => saveProduct(),
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
