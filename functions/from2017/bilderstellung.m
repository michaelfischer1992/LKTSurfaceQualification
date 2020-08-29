function [NeuErzeugteDateien] = bilderstellung(aktuelleZeile,ErzeugteDateien,fullImageFileName,fileName)

% File-Gr??e berechnen
fileInfo = dir(fullImageFileName);
fileSize = fileInfo.bytes;
% megabyte = cellstr([num2str(round((fileSize/1000000),2)), ' MB']);
megabyte = [num2str(round((fileSize/1000000),2)), ' MB'];

% Informationen in Array ?bernehmen
ErzeugteDateien(aktuelleZeile,1) = num2str(fileName);
ErzeugteDateien(aktuelleZeile,2) = megabyte;

NeuErzeugteDateien = ErzeugteDateien;
