logo_file = "s3dt-logo.dxf";
font = "Liberation Sans";

// reel:
outer_diameter = 200;
hole_diameter = 55;
reel_diameter = 190;
width = 20;
outer_reel_width = 5;
rim_height = 2;
rib_margin = 10;
inscription_depth = 1.5 * rim_height;
text_size = 20;

module inner_reel() {
    translate([0, 0, -width/2])
    linear_extrude(height=width-rim_height*2) {
        circle(d=reel_diameter, $fn=200);
    }
    
    translate([0, 0, 1.1])
    linear_extrude(height=4, scale=1.05) {
        circle(d=reel_diameter, $fn=200);
    }
    
    translate([0, 0, -6.1])
    rotate([180,0,0])
    linear_extrude(height=4, scale=1.05) {
        circle(d=reel_diameter, $fn=200);
    }
}

module plain_outer_reel() {
    linear_extrude(height=outer_reel_width) {
        circle(d=outer_diameter, $fn=400);
    }
}

module outer_reel() {
    union() {
        ribs();
        difference() {
            plain_outer_reel();
            color("gray")
            translate([0, 0, outer_reel_width-2])
            linear_extrude(height=2+1) {
                circle(d=outer_diameter - 5, $fn=400);
            }
        }
    }
}

module hole() {
    translate([0, 0, -width])
    linear_extrude(height=2*width) {
        circle(d=hole_diameter, $fn=200);
    }
}


module rib() {
    translate([hole_diameter/2+rib_margin, -rim_height/2, outer_reel_width - rim_height])
    cube([outer_diameter/2-(hole_diameter/2+2*rib_margin), rim_height, rim_height]);
}

module ribs() {
    for (angle=[0, 60, 120, 180, 240, 300]) {
        rotate(angle) rib();
    }
}

module reel() {
    inner_reel();
    translate([0, 0, width / 2 - outer_reel_width])
    // upper reel
    outer_reel();
    // lower reel
    translate([0, 0, -width / 2])
    rotate([180,0,0])
    plain_outer_reel();
}

module logo(height) {
    linear_extrude(height = height, center = true) {
        translate([-32.5,-22,0])
        scale(0.15)
        import(logo_file);
    }
}

module logo_inscription() {
    translate([0,-0.7*outer_diameter/2,width/2 - inscription_depth])
    logo(1.1 * inscription_depth); // + eps
}

module description() {
    translate([0, 0.6*outer_diameter/2, width/2 - inscription_depth])
    linear_extrude(height=1.1 * inscription_depth, center=true) {
        text("ABS", text_size, halign="center", font=font);
    }
}

scale(8/20)
difference() {
    difference() {
        reel();
        union() {
            logo_inscription();
            description();
        }
    }
    hole();
}
