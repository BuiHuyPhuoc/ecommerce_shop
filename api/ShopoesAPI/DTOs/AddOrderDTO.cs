using ShopoesAPI.Models;
using System.Text.Json.Serialization;

namespace ShopoesAPI.DTOs
{
    public class AddOrderCartDTO
    {
        public int Id { get; set; }
        public int IdProductVarient { get; set; }
        public int IdCustomer { get; set; }
        public int Quantity { get; set; }
        [JsonInclude]
        public virtual ProductVarient IdProductVarientNavigation { get; set; } = null!;
    }
}
