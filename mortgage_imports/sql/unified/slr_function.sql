CREATE FUNCTION slr_mapper AS
(
    (slr_name) ->
        CASE
            WHEN position(slr_name,'aurora') = 1 THEN 'aurora'
            WHEN position(slr_name,'branch banking') = 1 THEN 'bb&t'
            WHEN position(slr_name,'bvrt') = 1 THEN 'bvrt'
            WHEN position(slr_name,'cenlar') = 1 THEN 'cenlar'
            WHEN position(slr_name,'cardinal') = 1 THEN 'cardinal'
            WHEN position(slr_name,'charter one') = 1 THEN 'charter one'
            WHEN position(slr_name,'chase home') = 1 THEN 'chase home'
            WHEN position(slr_name,'chase ') = 1 THEN 'chase'
            WHEN position(slr_name,'caliber') = 1 THEN 'caliber'
            WHEN position(slr_name,'chicago') = 1 THEN 'chicago'
            WHEN position(slr_name,'citimortgage') = 1 THEN 'citi'
            WHEN position(slr_name,'citizens bank') = 1 THEN 'citizens'
            WHEN position(slr_name,'cmg') = 1 THEN 'cmg'
            WHEN position(slr_name,'colonial savings') = 1 THEN 'colonial'
            WHEN position(slr_name,'fannie mae/ditech') = 1 THEN 'ditech'
            WHEN position(slr_name,'countrywide') = 1 THEN 'countrywide'
            WHEN position(slr_name,'ditech') = 1 THEN 'ditech'
            WHEN position(slr_name,'dlj mortgage') = 1 THEN 'dlj'
            WHEN position(slr_name,'fifth third') = 1 THEN 'fifth third'
            WHEN position(slr_name,'first horizon') = 1 THEN 'first horizon'
            WHEN position(slr_name,'first tennessee') = 1 THEN 'first horizon'
            WHEN position(slr_name,'flagstar ') = 1 THEN 'flagstar'
            WHEN position(slr_name,'freedom mortgage') = 1 THEN 'freedom mortgage'
            WHEN position(slr_name,'ge') = 1 THEN 'ge'
            WHEN position(slr_name,'gmac mortgage') = 1 THEN 'gmac'
            WHEN position(slr_name,'greenpoint mortgage') = 1 THEN 'greenpoint'
            WHEN position(slr_name,'guild mortgage') = 1 THEN 'guild'
            WHEN position(slr_name,'hsbc bank') = 1 THEN 'hsbc'
            WHEN position(slr_name,'home point') = 1 THEN 'home point'
            WHEN position(slr_name,'indymac') >= 1 THEN 'indymac'
            WHEN position(slr_name,'nationstar') >= 1 THEN 'mr cooper'
            WHEN position(slr_name,'national city') = 1 THEN 'nat city'
            WHEN position(slr_name,'jp') = 1 THEN 'jp morgan'
            WHEN position(slr_name,'loanpal') = 1 THEN 'loanpal'
            WHEN position(slr_name,'m&t') = 1 THEN 'm&t'
            WHEN position(slr_name,'manufacturers and traders') = 1 THEN 'm&t'
            WHEN position(slr_name,'metlife') = 1 THEN 'metlife'
            WHEN position(slr_name,'mufg') = 1 THEN 'mufg'
            WHEN position(slr_name,'nationsbank') = 1 THEN 'nationsbank'
            WHEN position(slr_name,'paramount') = 1 THEN 'paramount'
            WHEN position(slr_name,'pennymac') = 1 THEN 'pennymac'
            WHEN position(slr_name,'phh') = 1 THEN 'phh'
            WHEN position(slr_name,'pmt') = 1 THEN 'pmt'
            WHEN position(slr_name,'pnc ') = 1 THEN 'pnc'
            WHEN position(slr_name,'primelending') = 1 THEN 'primelending'
            WHEN position(slr_name,'principal residential') = 1 THEN 'principal'
            WHEN position(slr_name,'pulte') = 1 THEN 'pulte'
            WHEN position(slr_name,'quicken') = 1 THEN 'quicken'
            WHEN position(slr_name,'regions ') = 1 THEN 'regions'
            WHEN position(slr_name,'rrac') = 1 THEN 'rrac'
            WHEN position(slr_name,'santander') = 1 THEN 'santander'
            WHEN position(slr_name,'select') = 1 THEN 'select'
            WHEN position(slr_name,'seneca') = 1 THEN 'seneca'
            WHEN position(slr_name,'sovereign') = 1 THEN 'sovereign'
            WHEN position(slr_name,'specialized') = 1 THEN 'specialized'
            WHEN position(slr_name,'stearns') = 1 THEN 'stearns'
            WHEN position(slr_name,'taylor') = 1 THEN 'taylor'
            WHEN position(slr_name,'texas capital') = 1 THEN 'texas capital'
            WHEN position(slr_name,'suntrust') = 1 THEN 'truist'
            WHEN position(slr_name,'truist') = 1 THEN 'truist'
            WHEN position(slr_name,'united shore') = 1 THEN 'united shore'
            WHEN position(slr_name,'u.s. bank') = 1 THEN 'us bank'
            WHEN position(slr_name,'usaa') = 1 THEN 'usaa'
            WHEN position(slr_name,'washington mutual') = 1 THEN 'wamu'
            WHEN position(slr_name,'wells fargo') = 1 THEN 'wfc'
            ELSE slr_name
        END)