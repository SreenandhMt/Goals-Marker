import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:goal_marker/services/home/home_provider.dart';
import 'package:provider/provider.dart';

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
  GlobalKey<FormState> key = GlobalKey<FormState>();
    String currentType = "Dey";
    bool onUpdate = false;
    late TextEditingController title,note;
  
  @override
  void initState() {
    title = TextEditingController(text: widget.map!=null? widget.map!["title"]:null);
   note = TextEditingController(text:  widget.map!=null? widget.map!["note"]:null);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if(size.width>100)
    {
      return Form(
      key: key,
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SizedBox(
            width: size.width*0.4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Keep Going",style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 30),
                  TextFormField(onChanged: (value) => setState(() {
                    onUpdate = true;
                  }),validator: (value) {
                    if(value==null)
                    {
                      return "Enter Goals";
                    }
                    if(value.isEmpty){
                      return "Enter Goals";
                    }
                    return null;
                  },controller: title,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),hintText: "Goal Title"),),
                  const SizedBox(height: 20),
                  TextFormField(onChanged: (value) => setState(() {
                    onUpdate = true;
                  }),controller: note,keyboardType: TextInputType.multiline,maxLines: null,maxLength: 100,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),hintText: "Note*"),),
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
                      if(onUpdate&&key.currentState!.validate())
                      {
                        
                         context.read<HomeServices>().updateData(id: widget.map!["id"],note: note.text,title: title.text,map: widget.map!);
                         setState(() {
                    onUpdate = false;
                  });
                      }else if(!onUpdate){
                        context.read<HomeServices>().deleteData(type: widget.map!["type"], id: widget.map!["id"]);
                        context.pop();
                      }
                     
                    }else if(key.currentState!.validate()){
                      context.read<HomeServices>().addData(type: currentType, datetime: DateTime.now().toString(), id: DateTime.now().microsecondsSinceEpoch.toString(),note: note.text,title: title.text);
                    }
                  },color: Colors.grey,padding:  EdgeInsets.all(0),child: SizedBox(width: double.infinity,height: 50,child: Center(child: Text(widget.map!=null? onUpdate? "Update":"Delete":"Add",style: TextStyle(),)),),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
    }
    return Form(
      key: key,
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text("Keep Going",style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 30),
                TextFormField(onChanged: (value) => setState(() {
                  onUpdate = true;
                }),validator: (value) {
                  if(value==null)
                  {
                    return "Enter Goals";
                  }
                  if(value!.isEmpty){
                    return "Enter Goals";
                  }
                },controller: title,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),hintText: "Goal Title"),),
                const SizedBox(height: 20),
                TextFormField(onChanged: (value) => setState(() {
                  onUpdate = true;
                }),controller: note,keyboardType: TextInputType.multiline,maxLines: null,maxLength: 100,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),hintText: "Note*"),),
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
                    if(onUpdate&&key.currentState!.validate())
                    {
                      
                       context.read<HomeServices>().updateData(id: widget.map!["id"],note: note.text,title: title.text,map: widget.map!);
                       setState(() {
                  onUpdate = false;
                });
                    }else if(!onUpdate){
                      context.read<HomeServices>().deleteData(type: widget.map!["type"], id: widget.map!["id"]);
                      context.pop();
                    }
                   
                  }else if(key.currentState!.validate()){
                    context.read<HomeServices>().addData(type: currentType, datetime: DateTime.now().toString(), id: DateTime.now().microsecondsSinceEpoch.toString(),note: note.text,title: title.text);
                  }
                },color: Colors.grey,padding:  EdgeInsets.all(0),child: SizedBox(width: double.infinity,height: 50,child: Center(child: Text(widget.map!=null? onUpdate? "Update":"Delete":"Add",style: TextStyle(),)),),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}