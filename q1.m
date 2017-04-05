C1 = [[0.1;1.1] [6.8;7.1] [-3.5;-4.1] [2.0;2.7] [4.1;2.8] [3.1;5.0] [-0.8; -1.3] [0.9;1.2] [5.0;6.4] [3.9;4.0]];
C2 = [[7.1;4.2] [ -1.4;-4.3] [4.5;0.0] [6.3;1.6] [4.2;1.9] [1.4;-3.2] [2.4;-4.0] [2.5;-6.1] [8.4;3.7] [4.1;-2.2]];
C1 = vertcat(C1,ones(1,length(C1))); %<-- augmented data of class 1
C2 = vertcat(C2,ones(1,length(C2))); %<--- augmented data of class 2
label=[ones(1,length(C1)),-ones(1,length(C2))]; %<-- label of data
hold on;
scatter(C1(1,:),C1(2,:),'r^'); %<-- data plotting for class 1
scatter(C2(1,:),C2(2,:),'go');%<-- data plotting for class 2
C = [C1,C2];
eta = .01; %<--- learning rate
update = 0;
iteration = 0; %<-- to count iteration number
W = [0;0;0]; %<--- augmented weight vector
flag =1;
while(flag == 1)
    flag = 0;
    update = update+1;
    li = 0 ;%<---label index
    for Ci = C
        li = li+1;
        if(W'*Ci*label(li) <= 0) %<--- condition for perceptron
            W = W + eta*label(li)*Ci;
            flag = 1;
            iteration = iteration+1;
        end
    end
end
disp(iteration);  %<--- to display number of iteration
disp(update);
disp(W);
A = W(1,1);
B = W(2,1);
C = W(3,1);
X = -6:1:12;
plot(X, (-C-A*X)/B,'b'); %<--- to display classifier
h = zeros(3, 1);
h(1) = plot(NaN,NaN,'^r');
h(2) = plot(NaN,NaN,'og');
h(3) = plot(NaN,NaN,'b');
legend(h, 'Class C1','Class C2','Classifier');
title('Classifier of Data C1 & C2')