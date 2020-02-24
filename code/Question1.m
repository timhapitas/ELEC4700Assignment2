L = 30;
W = 20;
meshSize = 1;
V_o = 1;
seriesTermCount = 300;

nx = L/meshSize;
ny = W/meshSize;

% -------------- 1 a)  -------------- %

G = sparse(nx, nx);
B = zeros(nx, 1);
V_2D = zeros(ny, nx);

%Construction of discrete Laplace operator and solution vector (1D)
    
for i = 1:nx %i counts x coordinate
       
       %mapping from position space to equation space
       n = i;
       nxm = i - 1;
       nxp = i + 1;
       
       %implement boundary conditions
       if (i == 1)
           
           G(n,n) = 1;
           B(n) = V_o;
           
       elseif (i == nx)
           
           G(n,n) = 1;
    
       else
           
           G(n,n) = -2/meshSize;
           G(n,nxm) = 1/meshSize;
           G(n,nxp) = 1/meshSize;
     
       end
       
end

V_1D = G\B;

for count = 1:ny
    
   V_2D(count,:) = V_1D;
    
end

%plot of numerical solution
figure;
surf(V_2D);
title('Voltage Throughout the Region (Unfixed Top and Bottom BCs)');
xlabel('x-Direction');
ylabel('y-Direction');
zlabel('Electric Potential (V)');

% -------------- 1 b)  -------------- %

G = sparse(nx*ny, nx*ny);
B = zeros(nx*ny, 1);

%Construction of discrete Laplace operator and solution vector

for j = 1:ny %j counts y coordinate
    
   for i = 1:nx %i counts x coordinate
       
       %mapping from mesh space to equation space
       
       n = i + (j - 1)*nx;
       nym = i + (j - 2)*nx;
       nyp = i + j*nx;
       nxm = (i - 1) + (j - 1)*nx;
       nxp = (i + 1) + (j - 1)*nx;
       
       %implement boundary conditions
       if ((i > 1 && i < nx) && ((j == 1) || (j == ny)))
          
           G(n,:) = 0;
           G(n,n) = 1;
           B(n) = 0;
   
       elseif (i == 1) || (i == nx)
           
           G(n,:) = 0;
           G(n,n) = 1;
           B(n) = V_o;
     
       else
           
           G(n,n) = -4/meshSize;
           G(n,nym) = 1/meshSize;
           G(n,nyp) = 1/meshSize;
           G(n, nxp) = 1/meshSize;
           G(n, nxm) = 1/meshSize;
     
       end
       
   end
    
end

%Solve the equivalent matrix problem
V = G\B;
V = reshape(V, [nx ny]);

%Define Analytical Series Solution
x = linspace(0, L, nx);
y = linspace(0, W, ny);
V_an = zeros(length(x), length(y));

seriesSolution = @(x,y,k) (4*V_o/pi)*(1/k)*((cosh((k*pi*x)/W))*(sin((k*pi*y)/W)))/(cosh((k*pi*(L/2))/W));

for xval = 1:length(x)
    for yval = 1:length(y)
        for k = 1:2:seriesTermCount
                            
            V_an(xval,yval) = V_an(xval,yval) + seriesSolution(x(xval) - (L)/2,y(yval),k);
                       
        end  
    end   
end

%meshgrid for plotting analytical solution
[Y,X] = meshgrid(y,x);

%plot of numerical solution
figure;
surf(V);
title('Voltage Throughout the Region Obtained from Numerical Solution of \nabla^2V = 0');
xlabel('y-Direction');
ylabel('x-Direction');
zlabel('Electric Potential (V)');
xlim([1 W]);
ylim([1 L]);


%plot of analytical solution
figure;
surf(X, Y, V_an);
title('Voltage Throughout the Region Given by the Analytical Series Solution of \nabla^2V = 0');
xlabel('x-Direction');
ylabel('y-Direction');
zlabel('Electric Potential (V)');
xlim([0 L]);
ylim([0 W]);
zlim([0 V_o]);