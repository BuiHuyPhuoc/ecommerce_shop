using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace ShopoesAPI.Models
{
    public partial class Cart
    {
        public int Id { get; set; }
        public int IdProductVarient { get; set; }
        public int IdCustomer {  get; set; }
        public int Quantity { get; set; }
        [JsonInclude]
        public virtual ProductVarient IdProductVarientNavigation { get; set; } = null!;
        [Required]
        [JsonIgnore]
        public virtual Customer IdCustomerNavigation { get; private set; }


    }
}
