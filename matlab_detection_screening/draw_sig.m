function draw_sig(x,s,e)

figure;

hold on;

u=real(x(s:e));
v=imag(x(s:e));

plot(u);
plot(v);

end