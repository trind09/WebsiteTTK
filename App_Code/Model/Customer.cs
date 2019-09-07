﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Customer
/// </summary>
public class Customer
{
    public AspNetUser AspNetUser { get; set; }
    public string Password { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Street { get; set; }
    public string City { get; set; }
    public string ZipCode { get; set; }
    public string Address { get; set; }
    public AspNetUserAddress AspNetUserAddress { get; set; }
    public string Birthday { get; set; }
    public string Email { get; set; }
    public string PhoneNumber { get; set; }
    public string[] Countries { get; set; }
}