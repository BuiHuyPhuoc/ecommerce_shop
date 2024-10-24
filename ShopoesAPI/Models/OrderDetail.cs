using System;
using System.Collections.Generic;

namespace ShopoesAPI.Models;

public partial class OrderDetail
{
    public int IdOrder { get; set; }

    public int IdProduct { get; set; }

    public string? ProductName { get; set; }

    public double? ProductPrice { get; set; }

    public double? SalePrice { get; set; }

    public int Quantity { get; set; }

    public virtual Order IdOrderNavigation { get; set; } = null!;

    public virtual Product IdProductNavigation { get; set; } = null!;
}
