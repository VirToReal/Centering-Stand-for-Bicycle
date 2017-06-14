/*
Zentrierständer für Fahrrad-Laufräder / Centering-Stand for Bicycle-Impeller
Copyright (C) 2017  Benjamin Hirmer - hardy at virtoreal.net
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/


/*
######### INFORMATION - CONSTRUCTING #########
Add the Parameters to fit the size of your wheel. You can be clumsy with that,
because the turquoise colored rods in the OpenScad-Preview are threaded-rods
and can be easily adjusted to your needed distances. Because of that, better
give some more than having to less at the end.

The variable "printmode" help you switch between OpenSCAD-Preview and Printmode.
The Preview shows your Adjustments on the Parameters. The "printmode = true" with
it's following variables will prepare a print-ready layout of your parametered
Structures. The length of each (not printable) Threaded-Rod will be "echoed" in the
OpenSCAD-Console. They can be cut in exact that length.

Following things have to be considered while building:
- RIM-GRABBER:
- All other small holes can be drilled up to 4mm for 20mm long M4 Screws to
assemble the whole Rim-Grabber altogether.

- You have to pull a shell with the length of 10.15mm inside the two gears
The Diameter of the shell should match the size of appr. 5-5.9mm, it doesn't
have to be exact that size, tolerance to the Hole in the Gear is desirable.
You have to drill up the Hole in the Gears up to appr. 6mm too, because your
printer won't work that exactly. For Example: I used 2x 3mm² end sleeves which
fits perfectly.

There must fit a 3mm Screw inside that shell to fix these two gears together
with fewer tolerances. Be sure the screws just fix the shell with the other
two structures (cap/baseplate), not the gears! Some grease will help, too!
The two arms of the Grabber should touch in the center before mounting.
You can rotate them altogether to fix them afterwards. Just be sure they're
in the right teeth of the gear. ITS IMPORTANT THAT THESE GEARS HAVE NO
TOLERANCES TO EACH OTHER.

- The two big holes are for the Threaded Rods. They're also fixing the "cap"
on the "baseplate" with the Gears between them.

- Cut a thread into the two Grabber-Arms for M5-Screws and place some inside
them. They should look out the structure the same distance. If you failed
with assembling the Grabber-Arms correctly, you can adjust here.

ALL OTHER PARTS:
- Not much to consider, just use Nut-Traps if there are one. Washers may prevent
the plastic from damage. Locknuts on some points may help against self adjusting.
The OpenSCAD Preview with "printmode = false" may explain everything to you.


######### INFORMATION - USING #########
Consider following things before start working with this tool:
- Be sure to tighten the Axis by clamping them in with the two Impeller-Holder.

- You have to measure in your Rim first before start working on it. You're able
to rearrange the "Rim-Grabber" on the Threaded Rod for this.

- If all Threaded Rods are tightened, the whole Structures may move during work
on your rim, but they'll always move back in they're original position. The
position will stay the same even after reinserting the rim after removal.

- You'll detect the wrong position by the sound when the rim touches one of the screws.
Measuring right at the Rim-Grabber makes it easy to adjust the spokelength. Always Adjust
3 spokes before/after the one with the strongest swing to get a smoother result.
You're also be able to add a metal-plate to detect runouts of the rim. Just use the
upper two screws of the Rim-Grabber to mount one.

*/

// Parameters
$fn = 60; // Model Resolution of Round Objects
aotr = 12; //Add of Threaded Rod at the ends for Nuts and Spacers
dotn = 13; //Diameter of the Nut for the Threaded Rods (8mm Threaded-Rods need 13mm)

dbfw = 150; // Distance between feets (width) (minimum the lenght of your beared axis)
dbfl = 400; // Distance between feets (length) (see how it works out for you in the OpenSCAD-Preview)
robw = 580; // Diameter of Bike-Wheel (add some tollerances, maybe you want to calibrate different tires)

footjoint_width = 20; // Width of Global Structures (check if the Nut-Traps have enough space)
footjoint_length = 30; // Length of Global Structures
footjoint_thrededrod = 8.2; // Threaded Rod Diameter - to join the Structures together (add some tollerances)

impellerholder_angle = 70; // Degree of Impeller-Holder (leave some space on the length-side, add some "dbfl" if you have to, so you can rearrange the whole wheel if you have to)
impellerholder_width = 100; // Upper Steg Length
impellerholder_rabbetd = 20; // Depth of Rabbet of Tire-Axis (your Axis should fit in it)
impellerholder_rabbetw = 20; // Width of Rabbet of Tire-Axis (your Axis should fit in it)

rimgrabber_distance = 200; // Distance Away from the Frame (play with the distance and armlength to find a nice working position for your rim)
rimgrabber_armlength = 40; // Length of the Grabber-Arms
rimgrabber_angle = 40; // Angle of Rim-Grabber (just for Simulation)

// Print Parts / Show Mounted Structure
printmode = true;

// Print Part # (15x Parts Total)
printfeeds = false; // Print all Feeds (8x Parts)
printfeeds_sb = 10; // Distance between Feeds
printstege = false; // Print the two Stege (2x Parts)
printrimgrabber_p1 = false; // Print the Rim-Grabber - Part 1 (Gearset) (2x Parts)
printrimgrabber_p2 = false; // Print the Rim-Grabber - Part 2 (Cap) (1x Part)
printrimgrabber_p3 = true; // Print the Rim-Grabber - Part 3 (Baseplate) (1x Part)
printrimgrabber_p4 = false; // Print the Holder of the Rim-Grabber (1x Part)


// Import Catarina Mota's Helical Gears (https://www.thingiverse.com/thing:1339)
include <gears_helical.scad>;

module trod (length, rotationx, rotationy, rotationz, diameter) { // Simulated Threaded-Rod
    color ("Aqua") rotate (a=[rotationx,rotationy,rotationz]) cylinder (h = length, r = diameter/2);
}

module footjoint (width, length, threadedrod) { // Foot for the Frame of the Stand
    difference () {
        union () {
            cube ( size = [width,length,width]); // Body
            translate ([width/2,0,width]) rotate ([-90,0,0]) cylinder ( h = length, r = width/2); // Body-Top
        }
        translate ([-1,width/2,width/2]) rotate ([0,90.0]) cylinder ( h = width+2, r = threadedrod/2 ); // Threaded Rod Width
        translate ([width/2,-1,width]) rotate ([-90,0.0]) cylinder ( h = length+2, r = threadedrod/2 ); // Threaded Rod Length
    }

}

module impellerholder (width, length, threadedrod, angle, dotn) { // Feed for Steg
    nutdia = dotn/2/cos(180/6)+0.7;
    difference () {
        union () {
            translate ([-width,0,width/2]) cube ( size = [width+width/2,length,width] );
            translate ([width/2,0,width]) rotate ([-90,0,0]) cylinder ( h = length, r = width/2 );
            translate ([-width,length/2,0]) rotate ([angle,0,0]) cube ( size = [width,length*1.1,width] );
        }
        union () {
            translate ([width/2,-1,width]) rotate ([-90,0,0]) cylinder ( h = length+2, r = threadedrod/2 ); // Threaded Rod
            translate ([-width/2,length/2-((width/2)/cos(-90+angle)),0]) rotate ([-90+angle,0,0]) cylinder ( h = length*2+2, r = threadedrod/2 ); // Threaded Rod
            translate ([-width/2,length/2-((width/2)/cos(-90+angle)),0]) rotate ([-90+angle,0,0]) cylinder ($fn = 6, r = nutdia, h = 10); // Nut Trap
        }
    }
}

module impellersteg (width, length, threadedrod, steg, angle, dotn, rabbetd, rabbetw) { // Steg
    nutdia = dotn/2/cos(180/6)+0.7;
    difference () {
        union () {
            translate ([-width,width,0]) rotate ([angle,0,0]) cube ( size = [width,length,width] );
            translate ([-width,width+(cos(angle)*length)-sin(angle)*width,(sin(angle)*length)+(sin(90-angle)*width)-width]) cube ( size = [width,steg,width] );
            mirror ([0,1,0]) translate ([-width,-(width+(cos(angle)*length)-sin(angle)*width)-steg-((cos(angle)*length)-sin(angle)*width),0]) rotate ([angle,0,0]) cube ( size = [width,length,width] );
            translate ([-width,width+(cos(angle)*length)-sin(angle)*width+steg/2-rabbetw/2-3,(sin(angle)*length)+(sin(90-angle)*width)+rabbetd/2]) rotate ([0,90,0]) linear_extrude ( height = width, convexity = 10) polygon (points = [[0,rabbetw+6],[0,0],[rabbetd,-1],[rabbetd,rabbetw+7]], paths = [[0,1,2,3]]); // Rabbet
        }
        union () {
            translate ([-width/2,width-((width/2)/cos(-90+angle)),0]) rotate ([-90+angle,0,0]) cylinder ( h = length*2+2, r = threadedrod/2 ); // Threaded Rod
            translate ([-width/2,width/2+cos(angle)*length,sin(angle)*length]) rotate ([-90+angle,0,0]) cylinder ($fn = 6, r = nutdia, h = 30);
            mirror ([0,1,0]) translate ([-width/2,-(width+(cos(angle)*length)-sin(angle)*width)-steg-((cos(angle)*length)-sin(angle)*width)-((width/2)/cos(-90+angle)),0]) rotate ([-90+angle,0,0]) cylinder ( h = length*2+2, r = threadedrod/2 ); // Threaded Rod
            mirror ([0,1,0]) translate ([-width/2,-(width+(cos(angle)*length)-sin(angle)*width)-steg-((cos(angle)*length)-sin(angle)*width)+cos(angle)*length-width/2,sin(angle)*length]) rotate ([-90+angle,0,0]) cylinder ($fn = 6, r = nutdia, h = 30);
            translate ([-width-1,width+(cos(angle)*length)-sin(angle)*width+steg/2-rabbetw/2,(sin(angle)*length)+(sin(90-angle)*width)+rabbetd/2+1]) rotate ([0,90,0]) linear_extrude ( height = width+2, convexity = 10) polygon (points = [[0,rabbetw],[0,0],[rabbetd+1,rabbetw/2]], paths = [[0,1,2]]); // Rabbet
        }
    }
}

module rimgrabber_holder (width, threadedrod, dotn) { // Structure to Set the Rim-Grabber in Place
    nutdia = dotn/2/cos(180/6)+0.7;
    difference () {
        union () {
            translate ([0,width/2,width/2]) rotate ([0,90,0]) cylinder ( h = 47, r = width/2 );
            translate ([0,-30,0]) cube ( size = [17,40,width] );
            translate ([30,-30,0]) cube ( size = [17,40,width] );
        }
        union () {
            translate ([-1,width/2,width/2]) rotate ([0,90,0]) cylinder ( h = 47+2, r = threadedrod/2 );
            translate ([15/2+1,width/2,width/2]) rotate ([90,0,0]) cylinder ( h = 40+1, r = threadedrod/2 );
            translate ([31+15/2,width/2,width/2]) rotate ([90,0,0]) cylinder ( h = 40+1, r = threadedrod/2 );
            translate ([31+15/2,-10,width/2]) rotate ([90,30,180]) cylinder ($fn = 6, r = nutdia, h = 10);
            translate ([31+15/2-dotn/2,-10,width/2]) cube ( size = [dotn, 10, width] );
            translate ([15/2+1,-10,width/2]) rotate ([90,30,180]) cylinder ($fn = 6, r = nutdia, h = 10);
            translate ([15/2+1-dotn/2,-10,width/2]) cube ( size = [dotn, 10, width] );
        }
    }
}

module rimgrabber (length, rotateing) { // Arm of one Rim-Grabber
    difference () {
        translate ([45/4,45/2-6,-5]) linear_extrude ( height = 10, convexity = 10) polygon (points = [[0,length],[0,0],[45/2,0],[10,length*0.6],[10,length]], paths = [[0,1,2,3,4]]);
        union () {
            translate ([10,45/4+length,0]) rotate ([0,90,0]) cylinder ( h = 15, r = 2 );
        }
    }
    if (rotateing) { // Rotate the Gear to "Gear-Up" to another
        translate ([45/2+1,0]) rotate ([0,0,(360*2)/(3.141592653589793238*41)]) gear();
    } else {
        translate ([45/2+1,0]) gear();
    }
}

module rimgrabber_structure (length, showpart) { // Whole Rim-Grabber combined as Structure
    if (!showpart || showpart == 1) { // Replace the two Gears in "printmode"
        if (showpart == 1) {
            translate ([10,0,0]) rimgrabber (length, false);
        } else {
            rimgrabber (length, false);
        }
        rotate([0,0,180]) mirror ([0,1,0]) rimgrabber (length, true);
    }
    difference () {
        union () {
            if (!showpart || showpart == 2) {
                translate ([-45/2,0,5]) linear_extrude ( height = 2, convexity = 10) polygon (points = [[0,45/2+6.5],[-10,0],[0,-45],[45,-45],[45+10,0],[45,45/2+6.5]], paths = [[0,1,2,3,4,5]]); // Cap
            }
            if (!showpart || showpart == 3) {
                translate ([-45/2,0,-5-2]) linear_extrude ( height = 2, convexity = 10) polygon (points = [[0,45/2+6.5],[-10,0],[0,-45],[45,-45],[45+10,0],[45,45/2+6.5]], paths = [[0,1,2,3,4,5]]); // Baseplate
                translate ([0,15,-5]) linear_extrude ( height = 10.15, convexity = 10) polygon (points = [[0,0],[10,9],[10,14],[-10,14],[-10,9]], paths = [[0,1,2,3,4]]); // Connection-Block
                translate ([-22.5,-45,-5]) cube ( size = [45,15,10.15] ); // Connection-Block
            }
        }
        union () {
            if (!showpart || showpart == 2 || showpart == 3) {
                translate ([-6,45/2+2,-5-2-1]) cylinder ( h = 10+2*2+2, r = 2 ); // Mounting Hole / Height Impact Signaling
                translate ([6,45/2+2,-5-2-1]) cylinder ( h = 10+2*2+2, r = 2 ); // Mounting Hole / Height Impact Signaling

                translate ([-15,-36.5,-5-2-1]) cylinder ( h = 10+2+2+2, r = 8.2/2 ); // Threaded Rod Hole for Holder
                translate ([15,-36.5,-5-2-1]) cylinder ( h = 10+2+2+2, r = 8.2/2 ); // Threaded Rod Hole for Holder

                translate ([-45/2-1,0,-5-2-1]) cylinder ( h = 10+2*2+2, r = 2 ); // left Gear - Hole
                translate ([45/2+1,0,-5-2-1]) cylinder ( h = 10+2*2+2, r = 2 ); // right Gear - Hole
            }
        }
    }
}

heightcalc = (tan(90-impellerholder_angle)*(robw/2))+footjoint_width/2+(tan(90-impellerholder_angle)*footjoint_length)+footjoint_length*2; // Precalc Lenght of Rim-Grabber Threaded-Rods

if (!printmode) { // Show all Parts Mounted to Preview
    // Frame
    footjoint (footjoint_width, footjoint_length, footjoint_thrededrod);
    translate ([footjoint_width+dbfw, 0, 0]) footjoint (footjoint_width, footjoint_length, footjoint_thrededrod);
    translate ([0, footjoint_length*2+dbfl, 0])  mirror ([0,1,0]) footjoint (footjoint_width, footjoint_length, footjoint_thrededrod);
    translate ([footjoint_width+dbfw, footjoint_length*2+dbfl, 0]) mirror ([0,1,0]) footjoint (footjoint_width, footjoint_length, footjoint_thrededrod);

    // Impeller-Holder Feeds
    translate ([0,footjoint_length+dbfl/2-impellerholder_width/2-(tan(90-impellerholder_angle)*(robw/2))+footjoint_width/4-(tan(90-impellerholder_angle)*footjoint_length),0]) impellerholder (footjoint_width, footjoint_length, footjoint_thrededrod, impellerholder_angle, dotn);
    translate ([0,footjoint_length+dbfl/2+impellerholder_width/2+(tan(90-impellerholder_angle)*(robw/2))-footjoint_width/4+(tan(90-impellerholder_angle)*footjoint_length),0]) mirror ([0,1,0]) impellerholder (footjoint_width, footjoint_length, footjoint_thrededrod, impellerholder_angle, dotn);
    translate ([footjoint_width*2+dbfw,footjoint_length+dbfl/2-impellerholder_width/2-(tan(90-impellerholder_angle)*(robw/2))+footjoint_width/4-(tan(90-impellerholder_angle)*footjoint_length),0]) mirror ([0,1,0]) rotate ([0,0,180]) impellerholder (footjoint_width, footjoint_length, footjoint_thrededrod, impellerholder_angle, dotn);
    translate ([footjoint_width*2+dbfw,footjoint_length+dbfl/2+impellerholder_width/2+(tan(90-impellerholder_angle)*(robw/2))-footjoint_width/4+(tan(90-impellerholder_angle)*footjoint_length),0])  rotate ([0,0,180]) impellerholder (footjoint_width, footjoint_length, footjoint_thrededrod, impellerholder_angle, dotn);

    // Steg
    translate ([0,footjoint_length+dbfl/2-impellerholder_width/2-(tan(90-impellerholder_angle)*footjoint_length),robw/2]) impellersteg (footjoint_width, footjoint_length, footjoint_thrededrod, impellerholder_width, impellerholder_angle, dotn, impellerholder_rabbetd, impellerholder_rabbetw);
    translate ([footjoint_width*3+dbfw,footjoint_length+dbfl/2-impellerholder_width/2-(tan(90-impellerholder_angle)*footjoint_length),robw/2]) impellersteg (footjoint_width, footjoint_length, footjoint_thrededrod, impellerholder_width, impellerholder_angle, dotn, impellerholder_rabbetd, impellerholder_rabbetw);

    // Rods - Length
    translate ([footjoint_width/2,-aotr,footjoint_width]) trod (dbfl+2*footjoint_length+2*aotr, -90, 0, 0, footjoint_thrededrod);
    translate ([dbfw+footjoint_width*1.5,-aotr,footjoint_width]) trod (dbfl+2*footjoint_length+2*aotr, -90, 0, 0, footjoint_thrededrod);

    // Rods - Width
    translate ([-aotr,footjoint_width/2,footjoint_width/2]) trod (dbfw+2*footjoint_width+2*aotr, 0, 90, 0, footjoint_thrededrod);
    translate ([-aotr,dbfl+footjoint_length*2-footjoint_width/2,footjoint_width/2]) trod (dbfw+2*footjoint_width+2*aotr, 0, 90, 0, footjoint_thrededrod);

    // Rods - Impeller-Holder

    translate ([-footjoint_width/2,footjoint_length+dbfl/2-impellerholder_width/2-(tan(90-impellerholder_angle)*(robw/2))+footjoint_width/2-(tan(90-impellerholder_angle)*footjoint_length),0]) trod (sqrt(heightcalc*heightcalc+robw/2*robw/2), -90+impellerholder_angle, 0, 0, footjoint_thrededrod);
    translate ([-footjoint_width/2,footjoint_length+dbfl/2+impellerholder_width/2+(tan(90-impellerholder_angle)*(robw/2))-footjoint_width/2+(tan(90-impellerholder_angle)*footjoint_length),0]) trod (sqrt(heightcalc*heightcalc+robw/2*robw/2), -270-impellerholder_angle, 0, 0, footjoint_thrededrod);
    translate ([footjoint_width/2+footjoint_width*2+dbfw,footjoint_length+dbfl/2-impellerholder_width/2-(tan(90-impellerholder_angle)*(robw/2))+footjoint_width/2-(tan(90-impellerholder_angle)*footjoint_length),0]) trod (sqrt(heightcalc*heightcalc+robw/2*robw/2), -90+impellerholder_angle, 0, 0, footjoint_thrededrod);
    translate ([footjoint_width/2+footjoint_width*2+dbfw,footjoint_length+dbfl/2+impellerholder_width/2+(tan(90-impellerholder_angle)*(robw/2))-footjoint_width/2+(tan(90-impellerholder_angle)*footjoint_length),0]) trod (sqrt(heightcalc*heightcalc+robw/2*robw/2), -270-impellerholder_angle, 0, 0, footjoint_thrededrod);

    // Rods/Structure - Rimgrabber
    translate ([0,0,rimgrabber_angle/90*footjoint_width]) rotate ([-rimgrabber_angle,0,0]) {
        translate ([footjoint_width+dbfw/2-47/2+17/2,footjoint_width/4, footjoint_width/2]) trod (rimgrabber_distance, 90, 0, 0, footjoint_thrededrod);
        translate ([footjoint_width+dbfw/2-47/2+17/2+30,footjoint_width/4, footjoint_width/2]) trod (rimgrabber_distance, 90, 0, 0, footjoint_thrededrod);
        translate ([footjoint_width+dbfw/2-47/2+47/2,-rimgrabber_distance+10+2+aotr,46.5]) rotate ([90,0,0]) rimgrabber_structure(rimgrabber_armlength, false);
        translate ([footjoint_width+dbfw/2-47/2,0,0]) rimgrabber_holder (footjoint_width, footjoint_thrededrod, dotn);
    }

    // Simulated Rim
    color ("grey") difference () {
        translate ([footjoint_width+dbfw/2-27/2,footjoint_length+dbfl/2,robw/2+footjoint_length]) rotate ([0,90,0]) cylinder ( h = 27, r = robw/2 );
        translate ([footjoint_width+dbfw/2-27/2-1,footjoint_length+dbfl/2,robw/2+footjoint_length]) rotate ([0,90,0]) cylinder ( h = 27+2, r = robw/2-15 );
    }

} else { // Show all Structures ready to Print
    if (printfeeds) { // Place and rotate Feed-Structures ready to print
        footjoint (footjoint_width, footjoint_length, footjoint_thrededrod);
        translate ([footjoint_width+printfeeds_sb, 0, 0]) footjoint (footjoint_width, footjoint_length, footjoint_thrededrod);
        translate ([0, footjoint_length*2+printfeeds_sb, 0])  mirror ([0,1,0]) footjoint (footjoint_width, footjoint_length, footjoint_thrededrod);
        translate ([footjoint_width+printfeeds_sb, footjoint_length*2+printfeeds_sb, 0]) mirror ([0,1,0]) footjoint (footjoint_width, footjoint_length, footjoint_thrededrod);

        translate ([-printfeeds_sb,0,footjoint_width]) rotate ([0,-90,0]) impellerholder (footjoint_width, footjoint_length, footjoint_thrededrod, impellerholder_angle, dotn);
        translate ([-printfeeds_sb,footjoint_length*2+printfeeds_sb,footjoint_width]) rotate ([0,-90,0]) mirror ([0,1,0]) impellerholder (footjoint_width, footjoint_length, footjoint_thrededrod, impellerholder_angle, dotn);
        translate ([-printfeeds_sb-footjoint_length,footjoint_length*2+printfeeds_sb*2,footjoint_width]) mirror ([0,1,0]) rotate ([0,-90,180]) impellerholder (footjoint_width, footjoint_length, footjoint_thrededrod, impellerholder_angle, dotn);
        translate ([printfeeds_sb,footjoint_length*3+printfeeds_sb*2,footjoint_width])  rotate ([0,-90,180]) impellerholder (footjoint_width, footjoint_length, footjoint_thrededrod, impellerholder_angle, dotn);
    }

    if (printstege) { // Place and rotate the Stege
        rotate ([0,90,0]) impellersteg (footjoint_width, footjoint_length, footjoint_thrededrod, impellerholder_width, impellerholder_angle, dotn, impellerholder_rabbetd, impellerholder_rabbetw);
        translate ([-10,0,footjoint_width]) rotate ([0,-90,0]) impellersteg (footjoint_width, footjoint_length, footjoint_thrededrod, impellerholder_width, impellerholder_angle, dotn, impellerholder_rabbetd, impellerholder_rabbetw);
    }

    if (printrimgrabber_p1) { // Place the Rim-Grabber - Part 1
        rimgrabber_structure(rimgrabber_armlength, 1);
    }
    if (printrimgrabber_p2) { // Place the Rim-Grabber - Part 2
        rimgrabber_structure(rimgrabber_armlength, 2);
    }
    if (printrimgrabber_p3) { // Place the Rim-Grabber - Part 3
        rimgrabber_structure(rimgrabber_armlength, 3);
    }
    if (printrimgrabber_p4) { // Place the Rim-Grabber - Part 4
        rimgrabber_holder (footjoint_width, footjoint_thrededrod, dotn);
    }

}

//Information Echos in Render-Terminal
echo ("################# SIZES OF UNPRINTABLE OBJECTS #################");
echo ("##################### (all sizes in mm/each) #####################");
echo ();
  //Threaded Rods
    //Groundframe
    echo ("##### THREADED RODS - GROUNFRAME #####");
    echo ("Pieces: 2, Width-Side of Groundframe-Rods", dbfw+2*footjoint_width+2*aotr);
    echo ("Pieces: 2, Length-Side of Groundframe-Rods", dbfl+2*footjoint_length+2*aotr);
    //Workpiece Clamp
    echo ();
    echo ("##### THREADED RODS - IMPELLER-HOLDER #####");
    echo ("Pieces: 4, Holds the Impeller in it's Place", sqrt(heightcalc*heightcalc+robw/2*robw/2));

    //Spindle Rods
    echo ();
    echo ("##### THREADED RODS - RIM-GRABBER #####");
    echo ("Pieces: 2, Holds the Adjustment-Tool in it's Place", rimgrabber_distance);
    echo ();
