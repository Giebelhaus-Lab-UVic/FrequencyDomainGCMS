
gctens = makeTensor(g_out60);
gcchr = sum(gctens,3);

gcticD1_us = sum(gcchr,1);




gntens = makeTensor(g2d);
gnchr = sum(gntens,3);
gnticD1 = sum(gnchr,1);

gcticD1 = gcticD1_us * max(gnticD1)/max(gcticD1_us);

figure; 
yyaxis left
plot(gnticD1); 
ylabel('Intensity')
hold on; 
yyaxis right 
plot(gcticD1);
ylabel('Intensity')
xlabel('Acquisitions')
%ylabel('Intensity')

lgd = legend('Before','After');
lgd.FontSize = 14;

ax = gca;
ax.FontSize = 14;


 