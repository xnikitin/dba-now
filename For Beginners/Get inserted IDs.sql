/* Instead of inserting rows into a table and then getting IDs
   of the inserted rows, you can get the IDs in the same step
   by using the OUTPUT clause. */

CREATE TABLE #RowsInserted 
(
    [Id]        INT
   ,[Name]      NVARCHAR(40)
   ,[UserId]    INT
   ,[Date]      DATETIME
);

INSERT INTO [dbo].[Badges]
(
    [Name]
   ,[UserId]
   ,[Date]
)
	OUTPUT  INSERTED.[Id]
           ,INSERTED.[Name]
           ,INSERTED.[UserId]
           ,INSERTED.[Date]
	INTO    #RowsInserted

	SELECT  N'Sunny Disposition'
           ,[Id]
           ,GETDATE()
	FROM    [dbo].[Users]
	WHERE   [Location] = N'Iceland';

SELECT	*
FROM	#RowsInserted;