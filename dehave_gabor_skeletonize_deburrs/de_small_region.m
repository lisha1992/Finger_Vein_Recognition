function cleaned = de_small_region(skel)

%% Eliminate small regions
stats  = regionprops(skel,'Area', 'PixelIdxList');
min_area = 20;
cleaned = skel;
for region = 1 : length(stats)
    if stats(region).Area < min_area
        cleaned(stats(region).PixelIdxList) = 0;
    end
end