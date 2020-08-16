x = linspace(-8,8,50);
y = linspace(-8,8,50);
[X,Y] = meshgrid(x,y);
Z = (4-abs(X)) + (4-abs(Y));
Z(Z < 0) = NaN;
%surf(X,Y,Z);

surf2stl('pyramid.stl', X*4, Y*4, Z*4);

