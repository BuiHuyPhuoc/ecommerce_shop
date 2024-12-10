using ShopoesAPI.Models;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace ShopoesAPI.DTOs.Auth
{
    public class CustomerRegisterDTO
    {
        public string? Name { get; set; } = string.Empty;
        public string? Phone { get; set; } = string.Empty;
        public string? Email { get; set; } = string.Empty;
        public string? Password { get; set; } = string.Empty;
        public string? ConfirmPassword { get; set; } = string.Empty;

    }
}
