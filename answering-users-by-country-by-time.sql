select
  datefromparts(Year(pq.CreationDate),Month(pq.CreationDate),1) as ym,
  count(distinct case when u.Location like '##L1?%Germany%##' then u.id else NULL end) as users1,
  count(distinct case when u.Location like '##L2?%India%##' then u.id else NULL end) as users2,
  count(distinct case when u.Location like '##L3?%United Kingdom%##' then u.id else NULL end) as users3
from Users u
join Posts pa
  on u.Id = pa.OwnerUserId
    and pa.PostTypeId = 2
join Posts pq
  on pq.Id = pa.ParentId
join PostTags pt
  on pt.PostId = pq.Id
join Tags t
  on pt.TagId = t.Id
where
  t.TagName = '##TagName?javascript##'
  and pa.Score >= ##MinScore?1##
group by Year(pq.CreationDate),Month(pq.CreationDate)
order by ym
