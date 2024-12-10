using System.ComponentModel.DataAnnotations;

namespace ShopoesAPI.DTOs.Auth
{
    public class ResetPasswordRequest
    {
        [Required]
        public required string Token { get; set; }
        [Required, MinLength(8, ErrorMessage = "Password has more than 8 characters.")]
        public required string Password { get; set; } = string.Empty;
        [Required, Compare("Password")]
        public required string ConfirmPassword { get; set; } = string.Empty;
    }
}
