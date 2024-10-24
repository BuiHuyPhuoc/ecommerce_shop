using System;
using System.Collections.Generic;

namespace ShopoesAPI.Models;

public partial class Account
{
    public int Id { get; set; }

    public string Email { get; set; } = null!;

    public int IdCustomer { get; set; }

    public byte[] PasswordHash { get; set; } = null!;

    public string? PasswordResetToken { get; set; }

    public byte[] PasswordSalt { get; set; } = null!;

    public DateTime? ResetTokenExpires { get; set; }

    public string? VerificationToken { get; set; }

    public DateTime? VerifiedAt { get; set; }

    public virtual Customer IdNavigation { get; set; } = null!;

    public virtual RefreshToken? RefreshToken { get; set; }
}
