import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main()
{
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Exploring",
        home: SIForm(),
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.indigo, accentColor: Colors.indigoAccent,
            fontFamily: 'maven-pro-v13'

        ),
      )
  );
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Exploring",
        home: SIForm()
    );
  }

}

class SIForm  extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SIFormState();
  }
}

class SIFormState  extends State<SIForm>{

  var _currencies =['Kwanzas', 'Dollars', 'Euro' , 'Libra'];
  var minPadding=5.0;
  var _currentItemSelected='';
  var displayResult='';


  TextEditingController principalController = TextEditingController();
  TextEditingController rioController =TextEditingController();
  TextEditingController termController =TextEditingController();

  var _formkey =GlobalKey<FormState>();
  List<Values>  historico = new List<Values>();
  bool  isClicked  =  false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentItemSelected =_currencies[0];
  }


  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;


    return Scaffold(
      appBar: AppBar(title: Text ('Simple Interest Calculator App'),),
      body:  Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.all(minPadding*2),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(minPadding),
                child: TextFormField(
                  controller: principalController,
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  onChanged: (String value){
                    setState(() {
                      if(!value.isEmpty)
                          isClicked = false;
                    });
                  },

                  validator: (String value){
                    if(value.isEmpty)
                      return 'Please enter principal amount';

                  },
                  decoration: InputDecoration(
                      labelStyle: textStyle,
                      labelText: 'Principal',
                       errorStyle: TextStyle
                        (
                          color: Colors.yellow,
                          fontSize: 15.0
                      ),
                      hintText: 'Enter Principal e.g 12000',
                      border: OutlineInputBorder
                        (
                        borderRadius: BorderRadius.circular(30),
                      )
                  ),

                ),
              ),

              Padding(
                padding: EdgeInsets.all(minPadding),
                child: TextFormField(
                  onChanged: (String value){
                    setState(() {
                      if(!value.isEmpty)
                           isClicked = false;
                    });
                  },
                  controller: rioController,
                  style: textStyle,
                  validator: (String value){
                    if(value.isEmpty)
                      return 'Please enter Rate of Interest amount';

                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(

                      errorStyle: TextStyle(
                          color: Colors.yellow,
                          fontSize: 15.0
                      ),
                      labelStyle: textStyle,
                      labelText: 'Rate of Interest',
                      hintText: 'Enter Principal e.g 12000',
                      border: OutlineInputBorder
                        (
                        borderRadius: BorderRadius.circular(30),

                      )
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: minPadding, bottom: minPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: minPadding),
                        child: TextFormField(
                          onChanged: (String value){
                            setState(() {
                              if(!value.isEmpty)
                                isClicked = false;
                            });
                          },
                          validator: (String value){
                            if(value.isEmpty)
                              return 'Please enter term amount';

                          },
                          controller: termController,
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  color: Colors.yellow,
                                  fontSize: 15.0
                              ),
                              labelStyle: textStyle,
                              labelText: 'Terms',
                              hintText: 'Time in years',
                              border: OutlineInputBorder
                                (
                                borderRadius: BorderRadius.circular(30),
                              )
                          ),
                        ),
                      ),
                    ),

                    Container(width: minPadding*5,)
                    ,
                    Expanded( child: DropdownButton<String>(
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: textStyle,),

                        );
                      }).toList(),
                      onChanged: (String newValueSelected)
                      {
                        _onDropDownItemSelected(newValueSelected);

                      },
                      value: _currentItemSelected,
                    ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.all(minPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child:ButtonTheme(
                        height: 40,
                         child: FlatButton(
                             color: Theme.of(context).accentColor,
                             textColor: Theme.of(context).primaryColorDark,
                             child: Text('Calculate', textScaleFactor: 1.5, ),
                             onPressed: (){
                               setState(() {
                                 if(_formkey.currentState.validate())
                                   this.displayResult= _calculateTotalReturns();
                               });
                             },
                             shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                         ),
                      ),
                    ),
                    SizedBox(width:5,),
                    Expanded(
                      child: ButtonTheme(
                         height: 40,
                          child: FlatButton(
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                              color: Theme.of(context).primaryColorDark,
                              textColor: Theme.of(context).primaryColorLight,
                              child: Text('Reset', textScaleFactor: 1.5),
                              onPressed: (){
                                setState(() {
                                  reset();
                                });
                              },
                      ),
                      ),
                    )
                  ],
                ),
              ),
              isClicked?
              Padding(
                padding: EdgeInsets.all(minPadding),
                child: Text('$displayResult', style: textStyle,),
              ):Container(),
              SizedBox(height:10,) ,
              Center(child:Container(
                child: isClicked? Icon(Icons.check_circle_outline , size: 122,): null,
              )),

            ],
          ),
        ),

      ),
      bottomNavigationBar: BottomAppBar(
           child: Container(
               padding: EdgeInsets.only(
                  top: 10,
               ),
               width: double.infinity ,
               height: 60,
               color: Colors.blue,
               child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     Expanded(
                         child:Center(child: Column(
                            children: <Widget>[
                                Icon(Icons.home , size: 18, color: Colors.white,)  ,
                                Text('Home' ,style: TextStyle(
                                   color: Colors.white,
                                ),)
                            ],
                         ),
                     )),
                  Expanded(
                          child:InkWell(
                            onTap: (){
                                 Navigator.of(context).push(
                                     MaterialPageRoute(builder: (BuildContext context)=> new PageHistorico(list: historico,))
                                 );
                            },
                            child:Center(child: Column(
                            children: <Widget>[
                              Icon(Icons.history, size: 18, color: Colors.white,)  ,
                              Text('Histórico' , style: TextStyle(
                                color: Colors.white,
                              ))
                            ],
                          )),
                        )),
                   ],
               ),
           ),
      ),

    );
  }

  Widget getImageAsset() {
    return Container(
      margin: EdgeInsets.all(minPadding*10),
      child: Center(
          child: Image( image:AssetImage('images/finance.png'), width: 125.0, height: 125.0,)),
    );
  }

  String setValue(String value)
  {
    return value;
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected=newValueSelected;
    });
  }

  String  _calculateTotalReturns() {
    setState(() {
      isClicked = true;
    });
    double principal =double.parse(principalController.text);
    double rio =double.parse(rioController.text);
    int term = int.parse(termController.text);


    double totalAmountPayable =principal+(principal*rio*term)/100;
    Values  valores =  new Values(type: _currentItemSelected, result:totalAmountPayable.toString() );
    historico.add(valores);
    return  'After $term years, your investiment will be worth $totalAmountPayable $_currentItemSelected';
  }
  void reset(){
    setState(() {
      isClicked = false;
    });
    principalController.clear();
    rioController.clear();
    termController..clear();
    this.displayResult='';
    _currentItemSelected =_currencies[0];
  }



}

class PageHistorico extends StatefulWidget{

  List<Values> list;
  PageHistorico({this.list});
  Sample createState()=> new Sample();

}

class Sample extends State<PageHistorico>{
   @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: new AppBar(
            title: Text('My Stories' ,style: TextStyle(
               color: Colors.white ,
            ),),
            backgroundColor: Colors.blueAccent,

        ),
        body: Container(
            padding: EdgeInsets.only(
               top: 10 ,

            ),
             height:MediaQuery.of(context).size.height,
            child:ListView.builder(
                itemCount: widget.list.length == 0?0:widget.list.length,
                itemBuilder: (context , index){
                   return ListTile(
                           leading:CircleAvatar(
                              foregroundColor: Colors.white,
                               child:Text(widget.list[index].type ,style: TextStyle(
                                 color: Colors.white,
                                 fontSize:8,
                                 fontWeight: FontWeight.bold,
                               ),),
                           ),
                          title: Text(widget.list[index].result, style: TextStyle(
                             color: Colors.white ,
                             fontSize: 23 ,

                          ),),
                   ) ;
                }
            ),


        ),

      );
  }
}

class Values {
   String type;
   String result ;
   Values({this.type, this.result});

}
