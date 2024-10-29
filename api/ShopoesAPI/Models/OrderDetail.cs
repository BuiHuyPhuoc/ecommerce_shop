using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace ShopoesAPI.Models;

public partial class OrderDetail
{
    private Order idOrderNavigation = null!;

    public int IdOrder { get; set; }

    public int IdProduct { get; set; }

    public string? ProductName { get; set; }

    public double? ProductPrice { get; set; }

    public double? SalePrice { get; set; }

    public int Quantity { get; set; }
    [JsonIgnore]
    public virtual Order IdOrderNavigation { get => idOrderNavigation; set => idOrderNavigation = value; }
    [JsonIgnore]
    public virtual Product IdProductNavigation { get; set; } = null!;
}
