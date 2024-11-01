using System.Text.Json.Serialization;

namespace ShopoesAPI.DTOs
{
    public class AddAddressDTO
    {
        public string ReceiverName { get; set; } = null!;

        public string ReceiverPhone { get; set; } = null!;

        public string City { get; set; } = null!;

        public string District { get; set; } = null!;

        public string Ward { get; set; } = null!;

        public string Street { get; set; } = null!;
    }
}
