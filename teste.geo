//Define Foil Coordinates (160pts)
lc = 0.01;


//Define bounding box corners
Point(2001) = { 1.500000, 0.250000, 0.0000000, 0.01};
Point(2002) = { 1.500000, -0.150000, 0.0000000, 0.01};
Point(2003) = { -0.1500000, -0.150000, 0.0000000, 0.01};
Point(2004) = { -0.1500000, 0.250000, 0.0000000, 0.01};


//Define bounding box edges
Line(1) = {2001, 2002};
Line(2) = {2002, 2003};
Line(3) = {2003, 2004};
Line(4) = {2004, 2001};

//Define bounding box2 corners
Point(3001) = { 4.500000, 1.500000, 0.0000000, 0.1};
Point(3002) = { 4.500000, -1.500000, 0.0000000, 0.1};
Point(3003) = { -1.500000, -1.500000, 0.0000000, 0.1};
Point(3004) = { -1.500000, 1.500000, 0.0000000, 0.1};

//Define bounding box2 edges
Line(5) = {3001, 3002};
Line(6) = {3002, 3003};
Line(7) = {3003, 3004};
Line(8) = {3004, 3001};

//Define bounding box outer boundary
Line Loop(101) = {1:4};

//Define bounding box2 outer boundary
Line Loop(102) = {5, 6, 7, 8};


//Define unstructured far field mesh zone
Plane Surface(201) = {101, 102};

