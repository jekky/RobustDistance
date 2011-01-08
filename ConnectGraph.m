function G = ConnectGraph(I)

G = sparse(size(I,1)*size(I,2),size(I,1)*size(I,2));

for y = 1 : size(I,1)
    for x = 1 : size(I,2)
        pos_max = -inf;
        pos_max_idx = [];
        neg_max = inf;
        neg_max_idx = [];
        for x_offset = -1 : 1
            for y_offset = -1 : 1
                if ((y_offset~=0 || x_offset~=0) && ...
                    y+y_offset>0 && y+y_offset<=size(I,1) &&  ...
                    x+x_offset>0 && x+x_offset<=size(I,2))
                    intDiff = I(y+y_offset,x+x_offset)-I(y,x);
                    if (intDiff>0 && intDiff>pos_max)
                        pos_max = intDiff;
                        pos_max_idx = [y+y_offset,x+x_offset];
                    end
                    if (intDiff>0 && intDiff==pos_max)
                        pos_max_idx = [pos_max_idx;y+y_offset,x+x_offset];
                    end
                    
                    if (intDiff<0 && intDiff<neg_max)
                        neg_max = intDiff;
                        neg_max_idx = [y+y_offset,x+x_offset];
                    end
                    if (intDiff<0 && intDiff==neg_max)
                        neg_max_idx = [neg_max_idx;y+y_offset,x+x_offset];
                    end                    
                end
            end
        end
        
        for idx = 1 : size(pos_max_idx,1)
            end_idx = sub2ind(size(I),pos_max_idx(idx,1),pos_max_idx(idx,2));
            start_idx = sub2ind(size(I),y,x);
            G(start_idx,end_idx)=1;
        end
        for idx = 1 : size(neg_max_idx,1)
            start_idx = sub2ind(size(I),neg_max_idx(idx,1),neg_max_idx(idx,2));
            end_idx = sub2ind(size(I),y,x);
            G(start_idx,end_idx)=1;
        end       
    end
end