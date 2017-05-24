function dehaved = scattering_rem(img, p, ex)

% Inputs:
% img: the gabor fitered ROI
% p: percentage of restoration, range [0.9 1)
% ex: extra fatcor

% R(i, j): restored image intensity without fog
% d(i, j): depth-map
% v(i, j): atmospheric veil 
% k: extinction coefficient
% 
% 1. estimation of Is, 
% 2. inference of V (x, y) from I(x, y)
% 3. estimation of R(x, y)
% 4. smoothing to handle noise amplification
% 5. final tone mapping


[m, n] = size(img);
img = im2double(img);  % double, [0 1]
sv=2*floor(max(size(img))/25)+1;

R=zeros(m, n);  % Restoration 

W = img; % for gray level image 


%% Atmospheric Veil Inference
A = medfilt2(W, [sv,sv], 'symmetric');  % A: local area of W; sv: size of the square or disc window used in median filter
sub = abs(W - A); % |W - A|
medFilt_sub = medfilt2(sub, [sv,sv], 'symmetric');  % median(|W-A|)
B = A - medFilt_sub;
veil = p * max(min(B, W), 0);

factor = 1./(1.-veil);% Contrast magnification factor
R = (img - veil).* factor;   % restoration, inverse Koschmieder's law
nb_original = img;
nb_restored = R;

% Gamma Correction
log_original = log(nb_original(2*m/3:m,:)+0.5/255.0);
log_restored = log(nb_restored(2*m/3:m,:)+0.5/255.0);
mean_original = mean(log_original(:));
mean_restored = mean(log_restored(:));
std_original = std(log_original(:));
std_restored = std(log_restored(:));
power = ex * std_original/std_restored;
U = R.^(power) * exp(mean_original - mean_restored * power);

%% Tone Mapping
max_U = max(U(:));
dehaved = U./(1+(1-1/max_U)*U);
dehaved = im2uint8(dehaved);





    





