function [s,m]=signal_energy(sig)

s=0;
m=-1;

for i=1:length(sig)
   m=max(m, abs(real(sig(i))));
   m=max(m, abs(imag(sig(i))));
   s=s+abs(sig(i));
end

s=s/length(sig);

end