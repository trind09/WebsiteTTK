CREATE TABLE [dbo].[Product](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](150) NOT NULL,
	[Description] [nvarchar](2000) NULL,
	[Status] [nvarchar](100) NOT NULL,
	[Publish] [bit] NOT NULL,
	[Images] [nvarchar](200) NULL,
	[RelativeProductIds] [int] NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Currency] [nchar](10) NOT NULL,
	[CreatedDate] [datetime] NOT NULL
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (1, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5''8" and chest 33") is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armani''s new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (2, N'White Blouse Armani 1', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (3, N'White Blouse Armani 2', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (4, N'White Blouse Armani 3', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (5, N'White Blouse Armani 4', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (6, N'White Blouse Armani 5', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (7, N'White Blouse Armani 6', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (8, N'White Blouse Armani 6', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (9, N'White Blouse Armani 4', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (10, N'White Blouse Armani 4', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (11, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (12, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (13, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (14, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (15, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (16, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (17, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (18, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (19, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (20, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (21, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (22, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (23, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (24, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (25, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (26, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (27, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (28, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (29, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (30, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (31, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (32, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (33, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (34, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (35, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (36, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (37, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (38, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (39, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (40, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (41, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (42, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (43, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (44, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (45, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (46, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (47, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (48, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (49, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (50, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (51, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (52, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (53, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (54, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (55, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Product] ([ID], [Title], [Description], [Status], [Publish], [Images], [RelativeProductIds], [Price], [Currency], [CreatedDate]) VALUES (56, N'White Blouse Armani', N'<p></p>
                <h4>Product details</h4>
                <p>White lace top, woven, has a round neck, short sleeves, has knitted lining attached</p>
                <h4>Material &amp; care</h4>
                <ul>
                  <li>Polyester</li>
                  <li>Machine wash</li>
                </ul>
                <h4>Size &amp; Fit</h4>
                <ul>
                  <li>Regular fit</li>
                  <li>The model (height 5.8 and chest 33) is wearing a size S</li>
                </ul>
                <blockquote>
                  <p><em>Define style this season with Armanis new range of trendy tops, crafted with intricate details. Create a chic statement look by teaming this lace number with skinny jeans and pumps.</em></p>
                </blockquote>
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="#" class="external facebook"><i class="fa fa-facebook"></i></a><a href="#" class="external gplus"><i class="fa fa-google-plus"></i></a><a href="#" class="external twitter"><i class="fa fa-twitter"></i></a><a href="#" class="email"><i class="fa fa-envelope"></i></a></p>
                </div>', N'Sale;New', 1, NULL, NULL, CAST(150000.00 AS Decimal(18, 2)), N'VND       ', CAST(N'2019-06-01 00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Product] OFF
USE [master]
GO
ALTER DATABASE [WebsiteTTK] SET  READ_WRITE 
GO
