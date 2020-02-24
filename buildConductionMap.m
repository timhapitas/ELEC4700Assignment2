function [cMap] = buildConductionMap(L, W, meshSize, nx, ny, backgroundCond, boxCond, bottleneckLength, bottleneckWidth)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%bottleneckLength and bottleneckWidth are defined as fractions of the total
%region length and width.

cMap = zeros(ny, nx);
boxL = bottleneckLength*L;
boxH = bottleneckWidth*W;
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

