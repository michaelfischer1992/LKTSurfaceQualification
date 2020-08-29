function Kontur = realeKontur(img)
    %Finden des Startpunktes fuer die Kontur
    [height,width,~] = size(img);
    
    zaehler =0;
    startB =0;
    for i = 1:height
        if img(i,1) == 1
            if startB == 0
                startB = i;
                zaehler = 1;
            else
                zaehler = zaehler +1;
            end
        end
    end
    
    %Insel ueber der Oberflaeche am linken Rand abfangen
    if zaehler >1
        for i=startB:height
            img(i,1) = 1;
        end
    end
    
    %Auslesen der wahren Kontur
    boundary = bwtraceboundary(img,[startB, 1],'E');
    
    %Länge von 'boundary' auslesen
    [heightBoundary,~] = size(boundary);
        
    %Finden des rechten Randes der Kontur in 'boundary'
    for i =1:heightBoundary
       if boundary(i,2) == width
           endeBoundary = i;
           break;
       end
       if i == heightBoundary
           endeBoundary = i;
       end
    end
    
    Kontur = [boundary(1:endeBoundary,1),boundary(1:endeBoundary,2)];
end