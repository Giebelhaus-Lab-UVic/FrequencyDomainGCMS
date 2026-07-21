
gctens = makeTensor(g_scale_IN);
gcchr = sum(gctens,3);
gcticD1 = sum(gcchr,1);


gntens = makeTensor(g2d);
gnchr = sum(gntens,3);
gnticD1 = sum(gnchr,1);

figure; 
yyaxis left
plot(gnticD1); 
hold on; 
yyaxis right 
plot(gcticD1);


legend('Before','After')

 