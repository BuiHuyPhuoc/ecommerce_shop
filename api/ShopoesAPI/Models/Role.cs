using System;
using System.Collections.Generic;

using System.Text.Json.Serialization;
namespace ShopoesAPI.Models;

public partial class Role
{
    public int Id { get; set; }

    public string NameRole { get; set; } = null!;
    [JsonIgnore]
    public virtual ICollection<Customer> Customers { get; set; } = new List<Customer>();
}
