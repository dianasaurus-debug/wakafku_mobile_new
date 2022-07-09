import 'package:final_project_mobile/models/slider.dart';
import 'package:final_project_mobile/screens/home/beranda.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  List<SliderModel> slides = [];
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
    slides = getSlides();
  }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : CustomColor.whitebg,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                scrollDirection: Axis.horizontal,
                onPageChanged: (value){
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemCount: slides.length,
                itemBuilder: (context, index){

                  // contents of slider
                  return Slider(
                    image: slides[index].getImage(),
                    title : slides[index].getTitle(),
                    description : slides[index].getDescription(),

                  );
                }
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(slides.length, (index) => buildDot(index, context),
              ),
            ),
          ),
          ElevatedButton(
            child: Text(currentIndex == slides.length - 1 ? "Continue": "Next"),
            onPressed: (){
              if(currentIndex == slides.length - 1){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
              }
              _controller.nextPage(duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
            },
          ),
        ],
      ),
    );
  }

  // container created for dots
  Container buildDot(int index, BuildContext context){
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.green,
      ),
    );
  }
}

// ignore: must_be_immutable
// slider declared
class Slider extends StatelessWidget {
  String image;
  String title;
  String description;

  Slider({Key? key, required this.image, required this.title, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 30, 30, 30),
      child : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // image given in slider
          Image(image: AssetImage(image), width: size.width*0.7),
          SizedBox(height: 25),
          Align(
            alignment: Alignment.center,
            child : Text('${title}', style: CustomFont.introTitle),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child : Text('${description}', style: CustomFont.orangeMedLight),
          )
        ],
      )
    );
  }
}