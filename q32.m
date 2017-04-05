C1 = [[3;3] [3;0] [2;1] [0;1.5]];
C2 = [[-1;1] [0;0] [-1;-1] [1;0]];
UC1=[]; %<--- (mean-element) of class 1
UC2=[]; %<--- (mean-element) of class 2
u1 = mean(C1,2); %<---mean of class 1
u2 = mean(C2,2); %<---mean of class 2
for c1=C1
   d = u1-c1;
   UC1 = [UC1,d];
end
for c2=C2
   d = u2-c2;
   UC2 = [UC2,d];
end
S1 =zeros(2,2);  %<---- sum scatter matrix of class 1
S2 =zeros(2,2);  %<---- sum scatter matrix of class 2
for U = UC1 %<---to find scatter matrix sum for class 1
    A = U*U';
    S1 = S1+A;
end
for U = UC2  %<---to find scatter matrix sum for class 2
    A = U*U';
    S2 = S2+A;
end
SW = S1+S2; %<---- Total sum of SCATTER MATRIX
U = u1-u2;  %<--- differnce between mean
ISW = inv(SW); %<--- Inverse of scatter matrix
e = ISW*U;  %<--- Direction of vector of projection
m = e(2)/e(1);  %<-- slope of projection line
x = -2:1:5;
y = m*x;
plot(x,y); %<--- to print projection line
e = e/norm(e); %<-- to find unit vector in dirction of e
hold on;
Temp = [];
for i = C1
    plot(i(1),i(2),'ro');  %<--- to print point
    poL = dot(i,e);
    proP = poL*e; %<--- projected point on line
    Temp = [Temp,proP];
    plot([ i(1) proP(1)] ,[i(2) proP(2)],'r--'); %<--- to draw line
hold on;
end
for i = C2
    plot(i(1),i(2),'g^');
    poL = dot(i,e);
    proP = poL*e;
    Temp = [Temp,proP];
    plot([ i(1) proP(1)] ,[i(2) proP(2)],'g--');
end
Temp = vertcat(Temp,ones(1,length(Temp)));
C1 = vertcat(C1,ones(1,length(C1))); %<---- augmented C1
C2 = vertcat(C2,ones(1,length(C2))); %<---- augmented C2
label=[ones(1,length(C1)),-ones(1,length(C2))];
W = [0;0;0];
eta = .02;
epoc =10000;
C = [C1,C2];
W = perceptron(Temp, label,epoc, eta, W);%<-- weight vector
A = W(1,1);
B = W(2,1);
CW = W(3,1);
X = [-1:1:2];
plot(X, (-CW-A*X)/B,'c'); %<--- to display classifier
eta = .01; %<-- learing rate
W = [0;0;0]; %<---- augmented weight vector
b = 1.5; %<---- margin
threshold = 0.02;
err = 10;

while (err > threshold)
    li = 0;
    for Ci = C
	li = li+1;
        err = norm(eta*(b-W'*Ci*label(li))*Ci);
        if err > threshold
	        W = W + eta*(b-W'*Ci*label(li))*Ci*label(li);
        end  
    end  
end
A = W(1,1);
B = W(2, 1);
C = W(3,1);
X = -2:1:4;
plot(X, (-C-A*X)/B,'k');
h = zeros(7, 1);
h(1) = plot(NaN,NaN,'ro');
h(2) = plot(NaN,NaN,'g^');
h(3) = plot(NaN,NaN,'b');
h(4) = plot(NaN,NaN,'r--');
h(5) = plot(NaN,NaN,'g--');
h(6) = plot(NaN,NaN,'c');
h(7) = plot(NaN,NaN,'k');

legend(h, 'Class C1','Class C2','FLDA','projection of C1 on flda','projection of C2 on flda','linear sepration of flda Data','LMS');