function saveaseps(scriptName,colour)
% SAVEASEPS Output all figures from a script in EPS format.
%
%     Runs the MATLAB script scriptName to output the figures in EPS
%     format, without embedded thumbnails, within a subfolder called
%     /html. The logical colour specifies the output as colour or black and
%     white.
%
%     SAVEASEPS('script.m', true) outputs a colour figure, where script.m
%     is the MATLAB script which creates the figures.
%     SAVEASEPS('script.m', false) for a black and white figure, where
%     script.m is the MATLAB script which creates the figures. 
%
% T.C. Sykes (mm13tcs@leeds.ac.uk)
% University of Leeds (2019)

if colour==true
    
    % Encapsulated PostScript® (EPS) Level 3 color
    evalc( strcat('publish(''',scriptName,...
        ''',''imageFormat'',''epsc'',''createThumbnail'',false)') );
    
else
    
    % Encapsulated PostScript® (EPS) Level 3 black and white
    evalc( strcat('publish(''',scriptName,...
        ''',''imageFormat'',''eps'',''createThumbnail'',false)') );
    
end