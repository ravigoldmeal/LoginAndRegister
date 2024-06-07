using LoginAndRegister;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.SqlClient;

[Serializable]
public class Book
{
    public int BookID { get; set; }


    public string Title { get; set; }


    public string Author { get; set; }


    public string Genre { get; set; }

    public DateTime PublicationDate { get; set; }

    public bool IsPopular { get; set; }

    public int RackNo { get; set; }


    public string BookImage { get; set; }


    public int Quantity { get; set; }


    public int MaximumDays { get; set; }


   


}

