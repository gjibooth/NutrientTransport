function saveasbitmap(outputFileName, fileExtension, highQuality)
% SAVEASBITMAP Output the current figure as a bitmap image file.
%
%     Outputs the current figure in bitmap (and pdf) file format, not in
%     RGB form, either matching the screen resolution or with a fixed high
%     resolution (hard coded as 600dpi). The ppi of the figure (which can
%     be set with setfiguresize.m) is respected in either case.
%
%     SAVEASBITMAP('image', 'png', true) outputs a PNG file called
%     image.png, with 600dpi.
%     SAVEASBITMAP('image', 'png', false) outputs a PNG file called
%     image.png, with the screen dpi.
%
%     Options for the file type (extension), assumed as PNG above, are:
%     OPTION    BITMAP IMAGE FORMAT
%     jpeg      JPEG 24-bit
%     png       PNG 24-bit
%     tiff      TIFF 24-bit (compressed)
%     bmp       BMP 24-bit
%     pdf       Full page Portable Document Format (PDF) color
%
% T.C. Sykes (mm13tcs@leeds.ac.uk)
% University of Leeds (2019)

% Construct output file name
outputFile = strcat(outputFileName,'.',fileExtension);

% User confirmation of possible overwriting of the output image
% if exist(outputFile,'file')==2
%     if inputdlg(['Enter true to confirm possible overwrite of ',...
%             'the output image (', outputFile, '): '])~=true
%         
%         disp('Exiting fig_saveFigure (figure not saved)...')
%         return;
%         
%     end
% end

% Save image
if highQuality==false
    
    % Low quality (screen resolution, set size)
    fig = gcf;
    fig.PaperPositionMode = 'auto';
    saveas(gcf, outputFile);
    
else
    
    % High quality (600dpi, unset size)
    formatType = strcat('-d',fileExtension);
    print(gcf,outputFileName,formatType,'-r600');
    
end
