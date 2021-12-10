function pkt_stf_ltf_op = equalize_channel(pkt)
nht = wlanNonHTConfig;

pkt = resample(pkt,4,5);
pkt = [zeros(20,1); pkt];
strt_indx = wlanPacketDetect(pkt,'CBW20');
if isempty(strt_indx)
    pkt_stf_ltf_op=[];
    return
end 
if strt_indx+800> length(pkt)
    pkt_stf_ltf_op=[];
    return
end
pkt = pkt(strt_indx:strt_indx+800);
stf_ind = wlanFieldIndices(nht,'L-STF');
ltf_ind = wlanFieldIndices(nht,'L-LTF');
pkt_stf = pkt(stf_ind(1):stf_ind(2));

freqOffsetEst1 = wlanCoarseCFOEstimate(pkt_stf,'CBW20');
pkt = pkt.*exp(1j*(1:length(pkt))'/20e6*2*pi*-freqOffsetEst1 );
pkt_ltf = pkt(ltf_ind(1):ltf_ind(2));

freqOffsetEst2 = wlanFineCFOEstimate(pkt_ltf,'CBW20');

pkt = pkt.*exp(1j*(1:length(pkt))'/20e6*2*pi*-freqOffsetEst2 );

datIndx= [  39:64 2:27 ];




pkt_stf = pkt(stf_ind(1):stf_ind(2));
pkt_ltf = pkt(ltf_ind(1):ltf_ind(2));
demodSig = wlanLLTFDemodulate(pkt_ltf,nht);
nVar = helperNoiseEstimate(demodSig,nht.ChannelBandwidth,1);

est = wlanLLTFChannelEstimate(demodSig,nht);


pkt_stf_ltf = [pkt_stf; pkt_ltf];
pkt_stf_ltf_resh = reshape(pkt_stf_ltf,64,5);
pkt_stf_ltf_freq = fft(pkt_stf_ltf_resh,64);

pkt_stf_ltf_freq = pkt_stf_ltf_freq(datIndx,:);
h1=est;



pkt_stf_ltf_freq_eq = pkt_stf_ltf_freq.*conj(h1)./(conj(h1).*h1+nVar);
%pkt_stf_ltf_freq_eq = pkt_stf_ltf_freq./(h1);


pkt_stf_ltf_freq_eq_all = zeros(64,5);
pkt_stf_ltf_freq_eq_all(datIndx,:) = pkt_stf_ltf_freq_eq;
pkt_stf_ltf_eq = ifft(pkt_stf_ltf_freq_eq_all,64);
pkt_stf_ltf_eq = pkt_stf_ltf_eq(:);

pkt_stf_ltf_fo = pkt_stf_ltf_eq .*exp(1j*(1:length(pkt_stf_ltf_eq))'/20e6*2*pi*(freqOffsetEst1+freqOffsetEst2) );
pkt_stf_ltf_op = resample(pkt_stf_ltf_fo,5,4);
% pkt_ltf = pkt_stf_ltf_eq(ltf_ind(1):ltf_ind(2));
% demodSig = wlanLLTFDemodulate(pkt_ltf,nht);
% est = wlanLLTFChannelEstimate(demodSig,nht);
% h2=est;
