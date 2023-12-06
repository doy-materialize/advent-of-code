with
input as (
    select
        'Time:        50     74     86     85
Distance:   242   1017   1691   1252' as input
),
races as (
    select
        replace(regexp_match(input, 'Time: *(.*)')[1], ' ', '')::bigint as time,
        replace(regexp_match(input, 'Distance: *(.*)')[1], ' ', '')::bigint as distance
    from
        input
)
select
    ceil((time + sqrt(time * time - 4 * distance)) / 2) - ceil((time - sqrt(time * time - 4 * distance)) / 2) as answer
from
    races
