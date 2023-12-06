with
input as (
    select
        'Time:        50     74     86     85
Distance:   242   1017   1691   1252' as input
),
races as (
    select
        regexp_split_to_table(regexp_match(input, 'Time: *(.*)')[1], ' +')::int as time,
        regexp_split_to_table(regexp_match(input, 'Distance: *(.*)')[1], ' +')::int as distance
    from
        input
),
distances as (
    select
        time,
        n,
        distance as record_distance,
        (time - n) * n as distance
    from
        races, generate_series(0, time) as n
),
wins as(
    select
        count(*) as wins
    from
        distances
    where
        distance > record_distance
    group by time
)
select
    round(exp(sum(ln(wins)))) as answer
from
    wins
