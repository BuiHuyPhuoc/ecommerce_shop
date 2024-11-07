using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ShopoesAPI.Migrations
{
    /// <inheritdoc />
    public partial class RelationOrderAndAddress : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "IdAddress",
                table: "Orders",
                type: "int",
                nullable: true,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Orders_IdAddress",
                table: "Orders",
                column: "IdAddress");

            migrationBuilder.AddForeignKey(
                name: "FK_Orders_Addresses_IdAddress",
                table: "Orders",
                column: "IdAddress",
                principalTable: "Addresses",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Orders_Addresses_IdAddress",
                table: "Orders");

            migrationBuilder.DropIndex(
                name: "IX_Orders_IdAddress",
                table: "Orders");

            migrationBuilder.DropColumn(
                name: "IdAddress",
                table: "Orders");
        }
    }
}
