// /* 1 */
// module circle_ring(radius, thickness) {
//     difference() {
//         circle(radius, $fn = 48);
//         circle(radius - thickness, , $fn = 48);
//     }
// }
// circle_ring(3, 1);


///* 2 */
//module circle_ring(radius, thickness) {
//    difference() {
//        circle(radius, $fn = 48);
//        offset(r = -thickness) circle(radius, , $fn = 48);
//    }
//}
//circle_ring(3, 1);


///* 3 */
//module square_frame(dimension, thickness) {
//    difference() {
//        square(dimension);
//        offset(r = -thickness) square(dimension);
//    }
//}
//square_frame([20, 10], 1);


/* 4 */
module frame(thickness) {
    difference() {
        children();
        offset(r = -thickness) children();
    }
}

frame(1) circle(3, $fn = 48);
frame(1) square([10, 5]);

https://openhome.cc/eGossip/OpenSCAD/Children.html
Now that it's such common requirement to make a frame, could we write a general frame module which generates a frame from any 2D module? No problem
