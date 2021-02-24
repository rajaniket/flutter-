import 'package:bmi_calc/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // // The Font Awesome Icon pack available as set of Flutter Icons.
import 'constants.dart';
import 'icon_content.dart';

// enum can't defined inside the class
enum Gender { male, female }

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color maleCardColour = kInactiveCardColor;
  Color femaleCardColor = kInactiveCardColor;
  int height = 180;
  Gender selectedGender;

  // 1 = male,  2 = female instead of this we are using enum

  // void updateColour(Gender gender) {
  //   if (gender == Gender.male) {
  //     if (maleCardColour == inactiveCardColor) {
  //       maleCardColour = activeCardColor;
  //       femaleCardColor = inactiveCardColor;
  //     } else {
  //       maleCardColour = inactiveCardColor;
  //     }
  //   }
  //   //  there may be more gender or widget so using if instead of else
  //   if (gender == Gender.female) {
  //     if (femaleCardColor == inactiveCardColor) {
  //       femaleCardColor = activeCardColor;
  //       maleCardColour = inactiveCardColor;
  //     } else {
  //       femaleCardColor = inactiveCardColor;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red[700], // it will overlap theme scaffold background color in main
      appBar: AppBar(
        title: Center(child: Text('BMI Calculator')),
      ),
      body: Column(
        // first creating three exapanded widget in column and the in 1st expanded widget there will be two expanded row and so on.
        crossAxisAlignment: CrossAxisAlignment
            .stretch, // it will streach out the widget (means will take all free space)
        children: [
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: ReusableCard(
                // wraping ReusableCard with GestureDetector for changing the colour of widget on tap
                onPress: () {
                  // passing a function
                  setState(() {
                    selectedGender = Gender.male;
                  });
                },
                changeColor: selectedGender == Gender.male
                    ? kActiveCardColor
                    : kInactiveCardColor,
                cardChild: IconContent(
                  icon: FontAwesomeIcons.mars,
                  label: 'Male',
                ),
              )),
              Expanded(
                  child: ReusableCard(
                onPress: () {
                  setState(() {
                    selectedGender = Gender.female;
                  });
                },
                changeColor: selectedGender == Gender.female
                    ? kActiveCardColor
                    : kInactiveCardColor,
                cardChild: IconContent(
                  icon: FontAwesomeIcons.venus,
                  label: 'Female',
                ),
              ))
            ],
          )),
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: ReusableCard(
                changeColor: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Height'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // you have to put both crossaxisalignment.baseline and testbaseline together to put cm at baseline only CrossAxisAlignment.baseline will give error
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          height.toString(),
                          style: kNumberTextStyle,
                        ),
                        Text(
                          'cm',
                          style: kLabelTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Color(0xFF8D8E98),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 30.0),
                        thumbColor: Color(0xFFEB1555),
                        activeTrackColor: Colors.white,
                        overlayColor: Color(0x29EB1555),
                      ), // it will copy all default data of slider and we can change just some value that we wish to change

                      child: Slider(
                        //  we want to reduce pointer size that property is not available in slider so wraping slider with slidertheme for changing it's inbuilt structure
                        value: height.toDouble(),
                        min: 120.0,
                        max: 220.0,
                        onChanged: (double newSliderValue) {
                          // newslidervalue is value given by user by sliding
                          print(newSliderValue);
                          setState(() {
                            height = newSliderValue
                                .round(); // converting newslidervalue to integer
                          });
                        },
                        // inactiveColor: Color(0xFF8D8E98),
                      ),
                    ) // value is of double type so we have to convert it into double
                  ],
                ),
              )),
            ],
          )),
          Expanded(
              child: Row(
            children: [
              Expanded(child: ReusableCard(changeColor: kActiveCardColor)),
              Expanded(child: ReusableCard(changeColor: kActiveCardColor)),
            ],
          )),
          Container(
            //color: bottomContainerColour,
            margin: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            height: kBottomContainerHeight,
            decoration: BoxDecoration(
                color: kBottomContainerColour,
                borderRadius: BorderRadiusDirectional.vertical(
                    top: Radius.circular(20.0), bottom: Radius.circular(0.0))),
          ),
        ],
      ),

      // for changing floatingActionButton color , as it as already prdefined color in dark theme
      // wrap up with Theme widget and provide themedata
      // floatingActionButton: Theme(
      //   data: ThemeData(accentColor: Colors.pink),
      //   child: FloatingActionButton(
      //     onPressed: () {},
      //     child: Icon(Icons.add),
      //   ),
      // ),
    );
  }
}
