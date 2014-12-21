select
  datefromparts(Year(p.CreationDate),Month(p.CreationDate),1) as ym,
  count(distinct case when u.Location like '##L1?%Germany%##' then u.id else NULL end) as users1,
  count(distinct case when u.Location like '##L2?%India%##' then u.id else NULL end) as users2,
  count(distinct case when u.Location like '##L3?%United Kingdom%##' then u.id else NULL end) as users3
from Users u
join Posts p
  on u.Id = p.OwnerUserId
    and p.PostTypeId = 1
join PostTags pt
  on pt.PostId = p.Id
join Tags t
  on pt.TagId = t.Id
where
  t.TagName = '##TagName?javascript##'
  and p.Score >= ##MinScore?1##
group by Year(p.CreationDate),Month(p.CreationDate)
order by ym
