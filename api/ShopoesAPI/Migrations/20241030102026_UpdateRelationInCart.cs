using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ShopoesAPI.Migrations
{
    /// <inheritdoc />
    public partial class UpdateRelationInCart : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Carts_Customers_IdCustomerNavigationId",
                table: "Carts");

            migrationBuilder.DropForeignKey(
                name: "FK_Carts_ProductVarients_IdProductVarientNavigationId",
                table: "Carts");

            migrationBuilder.DropIndex(
                name: "IX_Carts_IdCustomerNavigationId",
                table: "Carts");

            migrationBuilder.DropIndex(
                name: "IX_Carts_IdProductVarientNavigationId",
                table: "Carts");

            migrationBuilder.DropColumn(
                name: "IdCustomerNavigationId",
                table: "Carts");

            migrationBuilder.DropColumn(
                name: "IdProductVarientNavigationId",
                table: "Carts");

            migrationBuilder.CreateIndex(
                name: "IX_Carts_IdCustomer",
                table: "Carts",
                column: "IdCustomer");

            migrationBuilder.CreateIndex(
                name: "IX_Carts_IdProductVarient",
                table: "Carts",
                column: "IdProductVarient");

            migrationBuilder.AddForeignKey(
                name: "FK_Carts_Customers_IdCustomer",
                table: "Carts",
                column: "IdCustomer",
                principalTable: "Customers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Carts_ProductVarients_IdProductVarient",
                table: "Carts",
                column: "IdProductVarient",
                principalTable: "ProductVarients",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Carts_Customers_IdCustomer",
                table: "Carts");

            migrationBuilder.DropForeignKey(
                name: "FK_Carts_ProductVarients_IdProductVarient",
                table: "Carts");

            migrationBuilder.DropIndex(
                name: "IX_Carts_IdCustomer",
                table: "Carts");

            migrationBuilder.DropIndex(
                name: "IX_Carts_IdProductVarient",
                table: "Carts");

            migrationBuilder.AddColumn<int>(
                name: "IdCustomerNavigationId",
                table: "Carts",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "IdProductVarientNavigationId",
                table: "Carts",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Carts_IdCustomerNavigationId",
                table: "Carts",
                column: "IdCustomerNavigationId");

            migrationBuilder.CreateIndex(
                name: "IX_Carts_IdProductVarientNavigationId",
                table: "Carts",
                column: "IdProductVarientNavigationId");

            migrationBuilder.AddForeignKey(
                name: "FK_Carts_Customers_IdCustomerNavigationId",
                table: "Carts",
                column: "IdCustomerNavigationId",
                principalTable: "Customers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Carts_ProductVarients_IdProductVarientNavigationId",
                table: "Carts",
                column: "IdProductVarientNavigationId",
                principalTable: "ProductVarients",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
