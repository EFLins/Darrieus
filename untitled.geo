// Gmsh project created on Wed Dec 23 22:19:06 2020
SetFactory("OpenCASCADE");
//+
Box(1) = {-6.5, -1.5, 0, 0.1, 0.1, 0.1};
//+
Characteristic Length {3, 1, 5, 7, 8, 6, 2, 4} = 0.001;
//+
Transfinite Surface {3} = {5, 6, 2, 1};
//+
Transfinite Surface {6} = {1, 3, 7, 5};
//+
Transfinite Surface {1} = {3, 1, 2, 4};
//+
Transfinite Surface {4} = {3, 4, 8, 7};
//+
Transfinite Surface {5} = {4, 2, 6, 8};
//+
Transfinite Surface {2} = {8, 6, 5, 7};
//+
Transfinite Volume{1} = {5, 1, 3, 7, 6, 2, 4, 8};
