USE [master]
GO
/****** Object:  Database [Teatre]    Script Date: 22.04.2025 1:41:31 ******/
CREATE DATABASE [Teatre]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Teatre', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER1\MSSQL\DATA\Teatre.mdf' , SIZE = 139264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Teatre_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER1\MSSQL\DATA\Teatre_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Teatre] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Teatre].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Teatre] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Teatre] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Teatre] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Teatre] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Teatre] SET ARITHABORT OFF 
GO
ALTER DATABASE [Teatre] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Teatre] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Teatre] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Teatre] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Teatre] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Teatre] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Teatre] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Teatre] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Teatre] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Teatre] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Teatre] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Teatre] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Teatre] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Teatre] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Teatre] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Teatre] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Teatre] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Teatre] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Teatre] SET  MULTI_USER 
GO
ALTER DATABASE [Teatre] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Teatre] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Teatre] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Teatre] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Teatre] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Teatre] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Teatre] SET QUERY_STORE = OFF
GO
USE [Teatre]
GO
/****** Object:  User [test10]    Script Date: 22.04.2025 1:41:31 ******/
CREATE USER [test10] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[KolMest]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[KolMest]
(@name text)
returns int
as
begin
declare @k int
select @k = sum([Количество])
from [dbo].[Залы в театре] z join [dbo].[Места в театре] m
on z.[id_зала] = m.[id_зала]
where [Наименование зала] like @name
return @k
end
GO
/****** Object:  Table [dbo].[Афиша]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Афиша](
	[id_афишы] [int] NOT NULL,
	[id_репертуара] [int] NULL,
	[Дата проведения] [date] NOT NULL,
	[Время проведения] [time](0) NOT NULL,
	[id_заал] [int] NULL,
 CONSTRAINT [PK_Афиша] PRIMARY KEY CLUSTERED 
(
	[id_афишы] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Билет]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Билет](
	[id_билета] [int] NOT NULL,
	[id_афишы] [int] NOT NULL,
 CONSTRAINT [PK_Билет] PRIMARY KEY CLUSTERED 
(
	[id_билета] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Места в театре]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Места в театре](
	[id_места] [int] NOT NULL,
	[Тип места] [varchar](50) NULL,
	[id_зала] [int] NULL,
	[Количество] [int] NULL,
 CONSTRAINT [PK_Места в театре] PRIMARY KEY CLUSTERED 
(
	[id_места] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Стоимость мест в театре]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Стоимость мест в театре](
	[id_места] [int] NOT NULL,
	[id_билета] [int] NOT NULL,
	[Стоимость] [money] NULL,
 CONSTRAINT [PK_Стоимость мест в театре] PRIMARY KEY CLUSTERED 
(
	[id_места] ASC,
	[id_билета] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Репертуар]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Репертуар](
	[id_репертуара] [int] NOT NULL,
	[Наименование спектакля] [nchar](100) NULL,
	[Описание репертуара] [text] NULL,
	[id_театра] [int] NULL,
	[Длительность спектакля] [time](0) NULL,
	[Жанр] [varchar](50) NULL,
	[Возрастной рейтинг] [int] NULL,
 CONSTRAINT [PK_Репертуар] PRIMARY KEY CLUSTERED 
(
	[id_репертуара] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Tickets]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Tickets]
(@id int)
returns table
as
return select [Наименование спектакля],
[Дата проведения],
[Время проведения],
[Тип места],
[Стоимость]
from [dbo].[Репертуар] r join [dbo].[Афиша] a
on r.[id_репертуара] = a.[id_репертуара]
join [dbo].[Билет] b
on b.[id_афишы] = a.[id_афишы]
join [dbo].[Стоимость мест в театре] c
on c.[id_билета] = b.[id_билета]
join [dbo].[Места в театре] m
on m.[id_места] = c.[id_места]
where b.[id_билета] = @id
GO
/****** Object:  Table [dbo].[Артисты в театре]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Артисты в театре](
	[id_артиста] [int] NOT NULL,
	[ФИО_артиста] [varchar](100) NULL,
	[id_звания] [int] NULL,
	[Количество проведённых выступлений] [int] NULL,
	[id_театра] [int] NULL,
	[Дата рождения] [nchar](10) NULL,
	[Возраст] [nchar](10) NULL,
 CONSTRAINT [PK_Артисты в театре] PRIMARY KEY CLUSTERED 
(
	[id_артиста] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Залы в театре]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Залы в театре](
	[id_зала] [int] NOT NULL,
	[Наименование зала] [varchar](100) NULL,
	[Адрес] [varchar](100) NULL,
	[id_театра] [int] NULL,
 CONSTRAINT [PK_Залы в театре] PRIMARY KEY CLUSTERED 
(
	[id_зала] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Звания]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Звания](
	[id_звания] [int] NOT NULL,
	[Наименование звания] [varchar](50) NULL,
 CONSTRAINT [PK_Звания] PRIMARY KEY CLUSTERED 
(
	[id_звания] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Персональные_данные_пользователя]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Персональные_данные_пользователя](
	[id_пользователя] [int] NOT NULL,
	[Телефон] [float] NULL,
	[Адрес] [text] NULL,
	[Серия_паспорта] [int] NULL,
	[Номер_паспорта] [int] NULL,
	[Выдан] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_пользователя] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Пользователи]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Пользователи](
	[id_пользователя] [int] NOT NULL,
	[Фамилия] [varchar](100) NULL,
	[Имя] [varchar](100) NULL,
	[Отчество] [varchar](100) NULL,
	[Дата_рождения] [date] NULL,
	[Логин] [nvarchar](100) NULL,
	[Пароль] [text] NULL,
	[id_роли] [int] NULL,
 CONSTRAINT [PK__Пользова__AF763DA7AF983C2A] PRIMARY KEY CLUSTERED 
(
	[id_пользователя] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Роли]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Роли](
	[id_роли] [int] NOT NULL,
	[Наименование роли] [varchar](50) NULL,
 CONSTRAINT [PK_Роли] PRIMARY KEY CLUSTERED 
(
	[id_роли] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Роли в афише]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Роли в афише](
	[id_артиста] [int] NOT NULL,
	[id_афишы] [int] NOT NULL,
	[id_роли] [int] NOT NULL,
 CONSTRAINT [PK_Роли в афише] PRIMARY KEY CLUSTERED 
(
	[id_артиста] ASC,
	[id_афишы] ASC,
	[id_роли] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Роли_пользователей]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Роли_пользователей](
	[id_роли] [int] NOT NULL,
	[Наименование_роли] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_роли] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Театр]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Театр](
	[id_театра] [int] NOT NULL,
	[Наименование театра] [varchar](100) NULL,
	[Логотип] [varchar](100) NULL,
	[Описание театра] [text] NULL,
 CONSTRAINT [PK_Театр] PRIMARY KEY CLUSTERED 
(
	[id_театра] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Артисты в театре] ([id_артиста], [ФИО_артиста], [id_звания], [Количество проведённых выступлений], [id_театра], [Дата рождения], [Возраст]) VALUES (1, N'Карпов Денис Всеволодович', 1, 10, 1, N'окт 30 197', N'          ')
GO
INSERT [dbo].[Артисты в театре] ([id_артиста], [ФИО_артиста], [id_звания], [Количество проведённых выступлений], [id_театра], [Дата рождения], [Возраст]) VALUES (2, N'Плотников Данил Александрович', 1, 15, 1, N'дек 19 197', N'          ')
GO
INSERT [dbo].[Артисты в театре] ([id_артиста], [ФИО_артиста], [id_звания], [Количество проведённых выступлений], [id_театра], [Дата рождения], [Возраст]) VALUES (3, N'Лавров Константин Давидович', 1, 2, 1, N'окт 12 197', N'          ')
GO
INSERT [dbo].[Артисты в театре] ([id_артиста], [ФИО_артиста], [id_звания], [Количество проведённых выступлений], [id_театра], [Дата рождения], [Возраст]) VALUES (4, N'Шилова Варвара Ивановна', 2, 8, 1, N'фев 27 197', N'          ')
GO
INSERT [dbo].[Артисты в театре] ([id_артиста], [ФИО_артиста], [id_звания], [Количество проведённых выступлений], [id_театра], [Дата рождения], [Возраст]) VALUES (5, N'Ильинский Антон Денисович', 2, 100, 1, N'дек 24 200', N'          ')
GO
INSERT [dbo].[Артисты в театре] ([id_артиста], [ФИО_артиста], [id_звания], [Количество проведённых выступлений], [id_театра], [Дата рождения], [Возраст]) VALUES (6, N'Борисова Анна Андреевна', 1, 124, 2, N'сен 26 199', N'          ')
GO
INSERT [dbo].[Артисты в театре] ([id_артиста], [ФИО_артиста], [id_звания], [Количество проведённых выступлений], [id_театра], [Дата рождения], [Возраст]) VALUES (7, N'Соколова Вера Дмитриевна', 2, 4, 2, N'мар 23 198', N'          ')
GO
INSERT [dbo].[Артисты в театре] ([id_артиста], [ФИО_артиста], [id_звания], [Количество проведённых выступлений], [id_театра], [Дата рождения], [Возраст]) VALUES (8, N'Сидоров Игорь Александрович', 1, 32, 2, N'фев 11 197', N'          ')
GO
INSERT [dbo].[Артисты в театре] ([id_артиста], [ФИО_артиста], [id_звания], [Количество проведённых выступлений], [id_театра], [Дата рождения], [Возраст]) VALUES (9, N'Нечаева Ева Святославовна', 2, 1, 2, N'авг 18 198', N'          ')
GO
INSERT [dbo].[Артисты в театре] ([id_артиста], [ФИО_артиста], [id_звания], [Количество проведённых выступлений], [id_театра], [Дата рождения], [Возраст]) VALUES (10, N'Сорокина Элина Ивановна', 1, 0, 2, N'авг 22 197', N'          ')
GO
INSERT [dbo].[Артисты в театре] ([id_артиста], [ФИО_артиста], [id_звания], [Количество проведённых выступлений], [id_театра], [Дата рождения], [Возраст]) VALUES (11, N'Коновалова Кристина Кирилловна', 1, 67, 3, N'ноя  3 202', N'          ')
GO
INSERT [dbo].[Артисты в театре] ([id_артиста], [ФИО_артиста], [id_звания], [Количество проведённых выступлений], [id_театра], [Дата рождения], [Возраст]) VALUES (12, N'Кириллова Кристина Денисовна', 1, 91, 3, N'дек 15 201', N'          ')
GO
INSERT [dbo].[Артисты в театре] ([id_артиста], [ФИО_артиста], [id_звания], [Количество проведённых выступлений], [id_театра], [Дата рождения], [Возраст]) VALUES (13, N'Фокина Алёна Савельевна', 2, 77, 3, N'фев  8 198', N'          ')
GO
INSERT [dbo].[Артисты в театре] ([id_артиста], [ФИО_артиста], [id_звания], [Количество проведённых выступлений], [id_театра], [Дата рождения], [Возраст]) VALUES (14, N'Тарасов Артём Романович', 2, 10, 3, N'апр 14 200', N'          ')
GO
INSERT [dbo].[Артисты в театре] ([id_артиста], [ФИО_артиста], [id_звания], [Количество проведённых выступлений], [id_театра], [Дата рождения], [Возраст]) VALUES (15, N'Глухов Михаил Степанович', 2, 11, 3, N'май  6 200', N'          ')
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (1, 1, CAST(N'2023-08-07' AS Date), CAST(N'12:29:00' AS Time), 1)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (2, 1, CAST(N'2023-01-17' AS Date), CAST(N'11:12:00' AS Time), 1)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (3, 2, CAST(N'2023-05-15' AS Date), CAST(N'07:39:00' AS Time), 1)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (4, 2, CAST(N'2023-01-08' AS Date), CAST(N'19:42:00' AS Time), 1)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (5, 3, CAST(N'2023-08-03' AS Date), CAST(N'21:27:00' AS Time), 1)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (6, 3, CAST(N'2023-06-09' AS Date), CAST(N'03:32:00' AS Time), 1)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (7, 4, CAST(N'2023-02-24' AS Date), CAST(N'08:16:00' AS Time), 1)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (8, 4, CAST(N'2023-04-26' AS Date), CAST(N'19:20:00' AS Time), 1)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (9, 5, CAST(N'2023-06-09' AS Date), CAST(N'21:22:00' AS Time), 2)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (10, 5, CAST(N'2023-03-03' AS Date), CAST(N'02:27:00' AS Time), 3)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (11, 6, CAST(N'2023-06-01' AS Date), CAST(N'10:25:00' AS Time), 4)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (12, 6, CAST(N'2023-01-06' AS Date), CAST(N'05:43:00' AS Time), 2)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (13, 7, CAST(N'2023-02-19' AS Date), CAST(N'12:06:00' AS Time), 3)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (14, 7, CAST(N'2023-08-17' AS Date), CAST(N'23:20:00' AS Time), 4)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (15, 8, CAST(N'2023-03-18' AS Date), CAST(N'15:42:00' AS Time), 2)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (16, 8, CAST(N'2023-03-28' AS Date), CAST(N'16:10:00' AS Time), 3)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (17, 9, CAST(N'2023-03-16' AS Date), CAST(N'20:37:00' AS Time), 5)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (18, 9, CAST(N'2023-07-30' AS Date), CAST(N'21:15:00' AS Time), 6)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (19, 10, CAST(N'2023-05-18' AS Date), CAST(N'11:17:00' AS Time), 5)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (20, 10, CAST(N'2023-01-16' AS Date), CAST(N'12:25:00' AS Time), 6)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (21, 11, CAST(N'2023-03-17' AS Date), CAST(N'10:02:00' AS Time), 5)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (22, 11, CAST(N'2023-04-22' AS Date), CAST(N'05:47:00' AS Time), 6)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (23, 12, CAST(N'2023-05-22' AS Date), CAST(N'05:42:00' AS Time), 5)
GO
INSERT [dbo].[Афиша] ([id_афишы], [id_репертуара], [Дата проведения], [Время проведения], [id_заал]) VALUES (24, 12, CAST(N'2023-06-07' AS Date), CAST(N'23:33:00' AS Time), 6)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (1, 1)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (2, 2)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (3, 3)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (4, 4)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (5, 5)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (6, 6)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (7, 7)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (8, 8)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (9, 9)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (10, 10)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (11, 11)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (12, 12)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (13, 13)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (14, 14)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (15, 15)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (16, 16)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (17, 17)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (18, 18)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (19, 19)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (20, 20)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (21, 21)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (22, 22)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (23, 23)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (24, 24)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (25, 1)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (26, 2)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (27, 3)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (28, 4)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (29, 5)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (30, 6)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (31, 7)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (32, 8)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (33, 9)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (34, 10)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (35, 11)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (36, 12)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (37, 13)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (38, 14)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (39, 15)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (40, 16)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (41, 17)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (42, 18)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (43, 19)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (44, 20)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (45, 21)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (46, 22)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (47, 23)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (48, 24)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (49, 1)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (50, 2)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (51, 3)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (52, 4)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (53, 5)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (54, 6)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (55, 7)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (56, 8)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (57, 9)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (58, 10)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (59, 11)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (60, 12)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (61, 13)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (62, 14)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (63, 15)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (64, 16)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (65, 17)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (66, 18)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (67, 19)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (68, 20)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (69, 21)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (70, 22)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (71, 23)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (72, 24)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (73, 1)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (74, 2)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (75, 3)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (76, 4)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (77, 5)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (78, 6)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (79, 7)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (80, 8)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (81, 9)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (82, 10)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (83, 11)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (84, 12)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (85, 13)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (86, 14)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (87, 15)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (88, 16)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (89, 17)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (90, 18)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (91, 19)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (92, 20)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (93, 21)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (94, 22)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (95, 23)
GO
INSERT [dbo].[Билет] ([id_билета], [id_афишы]) VALUES (96, 24)
GO
INSERT [dbo].[Залы в театре] ([id_зала], [Наименование зала], [Адрес], [id_театра]) VALUES (1, N'Михайловский театр', N'площадь Искусств, 1', 1)
GO
INSERT [dbo].[Залы в театре] ([id_зала], [Наименование зала], [Адрес], [id_театра]) VALUES (2, N'Мариинский театр', N'Театральная пл., д. 1', 2)
GO
INSERT [dbo].[Залы в театре] ([id_зала], [Наименование зала], [Адрес], [id_театра]) VALUES (3, N'Мариинский-2', N'Декабристов, д. 34', 2)
GO
INSERT [dbo].[Залы в театре] ([id_зала], [Наименование зала], [Адрес], [id_театра]) VALUES (4, N'Концертный зал', N'ул. Писарева, д. 20', 2)
GO
INSERT [dbo].[Залы в театре] ([id_зала], [Наименование зала], [Адрес], [id_театра]) VALUES (5, N'Большой драматический театр им. Г.А.Товстоногова (БДТ)', N'наб. реки Фонтанки, 65', 3)
GO
INSERT [dbo].[Залы в театре] ([id_зала], [Наименование зала], [Адрес], [id_театра]) VALUES (6, N'Каменноостровский театр', N'пл. Старого Театра, д. 13', 3)
GO
INSERT [dbo].[Звания] ([id_звания], [Наименование звания]) VALUES (1, N'Заслуженный артист')
GO
INSERT [dbo].[Звания] ([id_звания], [Наименование звания]) VALUES (2, N'Народный артист')
GO
INSERT [dbo].[Места в театре] ([id_места], [Тип места], [id_зала], [Количество]) VALUES (1, N'Партер', 1, 100)
GO
INSERT [dbo].[Места в театре] ([id_места], [Тип места], [id_зала], [Количество]) VALUES (2, N'Балкон', 1, 200)
GO
INSERT [dbo].[Места в театре] ([id_места], [Тип места], [id_зала], [Количество]) VALUES (3, N'Ложа', 1, 50)
GO
INSERT [dbo].[Места в театре] ([id_места], [Тип места], [id_зала], [Количество]) VALUES (4, N'Партер', 2, 70)
GO
INSERT [dbo].[Места в театре] ([id_места], [Тип места], [id_зала], [Количество]) VALUES (5, N'Ложа', 2, 150)
GO
INSERT [dbo].[Места в театре] ([id_места], [Тип места], [id_зала], [Количество]) VALUES (6, N'Амфитеатр', 2, 80)
GO
INSERT [dbo].[Места в театре] ([id_места], [Тип места], [id_зала], [Количество]) VALUES (7, N'Балкон', 3, 300)
GO
INSERT [dbo].[Места в театре] ([id_места], [Тип места], [id_зала], [Количество]) VALUES (8, N'Ложа', 3, 80)
GO
INSERT [dbo].[Места в театре] ([id_места], [Тип места], [id_зала], [Количество]) VALUES (9, N'Бельэтаж', 3, 20)
GO
INSERT [dbo].[Места в театре] ([id_места], [Тип места], [id_зала], [Количество]) VALUES (10, N'Партер', 4, 310)
GO
INSERT [dbo].[Места в театре] ([id_места], [Тип места], [id_зала], [Количество]) VALUES (11, N'Балкон', 4, 50)
GO
INSERT [dbo].[Места в театре] ([id_места], [Тип места], [id_зала], [Количество]) VALUES (12, N'Амфитеатр', 4, 85)
GO
INSERT [dbo].[Места в театре] ([id_места], [Тип места], [id_зала], [Количество]) VALUES (13, N'Балкон', 5, 100)
GO
INSERT [dbo].[Места в театре] ([id_места], [Тип места], [id_зала], [Количество]) VALUES (14, N'Амфитеатр', 5, 100)
GO
INSERT [dbo].[Места в театре] ([id_места], [Тип места], [id_зала], [Количество]) VALUES (15, N'Бельэтаж', 5, 35)
GO
INSERT [dbo].[Места в театре] ([id_места], [Тип места], [id_зала], [Количество]) VALUES (16, N'Партер', 6, 185)
GO
INSERT [dbo].[Места в театре] ([id_места], [Тип места], [id_зала], [Количество]) VALUES (17, N'Ложа', 6, 80)
GO
INSERT [dbo].[Места в театре] ([id_места], [Тип места], [id_зала], [Количество]) VALUES (18, N'Бельэтаж', 6, 40)
GO
INSERT [dbo].[Персональные_данные_пользователя] ([id_пользователя], [Телефон], [Адрес], [Серия_паспорта], [Номер_паспорта], [Выдан]) VALUES (1, 0, N' ', 0, 0, N' ')
GO
INSERT [dbo].[Персональные_данные_пользователя] ([id_пользователя], [Телефон], [Адрес], [Серия_паспорта], [Номер_паспорта], [Выдан]) VALUES (2, 911, N'SPB', 1331, 979331, N'GU MVD')
GO
INSERT [dbo].[Персональные_данные_пользователя] ([id_пользователя], [Телефон], [Адрес], [Серия_паспорта], [Номер_паспорта], [Выдан]) VALUES (3, 0, N' ', 0, 0, N' ')
GO
INSERT [dbo].[Персональные_данные_пользователя] ([id_пользователя], [Телефон], [Адрес], [Серия_паспорта], [Номер_паспорта], [Выдан]) VALUES (4, 0, N' ', 0, 0, N' ')
GO
INSERT [dbo].[Персональные_данные_пользователя] ([id_пользователя], [Телефон], [Адрес], [Серия_паспорта], [Номер_паспорта], [Выдан]) VALUES (5, 0, N' ', 0, 0, N' ')
GO
INSERT [dbo].[Персональные_данные_пользователя] ([id_пользователя], [Телефон], [Адрес], [Серия_паспорта], [Номер_паспорта], [Выдан]) VALUES (6, 0, N' ', 0, 0, N' ')
GO
INSERT [dbo].[Персональные_данные_пользователя] ([id_пользователя], [Телефон], [Адрес], [Серия_паспорта], [Номер_паспорта], [Выдан]) VALUES (7, 0, N' ', 0, 0, N' ')
GO
INSERT [dbo].[Персональные_данные_пользователя] ([id_пользователя], [Телефон], [Адрес], [Серия_паспорта], [Номер_паспорта], [Выдан]) VALUES (8, 0, N' ', 0, 0, N' ')
GO
INSERT [dbo].[Пользователи] ([id_пользователя], [Фамилия], [Имя], [Отчество], [Дата_рождения], [Логин], [Пароль], [id_роли]) VALUES (1, N'Гусев', N'Вадим', N'Кириллович', CAST(N'2000-01-13' AS Date), N'gv', N'46aff8dcc7bf1bda0c15e2fc2aceacba953db6e34055b69ef7aca044115612f6d74598292f6982eb660e076f31965388d848de60fc3c5946ef461813258de408', 1)
GO
INSERT [dbo].[Пользователи] ([id_пользователя], [Фамилия], [Имя], [Отчество], [Дата_рождения], [Логин], [Пароль], [id_роли]) VALUES (2, N'Орехова', N'Анна', N'Степановна', CAST(N'1998-09-20' AS Date), N'OA', N'634ada37c0e4c3f6d390319e746a70edc403ee3d6bb424180e8ef2b395f9dbb1251881aa740d1eb73c42cede61d50fdbdd8c144f357a5cc95b42986620a89b76', 1)
GO
INSERT [dbo].[Пользователи] ([id_пользователя], [Фамилия], [Имя], [Отчество], [Дата_рождения], [Логин], [Пароль], [id_роли]) VALUES (3, N'Козырева', N'Любовь', N'Дмитриевна', CAST(N'1971-01-20' AS Date), N'kl', N'5eb23b8a88f961e81d88cdac27d7c8a3e65ed5e44b7303a5f5daddb80efc67c708e48c85028c9be1e831c7f666429d284f4fae9dbeee39dd7fe7ba3fb5fa3b27', 2)
GO
INSERT [dbo].[Пользователи] ([id_пользователя], [Фамилия], [Имя], [Отчество], [Дата_рождения], [Логин], [Пароль], [id_роли]) VALUES (4, N'Боброва', N'Вера', N'Дмитриевна', CAST(N'1977-01-03' AS Date), N'bv', N'0de8137cecb759503b568d5f1a297186436e5c4d9e2387c87b4521b8d0848cb74d56e0fc55066ec62bf37ae0b6f50074238d60b5f84549939e014fe0b92598bf', 2)
GO
INSERT [dbo].[Пользователи] ([id_пользователя], [Фамилия], [Имя], [Отчество], [Дата_рождения], [Логин], [Пароль], [id_роли]) VALUES (5, N'Кошелева', N'Ксения', N'Дмитриевна', CAST(N'1989-03-10' AS Date), N'KK', N'ecc82159a587c7ad095048b8514ff27512edf742ab68233409284e70b542d1fce4eabc949c7857f73479a6bf3a281a086b91553cfe138f5082a81a5241426ce7', 3)
GO
INSERT [dbo].[Пользователи] ([id_пользователя], [Фамилия], [Имя], [Отчество], [Дата_рождения], [Логин], [Пароль], [id_роли]) VALUES (6, N'Игнатов', N'Илья', N'Константинович', CAST(N'2002-02-24' AS Date), N'ii', N'7e048a77d6f0f51f138ded95ee71f9c2ccd90dd35fdfcbbd93513566ed5663b5b2c6303c5ac2780cd8a5b9c48c0e90b7609dab15603e49c5dec0da2555eea9d9', 3)
GO
INSERT [dbo].[Пользователи] ([id_пользователя], [Фамилия], [Имя], [Отчество], [Дата_рождения], [Логин], [Пароль], [id_роли]) VALUES (7, N'Ларионова', N'Светлана', N'Дмитриевна', CAST(N'1996-11-30' AS Date), N'LS', N'3f22397c6ca2be96f6236ab0052b96f2b8a52fc99e9ed087f11e25a83eecb7962b687c84fcd88c81ea1d9338512235c3c8c43afaffad8733d2e90eebb96d8274', 3)
GO
INSERT [dbo].[Пользователи] ([id_пользователя], [Фамилия], [Имя], [Отчество], [Дата_рождения], [Логин], [Пароль], [id_роли]) VALUES (8, N'A', N'A', N'A', CAST(N'2023-05-31' AS Date), N'Aa', N'bb55386f0b30b93b35a4a51f96cd6fb1242460e2b639cbcbcd8c4e6d6880527bf265170b839c622d2bda91f04dfa5c956be7e97fd133471e1eade03b34e62c85', 3)
GO
INSERT [dbo].[Репертуар] ([id_репертуара], [Наименование спектакля], [Описание репертуара], [id_театра], [Длительность спектакля], [Жанр], [Возрастной рейтинг]) VALUES (1, N'Опера «Любовный напиток»                                                                            ', N'В условиях, когда примадонна – немка, ...', 1, CAST(N'02:40:00' AS Time), N'опера', 6)
GO
INSERT [dbo].[Репертуар] ([id_репертуара], [Наименование спектакля], [Описание репертуара], [id_театра], [Длительность спектакля], [Жанр], [Возрастной рейтинг]) VALUES (2, N'Балет «Спящая красавица»                                                                            ', N'В пленительной музыке Чайковского и сказочном сюжете Шарля Перро, ...', 1, CAST(N'02:45:00' AS Time), N'балет', 6)
GO
INSERT [dbo].[Репертуар] ([id_репертуара], [Наименование спектакля], [Описание репертуара], [id_театра], [Длительность спектакля], [Жанр], [Возрастной рейтинг]) VALUES (3, N'Балет «Жизель, или Вилисы»                                                                          ', N'Либретто Жюля Анри Вернуа де Сен-Жоржа, ...', 1, CAST(N'02:15:00' AS Time), N'балет', 6)
GO
INSERT [dbo].[Репертуар] ([id_репертуара], [Наименование спектакля], [Описание репертуара], [id_театра], [Длительность спектакля], [Жанр], [Возрастной рейтинг]) VALUES (4, N'Опера «Аида»                                                                                        ', N'Рабы, полководцы и цари равны, ...', 1, CAST(N'02:00:00' AS Time), N'опера', 12)
GO
INSERT [dbo].[Репертуар] ([id_репертуара], [Наименование спектакля], [Описание репертуара], [id_театра], [Длительность спектакля], [Жанр], [Возрастной рейтинг]) VALUES (5, N'Балет «Сильфида»                                                                                    ', N'Манифест балетного романтизма, ...', 2, CAST(N'01:40:00' AS Time), N'балет', 6)
GO
INSERT [dbo].[Репертуар] ([id_репертуара], [Наименование спектакля], [Описание репертуара], [id_театра], [Длительность спектакля], [Жанр], [Возрастной рейтинг]) VALUES (6, N'Опера «Троянцы»                                                                                     ', N'Шарль Гуно, младший современник Берлиоза, ...', 2, CAST(N'05:05:00' AS Time), N'опера', 12)
GO
INSERT [dbo].[Репертуар] ([id_репертуара], [Наименование спектакля], [Описание репертуара], [id_театра], [Длительность спектакля], [Жанр], [Возрастной рейтинг]) VALUES (7, N'Опера «Золушка»                                                                                     ', N'В заглавной партии – ...', 2, CAST(N'02:00:00' AS Time), N'опера', 6)
GO
INSERT [dbo].[Репертуар] ([id_репертуара], [Наименование спектакля], [Описание репертуара], [id_театра], [Длительность спектакля], [Жанр], [Возрастной рейтинг]) VALUES (8, N'Опера «Орлеанская дева»                                                                             ', N'«Орлеанская дева» – самая монументальная и ...', 2, CAST(N'02:45:00' AS Time), N'опера', 6)
GO
INSERT [dbo].[Репертуар] ([id_репертуара], [Наименование спектакля], [Описание репертуара], [id_театра], [Длительность спектакля], [Жанр], [Возрастной рейтинг]) VALUES (9, N'Спектакль «Гроза»                                                                                   ', N'Впервые за столетнюю историю в БДТ ...', 3, CAST(N'02:15:00' AS Time), N'спектакль', 16)
GO
INSERT [dbo].[Репертуар] ([id_репертуара], [Наименование спектакля], [Описание репертуара], [id_театра], [Длительность спектакля], [Жанр], [Возрастной рейтинг]) VALUES (10, N'Спектакль «Джульетта»                                                                               ', N'«Джульетта» – первый спектакль, ...', 3, CAST(N'03:30:00' AS Time), N'спектакль', 18)
GO
INSERT [dbo].[Репертуар] ([id_репертуара], [Наименование спектакля], [Описание репертуара], [id_театра], [Длительность спектакля], [Жанр], [Возрастной рейтинг]) VALUES (11, N'Спектакль «Привидения»                                                                              ', N'Спектакль «Привидения» — новая совместная работа ...', 3, CAST(N'02:30:00' AS Time), N'спектакль', 16)
GO
INSERT [dbo].[Репертуар] ([id_репертуара], [Наименование спектакля], [Описание репертуара], [id_театра], [Длительность спектакля], [Жанр], [Возрастной рейтинг]) VALUES (12, N'Спектакль «Дама с собачкой»                                                                         ', N'«Дама с собачкой» Анатолия Праудина – ...', 3, CAST(N'02:35:00' AS Time), N'спектакль', 12)
GO
INSERT [dbo].[Роли] ([id_роли], [Наименование роли]) VALUES (1, N'Герой')
GO
INSERT [dbo].[Роли] ([id_роли], [Наименование роли]) VALUES (2, N'Шут')
GO
INSERT [dbo].[Роли] ([id_роли], [Наименование роли]) VALUES (3, N'Злодей')
GO
INSERT [dbo].[Роли] ([id_роли], [Наименование роли]) VALUES (4, N'Проказник')
GO
INSERT [dbo].[Роли] ([id_роли], [Наименование роли]) VALUES (5, N'Неизвестный')
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (1, 1, 1)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (1, 1, 3)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (1, 3, 2)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (1, 4, 2)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (1, 6, 1)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (1, 6, 3)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (1, 8, 2)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (2, 2, 2)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (2, 2, 4)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (2, 4, 3)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (2, 5, 3)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (2, 7, 2)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (2, 7, 4)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (2, 9, 3)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (3, 1, 4)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (3, 3, 3)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (3, 3, 5)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (3, 5, 4)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (3, 6, 4)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (3, 8, 3)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (3, 8, 5)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (4, 1, 5)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (4, 2, 5)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (4, 4, 1)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (4, 4, 4)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (4, 6, 5)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (4, 7, 5)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (5, 2, 1)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (5, 3, 1)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (5, 5, 2)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (5, 5, 5)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (5, 7, 1)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (5, 8, 1)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (6, 9, 1)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (6, 9, 2)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (6, 9, 4)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (6, 12, 1)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (6, 14, 1)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (6, 14, 2)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (6, 14, 4)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (7, 10, 2)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (7, 10, 3)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (7, 10, 5)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (7, 13, 2)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (7, 15, 2)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (7, 15, 3)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (7, 15, 5)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (8, 11, 1)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (8, 11, 3)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (8, 11, 4)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (8, 14, 3)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (8, 16, 1)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (8, 16, 3)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (8, 16, 4)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (9, 10, 4)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (9, 12, 2)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (9, 12, 4)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (9, 12, 5)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (9, 15, 4)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (10, 11, 5)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (10, 13, 1)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (10, 13, 3)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (10, 13, 5)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (10, 16, 5)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (11, 17, 2)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (11, 17, 5)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (11, 19, 3)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (11, 20, 2)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (11, 22, 2)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (11, 22, 5)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (11, 24, 3)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (12, 18, 1)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (12, 18, 3)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (12, 20, 4)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (12, 21, 3)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (12, 23, 1)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (12, 23, 3)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (13, 17, 4)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (13, 19, 2)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (13, 19, 4)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (13, 21, 5)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (13, 22, 4)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (13, 24, 2)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (13, 24, 4)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (14, 17, 1)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (14, 18, 5)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (14, 20, 3)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (14, 20, 5)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (14, 22, 1)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (14, 23, 5)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (15, 18, 2)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (15, 19, 1)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (15, 21, 1)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (15, 21, 4)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (15, 23, 2)
GO
INSERT [dbo].[Роли в афише] ([id_артиста], [id_афишы], [id_роли]) VALUES (15, 24, 1)
GO
INSERT [dbo].[Роли_пользователей] ([id_роли], [Наименование_роли]) VALUES (1, N'Администратор')
GO
INSERT [dbo].[Роли_пользователей] ([id_роли], [Наименование_роли]) VALUES (2, N'Актр')
GO
INSERT [dbo].[Роли_пользователей] ([id_роли], [Наименование_роли]) VALUES (3, N'Клиент')
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (1, 1, 5194.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (1, 4, 2124.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (1, 7, 10305.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (1, 26, 2451.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (1, 29, 11620.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (1, 32, 4611.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (1, 51, 9605.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (1, 54, 8614.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (1, 73, 10624.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (1, 76, 2447.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (1, 79, 13337.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (2, 2, 7970.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (2, 5, 10283.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (2, 8, 10816.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (2, 27, 9343.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (2, 30, 3623.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (2, 49, 2394.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (2, 52, 1545.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (2, 55, 9468.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (2, 74, 14269.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (2, 77, 8582.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (2, 80, 13130.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (3, 3, 5879.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (3, 6, 9706.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (3, 25, 5866.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (3, 28, 10476.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (3, 31, 2391.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (3, 50, 12266.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (3, 53, 7050.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (3, 56, 13248.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (3, 75, 4476.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (3, 78, 4802.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (4, 9, 14386.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (4, 34, 10329.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (4, 59, 11739.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (4, 84, 4739.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (5, 10, 4055.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (5, 35, 11327.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (5, 60, 3636.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (5, 85, 8362.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (6, 11, 1991.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (6, 36, 13216.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (6, 61, 11686.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (6, 86, 14401.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (7, 12, 10811.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (7, 37, 7159.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (7, 62, 14183.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (7, 87, 12144.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (8, 13, 7755.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (8, 38, 7985.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (8, 63, 3310.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (8, 88, 10244.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (9, 14, 2541.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (9, 39, 3153.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (9, 64, 13057.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (10, 15, 5263.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (10, 40, 12698.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (10, 81, 5719.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (11, 16, 9150.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (11, 57, 2080.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (11, 82, 11084.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (12, 33, 13744.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (12, 58, 9073.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (12, 83, 8278.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (13, 17, 3843.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (13, 23, 9426.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (13, 45, 13004.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (13, 67, 11210.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (13, 89, 7537.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (13, 95, 6594.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (14, 18, 11445.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (14, 24, 5423.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (14, 46, 6622.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (14, 68, 11413.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (14, 90, 5548.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (14, 96, 7576.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (15, 19, 3581.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (15, 41, 2218.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (15, 47, 5873.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (15, 69, 7115.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (15, 91, 10012.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (16, 20, 2586.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (16, 42, 2508.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (16, 48, 14735.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (16, 70, 5453.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (16, 92, 2681.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (17, 21, 12737.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (17, 43, 10547.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (17, 65, 3307.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (17, 71, 1720.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (17, 93, 5732.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (18, 22, 6341.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (18, 44, 2314.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (18, 66, 12672.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (18, 72, 9202.0000)
GO
INSERT [dbo].[Стоимость мест в театре] ([id_места], [id_билета], [Стоимость]) VALUES (18, 94, 7668.0000)
GO
INSERT [dbo].[Театр] ([id_театра], [Наименование театра], [Логотип], [Описание театра]) VALUES (1, N'Михайловский театр', N'../../images/miр.png', N'Михайловский театр – знаменитый музыкальный театр, ...')
GO
INSERT [dbo].[Театр] ([id_театра], [Наименование театра], [Логотип], [Описание театра]) VALUES (2, N'Мариинский театр', N'../../images/mar.jpg', N'Летоисчисление труппы Мариинского театра ведется с 1783 года, ...')
GO
INSERT [dbo].[Театр] ([id_театра], [Наименование театра], [Логотип], [Описание театра]) VALUES (3, N'Большой драматический театр им. Г.А.Товстоногова (БДТ)', N'../../images/bdt.png', N'Большой драматический театр, или БДТ, ...')
GO
ALTER TABLE [dbo].[Артисты в театре]  WITH CHECK ADD  CONSTRAINT [FK_Артисты в театре_Звания] FOREIGN KEY([id_звания])
REFERENCES [dbo].[Звания] ([id_звания])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Артисты в театре] CHECK CONSTRAINT [FK_Артисты в театре_Звания]
GO
ALTER TABLE [dbo].[Артисты в театре]  WITH CHECK ADD  CONSTRAINT [FK_Артисты в театре_Театр] FOREIGN KEY([id_театра])
REFERENCES [dbo].[Театр] ([id_театра])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Артисты в театре] CHECK CONSTRAINT [FK_Артисты в театре_Театр]
GO
ALTER TABLE [dbo].[Афиша]  WITH CHECK ADD  CONSTRAINT [FK_Афиша_Залы в театре] FOREIGN KEY([id_заал])
REFERENCES [dbo].[Залы в театре] ([id_зала])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Афиша] CHECK CONSTRAINT [FK_Афиша_Залы в театре]
GO
ALTER TABLE [dbo].[Афиша]  WITH CHECK ADD  CONSTRAINT [FK_Афиша_Репертуар] FOREIGN KEY([id_репертуара])
REFERENCES [dbo].[Репертуар] ([id_репертуара])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Афиша] CHECK CONSTRAINT [FK_Афиша_Репертуар]
GO
ALTER TABLE [dbo].[Билет]  WITH CHECK ADD  CONSTRAINT [FK_Билет_Афиша] FOREIGN KEY([id_афишы])
REFERENCES [dbo].[Афиша] ([id_афишы])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Билет] CHECK CONSTRAINT [FK_Билет_Афиша]
GO
ALTER TABLE [dbo].[Места в театре]  WITH CHECK ADD  CONSTRAINT [FK_Места в театре_Залы в театре] FOREIGN KEY([id_зала])
REFERENCES [dbo].[Залы в театре] ([id_зала])
GO
ALTER TABLE [dbo].[Места в театре] CHECK CONSTRAINT [FK_Места в театре_Залы в театре]
GO
ALTER TABLE [dbo].[Персональные_данные_пользователя]  WITH CHECK ADD  CONSTRAINT [FK__Персональ__id_по__7C4F7684] FOREIGN KEY([id_пользователя])
REFERENCES [dbo].[Пользователи] ([id_пользователя])
GO
ALTER TABLE [dbo].[Персональные_данные_пользователя] CHECK CONSTRAINT [FK__Персональ__id_по__7C4F7684]
GO
ALTER TABLE [dbo].[Пользователи]  WITH CHECK ADD  CONSTRAINT [FK_Пользователи_Роли_пользователей] FOREIGN KEY([id_роли])
REFERENCES [dbo].[Роли_пользователей] ([id_роли])
GO
ALTER TABLE [dbo].[Пользователи] CHECK CONSTRAINT [FK_Пользователи_Роли_пользователей]
GO
ALTER TABLE [dbo].[Репертуар]  WITH CHECK ADD  CONSTRAINT [FK_Репертуар_Театр] FOREIGN KEY([id_театра])
REFERENCES [dbo].[Театр] ([id_театра])
GO
ALTER TABLE [dbo].[Репертуар] CHECK CONSTRAINT [FK_Репертуар_Театр]
GO
ALTER TABLE [dbo].[Роли в афише]  WITH CHECK ADD  CONSTRAINT [FK_Роли в афише_Артисты в театре] FOREIGN KEY([id_артиста])
REFERENCES [dbo].[Артисты в театре] ([id_артиста])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Роли в афише] CHECK CONSTRAINT [FK_Роли в афише_Артисты в театре]
GO
ALTER TABLE [dbo].[Роли в афише]  WITH CHECK ADD  CONSTRAINT [FK_Роли в афише_Афиша] FOREIGN KEY([id_афишы])
REFERENCES [dbo].[Афиша] ([id_афишы])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Роли в афише] CHECK CONSTRAINT [FK_Роли в афише_Афиша]
GO
ALTER TABLE [dbo].[Роли в афише]  WITH CHECK ADD  CONSTRAINT [FK_Роли в афише_Роли] FOREIGN KEY([id_роли])
REFERENCES [dbo].[Роли] ([id_роли])
GO
ALTER TABLE [dbo].[Роли в афише] CHECK CONSTRAINT [FK_Роли в афише_Роли]
GO
ALTER TABLE [dbo].[Стоимость мест в театре]  WITH CHECK ADD  CONSTRAINT [FK_Стоимость мест в театре_Билет] FOREIGN KEY([id_билета])
REFERENCES [dbo].[Билет] ([id_билета])
GO
ALTER TABLE [dbo].[Стоимость мест в театре] CHECK CONSTRAINT [FK_Стоимость мест в театре_Билет]
GO
ALTER TABLE [dbo].[Стоимость мест в театре]  WITH CHECK ADD  CONSTRAINT [FK_Стоимость мест в театре_Места в театре] FOREIGN KEY([id_места])
REFERENCES [dbo].[Места в театре] ([id_места])
GO
ALTER TABLE [dbo].[Стоимость мест в театре] CHECK CONSTRAINT [FK_Стоимость мест в театре_Места в театре]
GO
/****** Object:  StoredProcedure [dbo].[Check_Login]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Check_Login]
@login nvarchar(100)
as
select [Логин]
from [dbo].[Пользователи] p
where [Логин] = @login
GO
/****** Object:  StoredProcedure [dbo].[Create_Teatr]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Create_Teatr]
@name varchar(100), @logo varchar(100), @review text
as
insert into [dbo].[Театр]
values
((select max([id_театра]) + 1 from [dbo].[Театр]), @name, @logo, @review)
GO
/****** Object:  StoredProcedure [dbo].[Load_Afisha]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Load_Afisha]
@id int
as 
select [id_афишы],[Дата проведения],[Время проведения],[Наименование зала],[Адрес]
from [dbo].[Афиша] a join [dbo].[Залы в театре] z
on a.[id_заал] = z.[id_зала]
where [id_репертуара] = @id
GO
/****** Object:  StoredProcedure [dbo].[Load_Janr]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Load_Janr]
as
select distinct [Жанр]
from [dbo].[Репертуар]
GO
/****** Object:  StoredProcedure [dbo].[Load_Repertuar]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Load_Repertuar]
@id int
as 
SELECT [id_репертуара]
      ,[Наименование спектакля]
      ,[Описание репертуара]
      ,[Длительность спектакля]
      ,[Жанр]
      ,[Возрастной рейтинг]
  FROM [Teatre].[dbo].[Репертуар]
where [id_театра] = @id
GO
/****** Object:  StoredProcedure [dbo].[Load_Repertuar_Janr]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Load_Repertuar_Janr]
@id int, @janr varchar(50)
as 
SELECT [id_репертуара]
      ,[Наименование спектакля]
      ,[Описание репертуара]
      ,[Длительность спектакля]
      ,[Жанр]
      ,[Возрастной рейтинг]
  FROM [Teatre].[dbo].[Репертуар]
where [id_театра] = @id
and [Жанр] = @janr
GO
/****** Object:  StoredProcedure [dbo].[Load_teatr]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Load_teatr]
as
select [id_театра],[Наименование театра],[Логотип],[Описание театра]
from [dbo].[Театр]
GO
/****** Object:  StoredProcedure [dbo].[Load_Teatr_Update]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Load_Teatr_Update]
@id int
as
select [id_театра],[Наименование театра],[Логотип],[Описание театра]
from [dbo].[Театр]
where [id_театра] = @id
GO
/****** Object:  StoredProcedure [dbo].[Load_User]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Load_User]
@id int
as
select p.[id_пользователя],[Фамилия],[Имя],[Отчество],[Дата_рождения],[Логин],[Пароль],[id_роли],[Телефон],[Адрес],[Серия_паспорта],[Номер_паспорта],[Выдан]
from [dbo].[Пользователи] p join [dbo].[Персональные_данные_пользователя] pd
on p.[id_пользователя] = pd.[id_пользователя]
where p.[id_пользователя] = @id
GO
/****** Object:  StoredProcedure [dbo].[Load_User_Autorization]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Load_User_Autorization]
@login nvarchar(100)
as
select p.[id_пользователя],[Фамилия],[Имя],[Отчество],[Дата_рождения],[Логин],[Пароль],[id_роли]
from [dbo].[Пользователи] p
where [Логин] = @login
GO
/****** Object:  StoredProcedure [dbo].[Login_Load]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Login_Load]
@id int
as
select [Логин]  from [dbo].[Пользователи] where [id_пользователя] = @id
GO
/****** Object:  StoredProcedure [dbo].[Teatr_Delete]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Teatr_Delete]
@id int
as
delete [dbo].[Театр]
where [id_театра] = @id
GO
/****** Object:  StoredProcedure [dbo].[Teatr_Update]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Teatr_Update]
@id int, @name varchar(100), @logo varchar(100), @review text 
as
update [dbo].[Театр]
set [Наименование театра] = @name,
[Логотип] = @logo,
[Описание театра] = @review
where [id_театра] = @id
GO
/****** Object:  StoredProcedure [dbo].[Update_Pass]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Update_Pass]
@id int, @login nvarchar(100), @pass text
as
update [dbo].[Пользователи]
set [Логин] = @login,
[Пароль] = @pass
where [id_пользователя] = @id
GO
/****** Object:  StoredProcedure [dbo].[Update_User_Full]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Update_User_Full]
@id int, @fn varchar(100), @ln varchar(100), @pat varchar(100), @dob date, @login nvarchar(100),
@ph float, @add text, @seria int, @num int, @vidan text
as
update [dbo].[Пользователи]
set [Фамилия] = @fn
      ,[Имя] = @ln
      ,[Отчество] = @pat
      ,[Дата_рождения] = @dob
      ,[Логин] = @login
where [id_пользователя] = @id
update [dbo].[Персональные_данные_пользователя]
set [Телефон] = @ph
      ,[Адрес] = @add
      ,[Серия_паспорта] = @seria
      ,[Номер_паспорта] = @num
      ,[Выдан] = @vidan
where [id_пользователя] = @id
GO
/****** Object:  StoredProcedure [dbo].[Update_User_Less]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Update_User_Less]
@id int, @fn varchar(100), @ln varchar(100), @pat varchar(100), @dob date, @login nvarchar(100)
--@ph float, @add text, @seria int, @num int, @vidan text
as
update [dbo].[Пользователи]
set [Фамилия] = @fn
      ,[Имя] = @ln
      ,[Отчество] = @pat
      ,[Дата_рождения] = @dob
      ,[Логин] = @login
where [id_пользователя] = @id
--update [dbo].[Персональные_данные_пользователя]
--set [Телефон] = @ph
--      ,[Адрес] = @add
--      ,[Серия_паспорта] = @seria
--      ,[Номер_паспорта] = @num
--      ,[Выдан] = @vidan
--where [id_пользователя] = @id
GO
/****** Object:  StoredProcedure [dbo].[User_Add]    Script Date: 22.04.2025 1:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[User_Add]
@FN	varchar(100), @LN varchar(100), @Pat varchar(100), @DOB date,@log nvarchar(100),@pass text
as
insert into [dbo].[Пользователи]
values
((select max([id_пользователя])+1 from [dbo].[Пользователи]),@FN,@LN,@Pat,@DOB,@log,@pass,3)
GO
USE [master]
GO
ALTER DATABASE [Teatre] SET  READ_WRITE 
GO
