using System;
using System.Collections.Generic;

namespace ShopoesAPI.Models;

public partial class Product
{
    public int Id { get; set; }

    public string NameProduct { get; set; } = null!;

    public string Description { get; set; } = null!;

    public double PriceProduct { get; set; }

    public double? NewPrice { get; set; }

    public int IdCategory { get; set; }

    public int IdBrand { get; set; }

    public string? ImageProduct { get; set; }

    public bool IsValid { get; set; }

    public virtual Brand IdBrandNavigation { get; set; } = null!;

    public virtual Category IdCategoryNavigation { get; set; } = null!;

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();
}
