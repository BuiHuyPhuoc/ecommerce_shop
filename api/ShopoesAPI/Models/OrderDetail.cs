using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace ShopoesAPI.Models;

public partial class OrderDetail
{
    [JsonIgnore]
    private Order idOrderNavigation = null!;

    public int IdOrder { get; set; }
    [Column("IdProductVarient")]
    public int IdProductVarient { get; set; }

    public string? ProductName { get; set; }

    public decimal? ProductPrice { get; set; }

    public decimal? SalePrice { get; set; }

    public int Quantity { get; set; }
    [JsonIgnore]
    public virtual Order IdOrderNavigation { get => idOrderNavigation; set => idOrderNavigation = value; }
    public virtual ProductVarient IdProductVarientNavigation { get; set; } = null!;
}
