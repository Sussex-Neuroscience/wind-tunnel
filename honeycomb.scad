use <threadlib/threadlib.scad>

//outer diameter of the acrylic tube
tunnelOD = 185; 
tunnelODedge = tunnelOD+5;
//inner diameter of the acrylic tube
tunnelID = 174;//tunnelOD-2;

//height of the tube fitting
tunnelFH = 40;//20;

//height of piece between fan and tunnel
fanBridge = 50;

//height of fan fitting
fanFH = 20;//40;
//fan outer diameter
fanOD = 124.2;
//fan inner diameter
fanID = 122;
//thickness of inner plate
plateT = 1;
//boarder around inner plate
plateBorder = 20;
//plate 
plateD = tunnelOD-plateBorder;//176;//174


//diameter of each honeycombhole
combD=10;
//distance between two holes
interComb=4;
//number of sides on each honeycomb hole
combS = 4;
nCombs = round((plateD)/(combD-interComb));
tol = 0.1;




$fn=60;


module honeycomb_grid_hex(){
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

module honeycomb_grid_cub(){
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
    //if (x%2==0){
    translate([(combD-interComb)*x,(combD-interComb)*y,-1]){
    cube([combD/2,combD/2,plateT+5]);
    }//end translate
    //}//end if 
    //else{
    //    translate([(combD-interComb)*x,combD/2+combD*y,-1]){
    //cylinder(d=combD,h=plateT+5, $fn=combS);
    //}//end translate
//}//end else
}//end for x
}//end y
}//union
}//end translate
}//end intersection
}//end difference
}//end module

module tunnel_fit(){
    difference(){
        
    cylinder(d=tunnelODedge,h=tunnelFH+plateT);
        translate([0,0,-1]){
        cylinder(d=tunnelOD+2*tol,h=tunnelFH+plateT+2);
        }//end translate
        translate([tunnelOD/2,0,tunnelFH/2]){
rotate([0,90,0]){
tap("M6",turns=2);
}//end rotate
}//end translate

        translate([-tunnelOD/2,0,tunnelFH/2]){
rotate([0,-90,0]){
tap("M6",turns=2);
}//end rotate
}//end translate
        translate([0,-tunnelOD/2,tunnelFH/2]){
rotate([90,0,0]){
tap("M6",turns=2);
}//end rotate
}//end translate

        translate([0,tunnelOD/2,tunnelFH/2]){
rotate([-90,0,0]){
tap("M6",turns=2);
}//end rotate
}//end translate
        translate([-15,-tunnelODedge/2-5,-2]){
        //cube([30,30,tunnelFH+plateT+20]);
    }//end translate
    }//end difference

    }//end module

module base_plate(){
    difference(){
        translate([-tunnelODedge/2,0,0]){
    cube([tunnelODedge,tunnelODedge/2,tunnelFH+plateT]);
    }//end translate
        
    translate([0,0,-1]){
     cylinder(d=tunnelODedge,h=tunnelFH+plateT+2);
       
   //     translate([tunnelOD/2-25,tunnelOD/2-20,-10]){
    //cube([20,15,tunnelFH+plateT+20]);
    //    }//end translate
    //        translate([-tunnelOD/2+5,tunnelOD/2-20,-10]){
    //cube([20,15,tunnelFH+plateT+20]);
    //    }//end translate
 }//end translate
    
    
}//end difference
    }//end module

module fan_fit(){
        difference(){
    
    union(){
    //cylinder(d=tunnelOD,h=tunnelFH+plateT);
    tunnel_fit();
    translate([0,0,tunnelFH+plateT-0.1]){
    cylinder(d1=tunnelODedge,d2=fanOD+3.2,h=fanBridge);
    }//end translate
    translate([0,0,tunnelFH+plateT-0.1+fanBridge]){
    cylinder(d=fanOD+3+2*tol,h=fanFH);   
    } //end translate
}//end union
    
    union(){
        translate([0,0,-2.1]){
    cylinder(d=tunnelID,h=tunnelFH+plateT+2);
        }
    translate([0,0,tunnelFH+plateT-0.1-1]){
    cylinder(d1=tunnelOD,d2=fanID,h=fanBridge+2);
    }//end translate
    translate([0,0,tunnelFH+plateT-0.1+fanBridge-1]){
    cylinder(d=fanOD+2*tol,h=fanFH+2);   
    } //end translate
}//end union

    }//end difference
    
    }//end module

//honeycomb_grid_hex();  
//honeycomb_grid_cub();  
//tunnel_fit();
//base_plate();

translate([200,0,0]){
//honeycomb_grid();  
fan_fit();
//base_plate();
}//end translate
