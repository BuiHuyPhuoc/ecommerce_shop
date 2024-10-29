namespace ShopoesAPI.DTOs
{
    public class CustomerReturn
    {
        public string Email { get; set; } = string.Empty;
        public string Name { get; set; } = string.Empty;
        public string Phone { get; set; } = string.Empty;
        public string NameRole { get; set; } = string.Empty;
        public string? AvatarImageUrl { get; set; }
    }
}
