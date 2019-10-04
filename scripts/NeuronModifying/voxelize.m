function varargout = voxelize(obj, res, tol)
% VOXELIZE  Converts a 3D solid object into its equivalent voxel
%       representation.
%    VOX = VOXELIZE(OBJ) Converts the given 3D object OBJ into its voxels.
%    VOX = VOXELIZE(OBJ,RES) Uses the specified RES as the generated voxel
%       size. If no voxel size is given, an estimated 'optimal' voxel size
%       is calculated, relative to the rectangular bounding box of the
%       object being voxelized.
%    VOX = VOXELIZE(OBJ,RES,TOL) Specifies the maximum tolerance TOL used
%       when converting the given 3D object OBJ to a triangle mesh.
% 
%    Example 1
%    ---------
%    This example loads a 3D sphere, voxelizes it and plots the obtained
%    voxels:
% 
%       obj = wf_load('sphere.obj');
%       [ vox res ] = voxelize(obj);
%       plot3D(vox, res);
% 
%
%    See also WF_LOAD, PLOT3D.

  importAOIJava('base');
  importAOIJava('voxelizer');

  if instanceOf(obj,'artofillusion.object.Object3D')
    obj3d = obj;
  elseif iswf(obj)
    obj3d = wfToAoi(obj);
  else
    error(['An object of type wavefront or artofillusion.object.Object3D '...
        'was expected']);
  end

  if ~obj3d.isClosed
    % There is a reason for this: CSG can not be performed over open
    % objects. The alternative is to voxelize the surface only, but this
    % would produce unwanted results: confusion may arise whether the
    % object was voxelized properly or only the surface of the object was
    % voxelized, specially because we do not know if the surfaces given are
    % closed.
    error('Voxelization of non-closed objects is not supported!');
  end

  if nargin<2; 
    bbox = obj3d.getBounds.getSize;
    res = nthroot((bbox.x*bbox.y*bbox.z)/10000,3);
    res = neo.aoi.RoundUtils.round(res, neo.aoi.RoundUtils.getRoundingPlaces(res));
  end
  if nargin<3; tol = 0.05; end

  voxels = neo.aoi.Voxelizer.getVoxelsWithFilling(obj3d, tol, res);
  vox = [];
  it = voxels.iterator();
  while it.hasNext
    curr = it.next();
    vox = vertcat(vox, [ curr.x curr.y curr.z ]);
  end

  if nargout>=1
    varargout{1} = vox;
  end
  if nargout>=2
    varargout{2} = res;
  end

function isInstance = instanceOf(obj, classname)
  isInstance = false;

  if isjava(obj)
    object = 'java.lang.Object';
    cls = obj.getClass;

    while ~isInstance && ~strcmp(cls.getName, object)
      if strcmp(cls.getName, classname)
        isInstance = true;
      else
        cls = cls.getSuperclass;
      end
    end
  end
