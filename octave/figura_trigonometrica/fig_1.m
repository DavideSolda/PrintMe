x = -2:.3:2;
y = -2:.3:2;
[X, Y]=meshgrid(x,y);
Z=exp(-X.^2 -Y.^2).*sin(X.^2+Y.^2);
n=30;
surf(X, Y, Z*n);
surf2stl("fig_1.stl", 10*X, 10*Y, (10+n/5+Z*n));

%ok


