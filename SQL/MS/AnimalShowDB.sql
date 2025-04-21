USE [AnimalShowDB]
GO
/****** Object:  Table [dbo].[Animal]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Animal](
	[id_animal] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[date_of_birthday] [date] NOT NULL,
	[id_club] [int] NOT NULL,
	[id_breed] [int] NOT NULL,
	[id_lineage] [int] NOT NULL,
	[id_owner] [int] NOT NULL,
	[image] [varchar](255) NULL,
 CONSTRAINT [PK_Animal] PRIMARY KEY CLUSTERED 
(
	[id_animal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Animal_has_vaccine]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Animal_has_vaccine](
	[id_animal] [int] NOT NULL,
	[id_vaccine] [int] NOT NULL,
	[date_of_vaccine] [date] NOT NULL,
 CONSTRAINT [PK_Animal_has_vaccine] PRIMARY KEY CLUSTERED 
(
	[id_animal] ASC,
	[id_vaccine] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Breed]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Breed](
	[id_breed] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[id_type] [int] NOT NULL,
 CONSTRAINT [PK_Breed] PRIMARY KEY CLUSTERED 
(
	[id_breed] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Club]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Club](
	[id_club] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Club] PRIMARY KEY CLUSTERED 
(
	[id_club] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Expert]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Expert](
	[id_expert] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](100) NOT NULL,
	[last_name] [varchar](100) NOT NULL,
	[id_club] [int] NOT NULL,
 CONSTRAINT [PK_Expert] PRIMARY KEY CLUSTERED 
(
	[id_expert] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lineage]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lineage](
	[id_lineage] [int] IDENTITY(1,1) NOT NULL,
	[nuber_documet] [int] NOT NULL,
	[name_father] [varchar](100) NOT NULL,
	[name_mother] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Lineage] PRIMARY KEY CLUSTERED 
(
	[id_lineage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Owner]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Owner](
	[id_owner] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](100) NOT NULL,
	[last_name] [varchar](100) NOT NULL,
	[patronymic] [varchar](100) NULL,
	[seria_passport] [int] NOT NULL,
	[number_passport] [int] NOT NULL,
	[issued] [text] NOT NULL,
	[date_of_birthday] [date] NOT NULL,
 CONSTRAINT [PK_Owner] PRIMARY KEY CLUSTERED 
(
	[id_owner] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ring]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ring](
	[id_ring] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[adress] [text] NOT NULL,
 CONSTRAINT [PK_Ring] PRIMARY KEY CLUSTERED 
(
	[id_ring] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ring_has_animal]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ring_has_animal](
	[id_ring] [int] NOT NULL,
	[id_animal] [int] NOT NULL,
	[id_show] [int] NOT NULL,
	[num_participant] [int] NOT NULL,
	[competition_place] [int] NULL,
 CONSTRAINT [PK_Ring_has_animal] PRIMARY KEY CLUSTERED 
(
	[id_ring] ASC,
	[id_animal] ASC,
	[id_show] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ring_has_expert]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ring_has_expert](
	[id_ring] [int] NOT NULL,
	[id_expert] [int] NOT NULL,
	[id_show] [int] NOT NULL,
 CONSTRAINT [PK_RIng_has_expert] PRIMARY KEY CLUSTERED 
(
	[id_ring] ASC,
	[id_expert] ASC,
	[id_show] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[id_role] [int] IDENTITY(1,1) NOT NULL,
	[name_role] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[id_role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Show]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Show](
	[id_show] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[date_of_show] [date] NOT NULL,
	[time_show] [time](0) NOT NULL,
 CONSTRAINT [PK_Show] PRIMARY KEY CLUSTERED 
(
	[id_show] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Type_of_animal]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Type_of_animal](
	[id_type] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Type_of_animal] PRIMARY KEY CLUSTERED 
(
	[id_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id_user] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](100) NOT NULL,
	[last_name] [varchar](100) NOT NULL,
	[patronymic] [varchar](100) NULL,
	[date_of_birthday] [date] NOT NULL,
	[login] [varchar](100) NOT NULL,
	[password] [varchar](max) NOT NULL,
	[id_role] [int] NOT NULL,
	[email] [varchar](100) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[id_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vaccine]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vaccine](
	[id_vaccine] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Vaccine] PRIMARY KEY CLUSTERED 
(
	[id_vaccine] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Animal] ON 
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (1, N'Джек', CAST(N'2021-02-26' AS Date), 1, 1, 1, 1, N'jack.jpg')
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (2, N'Жордак', CAST(N'2021-07-30' AS Date), 2, 1, 2, 2, N'jordak.jpg')
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (3, N'Беня', CAST(N'2021-05-07' AS Date), 3, 1, 3, 3, N'benya.jpg')
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (4, N'Гинтер', CAST(N'2023-08-01' AS Date), 4, 2, 4, 4, N'ginter.jpg')
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (5, N'Виконт', CAST(N'2017-01-31' AS Date), 5, 2, 5, 5, N'vikont.jpg')
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (7, N'Буцефал', CAST(N'2022-08-22' AS Date), 6, 2, 6, 7, N'bucefal.jpg')
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (8, N'Нильсон', CAST(N'2018-12-17' AS Date), 7, 3, 7, 8, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (9, N'Буян', CAST(N'2023-05-17' AS Date), 8, 3, 8, 9, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (10, N'Искандер', CAST(N'2019-08-11' AS Date), 1, 3, 9, 10, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (11, N'Данай', CAST(N'2017-12-17' AS Date), 2, 4, 10, 11, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (12, N'Саурон', CAST(N'2019-01-27' AS Date), 3, 4, 11, 12, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (13, N'Ерофей', CAST(N'2016-06-07' AS Date), 4, 4, 12, 12, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (14, N'Изабель', CAST(N'2021-10-12' AS Date), 5, 5, 13, 13, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (15, N'Уника', CAST(N'2022-06-25' AS Date), 6, 5, 14, 14, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (17, N'Ишка', CAST(N'2017-02-26' AS Date), 7, 5, 15, 15, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (19, N'Яська', CAST(N'2021-01-12' AS Date), 8, 6, 16, 17, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (20, N'Альфина', CAST(N'2023-03-09' AS Date), 1, 6, 17, 17, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (21, N'Индира', CAST(N'2017-10-19' AS Date), 2, 6, 18, 18, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (23, N'Шанель', CAST(N'2021-03-04' AS Date), 3, 7, 19, 20, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (24, N'Лакоста', CAST(N'2021-09-04' AS Date), 4, 7, 20, 20, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (25, N'Тиша', CAST(N'2023-12-21' AS Date), 5, 7, 21, 21, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (26, N'Чероки', CAST(N'2020-05-12' AS Date), 6, 8, 22, 22, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (27, N'Юнита', CAST(N'2018-10-16' AS Date), 7, 8, 23, 23, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (28, N'Моная', CAST(N'2016-04-12' AS Date), 8, 8, 24, 24, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (29, N'Инам', CAST(N'2016-10-22' AS Date), 1, 9, 25, 24, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (30, N'Рассвет', CAST(N'2017-07-15' AS Date), 2, 9, 26, 26, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (31, N'Устин', CAST(N'2021-08-24' AS Date), 3, 9, 27, 27, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (32, N'Услада', CAST(N'2021-06-17' AS Date), 4, 10, 28, 28, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (33, N'Чилим', CAST(N'2020-02-08' AS Date), 5, 10, 28, 29, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (34, N'Мирабель', CAST(N'2016-03-18' AS Date), 6, 10, 28, 30, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (36, N'Кирианна', CAST(N'2020-06-30' AS Date), 7, 11, 29, 31, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (37, N'Акуана', CAST(N'2018-02-14' AS Date), 8, 11, 29, 32, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (38, N'Кульбит', CAST(N'2017-11-02' AS Date), 1, 11, 29, 33, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (39, N'Валсис', CAST(N'2016-06-07' AS Date), 2, 12, 30, 34, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (40, N'Фелиша', CAST(N'2018-12-17' AS Date), 3, 12, 30, 35, NULL)
GO
INSERT [dbo].[Animal] ([id_animal], [name], [date_of_birthday], [id_club], [id_breed], [id_lineage], [id_owner], [image]) VALUES (41, N'Сюита', CAST(N'2018-12-17' AS Date), 4, 12, 30, 36, NULL)
GO
SET IDENTITY_INSERT [dbo].[Animal] OFF
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (1, 1, CAST(N'2022-08-18' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (1, 2, CAST(N'2022-12-26' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (1, 3, CAST(N'2023-06-03' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (1, 4, CAST(N'2023-01-15' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (2, 1, CAST(N'2023-09-11' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (2, 2, CAST(N'2022-12-01' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (2, 3, CAST(N'2024-01-24' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (2, 4, CAST(N'2023-04-08' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (3, 1, CAST(N'2023-07-02' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (3, 2, CAST(N'2023-10-29' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (4, 3, CAST(N'2022-02-27' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (4, 4, CAST(N'2022-12-01' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (5, 2, CAST(N'2023-01-17' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (5, 3, CAST(N'2023-11-08' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (5, 4, CAST(N'2023-03-31' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (7, 1, CAST(N'2023-01-17' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (7, 4, CAST(N'2023-08-28' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (8, 2, CAST(N'2022-11-12' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (8, 3, CAST(N'2023-05-01' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (9, 1, CAST(N'2022-07-15' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (10, 2, CAST(N'2022-10-26' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (10, 4, CAST(N'2023-01-02' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (11, 1, CAST(N'2024-04-03' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (11, 2, CAST(N'2022-10-26' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (12, 3, CAST(N'2023-09-12' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (12, 4, CAST(N'2022-11-11' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (13, 1, CAST(N'2024-04-03' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (13, 3, CAST(N'2024-03-30' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (14, 1, CAST(N'2023-09-11' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (14, 2, CAST(N'2024-03-25' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (15, 1, CAST(N'2022-03-02' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (15, 2, CAST(N'2024-01-29' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (17, 1, CAST(N'2022-01-27' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (17, 2, CAST(N'2022-05-18' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (17, 5, CAST(N'2022-09-29' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (17, 6, CAST(N'2022-07-28' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (19, 5, CAST(N'2022-11-04' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (19, 6, CAST(N'2024-04-24' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (20, 5, CAST(N'2023-04-04' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (20, 6, CAST(N'2022-11-04' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (21, 5, CAST(N'2022-01-25' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (21, 6, CAST(N'2023-11-26' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (23, 1, CAST(N'2024-03-08' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (23, 5, CAST(N'2023-02-18' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (24, 2, CAST(N'2022-05-21' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (24, 6, CAST(N'2023-02-25' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (25, 1, CAST(N'2022-12-08' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (25, 2, CAST(N'2023-01-12' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (25, 5, CAST(N'2024-03-27' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (26, 1, CAST(N'2024-04-24' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (26, 2, CAST(N'2024-04-24' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (26, 6, CAST(N'2022-05-21' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (27, 5, CAST(N'2023-10-09' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (27, 6, CAST(N'2022-01-25' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (28, 1, CAST(N'2022-07-02' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (28, 2, CAST(N'2023-02-26' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (29, 1, CAST(N'2023-09-12' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (29, 2, CAST(N'2022-07-13' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (30, 1, CAST(N'2020-10-03' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (30, 2, CAST(N'2022-08-09' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (31, 1, CAST(N'2024-03-08' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (31, 2, CAST(N'2021-07-13' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (32, 1, CAST(N'2024-04-29' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (32, 2, CAST(N'2020-11-14' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (33, 1, CAST(N'2023-01-31' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (33, 2, CAST(N'2023-12-07' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (34, 1, CAST(N'2020-08-13' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (34, 2, CAST(N'2020-07-11' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (36, 1, CAST(N'2020-04-12' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (36, 2, CAST(N'2023-05-22' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (36, 3, CAST(N'2021-04-26' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (37, 2, CAST(N'2023-08-28' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (37, 4, CAST(N'2020-04-12' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (37, 6, CAST(N'2021-04-26' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (38, 3, CAST(N'2021-07-22' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (38, 5, CAST(N'2021-04-29' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (39, 1, CAST(N'2021-07-22' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (39, 6, CAST(N'2022-09-21' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (40, 1, CAST(N'2021-07-22' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (40, 2, CAST(N'2020-10-05' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (41, 1, CAST(N'2024-02-15' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (41, 2, CAST(N'2024-02-06' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (41, 3, CAST(N'2023-08-28' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (41, 4, CAST(N'2020-03-18' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (41, 5, CAST(N'2020-04-12' AS Date))
GO
INSERT [dbo].[Animal_has_vaccine] ([id_animal], [id_vaccine], [date_of_vaccine]) VALUES (41, 6, CAST(N'2023-08-28' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Breed] ON 
GO
INSERT [dbo].[Breed] ([id_breed], [name], [id_type]) VALUES (1, N'Лабрадор', 1)
GO
INSERT [dbo].[Breed] ([id_breed], [name], [id_type]) VALUES (2, N'Немецкая овчарка', 1)
GO
INSERT [dbo].[Breed] ([id_breed], [name], [id_type]) VALUES (3, N'Хаски', 1)
GO
INSERT [dbo].[Breed] ([id_breed], [name], [id_type]) VALUES (4, N'Доберман', 1)
GO
INSERT [dbo].[Breed] ([id_breed], [name], [id_type]) VALUES (5, N'Мейн-кун', 2)
GO
INSERT [dbo].[Breed] ([id_breed], [name], [id_type]) VALUES (6, N'Бенгальская', 2)
GO
INSERT [dbo].[Breed] ([id_breed], [name], [id_type]) VALUES (7, N'Британская короткошерстная', 2)
GO
INSERT [dbo].[Breed] ([id_breed], [name], [id_type]) VALUES (8, N'Шотландская вислоухая', 2)
GO
INSERT [dbo].[Breed] ([id_breed], [name], [id_type]) VALUES (9, N'Мустанг', 3)
GO
INSERT [dbo].[Breed] ([id_breed], [name], [id_type]) VALUES (10, N'Арабская', 3)
GO
INSERT [dbo].[Breed] ([id_breed], [name], [id_type]) VALUES (11, N'Пони', 3)
GO
INSERT [dbo].[Breed] ([id_breed], [name], [id_type]) VALUES (12, N'Донская', 3)
GO
SET IDENTITY_INSERT [dbo].[Breed] OFF
GO
SET IDENTITY_INSERT [dbo].[Club] ON 
GO
INSERT [dbo].[Club] ([id_club], [name]) VALUES (1, N'Зооген')
GO
INSERT [dbo].[Club] ([id_club], [name]) VALUES (2, N'Блисфул')
GO
INSERT [dbo].[Club] ([id_club], [name]) VALUES (3, N'Каштанка')
GO
INSERT [dbo].[Club] ([id_club], [name]) VALUES (4, N'Легенда')
GO
INSERT [dbo].[Club] ([id_club], [name]) VALUES (5, N'Бульвест')
GO
INSERT [dbo].[Club] ([id_club], [name]) VALUES (6, N'Компаньон')
GO
INSERT [dbo].[Club] ([id_club], [name]) VALUES (7, N'Пёсушки')
GO
INSERT [dbo].[Club] ([id_club], [name]) VALUES (8, N'Зевс')
GO
SET IDENTITY_INSERT [dbo].[Club] OFF
GO
SET IDENTITY_INSERT [dbo].[Expert] ON 
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (1, N'Низамов', N'Альберт ', 1)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (2, N'Краснозобова ', N'Екатерина ', 1)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (3, N'Билинская ', N'Яна ', 1)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (4, N'Сероухова ', N'Карина ', 2)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (5, N'Гамзатханова ', N'Юлия ', 2)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (6, N'Тарлыков', N'Константин ', 2)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (7, N'Ботвина', N'Александра', 3)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (8, N'Водневская ', N'Дарья ', 3)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (9, N'Цуркан ', N'Дарья ', 3)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (10, N'Паустовская', N'Светлана', 4)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (11, N'Степин ', N'Тимофей ', 4)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (12, N'Кибирева ', N'Инна ', 4)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (13, N'Шебашев ', N'Илья ', 5)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (14, N'Бердочкин ', N'Антон ', 5)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (15, N'Барышкова ', N'Ангелина', 5)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (16, N'Базин ', N'Кирилл ', 6)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (17, N'Черненко', N'Виталий ', 6)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (18, N'Ровенко ', N'Екатерина', 6)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (19, N'Емшанова ', N'Диана ', 7)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (20, N'Фахртдинова ', N'Оксана', 7)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (21, N'Дятчин ', N'Валентин ', 7)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (22, N'Шарагина ', N'Жанна ', 8)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (23, N'Хина ', N'Екатерина ', 8)
GO
INSERT [dbo].[Expert] ([id_expert], [first_name], [last_name], [id_club]) VALUES (24, N'Новосадов ', N'Станислав ', 8)
GO
SET IDENTITY_INSERT [dbo].[Expert] OFF
GO
SET IDENTITY_INSERT [dbo].[Lineage] ON 
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (1, 6341, N'Напас', N'Джульетта')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (2, 5432, N'Арнольд', N'Саванна')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (3, 3810, N'Мени', N'Вега')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (4, 6439, N'Арчи', N'Гермиона')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (5, 2356, N'Цицерон', N'Габри')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (6, 3289, N'Чак', N'Аляска')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (7, 4369, N'Смурф', N'Алисия')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (8, 6431, N'Лайв', N'Офелия')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (9, 5749, N'Фунтик', N'Ельза')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (10, 6439, N'Джекс', N'Ангел')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (11, 7691, N'Снупи', N'Закира')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (12, 6491, N'Халк', N'Кася')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (13, 5461, N'Радж', N'Лана')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (14, 5467, N'Шайн', N'Тори')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (15, 9724, N'Сакар', N'Арлин')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (16, 2318, N'Урчун', N'Герда')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (17, 3578, N'Рамзес', N'Диана')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (18, 5421, N'Туман', N'Глория')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (19, 9871, N'Шерри', N'Эшли')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (20, 4452, N'Данко', N'Венди')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (21, 7314, N'Эйнштейн', N'Салли')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (22, 1742, N'Сэми', N'Люська')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (23, 2551, N'Чери', N'Розалия')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (24, 1267, N'Черчиль', N'Алиска')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (25, 6437, N'Нохчо', N'Линда')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (26, 1849, N'Феникс', N'Пахира')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (27, 3511, N'Волгарь', N'Чайра')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (28, 4231, N'Шокирующий', N'Пираканта')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (29, 6849, N'Энзо', N'Кастария')
GO
INSERT [dbo].[Lineage] ([id_lineage], [nuber_documet], [name_father], [name_mother]) VALUES (30, 7548, N'Модесто', N'Арифметика')
GO
SET IDENTITY_INSERT [dbo].[Lineage] OFF
GO
SET IDENTITY_INSERT [dbo].[Owner] ON 
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (1, N'Беднарская ', N'Светлана ', N'Ильдаровна', 4380, 472201, N'Отделом внутренних дел России по г. Томск', CAST(N'1966-06-26' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (2, N'Смекалкова ', N'Лилия ', N'Александровна', 4234, 344850, N'ОУФМС России по г. Каменск - Уральский', CAST(N'1982-12-18' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (3, N'Карвасарский ', N'Герман ', N'Антонович', 4421, 848568, N'Отделом УФМС России по г. Пенза', CAST(N'1993-11-03' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (4, N'Караченцев ', N'Илья ', N'Ильич', 4832, 851073, N'Отделением УФМС России по г. Шахты', CAST(N'1993-03-16' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (5, N'Громенко ', N'Максим ', N'Семенович', 4621, 613807, N'ОВД России по г. Грозный', CAST(N'1977-01-22' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (7, N'Муштаков ', N'Леонид', N'Аркадьевич', 4868, 407417, N'Отделением УФМС России в г. Ангарск', CAST(N'1996-05-06' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (8, N'Сусеев ', N'Ян', N'Леонидович', 4362, 106594, N'Отделением УФМС России по г. Симферополь', CAST(N'1971-07-12' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (9, N'Пончаев ', N'Радик ', N'Константинович', 4878, 568272, N'Отделением УФМС России по г. Нижневартовск', CAST(N'1994-01-04' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (10, N'Котовский ', N'Владислав ', N'Вячеславович', 4278, 968920, N'Управление внутренних дел по г. Ставрополь', CAST(N'1986-11-09' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (11, N'Хвесин ', N'Сергей ', N'Дмитриевич', 4185, 653661, N'ОУФМС России по г. Бердск', CAST(N'1990-03-07' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (12, N'Семенихина ', N'Оксана ', N'Семеновна', 4095, 379037, N'ОВД России по г. Балаково', CAST(N'1984-02-08' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (13, N'Ахтямов ', N'Анатолий ', N'Валентинович', 4142, 450000, N'Отделом внутренних дел России по г. Сочи', CAST(N'1995-12-04' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (14, N'Букат ', N'Антон ', N'Васильевич', 4684, 410274, N'ОУФМС России по г. Электросталь', CAST(N'1969-08-02' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (15, N'Процюк ', N'Валерия', N'Леонидовна', 4587, 546715, N'ОУФМС России по г. Курск', CAST(N'1990-10-13' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (17, N'Сазиков ', N'Степан ', N'Данилович', 4227, 237979, N'Отделением УФМС России по г. Мытищи', CAST(N'1993-12-05' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (18, N'Ленкова ', N'Оксана ', N'Филипповна', 4116, 402990, N'ОВД России по г. Тула', CAST(N'1973-01-14' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (20, N'Умяров ', N'Ефим ', N'Михаилович', 4315, 954623, N'ОВД России по г. Новосибирск', CAST(N'1991-12-05' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (21, N'Котлубеев ', N'Тимофей ', N'Дмитриевич', 4540, 216068, N'ОУФМС России по г. Северск', CAST(N'1988-04-19' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (22, N'Охотник ', N'Петр ', N'Вадимович', 4663, 290621, N'Отделением УФМС России в г. Братск', CAST(N'1992-08-16' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (23, N'Недоплясова ', N'Татьяна ', N'Альбертовна', 4727, 537460, N'Отделением УФМС России по г. Стерлитамак', CAST(N'1996-08-24' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (24, N'Стрельцова ', N'Вероника ', N'Ильдаровна', 4967, 888758, N'ОУФМС России по г. Невинномысск', CAST(N'1995-05-21' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (26, N'Саматов ', N'Эдуард ', N'Станиславович', 4870, 839450, N'Отделением УФМС России в г. Пушкино', CAST(N'1983-03-25' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (27, N'Жигайло ', N'Павел ', N'Яковлев', 4748, 428674, N'ОВД России по г. Новороссийск', CAST(N'1970-01-17' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (28, N'Ионтова ', N'Антонина ', N'Игоревна', 4188, 517018, N'Отделом УФМС России по г. Саратов', CAST(N'1975-04-17' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (29, N'Радищева ', N'Ирина ', N'Константиновна', 4064, 689334, N'Отделом УФМС России по г. Каспийск', CAST(N'1989-01-19' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (30, N'Лебедько', N'Оксана ', N'Егоровна', 4276, 540114, N'Отделением УФМС России в г. Оренбург', CAST(N'1972-06-05' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (31, N'Шанаева ', N'Ксения ', N'Алексеевна', 4583, 315989, N'Отделением УФМС России по г. Благовещенск', CAST(N'1993-11-03' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (32, N'Кабалевская ', N'Антонина ', N'Тимофеевна', 4059, 630518, N'Отделением УФМС России в г. Химки', CAST(N'1981-12-18' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (33, N'Бижанова ', N'Юлия ', N'Ильдаровна', 4940, 752662, N'Отделением УФМС России по г. Кемерово', CAST(N'1993-03-28' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (34, N'Демидович ', N'Елизавета ', N'Вадимовна', 4620, 455486, N'Отделением УФМС России по г. Йошкар-Ола', CAST(N'1992-06-10' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (35, N'Багрянов ', N'Анатолий ', N'Олегович', 4854, 403244, N'Отделением УФМС России по г. Киров', CAST(N'1985-08-15' AS Date))
GO
INSERT [dbo].[Owner] ([id_owner], [first_name], [last_name], [patronymic], [seria_passport], [number_passport], [issued], [date_of_birthday]) VALUES (36, N'Благодатских ', N'Филипп ', N'Егорович', 4494, 853108, N'Отделом внутренних дел России по г. Брянск', CAST(N'1985-03-12' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Owner] OFF
GO
SET IDENTITY_INSERT [dbo].[Ring] ON 
GO
INSERT [dbo].[Ring] ([id_ring], [name], [adress]) VALUES (1, N'КОНГРЕСС-РИНГ', N'Россия, г. Абакан, Ленинская ул., д. 1 кв.45')
GO
INSERT [dbo].[Ring] ([id_ring], [name], [adress]) VALUES (2, N'КВАЛИФИКАЦИОННЫЙ РИНГ ', N'Россия, г. Курск, Мира ул., д. 8 кв.85')
GO
INSERT [dbo].[Ring] ([id_ring], [name], [adress]) VALUES (3, N'СПЕЦИАЛЬНЫЙ', N'Россия, г. Петропавловск-Камчатский, Максима Горького ул., д. 12 кв.1')
GO
INSERT [dbo].[Ring] ([id_ring], [name], [adress]) VALUES (4, N'ПОРОДНЫЙ РИНГ', N'Россия, г. Серпухов, Сосновая ул., д. 6 кв.117')
GO
SET IDENTITY_INSERT [dbo].[Ring] OFF
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 1, 1, 1, 1)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 1, 2, 1, 1)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 1, 4, 1, 1)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 1, 5, 1, 1)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 1, 9, 1, 1)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 2, 1, 2, 2)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 2, 2, 2, 0)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 2, 4, 2, 2)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 2, 5, 2, 2)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 2, 9, 2, 2)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 3, 1, 3, 3)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 3, 2, 3, 3)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 3, 4, 3, 3)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 3, 5, 3, 3)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 3, 9, 3, 3)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 4, 1, 4, 4)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 4, 2, 4, 4)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 4, 4, 4, 4)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 4, 5, 4, 4)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 4, 9, 4, 4)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 5, 1, 5, 5)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 5, 2, 5, 5)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 5, 4, 5, 5)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 5, 5, 5, 5)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 5, 9, 5, 5)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 7, 4, 6, 6)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 7, 7, 1, 1)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 8, 7, 2, 2)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 9, 7, 3, 3)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 10, 7, 4, 4)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 11, 7, 5, 5)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 12, 7, 6, 6)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 13, 7, 7, 7)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 14, 6, 1, 13)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 14, 10, 1, 13)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 15, 6, 2, 14)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 15, 10, 2, 14)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 17, 6, 3, 15)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 17, 10, 3, 15)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 19, 6, 4, 16)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 19, 10, 4, 16)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 20, 6, 5, 17)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 21, 6, 6, 18)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 24, 8, 1, 13)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 25, 8, 2, 14)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 26, 8, 3, 15)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 27, 8, 4, 16)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 28, 8, 5, 17)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 29, 3, 1, 13)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 30, 3, 2, 14)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 31, 3, 3, 15)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 32, 3, 4, 16)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 33, 3, 5, 17)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 34, 3, 6, 18)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 36, 3, 7, 19)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 37, 3, 8, 20)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 38, 3, 9, 21)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 39, 3, 10, 22)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 40, 3, 11, 23)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (1, 41, 3, 12, 24)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 7, 1, 6, 6)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 7, 2, 6, 6)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 8, 1, 7, 7)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 8, 2, 7, 7)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 9, 1, 8, 8)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 9, 2, 8, 8)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 10, 1, 9, 9)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 10, 2, 9, 9)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 11, 1, 10, 10)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 11, 2, 10, 10)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 12, 1, 11, 11)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 12, 2, 11, 11)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 13, 1, 12, 12)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 13, 2, 12, 12)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 14, 4, 1, 13)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 14, 7, 1, 13)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 14, 9, 1, 13)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 15, 4, 2, 14)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 15, 7, 2, 14)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 15, 9, 2, 14)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 17, 4, 3, 15)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 17, 7, 3, 15)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 17, 9, 3, 15)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 19, 4, 4, 16)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 19, 7, 4, 16)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 19, 9, 4, 16)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 20, 4, 5, 17)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 20, 7, 5, 17)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 20, 9, 5, 17)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 20, 10, 5, 17)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 21, 4, 6, 18)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 21, 7, 6, 18)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 21, 10, 6, 18)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 23, 6, 7, 19)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 23, 7, 7, 19)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 23, 10, 7, 19)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 24, 6, 8, 20)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 24, 10, 8, 20)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 25, 6, 9, 21)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 26, 6, 10, 22)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 27, 6, 11, 23)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 28, 6, 12, 24)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 29, 5, 1, 13)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 30, 5, 2, 14)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 31, 5, 3, 15)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 32, 5, 4, 16)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 33, 5, 5, 17)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 37, 8, 1, 13)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 38, 8, 2, 14)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 39, 8, 3, 15)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 40, 8, 4, 16)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (2, 41, 8, 5, 17)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 14, 2, 1, 13)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 15, 2, 2, 14)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 17, 2, 3, 15)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 19, 2, 4, 16)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 20, 2, 5, 17)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 21, 2, 6, 18)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 25, 10, 9, 21)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 26, 10, 10, 22)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 27, 10, 11, 23)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 28, 10, 12, 24)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 29, 4, 1, 13)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 29, 9, 1, 13)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 30, 4, 2, 14)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 30, 9, 2, 14)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 31, 4, 3, 15)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 31, 9, 3, 15)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 32, 4, 4, 16)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 32, 9, 4, 16)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 33, 4, 5, 17)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 33, 9, 5, 17)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (3, 34, 4, 6, 18)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (4, 23, 2, 7, 19)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (4, 24, 2, 8, 20)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (4, 25, 2, 9, 21)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (4, 26, 2, 10, 22)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (4, 27, 2, 11, 23)
GO
INSERT [dbo].[Ring_has_animal] ([id_ring], [id_animal], [id_show], [num_participant], [competition_place]) VALUES (4, 28, 2, 12, 24)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 1, 1)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 1, 11)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 1, 19)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 1, 29)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 3, 2)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 4, 20)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 4, 30)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 5, 12)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 7, 3)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 7, 21)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 8, 4)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 9, 13)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 10, 22)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 11, 5)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 13, 6)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 13, 14)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 13, 23)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 15, 7)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 15, 24)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 17, 8)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 17, 15)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 17, 25)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 19, 9)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 19, 26)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 21, 16)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 21, 27)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 22, 10)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 23, 17)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (1, 23, 28)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 2, 1)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 2, 11)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 2, 19)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 2, 29)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 4, 2)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 5, 20)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 5, 30)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 6, 12)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 8, 21)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 9, 4)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 10, 13)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 11, 22)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 12, 5)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 14, 6)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 14, 14)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 14, 23)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 16, 7)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 16, 24)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 18, 8)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 18, 15)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 18, 25)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 20, 9)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 20, 26)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 22, 16)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 22, 27)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 23, 10)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 24, 17)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (2, 24, 28)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (3, 3, 11)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (3, 3, 19)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (3, 3, 29)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (3, 5, 2)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (3, 6, 20)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (3, 6, 30)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (3, 7, 12)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (3, 9, 21)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (3, 10, 4)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (3, 11, 13)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (3, 12, 22)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (3, 15, 14)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (3, 19, 15)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (3, 21, 9)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (3, 24, 10)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (4, 4, 11)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (4, 6, 2)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (4, 8, 12)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (4, 12, 13)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (4, 16, 14)
GO
INSERT [dbo].[Ring_has_expert] ([id_ring], [id_expert], [id_show]) VALUES (4, 20, 15)
GO
SET IDENTITY_INSERT [dbo].[Role] ON 
GO
INSERT [dbo].[Role] ([id_role], [name_role]) VALUES (1, N'Админ')
GO
INSERT [dbo].[Role] ([id_role], [name_role]) VALUES (2, N'Организатор')
GO
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[Show] ON 
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (1, N'Цветик-Семицветик', CAST(N'2023-03-03' AS Date), CAST(N'03:09:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (2, N'Расцвет', CAST(N'2023-11-21' AS Date), CAST(N'12:26:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (3, N'Диковинка', CAST(N'2023-08-24' AS Date), CAST(N'07:27:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (4, N'Хвостики и лапки', CAST(N'2023-07-12' AS Date), CAST(N'14:09:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (5, N'Мы в ответе за тех, кого приручили', CAST(N'2023-08-04' AS Date), CAST(N'13:03:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (6, N'Животный мир', CAST(N'2023-11-08' AS Date), CAST(N'18:08:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (7, N'Экология', CAST(N'2023-02-02' AS Date), CAST(N'20:45:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (8, N'Они такие разные, бывают и опасные!', CAST(N'2024-03-10' AS Date), CAST(N'10:55:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (9, N'Веселый зоопарк', CAST(N'2024-02-26' AS Date), CAST(N'16:15:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (10, N'Друзья домашнего очага', CAST(N'2024-02-26' AS Date), CAST(N'17:28:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (11, N'Животный мир нашей Родины', CAST(N'2023-03-08' AS Date), CAST(N'17:00:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (12, N'Кинологический эрудицион', CAST(N'2024-05-19' AS Date), CAST(N'06:30:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (13, N'Меньшие братья просят о защите', CAST(N'2023-10-17' AS Date), CAST(N'14:50:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (14, N'Мой пушистый любимец', CAST(N'2023-08-28' AS Date), CAST(N'16:06:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (15, N'Наши любимые «хвостолапые»', CAST(N'2024-11-14' AS Date), CAST(N'18:54:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (16, N'Про братьев наших меньших', CAST(N'2023-10-07' AS Date), CAST(N'12:14:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (17, N'Твои соседи по планете', CAST(N'2024-09-29' AS Date), CAST(N'17:28:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (19, N'Дикие и домашние', CAST(N'2024-04-25' AS Date), CAST(N'06:25:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (20, N'Почти как мы', CAST(N'2023-03-16' AS Date), CAST(N'13:55:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (21, N'Звери на все лады', CAST(N'2023-11-15' AS Date), CAST(N'15:46:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (22, N'В пространстве инстинктов', CAST(N'2024-07-28' AS Date), CAST(N'13:24:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (23, N'Самые ловкие', CAST(N'2024-01-25' AS Date), CAST(N'17:00:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (24, N'Звериные законы', CAST(N'2023-10-02' AS Date), CAST(N'14:29:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (25, N'Люди и звери', CAST(N'2024-03-09' AS Date), CAST(N'13:31:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (26, N'Со зверьми наедине', CAST(N'2023-10-02' AS Date), CAST(N'07:03:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (27, N'На службе у человека', CAST(N'2024-02-11' AS Date), CAST(N'16:24:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (28, N'Выдающиеся животные', CAST(N'2024-01-09' AS Date), CAST(N'14:56:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (29, N'Домашние хранители', CAST(N'2023-01-08' AS Date), CAST(N'18:01:00' AS Time))
GO
INSERT [dbo].[Show] ([id_show], [name], [date_of_show], [time_show]) VALUES (30, N'Разумные животные', CAST(N'2023-03-06' AS Date), CAST(N'18:03:00' AS Time))
GO
SET IDENTITY_INSERT [dbo].[Show] OFF
GO
SET IDENTITY_INSERT [dbo].[Type_of_animal] ON 
GO
INSERT [dbo].[Type_of_animal] ([id_type], [name]) VALUES (1, N'Собака')
GO
INSERT [dbo].[Type_of_animal] ([id_type], [name]) VALUES (2, N'Кошка')
GO
INSERT [dbo].[Type_of_animal] ([id_type], [name]) VALUES (3, N'Лошадь')
GO
SET IDENTITY_INSERT [dbo].[Type_of_animal] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 
GO
INSERT [dbo].[User] ([id_user], [first_name], [last_name], [patronymic], [date_of_birthday], [login], [password], [id_role], [email]) VALUES (1, N'Герасичев', N'Денис', N'Александрович', CAST(N'2005-01-24' AS Date), N'admin', N'b109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc86', 1, N'admin@ya.ru')
GO
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[Vaccine] ON 
GO
INSERT [dbo].[Vaccine] ([id_vaccine], [name]) VALUES (1, N'От бешенства')
GO
INSERT [dbo].[Vaccine] ([id_vaccine], [name]) VALUES (2, N'От трихофитии и микроспории')
GO
INSERT [dbo].[Vaccine] ([id_vaccine], [name]) VALUES (3, N'От чумы плотоядных')
GO
INSERT [dbo].[Vaccine] ([id_vaccine], [name]) VALUES (4, N'От липтоспироза')
GO
INSERT [dbo].[Vaccine] ([id_vaccine], [name]) VALUES (5, N'От хламидиоза')
GO
INSERT [dbo].[Vaccine] ([id_vaccine], [name]) VALUES (6, N'От бордетеллеза')
GO
SET IDENTITY_INSERT [dbo].[Vaccine] OFF
GO
ALTER TABLE [dbo].[Animal]  WITH CHECK ADD  CONSTRAINT [FK_Animal_Breed] FOREIGN KEY([id_breed])
REFERENCES [dbo].[Breed] ([id_breed])
GO
ALTER TABLE [dbo].[Animal] CHECK CONSTRAINT [FK_Animal_Breed]
GO
ALTER TABLE [dbo].[Animal]  WITH CHECK ADD  CONSTRAINT [FK_Animal_Club] FOREIGN KEY([id_club])
REFERENCES [dbo].[Club] ([id_club])
GO
ALTER TABLE [dbo].[Animal] CHECK CONSTRAINT [FK_Animal_Club]
GO
ALTER TABLE [dbo].[Animal]  WITH CHECK ADD  CONSTRAINT [FK_Animal_Lineage] FOREIGN KEY([id_lineage])
REFERENCES [dbo].[Lineage] ([id_lineage])
GO
ALTER TABLE [dbo].[Animal] CHECK CONSTRAINT [FK_Animal_Lineage]
GO
ALTER TABLE [dbo].[Animal]  WITH CHECK ADD  CONSTRAINT [FK_Animal_Owner] FOREIGN KEY([id_owner])
REFERENCES [dbo].[Owner] ([id_owner])
GO
ALTER TABLE [dbo].[Animal] CHECK CONSTRAINT [FK_Animal_Owner]
GO
ALTER TABLE [dbo].[Animal_has_vaccine]  WITH CHECK ADD  CONSTRAINT [FK_Animal_has_vaccine_Animal] FOREIGN KEY([id_animal])
REFERENCES [dbo].[Animal] ([id_animal])
GO
ALTER TABLE [dbo].[Animal_has_vaccine] CHECK CONSTRAINT [FK_Animal_has_vaccine_Animal]
GO
ALTER TABLE [dbo].[Animal_has_vaccine]  WITH CHECK ADD  CONSTRAINT [FK_Animal_has_vaccine_Vaccine] FOREIGN KEY([id_vaccine])
REFERENCES [dbo].[Vaccine] ([id_vaccine])
GO
ALTER TABLE [dbo].[Animal_has_vaccine] CHECK CONSTRAINT [FK_Animal_has_vaccine_Vaccine]
GO
ALTER TABLE [dbo].[Breed]  WITH CHECK ADD  CONSTRAINT [FK_Breed_Type_of_animal] FOREIGN KEY([id_type])
REFERENCES [dbo].[Type_of_animal] ([id_type])
GO
ALTER TABLE [dbo].[Breed] CHECK CONSTRAINT [FK_Breed_Type_of_animal]
GO
ALTER TABLE [dbo].[Expert]  WITH CHECK ADD  CONSTRAINT [FK_Expert_Club] FOREIGN KEY([id_club])
REFERENCES [dbo].[Club] ([id_club])
GO
ALTER TABLE [dbo].[Expert] CHECK CONSTRAINT [FK_Expert_Club]
GO
ALTER TABLE [dbo].[Ring_has_animal]  WITH CHECK ADD  CONSTRAINT [FK_Ring_has_animal_Animal] FOREIGN KEY([id_animal])
REFERENCES [dbo].[Animal] ([id_animal])
GO
ALTER TABLE [dbo].[Ring_has_animal] CHECK CONSTRAINT [FK_Ring_has_animal_Animal]
GO
ALTER TABLE [dbo].[Ring_has_animal]  WITH CHECK ADD  CONSTRAINT [FK_Ring_has_animal_Ring] FOREIGN KEY([id_ring])
REFERENCES [dbo].[Ring] ([id_ring])
GO
ALTER TABLE [dbo].[Ring_has_animal] CHECK CONSTRAINT [FK_Ring_has_animal_Ring]
GO
ALTER TABLE [dbo].[Ring_has_animal]  WITH CHECK ADD  CONSTRAINT [FK_Ring_has_animal_Show] FOREIGN KEY([id_show])
REFERENCES [dbo].[Show] ([id_show])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Ring_has_animal] CHECK CONSTRAINT [FK_Ring_has_animal_Show]
GO
ALTER TABLE [dbo].[Ring_has_expert]  WITH CHECK ADD  CONSTRAINT [FK_RIng_has_expert_Expert] FOREIGN KEY([id_expert])
REFERENCES [dbo].[Expert] ([id_expert])
GO
ALTER TABLE [dbo].[Ring_has_expert] CHECK CONSTRAINT [FK_RIng_has_expert_Expert]
GO
ALTER TABLE [dbo].[Ring_has_expert]  WITH CHECK ADD  CONSTRAINT [FK_RIng_has_expert_Ring] FOREIGN KEY([id_ring])
REFERENCES [dbo].[Ring] ([id_ring])
GO
ALTER TABLE [dbo].[Ring_has_expert] CHECK CONSTRAINT [FK_RIng_has_expert_Ring]
GO
ALTER TABLE [dbo].[Ring_has_expert]  WITH CHECK ADD  CONSTRAINT [FK_RIng_has_expert_Show] FOREIGN KEY([id_show])
REFERENCES [dbo].[Show] ([id_show])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Ring_has_expert] CHECK CONSTRAINT [FK_RIng_has_expert_Show]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([id_role])
REFERENCES [dbo].[Role] ([id_role])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
/****** Object:  StoredProcedure [dbo].[AddExpert]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc	[dbo].[AddExpert]
(@ring int, @expert int, @show int)
AS
insert into [dbo].[Ring_has_expert]
values
(@ring, @expert, @show)
GO
/****** Object:  StoredProcedure [dbo].[AddShow]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[AddShow]
(@name varchar(100), @date date, @time time(0))
AS
insert into [dbo].[Show]
values
(@name, @date, @time)
GO
/****** Object:  StoredProcedure [dbo].[DeleteAnimal]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DeleteAnimal]
(@idShow int, @idAnimal int)
AS
delete [dbo].[Ring_has_animal]
where [id_show] = @idShow and [id_animal] = @idAnimal
GO
/****** Object:  StoredProcedure [dbo].[DeleteExpert]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DeleteExpert]
(@idShow int, @idExpert int)
AS
delete [dbo].[Ring_has_expert]
where [id_show] = @idShow and [id_expert] = @idExpert
GO
/****** Object:  StoredProcedure [dbo].[DeleteShow]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DeleteShow]
(@idShow int)
AS
delete [dbo].[Show]
where [id_show] = @idShow
GO
/****** Object:  StoredProcedure [dbo].[SelectAllExpert]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc	[dbo].[SelectAllExpert]
AS
select [id_expert],
[first_name] + ' ' [last_name]
from [dbo].[Expert]
GO
/****** Object:  StoredProcedure [dbo].[SelectAnimal]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SelectAnimal]
(@idShow int)
AS
select [num_participant],
a.[id_animal],
[image],
a.[name],
datediff(year, a.[date_of_birthday], getdate()),
c.[name],
t.[name],
b.[name],
[first_name] + ' ' + [last_name] + ' ' + [patronymic],
[competition_place]
from [dbo].[Animal] a join [dbo].[Club] c
on a.[id_club] = c.[id_club]
join [dbo].[Breed] b
on a.[id_breed] = b.[id_breed]
join [dbo].[Type_of_animal] t
on b.[id_type] = t.[id_type]
join [dbo].[Owner] o
on a.[id_owner] = o.[id_owner]
join [dbo].[Ring_has_animal] rha
on a.[id_animal] = rha.[id_animal]
where [id_show] = @idShow
order by [competition_place]
GO
/****** Object:  StoredProcedure [dbo].[SelectAnimalById]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SelectAnimalById]
(@idAnimal int)
AS
select a.[id_animal],
a.[name],
datediff(year, a.[date_of_birthday], getdate()),
c.[name],
t.[name],
b.[name]
from [dbo].[Animal] a join [dbo].[Club] c
on a.[id_club] = c.[id_club]
join [dbo].[Breed] b
on a.[id_breed] = b.[id_breed]
join [dbo].[Type_of_animal] t
on b.[id_type] = t.[id_type]
join [dbo].[Owner] o
on a.[id_owner] = o.[id_owner]
where a.[id_animal] = @idAnimal
GO
/****** Object:  StoredProcedure [dbo].[SelectAnimalByOwner]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SelectAnimalByOwner]
(@idAnimal int)
AS
select a.[id_animal],
a.[name],
datediff(year, a.[date_of_birthday], getdate()),
c.[name],
t.[name],
b.[name]
from [dbo].[Animal] a join [dbo].[Club] c
on a.[id_club] = c.[id_club]
join [dbo].[Breed] b
on a.[id_breed] = b.[id_breed]
join [dbo].[Type_of_animal] t
on b.[id_type] = t.[id_type]
join [dbo].[Owner] o
on a.[id_owner] = o.[id_owner]
where o.[id_owner] = (select o.[id_owner]
					from [dbo].[Owner] o
					join [dbo].[Animal] a
					on o.[id_owner] = a.[id_owner]
					where [id_animal] = @idAnimal)
GO
/****** Object:  StoredProcedure [dbo].[SelectClub]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SelectClub]
AS
select * from [dbo].[Club]
GO
/****** Object:  StoredProcedure [dbo].[SelectExpert]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SelectExpert]
(@idShow int)
AS
select e.[id_expert],
[first_name],
[last_name],
[name]
from [dbo].[Expert] e join [dbo].[Club] c
on e.[id_club] = c.[id_club]
join [dbo].[Ring_has_expert] rhe
on e.[id_expert] = rhe.[id_expert]
where [id_show] = @idShow
GO
/****** Object:  StoredProcedure [dbo].[SelectExpertByClub]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SelectExpertByClub]
(@idShow int, @idClub int)
AS
select e.[id_expert],
[first_name],
[last_name],
[name]
from [dbo].[Expert] e join [dbo].[Club] c
on e.[id_club] = c.[id_club]
join [dbo].[Ring_has_expert] rhe
on e.[id_expert] = rhe.[id_expert]
where [id_show] = @idShow
and e.[id_club] = @idClub
GO
/****** Object:  StoredProcedure [dbo].[SelectOwner]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SelectOwner]
(@idAnimal int)
as
select o.[id_owner],
[first_name],
[last_name],
[patronymic],
[seria_passport],
[number_passport],
[issued],
o.[date_of_birthday]
from [dbo].[Owner] o
join [dbo].[Animal] a
on o.[id_owner] = a.[id_owner]
where [id_animal] = @idAnimal
GO
/****** Object:  StoredProcedure [dbo].[SelectRing]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc	[dbo].[SelectRing]
AS
select [id_ring],
[name]
from [dbo].[Ring]
GO
/****** Object:  StoredProcedure [dbo].[SelectRingHasExpert]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SelectRingHasExpert]
(@idShow int)
as
select r.[name],
[first_name],
[last_name],
c.[name]
from [dbo].[Club] c join [dbo].[Expert] e on c.[id_club] = e.[id_club]
join [dbo].[Ring_has_expert] rhe on rhe.[id_expert] = e.[id_expert]
join [dbo].[Ring] r on r.[id_ring] = rhe.[id_ring]
where rhe.[id_show] = @idShow
GO
/****** Object:  StoredProcedure [dbo].[SelectShow]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SelectShow]
AS
select * from [dbo].[Show]
order by [date_of_show] desc
GO
/****** Object:  StoredProcedure [dbo].[SelectShowByDate]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SelectShowByDate]
(@date varchar(10))
AS
select * from [dbo].[Show]
where [date_of_show] = @date
GO
/****** Object:  StoredProcedure [dbo].[SelectShowById]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc	[dbo].[SelectShowById]
(@idShow int)
AS
select * from [dbo].[Show]
where [id_show] = @idShow
GO
/****** Object:  StoredProcedure [dbo].[SelectUser]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SelectUser] 
(@login varchar(100))
AS
SELECT [id_user], [first_name], [last_name], [patronymic], [date_of_birthday], [login], [password], u.[id_role], [name_role], [email] FROM [dbo].[User] u JOIN [dbo].[Role] r ON u.[id_role] = r.[id_role] WHERE [login] = @login OR [email] = @login
GO
/****** Object:  StoredProcedure [dbo].[SelectVaccine]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SelectVaccine]
(@idAnimal int)
AS
select v.[id_vaccine],
[name],
[date_of_vaccine]
from [dbo].[Vaccine] v
join [dbo].[Animal_has_vaccine] ahv
on v.[id_vaccine] = ahv.[id_vaccine]
where [id_animal] = @idAnimal
GO
/****** Object:  StoredProcedure [dbo].[SetResult]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SetResult]
(@idAnimal int, @idShow int, @place int)
as
update [dbo].[Ring_has_animal]
set [competition_place] = @place
where [id_animal] = @idAnimal and [id_show] = @idShow
GO
/****** Object:  StoredProcedure [dbo].[UpdateShow]    Script Date: 22.04.2025 1:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc	[dbo].[UpdateShow]
(@idShow int, @name varchar(100), @date date, @time time)
AS
update [dbo].[Show]
set [name] = @name,
[date_of_show] = @date,
[time_show] = @time
where [id_show] = @idShow
GO
