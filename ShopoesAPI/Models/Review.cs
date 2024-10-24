using System;
using System.Collections.Generic;

namespace ShopoesAPI.Models;

public partial class Review
{
    public int Id { get; set; }

    public int IdCustomer { get; set; }

    public int IdProduct { get; set; }

    public int Rating { get; set; }

    public string Content { get; set; } = null!;

    public DateTime Date { get; set; }

    public virtual Customer IdCustomerNavigation { get; set; } = null!;
}
