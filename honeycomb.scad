plateT = 40;
plateD = 125;

combD=5;
interComb=2;

tol = 0.1;

$fn=30;

difference(){
    cylinder(d=plateD,h=plateT);
    union(){
        for ( y = [-plateD/2 : combD+interComb : plateD/2] ){
            for ( x = [-plateD/2 : combD+interComb : plateD/2] ){
    
                translate([x, y, -1]){
                    cylinder(d=combD,h=plateT+2, $fn=6);
                }//translate
            }//end for x
        }//end for y
    }//end union
}