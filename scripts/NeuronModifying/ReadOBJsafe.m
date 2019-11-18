function [V,VN, F,G] = ReadOBJsafe(filename)
  % Reads a .obj mesh file and outputs the vertex and face list
  % assumes a 3D triangle mesh and ignores everything but:
  % v x y z, vn x y z, and f i j k lines
  % Input:
  %  filename  string of obj file's path i.e. 'C:\Users\...\8 Basal Tree Models\1_0002.obj'
  %
  % Output:
  %  V  number of vertices x 3 array of vertex positions
  %  VN number of vertex normals x3 array of vertex normal positions
  %  F  number of faces x 3 array of face indices
  %
  V = zeros(0,3,0);
  VN = zeros(0,3,0);
  F = zeros(0,3,0);
  G = zeros(1);
  vertex_index = 1;
  vertex_group = 1;
  vn_index = 1;
  vn_group = 1;
  face_index = 1;
  face_group = 1;
  group_index = 1;
  if iscell(filename)
      filename = filename{1};
  end
  fid = fopen(filename,'rt');
  line = fgets(fid);
  while ischar(line)
    vertex = sscanf(line,'v %f %f %f');
    group = sscanf(line,'g grp%f');
    vertex_normal = sscanf(line,'vn %e %e %e');
%     face = sscanf(line,'f %d %d %d');
    face_long = sscanf(line,'f %d//%d %d//%d %d//%d');
    if(size(group)>0)
        G(group_index,:) = group;
        vertex_group = vertex_group + 1;
        vn_group = vn_group + 1;
        face_group = face_group + 1;
        group_index = group_index + 1;
        vn_index = 1;
        vertex_index = 1;
        face_index = 1;
    % see if line is vertex command if so add to vertices
    elseif(size(vertex)>0)
%       V(vertex_index,:,vertex_group) = vertex;
      V{vertex_group}(vertex_index,:) = vertex;
      vertex_index = vertex_index+1;
    % see if line is simple face command if so add to faces
%     elseif(size(face)>0)
%       F(face_index,:) = face;
%       face_index = face_index+1;
%     % see if line is a long face command if so add to faces
    elseif(size(face_long)>0)
      % remove normal and texture indices
      face_long = face_long(1:2:end);
      F{face_group-1}(face_index,:) = face_long;
      face_index = face_index+1;
    elseif(size(vertex_normal)>0)
      VN{vn_group}(vn_index,:) = vertex_normal;
      vn_index = vn_index+1;
    else
%       fprintf('Ignored: %s',line);
    end

    line = fgets(fid);
  end
  fclose(fid);
end
%[V,VN, F] = ReadOBJ('C:\Users\Jason\Desktop\Oregon Research\8 Basal Tree Models\1_0002.obj');
%trisurf(F,V(:,1),V(:,2),V(:,3),'FaceColor',[0.26,0.33,1.0 ]);
%light('Position',[-1.0,-1.0,100.0],'Style','infinite');
%lighting phong;
% Measuring the distance between all the vertices and restoring them in an
% n*n matrix
% D=pdist(v);
% Distance=squareform(D);