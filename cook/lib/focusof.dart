@override
  Widget focusof(BuildContext context)=> {
    return GestureDetector(
      onTap: () {
        //FocusManager.instance.primaryFocus?.unfocus();
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(50),
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Input1'),
                    onChanged: (text) {
                      setState(() {
                        _fieldText1 = text;
                      });
                    },
                  )),
                  ...
             ]
          )
       )
    );