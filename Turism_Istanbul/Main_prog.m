% Main Program
clc 
clear 
close all 
%% Start the timer
tic;

%% User Inputs
inputs.budget = input('Enter your budget: '); % 2000 is used 
load('Places.mat'); % Istanbul Museums
inputs.data = Places;
inputs.begin = inputs.data(6,:); % The Starting Place in the route
inputs.ObjectFunction = @Fitness;
inputs.nPlaces = length(inputs.data); % Number of places in the route

%% The parameters used in GA
parameters.nGen = 100;  % Number of iterations (#Generations)
parameters.nRoute = 100; % Population size (#Routes)
parameters.pOff = 1; % Offsprings Percentage
parameters.pMut = 0.1; % Percentage related to Mutation

%% Executing the GA 
output = GA(inputs, parameters);

%% Figures
figure;
hold on;
plot(Norm(output.bestfit),'r');
plot(Norm(output.bestcost),'g');
plot(Norm(output.bestdistance),'b');
plot(Norm(output.besttime),'black');
xlabel('Generations');
ylabel('Best Solutions');
legend('Fitness','Cost','Distance','Time','Location', 'northeast')
grid on;
hold off;

%% Stop the timer and display the elapsed time
elapsedTime = toc;
disp(['Elapsed time: ', num2str(elapsedTime), ' seconds']);
