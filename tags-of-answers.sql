select
  Top(##TopN?1000##)
  t.TagName as tag,
  count(distinct u.Id) as users
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
where u.Location like '##Location?%Germany%##'
  and Year(pq.CreationDate) = ##YearOfCreation?2014##
group by t.TagName
order by users desc
