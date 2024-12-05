using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ShopoesAPI.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreatee : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Brands",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NameBrand = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Brands__3214EC07D01411DF", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Categories",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Categori__3214EC07146654F8", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Roles",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NameRole = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Roles__3214EC0772513104", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Products",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NameProduct = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PriceProduct = table.Column<decimal>(type: "money", nullable: false),
                    NewPrice = table.Column<decimal>(type: "money", nullable: true),
                    IdCategory = table.Column<int>(type: "int", nullable: false),
                    IdBrand = table.Column<int>(type: "int", nullable: false),
                    ImageProduct = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    IsValid = table.Column<bool>(type: "bit", nullable: false, defaultValue: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Products__3214EC0763884365", x => x.Id);
                    table.ForeignKey(
                        name: "FK__Products__IdBran__440B1D61",
                        column: x => x.IdBrand,
                        principalTable: "Brands",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK__Products__IdCate__403A8C7D",
                        column: x => x.IdCategory,
                        principalTable: "Categories",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Customers",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    Phone = table.Column<string>(type: "nvarchar(12)", maxLength: 12, nullable: false),
                    IdRole = table.Column<int>(type: "int", nullable: false),
                    AvatarImageUrl = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Customer__3214EC071C3C1ADD", x => x.Id);
                    table.ForeignKey(
                        name: "FK__Customers__IdRol__44FF419A",
                        column: x => x.IdRole,
                        principalTable: "Roles",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ProductImages",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IdProduct = table.Column<int>(type: "int", nullable: true),
                    ImageUrl = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__ProductI__3214EC073159DAF9", x => x.Id);
                    table.ForeignKey(
                        name: "FK__ProductIm__IdPro__4CA06362",
                        column: x => x.IdProduct,
                        principalTable: "Products",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ProductVarients",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IdProduct = table.Column<int>(type: "int", nullable: true),
                    Size = table.Column<int>(type: "int", nullable: false),
                    InStock = table.Column<int>(type: "int", nullable: false),
                    IsValid = table.Column<bool>(type: "bit", nullable: true, defaultValue: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__ProductV__3214EC07D12EAD3F", x => x.Id);
                    table.ForeignKey(
                        name: "FK__ProductVa__IdPro__46E78A0C",
                        column: x => x.IdProduct,
                        principalTable: "Products",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Account",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    IdCustomer = table.Column<int>(type: "int", nullable: false),
                    PasswordHash = table.Column<byte[]>(type: "varbinary(max)", nullable: false, defaultValueSql: "(0x)"),
                    PasswordResetToken = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PasswordSalt = table.Column<byte[]>(type: "varbinary(max)", nullable: false, defaultValueSql: "(0x)"),
                    ResetTokenExpires = table.Column<DateTime>(type: "datetime2", nullable: true),
                    VerificationToken = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    VerifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Account__3214EC070761C792", x => x.Id);
                    table.ForeignKey(
                        name: "FK__Account__Id__4316F928",
                        column: x => x.Id,
                        principalTable: "Customers",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Addresses",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IdCustomer = table.Column<int>(type: "int", nullable: false),
                    ReceiverName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ReceiverPhone = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    City = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    District = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Ward = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Street = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    IsDefault = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Addresse__3214EC07DE403D2C", x => x.Id);
                    table.ForeignKey(
                        name: "FK__Addresses__IdCus__46E78A0C",
                        column: x => x.IdCustomer,
                        principalTable: "Customers",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Reviews",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IdCustomer = table.Column<int>(type: "int", nullable: false),
                    IdProduct = table.Column<int>(type: "int", nullable: false),
                    Rating = table.Column<int>(type: "int", nullable: false),
                    Content = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    Date = table.Column<DateTime>(type: "datetime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Reviews__3214EC07A6E4E31B", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Reviews_Products_IdProduct",
                        column: x => x.IdProduct,
                        principalTable: "Products",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK__Reviews__IdCusto__412EB0B6",
                        column: x => x.IdCustomer,
                        principalTable: "Customers",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Carts",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IdProductVarient = table.Column<int>(type: "int", nullable: false),
                    IdCustomer = table.Column<int>(type: "int", nullable: false),
                    Quantity = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Carts", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Carts_Customers_IdCustomer",
                        column: x => x.IdCustomer,
                        principalTable: "Customers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Carts_ProductVarients_IdProductVarient",
                        column: x => x.IdProductVarient,
                        principalTable: "ProductVarients",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "RefreshTokens",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Token = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Expires = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Created = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Revoked = table.Column<DateTime>(type: "datetime2", nullable: true),
                    AccountId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RefreshTokens", x => x.Id);
                    table.ForeignKey(
                        name: "FK_RefreshTokens_Account_AccountId",
                        column: x => x.AccountId,
                        principalTable: "Account",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Orders",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Date = table.Column<DateTime>(type: "datetime", nullable: false),
                    IdCustomer = table.Column<int>(type: "int", nullable: false),
                    IdAddress = table.Column<int>(type: "int", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false, defaultValue: "BOOKED"),
                    Amount = table.Column<decimal>(type: "decimal(18,2)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Orders__3214EC07D701579F", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Orders_Addresses_IdAddress",
                        column: x => x.IdAddress,
                        principalTable: "Addresses",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK__Orders__IdCustom__4222D4EF",
                        column: x => x.IdCustomer,
                        principalTable: "Customers",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "OrderDetails",
                columns: table => new
                {
                    IdOrder = table.Column<int>(type: "int", nullable: false),
                    IdProductVarient = table.Column<int>(type: "int", nullable: false),
                    ProductName = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    ProductPrice = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    SalePrice = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Quantity = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OrderDetails", x => new { x.IdOrder, x.IdProductVarient });
                    table.ForeignKey(
                        name: "FK_OrderDetails_ProductVarients_IdProductVarient",
                        column: x => x.IdProductVarient,
                        principalTable: "ProductVarients",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK__OrderDeta__IdOrd__45F365D3",
                        column: x => x.IdOrder,
                        principalTable: "Orders",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Addresses_IdCustomer",
                table: "Addresses",
                column: "IdCustomer");

            migrationBuilder.CreateIndex(
                name: "IX_Carts_IdCustomer",
                table: "Carts",
                column: "IdCustomer");

            migrationBuilder.CreateIndex(
                name: "IX_Carts_IdProductVarient",
                table: "Carts",
                column: "IdProductVarient");

            migrationBuilder.CreateIndex(
                name: "IX_Customers_IdRole",
                table: "Customers",
                column: "IdRole");

            migrationBuilder.CreateIndex(
                name: "IX_OrderDetails_IdProductVarient",
                table: "OrderDetails",
                column: "IdProductVarient");

            migrationBuilder.CreateIndex(
                name: "IX_Orders_IdAddress",
                table: "Orders",
                column: "IdAddress");

            migrationBuilder.CreateIndex(
                name: "IX_Orders_IdCustomer",
                table: "Orders",
                column: "IdCustomer");

            migrationBuilder.CreateIndex(
                name: "IX_ProductImages_IdProduct",
                table: "ProductImages",
                column: "IdProduct");

            migrationBuilder.CreateIndex(
                name: "IX_Products_IdBrand",
                table: "Products",
                column: "IdBrand");

            migrationBuilder.CreateIndex(
                name: "IX_Products_IdCategory",
                table: "Products",
                column: "IdCategory");

            migrationBuilder.CreateIndex(
                name: "IX_ProductVarients_IdProduct",
                table: "ProductVarients",
                column: "IdProduct");

            migrationBuilder.CreateIndex(
                name: "IX_RefreshTokens_AccountId",
                table: "RefreshTokens",
                column: "AccountId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Reviews_IdCustomer",
                table: "Reviews",
                column: "IdCustomer");

            migrationBuilder.CreateIndex(
                name: "IX_Reviews_IdProduct",
                table: "Reviews",
                column: "IdProduct");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Carts");

            migrationBuilder.DropTable(
                name: "OrderDetails");

            migrationBuilder.DropTable(
                name: "ProductImages");

            migrationBuilder.DropTable(
                name: "RefreshTokens");

            migrationBuilder.DropTable(
                name: "Reviews");

            migrationBuilder.DropTable(
                name: "ProductVarients");

            migrationBuilder.DropTable(
                name: "Orders");

            migrationBuilder.DropTable(
                name: "Account");

            migrationBuilder.DropTable(
                name: "Products");

            migrationBuilder.DropTable(
                name: "Addresses");

            migrationBuilder.DropTable(
                name: "Brands");

            migrationBuilder.DropTable(
                name: "Categories");

            migrationBuilder.DropTable(
                name: "Customers");

            migrationBuilder.DropTable(
                name: "Roles");
        }
    }
}
