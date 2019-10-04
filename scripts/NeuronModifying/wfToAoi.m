function aoi_obj = wfToAoi(obj)
% WFTOAOI  Converts Wavefront OBJ objects to ArtOfIllusion java objects.
%    AOI_OBJ = WFTOAOI(WF_OBJ) Converts the given wavefront object to an
%       ArtOfIllusion java of class TriangleMesh object. Wavefront objects
%       can be loaded using the WF_LOAD function.
% 
%    See also WF_LOAD.
  if ~iswf(obj)
    error('An object of type wavefront was expected');
  end

  importAOIJava;
  v = javaArray('artofillusion.math.Vec3',size(obj.vertex,1));
  for i=1:size(v,1)
    v(i) = artofillusion.math.Vec3(obj.vertex(i,1), obj.vertex(i,2), obj.vertex(i,3));
  end

  faces = [];
  for i=1:size(obj.faces,1)
    faces = vertcat(faces, getTriangles(obj.faces{i}));
  end

  aoi_obj = artofillusion.object.TriangleMesh(v, faces);

  function f = getTriangles(face)
    f = zeros(size(face,1)-2,3);
    for i=2:size(face,1)-1
      f(i-1,1) = face(1  ,1) - 1;
      f(i-1,2) = face(i  ,1) - 1;
      f(i-1,3) = face(i+1,1) - 1;
    end
