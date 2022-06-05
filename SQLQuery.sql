create trigger NewCommentNotification
on post_comment
after insert
as
begin
	
	
	declare @id bigint =	(select inserted.source_id
	from inserted)
	declare @emailAddress varchar(50) = (select user_profile.email_address from user_profile where user_profile.id = @id)
	declare @body varchar(255) = 'You have a new comment on your post!'
	exec msdb.dbo.sp_send_dbmail
		@profile_name = 'Social Network Profile',
		@recipients = @emailAddress,
		@body = @body,
		@subject = 'Social Network - New Comment';
end