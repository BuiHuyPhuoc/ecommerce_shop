using System.ComponentModel.DataAnnotations;

namespace ShopoesAPI.DTOs
{
    public class UserLoginRequest
    {
        public string Email { get; set; } = string.Empty;
        
        public string Password { get; set; } = string.Empty;
        
    }
}
