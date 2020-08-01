
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

