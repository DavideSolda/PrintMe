sum = 3;
for (a =[3:5]) {
    sum = sum + a;
    echo(sum);
}
echo(sum);


//text("\u20AC 10 \u263A");
//  translate([0,-20,0])
//    text("\u20AC 10 \u263A", font="Liberation Sans:style=Bold Italic");

//translate([0,10,0]) {
//  cube(2,center=true);
//  translate([5,0,0]) {
//    cube (3,center=true);
//  }
//}
  
//linear_extrude(10) {
//  text("\u20AC 10 \u263A");
//    translate([0,-20,0])
//      text("\u20AC 10 \u263A", font="Liberation Sans:style=Bold Italic");
//}


translate([0,-20,0])
rotate([0,0,0])
  linear_extrude(3)
    text("\u263A");

rotate([90,0,0])
  linear_extrude(3)
    text("\u263A");

for(i=[0:36]) {
   for(j=[0:36]) {
     color( [0.5+sin(10*i)/2, 0.5+sin(10*j)/2, 0.5+sin(10*(i+j))/2] )
     translate( [i, j, 0] )
     cube( size = [1, 1, 11+10*cos(10*i)*sin(10*j)] );
   }
}
