% This code is used for cue dependent fear conditioning of rats.
%
% Latest verstion is available in Github
% (https://github.com/yuichi-takeuchi/CueFearConditioning)
%
% Lisence:
% MIT License
%

%% Day 1: habituation
InterSoundIntervals = 20 + floor(100*rand(1,10));
for i = 1:120
   fprintf('habituation: %d s\n', i) 
   pause(1)
end
for i = 1:5
    fprintf('trial %d\n', i)
    [playerObj] = bhf_SineSoundBackground( 7500, 30 );
    pause(30)
    stop(playerObj)
    pause(InterSoundIntervals(2*i - 1))
    [playerObj] = bhf_SineSoundBackground( 2500, 30 );
    pause(30)
    stop(playerObj)
    pause(InterSoundIntervals(2*i))
end
disp('done')
clear i InterSoundIntervals playerObj

%% Day 2: conditioning
InterSoundIntervals = 100 + floor(20*rand(1,10));
binaryOn = [1 0 0 0];
binaryOff = [0 0 0 0];
d = daq.getDevices;
s = daq.createSession('ni');
addDigitalChannel(s, d.ID, 'Port0/Line0:3','OutputOnly');
outputSingleScan(s, binaryOff);

for i = 1:10
    fprintf('habituation: %d s\n', i) 
    pause(1)
end
for i = 1:5
    fprintf('trial %d\n', i)
    [playerObj] = bhf_SineSoundBackground( 7500, 30 );
    pause(28)
    outputSingleScan(s, binaryOn);
    pause(2)
    outputSingleScan(s, binaryOff);
    stop(playerObj)
    pause(InterSoundIntervals(2*i - 1))
    [playerObj] = bhf_SineSoundBackground( 2500, 30 );
    pause(28)
    stop(playerObj)
    pause(InterSoundIntervals(2*i))
end
outputSingleScan(s, [0 0 0 0]);
disp('done')
clear i InterSoundIntervals playerObj d s binaryOn binaryOff

%% Day 3: test
ToneHz = 7500; % 7500 or 2500
InterSoundIntervals = 20 + floor(100*rand(1,5));
for i = 1:120
   fprintf('habituation: %d s\n', i) 
   pause(1)
end
for i = 1:5
    fprintf('trial %d\n', i)
    [playerObj] = bhf_SineSoundBackground( ToneHz, 30 );
    pause(30)
    stop(playerObj)
    pause(InterSoundIntervals(i))
end
disp('done')
clear i InterSoundIntervals playerObj ToneHz

%% Day 4: test
ToneHz = 7500; % 7500 or 2500
InterSoundIntervals = 20 + floor(100*rand(1,20));
for i = 1:120
   fprintf('habituation: %d s', i) 
   pause(1)
end
for i = 1:5
    fprintf('trial %d\n', i)
    [playerObj] = bhf_SineSoundBackground( ToneHz, 30 );
    pause(30)
    stop(playerObj)
    pause(InterSoundIntervals(i))
end
disp('done')
clear i InterSoundIntervals playerObj ToneHz
