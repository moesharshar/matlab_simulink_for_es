%%
% traffic light position, filling color, and curvatue.
TL_POS = [20 15 10 30];
TL_FACE_COLOR = [0 0 0];
TL_CURVATURE = 0.2;

% same radius and X center for all three circles.
RADIUS = 4;
CENTER_X = 25;

% Red, Yellow, and Green centers on Y axis.
RED_CENTER_Y = 40;
YELLOW_CENTER_Y = 30;
GREEN_CENTER_Y = 20;


trafficLight_Head = rectangle('Position', TL_POS,...
    'FaceColor', TL_FACE_COLOR ,...
    'Curvature', TL_CURVATURE );

redCircle = rectangle('Position', [CENTER_X-RADIUS, RED_CENTER_Y-RADIUS, RADIUS*2, RADIUS*2],...
    'Curvature', 1,...
    'FaceColor', [1 0 0]);
yellowCircle = rectangle('Position', [CENTER_X-RADIUS, YELLOW_CENTER_Y-RADIUS, RADIUS*2, RADIUS*2],...
    'FaceColor', [0.6 0.6 0],...
    'Curvature', 1);
greenCircle = rectangle('Position', [CENTER_X-RADIUS, GREEN_CENTER_Y-RADIUS, RADIUS*2, RADIUS*2],...
    'FaceColor', [0 1 0],...
    'Curvature', 1);

trafficLight_Base = rectangle('Position', [24 5 2 10],...
    'FaceColor' , [0.5 0.5 0.5],...
    'Curvature', 0.2 );

hold on;

%line_1 = line([24 26], [10 13], 'Color', [1 1 0], 'LineWidth', 2);
x = [24, 24, 26, 26];
y = [10, 11, 14, 13];
fill(x, y, 'y');
fill(x, y-4, 'y');
%pgon1 = polyshape([24 24 26 26],[10 11 13])
%plot(pgon1)

xlim([0 50]);
ylim([0 50]);
grid on;

while 1
    redCircle.FaceColor = [1 0 0];
    greenCircle.FaceColor = [0 0.6 0];
    pause(1);
    
    redCircle.FaceColor = [0.5 0 0];
    yellowCircle.FaceColor = [1 1 0];
    pause(1);
    
    yellowCircle.FaceColor = [0.6 0.6 0];
    greenCircle.FaceColor = [0 1 0];
    pause(1);
end
%%