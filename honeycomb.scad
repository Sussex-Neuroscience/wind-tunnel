//outer diameter of the acrylic tube
tunnelOD = 180; 

//inner diameter of the acrylic tube
tunnelID = 174;//tunnelOD-2;

//height of the tube fitting
tunnelFH = 20;

//height of piece between fan and tunnel
fanBridge = 50;

//height of fan fitting
fanFH = 40;
//fan outer diameter
fanOD = 120;
fanID = 110;
//thickness of inner plate
plateT = 20;
//boarder around inner plate
plateBorder = 20;
//plate 
plateD = tunnelID-plateBorder;//176;//174


//diameter of each honeycombhole
combD=20;
//distance between two holes
interComb=4;
//number of sides on each honeycomb hole
combS = 6;
nCombs = round((plateD)/combD);
tol = 0.1;




$fn=40;


module honeycomb_grid(){
    difference(){
        cylinder(d=tunnelID,h=plateT);
        
    intersection(){
        translate([0,0,-1]){
        cylinder(d=plateD,h=plateT+3);
        }//end translate
        translate([-(plateD-combD)/2,-(plateD+combD)/2,-1]){
    union(){
   for ( y = [-1:1:nCombs+1] ){
for ( x = [-1:1:nCombs+1] ){
    //echo(x);
    if (x%2==0){
    translate([(combD-interComb)*x,combD*y,-1]){
    cylinder(d=combD,h=plateT+5, $fn=combS);
    }//end translate
    }//end if 
    else{
        translate([(combD-interComb)*x,combD/2+combD*y,-1]){
    cylinder(d=combD,h=plateT+5, $fn=combS);
    }//end translate
}//end else
}//end for x
}//end y
}//union
}//end translate
}//end intersection
}//end difference
}//end module


module tunnel_fit(){
    difference(){
        
    cylinder(d=tunnelOD,h=tunnelFH+plateT);
        translate([0,0,-1]){
        cylinder(d=tunnelID,h=tunnelFH+plateT+2);
        }//end translate
    }//end difference

    }//end module

module base_plate(){
    difference(){
        translate([-tunnelOD/2,0,0]){
    cube([tunnelOD,tunnelOD/2,tunnelFH+plateT]);
    }//end translate
    translate([0,0,-1]){
     cylinder(d=tunnelOD,h=tunnelFH+plateT+2);
    }
}//end difference
    }//end module

module fan_fit(){
        difference(){
    
    union(){
    cylinder(d=tunnelOD,h=tunnelFH+plateT);
    translate([0,0,tunnelFH+plateT-0.1]){
    cylinder(d1=tunnelOD,d2=fanOD,h=fanBridge);
    }//end translate
    translate([0,0,tunnelFH+plateT-0.1+fanBridge]){
    cylinder(d=fanOD,h=fanFH);   
    } //end translate
}//end union
    
    union(){
        translate([0,0,-2.1]){
    cylinder(d=tunnelID,h=tunnelFH+plateT+2);
        }
    translate([0,0,tunnelFH+plateT-0.1-1]){
    cylinder(d1=tunnelID,d2=fanID,h=fanBridge+2);
    }//end translate
    translate([0,0,tunnelFH+plateT-0.1+fanBridge-1]){
    cylinder(d=fanID,h=fanFH+2);   
    } //end translate
}//end union

    }//end difference
    
    }//end module

honeycomb_grid();  
tunnel_fit();
base_plate();


translate([200,0,0]){
honeycomb_grid();  
fan_fit();
base_plate();
}//end translate
