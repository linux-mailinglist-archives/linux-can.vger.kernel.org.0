Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C89A66CFC4
	for <lists+linux-can@lfdr.de>; Mon, 16 Jan 2023 20:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjAPTtZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 16 Jan 2023 14:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjAPTtX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 Jan 2023 14:49:23 -0500
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2054.outbound.protection.outlook.com [40.107.135.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39D92CC60
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2023 11:49:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCVUsu4vjnN26He2xMVdR3JB1D0g4yxkLiVr24guUtWIA2xCx8AXuhjvKm4ME2sFx3Tv9l2DUGY8EkMo73OwKV0hyudYQNFQE7XhJRwERcH9YrZksaZsxLCjBqwa6sSUyEE/WtEfix8FYLsVev3m8j8XO8YWeyLtseWgE/riNeSKi+HBh8g1Jyf4C0g6MRWbGwIE7Zj2J2EMZR1FaQjV6BBwv5PV4mCKof4EZACF1Vo3a55w/SWNA3yTD52pYkmeEe0pwPXUEl4ZIhaJGV0gVUzZZkWSnUAYetxMLt/DIOFv2n20ao021BT+eUsu/pWSJCGtVAvN002mk6q/CURH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6gORYFhL/llLa7t3HOonLesPWdCsdbV/44qeKqMF9E=;
 b=CFbdo6qlSVAMDMZY1fbuL3F3+7ihjnDQOZxNqGY0nlBmaLU/Xzp8N4kGQ5B7Gp8Myiy7cCLswf1KcO/zz+4qS9Hq+dvbzujUwMd6Bu7nszcU9rJkwg0gdU04dX1tAdxhCZOa9wvjTffGoTKlplPylCNNBfA/0XgCeL17BffTc8cFFYaOr8WKdf7uUPDuPbyIheA7eTeii5lUyzTLYEc/+HArht5a33F8z5Sfiohcm0Iew4joqTu/CbIznfTTabam/45EVuSDOOP3OW90297uSRw+NHkRyzojClhuqYi8TAOGBkrNpnDxxyHjP/EViC6AFy6jWSq2FeR/2RjjY7u43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=janztec.com; dmarc=pass action=none header.from=janztec.com;
 dkim=pass header.d=janztec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janzag.onmicrosoft.de;
 s=selector1-janzag-onmicrosoft-de;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6gORYFhL/llLa7t3HOonLesPWdCsdbV/44qeKqMF9E=;
 b=B20FEc+QBJipyG/UHqABKhRDzxJ8n8nekFh0jZwa6SzfGx3XVNue0c4eKqiDLYBLwg8mr3daUqC4PDxEXOlrZ7e+pMe58S0yJc2ELOv4AzYC1rQ5Fr1M6btha5LouNkiSDqOBoDs3usSbhxotLUuXGQZX+BX1o3fZZkTIHaZxLM=
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:26::13)
 by BE1P281MB2982.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:4b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 19:49:18 +0000
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba]) by FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba%7]) with mapi id 15.20.6002.012; Mon, 16 Jan 2023
 19:49:18 +0000
From:   =?utf-8?B?U3RlZmFuIEFsdGjDtmZlcg==?= <Stefan.Althoefer@janztec.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        "kernel@pengutroniux.de" <kernel@pengutroniux.de>
Subject: AW: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Thread-Topic: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Thread-Index: AQHZJgsgtPZlzMMAzkyw+q4DrZcdvq6heDUQ
Date:   Mon, 16 Jan 2023 19:49:18 +0000
Message-ID: <FR0P281MB1966455B1F0ED61EBCE5702097C19@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
References: <20230111222042.1139027-1-mkl@pengutronix.de>
In-Reply-To: <20230111222042.1139027-1-mkl@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=janztec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB1966:EE_|BE1P281MB2982:EE_
x-ms-office365-filtering-correlation-id: 61e5e53a-535f-455d-9bfa-08daf7fac198
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lf7l1t0LkJXevtPsog135QUKAKQz/++YSD99KSHQ1DV6NoirjhIhdfva3JuBmp93LDDN5uZMY5v64I8Oor2GHAK/hZ8mYJo7t2ejfjqxCnzNCpExQipsMtVexvjurIv4hA1kV3iA68joMNMg9ZoS4kvP1hBsZlWOBvLGBqPDaLiPgRBTXydp5TS8Z9lWMRhJM9CjfSmYL/fURRTRiRqvwS9wblL+0Bk+3iMgj/2Rc1yM1aFGEC5szNdST/eUtOQWnSEA62q3CIoUKYRR5uAfmpTcIi/B/v+W8tWb3H80KAtUMifjmD5clbtXG1GOsqzmDGYaA9ANGPiTqQZaeRZ3n4ntjuBcjy0kVoAbZHMky4ZNQQz9gnhuI5e3GzNNeahBwGZ4phAhhuD4LsNCLGnI39DXQOZ5DwaH6Ia+wTNMD7VvzeTHG7PlCsETFD+kAF4kBY9amOPsK9vZ64epTQ9Tu+hZwquEhwA4Uai7OqbGwCrbNn+bb14KFy80OFudubAVrwIG24/chHZ2NdKw/vrZE8vKET8htXDeIFDuSkUAymxPzNzPRzQdlNz2MV4SGSnQQWO6tXoS5n+QI2Aznzgc2U6qe0KTKLHYhhX4sHSNdB8bi4s+iKbRPrzV0mWDYpUo4DZlP075auBjjsI8tcXb1+8BvR3igtL3nBdNQRbZh7sGT04AAC9ri35OdfX6VOADDquZCawBuP4bTO5Fy2h7DQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(346002)(39840400004)(136003)(451199015)(9686003)(85202003)(478600001)(41300700001)(38070700005)(38100700002)(71200400001)(66556008)(316002)(110136005)(54906003)(86362001)(85182001)(33656002)(66476007)(7696005)(186003)(66946007)(55016003)(26005)(76116006)(4326008)(5660300002)(6506007)(2906002)(83380400001)(66446008)(4744005)(64756008)(8936002)(8676002)(52536014)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODVFRHNLNGRxTzVnS1cyQTNYV0VTYWIvNGUxakJXOGZiU1RpaXdVSy9Oa3Nl?=
 =?utf-8?B?VkdxbVNGbE1vOTNhYURENzg3bzJsVVlELzRtSGhmVWlSRDhzUmVPRGxjd0NT?=
 =?utf-8?B?bFErdHJGT3cyNzY0Y1BMa3E2TDllWWh1SE9SWmx1VGxmMTRFbjMvUDVxUXFj?=
 =?utf-8?B?V2pWZVNqdGRHNGtOamZWbzdoZFUweit3cEs5R2Yvamo0NS9aWEkvYzk4RXNH?=
 =?utf-8?B?NFc0VWM5YTlTM2dDVWM0THJTUGg0WHR3L200UWFzYVdGdDJqMkwwRDVZTklF?=
 =?utf-8?B?cUxZSUx4dE1VcVJFUnhrTkNKQ0RWL0NYTnkwdlhpVlpiVkFmc3loNnlQeXRZ?=
 =?utf-8?B?Y1FncDYyS1JpeFNpT1ZXZWJLR1ZVa0g1VEdNYTA0M05oSjJmS2w5ck0xZ2lB?=
 =?utf-8?B?dXRiNXFkVktjKytLZjlHWmVJTXNhS2ppenR5VzdDTllIQm45ODlYL2VLUHNG?=
 =?utf-8?B?aXZFcWpUUXl5SjdPdHUyWjJGZ0J6WEN5cUxDSUI4TnlieDBpQVNxQkl3QTJl?=
 =?utf-8?B?VW5NS0x2TVpFSU5nLzFwdjVwazlrNGFYOXNsRzhoZkZMYmNRMDh2dFJNOUZw?=
 =?utf-8?B?VFdXZHJjZEM1YzFybzRIeUpLUnlBYTM3bDR5UWRkNTNVZk84VXArSUZpTXBH?=
 =?utf-8?B?bFdFTjhuZHgxTHpPSWY1Z0ZRMXFESkxRQkNuenMzN2s0TVlVV2ZCZ2Y0SHVT?=
 =?utf-8?B?RDBCNTUzeGVpNVVENURxSStMNjRJVS9VelBRZkFtRG4ycjBBaFU4ZUY1Zm1o?=
 =?utf-8?B?c1JKS1NHc3lBY0dpSWdRbmhxbHJRY283TnIvam5Yb0o5NHlVZUIyV25wNlJr?=
 =?utf-8?B?K3orR29aSlJ0L2JqbVZmOWZpZkR4VFFwNjVUQnRNWTBTS3QwbmZIalJ1WGhG?=
 =?utf-8?B?UW1RMDk0aCsrL0JJWmx4S1cxcHlCV2ZnZytqbmgyWGsyTWdrcnFJdHVMMVdD?=
 =?utf-8?B?bWp5eWZlNWdVRkJreS8zczB5d1I2NXB5aTZkRVJ0K1YzdUtBdk9VTk01cUwv?=
 =?utf-8?B?OXRKdWNXbVhGY3I2d2NGazMxN1NkUUI5dVpPM0VtbjdNUHN6bkk3dUw3N3No?=
 =?utf-8?B?ZTVmVm5IK3o5bGpjZml1bWltclF0ODg5MUNiZStMdlNScWprSFBsNUczMkgr?=
 =?utf-8?B?Vkh2RkF1MUJtRUc5WjR0dTRpZUc2RmJrdFRxUGJTRDZWaVJrNWxyK1Z1L2FW?=
 =?utf-8?B?cUU2Nk4wbkFYSEVuYmdiNTZlby82d0wyN0I4RjVHVitjbXlEVVpNS2UwenA3?=
 =?utf-8?B?Vkl4NWw0WjBCZWlRZjlwbkhpemdHZERaYkNXbC8rdDlYVFBVd2dLdStiZXlY?=
 =?utf-8?B?UHNQMC9MWWo1bTUrR2tSTnJtdm9HRzJEOE83VEFueks5akxpa0RiUVhYbkpJ?=
 =?utf-8?B?YTloUVlXVjJCZEFHTXFhUE5NQ3drcklDMHppb2E4YlJmUmVRR3BZZUNnUHB0?=
 =?utf-8?B?bmhZa1RtU1dQa1BNTTZXdExZQWZYcDh0MXFON1M4cmo4ZXFoOEhVdTN2RDJ0?=
 =?utf-8?B?Qm1tS0dLQzlxanZrMkZmSHFNQ09pUDM3cFhCMFlRUFNGVTFjRHc1UHgrOHBl?=
 =?utf-8?B?Vk9HVjJtNE9KM1Ewakw2a3dZSjUwWldJSjE2Uyt1aVgxZW1CTGlQR0tSVkU0?=
 =?utf-8?B?VHpYa0I2bW5OYXJ5M1IzQ0pzRFA1TGVWcjhiUGRzWmtwRjRlL1JKdzdyN1BY?=
 =?utf-8?B?NlExak5vSnBiZlY3aTdIT1JmTWpNWnRGRmFYaWpDVnh0cnlsN0pIVzd0eTA3?=
 =?utf-8?B?K3h4d1R6ZHBrRlJSTytxQUpvMG94S1grR0N3VUhLVHhlTDMxenoxK0dUM09Y?=
 =?utf-8?B?NWVsaHlzZ2cxcHJJK1R2aEtiL3U1S0tZb0R4TzArZkk4Ylh0Z3JjMUc3V0o2?=
 =?utf-8?B?SjJOZUpHUkZBeTJnU0pkdzVYZEZiWmpDNTBGSWtnaHdZT2EzVy9jTjBRYlRK?=
 =?utf-8?B?N1c5NXIxa2Y1Sko3SzJPN3Y0akpQdER6UTBRc01TbjhPZDlsNE1NNDhFMTlI?=
 =?utf-8?B?RDlhYTJ4cFcyVlM2dEE1cVZDNEJtT1kzdVNhbG1xbENjWUxIcVN6dzE4eE5V?=
 =?utf-8?B?UCtNeUcxc0swdHIyeHNROStDN0hQYk5tN3RGbkZVcHRzVlphb0hpeGFqT21Z?=
 =?utf-8?B?dUx4R0hLVVNRcDZpdjF2dlhtRmN1aWlVYWU4eUwyZWNabDZBMFVON2cvZko3?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: janztec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e5e53a-535f-455d-9bfa-08daf7fac198
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 19:49:18.7922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c1dae847-7bcf-493f-b143-af65743cbb23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJGvp5+wzWplYsEXrYZz1uS8cqpf9VtLJS4fCkf/GHhSXyUshDL3QfSMCenn4guAiwxe76MKW7XsneA1XvHwpDyDY6jXFWNb80XlnIZtxrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2982
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGksDQoNCj4gV2l0aCB0aGUgaGVscCBvZiBUaG9tYXMgd2UgZm91bmQgb3V0IHRoYXQgdGhlIGNo
aXAgaGFzIGEgdGltZSB3aW5kb3cgYWZ0ZXIgcmVjZWl2aW5nIGEgQ0FOIGZyYW1lIHdoZXJlIHRo
ZSBSWCBGSUZPIFNUQSByZWdpc3RlciBjb250ZW50IGlzIG5vdCByZWFkIGNvcnJlY3RseS4NCg0K
RG9lcyB0aGUgd29ya2Fyb3VuZCBhc3N1bWUgdGhhdCBtb3N0IG9mIHRoZSBtZXNzYWdlcyBpbiB0
aGUgZmlmbyBhcmUgb2xkIChhbHJlYWR5IHJlYWQpIGNvbnRlbnQ/IFdoYXQgaGFwcGVucyBpZiB0
aGVyZSBpcyBtb3N0bHkgbmV3IChub3QgeWV0DQpyZWFkKSBjb250ZW50IGluIHRoZSBmaWZvPyBT
dXBwb3NlIGEgc2xvdyBob3N0IG9yIGNvYWxlc2NpbmcuIENhbiB0aGUgdGVtcG9yYXJpbHkgaW5j
b3JyZWN0IFJYIEZJRk8gU1RBIHJlZ2lzdGVyIHBvaW50IHRvIG9uZSBvZiB0aG9zZSAoYWhlYWQg
b2YgbmV4dC10by1yZWFkKT8gDQpXb3VsZG4ndCB3ZSBkcm9wIG1lc3NhZ2VzIG9yIGNhdXNlIGEg
ZGVhZGxvY2sgdGhlbj8NCg0KLS0NClN0ZWZhbg0K
