with data as (
  select 
    d.cartodb_id as original_id,
    to_timestamp(
      unnest(
        array [
          '27/02/2020', '28/02/2020', '29/02/2020', '01/03/2020', '02/03/2020', 
          '03/03/2020', '04/03/2020', '05/03/2020', '06/03/2020', '07/03/2020',
          '08/03/2020', '09/03/2020', '10/03/2020', '11/03/2020', '12/03/2020', 
          '13/03/2020', '14/03/2020', '15/03/2020', '16/03/2020', '17/03/2020'
          ]
      ),
      'DD/MM/YYYY'
    ) AS date,
    unnest(
      array [
        d._27_02_2020, d._28_02_2020, d._29_02_2020,
        d._01_03_2020, d._02_03_2020, d._03_03_2020, 
        d._04_03_2020, d._05_03_2020, d._06_03_2020,
        d._07_03_2020, d._08_03_2020, d._09_03_2020, 
        d._10_03_2020, d._11_03_2020, d._12_03_2020, 
        d._13_03_2020, d._14_03_2020, d._15_03_2020, 
        d._16_03_2020, d._17_03_2020
    ]
    ) AS value,
    d.ccaa,
    s.population,
    'Datadista' as source,
    'https://github.com/datadista/datasets/tree/master/COVID%2019' as source_url 
  from 
    casos d,
    spain_regions s
  where 
    d.ccaa = s.nom_ccaa
) 
select 
  *,
  (value / population) as value_density 
from 
  data
  