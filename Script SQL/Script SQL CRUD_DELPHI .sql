USE [master]
GO
/****** Object:  Database [CRUD_DELPHI]    Script Date: 23/08/2022 1:23:40 ******/
CREATE DATABASE [CRUD_DELPHI]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CRUD_DELPHI', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CRUD_DELPHI.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CRUD_DELPHI_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CRUD_DELPHI_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CRUD_DELPHI] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CRUD_DELPHI].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CRUD_DELPHI] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CRUD_DELPHI] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CRUD_DELPHI] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CRUD_DELPHI] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CRUD_DELPHI] SET ARITHABORT OFF 
GO
ALTER DATABASE [CRUD_DELPHI] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [CRUD_DELPHI] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CRUD_DELPHI] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CRUD_DELPHI] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CRUD_DELPHI] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CRUD_DELPHI] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CRUD_DELPHI] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CRUD_DELPHI] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CRUD_DELPHI] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CRUD_DELPHI] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CRUD_DELPHI] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CRUD_DELPHI] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CRUD_DELPHI] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CRUD_DELPHI] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CRUD_DELPHI] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CRUD_DELPHI] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CRUD_DELPHI] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CRUD_DELPHI] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CRUD_DELPHI] SET  MULTI_USER 
GO
ALTER DATABASE [CRUD_DELPHI] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CRUD_DELPHI] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CRUD_DELPHI] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CRUD_DELPHI] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CRUD_DELPHI] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CRUD_DELPHI] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [CRUD_DELPHI] SET QUERY_STORE = OFF
GO
USE [CRUD_DELPHI]
GO
/****** Object:  Table [dbo].[CABEZA_FACTURA]    Script Date: 23/08/2022 1:23:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CABEZA_FACTURA](
	[NUMERO] [varchar](50) NOT NULL,
	[FECHA] [datetime] NULL,
	[CLIENTE] [int] NULL,
	[TOTAL] [numeric](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[NUMERO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CLIENTES]    Script Date: 23/08/2022 1:23:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTES](
	[CLIENTE] [int] NOT NULL,
	[NOMBRE_CLIENTE] [varchar](150) NULL,
	[DIRECCION] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[CLIENTE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DETALLE_FACTURA]    Script Date: 23/08/2022 1:23:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE_FACTURA](
	[NUMERO] [varchar](50) NOT NULL,
	[PRODUCTO] [int] NULL,
	[CANTIDAD] [numeric](18, 2) NULL,
	[VALOR] [numeric](18, 2) NULL,
	[ITEM] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NUMERO] ASC,
	[ITEM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRODUCTOS]    Script Date: 23/08/2022 1:23:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTOS](
	[PRODUCTO] [int] NOT NULL,
	[NOMBRE_PRODUCTO] [varchar](250) NULL,
	[VALOR] [numeric](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[PRODUCTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CABEZA_FACTURA]  WITH CHECK ADD FOREIGN KEY([CLIENTE])
REFERENCES [dbo].[CLIENTES] ([CLIENTE])
GO
ALTER TABLE [dbo].[DETALLE_FACTURA]  WITH CHECK ADD FOREIGN KEY([NUMERO])
REFERENCES [dbo].[CABEZA_FACTURA] ([NUMERO])
GO
ALTER TABLE [dbo].[DETALLE_FACTURA]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCTO] FOREIGN KEY([PRODUCTO])
REFERENCES [dbo].[PRODUCTOS] ([PRODUCTO])
GO
ALTER TABLE [dbo].[DETALLE_FACTURA] CHECK CONSTRAINT [FK_PRODUCTO]
GO
USE [master]
GO
ALTER DATABASE [CRUD_DELPHI] SET  READ_WRITE 
GO
