using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace ShopoesAPI.Models;

public partial class ProductImage
{
    public int Id { get; set; }

    public int? IdProduct { get; set; }

    public string? ImageUrl { get; set; }
    [JsonIgnore]
    public virtual Product? IdProductNavigation { get; set; }
}
