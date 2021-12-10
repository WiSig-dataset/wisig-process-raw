function draw_sig_alt(transmitter)

x = read_complex_binary(strcat('data/tx{node,node',transmitter,'_}_rx{node,node13-13_rxFreq,2462e6_rxGain,0.5_capLen,0.512_rxSampRate,25e6}.dat'));

figure;

hold on;

u=real(x);
v=imag(x);

plot(u);
plot(v);

end