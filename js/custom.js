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
    "img/davidam-e.jpg",
    "img/davidam-santander.jpg",
    "img/davidam-mit.jpg",
    "img/davidam-logo-madrid.jpg",
    "img/davidam-covid19.jpg",
    "img/davidam-traje.jpg",
    "img/davidam-amsterdam-dark-ukranian-flag.jpg",
    "img/davidam-stalingrad.jpg",
    "img/davidam-ukrainian-flag.jpg",
    "img/davidam-united-painting.jpg",
    "img/davidam-bath.jpg",
    "img/davidam-piruli.jpg",
    "img/davidam-park.jpg",    
];


var size = photos.length;
var x = Math.floor(size*Math.random());
document.getElementById('photo-left').src=photos[x];
document.getElementById('photo-rigth').src=photos[x];

//document.getElementById("demo").innerHTML = "colortext2";

var colors = [
    "red",
    "green",
    "blue",
    "#0080FF",
    "black",
    "orange",
    "gold",
    "purple"
]

var i= 0;
for (i = 0; i < document.getElementsByClassName("box-title").length; i++) {
    document.getElementsByClassName("box-title")[i] = "red";
}

var list = document.getElementsByClassName("box-title");

var x = Math.floor(Math.random() * colors.length);

for (var i = 0; i < list.length; i++) {
    list[i].style.background = colors[x];
    if ( colors[x] == "gold") {
	list[i].style.color = "black";
    }
}

//Document.getElementById('colortext').textContent = "text";
document.getElementById("demo").innerHTML = colors[x];

if ( colors[x] == "red") {
    document.getElementById("demo").innerHTML = "We need improve the social politics, the citizens must be happy";
} else if ( colors[x] == "purple" ) {
    document.getElementById("demo").innerHTML = "The feminism is changing all the society, we can be safe, we can be public.";
} else if ( colors[x] == "blue" ) {
    document.getElementById("demo").innerHTML = "The house, the food, the family. That's the important thing.";
} else if ( colors[x] == "green" ) {
    document.getElementById("demo").innerHTML = "Save your city, save your country, save the planet, join us in the distance.";
} else if ( colors[x] == "black" ) {
    document.getElementById("demo").innerHTML = "I am angry with the injustice";
} else if ( colors[x] == "#0080FF" ) {
    document.getElementById("demo").innerHTML = "You are a sky, I want a start up with you";
} else if ( colors[x] == "orange" ) {
    document.getElementById("demo").innerHTML = "Understanding the diversity we know that the value of the unity";
} else if ( colors[x] == "gold" ) {
     document.getElementById("demo").innerHTML = "The life is better accompanied by another person";
} else {
    document.getElementById("demo").innerHTML = "Save your city, save your country, save the planet, join us in the distance.";
}



