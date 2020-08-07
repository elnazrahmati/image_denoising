function Output_Image = My_denoising (Input_Image, kernel_size) 
    input_dimension = size(Input_Image);
    Output_Image = double(zeros(input_dimension(1), input_dimension(2)));
    pad = (kernel_size-1)/2;
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
            in_i = i+pad;
            in_j = j+pad;
            if (Input_Image(in_i,in_j)~=0 && Input_Image(in_i,in_j)~=1)
                Output_Image(i, j) = Input_Image(in_i,in_j);
            else
                avg = 0;
                num = 0;
                for m = -pad : pad
                    for n = -pad : pad
                        if (Input_Image(in_i+n,in_j+m)~=0 && Input_Image(in_i+n,in_j+m)~=1)
                            num = num + 1;
                            avg = avg + Input_Image(in_i+n,in_j+m);
                        end
                    end
                end
                if num~=0
                    Output_Image(i, j) = avg/num;
                else
                    Output_Image(i, j) = 0.5;
                end
            end
        end
    end
end