function [s,e]=split(sig, start)

x=sig;

thr=0.01;
n=100;

i=start + 1;
j=i+n;

s=-1;

while i<=length(x)
    yn=0;
    while i<=j && i<=length(x)
        if real(x(i)) > thr || imag(x(i)) > thr
            s=(i+i-n)/2;
            yn=1;
            break;
        end
        i=i+1;
    end
    if yn==1
        break;
    end
    j=j+n;
end 

j=i+n;

e=-1;

while i<=length(x)
    cnt=0;
    while i<=j && i<=length(x)
        if real(x(i)) < thr && imag(x(i)) < thr
            cnt=cnt+1;
        end
        i=i+1;
    end
    if cnt>=n
        e=(j+j-n)/2;
        break;
    end
    j=j+n;
end

% if s~=-1
%     s=s+start;
% end
% 
% if e~=-1
%    e=e+start; 
% end


% figure;
% 
% hold on;
% 
% u=real(x(s:e));
% v=imag(x(s:e));
% 
% plot(u);
% plot(v);

end

