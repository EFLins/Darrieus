//Script

n  = 100; // points on upper/lower surface of airfoil used to define airfoil
         // These points may not appear in the mesh.

alpha = 120/180*Pi;
Rin = 1;
R   = 5;
Rou = 9;

lc1 = 0.10; 
lc2 = 0.001; // characteristic lengths of elements on airfoil and at farfield
lc3 = 0.1; //characteristic length for the inetrmediate domain
m = 2*n - 2; // total number of points on airfoil without repetition
             // LE and TE points are common to upper/lower surface

nle = n; // point number of LE = no. of points on upper surface
         // Point(1) is trailing edge

// NACA0012 profile: formula taken from 

// put points on upper surface of airfoil
For i In {1:n}
   theta = Pi * (i-1) / (n-1);
   x = 0.5 * (Cos(theta) + 1.0);
   x2 = x * x;
   x3 = x * x2;
   x4 = x * x3;
   y = 0.594689181*(0.298222773*Sqrt(x)- 0.127125232*x - 0.357907906*x2 + 0.291984971*x3 - 0.105174606*x4);
         
   xx[i] = x ;
   yy[i] = y ;
   xx[2*n-i+1] = x;
   yy[2*n-i+1] = -y;
   Printf("Points: %g  %g",x,y);
EndFor

// put points on upper surface of airfoil
XC = -0.5;
YC = Sqrt(R*R - XC*XC);
For i In {1:n}
   Point(i) = {xx[i]+XC, yy[i]+YC, 0.0, lc2};
EndFor
// put points on lower surface of airfoil
For i In {n+1:m+1}
   Point(i) = {xx[i]+XC, yy[i]+YC, 0.0, lc2};
EndFor

Spline(1) = {1:n}; Spline(2) = {n:m,1};

Transfinite Line{1,2} = n Using Bump 0.2;

Point(1000) = { 0.0, 0.0, 0.0, lc1};
Point(1005) = { -Rin*Cos(alpha/2), Rin*Sin(alpha/2), 0.0, lc1};
Point(1006) = {  Rin*Cos(alpha/2), Rin*Sin(alpha/2), 0.0, lc1};
Point(1003) = { -R*Cos(alpha/2), R*Sin(alpha/2), 0.0, lc1};
Point(1004) = {  R*Cos(alpha/2), R*Sin(alpha/2), 0.0, lc1};
Point(1007) = { -Rou*Cos(alpha/2), Rou*Sin(alpha/2), 0.0, lc1};
Point(1008) = {  Rou*Cos(alpha/2), Rou*Sin(alpha/2), 0.0, lc1};

Circle(3) = {1005, 1000, 1006};
Circle(4) = {1003, 1000,    n};
Circle(5) = {   1, 1000, 1004};
Circle(6) = {1007, 1000, 1008};

Line(7) = {1005,1003};
Line(8) = {1006,1004};
Line(9) = {1003,1007};
Line(10) = {1004,1008};

Curve Loop(4) = {7, 4, 2, 5, -8, -3};
Curve Loop(5) = {4, -1, 5, 10, -6, -9};

Plane Surface(5) = {4};
Plane Surface(6) = {5};

//Define Boundary Layer
Field[1] = BoundaryLayer;
Field[1].EdgesList = {1,2};
Field[1].AnisoMax = 1.0;
Field[1].FanNodesList = {1};
Field[1].hfar = 0.01;
Field[1].hwall_n = 0.001;
Field[1].thickness = 0.05;
Field[1].ratio = 1.1;
Field[1].Quads = 1;
Field[1].IntersectMetrics = 1;
BoundaryLayer Field = 1;

Transfinite Line {4} = 50 Using Progression 1;