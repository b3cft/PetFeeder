$fn=200;

// dimensions in mm
// -------------------
wall_thickness = 2;
pipe_dia = 43.5;
pipe_overlap = 15;
waist_height = 15;
waist_dia = pipe_dia - 15;
stepper_width=42;
stepper_length=42;
stepper_screw_dia=3.5;
stepper_screw_offset=15.75;
// -------------------

union() {
  pipe_fitting();
  stepper_plate();
}

module stepper_plate(){
  difference(){
    // stepper plate
    translate([-stepper_width/2,-stepper_length/2,0])
      cube([stepper_width,stepper_length,wall_thickness]);
    // stepper spindle cutout
    cylinder(d=24,h=wall_thickness);
    // screw_holes
    screw_holes(stepper_screw_offset);
  }
}

module screw_holes(offset) {
    translate([offset,offset,0])
      cylinder(d=stepper_screw_dia, h=wall_thickness);
    translate([-offset,offset,0])
      cylinder(d=stepper_screw_dia, h=wall_thickness);
    translate([offset,-offset,0])
      cylinder(d=stepper_screw_dia, h=wall_thickness);
    translate([-offset,-offset,0])
      cylinder(d=stepper_screw_dia, h=wall_thickness);
}

module pipe_fitting() {
  //Pipe Overlap
  translate([0,0,waist_height+wall_thickness])
  difference(){
    cylinder(
      d=pipe_dia+(2*wall_thickness),
      h=pipe_overlap);
    cylinder(
      d=pipe_dia,
      h=pipe_overlap);
  }
  // Waist
  translate([0,0,wall_thickness])
  difference(){
    cylinder(
      h=waist_height,
      d2=pipe_dia+(2*wall_thickness),
      d1=waist_dia+(2*wall_thickness));
    cylinder(
      h=waist_height,
      d2=pipe_dia,
      d1=waist_dia);
  }
}