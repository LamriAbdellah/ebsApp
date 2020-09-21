import 'package:epsapp/Constances/constants.dart';
import 'package:epsapp/guide/settings.dart';
import 'package:epsapp/guide/step_model.dart';
import 'package:epsapp/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:epsapp/shared_prefrences/sharing_userInfos.dart';

class IntroPage extends StatefulWidget {
  final int Case;

  const IntroPage({Key key, this.Case}) : super(key: key);
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  List<StepModel> list = StepModel.list;
  var _controller = PageController();
  var initialPage = 0;
  int Range=0;

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      setState(() {
        initialPage = _controller.page.round();
      });
    });

    return Scaffold(
      backgroundColor:Color(0xffFEFCEF),
      body: Column(

        children: <Widget>[
          _appBar(),
          _body(_controller),
          _indicator(),
        ],
      ),
    );
  }

  _appBar() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (initialPage > 0)
                _controller.animateToPage(initialPage - 1,
                    duration: Duration(microseconds: 500),
                    curve: Curves.easeIn);
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(50),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
          FlatButton(
            onPressed: () {
              if(Constants.UserState=="") {
                _controller.animateToPage(list.length,
                    duration: Duration(microseconds: 500),
                    curve: Curves.easeInOut);
                sharingUserInfo.saveuserStateSharedprefences("");
                Constants.UserState = "";
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) {
                  return Wrapper();
                }));
              }
              if(Constants.UserState=="new") {
                _controller.animateToPage(list.length,
                    duration: Duration(microseconds: 500),
                    curve: Curves.easeInOut);
                sharingUserInfo.saveuserStateSharedprefences("");
                Constants.UserState = "";
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) {
                  return settings();
                }));
              }
            },
            child: Text(
              "Skip",

              style: TextStyle(
                fontFamily: "Lora",
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _body(PageController controller) {
    return Expanded(
      child: PageView.builder(
        controller: controller,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              index == 1
                  ? _displayText(list[index].text)
                  : _displayImage(list[index].id),
              SizedBox(
                height: 25,
              ),
              index == 1
                  ? _displayImage(list[index].id)
                  : _displayText(list[index].text),
            ],
          );
        },
      ),
    );
  }

  _indicator() {
    return Container(
      width: 90,
      height: 90,
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 90,
              height: 90,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
                value: (initialPage + 1) / (list.length + 1),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                if (initialPage < list.length) {
                  _controller.animateToPage(initialPage + 1,
                      duration: Duration(microseconds: 500),
                      curve: Curves.easeIn);
                    print(Range);
                    Range=Range+1;

                }
               if  ((Range >= list.length)&& widget.Case==0){

                  Constants.UserState="";
                  sharingUserInfo.saveuserStateSharedprefences("");
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return settings();
                  }));
                }

                if  ((Range >= list.length)&& widget.Case==1){


                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return Wrapper();
                  }));
                }

              },
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _displayText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left:10,right: 10),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: "Lora",
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _displayImage(int path) {
    return Padding(
      padding: const EdgeInsets.only(left:15,right: 10),
      child: Image.asset(
        "assets/$path.png",
        height: MediaQuery.of(context).size.height * .5,
      ),
    );
  }
}
