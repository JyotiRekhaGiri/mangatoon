import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  final Function(double) onRatingSelected;

  RatingWidget({required this.onRatingSelected});

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  double _currentRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            _currentRating >= index + 1 ? Icons.star : Icons.star_border,
            color: Colors.yellow,
          ),
          onPressed: () {
            setState(() {
              _currentRating = index + 1.0;
              widget.onRatingSelected(_currentRating);
            });
          },
        );
      }),
    );
  }
}
