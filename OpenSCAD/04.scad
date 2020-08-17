// /* 1 */
// radius = 10;
// 
// circle(radius, $fn = 48);
// //circle(radius);
// translate([0, -radius, 0]) 
//     square(radius * 2);


// /* 2 */
// radius = 10;
// 
// module circle_and_square(radius) {
//     circle(radius, $fn = 48);
//     translate([0, -radius, 0]) 
//         square(radius * 2);
// }
// 
// rotate(-45) circle_and_square(radius);
// 
// // equivalente a
// rotate(-45) union() {
//     circle(radius, $fn = 48);
//     translate([0, -radius, 0]) 
//         square(radius * 2);
// }


// /* 2 */
// radius = 10;
// 
// module heart(radius) {
//     rotated_angle = 45;
//     diameter = radius * 2;
//     $fn = 48;
// 
//     rotate(-rotated_angle) union() {
//         circle(radius);
//         translate([0, -radius, 0]) 
//             square(diameter);
//     }
// 
//     translate([cos(rotated_angle)*diameter, 0, 0]) 
//         circle(radius);
// }
// 
// heart(radius);



// /* 3 */
// radius = 20;
// 
// module heart(radius) {
//     rotated_angle = 45;
//     diameter = radius * 2;
//     $fn = 48;
// 
//     rotate(-rotated_angle) union() {
//         circle(radius);
//         translate([0, -radius, 0]) 
//             square(diameter);
//     }
// 
//     translate([cos(rotated_angle) * diameter, 0, 0]) 
//         circle(radius);
// }
// 
// difference() {
//     heart(radius);
//     text("LOVE");
// }




// /* 4 */
// character = "A";
// font_size = 10;
// thickness = 1;
// 
// module hollow_sphere(radius, thickness) {
//     $fn = 48;
//     inner_radius = radius - thickness;
// 
//     difference() {
//         sphere(radius);
//         sphere(inner_radius);
//     }    
// }
// 
// module sphere_character(ch, font_size, thickness) {
//     font_offset = font_size / 2;
// 
//     intersection() {
//         hollow_sphere(font_size, thickness);
//         linear_extrude(font_size * 2) 
//             translate([-font_offset, -font_offset, 0]) 
//                 text(ch, size = font_size);
//     }
// }
// 
// sphere_character(character[0], font_size, thickness);
// difference() {
//   hollow_sphere(font_size - thickness, thickness);
//   //sphere(font_size - thickness, $fn = 48);
//   //cube(10,[font_size,0,0]);
// }
// 

// /* 5 */
// 
// hull() {
// sphere(7);
// translate([10,0,0])
//   sphere(7);
// }

// /* 6 */
// radius = 10;
// hull() {
//     linear_extrude(10) 
//         circle(radius);
//     linear_extrude(20) 
//         translate([2 * radius, 0, 0]) 
//             circle(radius);
// }



/* 6 */

radius = 10;


difference() {
hull() {
#circle(radius);
#translate([radius*2-1,0,0])
  circle(radius);

translate([radius,radius*2,0])
  circle(radius/3);
}
//translate([radius,-radius/2,0])
//  square([radius*4,radius],center=true);
}
