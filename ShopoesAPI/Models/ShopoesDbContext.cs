using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace ShopoesAPI.Models;

public partial class ShopoesDbContext : DbContext
{
    public ShopoesDbContext()
    {
    }

    public ShopoesDbContext(DbContextOptions<ShopoesDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Account> Accounts { get; set; }

    public virtual DbSet<Address> Addresses { get; set; }

    public virtual DbSet<Brand> Brands { get; set; }

    public virtual DbSet<Category> Categories { get; set; }

    public virtual DbSet<Customer> Customers { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<OrderDetail> OrderDetails { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<RefreshToken> RefreshTokens { get; set; }

    public virtual DbSet<Review> Reviews { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Account>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Account__3214EC070761C792");

            entity.ToTable("Account");

            entity.Property(e => e.Id).ValueGeneratedOnAdd();
            entity.Property(e => e.Email).HasMaxLength(100);
            entity.Property(e => e.PasswordHash).HasDefaultValueSql("(0x)");
            entity.Property(e => e.PasswordSalt).HasDefaultValueSql("(0x)");

            entity.HasOne(d => d.IdNavigation).WithOne(p => p.Account)
                .HasForeignKey<Account>(d => d.Id)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Account__Id__4316F928");
        });

        modelBuilder.Entity<Address>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Addresse__3214EC07DE403D2C");

            entity.HasIndex(e => e.IdCustomer, "IX_Addresses_IdCustomer");

            entity.Property(e => e.City).HasMaxLength(50);
            entity.Property(e => e.District).HasMaxLength(50);
            entity.Property(e => e.Street).HasMaxLength(20);
            entity.Property(e => e.Ward).HasMaxLength(50);

            entity.HasOne(d => d.IdCustomerNavigation).WithMany(p => p.Addresses)
                .HasForeignKey(d => d.IdCustomer)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Addresses__IdCus__46E78A0C");
        });

        modelBuilder.Entity<Brand>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Brands__3214EC07D01411DF");

            entity.Property(e => e.NameBrand).HasMaxLength(50);
        });

        modelBuilder.Entity<Category>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Categori__3214EC07146654F8");

            entity.Property(e => e.Name).HasMaxLength(255);
        });

        modelBuilder.Entity<Customer>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Customer__3214EC071C3C1ADD");

            entity.HasIndex(e => e.IdRole, "IX_Customers_IdRole");

            entity.Property(e => e.Name).HasMaxLength(255);
            entity.Property(e => e.Phone).HasMaxLength(12);

            entity.HasOne(d => d.IdRoleNavigation).WithMany(p => p.Customers)
                .HasForeignKey(d => d.IdRole)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Customers__IdRol__44FF419A");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Orders__3214EC07D701579F");

            entity.HasIndex(e => e.IdCustomer, "IX_Orders_IdCustomer");

            entity.Property(e => e.Date).HasColumnType("datetime");
            entity.Property(e => e.Status)
                .HasMaxLength(255)
                .HasDefaultValue("BOOKED");

            entity.HasOne(d => d.IdCustomerNavigation).WithMany(p => p.Orders)
                .HasForeignKey(d => d.IdCustomer)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Orders__IdCustom__4222D4EF");
        });

        modelBuilder.Entity<OrderDetail>(entity =>
        {
            entity.HasKey(e => new { e.IdOrder, e.IdProduct }).HasName("PK__OrderDet__9167A4641D8B6ECD");

            entity.Property(e => e.ProductName).HasMaxLength(255);

            entity.HasOne(d => d.IdOrderNavigation).WithMany(p => p.OrderDetails)
                .HasForeignKey(d => d.IdOrder)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__OrderDeta__IdOrd__45F365D3");

            entity.HasOne(d => d.IdProductNavigation).WithMany(p => p.OrderDetails)
                .HasForeignKey(d => d.IdProduct)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__OrderDeta__IdPro__45F365D3");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Products__3214EC0763884365");

            entity.HasIndex(e => e.IdBrand, "IX_Products_IdBrand");

            entity.HasIndex(e => e.IdCategory, "IX_Products_IdCategory");

            entity.Property(e => e.ImageProduct).HasMaxLength(255);
            entity.Property(e => e.IsValid).HasDefaultValue(true);
            entity.Property(e => e.NameProduct).HasMaxLength(255);

            entity.HasOne(d => d.IdBrandNavigation).WithMany(p => p.Products)
                .HasForeignKey(d => d.IdBrand)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Products__IdBran__440B1D61");

            entity.HasOne(d => d.IdCategoryNavigation).WithMany(p => p.Products)
                .HasForeignKey(d => d.IdCategory)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Products__IdCate__403A8C7D");
        });

        modelBuilder.Entity<RefreshToken>(entity =>
        {
            entity.HasIndex(e => e.AccountId, "IX_RefreshTokens_AccountId").IsUnique();

            entity.HasOne(d => d.Account).WithOne(p => p.RefreshToken).HasForeignKey<RefreshToken>(d => d.AccountId);
        });

        modelBuilder.Entity<Review>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Reviews__3214EC07A6E4E31B");

            entity.HasIndex(e => e.IdCustomer, "IX_Reviews_IdCustomer");

            entity.Property(e => e.Content).HasMaxLength(255);
            entity.Property(e => e.Date).HasColumnType("datetime");

            entity.HasOne(d => d.IdCustomerNavigation).WithMany(p => p.Reviews)
                .HasForeignKey(d => d.IdCustomer)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Reviews__IdCusto__412EB0B6");
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Roles__3214EC0772513104");

            entity.Property(e => e.NameRole).HasMaxLength(50);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
