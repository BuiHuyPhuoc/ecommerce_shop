using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace ShopoesAPI.Models;

public partial class Customer
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public int IdRole { get; set; }

    public string? AvatarImageUrl { get; set; }

    [JsonIgnore]
    public virtual Account? Account { get; set; }
    [JsonIgnore]
    public virtual ICollection<Address> Addresses { get; set; } = new List<Address>();

    public virtual Role IdRoleNavigation { get; set; } = null!;

    [JsonIgnore]
    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    [JsonIgnore]
    public virtual ICollection<Review> Reviews { get; set; } = new List<Review>();

    [JsonIgnore]
    public virtual ICollection<Cart> Carts { get; set; } = new List<Cart>();
}
