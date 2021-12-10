function [e]=find_beg(sig, start)

x=sig(start:end);

thr=0.005;
n=100;

i=start;
j=i+n;

while i<=length(x)
    cnt=0;
    while i<=j && i<=length(x)
        if real(x(i)) < thr && imag(x(i)) < thr
            cnt=cnt+1;
        end
        i=i+1;
    end
    if cnt>=n
        e=max((j+j-n)/2, 0);
        break;
    end
    j=j+n;
end

e=e+start;

end