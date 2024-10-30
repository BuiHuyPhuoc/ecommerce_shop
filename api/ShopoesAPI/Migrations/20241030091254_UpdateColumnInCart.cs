using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ShopoesAPI.Migrations
{
    /// <inheritdoc />
    public partial class UpdateColumnInCart : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Carts_Products_IdProductNavigationId",
                table: "Carts");

            migrationBuilder.RenameColumn(
                name: "IdProductNavigationId",
                table: "Carts",
                newName: "IdProductVarientNavigationId");

            migrationBuilder.RenameColumn(
                name: "IdProduct",
                table: "Carts",
                newName: "IdProductVarient");

            migrationBuilder.RenameIndex(
                name: "IX_Carts_IdProductNavigationId",
                table: "Carts",
                newName: "IX_Carts_IdProductVarientNavigationId");

            migrationBuilder.AddForeignKey(
                name: "FK_Carts_ProductVarients_IdProductVarientNavigationId",
                table: "Carts",
                column: "IdProductVarientNavigationId",
                principalTable: "ProductVarients",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Carts_ProductVarients_IdProductVarientNavigationId",
                table: "Carts");

            migrationBuilder.RenameColumn(
                name: "IdProductVarientNavigationId",
                table: "Carts",
                newName: "IdProductNavigationId");

            migrationBuilder.RenameColumn(
                name: "IdProductVarient",
                table: "Carts",
                newName: "IdProduct");

            migrationBuilder.RenameIndex(
                name: "IX_Carts_IdProductVarientNavigationId",
                table: "Carts",
                newName: "IX_Carts_IdProductNavigationId");

            migrationBuilder.AddForeignKey(
                name: "FK_Carts_Products_IdProductNavigationId",
                table: "Carts",
                column: "IdProductNavigationId",
                principalTable: "Products",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
