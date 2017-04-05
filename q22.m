filename = '/home/balda/Dropbox/sem2/smai/assignment/ionosphere.csv';
M = csvread(filename);  %<----reading csv file
label=[];  %<----label vector
data =[];  %<---data set with augement data
for i=1:1:length(M)
    d = M(i,1:end-1); %<----------selecting feature vector
    d = [d,1];  %<--------adding augmented element 
    d=d';
    l = M(i,end);
    if( l == 2)
      label = [label,1]; %<-- to assign label
    else
      label = [label,-1];
    end
    data = [data,d]; %<--- adding data 
end
epoches =[10,15,20,25,30,35,40,45,50];
w = zeros(1,35);  %<-- weight vector
w = w';
eta = 0.01; %< learing rate
k=10;
hold on;
CVO = cvpartition(label,'KFold',k);
accVot=[];
accVan=[];
for i = 1:length(epoches)
   epoc = epoches(i);
  
   accuracyVoted = 0;
   accuracyPer = 0;
   
   for j = 1:k
      w =zeros(1,35); 
      w = w';
      testData = [];
      testDataLabel = [];
      trainingData = [];
      trainingDataLabel = [];
      teIdx = test(CVO, j);
      teIdx = teIdx';
     
      for idx = 1:length(teIdx)
            if(teIdx(idx) == 1)  
                testData = [testData, data(:, idx)];
                testDataLabel = [testDataLabel, label(idx)];
            else
                trainingData = [trainingData, data(:, idx)];
                trainingDataLabel = [trainingDataLabel, label(idx)];
            end
        end
      [W,C] = voteperceptron(trainingData, trainingDataLabel, epoc, w); %<---W weight vector C-- survivaltimes
      w =zeros(1,35); 
      w = w';
      w = perceptron(trainingData, trainingDataLabel, epoc, eta, w);%<-- weight vector
      accuracyVoted  = accuracyVoted  + accuracyVotedPerceptron(W, C, testDataLabel, testData);
      accuracyPer  = accuracyPer + accuracyPerceptron(w, testData, testDataLabel);
  end 
  accuracyVoted = accuracyVoted/k;
  accuracyPer = accuracyPer/k;
  plot(epoc, accuracyVoted, 'b.');
  plot(epoc, accuracyPer, 'r.');
  xlabel ('Number of Epocs');
  ylabel ('Accuracy');
  accVot = [accVot, accuracyVoted];
  accVan = [accVan, accuracyPer];
end
plot(epoches, accVot, 'b');
plot(epoches, accVan, 'r');
h = zeros(2, 1);
h(1) = plot(NaN,NaN,'b');
h(2) = plot(NaN,NaN,'r-');
legend(h, 'Voted Perceptron', 'Vanilla Perceptron');
