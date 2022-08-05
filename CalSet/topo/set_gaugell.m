clear
close all

dmlat = [34, 37; ... % Omaezaki
         35,  1; ... % Shimizu
         35,  1; ... % Uchiura
         34, 37; ... % Irozaki
         34,  3; ... % Miyakejima
         34, 47; ... % Okada
         35, 14; ... % Odawara
         35, 39; ... % Tokyo
         34, 55; ... % Mera
        ];

dmlon = [138, 13; ... % Omaezaki
         138, 31; ... % Shimizu
         138, 53; ... % Uchiura
         138, 51; ... % Irozaki
         139, 33; ... % Miyakejima
         139, 23; ... % Okada
         139,  9; ... % Odawara
         139, 46; ... % Tokyo
         139, 50; ... % Mera
        ];


dlon = dm2degrees(dmlon);
dlat = dm2degrees(dmlat);

lonlat = [dlon, dlat];