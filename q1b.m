C1 = [[-3.0;-2.9] [.5;8.7] [2.9;2.1] [-0.1;5.2] [-4.0;2.2] [-1.3;3.7] [-3.4;6.2] [-4.1;3.4] [-5.1;1.6] [1.9;5.1]];
C2 = [[7.1;4.2] [ -1.4;-4.3] [4.5;0.0] [6.3;1.6] [4.2;1.9] [1.4;-3.2] [2.4;-4.0] [2.5;-6.1] [8.4;3.7] [4.1;-2.2]];
C1 = vertcat(C1,ones(1,length(C1))); %<-- augmented data of class 1
C2 = vertcat(C2,ones(1,length(C2))); %<--- augmented data of class 2
label=[ones(1,length(C1)),-ones(1,length(C2))]; %<-- label of data
hold on;
scatter(C1(1,:),C1(2,:),'ro'); %<-- data plotting for class 1
scatter(C2(1,:),C2(2,:),'g^');%<-- data plotting for class 2
C = [C1,C2];
eta = .001; %<--- learning rate
iteration = 0; %<-- to count iteration number
W = [0;0;0]; %<--- augmented weight vector
flag =1;
update = 0;
while(flag == 1)
    flag = 0;
    li = 0 ;%<---label index
    update = update+1;
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
X = -10:1:10;
plot(X, (-C-A*X)/B,'b'); %<--- to display classifier
h = zeros(3, 1);
h(1) = plot(NaN,NaN,'or');
h(2) = plot(NaN,NaN,'^g');
h(3) = plot(NaN,NaN,'b');
legend(h, 'Class C3','Class C2','Classifier');
title('Classifier of Data C3 & C2')