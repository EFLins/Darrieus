clear;
close all;
clc;
p1=[  1.000000  0.000000
  0.998380  0.001260
  0.994170  0.004940
  0.988250  0.010370
  0.980750  0.016460
  0.971110  0.022500
  0.958840  0.028530
  0.943890  0.034760
  0.926390  0.041160
  0.906410  0.047680
  0.884060  0.054270
  0.859470  0.060890
  0.832770  0.067490
  0.804120  0.074020
  0.773690  0.080440
  0.741660  0.086710
  0.708230  0.092770
  0.673600  0.098590
  0.637980  0.104120
  0.601580  0.109350
  0.564650  0.114250
  0.527440  0.118810
  0.490250  0.123030
  0.453400  0.126830
  0.417210  0.130110
  0.381930  0.132710
  0.347770  0.134470
  0.314880  0.135260
  0.283470  0.135050
  0.253700  0.133460
  0.225410  0.130370
  0.198460  0.125940
  0.172860  0.120260
  0.148630  0.113550
  0.125910  0.105980
  0.104820  0.097700
  0.085450  0.088790
  0.067890  0.079400
  0.052230  0.069650
  0.038550  0.059680
  0.026940  0.049660
  0.017550  0.039610
  0.010280  0.029540
  0.004950  0.019690
0.00  0.0];

p2=[0.00  0.0
  0.000440 -0.005610
  0.002640 -0.011200
  0.007890 -0.014270
  0.017180 -0.015500
  0.030060 -0.015840
  0.046270 -0.015320
  0.065610 -0.014040
  0.087870 -0.012020
  0.112820 -0.009250
  0.140200 -0.005630
  0.170060 -0.000750
  0.202780  0.005350
  0.238400  0.012130
  0.276730  0.019280
  0.317500  0.026520
  0.360440  0.033580
  0.405190  0.040210
  0.451390  0.046180
  0.498600  0.051290
  0.546390  0.055340
  0.594280  0.058200
  0.641760  0.059760
  0.688320  0.059940
  0.733440  0.058720
  0.776600  0.056120
  0.817290  0.052190
  0.855000  0.047060
  0.889280  0.040880
  0.919660  0.033870
  0.945730  0.026240
  0.966930  0.018220
  0.982550  0.010600
  0.992680  0.004680
  0.998250  0.001150
  1.000000  0.000000];
x1  = p1(:,1);
y1  = p1(:,2);

x2  = p2(:,1);
y2  = p2(:,2);
nx= 100;
r=2;
theta=linspace(90,180,nx); 
map = linspace(1,1.5,nx);
x3= 1+r.*map.*cosd(theta);
y3=r.*sind(theta);

map = linspace(1.5,1,nx);
x4=1+r*map.*cosd(theta+90);
y4=r*sind(theta+90);


x5=linspace(1,1,50);
y5=linspace(0,4,50);

x6=linspace(1,1,50);
y6=linspace(0,-4,50);

x7=linspace(-r,0,50);
y7=linspace(0,0,50);

x8=linspace(x3(floor(length(x3)/2)),x1(floor(length(x1)/2)),50);
y8=linspace(y3(end/2),y1(floor(length(y1)/2)),50);

x8=linspace(x3(floor(length(x3)/2)),x1(floor(length(x1)/1.5)+3),50);
y8=linspace(y3(floor(length(x3)/2)),y1(floor(length(x1)/1.5)+3),50);


x9=linspace(x4(floor(length(x4)/2)),x2(floor(length(x2)/3)-1),50);
y9=linspace(y4(floor(length(x4)/2)),y2(floor(length(x2)/3)-1),50);

x10=linspace(1,-4,50);
y10=linspace(4,4,50);

x11=linspace(1,-4,50);
y11=linspace(-4,-4,50);

x12=linspace(4,1,50);
y12=linspace(4,4,50);

x13=linspace(4,1,50);
y13=linspace(-4,-4,50);

x14=linspace(-4,-4,50);
y14=linspace(-4,4,50);

x15=linspace(4,4,50);
y15=linspace(-4,4,50);

x16=linspace(-r,-4,50);
y16=linspace(0,0,50);

x17=linspace(4,1,50);
y17=linspace(0,0,50);

plot(x1,y1,x2,y2,'.',x3,y3,x4,y4,x5,y5,x6,y6,x7,y7,x8,y8,x9,y9,'o',x10,y10,x11,y11,x12,y12,x13,y13,'--',x14,y14,x15,y15,x16,y16,'*',x17,y17,'LineWidth',2)
legend('x1','x2','x3','x4','x5','x6','x7','x8','x9','x10','x11','x12','x13','x14','x15','x16','x17');
fp = fopen('sellig_1223.txt','w');
fprintf(fp,'#Airfoil \n');
fprintf(fp,'#Group \t Point \t x_coord \t y_coord \t z_coord \n');
nx = length(x1);
for k=1:nx
s = sprintf('%d \t %d \t %f \t %f \t %f',1,k,x1(k),y1(k),0.0);
fprintf(fp,'%s\n',s);
end

nx = length(x2);
for k=1:nx
s = sprintf('%d \t %d \t %f \t %f \t %f',2,k,x2(nx-k+1),y2(nx-k+1),0.0);
fprintf(fp,'%s\n',s);
end

nx = length(x3);
for k=1:nx
s = sprintf('%d \t %d \t %f \t %f \t %f',3,k,x3(k),y3(k),0.0);
fprintf(fp,'%s\n',s);
end
nx = length(x4);
for k=1:nx
s = sprintf('%d \t %d \t %f \t %f \t %f',4,k,x4(k),y4(k),0.0);
fprintf(fp,'%s\n',s);
end
nx = length(x5);
for k=1:nx
s = sprintf('%d \t %d \t %f \t %f \t %f',5,k,x5(k),y5(k),0.0);
fprintf(fp,'%s\n',s);
end
nx = length(x6);
for k=1:nx
s = sprintf('%d \t %d \t %f \t %f \t %f',6,k,x6(k),y6(k),0.0);
fprintf(fp,'%s\n',s);
end
nx = length(x7);
for k=1:nx
s = sprintf('%d \t %d \t %f \t %f \t %f',7,k,x7(k),y7(k),0.0);
fprintf(fp,'%s\n',s);
end
nx = length(x8);
for k=1:nx
s = sprintf('%d \t %d \t %f \t %f \t %f',8,k,x8(k),y8(k),0.0);
fprintf(fp,'%s\n',s);
end
nx = length(x9);
for k=1:nx
s = sprintf('%d \t %d \t %f \t %f \t %f',9,k,x9(k),y9(k),0.0);
fprintf(fp,'%s\n',s);
end
nx = length(x10);
for k=1:nx
s = sprintf('%d \t %d \t %f \t %f \t %f',10,k,x10(k),y10(k),0.0);
fprintf(fp,'%s\n',s);
end
nx = length(x11);
for k=1:nx
s = sprintf('%d \t %d \t %f \t %f \t %f',11,k,x11(k),y11(k),0.0);
fprintf(fp,'%s\n',s);
end
nx = length(x12);
for k=1:nx
s = sprintf('%d \t %d \t %f \t %f \t %f',12,k,x12(k),y12(k),0.0);
fprintf(fp,'%s\n',s);
end
nx = length(x13);
for k=1:nx
s = sprintf('%d \t %d \t %f \t %f \t %f',13,k,x13(k),y13(k),0.0);
fprintf(fp,'%s\n',s);
end
nx = length(x14);
for k=1:nx
s = sprintf('%d \t %d \t %f \t %f \t %f',14,k,x14(k),y14(k),0.0);
fprintf(fp,'%s\n',s);
end
nx = length(x15);
for k=1:nx
s = sprintf('%d \t %d \t %f \t %f \t %f',15,k,x15(k),y15(k),0.0);
fprintf(fp,'%s\n',s);
end
nx = length(x16);
for k=1:nx
s = sprintf('%d \t %d \t %f \t %f \t %f',16,k,x16(k),y16(k),0.0);
fprintf(fp,'%s\n',s);
end
nx = length(x17);
for k=1:nx
s = sprintf('%d \t %d \t %f \t %f \t %f',17,k,x17(k),y17(k),0.0);
fprintf(fp,'%s\n',s);
end
fclose(fp);
axis equal;