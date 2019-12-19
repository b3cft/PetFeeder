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
  clamp();
  translate([-pipe_dia,-pipe_dia,-funnel_height*2-pipe_dia-wall_thickness/2])
  cube(pipe_dia*2,pipe_dia*2);
}

module clamp() {
  translate([0,0,-funnel_height+wall_thickness])
  difference() {
    union() {
      translate([-pipe_dia/2-wall_thickness,-pipe_dia,0])
        cube([pipe_dia+wall_thickness*2,pipe_dia*2,pipe_dia-wall_thickness]);
      // base clamp
      translate([-pipe_dia*.75,-pipe_dia,funnel_height])
        cube([pipe_dia*1.5,pipe_dia*2,wall_thickness]);
      // pipe clamp exterior
      translate([-pipe_dia*.75,-pipe_dia,0])
        cube([pipe_dia*1.5,pipe_dia*2,wall_thickness]);
     
    }

    // pipe interior
    rotate([90,0,0])
        translate([0,0,-pipe_dia])
        cylinder(d=pipe_dia, h=pipe_dia*2);
    // tube clamp screws
    translate([-pipe_dia/2-6,-pipe_dia/2-6,0])
      cylinder(d=screw_dia, h=funnel_height+wall_thickness);
    translate([pipe_dia/2+6,-pipe_dia/2-6,0])
      cylinder(d=screw_dia, h=funnel_height+wall_thickness);
    translate([-pipe_dia/2-6,pipe_dia/2+6,0])
      cylinder(d=screw_dia, h=funnel_height+wall_thickness);
    translate([pipe_dia/2+6,pipe_dia/2+6,0])
      cylinder(d=screw_dia, h=funnel_height+wall_thickness);  
  }
}