function mesh2stl(filename, X, Y, Z, delta)
%MESH2STL writes an .stl (STereoLithography) file from meshgrid variables
%  mesh2stl('filename', X, Y, Z)
%     produces a triangulated mesh from meshgrid variables X, Y, Z
%     and writes output to 'filename' in stl format 
%  --X, Y, Z must be two dimensional arrays of the same size
%  --optional: if delta is provided, produce a solid block from the graph
%              of surface z = f(x, y)
%              where 'delta' gives minimum thickness between base of block
%              and graph of surface
%  Example:
%    [X Y Z] = sombrero;
%    Z = 10*Z + 3;
%    mesh2stl('sombrero.stl', X, Y, Z, 2)
%  Author: Jason Lachniet, November, 2018

% determine dimensions
m = size(Z, 1);
n = size(Z, 2);

% construct triangular facets for surface
k = 0;
for i = 1:m-1
  for j = 1:n-1
    k = k + 1;
    F(:, :, k) = [X(i,j),     Y(i,j),     Z(i,j);
                  X(i,j+1),   Y(i,j+1),   Z(i,j+1);
                  X(i+1,j+1), Y(i+1,j+1), Z(i+1,j+1)];
    k = k + 1;
    F(:, :, k) = [X(i+1,j+1), Y(i+1,j+1), Z(i+1,j+1);
                  X(i+1,j),   Y(i+1,j),   Z(i+1,j);
                  X(i,j),     Y(i,j),     Z(i,j)];    
  end
end

if (nargin > 4)
  % calculate elevation and midpoint of base
  z_base = min(min(Z)) - delta;
  x_mid = (min(min(X)) + max(max(X)))/2;
  y_mid = (min(min(Y)) + max(max(Y)))/2;

  % construct triangular facets for 'curtain' and base
  for i = 1:n-1
    k = k + 1;
    F(:,:,k) = [X(1,i),   Y(1,i),   Z(1,i);
                X(1,i),   Y(1,i),   z_base;
                X(1,i+1), Y(1,i+1), Z(1,i+1)];
    k = k + 1;
    F(:,:,k) = [X(1,i+1), Y(1,i+1), Z(1,i+1);
                X(1,i),   Y(1,i),   z_base;
                X(1,i+1), Y(1,i+1), z_base];
    k = k + 1;
    F(:,:,k) = [x_mid,    y_mid,    z_base;
                X(1,i),   Y(1,i),   z_base;
                X(1,i+1), Y(1,i+1), z_base];
    k = k + 1;
    F(:,:,k) = [X(m,i),   Y(m,i),   Z(1,i);
                X(m,i),   Y(m,i),   z_base;
                X(m,i+1), Y(m,i+1), Z(1,i+1)];
    k = k + 1;
    F(:,:,k) = [X(m,i+1), Y(m,i+1), Z(1,i+1);
                X(m,i),   Y(m,i),   z_base;
                X(m,i+1), Y(m,i+1), z_base];
                k = k + 1;
    F(:,:,k) = [x_mid,    y_mid,    z_base;
                X(m,i),   Y(m,i),   z_base;
                X(m,i+1), Y(m,i+1), z_base];
  end
  for j = 1:m-1
    k = k + 1;
    F(:,:,k) = [X(j,1),   Y(j,1),   Z(j,1);
                X(j,1),   Y(j,1),   z_base;
                X(j+1,1), Y(j+1,i), Z(j+1,1)]; 
    k = k + 1;
    F(:,:,k) = [X(j+1,1), Y(j+1,1), Z(j+1,1);
                X(j,1),   Y(j,1),   z_base;
                X(j+1,1), Y(j+1,1), z_base]; 
    k = k + 1;
    F(:,:,k) = [x_mid,    y_mid,    z_base;
                X(j,1),   Y(j,1),   z_base;
                X(j+1,1), Y(j+1,1), z_base];
    k = k + 1;
    F(:,:,k) = [X(j,n), Y(j,n), Z(j,n);
                X(j,n), Y(j,n), z_base;
                X(j+1,n), Y(j+1,n), Z(j+1,n)]; 
    k = k + 1;
    F(:,:,k) = [X(j+1,n), Y(j+1,n), Z(j+1,n);
                X(j,n),   Y(j,n),   z_base;
                X(j+1,n), Y(j+1,n), z_base]; 
    k = k + 1;
    F(:,:,k) = [x_mid,    y_mid,    z_base;
                X(j,n),   Y(j,n),   z_base;
                X(j+1,n), Y(j+1,n), z_base];
  end
end

% number of triangular facets
num_facets = k;

% save in stl format
fid = fopen(filename, 'w');
title_str = sprintf('Created with GNU Octave %s', datestr(now));
fprintf(fid,'solid %s\r\n', title_str);
for k = 1:num_facets
   % vertices
   p1 = [F(1, 1, k) F(1, 2, k) F(1, 3, k)];
   p2 = [F(2, 1, k) F(2, 2, k) F(2, 3, k)];
   p3 = [F(3, 1, k) F(3, 2, k) F(3, 3, k)];
   
   % normal vector
   if (and(p1 ~= p2, p1 ~= p3, p2 ~= p3))
     n = cross(p2-p1, p3-p1)./norm(cross(p2-p1, p3-p1));
   else
     n = [0 0 0]; % unable to calculate normal vector
   end
   
   % write facets
   fprintf(fid, 'facet normal %.7E %.7E %.7E\r\n', n(1), n(2), n(3));
   fprintf(fid, 'outer loop\r\n');        
   fprintf(fid, 'vertex %.7E %.7E %.7E\r\n', p1);
   fprintf(fid, 'vertex %.7E %.7E %.7E\r\n', p2);
   fprintf(fid, 'vertex %.7E %.7E %.7E\r\n', p3);
   fprintf(fid, 'endloop\r\n');
   fprintf(fid, 'endfacet\r\n');
end
fprintf(fid, 'endsolid %s\r\n', title_str);
fclose(fid);

disp('Number of triangular facets:'), disp(num_facets)