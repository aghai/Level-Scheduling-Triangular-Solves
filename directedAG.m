function [lev, ilev, jlev, nlev] = directedAG(L, Lrow, Lcol)

n = size(L,1);
n = size(Lrow,1)-1;
jlev = zeros(n,1);

for i=1:n
    jlev(i) = i;
end

lev = zeros(n,1);
for i=1:n
   % if Lcol(Lrow(i)) ~= i    
        temp = lev(Lcol(Lrow(i)));
        for j=Lrow(i)+1:Lrow(i+1)-1 
            %if (Lcol(j) ~= i && temp < lev(Lcol(j)))
             if temp < lev(Lcol(j))
                temp = lev(Lcol(j));
            end
        end
   % else
   %     temp = 0;
   % end
    lev(i) = 1 + temp;
end

%After getting the lev we need to find CSR of lvl
nlev = max(lev);

[lev, jlev] = hypre_sort(lev, jlev, 1, n);

%creating ilev
ilev = zeros(nlev+1,1);
count = 0;
ilev(1) = 1;
iter = 2;
for h = 2:1:n
    if (lev(h)~=lev(h-1))
        ilev(iter) = ilev(iter-1) + 1 + count;
        iter = iter + 1;
        count = 0;
    else
        count = count + 1;
    end  
end
ilev(iter) = ilev(iter -1) +1 + count;




%
end

function [v, w] = hypre_sort(v, w, left, right)
if (left >= right)
    return;
end
[v, w] = hypre_swap(v, w, left, floor((left+right)/2) );
last = left;
for i = left+1: right
    if(v(i) < v(left))
        %last = last + 1;
        [v, w] = hypre_swap(v, w, ++last, i);
    end
end
[v, w] = hypre_swap(v, w, left, last);
[v, w] = hypre_sort(v, w, left, last -1);
[v, w] = hypre_sort(v, w, last+1, right);
end

function [v, w] = hypre_swap(v , w, i, j)
tmp = v(i);
v(i) = v(j);
v(j) = tmp;
tmp2 = w(i);
w(i) = w(j);
w(j) = tmp2;
end


