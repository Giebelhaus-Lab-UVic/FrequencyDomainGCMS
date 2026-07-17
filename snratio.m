
alkc_1 = alkexp.tic(1.948e5:1.956e5);
alkn_1 = sampleAlkanes2D.tic(1.948e5:1.956e5);

hm_c = (max(alkc_1) - 168269)/2 +168269;
hm_n = (max(alkn_1) - 88584)/2 + 88584;

%x_vals = 0:500;
% --- Step 2: Split peak into left and right sides
left_x = (1:458).';
right_x = (459:801).';
right_gauss = alkn_1(right_x);
% Collapse repeated y values to unique values
[uright_gauss, ~, rid_vals] = unique(right_gauss);
% Average corresponding x values
uright_x = accumarray(rid_vals, right_x, [], @mean);

left_gauss = alkn_1(left_x);

[uleft_gauss, ~, lid_vals] = unique(left_gauss);
uleft_x = accumarray(lid_vals, left_x, [], @mean);

% --- Step 3: Compute FWHM
x1 = interp1(uleft_gauss, uleft_x, hm_n);     % Interpolate half max
x2 = interp1(uright_gauss, uright_x, hm_n);
fwhm_n = x2-x1;     



right_gauss = alkc_1(right_x);
% Collapse repeated y values to unique values
[uright_gauss, ~, rid_vals] = unique(right_gauss);
% Average corresponding x values
uright_x = accumarray(rid_vals, right_x, [], @mean);

left_gauss = alkc_1(left_x);
[uleft_gauss, ~, lid_vals] = unique(left_gauss);
uleft_x = accumarray(lid_vals, left_x, [], @mean);

% --- Step 3: Compute FWHM
x1 = interp1(uleft_gauss, uleft_x, hm_c);     % Interpolate half max
x2 = interp1(uright_gauss, uright_x, hm_c);

fwhm_c = x2-x1;

r_n = round(20*fwhm_n);
strt_n = round(10*fwhm_n) +458;

r_c = round(20*fwhm_c);
strt_c = round(10*fwhm_c) + 458;

%n_noise = alkn_1((strt_n:+(strt_n+r_n)).');
%c_noise = alkc_1((strt_c:(+r_c+strt_c)).');

n_noise = alkn_1((550:801).');
c_noise = alkc_1((550:801).');

n_h = max(n_noise) - min(n_noise);
c_h = max(c_noise) - min(n_noise);

snr_c = 2*(max(alkc_1) - 168269)/c_h

snr_n = 2*(max(alkn_1) - 88584)/n_h

p_incr = (snr_c - snr_n)/snr_n *100;