function [roughnessImage] = calcSurfaceRoughness(handles, undercutsEliminated)
[~, width] = size(handles.imgOriginal);
faktor = get(handles.NumberofsectionsalongpicturewidthEditField, 'Value');
aufteilung = width/faktor;
boundary = realeKontur(~undercutsEliminated);
roughnessImage = ~undercutsEliminated;
letzteZeile = 0;
for j=1:faktor
    % letzten Punkt in boundary() ermitteln, der zur aktuellen Section
    % gehuert
    letzteZeileVorher = letzteZeile + 1;
    letzteZeileaktuell = aufteilung*10 + letzteZeileVorher;
    endeSection = round(j*aufteilung);
    for i=letzteZeileVorher:letzteZeileaktuell
        if boundary(i,2) >= endeSection
            letzteZeile = i;
            break;
        end
    end
    % Finden des jeweiligen Maximums, eintragen dessen Koordinaten in Array
    a = letzteZeileVorher;
    b = letzteZeile;
    MaxSection = min(boundary(a:b,1));
    MinSection = max(boundary(a:b,1));
    %     punktLinie = MaxSection  - 1; % so sitzt die horizontale Linie auf
    %     Max
    punktLinie = MaxSection - 2; % 1-pixel Abstand zum Max.
    %horizontale Linie zeichnen
    for d=round(((j-1)*aufteilung + 1)):round((j*aufteilung))
        roughnessImage(punktLinie,d) = 1;
    end
    %senkrechte Linie nach unten ziehen
    abstand = MinSection-punktLinie;
    if j>1
        for i=0:(abstand)
            roughnessImage(punktLinie + i,round(j*aufteilung)) = 1;
            roughnessImage(punktLinie + i,round((j-1)*aufteilung)) = 1;
        end
    end
    if j==1
        for i=0:(abstand)
            roughnessImage(punktLinie + i,round(j*aufteilung)) = 1;
        end
    end
end

%% tried it myself - didn't work 
%%%%%%%%%%%%%%%%%%
% for j = 1 : faktor
%     %% calculate parameters for this section
%     startSection = round((j - 1) * aufteilung) + 1;
%     endSection = round((j) * aufteilung);
%     MaxSection = min(boundary(startSection : endSection, 1));
%     MinSection = max(boundary(startSection : endSection, 1));
%     heightSection = abs(MinSection - MaxSection);
%     disp(['Section ', num2str(j), ' shows ', num2str(heightSection), ' px. depth.'])
%     punktLinie = MaxSection - 2; % 1-pixel Abstand zum Max. - sonst später getrennte Pore
%     %% draw horizontal lines
%     for d = startSection : endSection
%         roughnessImage(punktLinie, d) = 0;
%     end
%     %% draw vertical lines
%     abstand = MinSection - punktLinie;
%     if j > 1
%         for i = 0 : abstand
%             roughnessImage(punktLinie + i, startSection - 1) = 0;
%             roughnessImage(punktLinie + i, endSection) = 0;
%         end
%     end
%     if j == 1
%         for i = 0 : abstand
%             roughnessImage(punktLinie + i, endSection) = 0;
%         end
%     end
% end
% 
% figure
% imshow(FifthStepImage)
% hold on
% plot(boundary(:,2), boundary(:,1), '--gs',...
%     'LineWidth',2,...
%     'MarkerSize',2,...
%     'MarkerEdgeColor','b',...
%     'MarkerFaceColor',[0.5,0.5,0.5])

end