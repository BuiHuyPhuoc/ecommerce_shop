using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ShopoesAPI.Migrations
{
    /// <inheritdoc />
    public partial class CreateCartTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Carts",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IdProduct = table.Column<int>(type: "int", nullable: false),
                    IdCustomer = table.Column<int>(type: "int", nullable: false),
                    Quantity = table.Column<int>(type: "int", nullable: false),
                    IdProductNavigationId = table.Column<int>(type: "int", nullable: false),
                    IdCustomerNavigationId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Carts", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Carts_Customers_IdCustomerNavigationId",
                        column: x => x.IdCustomerNavigationId,
                        principalTable: "Customers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Carts_Products_IdProductNavigationId",
                        column: x => x.IdProductNavigationId,
                        principalTable: "Products",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });
            migrationBuilder.CreateIndex(
                name: "IX_Carts_IdCustomerNavigationId",
                table: "Carts",
                column: "IdCustomerNavigationId");

            migrationBuilder.CreateIndex(
                name: "IX_Carts_IdProductNavigationId",
                table: "Carts",
                column: "IdProductNavigationId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Addresses");

            migrationBuilder.DropTable(
                name: "Carts");

            migrationBuilder.DropTable(
                name: "OrderDetails");

            migrationBuilder.DropTable(
                name: "ProductImages");

            migrationBuilder.DropTable(
                name: "ProductVarients");

            migrationBuilder.DropTable(
                name: "RefreshTokens");

            migrationBuilder.DropTable(
                name: "Reviews");

            migrationBuilder.DropTable(
                name: "Orders");

            migrationBuilder.DropTable(
                name: "Products");

            migrationBuilder.DropTable(
                name: "Account");

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
