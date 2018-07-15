function x = LEVR(ia, ja, a, ilev, jlev, nlev, x)

for m = 1:nlev
%openmp parallel
    for k = ilev(m):ilev(m+1)-1
        i = jlev(k);
        for j = ia(i):ia(i+1)-2
            x(i) = x(i) - a(j)*x(ja(j));
        end
        x(i) = x(i)/a(ia(i+1)-1);   
    end
end