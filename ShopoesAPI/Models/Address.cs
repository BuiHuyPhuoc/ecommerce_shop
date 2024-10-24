using System;
using System.Collections.Generic;

namespace ShopoesAPI.Models;

public partial class Address
{
    public int Id { get; set; }

    public int IdCustomer { get; set; }

    public string City { get; set; } = null!;

    public string District { get; set; } = null!;

    public string Ward { get; set; } = null!;

    public string Street { get; set; } = null!;

    public bool IsDefault { get; set; }

    public virtual Customer IdCustomerNavigation { get; set; } = null!;
}
