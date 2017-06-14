# Centering-Stand-for-Bicycle
Zentrierständer für Fahrrad-Laufräder / Centering-Stand for Bicycle-Impeller

Fully parametric with OpenSCAD
Thingiverse-Link (https://www.thingiverse.com/thing:2385150)
Helical Gear by Catarina Mota (https://www.thingiverse.com/thing:1339)

# INFORMATION - CONSTRUCTING 
Add the Parameters to fit the size of your wheel. You can be clumsy with that,
because the turquoise colored rods in the OpenScad-Preview are threaded-rods
and can be easily adjusted to your needed distances. Because of that, better
give some more than having to less at the end.

The variable "printmode" help you switch between OpenSCAD-Preview and Printmode.
The Preview shows your Adjustments on the Parameters. The "printmode = true" with
it's following variables will prepare a print-ready layout of your parametered
Structures. The length of each (not printable) Threaded-Rod will be "echoed" in the
OpenSCAD-Console. They can be cut in exact that length.

following things have to be considered while building:
- RIM-GRABBER:
    - All other small holes can be drilled up to 4mm for 20mm long M4 Screws to
      assemble the whole Rim-Grabber altogether.

    - You have to pull a shell with the length of 10.15mm inside the two gears
      The Diameter of the shell should match the size of appr. 5-5.9mm, it don't
      have to be exact that size, tolerance to the Hole in the Gear is desirable.
      You have to drill up the Hole in the Gears up to appr. 6mm too, because your
      printer wont work that exactly. For Example: I used 2x 3mm² end sleeves which
      fits perfectly.

      There must fit a 3mm Screw inside that shell to fix these two gears together
      with less tolerances. Be sure the screws just fix the shell with the other
      two structures (cap/baseplate), not the gears! Some grease will help, too!
      The two arms of the Grabber should touch in the center before mounting.
      You can rotate them altogether to fix them afterwards. Just be sure they're
      in the right tooths of the gear. ITS IMPORTANT THAT THESE GEARS HAVE NO
      TOLERANCES TO EACH OTHER.

    - The two big holes are for the Threaded Rods. They're also fixing the "cap"
      on the "baseplate" with the Gears between them. 

    - Cut a thread into the two Grabber-Arms for M5-Screws and place some inside
      them. They should look out the structure the same distance. If you failed
      with assembling the Grabber-Arms correctly, you can adjust here.

- ALL OTHER PARTS:
    - Not much to consider, just use Nut-Traps if there are one. Washers may prevent
      the plastic from damage. Locknuts on some points may help against self adjusting.
      The OpenSCAD Preview with "printmode = false" may explain everything to you.

# INFORMATION - USING
Consider following things before start working with this tool:
- Be sure to tighten the Axis by clamping them in with the two Impeller-Holder.

- You have to measure in your Rim first before start working on it. You're able
to rearrange the "Rim-Grabber" on the Threaded Rod for this.

- If all Threaded Rods are tightened, the whole Structures may move during work
on your rim, but they'll always move back in they're original position.
