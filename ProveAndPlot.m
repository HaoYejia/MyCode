% function [] = ProveAndPlot(t_max,u,v,d)
t_max = input('Type the max t: ');
u = input('Type the speed of Angie you assume: ');
v = input('Type the speed of Buddy you assume: ');
d = input('Type the initial distacne beween them: ');

% t_max = 10; u = 8.89; v = 17.8; d = 100;

%Create an array containing zeros with amount of t_max+1, as the 
%x-coordinate of A
x_A = linspace(0,0,t_max+1); 

%Create an array of y-coordinate of A, whih general form y_t_A = t * u
y_A = linspace(0,u * t_max, t_max+1); 

%Declare the matrix that store the x-coordinate and y-coordinate of turning
%point of Buddy
% x_B = zeros(1,t_max+1); y_B = zeros(1,t_max+1);
x_B =[]; y_B =[];


%Put the x_A and y_A into A[], the array that store each points of Angie
A = [x_A;y_A];

%The initial position of Buddy
x_B(1) = d; y_B(1) = 0;

%The first move, where Buddy's oriantaiton is assumed to be along x-axis
x_B(2) = d-v; y_B(2) = 0;

%Calculate the broken-line path of Buddy by calculate each point that Buddy
%change its direction
for t=3 :t_max+1
        syms x y;
        
        %The restrect of domain and range, since the euqation would have 
        %two solutions
        assume(x<x_B(t-1)); assume(y>y_B(t-1)); 
        
        %Solve the equation
        [x_B(t),y_B(t)] = solve([y==(((y_A(t-1)- y_B(t-1))/(-1 * x_B(t-1)))*x)+y_A(t-1),sqrt((x-x_B(t-1))^2+(y-y_B(t-1))^2)==v],[x,y]); 
        
        %Escape the loop if the x-coordinate become negatiev, which is not the assumption required
        if x_B(t) <0
            break;
        end
end




 %Calculate the simple linear chasing model in the last few seconds
d_lastBrokenLine = sqrt((x_A(t-1)-x_B(t-1))^2+(y_A(t-1)-y_B(t-1))^2);
x_B(t) = 0; y_B(t) = y_A(t-1);
x_B(t+1) = 0; y_B(t+1) = y_A(t)+(v - d_lastBrokenLine);

x_B(t+2) = 0; y_B(t+2) = y_B(t) + v * (d_lastBrokenLine /  (v-u)) - d_lastBrokenLine;



%Put the x_B and y_B into B[], the array that store each points of Buddy
B = [x_B;y_B];

figure;
plot (x_A,y_A,'k-',x_B,y_B,'g-');
grid on;

time = y_B(length(y_B))/u;
d_A = y_B(length(y_B));
d_B = 0;
for i=2:length(y_B)
    d_B = d_B + sqrt((x_B(i)-x_B(i-1))^2 + (y_B(i)-y_B(i-1)^2));
end
fprintf('done');