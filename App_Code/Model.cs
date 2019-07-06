﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;

public partial class AspNetRole
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
    public AspNetRole()
    {
        this.AspNetUsers = new HashSet<AspNetUser>();
    }

    public string Id { get; set; }
    public string Name { get; set; }

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
    public virtual ICollection<AspNetUser> AspNetUsers { get; set; }
}

public partial class AspNetUser
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
    public AspNetUser()
    {
        this.AspNetUserClaims = new HashSet<AspNetUserClaim>();
        this.AspNetUserLogins = new HashSet<AspNetUserLogin>();
        this.AspNetRoles = new HashSet<AspNetRole>();
    }

    public string Id { get; set; }
    public string Email { get; set; }
    public bool EmailConfirmed { get; set; }
    public string PasswordHash { get; set; }
    public string SecurityStamp { get; set; }
    public string PhoneNumber { get; set; }
    public bool PhoneNumberConfirmed { get; set; }
    public bool TwoFactorEnabled { get; set; }
    public Nullable<System.DateTime> LockoutEndDateUtc { get; set; }
    public bool LockoutEnabled { get; set; }
    public int AccessFailedCount { get; set; }
    public string UserName { get; set; }

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
    public virtual ICollection<AspNetUserClaim> AspNetUserClaims { get; set; }
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
    public virtual ICollection<AspNetUserLogin> AspNetUserLogins { get; set; }
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
    public virtual ICollection<AspNetRole> AspNetRoles { get; set; }
}

public partial class AspNetUserAddress
{
    public int Id { get; set; }
    public string UserId { get; set; }
    public string Firstname { get; set; }
    public string Lastname { get; set; }
    public string Company { get; set; }
    public string Street { get; set; }
    public string City { get; set; }
    public string Country { get; set; }
    public string State { get; set; }
    public string Zip { get; set; }
    public Nullable<System.DateTime> Birthday { get; set; }
    public Nullable<bool> Gender { get; set; }
    public string PhoneNumber { get; set; }
    public string Email { get; set; }
    public string AddressType { get; set; }
}

public partial class AspNetUserClaim
{
    public int Id { get; set; }
    public string UserId { get; set; }
    public string ClaimType { get; set; }
    public string ClaimValue { get; set; }

    public virtual AspNetUser AspNetUser { get; set; }
}

public partial class AspNetUserLogin
{
    public string LoginProvider { get; set; }
    public string ProviderKey { get; set; }
    public string UserId { get; set; }

    public virtual AspNetUser AspNetUser { get; set; }
}

public partial class brand
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
    public brand()
    {
        this.products = new HashSet<product>();
    }

    public int brand_id { get; set; }
    public string brand_name { get; set; }
    public string brand_description { get; set; }
    public string images { get; set; }
    public Nullable<System.DateTime> create_date { get; set; }

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
    public virtual ICollection<product> products { get; set; }
}

public partial class C__MigrationHistory
{
    public string MigrationId { get; set; }
    public string ContextKey { get; set; }
    public byte[] Model { get; set; }
    public string ProductVersion { get; set; }
}

public partial class category
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
    public category()
    {
        this.products = new HashSet<product>();
    }

    public int category_id { get; set; }
    public string category_name { get; set; }
    public string category_description { get; set; }
    public string category_images { get; set; }
    public Nullable<System.DateTime> create_date { get; set; }
    public Nullable<int> parent_id { get; set; }
    public Nullable<bool> is_publish { get; set; }
    public Nullable<bool> is_menu { get; set; }

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
    public virtual ICollection<product> products { get; set; }
}

public partial class colour
{
    public int colour_id { get; set; }
    public string colour_name { get; set; }
    public string colour_description { get; set; }
    public Nullable<System.DateTime> create_date { get; set; }
}

public partial class customer
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
    public customer()
    {
        this.orders = new HashSet<order>();
    }

    public int customer_id { get; set; }
    public string first_name { get; set; }
    public string last_name { get; set; }
    public string phone { get; set; }
    public string email { get; set; }
    public string street { get; set; }
    public string city { get; set; }
    public string state { get; set; }
    public string zip_code { get; set; }
    public string address { get; set; }

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
    public virtual ICollection<order> orders { get; set; }
}

public partial class order
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
    public order()
    {
        this.order_items = new HashSet<order_items>();
    }

    public int order_id { get; set; }
    public Nullable<int> customer_id { get; set; }
    public byte order_status { get; set; }
    public System.DateTime order_date { get; set; }
    public System.DateTime required_date { get; set; }
    public Nullable<System.DateTime> shipped_date { get; set; }
    public int store_id { get; set; }
    public int staff_id { get; set; }

    public virtual customer customer { get; set; }
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
    public virtual ICollection<order_items> order_items { get; set; }
    public virtual staff staff { get; set; }
    public virtual store store { get; set; }
}

public partial class order_items
{
    public int order_id { get; set; }
    public int item_id { get; set; }
    public int product_id { get; set; }
    public int quantity { get; set; }
    public decimal list_price { get; set; }
    public decimal discount { get; set; }

    public virtual product product { get; set; }
    public virtual order order { get; set; }
}

public partial class product
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
    public product()
    {
        this.order_items = new HashSet<order_items>();
        this.stocks = new HashSet<stock>();
    }

    public int product_id { get; set; }
    public string product_name { get; set; }
    public string product_description { get; set; }
    public string product_images { get; set; }
    public int brand_id { get; set; }
    public int category_id { get; set; }
    public short model_year { get; set; }
    public decimal list_price { get; set; }
    public Nullable<System.DateTime> create_date { get; set; }
    public string create_by { get; set; }
    public Nullable<bool> is_publish { get; set; }
    public Nullable<bool> is_featured { get; set; }
    public Nullable<bool> is_sale { get; set; }
    public Nullable<bool> is_new { get; set; }
    public Nullable<bool> is_gift { get; set; }
    public Nullable<int> colour_id { get; set; }

    public virtual brand brand { get; set; }
    public virtual category category { get; set; }
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
    public virtual ICollection<order_items> order_items { get; set; }
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
    public virtual ICollection<stock> stocks { get; set; }
}

public partial class staff
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
    public staff()
    {
        this.orders = new HashSet<order>();
        this.staffs1 = new HashSet<staff>();
    }

    public int staff_id { get; set; }
    public string first_name { get; set; }
    public string last_name { get; set; }
    public string email { get; set; }
    public string phone { get; set; }
    public byte active { get; set; }
    public int store_id { get; set; }
    public Nullable<int> manager_id { get; set; }
    public string address { get; set; }

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
    public virtual ICollection<order> orders { get; set; }
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
    public virtual ICollection<staff> staffs1 { get; set; }
    public virtual staff staff1 { get; set; }
    public virtual store store { get; set; }
}

public partial class stock
{
    public int store_id { get; set; }
    public int product_id { get; set; }
    public Nullable<int> quantity { get; set; }

    public virtual product product { get; set; }
    public virtual store store { get; set; }
}

public partial class store
{
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
    public store()
    {
        this.stocks = new HashSet<stock>();
        this.orders = new HashSet<order>();
        this.staffs = new HashSet<staff>();
    }

    public int store_id { get; set; }
    public string store_name { get; set; }
    public string phone { get; set; }
    public string email { get; set; }
    public string street { get; set; }
    public string city { get; set; }
    public string state { get; set; }
    public string zip_code { get; set; }

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
    public virtual ICollection<stock> stocks { get; set; }
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
    public virtual ICollection<order> orders { get; set; }
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
    public virtual ICollection<staff> staffs { get; set; }
}
