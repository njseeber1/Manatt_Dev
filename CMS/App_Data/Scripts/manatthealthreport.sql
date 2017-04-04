select Date,Title from Manatt_DocumentNewsletter where  practices in ('p79p') order by date desc
select documentid, * from view_cms_tree_joined where classname = 'Manatt.Practice' and nodename like '%Health%' and nodelinkednodeid is null
select * from Manatt_DocumentNewsletter where practices in ('p339p','p79p')



select Date,Title,relatedpractices from Manatt_DocumentArticle where relatedpractices like '%79%'

select  ContentTitle, RelatedPractices,* from Manatt_Insights where RelatedPractices like '%79%' order by date desc

select a.nodealiaspath,documentid, b.Date,b.ContentTitle from view_cms_tree_joined a
join Manatt_Insights b on a.documentforeignkeyvalue = b.InsightsId and a.classname = 'Manatt.Insights'
 where a.nodealiaspath like '%/white-papers/%' and b.Relatedpractices like '%79%'
 order by b.date desc

 select * from Manatt_Insights
 select * from Manatt_DocumentNewsletter

 select documentid, * from view_cms_tree_joined where classname = 'Manatt.DocumentNewsletter' 
 
 -- newsletters
 select a.Date,a.Title,Parent = (select DocumentName from view_cms_tree_joined where nodeid = b.NodeParentId),
 RelatedPeopleFullName = STUFF((SELECT ', ' + CAST(DocumentName AS VARCHAR(MAX))
     FROM view_cms_tree_joined where classname = 'manatt.people' and documentid in (select item from fn_split(a.relatedpeople,'~'))
     FOR XML PATH('')),1,1,''),
RelatedKeywords = STUFF((SELECT ', ' + CAST(DocumentName AS VARCHAR(MAX))
     FROM view_cms_tree_joined where classname = 'Manatt.DocumentKeyword' and documentid in (select item from fn_split(a.RelatedKeywords,'~'))
     FOR XML PATH('')),1,1,''),
DocumentUrl = b.NodeAliasPath,
a.practices
  from Manatt_DocumentNewsletter a 
 inner join view_cms_tree_joined b on a.DocumentNewsletterId = b.DocumentForeignKeyValue and b.classname = 'Manatt.DocumentNewsletter' 
 where  a.practices like '%79%' 
 and a.practices not in ('579','576 579')
 order by  a.date desc

 -- whitepapers
  select a.Date,
  a.ContentTitle,  
 RelatedPeopleFullName = STUFF((SELECT ', ' + CAST(DocumentName AS VARCHAR(MAX))
     FROM view_cms_tree_joined where classname = 'manatt.people' and documentid in (select item from fn_split(a.relatedpeople,'~'))
     FOR XML PATH('')),1,1,''),
RelatedKeywords = STUFF((SELECT ', ' + CAST(DocumentName AS VARCHAR(MAX))
     FROM view_cms_tree_joined where classname = 'Manatt.DocumentKeyword' and documentid in (select item from fn_split(a.RelatedKeywords,'~'))
     FOR XML PATH('')),1,1,''),
DocumentUrl = b.NodeAliasPath,
a.Relatedpractices
  from Manatt_Insights a 
 inner join view_cms_tree_joined b on a.InsightsId = b.DocumentForeignKeyValue and b.classname = 'Manatt.Insights' and b.nodealiaspath like '%/white-papers/%'
 where  a.Relatedpractices like '%79%'
 order by a.date desc

  -- webinars
  select a.Date,
  a.ContentTitle,  
 RelatedPeopleFullName = STUFF((SELECT ', ' + CAST(DocumentName AS VARCHAR(MAX))
     FROM view_cms_tree_joined where classname = 'manatt.people' and documentid in (select item from fn_split(a.relatedpeople,'~'))
     FOR XML PATH('')),1,1,''),
RelatedKeywords = STUFF((SELECT ', ' + CAST(DocumentName AS VARCHAR(MAX))
     FROM view_cms_tree_joined where classname = 'Manatt.DocumentKeyword' and documentid in (select item from fn_split(a.RelatedKeywords,'~'))
     FOR XML PATH('')),1,1,''),
DocumentUrl = b.NodeAliasPath,
a.Relatedpractices
  from Manatt_Insights a 
 inner join view_cms_tree_joined b on a.InsightsId = b.DocumentForeignKeyValue and b.classname = 'Manatt.Insights' and b.nodealiaspath like '%/webinars/%'
 where  a.Relatedpractices like '%79%'
 order by a.date desc

-- document events
select DateStart,Title,
 RelatedAttorneys = STUFF((SELECT ', ' + CAST(DocumentName AS VARCHAR(MAX))
     FROM view_cms_tree_joined where classname = 'manatt.people' and documentid in (select item from fn_split(a.relatedAttorneys,'~'))
     FOR XML PATH('')),1,1,''),
RelatedKeywords = STUFF((SELECT ', ' + CAST(DocumentName AS VARCHAR(MAX))
     FROM view_cms_tree_joined where classname = 'Manatt.DocumentKeyword' and documentid in (select item from fn_split(a.RelatedKeywords,'~'))
     FOR XML PATH('')),1,1,''),
DocumentUrl = b.NodeAliasPath,
a.practices
 from Manatt_DocumentEvent a 
 inner join view_cms_tree_joined b on a.DocumentEventId = b.DocumentForeignKeyValue and b.classname = 'Manatt.DocumentEvent'
 where a.Practices like '% 79 %' 
 or a.Practices like '79'
 or a.Practices like '79 %'
 or a.Practices like '% 79'
 order by datestart desc

 -- awards
 select b.Date,b.Title,
 RelatedPeopleFullName = STUFF((SELECT ', ' + CAST(DocumentName AS VARCHAR(MAX))
     FROM view_cms_tree_joined where classname = 'manatt.people' and documentid in (select item from fn_split(b.relatedpeople,'~'))
     FOR XML PATH('')),1,1,''),
	 b.RelatedKeywords
--RelatedKeywords = STUFF((SELECT ', ' + CAST(DocumentName AS VARCHAR(MAX))
--     FROM view_cms_tree_joined where classname = 'Manatt.DocumentKeyword' and documentid in (select item from fn_split(b.RelatedKeywords,'~'))
--     FOR XML PATH('')),1,1,'')
 from view_cms_tree_joined a
join Manatt_DocumentNews b on a.documentforeignkeyvalue = b.DocumentNewsID and a.classname = 'Manatt.DocumentNews'
 where a.nodealiaspath like '%/awards/%' and b.Practices like '%p79p%'
 order by b.date desc

  -- news
 select b.Date,b.Title,
 RelatedPeopleFullName = STUFF((SELECT ', ' + CAST(DocumentName AS VARCHAR(MAX))
     FROM view_cms_tree_joined where classname = 'manatt.people' and documentid in (select item from fn_split(b.relatedpeople,'~'))
     FOR XML PATH('')),1,1,''),	 
RelatedKeywords = STUFF((SELECT ', ' + CAST(DocumentName AS VARCHAR(MAX))
     FROM view_cms_tree_joined where classname = 'Manatt.DocumentKeyword' and documentid in (select item from fn_split(b.RelatedKeywords,'~'))
     FOR XML PATH('')),1,1,'')
 from view_cms_tree_joined a
join Manatt_DocumentNews b on a.documentforeignkeyvalue = b.DocumentNewsID and a.classname = 'Manatt.DocumentNews'
 where a.nodealiaspath like '%/news/%' and b.Practices like '%p79p%'
 order by b.date desc

-- document articles
 select b.Date,b.Title,
 RelatedPeopleFullName = STUFF((SELECT ', ' + CAST(DocumentName AS VARCHAR(MAX))
     FROM view_cms_tree_joined where classname = 'manatt.people' and documentid in (select item from fn_split(b.relatedpeople,'~'))
     FOR XML PATH('')),1,1,''),	 
RelatedKeywords = STUFF((SELECT ', ' + CAST(DocumentName AS VARCHAR(MAX))
     FROM view_cms_tree_joined where classname = 'Manatt.DocumentKeyword' and documentid in (select item from fn_split(b.RelatedKeywords,'~'))
     FOR XML PATH('')),1,1,''),
DocumentUrl = a.NodeAliasPath,
b.relatedpractices
 from view_cms_tree_joined a
join Manatt_DocumentArticle b on a.documentforeignkeyvalue = b.DocumentArticleID and a.classname = 'Manatt.DocumentArticle'
 where b.relatedpractices like '%~79~%'
  or b.relatedpractices like '79'
 or b.relatedpractices like '79~%'
 or b.relatedpractices like '%~79'
 order by b.date desc

select * from Manatt_DocumentArticle where relatedpractices like '%79%'

 ------------------------------------------------------------------------------------------------------------------
  select * from Manatt_DocumentNews

  select b.Date,b.Title,a.nodealiaspath,b.relatedkeywords,a.documentlastpublished
 from view_cms_tree_joined a
join Manatt_DocumentNews b on a.documentforeignkeyvalue = b.DocumentNewsID and a.classname = 'Manatt.DocumentNews'
 where 
 a.nodealiaspath like '%/news/%'
  and 
 --b.Practices like '%p79p%'
 order by b.date desc


 select * from Manatt_DocumentNews
 select * from [dbo].[Manatt_DocumentKeyword]
 select documentname,* from view_cms_tree_joined where ClassName='Manatt.DocumentKeyword'
AND NodeAliasPath LIKE '/Communications/Keywords/%'

[dbo].[fn_Manatt_GetPeopleFullName]
 sp_helptext fn_Manatt_GetPeopleFullNamesByIds
 declare @x varchar(max)
 exec @x= fn_Manatt_GetPeopleFullNamesByIds @ids = '4248~4295~4659'
 select @x
 select * from fn_split('4248~4295~4659','~')
 exec fn_Manatt_GetPeopleFullNamesByIds 

SELECT @peopleIds = COALESCE(@peopleIds + 'p', '') + CAST(DocumentForeignKeyValue AS varchar) FROM view_cms_tree_joined WHERE ClassName = 'Manatt.People' AND @ids LIKE '%p' + CAST(DocumentID AS VARCHAR) + 'p%'	



select * from Manatt_DocumentEvent where Practices like '%79%' order by datestart desc


 select documentname,* from view_cms_tree_joined where ClassName='Manatt.Insights'

select Date,Title,relatedpractices from Manatt_DocumentPressRelease where relatedpractices like '%79%'

select top 500 * from Manatt_DocumentNewsletter
select * from Manatt_DocumentNews



  select b.documentNewsid,b.Date,b.Title,a.nodealiaspath,b.relatedkeywords,a.documentlastpublished
 from view_cms_tree_joined a
join Manatt_DocumentNews b on a.documentforeignkeyvalue = b.DocumentNewsID and a.classname = 'Manatt.DocumentNews'
 where 
 a.nodealiaspath like '%/news/%'
 and b.documentnewsid > 1530
 and relatedkeywords is not null

 select 
 RelatedKeywords = STUFF((SELECT '~' + CAST(DocumentId AS VARCHAR(MAX))
     FROM view_cms_tree_joined where classname = 'Manatt.DocumentKeyword' and documentname in (select item from fn_split(RelatedKeywords,'~'))
     FOR XML PATH('')),1,1,'')
  from Manatt_DocumentNews
 where 
 documentnewsid > 1530
 and relatedkeywords is not null

 select * from Manatt_DocumentNews
 update Manatt_DocumentNews set 
  RelatedKeywords = STUFF((SELECT '~' + CAST(DocumentId AS VARCHAR(MAX))
     FROM view_cms_tree_joined where classname = 'Manatt.DocumentKeyword' and documentname in (select item from fn_split(RelatedKeywords,'~'))
     FOR XML PATH('')),1,1,'')
	  where 
 documentnewsid > 1530
 and relatedkeywords is not null


  select documentname,* from view_cms_tree_joined where ClassName='Manatt.DocumentKeyword'
AND NodeAliasPath LIKE '/Communications/Keywords/%'