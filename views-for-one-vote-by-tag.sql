select *
from (
  select
  Top(##TopBottom?15##)
    t.TagName as tag,
    avg(p.ViewCount) as views,
    count(*) as n
  from Posts p
  join PostTags pt
    on pt.PostId = p.Id
  join Tags t
    on pt.TagId = t.Id
  where 
    Year(p.CreationDate) = ##YearOfCreation?2014##
    and p.score ##score?=1##
  group by t.TagName
  having count(*) ##mincount?> 1000##
  order by views asc
  
  union
  
  select
  Top(##TopBottom?15##)
    t.TagName as tag,
    avg(p.ViewCount) as views,
    count(*) as n
  from Posts p
  join PostTags pt
    on pt.PostId = p.Id
  join Tags t
    on pt.TagId = t.Id
  where 
    Year(p.CreationDate) = ##YearOfCreation?2014##
    and p.score ##score?=1##
  group by t.TagName
  having count(*) ##mincount?> 1000##
  order by views desc
) as t
order by t.views asc
