function gb_bank = gaber_bank(sigma, gamma, theta, frequency)
psi=0;
sigma_x = sigma;
sigma_y = sigma_x/gamma;

% Bounding box  
nstds = 4; 
xmax = max(abs(nstds*sigma_x*cos(theta)),abs(nstds*sigma_y*sin(theta)));  
xmax = ceil(max(1,xmax));  
ymax = max(abs(nstds*sigma_x*sin(theta)),abs(nstds*sigma_y*cos(theta)));  
ymax = ceil(max(1,ymax));  
xmin = -xmax; ymin = -ymax;  
[x,y] = meshgrid(xmin:xmax,ymin:ymax);     
   
% Rotation   
x_theta = x*cos(theta)+y*sin(theta); 
y_theta = -x*sin(theta)+y*cos(theta);

%t1 = 1/(2*pi*sigma_x*sigma_y);
%t2 = exp(-0.5*( x_theta^2/sigma_x^2 + y_theta^2/sigma_y^2 ));
%t3 = cos(sqrt(-1)*2*pi*frequency*x_theta);
%gb_bank = exp(-.5*(x_theta.^2/sigma_x^2+y_theta.^2/sigma_y^2)).*cos(2*pi/(1/frequency)*x_theta+psi); 
gb_bank = exp(-.5*(x_theta.^2/sigma_x^2+y_theta.^2/sigma_y^2)).*cos(2*pi/(1/frequency)*x_theta+psi);


