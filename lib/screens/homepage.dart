import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String quote = "";
  Future fetchQuotes() async {
    var headers = {
      'X-RapidAPI-Host': 'love-quote.p.rapidapi.com',
      'X-RapidAPI-Key': 'a9874154b3msh8455de0e4fe5827p14bb74jsndf194f26497c'
    };
    var request = http.Request(
        'GET', Uri.parse('https://love-quote.p.rapidapi.com/lovequote'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String responseString = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseString);
    if (response.statusCode == 200) {
      setState(() {
        quote = decodedResponse["quote"];
      });
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchQuotes();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fetchQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(
          FontAwesomeIcons.whatsapp,
          color: Colors.white,
        ),
        onPressed: () async {
          var url =
              'https://wa.me/+255758585847?text=Babe I just loved this quote "$quote"';
          void _launchURL() async {
            if (!await launch(url)) throw 'Could not launch $url';
          }

          _launchURL();
          // var url = '"https://wa.me/255758585847?text=$quote"';
          // void _launchURL() async {
          //   if (!await launch(url)) throw 'Could not launch $url';
          // }

          // _launchURL();
        },
      ),
      body: quote == null
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 35, top: 35, right: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Love Bug",
                            style: GoogleFonts.acme(
                                fontWeight: FontWeight.w300,
                                color: Colors.grey,
                                fontSize: 30),
                          ),
                          Icon(
                            FontAwesomeIcons.bugs,
                            color: Colors.red,
                          )
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3),
                      Center(
                        child: SizedBox(
                          width: 250.0,
                          child: DefaultTextStyle(
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 20),
                            child: AnimatedTextKit(
                              pause: Duration(milliseconds: 4000),
                              repeatForever: true,
                              animatedTexts: [
                                TypewriterAnimatedText(quote),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Center(
                        child: ElevatedButton.icon(
                          icon: Icon(
                            FontAwesomeIcons.arrowsRotate,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            fetchQuotes();
                          },
                          label: Text(
                            "Reload",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
