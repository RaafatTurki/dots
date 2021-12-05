/*	vim: filetype=css
	version: 1.7.0
*/

* {
	bg:		cw(black);
	mg:		#0A151F;
    fg:		#294374;
	sel:	#FEFFFF;
	tr:		#00000000;

	background-color:  @tr;
	text-color:  @sel;
}
window {
	height:		80%;
	width:		20%;
	location:	center;
	anchor:		center;
	/* border: 1px; */
	border: 0px;
    border-color: @mg;
}
mode-switcher {}
button selected {
    border-color: @fg;
    text-color: @fg;
}
inputbar {
    padding: 4px;
}
mainbox {
    expand: true;
    background-color: @bg;
    spacing: 16px;
	padding: 10px;
}
listview {
    dynamic: true;
    lines: 10;
}
element {
	padding: 1px 10px;
}
element-text {
	text-color: @fg;
}
element-icon {
	padding: 0px 10px 0px 0px;
}
element selected {}
element-text selected {
	text-color: @sel;
}
