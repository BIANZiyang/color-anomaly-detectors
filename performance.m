% algorithms to performance test
algos = {@rxg, @rxl, @dwest, @nswtd, @mwnswtd, @pcag, @mwpcag, @pcad, @knna};
algos_nice = {'Global RX', 'Local RX', 'DWEST', 'NSWTD', 'MW-NSWTD', 'PCAG', 'MW-PCAG', 'PCAD', 'KNN'};

% scenes to compare
scene_files = {'beach.jpg', 'desert.jpg', 'island.jpg'};

% results
tbl = zeros(numel(algos), numel(scene_files));

for i = 1:numel(algos)
    cb = algos{i};
    
    for j = 1:numel(scene_files)
        % load scene
        scene = scene_files{j};
        s = load(sprintf('output/%s.mat', scene), 'scene');
        img = s.scene;
        
        % profile
        t = cputime;
        a = cb(img);
        e = cputime - t;
        
        % store result
        tbl(i, j) = e;
    end
end

% bar plot
b = bar(tbl);
ylabel('Average time (s)');
xlabel('Algorithm');
set(gca, 'XTickLabel', algos_nice);
title('Execution Time');
print(gcf, 'exec.png', '-dpng', '-r300');