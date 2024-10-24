using System;
using System.Collections.Generic;

namespace ShopoesAPI.Models;

public partial class RefreshToken
{
    public int Id { get; set; }

    public string Token { get; set; } = null!;

    public DateTime Expires { get; set; }

    public DateTime Created { get; set; }

    public DateTime? Revoked { get; set; }

    public int AccountId { get; set; }

    public virtual Account Account { get; set; } = null!;
}
