import 'package:flutter/material.dart';
//  final vs const
//  const vatiable --->Value must be known at compile-time, const birthday  = "2008/12/25" Can't be changed after initialized.
// final varaible  ---> Value must be known at run-time, final birthday = getBirthDateFromDB() ,Can't be changed after initialized.

class ReusableCard extends StatelessWidget {
  // you can delete reusablecard thait contains key , a type of constructer
  // for changing colors , etc , we have to define a constructor
  ReusableCard(
      {@required this.changeColor,
      this.cardChild,
      this.onPress}); // {} for name ,, @required states argument is must
  final Color
      changeColor; // it is stateless widget so it sould be final because it's value will bw assigned at run time , when we change color old reusableCard will get destroyed and in place of that a new reusable card will be created
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress, // passing onPress function to onTap
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: changeColor,
        ),
      ),
    );
  }
}
