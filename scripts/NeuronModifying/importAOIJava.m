function importAOIJava(package)
% IMPORTAOIJAVA  imports Art of Illusion java functionalities.
%    IMPORTAOIJAVA Checks the java class path for the ArtoOfIllusion.jar file.
%       If the file is not included, it is added to the class path. This jar
%       file is required for all functions which use AOI java objects
%    IMPORTAOIJAVA(PACKAGE) Checks that the specified jar file is in the
%       class path. Package options are:
% 
%          base        ArtOfIllusion.jar
%          voxelizer   voxelizer.jar
% 
% See also JAVACLASSPATH, JAVAADDPATH

  % Set default value
  if nargin<1
    package = 'base';
  end

  % Select package
  if strcmpi(package, 'base')
    jarfile = 'ArtOfIllusion.jar';
  elseif strcmpi(package, 'voxelizer')
    jarfile = 'voxelizer.jar';
  end

  % Do import
  if ~ismember(jarfile, javaclasspath)
    javaaddpath(jarfile);
  end
