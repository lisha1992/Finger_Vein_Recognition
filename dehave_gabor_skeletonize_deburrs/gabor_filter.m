function gb = gabor_filter(roi,bandwidth, N, M)

[row, col]=size(roi);
if M ==1
    wavelength = [18];
end
if M == 3
    wavelength = [14 16 18];
end
if M == 5
    wavelength = [14 15 16 17 18];
end

frequency = 1./wavelength;
theta = zeros(1, N);
for k=1:N
    theta(k) = (k-1)*pi/N;
end

K = (2^bandwidth-1)/(2^bandwidth+1);
gamma = 1;

for m=1:M
    sigma(m) = sqrt(log(2)/2)/(frequency(m) * K * pi);
end


for m=1:M
    G =cell(1,N);
    B = cell(1, N);
    for n=1:N
        G{1,n}=zeros(row,col);
        G{1,n}=gaber_bank(sigma(m), gamma, theta(n), frequency(m));
        B{1, n} = conv2(double(roi), double(real(G{1, n})), 'same');% 100*300 for each cell
    end
    for r=1:row
        for c=1:col
            for n=1:N
                B1(r,c, n)=B{1,n}(r, c);
            end
            gb_result(r,c)= min(B1(r,c,:));
         
        end
    end
   
 %  figure;imshow(gb_result, []);title(['wl' num2str(wavelength(m)) '_bw' num2str(bandwidth)]);
    
end

gb=gb_result;








    
    
    
        
            
        
        
        
    
    
    





