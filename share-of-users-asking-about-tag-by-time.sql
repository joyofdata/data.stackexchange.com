select
  datefromparts(Year(p.CreationDate),Month(p.CreationDate),1) as ym,
  100*cast(count(distinct 
    case when t.TagName = '##TagName?javascript##' 
    then u.id else NULL end) as float) /
    (0.01 + count(distinct u.id)) as users_tag_per_all
from Users u
join Posts p
  on u.Id = p.OwnerUserId
    and p.PostTypeId = 1
join PostTags pt
  on pt.PostId = p.Id
join Tags t
  on pt.TagId = t.Id
where
  p.Score >= ##MinScore?1##
  and Year(p.CreationDate) >= 2009
group by Year(p.CreationDate),Month(p.CreationDate)
order by ym
