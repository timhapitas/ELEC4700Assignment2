function [cMap] = buildConductionMap(L, W, meshSize, nx, ny, backgroundCond, boxCond)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

cMap = zeros(ny, nx);
boxL = L/3;
boxH = W/3;
boxXstart = ((L/3)/meshSize);
boxXfinish = boxXstart + boxL/meshSize;
boxYstart = 0;
boxYfinish = boxYstart + (boxH/meshSize);
verticalSep = ((W/3)/meshSize);

for j = 1:ny
    for i = 1:nx
       
        if (((i >= boxXstart) && (i <= boxXfinish)) && ((j >= boxYstart) && (j <= boxYfinish)))
            cMap(j,i) = boxCond;
            
        elseif (((i >= boxXstart) && (i <= boxXfinish)) && ((j >= (boxYfinish + verticalSep)) && (j <= ny)))
            cMap(j,i) = boxCond;
            
        else
            cMap(j,i) = backgroundCond;
            
        end    
    end
end
end

