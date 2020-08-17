height = 5;
offset_for_center = -height / 2;
word = "DIO CAN";
font="Liberation Sans:style=Bold Italic";

//module bestemmia() {
//    translate([offset_for_center, offset_for_center, offset_for_center])
//        linear_extrude(height) 
//            text(word, font = font);
//}
//
//bestemmia();


//module chinese_word(word, font, height, offset_for_center) {
//    translate([offset_for_center, offset_for_center, offset_for_center])
//        linear_extrude(height) 
//            text(word, font = font);
//}
//
//chinese_word(word, font, height, offset_for_center);


//module chinese_word(word, font, height, center = true) {
//    offset_for_center = center ? -height / 2 : 0;
//    translate([offset_for_center, offset_for_center, offset_for_center])
//        linear_extrude(height) 
//            text(word, font = font);
//}
//
//chinese_word(word, font, height, center = false);
//rotate([90, 0, 0]) 
//    chinese_word(word, font, height, center = false);


reps = 10;
step_angle = 360/reps;
radius = 30*$t;


for(i = [0:reps]) {
    rotate(step_angle * i) 
        //translate([radius, 0, i * 5]) 
        translate([radius, 0, 0]) 
            linear_extrude(height) 
                text(word);
} 


length_side1 = 10;
length_side2 = 20;

function length_hypotenuse(length_side1, length_side1) = 
    sqrt(pow(length_side1, 2) + pow(length_side2, 2));

echo(length_hypotenuse(length_side1, length_side1));  // ECHO: 22.3607


function my_len(text, counter = 0) = 
    text[counter] == undef ? counter : my_len(text, counter + 1);

echo(my_len("TEST"));  // ECHO: 4
