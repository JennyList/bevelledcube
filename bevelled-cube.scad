/*

A function to generate a bevelled cube
Jenny List 2025
CC-BY-SA 4.0

Usage:

bevelledCube(x,y,z,radius);

where x,y, and z are the dimensions of the cube, and radius is the desired bevel radius.

Values of radius greater than x, y, or z, will produce odd results.

Smoothness of the curves is as always dictated by a global value of $fn.

*/


module bevelledCube(x,y,z,radius){

    // Makes a cut-out shape for a bevel
    module bevel(facelength,bevelradius){
        difference(){
            cube([bevelradius,bevelradius,facelength]);
            translate([bevelradius,bevelradius,0]) cylinder(facelength,bevelradius,bevelradius);
        }
    }

    //Cuts the bevel away from a cube
    difference(){
        cube([x,y,z]);
        //Z axis bevels
        bevel(z,radius);
        translate([x,0,0]) mirror([1,0,0]) bevel(z,radius);
        translate([0,y,0]) mirror([0,1,0]) bevel(z,radius);
        translate([x,y,0]) mirror([1,1,0]) bevel(z,radius);
        
        //X axis bevels
        rotate([0,90,0]) mirror([1,0,0]) bevel(x,radius);
        rotate([0,90,0]) translate([-z,0,0]) bevel(x,radius);
        rotate([0,90,0]) translate([0,y,0]) mirror([1,1,0]) bevel(x,radius);
        rotate([0,90,0]) translate([-z,y,0]) mirror([0,1,0]) bevel(x,radius);
        
        //Y axis bevels
        rotate([-90,0,0]) mirror([0,1,0]) bevel(y,radius);
        rotate([-90,0,0])  translate([0,-z,0]) bevel(y,radius);
        rotate([-90,0,0])  translate([x,0,0]) mirror([1,1,0]) bevel(y,radius);
        rotate([-90,0,0])  translate([x,-z,0]) mirror([1,0,0]) bevel(y,radius);
        
        //Remove corners ready for spheres
        cube([radius,radius,radius]);
        translate([x-radius,0,0]) cube([radius,radius,radius]);
        translate([x-radius,y-radius,0]) cube([radius,radius,radius]);
        translate([0,y-radius,0]) cube([radius,radius,radius]);
        translate([0,0,z-radius]) cube([radius,radius,radius]);
        translate([x-radius,0,z-radius]) cube([radius,radius,radius]);
        translate([x-radius,y-radius,z-radius]) cube([radius,radius,radius]);
        translate([0,y-radius,z-radius]) cube([radius,radius,radius]);
        
    }

    //Spherical corners
    translate([radius,radius,radius]) sphere(radius);
    translate([x-radius,radius,radius]) sphere(radius);
    translate([x-radius,y-radius,radius]) sphere(radius);
    translate([radius,y-radius,radius]) sphere(radius);
    translate([radius,radius,z-radius]) sphere(radius);
    translate([x-radius,radius,z-radius]) sphere(radius);
    translate([x-radius,y-radius,z-radius]) sphere(radius);
    translate([radius,y-radius,z-radius]) sphere(radius);
}

//Example:
//$fn=90;
//bevelledCube(30,40,50,5);

