import 'package:daily_quote/model/quote_model.dart';
import 'package:flutter/material.dart';

import '../services/service.dart';
import '../widgets/build_app_bar.dart';
import '../widgets/categories_list.dart';


bool isDark=false;
class HomeView extends StatefulWidget {
   HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
String? selectedItem='age';
String? numberofQuotes='10';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: buildAppBar(),
      body: FutureBuilder<List<QuoteModel>>(
        future: ApiService().getQuotes(category: selectedItem!, numberOfQuotes: '50'),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<QuoteModel>quotes=snapshot.data!;
            return ListView.separated(itemBuilder: (context, index) => QuoteBody(quoteModel: quotes[index],),itemCount: quotes.length, separatorBuilder: (BuildContext context, int index) =>const SizedBox(height: 15.0,),);
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(

      child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

          Text (' Category',style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            buildDropdownButton(context),
            Text ('Number of Quotes you need to see ?',style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            buildCustomTextField(context),


        ],),
      ),
    );
  }



  DropdownButton<String> buildDropdownButton(BuildContext context) {
    return DropdownButton<String>(
              value: selectedItem,
              items: categories.map((item) {
            return DropdownMenuItem(child: Text(item),value: item,);
          }).toList(), onChanged: (data){
                Navigator.pop(context);
            setState(() {
              selectedItem=data;
            });
          });
  }

  SizedBox buildCustomTextField(BuildContext context) {

    return SizedBox(
            width: MediaQuery.of(context).size.width/6,
            child: TextField(
              onSubmitted: (data){
                setState(() {
                  numberofQuotes=data ;

                });
                Navigator.pop(context);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: numberofQuotes,
                border:OutlineInputBorder(borderRadius: BorderRadius.circular(18))
              ),
            ),
          );
  }
}

class QuoteBody extends StatelessWidget {
   QuoteBody({
    super.key,required this.quoteModel
  });
QuoteModel quoteModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quoteModel.quote,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
               quoteModel.author,
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }


}
