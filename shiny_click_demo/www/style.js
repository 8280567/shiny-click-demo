function closeMenu(event) {
var current, related;
if (window.event) {
current = this;
related = window.event.toElement;
}
else {
current = event.currentTarget;
related = event.relatedTarget;
}
if (current != related && !contains(current, related))
   current.style.visibility = "hidden";
};



function contains(a,b){
    //alert("contains")
// Return true if node a contains node b.
while (b.parentNode)
if ((b = b.parentNode) == a)
return true;
return false;
};

Shiny.addCustomMessageHandler("testmessage0",
  function(message) {
     //alert(JSON.stringify(message));
  }
);


Shiny.addCustomMessageHandler("openMenu",
  function(message) {

    //alert("openMenu");
    var event=message.event;
    var el, x, y;
var id=message.divid
 document.getElementById(id).onmouseout = closeMenu;
el = document.getElementById(id);
if (window.event) {
x = window.event.clientX + document.documentElement.scrollLeft
+ document.body.scrollLeft;
y = window.event.clientY + document.documentElement.scrollTop +
+ document.body.scrollTop;
}
else {
x = event.x ;//+ window.scrollX;
y = event.y;// + window.scrollY;
}
x -= 2; y -= 2;
el.style.left = x + "px";
el.style.top = y + "px";
el.style.visibility = "visible";
   // alert(JSON.stringify(message)+'00000000');
  }
);


Shiny.addCustomMessageHandler("closeMenu",
  function(message) {
      var event=message.event

      if(event==null)
      {
      return;

      }

var id='myMenu'
 var  e0 ;
 e0= document.getElementById(id);
var current, related;
if (window.event) {
current = this;
related = window.event.toElement;
}
else {
current = event.currentTarget;
related = event.relatedTarget;
}
if (current != related && !contains(current, related))
    current.style.visibility = "hidden";
}
);



Shiny.addCustomMessageHandler("contains",
  function(a,b){
    alert("contains")
// Return true if node a contains node b.
while (b.parentNode)
if ((b = b.parentNode) == a)
return true;
return false;
}
);

  function TC(a,popid,imgid)
 {
   var lxp = new lxPopup("Mask", popid, "close", "PopupMe");
   lxp.popup(lxp);

   sas();
   function sas()
     {
       var vxp = new lxPopup("Mask", popid, "close", "menuItem");
       vxp.popup(vxp);
        $("#"+imgid).attr("src", a);
    }
 }


