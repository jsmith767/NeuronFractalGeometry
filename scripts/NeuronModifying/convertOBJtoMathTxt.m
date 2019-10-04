%Converts OBJ's to txt files for mathematica processing.
%Navigate to the folder that contains all the different straightenings of
%the neurons.
%Make sure 'bin_reader.py','binvox.exe', & 'glut32.dll' are in the parent
%folder.

[P F] = subdir(pwd);
files = dir;
currentDirectory = pwd;
for i=1:size(P,2)
    copyfile('bin_reader.py',P{i});
    copyfile('binvox.exe',P{i});
    copyfile('glut32.dll',P{i});
end
for i=1:size(P,2)
    cd(P{i});
    system('for %x in (*.obj) do binvox -d 1024 -e %x');
    system('for %x in (*.binvox) do python bin_reader.py %x %x');
end
cd(currentDirectory);