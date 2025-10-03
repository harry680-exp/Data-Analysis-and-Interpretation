%%Load Image
clc;
clearvars;
im = (imread('T1.jpg'));
im2_original = (imread('T2.jpg'));



%%Initialization
num_rows  = size(im,1);
num_column = size(im,2);
bins = 26;
bin_width =10;
txr= -10 :10;
disp(txr);
num_shifts = numel(txr);

rho_values =zeros(size(txr));
qmi_values =zeros(size(txr));
mi_values =zeros(size(txr));

%%Update Image
for shift_amt = 1 : num_shifts 
    tx = txr(shift_amt);
    disp(tx);
    im2 = zeros(num_rows,num_column);
    for i = 1: num_rows
        if tx >= 0
            for j = 1: num_column
                if j<(tx+1)
                    im2(i,j) = 0;
                else 
                    im2(i,j) = im2_original(i,j-tx);
                end
            end
        else
            shift = abs(tx);
            for j = 1 : num_column
                if j > num_column - shift
                    im2(i,j) = 0;
                else
                    im2(i,j) =im2_original(i,j+shift);
                end
            end
        end
    end


%%Calculate corellation
   
    imd = double(im);
    im2d =double(im2);
    mean_im =mean(imd(:));
    mean_im2 =mean(im2d(:));
  

    errorsq_im =double(0);
    errorsq_im2 =double(0) ;
    Product_error =double(0);


    for i = 1: num_rows 
        for j = 1: num_column
            error_im = imd(i,j)- mean_im;
            error_im2 = im2d(i,j)-mean_im2;
            Product_error = Product_error+(error_im*error_im2);
            errorsq_im = errorsq_im + (imd(i,j)-mean_im)^2;
            errorsq_im2 = errorsq_im2 + (im2d(i,j)-mean_im2)^2;
        end
    end

    rho = Product_error/sqrt(errorsq_im*errorsq_im2);
    rho_values(shift_amt) = rho;
    disp(rho);



%%QMI

    histogram_im = zeros(bins,bins);
    sumcount = 0;

    for i = 1 :num_rows
        for j = 1: num_column
            if im(i,j) ==0 || im2(i,j)==0
                continue;
            end

        
            binim = min(floor(double(im(i,j))/bin_width)+1,bins);
            binim2 = min(floor(double(im2(i,j))/bin_width)+1,bins);
            sumcount = sumcount +1;
            histogram_im(binim,binim2) = histogram_im(binim,binim2) +1;

        end
    end

    histogram_im =histogram_im/sumcount;

    marginalim = sum(histogram_im,2);

    marginalim2 = sum(histogram_im,1)';


    qmi = 0;
    for i = 1: bins 
        for j = 1: bins
            qmi = qmi + (histogram_im(i,j)- (marginalim(i)*marginalim2(j)))^2;
        end
    end
    qmi_values(shift_amt) = qmi;
    disp(qmi);





%%MI
    MI = 0;


    for i = 1: bins 
        for j = 1: bins
            if histogram_im(i,j) >0  && marginalim(i)>0 && marginalim2(j)>0
                term =log(histogram_im(i,j)) - log(marginalim(i)*marginalim2(j));

                MI = MI + (histogram_im(i,j)*term);
            end
        end
    end
    mi_values(shift_amt) = MI;
    disp(MI);
end

%%Plot Results
figure;
subplot(3,1,1);
plot(txr,rho_values,'g-o');
title('Correlation (\rho) vs. Shift (tx)');
ylabel('Correlation \rho');
grid on;

subplot(3,1,2);
plot(txr,qmi_values,'g-o');
title('QMI vs. Shift (tx)');
ylabel('QMI');
grid on;

subplot(3,1,3);
plot(txr,mi_values,'g-o');
title('Mutual Information (MI) vs. Shift (tx)');
xlabel('Shift tx (pixels)');
ylabel('MI (bits)');
grid on;








    





