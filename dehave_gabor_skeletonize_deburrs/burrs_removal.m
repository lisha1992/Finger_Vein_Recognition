function skel = burrs_removal(BW)
L = bwlabel(BW, 8);
S = regionprops(L, 'Area');
BW = ismember(L, find([S.Area] > 100));
BW2=1-BW;

%% skeletonize
skel = bwmorph(BW2,'thin', Inf); 
figure;imshow(skel);title('before deburrs');
%% Edge cutting
skel = skel(size(skel,1)/50:size(skel, 1)-size(skel,1)/50, size(skel,2)/50:size(skel, 2)-size(skel,2)/50); 

burrs_len = 20;
flag =1;
while flag
    cleaned = de_small_region(skel);
    endp = bwmorph(cleaned, 'endpoints');
    [end_y,end_x] = find(endp);
    branch = bwmorph(cleaned, 'branchpoints');
    mask = zeros(size(cleaned));
    for k = 1:numel(end_x)
        dist = bwdistgeodesic(logical(cleaned), end_x(k),end_y(k));
        dist_end2branch = min(dist(find(branch)));
        if dist_end2branch < burrs_len
            mask(dist < dist_end2branch) =true;
        end
    end
    skel2=cleaned-mask;
    skel = skel2;
    
    cleaned_2 = de_small_region(skel);
    endp = bwmorph(cleaned_2, 'endpoints');
    [end_y,end_x] = find(endp);
    branch = bwmorph(cleaned_2, 'branchpoints');
    min_dist =[];
    for k = 1:numel(end_x)
        dist = bwdistgeodesic(logical(cleaned_2), end_x(k),end_y(k));
        dist_end2branch = min(dist(find(branch)));
        min_dist = [min_dist; dist_end2branch];
    end
    if sum(min_dist<burrs_len)>=1
        flag = 1;
    else
        flag = 0;
    end
  %  skel = de_small_region(skel);
end

skel_new = de_small_region(skel);
figure;imshow(skel_new);title('skeleton');
skel=skel_new;