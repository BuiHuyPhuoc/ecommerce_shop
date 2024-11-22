using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ShopoesAPI.Migrations
{
    /// <inheritdoc />
    public partial class AddForeignkeyFromReviewToProduct : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "IX_Reviews_IdProduct",
                table: "Reviews",
                column: "IdProduct");

            migrationBuilder.AddForeignKey(
                name: "FK_Reviews_Products_IdProduct",
                table: "Reviews",
                column: "IdProduct",
                principalTable: "Products",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Reviews_Products_IdProduct",
                table: "Reviews");

            migrationBuilder.DropIndex(
                name: "IX_Reviews_IdProduct",
                table: "Reviews");
        }
    }
}
