import 'package:flutter/material.dart';

import 'package:goal_marker/services/home/home_provider.dart';

class EditGoalPage extends StatefulWidget {
  const EditGoalPage({
    super.key,
    this.map,
  });
  final Map<String,dynamic>? map;

  @override
  State<EditGoalPage> createState() => _EditGoalPageState();
}

class _EditGoalPageState extends State<EditGoalPage> {
  List<String> types = ["Dey","Week","Month","Year"];
    String currentType = "Dey";
    late TextEditingController title,note;
  
  @override
  void initState() {
    title = TextEditingController(text: widget.map!=null? widget.map!["title"]:null);
   note = TextEditingController(text:  widget.map!=null? widget.map!["note"]:null);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(controller: title,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),hintText: "Add Goal"),),
              const SizedBox(height: 20),
              TextFormField(controller: note,keyboardType: TextInputType.multiline,maxLines: null,maxLength: 100,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),hintText: "Note"),),
              const SizedBox(height: 10),
              if(widget.map==null)
              DropdownButton(value: currentType,items: types.map((e) => DropdownMenuItem(value: e,child: Text(e)),).toList(), onChanged: (value) {
                setState(() {
                  currentType=value!;
                });
              },),
              if(widget.map==null)
              const SizedBox(height: 10),
              MaterialButton(onPressed: (){
                if(widget.map!=null)
                {
                  HomeServices().updateData(id: DateTime.now().microsecondsSinceEpoch.toString(),note: note.text,title: title.text,map: widget.map!);
                }else{
                  HomeServices().addData(type: currentType, datetime: DateTime.now().toString(), id: DateTime.now().microsecondsSinceEpoch.toString(),note: note.text,title: title.text);
                }
              },color: Colors.grey,padding:  EdgeInsets.all(0),child: SizedBox(width: double.infinity,height: 50,child: Center(child: Text(widget.map!=null? "Update":"Add",style: TextStyle(),)),),)
            ],
          ),
        ),
      ),
    );
  }
}