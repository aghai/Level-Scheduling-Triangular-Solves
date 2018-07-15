function x = LEVC(ib, jb, b, ilev, jlev, nlev, x)

for m = 1:1:nlev
% openmp parallel
    for k = ilev(m):ilev(m+1)-1
        i = jlev(k);
        x(i) = x(i)/b(ib(i+1)-1); 
        for j = ib(i):ib(i+1)-2
            %atomic operation
            x(jb(j)) = x(jb(j)) - b(j)*x(i);
            %atomic operation
        end
    end
end