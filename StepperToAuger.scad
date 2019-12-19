$fn = 200;

spindle_len = 10;
spindle_dia = 8;
auger_dia = 38;
wall_thickness = 2;
//M3 screw dia is 3mm
screw_dia = 3.5;

difference(){
  union() {
    translate([0,0,wall_thickness])
    cylinder(d=spindle_dia, h=spindle_len);
    cylinder(d=auger_dia, h=wall_thickness);
  }
  //screw holes
  translate([auger_dia/2-5, 0, 0])
    cylinder(d=screw_dia, h=wall_thickness);
  translate([-(auger_dia/2-5), 0, 0])
    cylinder(d=screw_dia, h=wall_thickness);
}