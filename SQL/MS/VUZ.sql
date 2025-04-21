USE [master]
GO
/****** Object:  Database [VUZ]    Script Date: 22.04.2025 1:43:43 ******/
CREATE DATABASE [VUZ]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'VUZ', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER1\MSSQL\DATA\VUZ.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'VUZ_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER1\MSSQL\DATA\VUZ_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [VUZ] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VUZ].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [VUZ] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [VUZ] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [VUZ] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [VUZ] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [VUZ] SET ARITHABORT OFF 
GO
ALTER DATABASE [VUZ] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [VUZ] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [VUZ] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [VUZ] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [VUZ] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [VUZ] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [VUZ] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [VUZ] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [VUZ] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [VUZ] SET  ENABLE_BROKER 
GO
ALTER DATABASE [VUZ] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [VUZ] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [VUZ] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [VUZ] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [VUZ] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [VUZ] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [VUZ] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [VUZ] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [VUZ] SET  MULTI_USER 
GO
ALTER DATABASE [VUZ] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [VUZ] SET DB_CHAINING OFF 
GO
ALTER DATABASE [VUZ] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [VUZ] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [VUZ] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [VUZ] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [VUZ] SET QUERY_STORE = OFF
GO
USE [VUZ]
GO
/****** Object:  Table [dbo].[Group]    Script Date: 22.04.2025 1:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group](
	[id_group] [int] IDENTITY(1,1) NOT NULL,
	[Name_group] [varchar](50) NOT NULL,
	[id_spec] [int] NOT NULL,
	[Num_course] [int] NOT NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[id_group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lessons]    Script Date: 22.04.2025 1:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lessons](
	[id_lesson] [int] IDENTITY(1,1) NOT NULL,
	[Name_lesson] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Lessons] PRIMARY KEY CLUSTERED 
(
	[id_lesson] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Load_teachers]    Script Date: 22.04.2025 1:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Load_teachers](
	[id_load] [int] IDENTITY(1,1) NOT NULL,
	[id_plan] [int] NOT NULL,
	[id_teacher] [int] NOT NULL,
 CONSTRAINT [PK_Load_teachers] PRIMARY KEY CLUSTERED 
(
	[id_load] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Programm_of_lesson]    Script Date: 22.04.2025 1:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Programm_of_lesson](
	[id_prog] [int] IDENTITY(1,1) NOT NULL,
	[id_plan] [int] NOT NULL,
	[Topic_lesson] [varchar](100) NOT NULL,
	[id_type] [int] NOT NULL,
 CONSTRAINT [PK_Programm_of_lesson] PRIMARY KEY CLUSTERED 
(
	[id_prog] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 22.04.2025 1:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[id_role] [int] IDENTITY(1,1) NOT NULL,
	[Name_role] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[id_role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Specialization]    Script Date: 22.04.2025 1:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Specialization](
	[id_spec] [int] IDENTITY(1,1) NOT NULL,
	[Name_spec] [varchar](200) NOT NULL,
 CONSTRAINT [PK_Specialization] PRIMARY KEY CLUSTERED 
(
	[id_spec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status_teacher]    Script Date: 22.04.2025 1:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status_teacher](
	[id_status] [int] IDENTITY(1,1) NOT NULL,
	[Name_status] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Status_teacher] PRIMARY KEY CLUSTERED 
(
	[id_status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 22.04.2025 1:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[id_student] [int] IDENTITY(1,1) NOT NULL,
	[FIO] [varchar](100) NOT NULL,
	[Phone] [float] NULL,
	[Email] [varchar](100) NULL,
	[Date_Of_Birthday] [date] NULL,
	[id_group] [int] NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[id_student] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Study_plan]    Script Date: 22.04.2025 1:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Study_plan](
	[id_plan] [int] IDENTITY(1,1) NOT NULL,
	[id_group] [int] NOT NULL,
	[id_lesson] [int] NOT NULL,
	[Hours] [int] NOT NULL,
	[Hours_1sem] [int] NOT NULL,
	[Hours_2sem] [int] NOT NULL,
 CONSTRAINT [PK_Study_plan] PRIMARY KEY CLUSTERED 
(
	[id_plan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teacher]    Script Date: 22.04.2025 1:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teacher](
	[id_teacher] [int] IDENTITY(1,1) NOT NULL,
	[FIO] [varchar](100) NOT NULL,
	[id_status] [int] NOT NULL,
	[Date_of_Birthday] [date] NULL,
	[Phone] [float] NULL,
	[Email] [varchar](100) NULL,
	[Work_expirience] [int] NULL,
 CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED 
(
	[id_teacher] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Type_of_lesson]    Script Date: 22.04.2025 1:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Type_of_lesson](
	[id_type] [int] IDENTITY(1,1) NOT NULL,
	[Name_type] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Type_of_lesson] PRIMARY KEY CLUSTERED 
(
	[id_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 22.04.2025 1:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id_user] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[Patronymic] [varchar](100) NULL,
	[Email] [varchar](100) NULL,
	[id_role] [int] NOT NULL,
	[Login] [varchar](100) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[Passwordik] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[id_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Group] ON 
GO
INSERT [dbo].[Group] ([id_group], [Name_group], [id_spec], [Num_course]) VALUES (1, N'31-ИБ', 5, 3)
GO
INSERT [dbo].[Group] ([id_group], [Name_group], [id_spec], [Num_course]) VALUES (2, N'22-ИБ', 5, 2)
GO
INSERT [dbo].[Group] ([id_group], [Name_group], [id_spec], [Num_course]) VALUES (3, N'11-КС', 1, 1)
GO
INSERT [dbo].[Group] ([id_group], [Name_group], [id_spec], [Num_course]) VALUES (4, N'42-КС', 1, 4)
GO
INSERT [dbo].[Group] ([id_group], [Name_group], [id_spec], [Num_course]) VALUES (5, N'12-ИС', 2, 1)
GO
INSERT [dbo].[Group] ([id_group], [Name_group], [id_spec], [Num_course]) VALUES (6, N'31-ИС', 2, 3)
GO
INSERT [dbo].[Group] ([id_group], [Name_group], [id_spec], [Num_course]) VALUES (7, N'11-СА', 3, 1)
GO
INSERT [dbo].[Group] ([id_group], [Name_group], [id_spec], [Num_course]) VALUES (8, N'21-СА', 3, 2)
GO
INSERT [dbo].[Group] ([id_group], [Name_group], [id_spec], [Num_course]) VALUES (9, N'32-ИИ', 4, 3)
GO
INSERT [dbo].[Group] ([id_group], [Name_group], [id_spec], [Num_course]) VALUES (10, N'31-ИИ', 4, 3)
GO
SET IDENTITY_INSERT [dbo].[Group] OFF
GO
SET IDENTITY_INSERT [dbo].[Lessons] ON 
GO
INSERT [dbo].[Lessons] ([id_lesson], [Name_lesson]) VALUES (1, N'ФИЗИЧЕСКАЯ КУЛЬТУРА')
GO
INSERT [dbo].[Lessons] ([id_lesson], [Name_lesson]) VALUES (2, N'БЕЗОПАСНОСТЬ ЖИЗНЕДЕЯТЕЛЬНОСТИ ')
GO
INSERT [dbo].[Lessons] ([id_lesson], [Name_lesson]) VALUES (3, N'ПСИХОЛОГИЯ ОБЩЕНИЯ ')
GO
INSERT [dbo].[Lessons] ([id_lesson], [Name_lesson]) VALUES (4, N'ОСНОВЫ ПРЕДПРИНИМАТЕЛЬСКОЙ ДЕЯТЕЛЬНОСТИ ')
GO
INSERT [dbo].[Lessons] ([id_lesson], [Name_lesson]) VALUES (5, N'ПРАВОВОЕ ОБЕСПЕЧЕНИЕ ПРОФЕССИОНАЛЬНОЙ ДЕЯТЕЛЬНОСТИ ')
GO
INSERT [dbo].[Lessons] ([id_lesson], [Name_lesson]) VALUES (6, N'ЭКОНОМИКА ОТРАСЛИ ')
GO
INSERT [dbo].[Lessons] ([id_lesson], [Name_lesson]) VALUES (7, N'ИНОСТРАННЫЙ ЯЗЫК В ПРОФЕССИОНАЛЬНОЙ ДЕЯТЕЛЬНОСТИ')
GO
INSERT [dbo].[Lessons] ([id_lesson], [Name_lesson]) VALUES (8, N'МЕНЕДЖМЕНТ В ПРОФЕССИОНАЛЬНОЙ ДЕЯТЕЛЬНОСТИ ')
GO
SET IDENTITY_INSERT [dbo].[Lessons] OFF
GO
SET IDENTITY_INSERT [dbo].[Load_teachers] ON 
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (1, 1, 1)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (2, 12, 1)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (3, 3, 1)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (6, 10, 2)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (7, 7, 2)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (8, 2, 2)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (9, 4, 3)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (10, 5, 3)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (11, 6, 3)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (12, 11, 4)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (14, 6, 4)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (15, 11, 5)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (16, 7, 5)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (17, 2, 5)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (18, 10, 6)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (19, 3, 6)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (21, 1, 7)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (22, 12, 7)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (25, 7, 8)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (26, 4, 8)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (27, 10, 9)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (28, 2, 9)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (29, 1, 9)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (30, 10, 10)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (31, 11, 10)
GO
INSERT [dbo].[Load_teachers] ([id_load], [id_plan], [id_teacher]) VALUES (32, 12, 10)
GO
SET IDENTITY_INSERT [dbo].[Load_teachers] OFF
GO
SET IDENTITY_INSERT [dbo].[Programm_of_lesson] ON 
GO
INSERT [dbo].[Programm_of_lesson] ([id_prog], [id_plan], [Topic_lesson], [id_type]) VALUES (1, 1, N' ', 1)
GO
INSERT [dbo].[Programm_of_lesson] ([id_prog], [id_plan], [Topic_lesson], [id_type]) VALUES (2, 2, N' ', 1)
GO
INSERT [dbo].[Programm_of_lesson] ([id_prog], [id_plan], [Topic_lesson], [id_type]) VALUES (4, 4, N' ', 1)
GO
INSERT [dbo].[Programm_of_lesson] ([id_prog], [id_plan], [Topic_lesson], [id_type]) VALUES (5, 5, N' ', 3)
GO
INSERT [dbo].[Programm_of_lesson] ([id_prog], [id_plan], [Topic_lesson], [id_type]) VALUES (7, 7, N' ', 1)
GO
INSERT [dbo].[Programm_of_lesson] ([id_prog], [id_plan], [Topic_lesson], [id_type]) VALUES (9, 10, N' ', 1)
GO
INSERT [dbo].[Programm_of_lesson] ([id_prog], [id_plan], [Topic_lesson], [id_type]) VALUES (10, 11, N' ', 2)
GO
INSERT [dbo].[Programm_of_lesson] ([id_prog], [id_plan], [Topic_lesson], [id_type]) VALUES (11, 12, N' ', 1)
GO
SET IDENTITY_INSERT [dbo].[Programm_of_lesson] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 
GO
INSERT [dbo].[Roles] ([id_role], [Name_role]) VALUES (1, N'Студент')
GO
INSERT [dbo].[Roles] ([id_role], [Name_role]) VALUES (2, N'Преподаватель')
GO
INSERT [dbo].[Roles] ([id_role], [Name_role]) VALUES (3, N'Администрация')
GO
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Specialization] ON 
GO
INSERT [dbo].[Specialization] ([id_spec], [Name_spec]) VALUES (1, N'Компьютерные системы и комплексы')
GO
INSERT [dbo].[Specialization] ([id_spec], [Name_spec]) VALUES (2, N'Информационные системы и программирование')
GO
INSERT [dbo].[Specialization] ([id_spec], [Name_spec]) VALUES (3, N'Сетевое и системное администрирование')
GO
INSERT [dbo].[Specialization] ([id_spec], [Name_spec]) VALUES (4, N'Интеллектуальные интегрированные системы')
GO
INSERT [dbo].[Specialization] ([id_spec], [Name_spec]) VALUES (5, N'Обеспечение информационной безопасности автоматизированных систем')
GO
SET IDENTITY_INSERT [dbo].[Specialization] OFF
GO
SET IDENTITY_INSERT [dbo].[Status_teacher] ON 
GO
INSERT [dbo].[Status_teacher] ([id_status], [Name_status]) VALUES (1, N'Профессор')
GO
INSERT [dbo].[Status_teacher] ([id_status], [Name_status]) VALUES (2, N'Доцент')
GO
INSERT [dbo].[Status_teacher] ([id_status], [Name_status]) VALUES (3, N'Кандидат наук')
GO
SET IDENTITY_INSERT [dbo].[Status_teacher] OFF
GO
SET IDENTITY_INSERT [dbo].[Student] ON 
GO
INSERT [dbo].[Student] ([id_student], [FIO], [Phone], [Email], [Date_Of_Birthday], [id_group]) VALUES (1, N'Аксенов Николай Артёмович', 79363368511, N'vexellofremmi-5847@yopmail.com', CAST(N'2003-01-01' AS Date), 1)
GO
INSERT [dbo].[Student] ([id_student], [FIO], [Phone], [Email], [Date_Of_Birthday], [id_group]) VALUES (2, N'Смирнова Анастасия Фёдоровна', 79011645890, N'nahoiripequou-9384@yopmail.com', CAST(N'2002-10-10' AS Date), 2)
GO
INSERT [dbo].[Student] ([id_student], [FIO], [Phone], [Email], [Date_Of_Birthday], [id_group]) VALUES (3, N'Хохлов Максим Алексеевич', 79782507505, N'dabraneddappi-1411@yopmail.com', CAST(N'2004-01-11' AS Date), 3)
GO
INSERT [dbo].[Student] ([id_student], [FIO], [Phone], [Email], [Date_Of_Birthday], [id_group]) VALUES (4, N'Лаптев Игорь Львович', 79968499231, N'laffunanniri-3079@yopmail.com', CAST(N'2003-10-20' AS Date), 4)
GO
INSERT [dbo].[Student] ([id_student], [FIO], [Phone], [Email], [Date_Of_Birthday], [id_group]) VALUES (5, N'Родионова Виктория Романовна', 77858604270, N'possafouffeudu-9778@yopmail.com', CAST(N'2002-03-30' AS Date), 5)
GO
INSERT [dbo].[Student] ([id_student], [FIO], [Phone], [Email], [Date_Of_Birthday], [id_group]) VALUES (6, N'Смирнова Агата Ильинична', 79025287384, N'tramugracroutte-7356@yopmail.com', CAST(N'2005-08-05' AS Date), 6)
GO
INSERT [dbo].[Student] ([id_student], [FIO], [Phone], [Email], [Date_Of_Birthday], [id_group]) VALUES (7, N'Князев Павел Егорович', 79585259338, N'geyavautrawo-6932@yopmail.com', CAST(N'2005-01-24' AS Date), 7)
GO
INSERT [dbo].[Student] ([id_student], [FIO], [Phone], [Email], [Date_Of_Birthday], [id_group]) VALUES (8, N'Павлов Арсений Павлович', 79940142756, N'wejoujawamoi-4734@yopmail.com', CAST(N'2003-12-30' AS Date), 8)
GO
INSERT [dbo].[Student] ([id_student], [FIO], [Phone], [Email], [Date_Of_Birthday], [id_group]) VALUES (9, N'Артамонов Даниэль Матвеевич', 79923693317, N'tifralajafau-2345@yopmail.com', CAST(N'2003-09-16' AS Date), 9)
GO
INSERT [dbo].[Student] ([id_student], [FIO], [Phone], [Email], [Date_Of_Birthday], [id_group]) VALUES (10, N'Литвинова Анна Тимофеевна', 79016483664, N'geffubugreju-6980@yopmail.com', CAST(N'2004-05-08' AS Date), 10)
GO
SET IDENTITY_INSERT [dbo].[Student] OFF
GO
SET IDENTITY_INSERT [dbo].[Study_plan] ON 
GO
INSERT [dbo].[Study_plan] ([id_plan], [id_group], [id_lesson], [Hours], [Hours_1sem], [Hours_2sem]) VALUES (1, 1, 1, 60, 25, 35)
GO
INSERT [dbo].[Study_plan] ([id_plan], [id_group], [id_lesson], [Hours], [Hours_1sem], [Hours_2sem]) VALUES (2, 1, 3, 55, 20, 25)
GO
INSERT [dbo].[Study_plan] ([id_plan], [id_group], [id_lesson], [Hours], [Hours_1sem], [Hours_2sem]) VALUES (3, 1, 5, 58, 22, 26)
GO
INSERT [dbo].[Study_plan] ([id_plan], [id_group], [id_lesson], [Hours], [Hours_1sem], [Hours_2sem]) VALUES (4, 2, 2, 70, 32, 38)
GO
INSERT [dbo].[Study_plan] ([id_plan], [id_group], [id_lesson], [Hours], [Hours_1sem], [Hours_2sem]) VALUES (5, 2, 4, 65, 30, 35)
GO
INSERT [dbo].[Study_plan] ([id_plan], [id_group], [id_lesson], [Hours], [Hours_1sem], [Hours_2sem]) VALUES (6, 2, 6, 60, 25, 35)
GO
INSERT [dbo].[Study_plan] ([id_plan], [id_group], [id_lesson], [Hours], [Hours_1sem], [Hours_2sem]) VALUES (7, 3, 7, 100, 45, 55)
GO
INSERT [dbo].[Study_plan] ([id_plan], [id_group], [id_lesson], [Hours], [Hours_1sem], [Hours_2sem]) VALUES (10, 3, 8, 70, 32, 38)
GO
INSERT [dbo].[Study_plan] ([id_plan], [id_group], [id_lesson], [Hours], [Hours_1sem], [Hours_2sem]) VALUES (11, 3, 1, 60, 25, 35)
GO
INSERT [dbo].[Study_plan] ([id_plan], [id_group], [id_lesson], [Hours], [Hours_1sem], [Hours_2sem]) VALUES (12, 4, 2, 70, 32, 38)
GO
SET IDENTITY_INSERT [dbo].[Study_plan] OFF
GO
SET IDENTITY_INSERT [dbo].[Teacher] ON 
GO
INSERT [dbo].[Teacher] ([id_teacher], [FIO], [id_status], [Date_of_Birthday], [Phone], [Email], [Work_expirience]) VALUES (1, N'Головина Анастасия Артёмовна', 1, CAST(N'1950-01-30' AS Date), 79788243788, N'geffubugreju-6980@yopmail.com', 10)
GO
INSERT [dbo].[Teacher] ([id_teacher], [FIO], [id_status], [Date_of_Birthday], [Phone], [Email], [Work_expirience]) VALUES (2, N'Овчинникова Аяна Егоровна', 1, CAST(N'1988-08-10' AS Date), 79913424187, N'hidagruddemmou-2642@yopmail.com', 1)
GO
INSERT [dbo].[Teacher] ([id_teacher], [FIO], [id_status], [Date_of_Birthday], [Phone], [Email], [Work_expirience]) VALUES (3, N'Никулин Виктор Саввич', 1, CAST(N'1990-08-28' AS Date), 79780420436, N'cocrousaddotta-7964@yopmail.com', 4)
GO
INSERT [dbo].[Teacher] ([id_teacher], [FIO], [id_status], [Date_of_Birthday], [Phone], [Email], [Work_expirience]) VALUES (4, N'Аксенов Максим Давидович', 2, CAST(N'1974-04-01' AS Date), 79024637732, N'jilleffokauli-1208@yopmail.com', 5)
GO
INSERT [dbo].[Teacher] ([id_teacher], [FIO], [id_status], [Date_of_Birthday], [Phone], [Email], [Work_expirience]) VALUES (5, N'Морозов Михаил Гордеевич', 3, CAST(N'1964-09-06' AS Date), 79047379156, N'pogoulleddixe-5640@yopmail.com', 8)
GO
INSERT [dbo].[Teacher] ([id_teacher], [FIO], [id_status], [Date_of_Birthday], [Phone], [Email], [Work_expirience]) VALUES (6, N'Усова Виктория Матвеевна', 1, CAST(N'1995-12-17' AS Date), 79580515041, N'lounabavassa-3977@yopmail.com', 1)
GO
INSERT [dbo].[Teacher] ([id_teacher], [FIO], [id_status], [Date_of_Birthday], [Phone], [Email], [Work_expirience]) VALUES (7, N'Кириллова Ирина Леонидовна', 2, CAST(N'1993-10-10' AS Date), 77103856061, N'niquauffebreza-3533@yopmail.com', 5)
GO
INSERT [dbo].[Teacher] ([id_teacher], [FIO], [id_status], [Date_of_Birthday], [Phone], [Email], [Work_expirience]) VALUES (8, N'Матвеева Ева Артёмовна', 1, CAST(N'1989-11-05' AS Date), 74732039975, N'wejixallanne-6094@yopmail.com', 7)
GO
INSERT [dbo].[Teacher] ([id_teacher], [FIO], [id_status], [Date_of_Birthday], [Phone], [Email], [Work_expirience]) VALUES (9, N'Герасимов Григорий Михайлович', 3, CAST(N'1972-04-21' AS Date), 73886544583, N'hatulasseutro-6310@yopmail.com', 13)
GO
INSERT [dbo].[Teacher] ([id_teacher], [FIO], [id_status], [Date_of_Birthday], [Phone], [Email], [Work_expirience]) VALUES (10, N'Кочергин Иван Олегович', 1, CAST(N'1998-08-05' AS Date), 77232976611, N'haudaunnetita-5137@yopmail.com', 2)
GO
SET IDENTITY_INSERT [dbo].[Teacher] OFF
GO
SET IDENTITY_INSERT [dbo].[Type_of_lesson] ON 
GO
INSERT [dbo].[Type_of_lesson] ([id_type], [Name_type]) VALUES (1, N'Лабораторная работа')
GO
INSERT [dbo].[Type_of_lesson] ([id_type], [Name_type]) VALUES (2, N'Лекция')
GO
INSERT [dbo].[Type_of_lesson] ([id_type], [Name_type]) VALUES (3, N'Экзамен')
GO
SET IDENTITY_INSERT [dbo].[Type_of_lesson] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([id_user], [FirstName], [LastName], [Patronymic], [Email], [id_role], [Login], [Password], [Passwordik]) VALUES (1, N'Петров', N'Филипп', N'Борисович', N'pfb@gmail.com', 1, N'PH', N'Ph13!     ', N'238e7fe64de0b0a921f72d57f6c14bcbd3f71dcdc22eb23767321300e0aeb8bda159dad8d5b3fab4300ad51743eb7bf125b4dd792436556a353f80a1340e3aba')
GO
INSERT [dbo].[Users] ([id_user], [FirstName], [LastName], [Patronymic], [Email], [id_role], [Login], [Password], [Passwordik]) VALUES (2, N'Иванов', N'Александр', N'Кириллович', N'iak@ya.ru', 2, N'AK', N'Iak2@     ', N'0ae1f838ccfd2bdb433923825165cc35204343b68d23d73821fe7de246ea0f3e34c618564bf468e4715b4cd23f8551fcdb3a5fc588e282bb65d16919e19569f8')
GO
INSERT [dbo].[Users] ([id_user], [FirstName], [LastName], [Patronymic], [Email], [id_role], [Login], [Password], [Passwordik]) VALUES (3, N'Колесников', N'Евгений', N'Григорьевич', N'keg@mail.com', 3, N'KEG', N'Kk123#    ', N'88b4b0129a650242e93cff2bb7d819f2e94c5a3318bafee3755602c3c6d449a1a4f2117f32eed681f6a501b8978cf206d1b0ac168847b974ba9bb8029c943e6e')
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Group]  WITH CHECK ADD  CONSTRAINT [FK_Group_Specialization] FOREIGN KEY([id_spec])
REFERENCES [dbo].[Specialization] ([id_spec])
GO
ALTER TABLE [dbo].[Group] CHECK CONSTRAINT [FK_Group_Specialization]
GO
ALTER TABLE [dbo].[Load_teachers]  WITH CHECK ADD  CONSTRAINT [FK_Load_teachers_Study_plan] FOREIGN KEY([id_plan])
REFERENCES [dbo].[Study_plan] ([id_plan])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Load_teachers] CHECK CONSTRAINT [FK_Load_teachers_Study_plan]
GO
ALTER TABLE [dbo].[Load_teachers]  WITH CHECK ADD  CONSTRAINT [FK_Load_teachers_Teacher] FOREIGN KEY([id_teacher])
REFERENCES [dbo].[Teacher] ([id_teacher])
GO
ALTER TABLE [dbo].[Load_teachers] CHECK CONSTRAINT [FK_Load_teachers_Teacher]
GO
ALTER TABLE [dbo].[Programm_of_lesson]  WITH CHECK ADD  CONSTRAINT [FK_Programm_of_lesson_Study_plan] FOREIGN KEY([id_plan])
REFERENCES [dbo].[Study_plan] ([id_plan])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Programm_of_lesson] CHECK CONSTRAINT [FK_Programm_of_lesson_Study_plan]
GO
ALTER TABLE [dbo].[Programm_of_lesson]  WITH CHECK ADD  CONSTRAINT [FK_Programm_of_lesson_Type_of_lesson] FOREIGN KEY([id_type])
REFERENCES [dbo].[Type_of_lesson] ([id_type])
GO
ALTER TABLE [dbo].[Programm_of_lesson] CHECK CONSTRAINT [FK_Programm_of_lesson_Type_of_lesson]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Group] FOREIGN KEY([id_group])
REFERENCES [dbo].[Group] ([id_group])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Group]
GO
ALTER TABLE [dbo].[Study_plan]  WITH CHECK ADD  CONSTRAINT [FK_Study_plan_Group] FOREIGN KEY([id_group])
REFERENCES [dbo].[Group] ([id_group])
GO
ALTER TABLE [dbo].[Study_plan] CHECK CONSTRAINT [FK_Study_plan_Group]
GO
ALTER TABLE [dbo].[Study_plan]  WITH CHECK ADD  CONSTRAINT [FK_Study_plan_Lessons] FOREIGN KEY([id_lesson])
REFERENCES [dbo].[Lessons] ([id_lesson])
GO
ALTER TABLE [dbo].[Study_plan] CHECK CONSTRAINT [FK_Study_plan_Lessons]
GO
ALTER TABLE [dbo].[Teacher]  WITH CHECK ADD  CONSTRAINT [FK_Teacher_Status_teacher] FOREIGN KEY([id_status])
REFERENCES [dbo].[Status_teacher] ([id_status])
GO
ALTER TABLE [dbo].[Teacher] CHECK CONSTRAINT [FK_Teacher_Status_teacher]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([id_role])
REFERENCES [dbo].[Roles] ([id_role])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
USE [master]
GO
ALTER DATABASE [VUZ] SET  READ_WRITE 
GO
