function Output_Image = My_denoising_v2 (Input_Image) 
    input_dimension = size(Input_Image);
    Output_Image = double(zeros(input_dimension(1), input_dimension(2)));
    pad = (3-1)/2;
    %padding
    temp1 = Input_Image(:,input_dimension(2));
    temp2 = Input_Image(:,1);
    for i = 1 : pad
        Input_Image = horzcat(Input_Image, temp1);
        Input_Image = horzcat(temp2, Input_Image);
    end
    temp1 = Input_Image(input_dimension(1),:);
    temp2 = Input_Image(1,:);
    for i = 1 : pad
        Input_Image = vertcat(Input_Image, temp1);
        Input_Image = vertcat(temp2, Input_Image);
    end
    
    for i = 1 : input_dimension(1)
        for j = 1 : input_dimension(2)
            for pad = 1 : 7
                in_i = i+1;
                in_j = j+1;
                if (Input_Image(in_i,in_j)~=0 && Input_Image(in_i,in_j)~=1)
                    Output_Image(i, j) = Input_Image(in_i,in_j);
                    break;
                else
                    avg = 0;
                    num = 0;
                    for m = -pad : pad
                        for n = -pad : pad
                            if (in_i+n>=1 && in_i+n<=input_dimension(1)+1 && in_j+m>=1 && in_j+m<=input_dimension(2)+1)
                                if (Input_Image(in_i+n,in_j+m)~=0 && Input_Image(in_i+n,in_j+m)~=1)
                                    num = num + 1;
                                    avg = avg + Input_Image(in_i+n,in_j+m);
                                end
                            end
                        end
                    end
                    if num~=0
                        Output_Image(i, j) = avg/num;
                        break;
                    elseif pad == 15
                        Output_Image(i, j) = 0.5;
                    end
                end
            end
        end
    end
end