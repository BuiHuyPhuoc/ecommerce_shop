use master
go

if exists (select * from sysdatabases where name = 'ShopoesDB')
	drop database ShopoesDB
go

create database ShopoesDB
go

use ShopoesDB
go

ALTER DATABASE [ShopoesDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ShopoesDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ShopoesDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ShopoesDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ShopoesDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ShopoesDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ShopoesDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ShopoesDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ShopoesDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ShopoesDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ShopoesDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ShopoesDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ShopoesDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ShopoesDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ShopoesDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ShopoesDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ShopoesDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ShopoesDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ShopoesDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ShopoesDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ShopoesDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ShopoesDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ShopoesDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ShopoesDB] SET  MULTI_USER 
GO
ALTER DATABASE [ShopoesDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ShopoesDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ShopoesDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ShopoesDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ShopoesDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ShopoesDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ShopoesDB] SET QUERY_STORE = OFF
GO
USE [ShopoesDB]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 10/30/2024 5:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 10/30/2024 5:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[IdCustomer] [int] NOT NULL,
	[PasswordHash] [varbinary](max) NOT NULL,
	[PasswordResetToken] [nvarchar](max) NULL,
	[PasswordSalt] [varbinary](max) NOT NULL,
	[ResetTokenExpires] [datetime2](7) NULL,
	[VerificationToken] [nvarchar](max) NULL,
	[VerifiedAt] [datetime2](7) NULL,
 CONSTRAINT [PK__Account__3214EC070761C792] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 10/30/2024 5:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdCustomer] [int] NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[District] [nvarchar](50) NOT NULL,
	[Ward] [nvarchar](50) NOT NULL,
	[Street] [nvarchar](20) NOT NULL,
	[IsDefault] [bit] NOT NULL,
 CONSTRAINT [PK__Addresse__3214EC07DE403D2C] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Brands]    Script Date: 10/30/2024 5:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brands](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NameBrand] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__Brands__3214EC07D01411DF] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carts]    Script Date: 10/30/2024 5:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdProductVarient] [int] NOT NULL,
	[IdCustomer] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_Carts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 10/30/2024 5:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK__Categori__3214EC07146654F8] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 10/30/2024 5:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Phone] [nvarchar](12) NOT NULL,
	[IdRole] [int] NOT NULL,
	[AvatarImageUrl] [nvarchar](max) NULL,
 CONSTRAINT [PK__Customer__3214EC071C3C1ADD] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 10/30/2024 5:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[IdOrder] [int] NOT NULL,
	[IdProduct] [int] NOT NULL,
	[ProductName] [nvarchar](255) NULL,
	[ProductPrice] [float] NULL,
	[SalePrice] [float] NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK__OrderDet__9167A4641D8B6ECD] PRIMARY KEY CLUSTERED 
(
	[IdOrder] ASC,
	[IdProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 10/30/2024 5:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[IdCustomer] [int] NOT NULL,
	[Status] [nvarchar](255) NOT NULL,
	[Amount] [float] NOT NULL,
 CONSTRAINT [PK__Orders__3214EC07D701579F] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImages]    Script Date: 10/30/2024 5:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdProduct] [int] NULL,
	[ImageUrl] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 10/30/2024 5:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NameProduct] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[PriceProduct] [money] NOT NULL,
	[NewPrice] [money] NULL,
	[IdCategory] [int] NOT NULL,
	[IdBrand] [int] NOT NULL,
	[ImageProduct] [nvarchar](255) NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK__Products__3214EC0763884365] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductVarients]    Script Date: 10/30/2024 5:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductVarients](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdProduct] [int] NULL,
	[Size] [int] NOT NULL,
	[InStock] [int] NOT NULL,
	[IsValid] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RefreshTokens]    Script Date: 10/30/2024 5:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RefreshTokens](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Token] [nvarchar](max) NOT NULL,
	[Expires] [datetime2](7) NOT NULL,
	[Created] [datetime2](7) NOT NULL,
	[Revoked] [datetime2](7) NULL,
	[AccountId] [int] NOT NULL,
 CONSTRAINT [PK_RefreshTokens] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 10/30/2024 5:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdCustomer] [int] NOT NULL,
	[IdProduct] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[Content] [nvarchar](255) NOT NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [PK__Reviews__3214EC07A6E4E31B] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 10/30/2024 5:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NameRole] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__Roles__3214EC0772513104] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241030090654_CreateCartTable', N'8.0.10')
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241030091254_UpdateColumnInCart', N'8.0.10')
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241030102026_UpdateRelationInCart', N'8.0.10')
GO
SET IDENTITY_INSERT [dbo].[Account] ON 
GO
INSERT [dbo].[Account] ([Id], [Email], [IdCustomer], [PasswordHash], [PasswordResetToken], [PasswordSalt], [ResetTokenExpires], [VerificationToken], [VerifiedAt]) VALUES (1, N'buihuyphuoc123@gmail.com', 1, 0xE547301D51BFF08FFE59FB677414083B87EA21A503A798EFF345D69441C0FAD9155D88F8D9BAD015D84F62DEB5B494BBD7692B8992415D352E78F563EFE8C30F, NULL, 0x3A93AF18900EE8910EF582C7EF9E36F5AFEE3B9D1DBCF8487C1B5AFA3149495AABFE8B5BE42238831BE06F3A04761E2EEBCECF0EDAA233F8AD9245C5D7E9734A1BFAE40C9F51D948B704341D4C9348317E9540721C5EC76E498854E42DF60A15A4FDC9E30A4DBC7E0BA2BAB35B22E4FA55CD711E21BC555CF77F42A0E0C23B6F, NULL, N'8C59E2110B8867B02D3768E01D520889516CB181D1EC0DB0A50489644B948DEE27C31F9FA791397EA5BC27F47BC007C5B9F166134EC6A331BC924324BDB30953', CAST(N'2024-10-26T18:48:32.4991535' AS DateTime2))
GO
INSERT [dbo].[Account] ([Id], [Email], [IdCustomer], [PasswordHash], [PasswordResetToken], [PasswordSalt], [ResetTokenExpires], [VerificationToken], [VerifiedAt]) VALUES (2, N'dfzdfh@gmail.com', 2, 0xFC2368F0614C74F0B1FE611DEBD5BA129E04766B218969B87C0D4FE999D834F29E595F820F9C844E5BBEA5A1CE79E4AB7ED49B44880687C3F21E814A3EEEC48A, NULL, 0x3EC36FA88A7973987017625C4800D43A02A9555377ADB605A655DADB43545542E8D66C9E2C463265DF7C3BA163709EE97AFC6B93DBECE8E6A5530D85E8889B5E0BB7B657DA425AC6CFEA2EA5E0DBB9D4215FCD18E58BAA0AB1F250D5EDEAE5BD1DFB53C227B80BCDD42DA7DAB0E14B20F061DC9AE2849601F20ED1B97D8AE50B, NULL, N'9E02F8BC9B6AC6634BE21A6B461D0853C2D05D0D2DFA78C867ADE8ADEC7CCF5D53C18395F815C9F642432156FC942199141EABC6867E5D16903672E1226D258A', CAST(N'2024-10-27T00:51:25.7655865' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[Brands] ON 
GO
INSERT [dbo].[Brands] ([Id], [NameBrand]) VALUES (1, N'Nike')
GO
INSERT [dbo].[Brands] ([Id], [NameBrand]) VALUES (2, N'Adidas')
GO
INSERT [dbo].[Brands] ([Id], [NameBrand]) VALUES (3, N'Puma')
GO
INSERT [dbo].[Brands] ([Id], [NameBrand]) VALUES (4, N'Decathlon')
GO
SET IDENTITY_INSERT [dbo].[Brands] OFF
GO
SET IDENTITY_INSERT [dbo].[Carts] ON 
GO
INSERT [dbo].[Carts] ([Id], [IdProductVarient], [IdCustomer], [Quantity]) VALUES (1, 1, 1, 1)
GO
INSERT [dbo].[Carts] ([Id], [IdProductVarient], [IdCustomer], [Quantity]) VALUES (2, 2, 1, 2)
GO
SET IDENTITY_INSERT [dbo].[Carts] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (1, N'Giầy thể thao')
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (2, N'Giầy nam')
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (3, N'Giầy nữ')
GO
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 
GO
INSERT [dbo].[Customers] ([Id], [Name], [Phone], [IdRole], [AvatarImageUrl]) VALUES (1, N'Huy Phuoc', N'0334379439', 1, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/avatar%2Favatar_test.png?alt=media&token=4ccfc92e-db73-49de-98bd-526bde1677fb')
GO
INSERT [dbo].[Customers] ([Id], [Name], [Phone], [IdRole], [AvatarImageUrl]) VALUES (2, N'Huy Phuoc', N'0123456789', 1, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/uploaded_images%2F1730121358199.png?alt=media&token=5a6b4ec3-2432-454b-b5b0-6f6661bf397a')
GO
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductImages] ON 
GO
INSERT [dbo].[ProductImages] ([Id], [IdProduct], [ImageUrl]) VALUES (1, 1, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/AIR%2BFORCE%2B1%2B''07%20(2).jfif?alt=media&token=7c4fcbc1-cbee-42b1-b0ca-7adcb2358387')
GO
INSERT [dbo].[ProductImages] ([Id], [IdProduct], [ImageUrl]) VALUES (2, 1, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/AIR%2BFORCE%2B1%2B''07%20(3).jfif?alt=media&token=7eef7647-2b0e-4e96-897c-74b69801b1cc')
GO
INSERT [dbo].[ProductImages] ([Id], [IdProduct], [ImageUrl]) VALUES (3, 1, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/AIR%2BFORCE%2B1%2B''07%20(1).jfif?alt=media&token=4645b8c0-9328-483c-a534-888414a2b905')
GO
INSERT [dbo].[ProductImages] ([Id], [IdProduct], [ImageUrl]) VALUES (4, 2, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/AIR%2BFORCE%2B1%2B''07%20(4).jfif?alt=media&token=85af822d-271f-43c8-baeb-333ec122c90c')
GO
INSERT [dbo].[ProductImages] ([Id], [IdProduct], [ImageUrl]) VALUES (5, 2, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/AIR%2BFORCE%2B1%2B''07%20(5).jfif?alt=media&token=0774f5b0-bd8a-4676-8190-f98b33427774')
GO
INSERT [dbo].[ProductImages] ([Id], [IdProduct], [ImageUrl]) VALUES (6, 2, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/AIR%2BFORCE%2B1%2B''07%20(6).jfif?alt=media&token=82efd6ca-695b-45ae-9af7-ec3a4aee4950')
GO
INSERT [dbo].[ProductImages] ([Id], [IdProduct], [ImageUrl]) VALUES (7, 3, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/gi%C3%A0y-ch%E1%BA%A1y-b%E1%BB%99-nam-ks500-2-%C4%91en-va%CC%80ng-kiprun-8772865%20(1).jpg?alt=media&token=76945cb6-2b2b-429c-a2a3-3020637a390e')
GO
INSERT [dbo].[ProductImages] ([Id], [IdProduct], [ImageUrl]) VALUES (8, 4, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/gi%C3%A0y-ch%E1%BA%A1y-b%E1%BB%99-nam-ks500-2-%C4%91en-va%CC%80ng-kiprun-8772865%20(2).jpg?alt=media&token=cd0beb24-11dc-409f-87f8-602770db3856')
GO
INSERT [dbo].[ProductImages] ([Id], [IdProduct], [ImageUrl]) VALUES (9, 5, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/gi%C3%A0y-ch%E1%BA%A1y-b%E1%BB%99-nam-nh%E1%BA%B9-jogflow-500k-1-%C4%91en-kalenji-8767749%20(2).jpg?alt=media&token=79b291fe-321b-44ea-9566-6dac5c0e0ed6')
GO
INSERT [dbo].[ProductImages] ([Id], [IdProduct], [ImageUrl]) VALUES (10, 6, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/gi%C3%A0y-%C4%91i-b%E1%BB%99-nam-si%C3%AAu-nh%E1%BA%B9-pw-100-x%C3%A1m-decathlon-8486177%20(2).jpg?alt=media&token=14011567-de30-494c-b8f5-b42b0366320c')
GO
INSERT [dbo].[ProductImages] ([Id], [IdProduct], [ImageUrl]) VALUES (11, 7, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/imageye___-_AIR%2BFORCE%2B1%2B''07%20(1).png?alt=media&token=ac9516ab-42b2-4c1d-ad04-e246d7496910')
GO
INSERT [dbo].[ProductImages] ([Id], [IdProduct], [ImageUrl]) VALUES (12, 8, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/imageye___-_NMD_G1_Shoes_White_IF3455_01_standard.png?alt=media&token=ec6dbe7d-0c5a-4460-a749-9a89d2552222')
GO
INSERT [dbo].[ProductImages] ([Id], [IdProduct], [ImageUrl]) VALUES (13, 9, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/imageye___-_Adifom_Climacool_Shoes_Grey_IF3935_03_standard.png?alt=media&token=bcd913be-b87e-450a-a5d6-b5d26277e38b')
GO
INSERT [dbo].[ProductImages] ([Id], [IdProduct], [ImageUrl]) VALUES (14, 10, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/imageye___-_Adifom_Climacool_Shoes_Grey_IF3935_03_standard.png?alt=media&token=bcd913be-b87e-450a-a5d6-b5d26277e38b')
GO
INSERT [dbo].[ProductImages] ([Id], [IdProduct], [ImageUrl]) VALUES (15, 11, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/imageye___-_Adifom_Climacool_Shoes_Grey_IF3935_03_standard.png?alt=media&token=bcd913be-b87e-450a-a5d6-b5d26277e38b')
GO
INSERT [dbo].[ProductImages] ([Id], [IdProduct], [ImageUrl]) VALUES (16, 12, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/imageye___-_Adifom_Climacool_Shoes_Grey_IF3935_03_standard.png?alt=media&token=bcd913be-b87e-450a-a5d6-b5d26277e38b')
GO
INSERT [dbo].[ProductImages] ([Id], [IdProduct], [ImageUrl]) VALUES (17, 13, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/imageye___-_Adifom_Climacool_Shoes_Grey_IF3935_03_standard.png?alt=media&token=bcd913be-b87e-450a-a5d6-b5d26277e38b')
GO
INSERT [dbo].[ProductImages] ([Id], [IdProduct], [ImageUrl]) VALUES (18, 14, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/NIKE%2BCORTEZ%20(1).png?alt=media&token=b32742bc-c49a-4a56-904f-8cb47a585abe')
GO
INSERT [dbo].[ProductImages] ([Id], [IdProduct], [ImageUrl]) VALUES (19, 14, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/NIKE%2BCORTEZ%20(2).png?alt=media&token=f756566e-f104-4f8c-9aec-f49c522b7697')
GO
SET IDENTITY_INSERT [dbo].[ProductImages] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 
GO
INSERT [dbo].[Products] ([Id], [NameProduct], [Description], [PriceProduct], [NewPrice], [IdCategory], [IdBrand], [ImageProduct], [IsValid]) VALUES (1, N'Nike Air Force 1 Trắng', N'Giầy Nike chính hãng nhập khẩu', 2000000.0000, 1200000.0000, 2, 1, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/AIR%2BFORCE%2B1%2B''07%20(1).jfif?alt=media&token=4645b8c0-9328-483c-a534-888414a2b905', 1)
GO
INSERT [dbo].[Products] ([Id], [NameProduct], [Description], [PriceProduct], [NewPrice], [IdCategory], [IdBrand], [ImageProduct], [IsValid]) VALUES (2, N'Nike Air Force 1 Trắng Đen', N'Giầy Nike chính hãng nhập khẩu', 2000000.0000, 1200000.0000, 2, 1, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/AIR%2BFORCE%2B1%2B''07%20(1).jfif?alt=media&token=4645b8c0-9328-483c-a534-888414a2b905', 1)
GO
INSERT [dbo].[Products] ([Id], [NameProduct], [Description], [PriceProduct], [NewPrice], [IdCategory], [IdBrand], [ImageProduct], [IsValid]) VALUES (3, N'Giầy chạy bộ Kriprun', N'Giầy Decathlon chính hãng nhập khẩu', 2000000.0000, 1200000.0000, 1, 4, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/gi%C3%A0y-ch%E1%BA%A1y-b%E1%BB%99-nam-ks500-2-%C4%91en-va%CC%80ng-kiprun-8772865.jpg?alt=media&token=3f677fd6-63ae-4198-9ca0-04bb22e4fc84', 1)
GO
INSERT [dbo].[Products] ([Id], [NameProduct], [Description], [PriceProduct], [NewPrice], [IdCategory], [IdBrand], [ImageProduct], [IsValid]) VALUES (4, N'Giầy chạy bộ Jogflow', N'Giầy Decathlon chính hãng nhập khẩu', 2000000.0000, 1200000.0000, 1, 4, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/gi%C3%A0y-ch%E1%BA%A1y-b%E1%BB%99-nam-ks500-2-%C4%91en-va%CC%80ng-kiprun-8772865.jpg?alt=media&token=3f677fd6-63ae-4198-9ca0-04bb22e4fc84', 1)
GO
INSERT [dbo].[Products] ([Id], [NameProduct], [Description], [PriceProduct], [NewPrice], [IdCategory], [IdBrand], [ImageProduct], [IsValid]) VALUES (5, N'Giầy chạy bộ Jogflow xanh', N'Giầy Decathlon chính hãng nhập khẩu', 2000000.0000, 1200000.0000, 1, 4, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/gi%C3%A0y-ch%E1%BA%A1y-b%E1%BB%99-nam-ks500-2-%C4%91en-va%CC%80ng-kiprun-8772865.jpg?alt=media&token=3f677fd6-63ae-4198-9ca0-04bb22e4fc84', 1)
GO
INSERT [dbo].[Products] ([Id], [NameProduct], [Description], [PriceProduct], [NewPrice], [IdCategory], [IdBrand], [ImageProduct], [IsValid]) VALUES (6, N'Giầy chạy bộ Jogflow xám', N'Giầy Decathlon chính hãng nhập khẩu', 2000000.0000, 1200000.0000, 1, 4, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/gi%C3%A0y-ch%E1%BA%A1y-b%E1%BB%99-nam-ks500-2-%C4%91en-va%CC%80ng-kiprun-8772865.jpg?alt=media&token=3f677fd6-63ae-4198-9ca0-04bb22e4fc84', 1)
GO
INSERT [dbo].[Products] ([Id], [NameProduct], [Description], [PriceProduct], [NewPrice], [IdCategory], [IdBrand], [ImageProduct], [IsValid]) VALUES (7, N'Nike Air Force 1 Đen Trắng', N'Giầy Nike chính hãng nhập khẩu', 2000000.0000, 1200000.0000, 2, 1, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/AIR%2BFORCE%2B1%2B''07%20(1).jfif?alt=media&token=4645b8c0-9328-483c-a534-888414a2b905', 1)
GO
INSERT [dbo].[Products] ([Id], [NameProduct], [Description], [PriceProduct], [NewPrice], [IdCategory], [IdBrand], [ImageProduct], [IsValid]) VALUES (8, N'Giầy thể thao Adidas', N'Giầy Adidas chính hãng nhập khẩu', 2000000.0000, 1200000.0000, 1, 2, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/imageye___-_Adifom_Climacool_Shoes_Grey_IF3935_01_standard.png?alt=media&token=373bb199-a34f-4aa6-8473-0c78639e6f43', 1)
GO
INSERT [dbo].[Products] ([Id], [NameProduct], [Description], [PriceProduct], [NewPrice], [IdCategory], [IdBrand], [ImageProduct], [IsValid]) VALUES (9, N'Giầy nữ Adidas', N'Giầy Adidas chính hãng nhập khẩu', 2000000.0000, 1200000.0000, 3, 2, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/imageye___-_Adifom_Climacool_Shoes_Grey_IF3935_01_standard.png?alt=media&token=373bb199-a34f-4aa6-8473-0c78639e6f43', 1)
GO
INSERT [dbo].[Products] ([Id], [NameProduct], [Description], [PriceProduct], [NewPrice], [IdCategory], [IdBrand], [ImageProduct], [IsValid]) VALUES (10, N'Giầy nữ Adidas Standard', N'Giầy Adidas chính hãng nhập khẩu', 2000000.0000, 1200000.0000, 3, 2, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/imageye___-_Adifom_Climacool_Shoes_Grey_IF3935_01_standard.png?alt=media&token=373bb199-a34f-4aa6-8473-0c78639e6f43', 1)
GO
INSERT [dbo].[Products] ([Id], [NameProduct], [Description], [PriceProduct], [NewPrice], [IdCategory], [IdBrand], [ImageProduct], [IsValid]) VALUES (11, N'Giầy nữ Adidas Falcon', N'Giầy Adidas chính hãng nhập khẩu', 2000000.0000, 1200000.0000, 3, 2, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/imageye___-_Adifom_Climacool_Shoes_Grey_IF3935_01_standard.png?alt=media&token=373bb199-a34f-4aa6-8473-0c78639e6f43', 1)
GO
INSERT [dbo].[Products] ([Id], [NameProduct], [Description], [PriceProduct], [NewPrice], [IdCategory], [IdBrand], [ImageProduct], [IsValid]) VALUES (12, N'Nike AF1 NEXT NATURE', N'Giầy Nike chính hãng nhập khẩu', 2000000.0000, 1200000.0000, 2, 1, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/AIR%2BFORCE%2B1%2B''07%20(1).jfif?alt=media&token=4645b8c0-9328-483c-a534-888414a2b905', 1)
GO
INSERT [dbo].[Products] ([Id], [NameProduct], [Description], [PriceProduct], [NewPrice], [IdCategory], [IdBrand], [ImageProduct], [IsValid]) VALUES (13, N'Nike Air Force 1 NN', N'Giầy Nike chính hãng nhập khẩu', 2000000.0000, 1200000.0000, 2, 1, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/AIR%2BFORCE%2B1%2B''07%20(1).jfif?alt=media&token=4645b8c0-9328-483c-a534-888414a2b905', 1)
GO
INSERT [dbo].[Products] ([Id], [NameProduct], [Description], [PriceProduct], [NewPrice], [IdCategory], [IdBrand], [ImageProduct], [IsValid]) VALUES (14, N'Nike Cortez', N'Giầy Nike chính hãng nhập khẩu', 2000000.0000, 1200000.0000, 3, 1, N'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/AIR%2BFORCE%2B1%2B''07%20(1).jfif?alt=media&token=4645b8c0-9328-483c-a534-888414a2b905', 1)
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductVarients] ON 
GO
INSERT [dbo].[ProductVarients] ([Id], [IdProduct], [Size], [InStock], [IsValid]) VALUES (1, 1, 34, 5, 1)
GO
INSERT [dbo].[ProductVarients] ([Id], [IdProduct], [Size], [InStock], [IsValid]) VALUES (2, 1, 35, 5, 1)
GO
INSERT [dbo].[ProductVarients] ([Id], [IdProduct], [Size], [InStock], [IsValid]) VALUES (3, 1, 36, 5, 1)
GO
INSERT [dbo].[ProductVarients] ([Id], [IdProduct], [Size], [InStock], [IsValid]) VALUES (4, 1, 37, 5, 1)
GO
INSERT [dbo].[ProductVarients] ([Id], [IdProduct], [Size], [InStock], [IsValid]) VALUES (5, 2, 34, 5, 1)
GO
INSERT [dbo].[ProductVarients] ([Id], [IdProduct], [Size], [InStock], [IsValid]) VALUES (6, 2, 35, 5, 1)
GO
INSERT [dbo].[ProductVarients] ([Id], [IdProduct], [Size], [InStock], [IsValid]) VALUES (7, 3, 34, 5, 1)
GO
INSERT [dbo].[ProductVarients] ([Id], [IdProduct], [Size], [InStock], [IsValid]) VALUES (8, 3, 35, 5, 1)
GO
INSERT [dbo].[ProductVarients] ([Id], [IdProduct], [Size], [InStock], [IsValid]) VALUES (9, 4, 34, 5, 1)
GO
INSERT [dbo].[ProductVarients] ([Id], [IdProduct], [Size], [InStock], [IsValid]) VALUES (10, 5, 34, 5, 1)
GO
INSERT [dbo].[ProductVarients] ([Id], [IdProduct], [Size], [InStock], [IsValid]) VALUES (11, 6, 34, 5, 1)
GO
INSERT [dbo].[ProductVarients] ([Id], [IdProduct], [Size], [InStock], [IsValid]) VALUES (12, 7, 34, 5, 1)
GO
INSERT [dbo].[ProductVarients] ([Id], [IdProduct], [Size], [InStock], [IsValid]) VALUES (13, 8, 34, 5, 1)
GO
INSERT [dbo].[ProductVarients] ([Id], [IdProduct], [Size], [InStock], [IsValid]) VALUES (14, 9, 34, 5, 1)
GO
INSERT [dbo].[ProductVarients] ([Id], [IdProduct], [Size], [InStock], [IsValid]) VALUES (15, 10, 34, 5, 1)
GO
INSERT [dbo].[ProductVarients] ([Id], [IdProduct], [Size], [InStock], [IsValid]) VALUES (16, 11, 34, 5, 1)
GO
INSERT [dbo].[ProductVarients] ([Id], [IdProduct], [Size], [InStock], [IsValid]) VALUES (17, 12, 34, 5, 1)
GO
INSERT [dbo].[ProductVarients] ([Id], [IdProduct], [Size], [InStock], [IsValid]) VALUES (18, 13, 34, 5, 1)
GO
INSERT [dbo].[ProductVarients] ([Id], [IdProduct], [Size], [InStock], [IsValid]) VALUES (19, 14, 34, 5, 1)
GO
SET IDENTITY_INSERT [dbo].[ProductVarients] OFF
GO
SET IDENTITY_INSERT [dbo].[RefreshTokens] ON 
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [Expires], [Created], [Revoked], [AccountId]) VALUES (1, N'77UqWTox0OcuG/3beQTzbAP1iD+z8TKF2t84viSJ3g6fg1PKnUSoNFepla7ZutcISYibTBCO/drdgA4G3o12Sg==', CAST(N'2024-10-31T07:12:05.3842663' AS DateTime2), CAST(N'2024-10-30T07:12:05.3843209' AS DateTime2), NULL, 1)
GO
INSERT [dbo].[RefreshTokens] ([Id], [Token], [Expires], [Created], [Revoked], [AccountId]) VALUES (2, N'3VudX8ZAMqUtMatOn7EzPBPCGIpg9qpoN2s0p6C9/7n/eU4JJ44uP0JvBGCvJaYQQY09re0dUOBM0BFabeqImw==', CAST(N'2024-10-29T13:15:49.0608850' AS DateTime2), CAST(N'2024-10-28T13:15:49.0618571' AS DateTime2), NULL, 2)
GO
SET IDENTITY_INSERT [dbo].[RefreshTokens] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 
GO
INSERT [dbo].[Roles] ([Id], [NameRole]) VALUES (1, N'Khách hàng')
GO
INSERT [dbo].[Roles] ([Id], [NameRole]) VALUES (2, N'Quản trị viên')
GO
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
/****** Object:  Index [IX_Addresses_IdCustomer]    Script Date: 10/30/2024 5:28:03 PM ******/
CREATE NONCLUSTERED INDEX [IX_Addresses_IdCustomer] ON [dbo].[Addresses]
(
	[IdCustomer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Carts_IdCustomer]    Script Date: 10/30/2024 5:28:03 PM ******/
CREATE NONCLUSTERED INDEX [IX_Carts_IdCustomer] ON [dbo].[Carts]
(
	[IdCustomer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Carts_IdProductVarient]    Script Date: 10/30/2024 5:28:03 PM ******/
CREATE NONCLUSTERED INDEX [IX_Carts_IdProductVarient] ON [dbo].[Carts]
(
	[IdProductVarient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Customers_IdRole]    Script Date: 10/30/2024 5:28:03 PM ******/
CREATE NONCLUSTERED INDEX [IX_Customers_IdRole] ON [dbo].[Customers]
(
	[IdRole] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Orders_IdCustomer]    Script Date: 10/30/2024 5:28:03 PM ******/
CREATE NONCLUSTERED INDEX [IX_Orders_IdCustomer] ON [dbo].[Orders]
(
	[IdCustomer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_IdBrand]    Script Date: 10/30/2024 5:28:03 PM ******/
CREATE NONCLUSTERED INDEX [IX_Products_IdBrand] ON [dbo].[Products]
(
	[IdBrand] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_IdCategory]    Script Date: 10/30/2024 5:28:03 PM ******/
CREATE NONCLUSTERED INDEX [IX_Products_IdCategory] ON [dbo].[Products]
(
	[IdCategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RefreshTokens_AccountId]    Script Date: 10/30/2024 5:28:03 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_RefreshTokens_AccountId] ON [dbo].[RefreshTokens]
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Reviews_IdCustomer]    Script Date: 10/30/2024 5:28:03 PM ******/
CREATE NONCLUSTERED INDEX [IX_Reviews_IdCustomer] ON [dbo].[Reviews]
(
	[IdCustomer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT (0x) FOR [PasswordHash]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT (0x) FOR [PasswordSalt]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (N'BOOKED') FOR [Status]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (CONVERT([bit],(1))) FOR [IsValid]
GO
ALTER TABLE [dbo].[ProductVarients] ADD  DEFAULT ((1)) FOR [IsValid]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK__Account__Id__4316F928] FOREIGN KEY([Id])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK__Account__Id__4316F928]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK__Addresses__IdCus__46E78A0C] FOREIGN KEY([IdCustomer])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK__Addresses__IdCus__46E78A0C]
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD  CONSTRAINT [FK_Carts_Customers_IdCustomer] FOREIGN KEY([IdCustomer])
REFERENCES [dbo].[Customers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Carts] CHECK CONSTRAINT [FK_Carts_Customers_IdCustomer]
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD  CONSTRAINT [FK_Carts_ProductVarients_IdProductVarient] FOREIGN KEY([IdProductVarient])
REFERENCES [dbo].[ProductVarients] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Carts] CHECK CONSTRAINT [FK_Carts_ProductVarients_IdProductVarient]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK__Customers__IdRol__44FF419A] FOREIGN KEY([IdRole])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK__Customers__IdRol__44FF419A]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK__OrderDeta__IdOrd__45F365D3] FOREIGN KEY([IdOrder])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK__OrderDeta__IdOrd__45F365D3]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([IdProduct])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK__Orders__IdCustom__4222D4EF] FOREIGN KEY([IdCustomer])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK__Orders__IdCustom__4222D4EF]
GO
ALTER TABLE [dbo].[ProductImages]  WITH CHECK ADD FOREIGN KEY([IdProduct])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK__Products__IdBran__440B1D61] FOREIGN KEY([IdBrand])
REFERENCES [dbo].[Brands] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK__Products__IdBran__440B1D61]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK__Products__IdCate__403A8C7D] FOREIGN KEY([IdCategory])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK__Products__IdCate__403A8C7D]
GO
ALTER TABLE [dbo].[ProductVarients]  WITH CHECK ADD FOREIGN KEY([IdProduct])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[RefreshTokens]  WITH CHECK ADD  CONSTRAINT [FK_RefreshTokens_Account_AccountId] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Account] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RefreshTokens] CHECK CONSTRAINT [FK_RefreshTokens_Account_AccountId]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK__Reviews__IdCusto__412EB0B6] FOREIGN KEY([IdCustomer])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK__Reviews__IdCusto__412EB0B6]
GO
ALTER TABLE [dbo].[ProductVarients]  WITH CHECK ADD CHECK  (([InStock]>=(0)))
GO
ALTER TABLE [dbo].[ProductVarients]  WITH CHECK ADD CHECK  (([Size]>(0)))
GO
USE [master]
GO
ALTER DATABASE [ShopoesDB] SET  READ_WRITE 
GO

