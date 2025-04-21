/****** Object:  Database [TRANSPORT]    Script Date: 22.04.2025 1:42:31 ******/
CREATE DATABASE [TRANSPORT]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TRANSPORT', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER1\MSSQL\DATA\TRANSPORT.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TRANSPORT_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER1\MSSQL\DATA\TRANSPORT_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TRANSPORT] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TRANSPORT].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TRANSPORT] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TRANSPORT] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TRANSPORT] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TRANSPORT] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TRANSPORT] SET ARITHABORT OFF 
GO
ALTER DATABASE [TRANSPORT] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [TRANSPORT] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TRANSPORT] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TRANSPORT] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TRANSPORT] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TRANSPORT] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TRANSPORT] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TRANSPORT] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TRANSPORT] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TRANSPORT] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TRANSPORT] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TRANSPORT] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TRANSPORT] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TRANSPORT] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TRANSPORT] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TRANSPORT] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TRANSPORT] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TRANSPORT] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TRANSPORT] SET  MULTI_USER 
GO
ALTER DATABASE [TRANSPORT] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TRANSPORT] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TRANSPORT] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TRANSPORT] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TRANSPORT] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TRANSPORT] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TRANSPORT] SET QUERY_STORE = OFF
GO
/****** Object:  User [Denis]    Script Date: 22.04.2025 1:42:32 ******/
CREATE USER [Denis] FOR LOGIN [Denis] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [@user]    Script Date: 22.04.2025 1:42:32 ******/
CREATE USER [@user] FOR LOGIN [@log] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [super_admin]    Script Date: 22.04.2025 1:42:32 ******/
CREATE ROLE [super_admin]
GO
/****** Object:  DatabaseRole [operator_4]    Script Date: 22.04.2025 1:42:32 ******/
CREATE ROLE [operator_4]
GO
/****** Object:  DatabaseRole [operator_3]    Script Date: 22.04.2025 1:42:32 ******/
CREATE ROLE [operator_3]
GO
/****** Object:  DatabaseRole [operator_2]    Script Date: 22.04.2025 1:42:32 ******/
CREATE ROLE [operator_2]
GO
/****** Object:  DatabaseRole [operator_1]    Script Date: 22.04.2025 1:42:32 ******/
CREATE ROLE [operator_1]
GO
/****** Object:  DatabaseRole [admin_4]    Script Date: 22.04.2025 1:42:32 ******/
CREATE ROLE [admin_4]
GO
/****** Object:  DatabaseRole [admin_3]    Script Date: 22.04.2025 1:42:32 ******/
CREATE ROLE [admin_3]
GO
/****** Object:  DatabaseRole [admin_2]    Script Date: 22.04.2025 1:42:32 ******/
CREATE ROLE [admin_2]
GO
/****** Object:  DatabaseRole [admin_1]    Script Date: 22.04.2025 1:42:32 ******/
CREATE ROLE [admin_1]
GO
/****** Object:  DatabaseRole [@group]    Script Date: 22.04.2025 1:42:32 ******/
CREATE ROLE [@group]
GO
ALTER ROLE [operator_1] ADD MEMBER [Denis]
GO
ALTER ROLE [operator_2] ADD MEMBER [Denis]
GO
ALTER ROLE [operator_3] ADD MEMBER [Denis]
GO
ALTER ROLE [operator_4] ADD MEMBER [Denis]
GO
ALTER ROLE [super_admin] ADD MEMBER [Denis]
GO
ALTER ROLE [admin_1] ADD MEMBER [Denis]
GO
ALTER ROLE [admin_2] ADD MEMBER [Denis]
GO
ALTER ROLE [admin_3] ADD MEMBER [Denis]
GO
ALTER ROLE [admin_4] ADD MEMBER [Denis]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [Denis]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [super_admin]
GO
/****** Object:  Table [dbo].[Marshrut]    Script Date: 22.04.2025 1:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Marshrut](
	[Id_Marsh] [int] IDENTITY(1,1) NOT NULL,
	[Id_GR] [int] NULL,
	[Id_Tr] [int] NULL,
	[Nomer_Mars] [int] NULL,
	[Nach_Sled] [varchar](100) NULL,
	[Kon_Sled] [varchar](100) NULL,
	[Time_Sled] [time](0) NULL,
	[Id_Perevoz] [int] NULL,
	[Day_Sled] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Marsh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[op_1]    Script Date: 22.04.2025 1:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[op_1]
as
select [Nomer_Mars],[Nach_Sled],[Kon_Sled],[Time_Sled]
from [dbo].[Marshrut]
where [Id_Perevoz]=1
GO
/****** Object:  View [dbo].[op_2]    Script Date: 22.04.2025 1:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[op_2]
as
select [Nomer_Mars],[Nach_Sled],[Kon_Sled],[Time_Sled]
from [dbo].[Marshrut]
where [Id_Perevoz]=2
GO
/****** Object:  View [dbo].[op_3]    Script Date: 22.04.2025 1:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[op_3]
as
select [Nomer_Mars],[Nach_Sled],[Kon_Sled],[Time_Sled]
from [dbo].[Marshrut]
where [Id_Perevoz]=3
GO
/****** Object:  View [dbo].[op_4]    Script Date: 22.04.2025 1:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[op_4]
as
select [Nomer_Mars],[Nach_Sled],[Kon_Sled],[Time_Sled]
from [dbo].[Marshrut]
where [Id_Perevoz]=4
GO
/****** Object:  Table [dbo].[Sotrudniki]    Script Date: 22.04.2025 1:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sotrudniki](
	[Id_Sotr] [int] IDENTITY(1,1) NOT NULL,
	[Id_Perevoz] [int] NULL,
	[Vid_Sotr] [varchar](50) NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Oklad] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Sotr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ad_1]    Script Date: 22.04.2025 1:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ad_1]
as
select [Vid_Sotr],[FirstName],[LastName],[Oklad]
from [dbo].[Sotrudniki]
where [Id_Perevoz]=1
GO
/****** Object:  View [dbo].[ad_2]    Script Date: 22.04.2025 1:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ad_2]
as
select [Vid_Sotr],[FirstName],[LastName],[Oklad]
from [dbo].[Sotrudniki]
where [Id_Perevoz]=2
GO
/****** Object:  View [dbo].[ad_3]    Script Date: 22.04.2025 1:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ad_3]
as
select [Vid_Sotr],[FirstName],[LastName],[Oklad]
from [dbo].[Sotrudniki]
where [Id_Perevoz]=3
GO
/****** Object:  View [dbo].[ad_4]    Script Date: 22.04.2025 1:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ad_4]
as
select [Vid_Sotr],[FirstName],[LastName],[Oklad]
from [dbo].[Sotrudniki]
where [Id_Perevoz]=4
GO
/****** Object:  Table [dbo].[Graphic]    Script Date: 22.04.2025 1:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Graphic](
	[Id_Graph] [int] NOT NULL,
	[Id_Ost] [int] NULL,
	[Day_Week] [varchar](60) NULL,
	[Time_Graph] [time](0) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Graph] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Graphic_Rabotnikov]    Script Date: 22.04.2025 1:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Graphic_Rabotnikov](
	[Id_GR] [int] IDENTITY(1,1) NOT NULL,
	[Id_Sotr] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_GR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Izmen]    Script Date: 22.04.2025 1:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Izmen](
	[Id_Izm] [int] IDENTITY(1,1) NOT NULL,
	[Day_Izm] [date] NULL,
	[Time_Rasp] [time](0) NULL,
	[Time_Izm] [time](0) NULL,
	[Prichina] [varchar](50) NULL,
	[Id_Graph] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Izm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ost_Po_Puti]    Script Date: 22.04.2025 1:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ost_Po_Puti](
	[Id_Ost] [int] NOT NULL,
	[Id_Marsh] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Ost] ASC,
	[Id_Marsh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ostanovki]    Script Date: 22.04.2025 1:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ostanovki](
	[Id_Ost] [int] IDENTITY(1,1) NOT NULL,
	[Nazv_Ost] [varchar](100) NULL,
	[Mesto_ost] [varchar](100) NULL,
	[Pav] [varchar](10) NULL,
	[Id_Vid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Ost] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Perevozchik]    Script Date: 22.04.2025 1:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perevozchik](
	[Id_Perevoz] [int] IDENTITY(1,1) NOT NULL,
	[Name_perevoz] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Perevoz] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tab_Izmen]    Script Date: 22.04.2025 1:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tab_Izmen](
	[Time_Graph] [time](0) NULL,
	[Day_Izm] [date] NULL,
	[Time_Rasp] [time](0) NULL,
	[Time_Izm] [time](0) NULL,
	[Prichina] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transport]    Script Date: 22.04.2025 1:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transport](
	[Id_Tr] [int] IDENTITY(1,1) NOT NULL,
	[Id_Vid] [int] NULL,
	[Num_Tr] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Tr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vid_Transporta]    Script Date: 22.04.2025 1:42:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vid_Transporta](
	[Id_Vid] [int] IDENTITY(1,1) NOT NULL,
	[Vid] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Vid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (1, 1, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (2, 1, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (3, 1, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (4, 2, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (5, 2, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (6, 2, N'Будние дни', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (7, 3, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (8, 3, N'Будние дни', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (9, 3, N'Будние дни', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (10, 4, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (11, 4, N'Будние дни', CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (12, 4, N'Выходные дни', CAST(N'11:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (13, 5, N'Ежедневно', CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (14, 5, N'Будние дни', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (15, 5, N'Будние дни', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (16, 6, N'Будние дни', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (17, 6, N'Будние дни', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (18, 6, N'Будние дни', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (19, 7, N'Ежедневно', CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (20, 7, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (21, 7, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (22, 8, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (23, 8, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (24, 8, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (25, 9, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (26, 9, N'Ежедневно', CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (27, 9, N'Ежедневно', CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (28, 10, N'Ежедневно', CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (29, 10, N'Ежедневно', CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (30, 10, N'Ежедневно', CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (31, 11, N'Ежедневно', CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (32, 11, N'Ежедневно', CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (33, 11, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (34, 12, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (35, 12, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (36, 12, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (37, 13, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (38, 13, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (39, 13, N'Выходные дни', CAST(N'11:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (40, 14, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (41, 14, N'Будние дни', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (42, 14, N'Будние дни', CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (43, 15, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (44, 15, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (45, 15, N'Ежедневно', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (46, 16, N'Будние дни', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (47, 16, N'Будние дни', CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (48, 16, N'Выходные дни', CAST(N'11:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (49, 17, N'Будние дни', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (50, 17, N'Будние дни', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (51, 17, N'Будние дни', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (52, 18, N'Будние дни', CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (53, 18, N'Будние дни', CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (54, 18, N'Будние дни', CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (55, 19, N'Будние дни', CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (56, 19, N'Будние дни', CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (57, 19, N'Выходные дни', CAST(N'11:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (58, 20, N'Будние дни', CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (59, 20, N'Будние дни', CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (60, 20, N'Выходные дни', CAST(N'11:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (61, 21, N'Будние дни', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (62, 21, N'Будние дни', CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Graphic] ([Id_Graph], [Id_Ost], [Day_Week], [Time_Graph]) VALUES (63, 21, N'Выходные дни', CAST(N'11:00:00' AS Time))
GO
SET IDENTITY_INSERT [dbo].[Graphic_Rabotnikov] ON 
GO
INSERT [dbo].[Graphic_Rabotnikov] ([Id_GR], [Id_Sotr]) VALUES (1, 1)
GO
INSERT [dbo].[Graphic_Rabotnikov] ([Id_GR], [Id_Sotr]) VALUES (2, 2)
GO
INSERT [dbo].[Graphic_Rabotnikov] ([Id_GR], [Id_Sotr]) VALUES (3, 3)
GO
INSERT [dbo].[Graphic_Rabotnikov] ([Id_GR], [Id_Sotr]) VALUES (4, 4)
GO
INSERT [dbo].[Graphic_Rabotnikov] ([Id_GR], [Id_Sotr]) VALUES (5, 5)
GO
INSERT [dbo].[Graphic_Rabotnikov] ([Id_GR], [Id_Sotr]) VALUES (6, 6)
GO
INSERT [dbo].[Graphic_Rabotnikov] ([Id_GR], [Id_Sotr]) VALUES (7, 7)
GO
INSERT [dbo].[Graphic_Rabotnikov] ([Id_GR], [Id_Sotr]) VALUES (8, 8)
GO
INSERT [dbo].[Graphic_Rabotnikov] ([Id_GR], [Id_Sotr]) VALUES (9, 9)
GO
INSERT [dbo].[Graphic_Rabotnikov] ([Id_GR], [Id_Sotr]) VALUES (10, 10)
GO
INSERT [dbo].[Graphic_Rabotnikov] ([Id_GR], [Id_Sotr]) VALUES (11, 11)
GO
INSERT [dbo].[Graphic_Rabotnikov] ([Id_GR], [Id_Sotr]) VALUES (12, 12)
GO
SET IDENTITY_INSERT [dbo].[Graphic_Rabotnikov] OFF
GO
SET IDENTITY_INSERT [dbo].[Izmen] ON 
GO
INSERT [dbo].[Izmen] ([Id_Izm], [Day_Izm], [Time_Rasp], [Time_Izm], [Prichina], [Id_Graph]) VALUES (3, CAST(N'2022-11-18' AS Date), CAST(N'08:30:00' AS Time), CAST(N'09:00:00' AS Time), N'ТО Автомобиля', 58)
GO
INSERT [dbo].[Izmen] ([Id_Izm], [Day_Izm], [Time_Rasp], [Time_Izm], [Prichina], [Id_Graph]) VALUES (4, CAST(N'2022-11-18' AS Date), CAST(N'08:30:00' AS Time), CAST(N'10:00:00' AS Time), N'ТО Автомобиля', 27)
GO
INSERT [dbo].[Izmen] ([Id_Izm], [Day_Izm], [Time_Rasp], [Time_Izm], [Prichina], [Id_Graph]) VALUES (5, CAST(N'2022-11-19' AS Date), CAST(N'11:00:00' AS Time), CAST(N'11:30:00' AS Time), N'ТО Автомобиля', 39)
GO
SET IDENTITY_INSERT [dbo].[Izmen] OFF
GO
SET IDENTITY_INSERT [dbo].[Marshrut] ON 
GO
INSERT [dbo].[Marshrut] ([Id_Marsh], [Id_GR], [Id_Tr], [Nomer_Mars], [Nach_Sled], [Kon_Sled], [Time_Sled], [Id_Perevoz], [Day_Sled]) VALUES (1, 1, 1, 1, N'Лиговский пр., 1, Санкт-Петербург, 191471', N'Кременчугская ул., 3 к1, Санкт-Петербург, 191276', CAST(N'15:30:00' AS Time), 1, CAST(N'2022-11-19' AS Date))
GO
INSERT [dbo].[Marshrut] ([Id_Marsh], [Id_GR], [Id_Tr], [Nomer_Mars], [Nach_Sled], [Kon_Sled], [Time_Sled], [Id_Perevoz], [Day_Sled]) VALUES (2, 2, 1, 107, N'8-я Советская ул., 31, Санкт-Петербург, 191506', N'Кременчугская ул., 3 к1, Санкт-Петербург, 191276', CAST(N'14:00:00' AS Time), 2, CAST(N'2022-11-19' AS Date))
GO
INSERT [dbo].[Marshrut] ([Id_Marsh], [Id_GR], [Id_Tr], [Nomer_Mars], [Nach_Sled], [Kon_Sled], [Time_Sled], [Id_Perevoz], [Day_Sled]) VALUES (3, 3, 1, 33, N'Лиговский пр., 1, Санкт-Петербург, 191471', N'Кременчугская ул., 3 к1, Санкт-Петербург, 191276', CAST(N'15:30:00' AS Time), 3, CAST(N'2022-11-19' AS Date))
GO
INSERT [dbo].[Marshrut] ([Id_Marsh], [Id_GR], [Id_Tr], [Nomer_Mars], [Nach_Sled], [Kon_Sled], [Time_Sled], [Id_Perevoz], [Day_Sled]) VALUES (4, 4, 2, 188, N'ул. Печатника Григорьева, д.97, Санкт-Петербург, 191738', N'Боровая ул., 57, Санкт-Петербург, 19178', CAST(N'14:00:00' AS Time), 4, CAST(N'2022-11-19' AS Date))
GO
INSERT [dbo].[Marshrut] ([Id_Marsh], [Id_GR], [Id_Tr], [Nomer_Mars], [Nach_Sled], [Kon_Sled], [Time_Sled], [Id_Perevoz], [Day_Sled]) VALUES (5, 5, 2, 16, N'ул. Печатника Григорьева, д.97, Санкт-Петербург, 191738', N'Лиговский пр., 1, Санкт-Петербург, 191471', CAST(N'08:50:00' AS Time), 1, CAST(N'2022-11-19' AS Date))
GO
INSERT [dbo].[Marshrut] ([Id_Marsh], [Id_GR], [Id_Tr], [Nomer_Mars], [Nach_Sled], [Kon_Sled], [Time_Sled], [Id_Perevoz], [Day_Sled]) VALUES (6, 6, 2, 38, N'Кременчугская ул., 3 к1, Санкт-Петербург, 191276', N'Боровая ул., 57, Санкт-Петербург, 19178', CAST(N'08:50:00' AS Time), 2, CAST(N'2022-11-19' AS Date))
GO
INSERT [dbo].[Marshrut] ([Id_Marsh], [Id_GR], [Id_Tr], [Nomer_Mars], [Nach_Sled], [Kon_Sled], [Time_Sled], [Id_Perevoz], [Day_Sled]) VALUES (7, 7, 3, 8, N'Кременчугская ул., 3 к1, Санкт-Петербург, 191276', N'Лиговский пр., 1, Санкт-Петербург, 191471', CAST(N'14:00:00' AS Time), 3, CAST(N'2022-11-19' AS Date))
GO
INSERT [dbo].[Marshrut] ([Id_Marsh], [Id_GR], [Id_Tr], [Nomer_Mars], [Nach_Sled], [Kon_Sled], [Time_Sled], [Id_Perevoz], [Day_Sled]) VALUES (8, 8, 3, 50, N'8-я Советская ул., 31, Санкт-Петербург, 191506', N'ул. Печатника Григорьева, д.97, Санкт-Петербург, 191738', CAST(N'08:50:00' AS Time), 4, CAST(N'2022-11-19' AS Date))
GO
INSERT [dbo].[Marshrut] ([Id_Marsh], [Id_GR], [Id_Tr], [Nomer_Mars], [Nach_Sled], [Kon_Sled], [Time_Sled], [Id_Perevoz], [Day_Sled]) VALUES (9, 9, 4, 36, N'Кременчугская ул., 3 к1, Санкт-Петербург, 191276', N'Боровая ул., 57, Санкт-Петербург, 19178', CAST(N'09:00:00' AS Time), 1, CAST(N'2022-11-19' AS Date))
GO
INSERT [dbo].[Marshrut] ([Id_Marsh], [Id_GR], [Id_Tr], [Nomer_Mars], [Nach_Sled], [Kon_Sled], [Time_Sled], [Id_Perevoz], [Day_Sled]) VALUES (10, 10, 4, 44, N'Миргородская ул., 41, Санкт-Петербург, 191516', N'8-я Советская ул., 31, Санкт-Петербург, 191506', CAST(N'14:00:00' AS Time), 2, CAST(N'2022-11-19' AS Date))
GO
INSERT [dbo].[Marshrut] ([Id_Marsh], [Id_GR], [Id_Tr], [Nomer_Mars], [Nach_Sled], [Kon_Sled], [Time_Sled], [Id_Perevoz], [Day_Sled]) VALUES (11, 11, 5, 4, N'Кременчугская ул., 3 к1, Санкт-Петербург, 191276', N'ул. Печатника Григорьева, д.97, Санкт-Петербург, 191738', CAST(N'15:30:00' AS Time), 3, CAST(N'2022-11-19' AS Date))
GO
INSERT [dbo].[Marshrut] ([Id_Marsh], [Id_GR], [Id_Tr], [Nomer_Mars], [Nach_Sled], [Kon_Sled], [Time_Sled], [Id_Perevoz], [Day_Sled]) VALUES (12, 12, 5, 5, N'ул. Печатника Григорьева, д.97, Санкт-Петербург, 191738', N'Боровая ул., 57, Санкт-Петербург, 19178', CAST(N'15:30:00' AS Time), 4, CAST(N'2022-11-19' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Marshrut] OFF
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (1, 1)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (1, 8)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (1, 10)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (2, 2)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (2, 11)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (3, 3)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (3, 12)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (4, 1)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (4, 4)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (5, 2)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (5, 5)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (6, 3)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (6, 6)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (7, 4)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (7, 7)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (8, 5)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (8, 8)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (9, 6)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (9, 9)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (10, 1)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (10, 7)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (10, 10)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (11, 8)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (11, 11)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (12, 9)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (12, 12)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (13, 1)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (13, 10)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (14, 2)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (14, 11)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (15, 3)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (15, 12)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (16, 4)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (17, 5)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (18, 6)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (19, 7)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (20, 8)
GO
INSERT [dbo].[Ost_Po_Puti] ([Id_Ost], [Id_Marsh]) VALUES (21, 9)
GO
SET IDENTITY_INSERT [dbo].[Ostanovki] ON 
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (1, N'Лиговский пр., 1, Санкт-Петербург, 191471', N'дорога', N'есть', 2)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (2, N'Кирочная ул., 34, Санкт-Петербург, 191140', N'дорога', N'есть', 3)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (3, N'Боровая ул., 57, Санкт-Петербург, 19178', N'дорога', N'есть', 2)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (4, N'Лиговский пр., 18, Санкт-Петербург, 19116', N'дорога', N'нету', 4)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (5, N'Новгородская ул., 79, Санкт-Петербург, 191127', N'Торговый центр', N'есть', 5)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (6, N'Лиговский пр., 42, Санкт-Петербург, 191731', N'Торговый центр', N'нету', 3)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (7, N'8-я Советская ул., 31, Санкт-Петербург, 191506', N'Торговый центр', N'нету', 2)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (8, N'Старорусская ул., 52, Санкт-Петербург, 191474', N'Торговый центр', N'есть', 4)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (9, N'ул. Марата, 45, Санкт-Петербург, 191621', N'дорога', N'есть', 3)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (10, N'Миргородская ул., 74, Санкт-Петербург, 191577', N'Торговый центр', N'нету', 2)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (11, N'Миргородская ул., 87, Санкт-Петербург, 191186', N'дорога', N'есть', 2)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (12, N'Кременчугская ул., 23 к1, Санкт-Петербург, 191745', N'Торговый центр', N'нету', 3)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (13, N'Лиговский пр., 38, Санкт-Петербург, 191160', N'дорога', N'нету', 5)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (14, N'ул. Печатника Григорьева, д.97, Санкт-Петербург, 191738', N'метро', N'есть', 1)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (15, N'Старорусская ул., 81, Санкт-Петербург, 191157', N'метро', N'есть', 1)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (16, N'набережная реки Фонтанки, 51, Санкт-Петербург, 191314', N'метро', N'есть', 5)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (17, N'Миргородская ул., 61, Санкт-Петербург, 191472', N'дорога', N'есть', 3)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (18, N'Новгородская ул., 86, Санкт-Петербург, 19119', N'дорога', N'нету', 4)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (19, N'Лиговский пр., 21, Санкт-Петербург, 191564', N'Торговый центр', N'нету', 4)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (20, N'Миргородская ул., 41, Санкт-Петербург, 191516', N'метро', N'нету', 1)
GO
INSERT [dbo].[Ostanovki] ([Id_Ost], [Nazv_Ost], [Mesto_ost], [Pav], [Id_Vid]) VALUES (21, N'Кременчугская ул., 3 к1, Санкт-Петербург, 191276', N'дорога', N'есть', 2)
GO
SET IDENTITY_INSERT [dbo].[Ostanovki] OFF
GO
SET IDENTITY_INSERT [dbo].[Perevozchik] ON 
GO
INSERT [dbo].[Perevozchik] ([Id_Perevoz], [Name_perevoz]) VALUES (1, N'Пассажиравтотранс')
GO
INSERT [dbo].[Perevozchik] ([Id_Perevoz], [Name_perevoz]) VALUES (2, N'Вест-Сервис')
GO
INSERT [dbo].[Perevozchik] ([Id_Perevoz], [Name_perevoz]) VALUES (3, N'Горэлектротранс')
GO
INSERT [dbo].[Perevozchik] ([Id_Perevoz], [Name_perevoz]) VALUES (4, N'Транспортная концессионная компания')
GO
SET IDENTITY_INSERT [dbo].[Perevozchik] OFF
GO
SET IDENTITY_INSERT [dbo].[Sotrudniki] ON 
GO
INSERT [dbo].[Sotrudniki] ([Id_Sotr], [Id_Perevoz], [Vid_Sotr], [FirstName], [LastName], [Oklad]) VALUES (1, 1, N'Водитель', N'Ермолаев', N'Лука', 82000)
GO
INSERT [dbo].[Sotrudniki] ([Id_Sotr], [Id_Perevoz], [Vid_Sotr], [FirstName], [LastName], [Oklad]) VALUES (2, 2, N'Кондуктор', N'Емельянов', N'Артемий', 35000)
GO
INSERT [dbo].[Sotrudniki] ([Id_Sotr], [Id_Perevoz], [Vid_Sotr], [FirstName], [LastName], [Oklad]) VALUES (3, 3, N'Водитель', N'Лукьянов', N'Марк', 65000)
GO
INSERT [dbo].[Sotrudniki] ([Id_Sotr], [Id_Perevoz], [Vid_Sotr], [FirstName], [LastName], [Oklad]) VALUES (4, 4, N'Кондуктор', N'Румянцев', N'Дмитрий', 34000)
GO
INSERT [dbo].[Sotrudniki] ([Id_Sotr], [Id_Perevoz], [Vid_Sotr], [FirstName], [LastName], [Oklad]) VALUES (5, 2, N'Кондуктор', N'Суслова', N'Алиса', 30000)
GO
INSERT [dbo].[Sotrudniki] ([Id_Sotr], [Id_Perevoz], [Vid_Sotr], [FirstName], [LastName], [Oklad]) VALUES (6, 2, N'Водитель', N'Смирнов', N'Иван', 70000)
GO
INSERT [dbo].[Sotrudniki] ([Id_Sotr], [Id_Perevoz], [Vid_Sotr], [FirstName], [LastName], [Oklad]) VALUES (7, 1, N'Кондуктор', N'Ермолаева', N'Виктория', 32000)
GO
INSERT [dbo].[Sotrudniki] ([Id_Sotr], [Id_Perevoz], [Vid_Sotr], [FirstName], [LastName], [Oklad]) VALUES (8, 3, N'Кондуктор', N'Митрофанова', N'Мария', 30000)
GO
INSERT [dbo].[Sotrudniki] ([Id_Sotr], [Id_Perevoz], [Vid_Sotr], [FirstName], [LastName], [Oklad]) VALUES (9, 3, N'Кондуктор', N'Исаев', N'Артемий', 33000)
GO
INSERT [dbo].[Sotrudniki] ([Id_Sotr], [Id_Perevoz], [Vid_Sotr], [FirstName], [LastName], [Oklad]) VALUES (10, 4, N'Кондуктор', N'Зуева', N'Дарья', 29000)
GO
INSERT [dbo].[Sotrudniki] ([Id_Sotr], [Id_Perevoz], [Vid_Sotr], [FirstName], [LastName], [Oklad]) VALUES (11, 4, N'Водитель', N'Тихонов', N'Роман', 75000)
GO
INSERT [dbo].[Sotrudniki] ([Id_Sotr], [Id_Perevoz], [Vid_Sotr], [FirstName], [LastName], [Oklad]) VALUES (12, 1, N'Кондуктор', N'Лапин', N'Дмитрий', 36000)
GO
SET IDENTITY_INSERT [dbo].[Sotrudniki] OFF
GO
INSERT [dbo].[Tab_Izmen] ([Time_Graph], [Day_Izm], [Time_Rasp], [Time_Izm], [Prichina]) VALUES (CAST(N'08:30:00' AS Time), CAST(N'2022-11-18' AS Date), CAST(N'08:30:00' AS Time), CAST(N'09:00:00' AS Time), N'ТО Автомобиля')
GO
INSERT [dbo].[Tab_Izmen] ([Time_Graph], [Day_Izm], [Time_Rasp], [Time_Izm], [Prichina]) VALUES (CAST(N'08:30:00' AS Time), CAST(N'2022-11-18' AS Date), CAST(N'08:30:00' AS Time), CAST(N'10:00:00' AS Time), N'ТО Автомобиля')
GO
INSERT [dbo].[Tab_Izmen] ([Time_Graph], [Day_Izm], [Time_Rasp], [Time_Izm], [Prichina]) VALUES (CAST(N'11:00:00' AS Time), CAST(N'2022-11-19' AS Date), CAST(N'11:00:00' AS Time), CAST(N'11:30:00' AS Time), N'ТО Автомобиля')
GO
SET IDENTITY_INSERT [dbo].[Transport] ON 
GO
INSERT [dbo].[Transport] ([Id_Tr], [Id_Vid], [Num_Tr]) VALUES (1, 1, 1)
GO
INSERT [dbo].[Transport] ([Id_Tr], [Id_Vid], [Num_Tr]) VALUES (2, 2, 107)
GO
INSERT [dbo].[Transport] ([Id_Tr], [Id_Vid], [Num_Tr]) VALUES (3, 2, 33)
GO
INSERT [dbo].[Transport] ([Id_Tr], [Id_Vid], [Num_Tr]) VALUES (4, 2, 188)
GO
INSERT [dbo].[Transport] ([Id_Tr], [Id_Vid], [Num_Tr]) VALUES (5, 3, 38)
GO
INSERT [dbo].[Transport] ([Id_Tr], [Id_Vid], [Num_Tr]) VALUES (6, 3, 16)
GO
INSERT [dbo].[Transport] ([Id_Tr], [Id_Vid], [Num_Tr]) VALUES (7, 3, 8)
GO
INSERT [dbo].[Transport] ([Id_Tr], [Id_Vid], [Num_Tr]) VALUES (8, 4, 50)
GO
INSERT [dbo].[Transport] ([Id_Tr], [Id_Vid], [Num_Tr]) VALUES (9, 4, 36)
GO
INSERT [dbo].[Transport] ([Id_Tr], [Id_Vid], [Num_Tr]) VALUES (10, 4, 44)
GO
INSERT [dbo].[Transport] ([Id_Tr], [Id_Vid], [Num_Tr]) VALUES (11, 5, 1)
GO
INSERT [dbo].[Transport] ([Id_Tr], [Id_Vid], [Num_Tr]) VALUES (12, 5, 4)
GO
INSERT [dbo].[Transport] ([Id_Tr], [Id_Vid], [Num_Tr]) VALUES (13, 5, 5)
GO
SET IDENTITY_INSERT [dbo].[Transport] OFF
GO
SET IDENTITY_INSERT [dbo].[Vid_Transporta] ON 
GO
INSERT [dbo].[Vid_Transporta] ([Id_Vid], [Vid]) VALUES (1, N'Электропоезд')
GO
INSERT [dbo].[Vid_Transporta] ([Id_Vid], [Vid]) VALUES (2, N'Автобус')
GO
INSERT [dbo].[Vid_Transporta] ([Id_Vid], [Vid]) VALUES (3, N'Трамвай')
GO
INSERT [dbo].[Vid_Transporta] ([Id_Vid], [Vid]) VALUES (4, N'Троллейбус')
GO
INSERT [dbo].[Vid_Transporta] ([Id_Vid], [Vid]) VALUES (5, N'Маршрутное такси')
GO
SET IDENTITY_INSERT [dbo].[Vid_Transporta] OFF
GO
ALTER TABLE [dbo].[Graphic]  WITH CHECK ADD FOREIGN KEY([Id_Ost])
REFERENCES [dbo].[Ostanovki] ([Id_Ost])
GO
ALTER TABLE [dbo].[Graphic_Rabotnikov]  WITH CHECK ADD FOREIGN KEY([Id_Sotr])
REFERENCES [dbo].[Sotrudniki] ([Id_Sotr])
GO
ALTER TABLE [dbo].[Izmen]  WITH CHECK ADD FOREIGN KEY([Id_Graph])
REFERENCES [dbo].[Graphic] ([Id_Graph])
GO
ALTER TABLE [dbo].[Marshrut]  WITH CHECK ADD FOREIGN KEY([Id_GR])
REFERENCES [dbo].[Graphic_Rabotnikov] ([Id_GR])
GO
ALTER TABLE [dbo].[Marshrut]  WITH CHECK ADD FOREIGN KEY([Id_Perevoz])
REFERENCES [dbo].[Perevozchik] ([Id_Perevoz])
GO
ALTER TABLE [dbo].[Marshrut]  WITH CHECK ADD FOREIGN KEY([Id_Tr])
REFERENCES [dbo].[Transport] ([Id_Tr])
GO
ALTER TABLE [dbo].[Ost_Po_Puti]  WITH CHECK ADD FOREIGN KEY([Id_Marsh])
REFERENCES [dbo].[Marshrut] ([Id_Marsh])
GO
ALTER TABLE [dbo].[Ost_Po_Puti]  WITH CHECK ADD FOREIGN KEY([Id_Ost])
REFERENCES [dbo].[Ostanovki] ([Id_Ost])
GO
ALTER TABLE [dbo].[Ostanovki]  WITH CHECK ADD FOREIGN KEY([Id_Vid])
REFERENCES [dbo].[Vid_Transporta] ([Id_Vid])
GO
ALTER TABLE [dbo].[Sotrudniki]  WITH CHECK ADD FOREIGN KEY([Id_Perevoz])
REFERENCES [dbo].[Perevozchik] ([Id_Perevoz])
GO
ALTER TABLE [dbo].[Transport]  WITH CHECK ADD FOREIGN KEY([Id_Vid])
REFERENCES [dbo].[Vid_Transporta] ([Id_Vid])
GO
/****** Object:  StoredProcedure [dbo].[q_1]    Script Date: 22.04.2025 1:42:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[q_1]
@vid varchar(50)
as
if not exists(select [Nomer_Mars],[Nach_Sled],[Kon_Sled],[Time_Sled],[Name_perevoz],[Num_Tr],[Vid]
from [dbo].[Marshrut] m join [dbo].[Perevozchik] p
on m.[Id_Perevoz] = p.[Id_Perevoz]
join [dbo].[Transport] t
on t.[Id_Tr] = m.[Id_Tr]
join [dbo].[Vid_Transporta] v
on v.[Id_Vid] = t.[Id_Vid]
where [Vid] = @vid)
print 'Такого транспорта нету'
else
select [Nomer_Mars],[Nach_Sled],[Kon_Sled],[Time_Sled],[Name_perevoz],[Num_Tr],[Vid]
from [dbo].[Marshrut] m join [dbo].[Perevozchik] p
on m.[Id_Perevoz] = p.[Id_Perevoz]
join [dbo].[Transport] t
on t.[Id_Tr] = m.[Id_Tr]
join [dbo].[Vid_Transporta] v
on v.[Id_Vid] = t.[Id_Vid]
where [Vid] = @vid
order by [Nomer_Mars]
GO
/****** Object:  StoredProcedure [dbo].[q_10]    Script Date: 22.04.2025 1:42:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[q_10]
@user varchar(100), @role varchar(100)
as
if (@role = 'operator_1') alter role [@role] add member [@user]
if (@role = 'operator_2') alter role [@role] add member [@user]
if (@role = 'operator_3') alter role [@role] add member [@user]
if (@role = 'operator_4') alter role [@role] add member [@user]
if (@role = 'admin_1') alter role [@role] add member [@user]
if (@role = 'admin_2') alter role [@role] add member [@user]
if (@role = 'admin_3') alter role [@role] add member [@user]
if (@role = 'admin_4') alter role [@role] add member [@user]
if (@role = 'super_admin') alter role [@role] add member [@user]
GO
/****** Object:  StoredProcedure [dbo].[q_11]    Script Date: 22.04.2025 1:42:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[q_11]
@group varchar(50)
as
create role [@group]
GO
/****** Object:  StoredProcedure [dbo].[q_14]    Script Date: 22.04.2025 1:42:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[q_14]
@num int
as
if not exists(select [Nomer_Mars], count(month([Day_Sled]))
from [dbo].[Marshrut] m join [dbo].[Ost_Po_Puti] op
on m.[Id_Marsh] = op.[Id_Marsh]
join [dbo].[Ostanovki] o
on o.[Id_Ost] = op.[Id_Ost]
join [dbo].[Graphic] g
on g.[Id_Ost] = o.[Id_Ost]
where [Nomer_Mars] = @num
group by [Nomer_Mars])
print 'Такого маршрута нету'
else
select [Nomer_Mars], count(month([Day_Sled]))
from [dbo].[Marshrut] m join [dbo].[Ost_Po_Puti] op
on m.[Id_Marsh] = op.[Id_Marsh]
join [dbo].[Ostanovki] o
on o.[Id_Ost] = op.[Id_Ost]
join [dbo].[Graphic] g
on g.[Id_Ost] = o.[Id_Ost]
where [Nomer_Mars] = @num
group by [Nomer_Mars]
GO
/****** Object:  StoredProcedure [dbo].[q_16]    Script Date: 22.04.2025 1:42:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[q_16]
@date date
as
if not exists (select count([Nomer_Mars]),[Day_Sled]
from [dbo].[Marshrut]
where @date = [Day_Sled]
group by [Day_Sled])
print 'В эту дату не было маршрутов'
else 
select count([Nomer_Mars]),[Day_Sled]
from [dbo].[Marshrut]
where @date = [Day_Sled]
group by [Day_Sled]
GO
/****** Object:  StoredProcedure [dbo].[q_2]    Script Date: 22.04.2025 1:42:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- q_2 --
create proc [dbo].[q_2]
@naz varchar(100)
as
if not exists(select [Nomer_Mars],[Nach_Sled],[Kon_Sled],[Time_Sled],[Name_perevoz],[Num_Tr],[Vid],[Nazv_Ost],[Mesto_ost],[Pav]
from [dbo].[Marshrut] m join [dbo].[Perevozchik] p
on m.[Id_Perevoz] = p.[Id_Perevoz]
join [dbo].[Transport] t
on t.[Id_Tr] = m.[Id_Tr]
join [dbo].[Vid_Transporta] v
on v.[Id_Vid] = t.[Id_Vid]
join [dbo].[Ost_Po_Puti] op
on op.[Id_Marsh] = m.[Id_Marsh]
join [dbo].[Ostanovki] o
on o.[Id_Ost] = op.[Id_Ost]
where [Nazv_Ost] = @naz)
print 'Такой остановки нету'
else
select [Nomer_Mars],[Nach_Sled],[Kon_Sled],[Time_Sled],[Name_perevoz],[Num_Tr],[Vid],[Nazv_Ost],[Mesto_ost],[Pav]
from [dbo].[Marshrut] m join [dbo].[Perevozchik] p
on m.[Id_Perevoz] = p.[Id_Perevoz]
join [dbo].[Transport] t
on t.[Id_Tr] = m.[Id_Tr]
join [dbo].[Vid_Transporta] v
on v.[Id_Vid] = t.[Id_Vid]
join [dbo].[Ost_Po_Puti] op
on op.[Id_Marsh] = m.[Id_Marsh]
join [dbo].[Ostanovki] o
on o.[Id_Ost] = op.[Id_Ost]
where [Nazv_Ost] = @naz
GO
/****** Object:  StoredProcedure [dbo].[q_3]    Script Date: 22.04.2025 1:42:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc  [dbo].[q_3]
@num int
as
if not exists(select [Nomer_Mars], month([Day_Sled]) [month],day([Day_Sled]) [day],[Day_Week],[Time_Graph]
from [dbo].[Marshrut] m join [dbo].[Ost_Po_Puti] op
on m.[Id_Marsh] = op.[Id_Marsh]
join [dbo].[Ostanovki] o
on o.[Id_Ost] = op.[Id_Ost]
join [dbo].[Graphic] g
on g.[Id_Ost] = o.[Id_Ost]
where [Nomer_Mars] = @num)
print 'Такого маршрута нету'
else select [Nomer_Mars], month([Day_Sled]) [month],day([Day_Sled]) [day],[Day_Week],[Time_Graph]
from [dbo].[Marshrut] m join [dbo].[Ost_Po_Puti] op
on m.[Id_Marsh] = op.[Id_Marsh]
join [dbo].[Ostanovki] o
on o.[Id_Ost] = op.[Id_Ost]
join [dbo].[Graphic] g
on g.[Id_Ost] = o.[Id_Ost]
where [Nomer_Mars] = @num
GO
/****** Object:  StoredProcedure [dbo].[q_5]    Script Date: 22.04.2025 1:42:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc  [dbo].[q_5]
@num int
as
if not exists(select count(o.[Id_Ost]) kol_vo,[Pav]
from [dbo].[Marshrut] m join [dbo].[Ost_Po_Puti] op
on m.[Id_Marsh] = op.[Id_Marsh]
join [dbo].[Ostanovki] o
on o.[Id_Ost] = op.[Id_Ost]
join [dbo].[Graphic] g
on g.[Id_Ost] = o.[Id_Ost]
where [Nomer_Mars]=@num
group by [Pav])
print 'Такого маршрута нету'
else select count(o.[Id_Ost]) kol_vo,[Pav]
from [dbo].[Marshrut] m join [dbo].[Ost_Po_Puti] op
on m.[Id_Marsh] = op.[Id_Marsh]
join [dbo].[Ostanovki] o
on o.[Id_Ost] = op.[Id_Ost]
join [dbo].[Graphic] g
on g.[Id_Ost] = o.[Id_Ost]
where [Nomer_Mars]=@num
group by [Pav]
GO
/****** Object:  StoredProcedure [dbo].[q_8]    Script Date: 22.04.2025 1:42:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[q_8]
@name varchar(50)
as
if not exists(select [Nomer_Mars],[Name_perevoz],[Vid]
from [dbo].[Marshrut] m join [dbo].[Perevozchik] p
on m.[Id_Perevoz] = p.[Id_Perevoz]
join [dbo].[Transport] t
on m.[Id_Tr] = t.[Id_Tr]
join [dbo].[Vid_Transporta] v
on t.[Id_Vid] = v.[Id_Vid]
where [Name_perevoz] = @name)
print 'Такого перевозчика не существует'
else select [Nomer_Mars],[Name_perevoz],[Vid]
from [dbo].[Marshrut] m join [dbo].[Perevozchik] p
on m.[Id_Perevoz] = p.[Id_Perevoz]
join [dbo].[Transport] t
on m.[Id_Tr] = t.[Id_Tr]
join [dbo].[Vid_Transporta] v
on t.[Id_Vid] = v.[Id_Vid]
where [Name_perevoz] = @name
GO
/****** Object:  StoredProcedure [dbo].[q_9]    Script Date: 22.04.2025 1:42:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[q_9]
@log varchar(100), @user varchar(100), @pass varchar(100)
as
create login [@log] with password = '@pass'
create user [@user] for login [@log]
GO
ALTER DATABASE [TRANSPORT] SET  READ_WRITE 
GO
