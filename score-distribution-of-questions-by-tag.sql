-- http://data.stackexchange.com/stackoverflow/query/261669?tag1=haskell&tag2=r&tag3=php&y=2013&minScore=-10&maxScore=20#graph

select * 
into #distribution
from (
  select
    p.score as score,
    sum(case when t.TagName = '##tag1?haskell##' then 1 else 0 end) n1,
    sum(case when t.TagName = '##tag2?r##' then 1 else 0 end) as n2,
    sum(case when t.TagName = '##tag3?php##' then 1 else 0 end) as n3
  from Posts p
  join PostTags pt
    on pt.PostId = p.Id
  join Tags t
    on pt.TagId = t.Id
  where 
    Year(p.CreationDate) = ##y?2013##
    and score between ##minScore?-10## and ##maxScore?20##
    and p.PostTypeId = 1
  group by p.score
) as t

select *
into #maximum
from (
  select
    max(n1) as n1,
    max(n2) as n2,
    max(n3) as n3
  from #distribution
) as t

select
  d.score,
  1.0*d.n1 / m.n1 as ##tag1##,
  1.0*d.n2 / m.n2 as ##tag2##,
  1.0*d.n3 / m.n3 as ##tag3##
from #distribution as d
join #maximum as m
  on 1=1
