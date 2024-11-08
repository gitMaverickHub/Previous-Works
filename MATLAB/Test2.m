fid = fopen('dataFile.txt');
a = fscanf(fid,'%g %g',[1 2])
b = fscanf(fid,'%g %g %g',[1 3])
c = fscanf(fid,'%g %g',[1 2])
d = fscanf(fid,'%g',[1 1])
e = fscanf(fid,'%g',[1 3])
a(2)*b(3)*c(2)*d(1)
fclose(fid);