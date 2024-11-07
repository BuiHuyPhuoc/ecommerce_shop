using ShopoesAPI.Models;

namespace ShopoesAPI.DTOs
{
    public class OrderRequest
    {
        public List<int> IdCarts { get; set; }
        public string Status { get; set; }

    }
}
