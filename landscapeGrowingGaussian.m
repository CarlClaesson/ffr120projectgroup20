function environment = landscapeGrowingGaussian(N,xSpots,ySpots,numberOfSpots,environment,position)
circlesRange = 0.2; %change the size of the patched 0.2=20% of the lattice size
X = 0:0.05:4.95;
environment = abs(peaks(X-position));
Normalize = max(max(environment));
environment = environment/(0.5*Normalize);
environment = environment+0.3*rand(N);
end