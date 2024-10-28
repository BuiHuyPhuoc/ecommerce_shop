use master
go

if exists (select * from sysdatabases where name = 'ShopoesDB')
	drop database ShopoesDB
go

create database ShopoesDB
go

use ShopoesDB
go

/****** Object:  Table [dbo].[Account]    Script Date: 10/19/2024 11:23:09 AM ******/
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
/****** Object:  Table [dbo].[Addresses]    Script Date: 10/19/2024 11:23:09 AM ******/
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
/****** Object:  Table [dbo].[Brands]    Script Date: 10/19/2024 11:23:09 AM ******/
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
/****** Object:  Table [dbo].[Categories]    Script Date: 10/19/2024 11:23:09 AM ******/
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
/****** Object:  Table [dbo].[Customers]    Script Date: 10/19/2024 11:23:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Phone] [nvarchar](12) NOT NULL,
	[IdRole] [int] NOT NULL,
	[AvatarImageUrl] [nvarchar](max) null,
 CONSTRAINT [PK__Customer__3214EC071C3C1ADD] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 10/19/2024 11:23:09 AM ******/
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
/****** Object:  Table [dbo].[Orders]    Script Date: 10/19/2024 11:23:09 AM ******/
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
/****** Object:  Table [dbo].[Products]    Script Date: 10/19/2024 11:23:09 AM ******/
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
/****** Object:  Table [dbo].[RefreshTokens]    Script Date: 10/19/2024 11:23:09 AM ******/
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
/****** Object:  Table [dbo].[Reviews]    Script Date: 10/19/2024 11:23:09 AM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 10/19/2024 11:23:09 AM ******/
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
/****** Object:  Index [IX_Addresses_IdCustomer]    Script Date: 10/19/2024 11:23:09 AM ******/
CREATE NONCLUSTERED INDEX [IX_Addresses_IdCustomer] ON [dbo].[Addresses]
(
	[IdCustomer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Customers_IdRole]    Script Date: 10/19/2024 11:23:09 AM ******/
CREATE NONCLUSTERED INDEX [IX_Customers_IdRole] ON [dbo].[Customers]
(
	[IdRole] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Orders_IdCustomer]    Script Date: 10/19/2024 11:23:09 AM ******/
CREATE NONCLUSTERED INDEX [IX_Orders_IdCustomer] ON [dbo].[Orders]
(
	[IdCustomer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_IdBrand]    Script Date: 10/19/2024 11:23:09 AM ******/
CREATE NONCLUSTERED INDEX [IX_Products_IdBrand] ON [dbo].[Products]
(
	[IdBrand] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_IdCategory]    Script Date: 10/19/2024 11:23:09 AM ******/
CREATE NONCLUSTERED INDEX [IX_Products_IdCategory] ON [dbo].[Products]
(
	[IdCategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RefreshTokens_AccountId]    Script Date: 10/19/2024 11:23:09 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_RefreshTokens_AccountId] ON [dbo].[RefreshTokens]
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Reviews_IdCustomer]    Script Date: 10/19/2024 11:23:09 AM ******/
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
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK__Orders__IdCustom__4222D4EF] FOREIGN KEY([IdCustomer])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK__Orders__IdCustom__4222D4EF]
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

ALTER TABLE OrderDetails
ADD FOREIGN KEY (IdProduct) REFERENCES Products(Id);

create table [ProductVarients] (
	[Id] [int] IDENTITY(1,1) primary key,
	[IdProduct] int references [Products](Id),
	[Size] int not null check ([Size] > 0),
	[InStock] int not null check ([InStock] >=0),
	[IsValid] bit default 1,
)

create table [ProductImages] (
	[Id] [int] IDENTITY(1,1) primary key,
	[IdProduct] int references [Products](Id),
	[ImageUrl] nvarchar(max),
)

--Thêm dữ liệu
insert into [Brands] values (N'Nike')
insert into [Brands] values (N'Adidas')
insert into [Brands] values (N'Puma')
insert into [Brands] values (N'Decathlon')

insert into [Categories] values (N'Giầy thể thao')
insert into [Categories] values (N'Giầy nam')
insert into [Categories] values (N'Giầy nữ')

insert into [Roles] values (N'Khách hàng')
insert into [Roles] values (N'Quản trị viên')

insert into [Products] values (N'Nike Air Force 1 Trắng', N'Giầy Nike chính hãng nhập khẩu', 2000000.0, 1200000, 2,  1, null, 1)
insert into [Products] values (N'Nike Air Force 1 Trắng Đen', N'Giầy Nike chính hãng nhập khẩu', 2000000, 1200000, 2,  1, null, 1)
insert into [Products] values (N'Giầy chạy bộ Kriprun', N'Giầy Decathlon chính hãng nhập khẩu', 2000000, 1200000, 1,  4, null, 1)
insert into [Products] values (N'Giầy chạy bộ Jogflow', N'Giầy Decathlon chính hãng nhập khẩu', 2000000, 1200000, 1,  4, null, 1)
insert into [Products] values (N'Giầy chạy bộ Jogflow xanh', N'Giầy Decathlon chính hãng nhập khẩu', 2000000, 1200000, 1,  4, null, 1)
insert into [Products] values (N'Giầy chạy bộ Jogflow xám', N'Giầy Decathlon chính hãng nhập khẩu', 2000000, 1200000, 1,  4, null, 1)
insert into [Products] values (N'Nike Air Force 1 Đen Trắng', N'Giầy Nike chính hãng nhập khẩu', 2000000, 1200000, 2, 1, null, 1)
insert into [Products] values (N'Giầy thể thao Adidas', N'Giầy Adidas chính hãng nhập khẩu', 2000000, 1200000, 1, 2, null, 1)
insert into [Products] values (N'Giầy nữ Adidas', N'Giầy Adidas chính hãng nhập khẩu', 2000000, 1200000, 3, 2, null, 1)
insert into [Products] values (N'Giầy nữ Adidas Standard', N'Giầy Adidas chính hãng nhập khẩu', 2000000, 1200000, 3, 2, null, 1)
insert into [Products] values (N'Giầy nữ Adidas Falcon', N'Giầy Adidas chính hãng nhập khẩu', 2000000, 1200000, 3, 2, null, 1)
insert into [Products] values (N'Nike AF1 NEXT NATURE', N'Giầy Nike chính hãng nhập khẩu', 2000000, 1200000, 2, 1, null, 1)
insert into [Products] values (N'Nike Air Force 1 NN', N'Giầy Nike chính hãng nhập khẩu', 2000000, 1200000, 2, 1, null, 1)
insert into [Products] values (N'Nike Cortez', N'Giầy Nike chính hãng nhập khẩu', 2000000, 1200000, 3, 1, null, 1)

insert into [ProductImages] values (1, 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/AIR%2BFORCE%2B1%2B''07%20(2).jfif?alt=media&token=7c4fcbc1-cbee-42b1-b0ca-7adcb2358387')
insert into [ProductImages] values (1, 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/AIR%2BFORCE%2B1%2B''07%20(3).jfif?alt=media&token=7eef7647-2b0e-4e96-897c-74b69801b1cc')
insert into [ProductImages] values (1, 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/AIR%2BFORCE%2B1%2B''07%20(1).jfif?alt=media&token=4645b8c0-9328-483c-a534-888414a2b905')
insert into [ProductImages] values (2, 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/AIR%2BFORCE%2B1%2B''07%20(4).jfif?alt=media&token=85af822d-271f-43c8-baeb-333ec122c90c')
insert into [ProductImages] values (2, 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/AIR%2BFORCE%2B1%2B''07%20(5).jfif?alt=media&token=0774f5b0-bd8a-4676-8190-f98b33427774')
insert into [ProductImages] values (2, 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/AIR%2BFORCE%2B1%2B''07%20(6).jfif?alt=media&token=82efd6ca-695b-45ae-9af7-ec3a4aee4950')
insert into [ProductImages] values (3, 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/gi%C3%A0y-ch%E1%BA%A1y-b%E1%BB%99-nam-ks500-2-%C4%91en-va%CC%80ng-kiprun-8772865%20(1).jpg?alt=media&token=76945cb6-2b2b-429c-a2a3-3020637a390e')
insert into [ProductImages] values (4, 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/gi%C3%A0y-ch%E1%BA%A1y-b%E1%BB%99-nam-ks500-2-%C4%91en-va%CC%80ng-kiprun-8772865%20(2).jpg?alt=media&token=cd0beb24-11dc-409f-87f8-602770db3856')
insert into [ProductImages] values (5, 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/gi%C3%A0y-ch%E1%BA%A1y-b%E1%BB%99-nam-nh%E1%BA%B9-jogflow-500k-1-%C4%91en-kalenji-8767749%20(2).jpg?alt=media&token=79b291fe-321b-44ea-9566-6dac5c0e0ed6')
insert into [ProductImages] values (6, 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/gi%C3%A0y-%C4%91i-b%E1%BB%99-nam-si%C3%AAu-nh%E1%BA%B9-pw-100-x%C3%A1m-decathlon-8486177%20(2).jpg?alt=media&token=14011567-de30-494c-b8f5-b42b0366320c')
insert into [ProductImages] values (7, 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/imageye___-_AIR%2BFORCE%2B1%2B''07%20(1).png?alt=media&token=ac9516ab-42b2-4c1d-ad04-e246d7496910')
insert into [ProductImages] values (8, 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/imageye___-_NMD_G1_Shoes_White_IF3455_01_standard.png?alt=media&token=ec6dbe7d-0c5a-4460-a749-9a89d2552222')
insert into [ProductImages] values (9, 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/imageye___-_Adifom_Climacool_Shoes_Grey_IF3935_03_standard.png?alt=media&token=bcd913be-b87e-450a-a5d6-b5d26277e38b')
insert into [ProductImages] values (10, 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/imageye___-_Adifom_Climacool_Shoes_Grey_IF3935_03_standard.png?alt=media&token=bcd913be-b87e-450a-a5d6-b5d26277e38b')
insert into [ProductImages] values (11, 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/imageye___-_Adifom_Climacool_Shoes_Grey_IF3935_03_standard.png?alt=media&token=bcd913be-b87e-450a-a5d6-b5d26277e38b')
insert into [ProductImages] values (12, 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/imageye___-_Adifom_Climacool_Shoes_Grey_IF3935_03_standard.png?alt=media&token=bcd913be-b87e-450a-a5d6-b5d26277e38b')
insert into [ProductImages] values (13, 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/imageye___-_Adifom_Climacool_Shoes_Grey_IF3935_03_standard.png?alt=media&token=bcd913be-b87e-450a-a5d6-b5d26277e38b')
insert into [ProductImages] values (14, 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/NIKE%2BCORTEZ%20(1).png?alt=media&token=b32742bc-c49a-4a56-904f-8cb47a585abe')
insert into [ProductImages] values (14, 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/NIKE%2BCORTEZ%20(2).png?alt=media&token=f756566e-f104-4f8c-9aec-f49c522b7697')

update Products
set ImageProduct = 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/AIR%2BFORCE%2B1%2B''07%20(1).jfif?alt=media&token=4645b8c0-9328-483c-a534-888414a2b905'
where Id = 1 or Id = 2 or Id = 7 or Id = 12 or Id = 13 or Id = 14

update Products
set ImageProduct = 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/gi%C3%A0y-ch%E1%BA%A1y-b%E1%BB%99-nam-ks500-2-%C4%91en-va%CC%80ng-kiprun-8772865.jpg?alt=media&token=3f677fd6-63ae-4198-9ca0-04bb22e4fc84'
where Id = 3 or Id = 4 or Id = 5 or Id = 6

update Products
set ImageProduct = 'https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/imageye___-_Adifom_Climacool_Shoes_Grey_IF3935_01_standard.png?alt=media&token=373bb199-a34f-4aa6-8473-0c78639e6f43'
where Id = 8 or Id = 9 or Id = 10 or Id = 11

insert into ProductVarients values (1, 34, 5, 1)
insert into ProductVarients values (1, 35, 5, 1)
insert into ProductVarients values (1, 36, 5, 1)
insert into ProductVarients values (1, 37, 5, 1)
insert into ProductVarients values (2, 34, 5, 1)
insert into ProductVarients values (2, 35, 5, 1)
insert into ProductVarients values (3, 34, 5, 1)
insert into ProductVarients values (3, 35, 5, 1)
insert into ProductVarients values (4, 34, 5, 1)
insert into ProductVarients values (5, 34, 5, 1)
insert into ProductVarients values (6, 34, 5, 1)
insert into ProductVarients values (7, 34, 5, 1)
insert into ProductVarients values (8, 34, 5, 1)
insert into ProductVarients values (9, 34, 5, 1)
insert into ProductVarients values (10, 34, 5, 1)
insert into ProductVarients values (11, 34, 5, 1)
insert into ProductVarients values (12, 34, 5, 1)
insert into ProductVarients values (13, 34, 5, 1)
insert into ProductVarients values (14, 34, 5, 1)

