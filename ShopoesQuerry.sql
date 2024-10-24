use master
go

if exists (select * from sysdatabases where name = 'ShopoesDB')
	drop database ShopoesDB
go

create database ShopoesDB
go

use ShopoesDB
go

CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
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
	[PriceProduct] [float] NOT NULL,
	[NewPrice] [float] NULL,
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


--Thêm dữ liệu
insert into [Brands] values (N'Nike')
insert into [Brands] values (N'Adidas')
insert into [Brands] values (N'Puma')
insert into [Brands] values (N'Decathlon')

insert into [Categories] values (N'Giầy thể thao')
insert into [Categories] values (N'Giầy nam')
insert into [Categories] values (N'Giầy nữ')

--[Id] [int] IDENTITY(1,1) NOT NULL,
--	[NameProduct] [nvarchar](255) NOT NULL,
--	[Description] [nvarchar](max) NOT NULL,
--	[PriceProduct] [float] NOT NULL,
--	[NewPrice] [float] NULL,
--	[IdCategory] [int] NOT NULL,
--	[IdBrand] [int] NOT NULL,
--	[ImageProduct] [nvarchar](255) NULL,
--	[IsValid] [bit] NOT NULL,

insert into [Products] values (N'Nike Air Force 1 Trắng', N'Giầy Nike chính hãng nhập khẩu', 2000000, 1200000, 2,  1, null, 1)
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

insert into [Roles] values (N'Khách hàng')
insert into [Roles] values (N'Quản trị viên')

--insert into [Customers] values (N'test', '0123456789', 1)
--insert into [Customers] values (N'admin', '0987654321', 2)

--insert into [Addresses] values (1, N'Thành phố Hồ Chí Minh', N'Huyện Hóc Môn', N'Xã Trung Chánh', N'119 đường Giác Đạo', 1)
--insert into [Addresses] values (1, N'Thành phố Hồ Chí Minh', N'Huyện Hóc Môn', N'Xã Trung Chánh', N'333 đường Giác Đạo', 1)

--insert into [Account] values ('test@gmail.com', '123', 1)
--insert into [Account] values ('admin@gmail.com', '123', 2) 

--select * from Account
--select * from Customers

--delete from Customers;
--delete from Account;
 

