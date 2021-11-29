CREATE FUNCTION serv_mapper AS
(
    (serv_name) ->
             CASE
                WHEN position(serv_name,'aurora') = 1 THEN 'aurora'
                WHEN position(serv_name,'cenlar') = 1 THEN 'cenlar'
                WHEN position(serv_name,'chase ') = 1 THEN 'chase'
                WHEN position(serv_name,'citimortgage') = 1 THEN 'citi'
                WHEN position(serv_name,'citizens bank') = 1 THEN 'citizens'
                WHEN position(serv_name,'colonial savings') = 1 THEN 'colonial'
                WHEN position(serv_name,'fannie mae/ditech') = 1 THEN 'ditech'
                WHEN position(serv_name,'ditech') = 1 THEN 'ditech'
                WHEN position(serv_name,'dlj mortgage') = 1 THEN 'dlj'
                WHEN position(serv_name,'fifth third') = 1 THEN 'fifth third'
                WHEN position(serv_name,'first horizon') = 1 THEN 'first horizon'
                WHEN position(serv_name,'first tennessee') = 1 THEN 'first horizon'
                WHEN position(serv_name,'flagstar ') = 1 THEN 'flagstar'
                WHEN position(serv_name,'freedom mortgage') = 1 THEN 'freedom mortgage'
                WHEN position(serv_name,'gmac mortgage') = 1 THEN 'gmac'
                WHEN position(serv_name,'greenpoint mortgage') = 1 THEN 'greenpoint'
                WHEN position(serv_name,'guild mortgage') = 1 THEN 'guild'
                WHEN position(serv_name,'hsbc bank') = 1 THEN 'hsbc'
                WHEN position(serv_name,'indymac') >= 1 THEN 'indymac'
                WHEN position(serv_name,'nationstar') >= 1 THEN 'mr cooper'
                WHEN position(serv_name,'jp') = 1 THEN 'jp morgan'
                WHEN position(serv_name,'m&t') = 1 THEN 'm&t'
                WHEN position(serv_name,'manufacturers and traders') = 1 THEN 'm&t'
                WHEN position(serv_name,'metlife') = 1 THEN 'metlife'
                WHEN position(serv_name,'mufg') = 1 THEN 'mufg'
                WHEN position(serv_name,'pennymac') = 1 THEN 'pennymac'
                WHEN position(serv_name,'pnc ') = 1 THEN 'pnc'
                WHEN position(serv_name,'principal residential') = 1 THEN 'principal'
                WHEN position(serv_name,'quicken') = 1 THEN 'quicken'
                WHEN position(serv_name,'regions ') = 1 THEN 'regions'
                WHEN position(serv_name,'select') = 1 THEN 'select'
                WHEN position(serv_name,'seneca') = 1 THEN 'seneca'
                WHEN position(serv_name,'specialized') = 1 THEN 'specialized'
                WHEN position(serv_name,'suntrust') = 1 THEN 'truist'
                WHEN position(serv_name,'truist') = 1 THEN 'truist'
                WHEN position(serv_name,'u.s. bank') = 1 THEN 'us bank'
                WHEN position(serv_name,'usaa') = 1 THEN 'usaa'
                WHEN position(serv_name,'washington mutual') = 1 THEN 'wamu'
                WHEN position(serv_name,'wells fargo') = 1 THEN 'wfc'
                ELSE serv_name
        END
);
