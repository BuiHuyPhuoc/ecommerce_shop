﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using ShopoesAPI.Models;

#nullable disable

namespace ShopoesAPI.Migrations
{
    [DbContext(typeof(ShopoesDbContext))]
    partial class ShopoesDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.10")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("ShopoesAPI.Models.Account", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<int>("IdCustomer")
                        .HasColumnType("int");

                    b.Property<byte[]>("PasswordHash")
                        .IsRequired()
                        .ValueGeneratedOnAdd()
                        .HasColumnType("varbinary(max)")
                        .HasDefaultValueSql("(0x)");

                    b.Property<string>("PasswordResetToken")
                        .HasColumnType("nvarchar(max)");

                    b.Property<byte[]>("PasswordSalt")
                        .IsRequired()
                        .ValueGeneratedOnAdd()
                        .HasColumnType("varbinary(max)")
                        .HasDefaultValueSql("(0x)");

                    b.Property<DateTime?>("ResetTokenExpires")
                        .HasColumnType("datetime2");

                    b.Property<string>("VerificationToken")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime?>("VerifiedAt")
                        .HasColumnType("datetime2");

                    b.HasKey("Id")
                        .HasName("PK__Account__3214EC070761C792");

                    b.ToTable("Account", (string)null);
                });

            modelBuilder.Entity("ShopoesAPI.Models.Address", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("City")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("District")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<int>("IdCustomer")
                        .HasColumnType("int");

                    b.Property<bool>("IsDefault")
                        .HasColumnType("bit");

                    b.Property<string>("ReceiverName")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("ReceiverPhone")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Street")
                        .IsRequired()
                        .HasMaxLength(20)
                        .HasColumnType("nvarchar(20)");

                    b.Property<string>("Ward")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("Id")
                        .HasName("PK__Addresse__3214EC07DE403D2C");

                    b.HasIndex(new[] { "IdCustomer" }, "IX_Addresses_IdCustomer");

                    b.ToTable("Addresses");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Brand", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("NameBrand")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("Id")
                        .HasName("PK__Brands__3214EC07D01411DF");

                    b.ToTable("Brands");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Cart", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("IdCustomer")
                        .HasColumnType("int");

                    b.Property<int>("IdProductVarient")
                        .HasColumnType("int");

                    b.Property<int>("Quantity")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("IdCustomer");

                    b.HasIndex("IdProductVarient");

                    b.ToTable("Carts");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Category", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("nvarchar(255)");

                    b.HasKey("Id")
                        .HasName("PK__Categori__3214EC07146654F8");

                    b.ToTable("Categories");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Customer", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("AvatarImageUrl")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("IdRole")
                        .HasColumnType("int");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("nvarchar(255)");

                    b.Property<string>("Phone")
                        .IsRequired()
                        .HasMaxLength(12)
                        .HasColumnType("nvarchar(12)");

                    b.HasKey("Id")
                        .HasName("PK__Customer__3214EC071C3C1ADD");

                    b.HasIndex(new[] { "IdRole" }, "IX_Customers_IdRole");

                    b.ToTable("Customers");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Order", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<decimal>("Amount")
                        .HasColumnType("decimal(18,2)");

                    b.Property<DateTime>("Date")
                        .HasColumnType("datetime");

                    b.Property<int>("IdAddress")
                        .HasColumnType("int");

                    b.Property<int>("IdCustomer")
                        .HasColumnType("int");

                    b.Property<string>("Status")
                        .IsRequired()
                        .ValueGeneratedOnAdd()
                        .HasMaxLength(255)
                        .HasColumnType("nvarchar(255)")
                        .HasDefaultValue("BOOKED");

                    b.HasKey("Id")
                        .HasName("PK__Orders__3214EC07D701579F");

                    b.HasIndex("IdAddress");

                    b.HasIndex(new[] { "IdCustomer" }, "IX_Orders_IdCustomer");

                    b.ToTable("Orders");
                });

            modelBuilder.Entity("ShopoesAPI.Models.OrderDetail", b =>
                {
                    b.Property<int>("IdOrder")
                        .HasColumnType("int");

                    b.Property<int>("IdProductVarient")
                        .HasColumnType("int")
                        .HasColumnName("IdProductVarient");

                    b.Property<string>("ProductName")
                        .HasMaxLength(255)
                        .HasColumnType("nvarchar(255)");

                    b.Property<decimal?>("ProductPrice")
                        .HasColumnType("decimal(18,2)");

                    b.Property<int>("Quantity")
                        .HasColumnType("int");

                    b.Property<decimal?>("SalePrice")
                        .HasColumnType("decimal(18,2)");

                    b.HasKey("IdOrder", "IdProductVarient");

                    b.HasIndex("IdProductVarient");

                    b.ToTable("OrderDetails");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Product", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("IdBrand")
                        .HasColumnType("int");

                    b.Property<int>("IdCategory")
                        .HasColumnType("int");

                    b.Property<string>("ImageProduct")
                        .HasMaxLength(255)
                        .HasColumnType("nvarchar(255)");

                    b.Property<bool>("IsValid")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValue(true);

                    b.Property<string>("NameProduct")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("nvarchar(255)");

                    b.Property<decimal?>("NewPrice")
                        .HasColumnType("money");

                    b.Property<decimal>("PriceProduct")
                        .HasColumnType("money");

                    b.HasKey("Id")
                        .HasName("PK__Products__3214EC0763884365");

                    b.HasIndex(new[] { "IdBrand" }, "IX_Products_IdBrand");

                    b.HasIndex(new[] { "IdCategory" }, "IX_Products_IdCategory");

                    b.ToTable("Products");
                });

            modelBuilder.Entity("ShopoesAPI.Models.ProductImage", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int?>("IdProduct")
                        .HasColumnType("int");

                    b.Property<string>("ImageUrl")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id")
                        .HasName("PK__ProductI__3214EC073159DAF9");

                    b.HasIndex("IdProduct");

                    b.ToTable("ProductImages");
                });

            modelBuilder.Entity("ShopoesAPI.Models.ProductVarient", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int?>("IdProduct")
                        .HasColumnType("int");

                    b.Property<int>("InStock")
                        .HasColumnType("int");

                    b.Property<bool?>("IsValid")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValue(true);

                    b.Property<int>("Size")
                        .HasColumnType("int");

                    b.HasKey("Id")
                        .HasName("PK__ProductV__3214EC07D12EAD3F");

                    b.HasIndex("IdProduct");

                    b.ToTable("ProductVarients");
                });

            modelBuilder.Entity("ShopoesAPI.Models.RefreshToken", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("AccountId")
                        .HasColumnType("int");

                    b.Property<DateTime>("Created")
                        .HasColumnType("datetime2");

                    b.Property<DateTime>("Expires")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("Revoked")
                        .HasColumnType("datetime2");

                    b.Property<string>("Token")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex(new[] { "AccountId" }, "IX_RefreshTokens_AccountId")
                        .IsUnique();

                    b.ToTable("RefreshTokens");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Review", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Content")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("nvarchar(255)");

                    b.Property<DateTime>("Date")
                        .HasColumnType("datetime");

                    b.Property<int>("IdCustomer")
                        .HasColumnType("int");

                    b.Property<int>("IdProduct")
                        .HasColumnType("int");

                    b.Property<int>("Rating")
                        .HasColumnType("int");

                    b.HasKey("Id")
                        .HasName("PK__Reviews__3214EC07A6E4E31B");

                    b.HasIndex("IdProduct");

                    b.HasIndex(new[] { "IdCustomer" }, "IX_Reviews_IdCustomer");

                    b.ToTable("Reviews");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Role", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("NameRole")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("Id")
                        .HasName("PK__Roles__3214EC0772513104");

                    b.ToTable("Roles");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Account", b =>
                {
                    b.HasOne("ShopoesAPI.Models.Customer", "IdNavigation")
                        .WithOne("Account")
                        .HasForeignKey("ShopoesAPI.Models.Account", "Id")
                        .IsRequired()
                        .HasConstraintName("FK__Account__Id__4316F928");

                    b.Navigation("IdNavigation");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Address", b =>
                {
                    b.HasOne("ShopoesAPI.Models.Customer", "IdCustomerNavigation")
                        .WithMany("Addresses")
                        .HasForeignKey("IdCustomer")
                        .IsRequired()
                        .HasConstraintName("FK__Addresses__IdCus__46E78A0C");

                    b.Navigation("IdCustomerNavigation");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Cart", b =>
                {
                    b.HasOne("ShopoesAPI.Models.Customer", "IdCustomerNavigation")
                        .WithMany("Carts")
                        .HasForeignKey("IdCustomer")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("ShopoesAPI.Models.ProductVarient", "IdProductVarientNavigation")
                        .WithMany("Carts")
                        .HasForeignKey("IdProductVarient")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("IdCustomerNavigation");

                    b.Navigation("IdProductVarientNavigation");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Customer", b =>
                {
                    b.HasOne("ShopoesAPI.Models.Role", "IdRoleNavigation")
                        .WithMany("Customers")
                        .HasForeignKey("IdRole")
                        .IsRequired()
                        .HasConstraintName("FK__Customers__IdRol__44FF419A");

                    b.Navigation("IdRoleNavigation");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Order", b =>
                {
                    b.HasOne("ShopoesAPI.Models.Address", "IdAddressNavigation")
                        .WithMany("Orders")
                        .HasForeignKey("IdAddress")
                        .IsRequired();

                    b.HasOne("ShopoesAPI.Models.Customer", "IdCustomerNavigation")
                        .WithMany("Orders")
                        .HasForeignKey("IdCustomer")
                        .IsRequired()
                        .HasConstraintName("FK__Orders__IdCustom__4222D4EF");

                    b.Navigation("IdAddressNavigation");

                    b.Navigation("IdCustomerNavigation");
                });

            modelBuilder.Entity("ShopoesAPI.Models.OrderDetail", b =>
                {
                    b.HasOne("ShopoesAPI.Models.Order", "IdOrderNavigation")
                        .WithMany("OrderDetails")
                        .HasForeignKey("IdOrder")
                        .IsRequired()
                        .HasConstraintName("FK__OrderDeta__IdOrd__45F365D3");

                    b.HasOne("ShopoesAPI.Models.ProductVarient", "IdProductVarientNavigation")
                        .WithMany("OrderDetails")
                        .HasForeignKey("IdProductVarient")
                        .IsRequired();

                    b.Navigation("IdOrderNavigation");

                    b.Navigation("IdProductVarientNavigation");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Product", b =>
                {
                    b.HasOne("ShopoesAPI.Models.Brand", "IdBrandNavigation")
                        .WithMany("Products")
                        .HasForeignKey("IdBrand")
                        .IsRequired()
                        .HasConstraintName("FK__Products__IdBran__440B1D61");

                    b.HasOne("ShopoesAPI.Models.Category", "IdCategoryNavigation")
                        .WithMany("Products")
                        .HasForeignKey("IdCategory")
                        .IsRequired()
                        .HasConstraintName("FK__Products__IdCate__403A8C7D");

                    b.Navigation("IdBrandNavigation");

                    b.Navigation("IdCategoryNavigation");
                });

            modelBuilder.Entity("ShopoesAPI.Models.ProductImage", b =>
                {
                    b.HasOne("ShopoesAPI.Models.Product", "IdProductNavigation")
                        .WithMany("ProductImages")
                        .HasForeignKey("IdProduct")
                        .HasConstraintName("FK__ProductIm__IdPro__4CA06362");

                    b.Navigation("IdProductNavigation");
                });

            modelBuilder.Entity("ShopoesAPI.Models.ProductVarient", b =>
                {
                    b.HasOne("ShopoesAPI.Models.Product", "IdProductNavigation")
                        .WithMany("ProductVarients")
                        .HasForeignKey("IdProduct")
                        .HasConstraintName("FK__ProductVa__IdPro__46E78A0C");

                    b.Navigation("IdProductNavigation");
                });

            modelBuilder.Entity("ShopoesAPI.Models.RefreshToken", b =>
                {
                    b.HasOne("ShopoesAPI.Models.Account", "Account")
                        .WithOne("RefreshToken")
                        .HasForeignKey("ShopoesAPI.Models.RefreshToken", "AccountId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Account");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Review", b =>
                {
                    b.HasOne("ShopoesAPI.Models.Customer", "IdCustomerNavigation")
                        .WithMany("Reviews")
                        .HasForeignKey("IdCustomer")
                        .IsRequired()
                        .HasConstraintName("FK__Reviews__IdCusto__412EB0B6");

                    b.HasOne("ShopoesAPI.Models.Product", "IdProductNavigation")
                        .WithMany("Reviews")
                        .HasForeignKey("IdProduct")
                        .IsRequired();

                    b.Navigation("IdCustomerNavigation");

                    b.Navigation("IdProductNavigation");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Account", b =>
                {
                    b.Navigation("RefreshToken");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Address", b =>
                {
                    b.Navigation("Orders");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Brand", b =>
                {
                    b.Navigation("Products");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Category", b =>
                {
                    b.Navigation("Products");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Customer", b =>
                {
                    b.Navigation("Account");

                    b.Navigation("Addresses");

                    b.Navigation("Carts");

                    b.Navigation("Orders");

                    b.Navigation("Reviews");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Order", b =>
                {
                    b.Navigation("OrderDetails");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Product", b =>
                {
                    b.Navigation("ProductImages");

                    b.Navigation("ProductVarients");

                    b.Navigation("Reviews");
                });

            modelBuilder.Entity("ShopoesAPI.Models.ProductVarient", b =>
                {
                    b.Navigation("Carts");

                    b.Navigation("OrderDetails");
                });

            modelBuilder.Entity("ShopoesAPI.Models.Role", b =>
                {
                    b.Navigation("Customers");
                });
#pragma warning restore 612, 618
        }
    }
}
