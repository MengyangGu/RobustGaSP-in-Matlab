addpath('functions');

% One only need to compile once. 
compile_cpp();

% Example 1: emulating humanity data from the DIAMOND computer model where 
%            the output is the number of casualties over 5 days after catastrophes. 
addpath('data/humanity_data');

humanity_X = dlmread('humanity_X.txt',' ',1,0);
humanity_Y = dlmread('humanity_Y.txt',' ',1,0);

humanity_Xt = dlmread('humanity_Xt.txt',' ',1,0);
humanity_Yt = dlmread('humanity_Yt.txt',' ',1,0);

% parameters for the  ppgasp emulator. Here we assume an estimated nugget
% and intercept.
design=humanity_X;
response=humanity_Y;

options.nugget_est=true;
options.lower_bound=false;


model=ppgasp(design,response,options);



% prediction

pred_model=predict_ppgasp(model,humanity_Xt);


% one may trucate this example as they should be nonnegative
% pred_model.mean(find(pred_model.mean<0))=0;

% predictive root of mean squared error
sqrt(mean((pred_model.mean-humanity_Yt).^2,'all'))

% standard deviation
std(humanity_Yt,0,'all')

% you may trucate predictive interval to be nonnegative for this example
% pred_model.lower95(find(pred_model.lower95<0))=0;
% pred_model.upper95(find(pred_model.upper95<0))=0;

% number of held-out data covered in the nominal 95 precent predictive interval
size(find(humanity_Yt>=pred_model.lower95 ...
    & humanity_Yt<=pred_model.upper95),1)/(size(humanity_Yt,1)*size(humanity_Yt,2))
% average length of confidence interval
mean(pred_model.upper95-pred_model.lower95,'all')

% plot the hold out data and prediction with 95 precent predictive interval

for i=1:5 
    subplot_here=subplot(2,3,i);

    plot(1:120, humanity_Yt(:,i),'r.','DisplayName','test data')
    ylabel('number of casualties')
    xlabel('test number')
    hold on 
    legend(subplot_here)

    error_i=(pred_model.upper95(:,i)-pred_model.lower95(:,i))/2;
    errorbar(1:120,pred_model.mean(:,i),error_i,'b.','DisplayName','prediction');

end

% Example 2: a scalar output function with 2-dimensional input
% For function details and reference information, see:
% http://www.sfu.ca/~ssurjano/

nonpolynomial = @(x) ((30 + 5*x(:,1).*sin(5*x(:,1))).*(4 + exp(-5*x(:,2)))-100)/6;
n=50;
% We generate input by uniform deisng. A better design is the latin hypercube design. See lhsdesign().
x=[rand(n,1) rand(n,1)];
y=nonpolynomial(x);

model=ppgasp(x,y);


% test output
[x1_testing_mat x2_testing_mat]=meshgrid(0:0.02:1,0:0.02:1);

num_testing=length(0:0.02:1)^2;
x_testing=zeros(num_testing,2);
x_testing(:,1)=reshape(x1_testing_mat,[num_testing,1]);
x_testing(:,2)=reshape(x2_testing_mat,[num_testing,1]);

pred_model=predict_ppgasp(model,x_testing);

y_testing=nonpolynomial(x_testing);

% predictive root of mean squared error
sqrt(mean((pred_model.mean-y_testing).^2))
std(y_testing)

size(find(y_testing>=pred_model.lower95 ...
    & y_testing<=pred_model.upper95),1)/(size(y_testing,1)*size(y_testing,2))
% average length of confidence interval
mean(pred_model.upper95-pred_model.lower95,'all')

%make a plot about test output and prediction 
y_testing_mat=reshape(y_testing, [sqrt(num_testing),sqrt(num_testing)]);
pred_model_mean_mat=reshape(pred_model.mean, [sqrt(num_testing),sqrt(num_testing)]);

subplot(1,2,1);

surf(x1_testing_mat,x2_testing_mat,y_testing_mat)
xlabel('input 1')
ylabel('input 2')

view(2)
c1=colorbar;
ylabel(c1, 'test output')
caxis([0 10])


subplot(1,2,2);

surf(x1_testing_mat,x2_testing_mat,pred_model_mean_mat)
xlabel('input 1')
ylabel('input 2')
view(2)
c2=colorbar;
ylabel(c2, 'prediction')
caxis([0 10])

