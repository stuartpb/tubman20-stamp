module from_jackson_bottom_left(extents) {
  translate([-55.935/2,-58.745/2]) children();
}

// How deep to make the stamp.
stamp_depth = 1;

// How thick to make the layer behind the stamp.
backing_depth = 1;

// How much to overshoot with differences.
fudge = 1;

// Cutout for the beginning of the word "TWENTY"
twenty_safezone_x = 39;
twenty_safezone_h = 5;
// this doesn't really matter, just needs to overshoot the extents of the stamp
twenty_safezone_w = 50;

// Cutout for the banner underneath the portrait
copperplate_safezone_x = 17;
copperplate_safezone_w = 14.75;
copperplate_safezone_h = 3.5;
copperplate_x = 18.5;
copperplate_y = 0.5;

// Expansion to make the copperplate printable on a 0.4mm nozzle
copperplate_outset = 0.08;

// Extent values to counteract OpenSCAD's forced bounding-box centering
tubman_y_offset = -(58.745-51.849)/2;
copperplate_w = 11.480;
copperplate_h = 1.482;

module stamp_design() {
  union() {
    difference() {
      translate([0, tubman_y_offset]) import("tubman-portrait.svg");
      translate([copperplate_safezone_x,-1,0]) from_jackson_bottom_left()
        square([copperplate_safezone_w,copperplate_safezone_h]);
      translate([twenty_safezone_x,0,0]) from_jackson_bottom_left()
        square([twenty_safezone_w,twenty_safezone_h]);
    }
    translate([copperplate_w/2+copperplate_x,copperplate_h/2+copperplate_y,0]) from_jackson_bottom_left()
      offset(delta=copperplate_outset) import("tubman-copperplate.svg");
  }
}

mirror([1,0,0]) union() {
  linear_extrude(backing_depth) import("jackson-silhouette.svg");
  linear_extrude(backing_depth) translate([0, tubman_y_offset]) import("tubman-silhouette.svg");
  translate([0,0, backing_depth]) linear_extrude(stamp_depth) stamp_design();
}
