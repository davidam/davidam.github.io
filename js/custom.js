/*
  @licstart  The following is the entire license notice for the 
  JavaScript code in this page. 
  
  Copyright (C) 2020  David Arroyo Menéndez davidam@libresoft
  
  The JavaScript code in this page is free software: you can 
  redistribute it and/or modify it under the terms of the GNU 
  General Public License (GNU GPL) as published by the Free Software 
  Foundation, either version 3 of the License, or (at your option) 
  any later version.  The code is distributed WITHOUT ANY WARRANTY; 
  without even the implied warranty of MERCHANTABILITY or FITNESS 
  FOR A PARTICULAR PURPOSE.  See the GNU GPL for more details. 
  
  As additional permission under GNU GPL version 3 section 7, you 
  may distribute non-source (e.g., minimized or compacted) forms of 
  that code without the copy of the GNU GPL normally required by 
  section 4, provided you include this license notice and a URL 
  through which recipients can access the Corresponding Source. 
  
  
  @licend  The above is the entire license notice 
  for the JavaScript code in this page.  
*/


var photos = [
    "img/davidam-github.jpg",
    "img/davidam2.png",
    "img/davidam3.png",
    "img/davidam-e.jpg"
];


var size = photos.length;
var x = Math.floor(size*Math.random());
document.getElementById('photo-left').src=photos[x];
document.getElementById('photo-rigth').src=photos[x];


var colors = [
    "red",
    "green",
    "blue",
    "black",
    "orange",
    "purple"
]

var i= 0;
for (i = 0; i < document.getElementsByClassName("box-title").length; i++) {
    document.getElementsByClassName("box-title")[i] = "red";
}

var list = document.getElementsByClassName("box-title");

var x = Math.floor(Math.random() * list.length);

for (var i = 0; i < list.length; i++) {
    list[i].style.background = colors[x];
}

Document.getElementsByClassName("box-title")[0].style.background = "red";

