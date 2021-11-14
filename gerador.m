clear;
close all;
clc;
p1=[1.00000	 0
0.95000	 0.00807
0.90000	 0.01448
0.85000	 0.02053
0.80000	 0.02623
0.75000	 0.03160
0.70000	 0.03664
0.65000	 0.04133
0.60000	 0.04563
0.55000	 0.04952
0.50000	 0.05294
0.44900	 0.05588
0.39900	 0.05808
0.34900	 0.05951
0.29900	 0.06002
0.27500	 0.06048
0.25000	 0.06084
0.22500	 0.06100
0.20000	 0.06087
0.17500	 0.06033
0.15000	 0.05924
0.12500	 0.05740
0.10000	 0.05454
0.08000	 0.05121
0.06000	 0.04655
0.05000	 0.04351
0.04000	 0.03982
0.03000	 0.03522
0.02000	 0.02925
0.01000	 0.02074
0.00500	 0.01438
0.00000	 0.00000];

p2=[0.00000	 0.00000
0.00500 -0.01438
0.01000	-0.02074
0.02000	-0.02925
0.03000	-0.03522
0.04000	-0.03982
0.05000	-0.04351
0.06000	-0.04655
0.08000	-0.05121
0.10000	-0.05454
0.12500	-0.05740
0.15000	-0.05924
0.17500	-0.06033
0.20000	-0.06087
0.22500	-0.06100
0.25000	-0.06084
0.27500	-0.06048
0.29900	-0.06002
0.34900	-0.05951
0.39900	-0.05808
0.44900	-0.05588
0.50000	-0.05294
0.55000	-0.04952
0.60000	-0.04563
0.65000	-0.04133
0.70000	-0.03664
0.75000	-0.03160
0.80000	-0.02623
0.85000	-0.02053
0.90000	-0.01448
0.95000	-0.00807
1.00000	0];

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
fp = fopen('geradornaca0012.txt','w');
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
