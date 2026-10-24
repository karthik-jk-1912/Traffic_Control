clc
clear
close all

%% STEP 1 — SELECT IMAGE
[file,path] = uigetfile({'*.jpg;*.png;*.jpeg'}, 'Select Traffic Image');

if isequal(file,0)
    disp('No image selected');
    return
end

img = imread(fullfile(path,file));

%% STEP 2 — DISPLAY INPUT IMAGE
figure('Name','Traffic Vehicle Detection')
imshow(img)
title('Traffic Image')
hold on

%% STEP 3 — LOAD VEHICLE DETECTOR
detector = vehicleDetectorACF();

%% STEP 4 — DETECT VEHICLES
[bboxes, scores] = detect(detector, img);

vehicleCount = size(bboxes,1);

%% STEP 5 — DRAW BOUNDING BOXES
for i = 1:vehicleCount
    
    rectangle('Position', bboxes(i,:), ...
        'EdgeColor','red', ...
        'LineWidth',2);

end

%% STEP 6 — TRAFFIC CLASSIFICATION

if vehicleCount >= 12
    trafficLevel = "HEAVY TRAFFIC";
else
    trafficLevel = "LESS TRAFFIC";
end

%% STEP 7 — PRIORITY STATUS

priorityStatus = "NO PRIORITY VEHICLE";

%% STEP 8 — DISPLAY RESULTS IN COMMAND WINDOW

disp('------------------------------------')
disp('Traffic Analysis Result')
disp('------------------------------------')

fprintf('Number of Vehicles Detected : %d\n',vehicleCount);
fprintf('Traffic Condition           : %s\n',trafficLevel);

fprintf('Priority Vehicle Status     : %s\n',priorityStatus);

disp('------------------------------------')

%% STEP 9 — UPDATE IMAGE TITLE

title(['Vehicles Detected: ',num2str(vehicleCount),' | ',trafficLevel])

%% STEP 10 — INFORMATION PANEL

figure('Name','Traffic Information Panel','Color','white')
axis off

text(0.1,0.8,'TRAFFIC ANALYSIS RESULT','FontSize',18,'FontWeight','bold')

text(0.1,0.6,['Vehicles Detected : ',num2str(vehicleCount)],...
    'FontSize',16)

text(0.1,0.45,['Traffic Condition : ',char(trafficLevel)],...
    'FontSize',16)

text(0.1,0.3,['Priority Vehicle : ',char(priorityStatus)],...
    'FontSize',16)
