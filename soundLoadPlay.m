% function soundLoadPlay()

% May want to convert m4a to wav, to use wavread. 
% Could use audioread and audiowrite. 
% my_sound = wavread('my_wav_file.wav');

sampleRate = 96000; % may need to adjust for diff audiocard
my_m4a = audioread('/Users/katieshak/Downloads/Clap1sec.m4a');
my_player = audioplayer(my_m4a,sampleRate);

% playback controls:
play(my_player);
% pause(my_player);
% resume(my_player);
% stop(my_player);
