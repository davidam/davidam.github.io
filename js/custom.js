
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

