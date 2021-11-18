clear;
close all;
clc;
p1=[1.00000  0.00000
  0.99655  0.00159
  0.98706  0.00650
  0.97304  0.01434
  0.95530  0.02381
  0.93358  0.03376
  0.90734  0.04400
  0.87671  0.05481
  0.84221  0.06620
  0.80436  0.07803
  0.76373  0.09010
  0.72090  0.10215
  0.67644  0.11391
  0.63092  0.12506
  0.58491  0.13524
  0.53893  0.14410
  0.49347  0.15116
  0.44870  0.15593
  0.40464  0.15828
  0.36149  0.15824
  0.31947  0.15590
  0.27885  0.15138
  0.23987  0.14485
  0.20286  0.13657
  0.16816  0.12676
  0.13611  0.11562
  0.10700  0.10337
  0.08106  0.09023
  0.05852  0.07646
  0.03953  0.06232
  0.02421  0.04812
  0.01262  0.03419
  0.00481  0.02093
  0.00071  0.00879
  0.00002  0.00088
  0.000 0];

p2=[0.000 0
  0.00125 -0.00518
  0.00157 -0.00590
  0.00194 -0.00656
  0.00237 -0.00717
  0.00288 -0.00771
  0.00348 -0.00823
  0.00415 -0.00874
  0.00571 -0.00969
  0.00751 -0.01057
  0.01065 -0.01177
  0.01365 -0.01266
  0.02892 -0.01485
  0.04947 -0.01482
  0.07533 -0.01236
  0.10670 -0.00740
  0.14385 -0.00002
  0.18727  0.00922
  0.23688  0.01913
  0.29196  0.02865
  0.35163  0.03687
  0.41449  0.04283
  0.47867  0.04626
  0.54275  0.04760
  0.60579  0.04715
  0.66690  0.04501
  0.72503  0.04126
  0.77912  0.03625
  0.82836  0.03050
  0.87219  0.02444
  0.91012  0.01844
  0.94179  0.01286
  0.96692  0.00794
  0.98519  0.00390
  0.99629  0.00106
  1.00000  0.00000];
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
fp = fopen('Eppler_423.txt','w');
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