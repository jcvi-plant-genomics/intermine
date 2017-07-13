--
-- manually update organisms
--

UPDATE organism SET
genus='Medicago', species='truncatula A17',
shortname='M. truncatula A17', name='Medicago truncatula', commonname='barrel medic'
WHERE taxonid=3880 and variety='A17';

UPDATE organism SET 
genus='Medicago', species='truncatula R108',
shortname='M. truncatula R108', name='Medicago truncatula', commonname='barrel medic'
WHERE taxonid=3880 and variety='R108';
