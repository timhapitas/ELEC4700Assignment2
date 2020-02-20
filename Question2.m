meshSize = 0.5;

L = 25;
W = 50;

nx = L/meshSize;
ny = W/meshSize;

backgroundCond = 1;
boxCond = 1e-2;
V_o = 10;

cMap = buildConductionMap(L, W, meshSize, nx, ny, backgroundCond, boxCond);


G = sparse(nx*ny, nx*ny);
B = zeros(nx*ny, 1);

for j = 1:ny %j counts y coordinate
    
   for i = 1:nx %i counts x coordinate
       
       %mapping from mesh space to equation space
       
       n = i + (j - 1)*nx;
       nym = i + (j - 2)*nx;
       nyp = i + j*nx;
       nxm = (i - 1) + (j - 1)*nx;
       nxp = (i + 1) + (j - 1)*nx;
       
       %implement boundary conditions
       if ((i > 1 && i < nx) && (j == 1)) %bottom of region
           
           % conductivity node mapping
           rxm = (cMap(j,i) + cMap(j,i-1))/2;
           rxp = (cMap(j,i) + cMap(j,i+1))/2;
           ryp = (cMap(j,i) + cMap(j+1,i))/2;
       
           G(n,n) = -(rxp + rxm + ryp)/(meshSize^2);
           G(n,nxm) = rxm/(meshSize^2);
           G(n,nxp) = rxp/(meshSize^2);
           G(n,nyp) = ryp/(meshSize^2);
           B(n) = 0;
         
       elseif ((i > 1 && i < nx) && (j == ny)) %top of region
           
           % conductivity node mapping
           rxm = (cMap(j,i) + cMap(j,i-1))/2;
           rxp = (cMap(j,i) + cMap(j,i+1))/2;
           rym = (cMap(j,i) + cMap(j-1,i))/2;
           
           G(n,n) = -(rxp + rxm + rym)/(meshSize^2);
           G(n,nxm) = rxm/(meshSize^2);
           G(n,nxp) = rxp/(meshSize^2);
           G(n,nym) = rym/(meshSize^2);
           B(n) = 0;
       
       elseif (i == 1) %left side of region
           
           G(n,:) = 0;
           G(n,n) = 1;
           B(n) = V_o;
           
       elseif (i == nx) %right side of region
           
           G(n,:) = 0;
           G(n,n) = 1;
           B(n) = 0;
        
       else %everywhere else in the region
           
           % conductivity node mapping
           rxm = (cMap(j,i) + cMap(j,i-1))/2;
           rxp = (cMap(j,i) + cMap(j,i+1))/2;
           rym = (cMap(j,i) + cMap(j-1,i))/2;
           ryp = (cMap(j,i) + cMap(j+1,i))/2;
           
           G(n,n) = -(rxp + rxm + ryp + rym)/(meshSize^2);
           G(n,nxp) = rxp/(meshSize^2);
           G(n,nxm) = rxm/(meshSize^2);
           G(n,nyp) = ryp/(meshSize^2);
           G(n,nym) = rym/(meshSize^2);
           B(n) = 0;
     
       end
       
   end
    
end

% Solve the differential equation
V = G\B;

% map voltage back to position space
V = reshape(V, [nx ny]);
V = transpose(V);

% compute electric field components
[Ex, Ey] = gradient(V);
Ex = -Ex;
Ey = -Ey;

% calculate current density
Jx = cMap.*Ex;
Jy = cMap.*Ey;

% numerical approximation of surface integral of J at the top and bottom
% contacts
currentTop = abs(sum(Jy(ny,:))*meshSize);
currentBot = abs(sum(Jy(1,:))*meshSize);

% plots
figure;
surf(cMap);
title('Electrical Conductivity Throughout the Region of Interest');
xlabel('x-Direction');
ylabel('y-Direction');
zlabel('Conductivity (\Omega^{-1})');


figure;
surf(V);
title('Potential Throughout the Region');
xlabel('x-Direction');
ylabel('y-Direction');
zlabel('Electric Potential (V)');

figure;
quiver(Ex, Ey);
title('Electric Field Throughout the Region (V/m)');
xlabel('x-Direction');
ylabel('y-Direction');

figure;
quiver(Jx, Jy);
title('Current Density Throughout the Region (A/m^2)');
xlabel('x-Direction');
ylabel('y-Direction');



