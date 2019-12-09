function environment = landscapeGrowing(N,xSpots,ySpots,numberOfSpots,environment)
circlesRange = 0.2; %change the size of the patched 0.2=20% of the lattice size
for idx = 1:numberOfSpots
    xMax = xSpots(idx)+circlesRange*N;
    xMin = xSpots(idx)-circlesRange*N;
    yMax = ySpots(idx)+circlesRange*N;
    yMin = ySpots(idx)-circlesRange*N;
    if(xSpots(idx)+circlesRange*N>N)
        xMax = N;
    end
    if(xSpots(idx)-circlesRange*N<1)
        xMin = 1;
    end
    if(ySpots(idx)+circlesRange*N>N)
        yMax = N;
    end
    if(ySpots(idx)-circlesRange*N<1)
        yMin = 1;
    end
    for idx2 = xMin:xMax
        for idx3 = yMin:yMax
            environment(idx2,idx3) = environment(idx2,idx3)+0.5*rand()+0.4;
        end
    end
end
environment = environment+unifrnd(0,0.3,N,N);
end