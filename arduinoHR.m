function [data] = arduinoHR
%you need to create this file in the folder before you begin
csvFile = "person10after.csv";

dec = 0;
while dec == 0
    ports = serialportlist('available');
    disp(ports);
    prompt = "What is the port? \n";
    com = input(prompt, 's');
    com = str2num(com); %#ok<*ST2NM>
    disp(ports(com));
    prompt = "Are you sure? (1 = Y, 0 = N) \n";
    dec = input(prompt, 's');
    dec = str2num(dec);
end

port = ports(com);

arduinoObj = serialport(port, 9600);

%sample rate of ~80 samples/sec
%change first number (1000 default should take 12.5 sec) to change recording time
% recommended 25000 for 5 mins
data = zeros(23000,2);
s = size(data);
while arduinoObj.NumBytesAvailable <= 0
end

disp('Recording!');
for i = 1:s(1)
    while arduinoObj.NumBytesAvailable <= 0
    end
    rawData = readline(arduinoObj);
    temp = strsplit(rawData, ',');
    temp2 = temp(2);
    temp2 = char(temp2);
    temp2 = temp2(1:4);
    data(i,1) = str2double(temp(1));
    data(i,2) = str2double(temp2);
end

csvwrite(csvFile, data);

    