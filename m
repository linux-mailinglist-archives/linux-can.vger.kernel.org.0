Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E579F392859
	for <lists+linux-can@lfdr.de>; Thu, 27 May 2021 09:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhE0HS7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 27 May 2021 03:18:59 -0400
Received: from mail-vi1eur05on2075.outbound.protection.outlook.com ([40.107.21.75]:7777
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229579AbhE0HS6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 27 May 2021 03:18:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCDDNOS+iipYjuUZ2RjVHYs82M6SL5sybEcMR4o/uRsNOxeo4c3pxtBXUt1XN2qVptvhZBXxbTh3VJ7TVO3w0nCoSka0WYqXNxtKKvu3nLOCMFmkGzBzhdIONPLOCGj5oLFusBObabx/q8Bwtn5upzSbveGcnkMOA21qfdKpu40I3JYuaxcG/SiulauXAPwG+y+5Stw+7oQMlgi5EJkWsRBsByKhI0fhuY9dbiWxWBfHjNrnTQ6edXJQx/XjJP/ABsyjr4xjr3T1iAZBBSEAPOOKNqOlj5edgVZHILC1ZRJrT/fZSFCMapzAbPKnczP4OlGq2nj5EijQCyOUb3ITPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9UVH5e/I+Ogg85DJdsud8V7/UJRqWdy7XViL9Bl9oY=;
 b=LB+o7+nKquDM+IvYiAgZo4exLN6vh42mokE37Ll8FKU1YIdxTnFDMSolKZphiX8S0gvCgdaZmYFVozKOwKKgLDuNWFxSh8cUHlY2GaQqcppKaqq/6mHN1m2NIdglTVsbauSddh7VtMbqumJAfAWAZYcaJm9gLk7YpauDzmPs7Qa1mJ/xVDLq5XphWsBrLOZTUNDuFUqfXD2DMo37fkfh+nWLN7rlrKOYcWTn7+rw8ngCpErk1Tw0WYH3gKBZPz9WXZT7+eitixzzAipENsPVB/gYy/JuUSNIYtAbMmVQOxeGm+MrG+Vn3VJKnbOUDLKT0IFXsFfUy+yyHFOodeIwDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9UVH5e/I+Ogg85DJdsud8V7/UJRqWdy7XViL9Bl9oY=;
 b=jInHxCgEKISquRylTA/YlCIWekHb/hhlJyg6iIJAZUJ17JnvAy79ckmta4c/fnvWDZ5Z+yUVJdYJ5UMgTJpyYdnF5WQZqxKB4zJWdq0EfuXbXtD5ve8XZL7liuMWjJMAgxWDHOhdqJ3ALOPRRBeXRPMMQtIdrsVKtqppawZZhrM=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB5499.eurprd04.prod.outlook.com (2603:10a6:10:8b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 07:17:23 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3400:b139:f681:c8cf]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3400:b139:f681:c8cf%9]) with mapi id 15.20.4150.027; Thu, 27 May 2021
 07:17:23 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: RE: [PATCH] can: raw: fix TX CAN frames show up as RX'ed ones
Thread-Topic: [PATCH] can: raw: fix TX CAN frames show up as RX'ed ones
Thread-Index: AQHXRck3t2CqTpI3kkW43+O6vZjBkKr3BCgQ
Date:   Thu, 27 May 2021 07:17:22 +0000
Message-ID: <DB8PR04MB6795656CDFC5D021E9FA7D19E6239@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210510182038.1528631-1-mkl@pengutronix.de>
In-Reply-To: <20210510182038.1528631-1-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 784c5abd-7ad8-4b51-7dcd-08d920df7916
x-ms-traffictypediagnostic: DB7PR04MB5499:
x-microsoft-antispam-prvs: <DB7PR04MB549914BCAF315B2B68D87FDEE6239@DB7PR04MB5499.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cvVNFG3jIF5Jj2WZAToT1IHSdajJn5nWzPNQKH+9Ms9bPszd9hyTXpZKdxbK+IwkOSQk86BgdNEWwIVmQPCvi7umK5MFKJ0D8jG8Ghnp40q0GlzJdVD/IZJhJhwjETfWNMp8mM9MTeFebtkwnYf5eEyIBgPlrOKfxP7Sx/5FecYwoMwnmjbEXYCkV4aezKkr95MfUgE3b6e+QsNQ0jRfd1lz0jkmA3LRdn5TBdKKXI+geX5CFC0Y1hMFI7vXXE/bwXkguul2OHTxPu08QfqLJke6sTWgw1DJ9LOrGB8w0XzQXs69C9qiKjh/MBCvZxT2sGASPvWqRGPCg4x1lbsflvp5zYEZ/pTGmFtlDsQikhFpiWSkHQ7e6WIbH/mqRVVYG/QyMwNF7E9D0GMN1Vpv12Am4mwPVFxpp6s1JjeMV7mcaY2PGT5XOWG8tfZ5MX6EJELJcL1lguNvVhtnlCFJQogjrYZ9WMJs4h4JmX5K4Bhx0fIFrMOTOuopEFnVNFEpukJLQ68lKpks/+uLckW3AP17EPfpv/6MUudTnZ0L6SxfsAlylpmubeMiRKtRprITLOhQcbFNOHn+7mSQT8jUAKMhaCQ3VLJ9zh3PNKJP8OE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(33656002)(9686003)(110136005)(316002)(478600001)(26005)(122000001)(5660300002)(38100700002)(52536014)(2906002)(83380400001)(8936002)(7696005)(86362001)(71200400001)(4326008)(55016002)(53546011)(8676002)(66476007)(66556008)(66446008)(66946007)(64756008)(6506007)(186003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?Nng4U3dDTzRDamRUU3hmLzZEUnZLaU9MZWMyQzMrNGMxT0xTNzNCTGxoMnZM?=
 =?gb2312?B?T1BWd0VpYnl4aHpkMDdtbXdPR1IyektwN0JTd3g0Y091dVlYN2hCWTJaVFRB?=
 =?gb2312?B?K1orNXQ2RzVUbE5YNCtPZWJzb2ZUaXFmYkZLd1c3TXJ3VTI3ZE5YWmF0REdv?=
 =?gb2312?B?citCeHVkODlDZXhSNkFLVVR6S3VRZG1IbjIybmljL09QN1Q0aEtSSWE4aENn?=
 =?gb2312?B?ak16UFduZE5KazIwdy9QalUxc0p0eEVQNjY0dGlsaGFqczNnaVVNM29tTmJX?=
 =?gb2312?B?K2pqdnpSbUtScm84Qko5TVlrVEdsRDJSSDEraTJNcmRNNnEzajFqejBWbFpX?=
 =?gb2312?B?MHNDMDFmbVU5Q0J2cGJrL2pxS0dxL2NiQmxqVEpFbEVRY0U1WFl3b3VvMzh4?=
 =?gb2312?B?NzJvdDYrcmpzV0JJUTd1Y0hGZzFpT0pENDB4Smw1Q3JRN3pIcm9BR0xBR3Jm?=
 =?gb2312?B?VXZobkNiYXhGQXNLRkpnSkkyMlNaUGpIRG9STktkK2g0b0xPaGtQNW9adzNm?=
 =?gb2312?B?ejc4Qkx5bWwvMCtLWVpqVGhLM3M2N3k5ZDhlVDE2UHJ6emw1UXF6L3l1d29P?=
 =?gb2312?B?Qnh6RzZVUGczTFgxeWcxc3VwR3RsQXcvRzdiT3V6VHQyNTRvNlNmTzJTS3VL?=
 =?gb2312?B?bVdvMDhqUStYSS8reFZTaC8xamlYa2RWTkxXV0xkdGFUSzFaa2tHMGZsQkQx?=
 =?gb2312?B?WS9xMVZXSC9sN04rcndZL1BlUnhoNTJOQ1I0V2JuQ0hqcU90bk5TV3QwQlJ5?=
 =?gb2312?B?TkVtTDVmVXdFNmhVSTM4ZjZNamJ3VHI5cGFsa2RBV1kvOXZ3WnY2YjdUdnZS?=
 =?gb2312?B?bzkwYnJpdzF4WDRaUzhJeUwwUTlFWStiOGRkb3BHSmZ1eWFQL29tTTNkZThl?=
 =?gb2312?B?ZWEzb1IxcDljY3BFc08wbEY4aHFSYks1bW5wVTFiN0lLM2FUZnM1UVNGZXdB?=
 =?gb2312?B?UGZqRTQ0RVZoSEpVV3NNanpodHJSY2xkdFptRzVETDNwOWtXZURmenQvZzBX?=
 =?gb2312?B?TGR0THhBR2E2YVNISDZMUUlYN0VXTFljYjhRS3k1N2xKZWljLzVUTWZXWHZY?=
 =?gb2312?B?NWgwdTFQcXJZQWJ6bU5UUWl4Nkx0cDVlb0lKN2lqLzROWHNjeVhDTWJpQnZp?=
 =?gb2312?B?NFRnZUVvRjlEQUI5WFk4dldxOTRYa1p5TTNkcGE1ckkzNU9xQ0hzdllYeFJs?=
 =?gb2312?B?eTA0eEdyWVZHUmhIaFMxenVqT01tQWhienB6WVhKa21qOERRbXVVcHRsSUts?=
 =?gb2312?B?VGpQN3kwZTNNSi8wM3A0d1BuWVVKcDNvbCtyVWo1b2w2YTlpQUhSTU9oUTB1?=
 =?gb2312?B?VHd0Vy9tV1lRL1NmYlRDTHFrbUFZVlNaZXhIWlZDYXMwL0dWOFJLVk9lZlZt?=
 =?gb2312?B?aFJhVGxaWWdJMndpL2FnUFl4VU9XVHk4Y0kxelpvMFFyMy9PbUtxRFJzU0ZN?=
 =?gb2312?B?c1NSY1Z1cXBRNGs1alZienhrNmlqK0NBNnoxcU4vbjdaQnFsNnoyeE0rMnZS?=
 =?gb2312?B?bFdtY3BRVlpyamtlU3NKNDNoT3k5RHYvanpzVHREdTM3MXZPRng2UkNaL0cz?=
 =?gb2312?B?NjgwaW5DeWZ4WHBXaUtCSGNVazEvQldDTzVuMGVIUFN3ajlQUVExN213N0or?=
 =?gb2312?B?QUFvWWVpUU4wak9MdWVVejRvVWdCa1Jta2R0VStyU3dlLzgydlhXeUdENU1L?=
 =?gb2312?B?c0cxa0Q0LzVhNVAvWE5sMExFZXY4R3hDV0x3dkpmNHpjRG5SdWdhN0UrSGFX?=
 =?gb2312?Q?HcAskIU7nAcym1O7LTRcDnOuao/e+ea4xykWJiO?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 784c5abd-7ad8-4b51-7dcd-08d920df7916
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 07:17:23.0032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxUPltMTqNz5Xs1XEsfg2TxHnfNuT9AKyTojJm1M1hE+P5J0kBtu3FXf04Z4ftUW9xiHzkEnrNcFQUQZGFM+ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5499
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQpIaSBNYXJjLA0KDQpJIGhhdmUgbm90IHNlZW4gdGhpcyBwYXRjaCBpbiBsaW51eC1jYW4gcmVw
bywgd2hhdCB0aGUgc3RhdHVzPyBUaGFua3MuDQoNCkJlc3QgUmVnYXJkcywNCkpvYWtpbSBaaGFu
Zw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1
ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjHE6jXUwjExyNUgMjoyMQ0KPiBU
bzogbGludXgtY2FuQHZnZXIua2VybmVsLm9yZw0KPiBDYzogTWFyYyBLbGVpbmUtQnVkZGUgPG1r
bEBwZW5ndXRyb25peC5kZT47IFRvcmluIENvb3Blci1CZW5udW4NCj4gPHRvcmluQG1heGlsdXhz
eXN0ZW1zLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBjYW46IHJhdzogZml4IFRYIENBTiBmcmFt
ZXMgc2hvdyB1cCBhcyBSWCdlZCBvbmVzDQo+IA0KPiBGaXhlczogZTk0MGUwODk1YTgyICgiY2Fu
OiBza2I6IGNhbl9za2Jfc2V0X293bmVyKCk6IGZpeCByZWYgY291bnRpbmcgaWYgc29ja2V0DQo+
IHdhcyBjbG9zZWQgYmVmb3JlIHNldHRpbmcgc2tiIG93bmVyc2hpcCIpDQo+IFJlcG9ydGVkLWJ5
OiBUb3JpbiBDb29wZXItQmVubnVuIDx0b3JpbkBtYXhpbHV4c3lzdGVtcy5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IC0tLQ0K
PiBIZXkgVG9yaW4sDQo+IA0KPiB0aGlzIGlzIG9ubHkgY29tcGlsZSB0aW1lIHRlc3RlZC4gUGxl
YXNlIGdpdmUgaXQgYSB0cnkuDQo+IA0KPiByZWdhcmRzLA0KPiBNYXJjDQo+IA0KPiAgZHJpdmVy
cy9uZXQvY2FuL2Rldi9za2IuYyB8ICAyICsrDQo+ICBpbmNsdWRlL2xpbnV4L2Nhbi9za2IuaCAg
IHwgMTQgKysrKysrKysrKystLS0NCj4gIG5ldC9jYW4vcmF3LmMgICAgICAgICAgICAgfCAgMiAr
LQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9kZXYvc2tiLmMgYi9kcml2ZXJzL25l
dC9jYW4vZGV2L3NrYi5jIGluZGV4DQo+IDYxNjYwMjQ4YzY5ZS4uOTY0NGMwZDg1YmI2IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vZGV2L3NrYi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0
L2Nhbi9kZXYvc2tiLmMNCj4gQEAgLTIwMCw2ICsyMDAsNyBAQCBzdHJ1Y3Qgc2tfYnVmZiAqYWxs
b2NfY2FuX3NrYihzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LA0KPiBzdHJ1Y3QgY2FuX2ZyYW1lICoq
Y2YpDQo+ICAJY2FuX3NrYl9yZXNlcnZlKHNrYik7DQo+ICAJY2FuX3NrYl9wcnYoc2tiKS0+aWZp
bmRleCA9IGRldi0+aWZpbmRleDsNCj4gIAljYW5fc2tiX3Bydihza2IpLT5za2JjbnQgPSAwOw0K
PiArCWNhbl9za2JfcHJ2KHNrYiktPmZsYWdzID0gMDsNCj4gDQo+ICAJKmNmID0gc2tiX3B1dF96
ZXJvKHNrYiwgc2l6ZW9mKHN0cnVjdCBjYW5fZnJhbWUpKTsNCj4gDQo+IEBAIC0yMzEsNiArMjMy
LDcgQEAgc3RydWN0IHNrX2J1ZmYgKmFsbG9jX2NhbmZkX3NrYihzdHJ1Y3QgbmV0X2RldmljZQ0K
PiAqZGV2LA0KPiAgCWNhbl9za2JfcmVzZXJ2ZShza2IpOw0KPiAgCWNhbl9za2JfcHJ2KHNrYikt
PmlmaW5kZXggPSBkZXYtPmlmaW5kZXg7DQo+ICAJY2FuX3NrYl9wcnYoc2tiKS0+c2tiY250ID0g
MDsNCj4gKwljYW5fc2tiX3Bydihza2IpLT5mbGFncyA9IDA7DQo+IA0KPiAgCSpjZmQgPSBza2Jf
cHV0X3plcm8oc2tiLCBzaXplb2Yoc3RydWN0IGNhbmZkX2ZyYW1lKSk7DQo+IA0KPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9jYW4vc2tiLmggYi9pbmNsdWRlL2xpbnV4L2Nhbi9za2IuaCBp
bmRleA0KPiBkMzExYmMzNjlhMzkuLjI0YTNlNjgyYjRhMiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS9saW51eC9jYW4vc2tiLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9jYW4vc2tiLmgNCj4gQEAg
LTUxLDYgKzUxLDcgQEAgc3RydWN0IGNhbl9za2JfcHJpdiB7DQo+ICAJaW50IGlmaW5kZXg7DQo+
ICAJaW50IHNrYmNudDsNCj4gIAl1bnNpZ25lZCBpbnQgZnJhbWVfbGVuOw0KPiArCXVuc2lnbmVk
IGludCBmbGFnczsNCj4gIAlzdHJ1Y3QgY2FuX2ZyYW1lIGNmW107DQo+ICB9Ow0KPiANCj4gQEAg
LTcxLDkgKzcyLDE2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjYW5fc2tiX3NldF9vd25lcihzdHJ1
Y3Qgc2tfYnVmZg0KPiAqc2tiLCBzdHJ1Y3Qgc29jayAqc2spDQo+ICAJICogYWZ0ZXIgdGhlIGxh
c3QgVFggc2tiIGhhcyBiZWVuIGZyZWVkKS4gU28gb25seSBpbmNyZWFzZQ0KPiAgCSAqIHNvY2tl
dCByZWZjb3VudCBpZiB0aGUgcmVmY291bnQgaXMgPiAwLg0KPiAgCSAqLw0KPiAtCWlmIChzayAm
JiByZWZjb3VudF9pbmNfbm90X3plcm8oJnNrLT5za19yZWZjbnQpKSB7DQo+IC0JCXNrYi0+ZGVz
dHJ1Y3RvciA9IHNvY2tfZWZyZWU7DQo+IC0JCXNrYi0+c2sgPSBzazsNCj4gKwlpZiAoc2spIHsN
Cj4gKwkJc3RydWN0IGNhbl9za2JfcHJpdiAqc2tiX3ByaXY7DQo+ICsNCj4gKwkJc2tiX3ByaXYg
PSBjYW5fc2tiX3Bydihza2IpOw0KPiArCQlza2JfcHJpdi0+ZmxhZ3MgPSBNU0dfRE9OVFJPVVRF
Ow0KPiArDQo+ICsJCWlmIChyZWZjb3VudF9pbmNfbm90X3plcm8oJnNrLT5za19yZWZjbnQpKSB7
DQo+ICsJCQlza2ItPmRlc3RydWN0b3IgPSBzb2NrX2VmcmVlOw0KPiArCQkJc2tiLT5zayA9IHNr
Ow0KPiArCQl9DQo+ICAJfQ0KPiAgfQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9jYW4vcmF3LmMg
Yi9uZXQvY2FuL3Jhdy5jIGluZGV4IDEzOWQ5NDcxZGRjZi4uOWJlZGQwNjcyZmFlDQo+IDEwMDY0
NA0KPiAtLS0gYS9uZXQvY2FuL3Jhdy5jDQo+ICsrKyBiL25ldC9jYW4vcmF3LmMNCj4gQEAgLTE2
OSw3ICsxNjksNyBAQCBzdGF0aWMgdm9pZCByYXdfcmN2KHN0cnVjdCBza19idWZmICpvc2tiLCB2
b2lkICpkYXRhKQ0KPiAgCS8qIGFkZCBDQU4gc3BlY2lmaWMgbWVzc2FnZSBmbGFncyBmb3IgcmF3
X3JlY3Ztc2coKSAqLw0KPiAgCXBmbGFncyA9IHJhd19mbGFncyhza2IpOw0KPiAgCSpwZmxhZ3Mg
PSAwOw0KPiAtCWlmIChvc2tiLT5zaykNCj4gKwlpZiAoY2FuX3NrYl9wcnYob3NrYiktPmZsYWdz
ID09IE1TR19ET05UUk9VVEUpDQo+ICAJCSpwZmxhZ3MgfD0gTVNHX0RPTlRST1VURTsNCj4gIAlp
ZiAob3NrYi0+c2sgPT0gc2spDQo+ICAJCSpwZmxhZ3MgfD0gTVNHX0NPTkZJUk07DQo+IC0tDQo+
IDIuMzAuMg0KPiANCg0K
