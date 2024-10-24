﻿using System;
using System.Collections.Generic;

namespace ShopoesAPI.Models;

public partial class Role
{
    public int Id { get; set; }

    public string NameRole { get; set; } = null!;

    public virtual ICollection<Customer> Customers { get; set; } = new List<Customer>();
}
