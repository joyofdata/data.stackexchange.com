select
  Top(##TopN?1000##)
  t.TagName as tag,
  count(distinct u.Id) as users
from Users u
join Posts p
  on u.Id = p.OwnerUserId
    and p.PostTypeId = 1
join PostTags pt
  on pt.PostId = p.Id
join Tags t
  on pt.TagId = t.Id
where u.Location like '##Location?%Germany%##'
  and Year(p.CreationDate) = ##YearOfCreation?2014##
group by t.TagName
order by users desc
