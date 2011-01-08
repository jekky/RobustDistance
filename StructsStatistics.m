function [structCodes,structLens] = StructsStatistics(structs,G,I)

% length
structLens = [];
structCodes = zeros(length(structs),8);
for idx = 1 : length(structs)
    structLen = length(structs{idx});    
    structLens = [structLens;structLen];
    
    code = zeros(1,8);
    struct = structs{idx};
    
    for idx2 = 1 : length(struct)
        for idx3 = 1 : length(struct)
            if (G(struct(idx2),struct(idx3))>0)
                [y1,x1] = ind2sub(size(I),struct(idx2));
                [y2,x2] = ind2sub(size(I),struct(idx3));
                if (y2-y1==-1 && x2-x1==-1)
                    code(1) = code(1)+abs(double(I(y1,x1))-double(I(y2,x2)));
                end
                if (y2-y1==-1 && x2-x1==0)
                    code(2) = code(2)+abs(double(I(y1,x1))-double(I(y2,x2)));
                end
                if (y2-y1==-1 && x2-x1==1)
                    code(3) = code(3)+abs(double(I(y1,x1))-double(I(y2,x2)));
                end
                if (y2-y1==0 && x2-x1==-1)
                    code(4) = code(4)+abs(double(I(y1,x1))-double(I(y2,x2)));
                end
                if (y2-y1==0 && x2-x1==1)
                    code(5) = code(5)+abs(double(I(y1,x1))-double(I(y2,x2)));
                end
                if (y2-y1==1 && x2-x1==-1)
                    code(6) = code(6)+abs(double(I(y1,x1))-double(I(y2,x2)));
                end
                if (y2-y1==1 && x2-x1==0)
                    code(7) = code(7)+abs(double(I(y1,x1))-double(I(y2,x2)));
                end
                if (y2-y1==1 && x2-x1==1)
                    code(8) = code(8)+abs(double(I(y1,x1))-double(I(y2,x2)));
                end                
            end
        end
    end
    
    [maxCode,maxIdx] = max(code);
    code2 = [code(maxIdx:end),code(1:maxIdx-1)];
    code = code2;
    
    structCodes(idx,:) = code./length(struct);
end

%length(find(structLens>20))
%figure,hist(structLens);