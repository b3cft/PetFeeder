$fn = 200;

base_width = 84;
base_length = 114;
wall_thickness = 2;
radius = 10;
//M3 screw dia is 3mm
screw_dia = 3.5;
pipe_dia = 43.5;
funnel_height=40;


difference() {
  union() {
    base_plate();
    funnel();
  }
  translate([-pipe_dia,-pipe_dia,-funnel_height*2-pipe_dia-wall_thickness/2])
  cube(pipe_dia*2,pipe_dia*2,funnel_height);
}

module funnel() {
  translate([0,0,-funnel_height+wall_thickness])
  difference() {
    union() {
      scale([1, 1.5, 1])
        cylinder(d1=pipe_dia, d2=pipe_dia*1.5, h=funnel_height);
      rotate([90,0,0])
        translate([0,0,-pipe_dia])
        cylinder(d=pipe_dia+2*wall_thickness, h=pipe_dia*2);
      // pipe clamp exterior
      translate([-pipe_dia*.75,-pipe_dia,0])
        cube([pipe_dia*1.5,pipe_dia*2,wall_thickness]);
     
    }
    // funnel  interior
    scale([1, 1.5, 1])
      cylinder(d1=pipe_dia-2*wall_thickness, d2=pipe_dia*1.5-2*wall_thickness, h=40);
    // pipe interior
    rotate([90,0,0])
        translate([0,0,-pipe_dia])
        cylinder(d=pipe_dia, h=pipe_dia*2);
    // tube clamp screws
    translate([-pipe_dia/2-6,-pipe_dia/2-6,0])
      cylinder(d=screw_dia, h=wall_thickness);
    translate([pipe_dia/2+6,-pipe_dia/2-6,0])
      cylinder(d=screw_dia, h=wall_thickness);
    translate([-pipe_dia/2-6,pipe_dia/2+6,0])
      cylinder(d=screw_dia, h=wall_thickness);
    translate([pipe_dia/2+6,pipe_dia/2+6,0])
      cylinder(d=screw_dia, h=wall_thickness);  
  }
}

module cut_corner(r,x,y){
  translate([x-radius,y-radius,0])
  rotate([0,0,r])
  difference() {
    cube([radius,radius,wall_thickness]);
    intersection() {
      cylinder(r=radius, h=wall_thickness);
        cube([radius, radius, wall_thickness]);
    }

  }
}

module base_plate() {
  difference() {
    translate([0,0,wall_thickness/2])
      cube([base_width, base_length, wall_thickness], center=true);
    //corners
    cut_corner(0,base_width/2,base_length/2);
    cut_corner(90,-base_width/2+radius*2,base_length/2);
    cut_corner(-90,base_width/2,-base_length/2+radius*2);
    cut_corner(180,-base_width/2+radius*2,-base_length/2+radius*2);
    //screw holes
    translate([base_width/2-radius, base_length/2-radius, 0])
      cylinder(d=screw_dia, h=wall_thickness);
    translate([-base_width/2+radius, base_length/2-radius, 0])
      cylinder(d=screw_dia, h=wall_thickness);
    translate([base_width/2-radius, -base_length/2+radius, 0])
      cylinder(d=screw_dia, h=wall_thickness);
    translate([-base_width/2+radius, -base_length/2+radius, 0])
      cylinder(d=screw_dia, h=wall_thickness);
    //funnel intersection
    scale([1,1.5,1])
     cylinder(d=pipe_dia*1.5-wall_thickness,h=wall_thickness);
  }
}
