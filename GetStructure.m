function structs = GetStructure(G,I)

access_flag = zeros(size(G,1),1);
cur_idx = 1;
for idx = 1:size(G,1)
    if (access_flag(idx)==0)
        connectedIdx = find(G(idx,:)>0);
%         [y,x] = ind2sub(size(I),idx);
%         [I,J] = ind2sub(size(I),connectedIdx);
%         (I-repmat(y,[size(I),1]))
%         (J-repmat(x,[size(J),1]))
        struct = [idx,connectedIdx];        
        seeds = connectedIdx;
        while (length(seeds>0))
            cur_seed = seeds(1);
            connectedIdx = find(G(cur_seed,:)>0);
            struct = union(struct,connectedIdx(:));
            seeds = union(seeds(2:end),connectedIdx);
        end
        
        connectedIdx = find(G(:,idx)>0);
        struct2 = [connectedIdx];        
        seeds = connectedIdx;
        while (length(seeds>0))
            cur_seed = seeds(1);
            connectedIdx = find(G(:,cur_seed)>0);
            struct2 = union(struct2,connectedIdx(:));
            seeds = union(seeds(2:end),connectedIdx);
        end

        struct = union(struct,struct2);
        
        access_flag(struct) = 1;
%         [struct_y,struct_x] = ind2sub(size(I),struct);
%         close all;
%         figure(2);
%         imshow(I);
%         hold on;
%         plot(struct_x,struct_y,'r+');
%         pause;
        
        structs{cur_idx} = struct;
        cur_idx = cur_idx+1;
    end
end