import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restofulist/common/styles.dart';
import 'package:restofulist/data/api/api_service.dart';
import 'package:restofulist/data/model/api/restaurant_add_review.dart';
import 'package:restofulist/data/model/restaurant.dart';
import 'package:restofulist/provider/restaurant_provider.dart';
import 'package:restofulist/ui/components/platform_widget.dart';

class RestaurantAddReviewPageIntent {
  const RestaurantAddReviewPageIntent(this.restaurant, this.onReviewAdded);

  final Restaurant restaurant;
  final Function onReviewAdded;
}

class RestaurantAddReviewPage extends StatefulWidget {
  static const routeName = '/add_review';

  const RestaurantAddReviewPage({Key? key}) : super(key: key);

  @override
  State<RestaurantAddReviewPage> createState() =>
      _RestaurantAddReviewPageState();
}

class _RestaurantAddReviewPageState extends State<RestaurantAddReviewPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();

  late Function onReviewAdded;
  late RestaurantAddReviewProvider _provider;

  @override
  void initState() {
    super.initState();

    _provider = context.read<RestaurantAddReviewProvider>();
    _provider.addListener(() {
      final state = _provider.state;
      if (state == ApiResultState.hasData) {
        onReviewAdded();
        Navigator.of(context).pop();
      } else if (state == ApiResultState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send review'),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  Widget _buildAppBar(BuildContext context, Restaurant restaurant) {
    return Text('Add Review: ${restaurant.name}');
  }

  Widget _buildContent(BuildContext context, Restaurant restaurant) {
    return Consumer<RestaurantAddReviewProvider>(
        builder: (context, provider, child) {
      if (provider.state == ApiResultState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _reviewController,
                decoration: const InputDecoration(
                  labelText: 'Review',
                ),
                maxLines: 5,
                minLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your review';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Send review to server
                    provider.send(RestaurantAddReviewRequest(
                        id: restaurant.id,
                        name: _nameController.text,
                        review: _reviewController.text));
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        );
      }
    });
  }

  Widget _buildAndroid(BuildContext context) {
    final intent = ModalRoute.of(context)!.settings.arguments
        as RestaurantAddReviewPageIntent;
    final restaurant = intent.restaurant;
    onReviewAdded = intent.onReviewAdded;
    return Scaffold(
      appBar: AppBar(title: _buildAppBar(context, restaurant)),
      body: _buildContent(context, restaurant),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildAndroid,
    );
  }
}
