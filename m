Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8F82211B7
	for <lists+linux-can@lfdr.de>; Fri, 17 May 2019 03:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfEQBV7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 16 May 2019 21:21:59 -0400
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:50310
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726839AbfEQBV7 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 16 May 2019 21:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7ZDq8wnPlgvYDLsapoxooClxEL44YHNxQ9JbROJsl8=;
 b=OgbLZRkxtTMVpjVk9YRm3OmYp7KaQ9S0VQVYaNCXSgWrRht5hmJ8j/ZacJexjITTARYd0IyUlM2MLpJM0aCx2zSCKUkJgsb8JxNZPencPAbZamzDb3aeblpfolU6KAIVj+iixuc/pkRgvrkg8cR03D4DHR7EGitHSqbUfdktjkQ=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4890.eurprd04.prod.outlook.com (20.176.234.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Fri, 17 May 2019 01:21:52 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::bd02:a611:1f0:daac]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::bd02:a611:1f0:daac%6]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 01:21:52 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Pankaj Bansal <pankaj.bansal@nxp.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] can: flexcan: make PE clock info conditional
Thread-Topic: [PATCH v2 2/2] can: flexcan: make PE clock info conditional
Thread-Index: AQHVC78eiEMQAEmQU0i5kR/nmT1v2KZug56Q
Date:   Fri, 17 May 2019 01:21:52 +0000
Message-ID: <DB7PR04MB46184B47B704098716DF7E3DE60B0@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20190516133556.15872-1-pankaj.bansal@nxp.com>
 <20190516133556.15872-3-pankaj.bansal@nxp.com>
In-Reply-To: <20190516133556.15872-3-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30bf32b6-ebe8-497e-adc3-08d6da660b1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4890;
x-ms-traffictypediagnostic: DB7PR04MB4890:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR04MB4890856FF627B05C91325129E60B0@DB7PR04MB4890.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(136003)(396003)(13464003)(199004)(189003)(66946007)(66446008)(64756008)(66556008)(66476007)(76116006)(73956011)(53936002)(6116002)(3846002)(6246003)(55016002)(9686003)(6306002)(6436002)(74316002)(2906002)(8936002)(25786009)(8676002)(4326008)(81156014)(81166006)(305945005)(7736002)(33656002)(229853002)(256004)(7696005)(99286004)(110136005)(71200400001)(71190400001)(316002)(186003)(26005)(86362001)(45080400002)(52536014)(5660300002)(14454004)(102836004)(6506007)(53546011)(76176011)(478600001)(966005)(66066001)(68736007)(486006)(446003)(476003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4890;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RiA1TxElwNmBfQLHUHvGl84wWLEvx2i0RW+QsVePmvnN+ll/aSpf0BeGGiKaMFh9Hk9eWx7o+kTRagXj4w9QL/Gq8bZL6gTHJDYF8SZabT1QyVkIFvrwMgl3d5f8dDuv73Zr0/RZepnMvJmYsdBEd+lboQugzc9lNSiJNw6g5rwzHBykcpluvIPdumXZdtrPIx9DWQzhs5dyuUrLsXjna3BKAMuGXdiPNVBk41DzutN+Ra4iiFcMAKvv58tdIoaWY7LLCz6lfLX3eT50EPW+EwVOf2W3pWKz1mZtpLQNWeZpNfe4dxdcohUgjhX7o8lp7qlGmUzl0jxP0+QRA5BvJYu/WMndmS8+8ipDpSK5HZQApNLrqM/ledCo5msbQQeAv0Sbk4Pw7RNl00wlh3uDaHdwruzn1K0RF9zRTQ9xf54=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bf32b6-ebe8-497e-adc3-08d6da660b1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 01:21:52.6211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4890
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGxpbnV4LWNhbi1vd25lckB2
Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWNhbi1vd25lckB2Z2VyLmtlcm5lbC5vcmc+DQo+IE9uIEJl
aGFsZiBPZiBQYW5rYWogQmFuc2FsDQo+IFNlbnQ6IDIwMTnlubQ15pyIMTbml6UgMTY6MTINCj4g
VG86IFdvbGZnYW5nIEdyYW5kZWdnZXIgPHdnQGdyYW5kZWdnZXIuY29tPjsgTWFyYyBLbGVpbmUt
QnVkZGUNCj4gPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gQ2M6IGxpbnV4LWNhbkB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogW1BBVENIIHYyIDIvMl0gY2FuOiBmbGV4Y2FuOiBtYWtlIFBFIGNs
b2NrIGluZm8gY29uZGl0aW9uYWwNCj4gDQo+IFBFIGNsb2NrIGluZm8gY2FuIGJlIHNraXBwZWQg
aWYgdGhlIHN5bmNocm9ub3VzIGNsb2NraW5nIGlzIHRvIGJlIHVzZWQgaW4NCj4gZmxleGNhbi4N
Cj4gDQo+IFJlZmVyIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL2Zz
bC1mbGV4Y2FuLnR4dCBmb3IgbW9yZQ0KPiBpbmZvLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGFu
a2FqIEJhbnNhbCA8cGFua2FqLmJhbnNhbEBueHAuY29tPg0KPiAtLS0NCj4gDQo+IE5vdGVzOg0K
PiAgICAgRGVwZW5kZW5jaWVzOg0KPiAgICAgWzFdDQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUua2VyDQo+IG5l
bC5vcmclMkZwYXRjaHdvcmslMkZjb3ZlciUyRjEwMjQ1MzYlMkYmYW1wO2RhdGE9MDIlN0MwMSU3
Q3FpYQ0KPiBuZ3FpbmcuemhhbmclNDBueHAuY29tJTdDODE5YWRlMGNmZWQ5NGI4MTg3NDMwOGQ2
ZDlkNjNmYWIlN0M2ODYNCj4gZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3
QzYzNjkzNTkxMTU0OTg4OTU1OCZhbQ0KPiBwO3NkYXRhPUhEVWlITlY4R0JTJTJCMlg5d0UwSVdC
NmloSms4N3ZvQXFzQzh4a1A3NURoNCUzRCZhbXA7DQo+IHJlc2VydmVkPTANCj4gICAgIFsyXQ0K
PiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cHMlM0ElMkYlMkZsb3JlLmtlcg0KPiBuZWwub3JnJTJGcGF0Y2h3b3JrJTJGcGF0Y2glMkYxMDAx
OTE4JTJGJmFtcDtkYXRhPTAyJTdDMDElN0NxaWENCj4gbmdxaW5nLnpoYW5nJTQwbnhwLmNvbSU3
QzgxOWFkZTBjZmVkOTRiODE4NzQzMDhkNmQ5ZDYzZmFiJTdDNjg2DQo+IGVhMWQzYmMyYjRjNmZh
OTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY5MzU5MTE1NDk4ODk1NTgmYW0NCj4gcDtzZGF0
YT0lMkJxNzBBU2FST2daSG5ObzhTRWdHUzBkQ0hyU3V6WTdHeWFCJTJGanh1VzQxWSUzRCZhbQ0K
PiBwO3Jlc2VydmVkPTANCj4gDQo+ICAgICBWMjoNCj4gICAgIC0gbW9kaWZpZWQgdGhlIGNsa19z
cmMgPT0gMCB0byAhY2xrX3NyYw0KPiAgICAgLSBtb2RpZmllZCBjaGFuZ2VzIGluIGZsZXhjYW5f
Y2xrc19lbmFibGUNCj4gICAgIC0gQWRkZWQgRGVwZW5kZW5jaWVzIGluIE5vdGVzDQo+IA0KPiAg
ZHJpdmVycy9uZXQvY2FuL2ZsZXhjYW4uYyB8IDM5ICsrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAxMiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jIGIv
ZHJpdmVycy9uZXQvY2FuL2ZsZXhjYW4uYyBpbmRleA0KPiA1ZjQwNzVkNTk4ZDAuLjI0OWZjMGE2
Zjg1ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL2ZsZXhjYW4uYw0KPiArKysgYi9k
cml2ZXJzL25ldC9jYW4vZmxleGNhbi5jDQo+IEBAIC01MTUsMjEgKzUxNSwyNCBAQCBzdGF0aWMg
aW50IGZsZXhjYW5fY2xrc19lbmFibGUoY29uc3Qgc3RydWN0DQo+IGZsZXhjYW5fcHJpdiAqcHJp
dikgIHsNCj4gIAlpbnQgZXJyOw0KPiANCj4gLQllcnIgPSBjbGtfcHJlcGFyZV9lbmFibGUocHJp
di0+Y2xrX2lwZyk7DQo+ICsJZXJyID0gY2xrX3ByZXBhcmVfZW5hYmxlKHByaXYtPmNsa19wZXIp
Ow0KPiAgCWlmIChlcnIpDQo+ICAJCXJldHVybiBlcnI7DQo+IA0KPiAtCWVyciA9IGNsa19wcmVw
YXJlX2VuYWJsZShwcml2LT5jbGtfcGVyKTsNCj4gLQlpZiAoZXJyKQ0KPiAtCQljbGtfZGlzYWJs
ZV91bnByZXBhcmUocHJpdi0+Y2xrX2lwZyk7DQo+ICsJaWYgKHByaXYtPmNsa19pcGcpIHsNCj4g
KwkJZXJyID0gY2xrX3ByZXBhcmVfZW5hYmxlKHByaXYtPmNsa19pcGcpOw0KPiArCQlpZiAoZXJy
KQ0KPiArCQkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHByaXYtPmNsa19wZXIpOw0KPiArCX0NCj4g
DQo+ICAJcmV0dXJuIGVycjsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgdm9pZCBmbGV4Y2FuX2Nsa3Nf
ZGlzYWJsZShjb25zdCBzdHJ1Y3QgZmxleGNhbl9wcml2ICpwcml2KSAgew0KPiArCWlmIChwcml2
LT5jbGtfaXBnKQ0KPiArCQljbGtfZGlzYWJsZV91bnByZXBhcmUocHJpdi0+Y2xrX2lwZyk7DQo+
ICAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHByaXYtPmNsa19wZXIpOw0KPiAtCWNsa19kaXNhYmxl
X3VucHJlcGFyZShwcml2LT5jbGtfaXBnKTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgaW5saW5lIGlu
dCBmbGV4Y2FuX3RyYW5zY2VpdmVyX2VuYWJsZShjb25zdCBzdHJ1Y3QgZmxleGNhbl9wcml2ICpw
cml2KQ0KPiBAQCAtMTY4OCwxOCArMTY5MSwzMCBAQCBzdGF0aWMgaW50IGZsZXhjYW5fcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIAl9DQo+IA0KPiAgCWlmICghY2xv
Y2tfZnJlcSkgew0KPiAtCQljbGtfaXBnID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJpcGci
KTsNCj4gLQkJaWYgKElTX0VSUihjbGtfaXBnKSkgew0KPiAtCQkJZGV2X2VycigmcGRldi0+ZGV2
LCAibm8gaXBnIGNsb2NrIGRlZmluZWRcbiIpOw0KPiAtCQkJcmV0dXJuIFBUUl9FUlIoY2xrX2lw
Zyk7DQo+IC0JCX0NCj4gLQ0KPiAgCQljbGtfcGVyID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYs
ICJwZXIiKTsNCj4gIAkJaWYgKElTX0VSUihjbGtfcGVyKSkgew0KPiAgCQkJZGV2X2VycigmcGRl
di0+ZGV2LCAibm8gcGVyIGNsb2NrIGRlZmluZWRcbiIpOw0KPiAgCQkJcmV0dXJuIFBUUl9FUlIo
Y2xrX3Blcik7DQo+ICAJCX0NCj4gLQkJY2xvY2tfZnJlcSA9IGNsa19nZXRfcmF0ZShjbGtfcGVy
KTsNCj4gKw0KPiArCQlpZiAoIWNsa19zcmMpIHsNCj4gKwkJCS8vIG9ubHkgZ2V0IG9zY2lsbGF0
b3IgY2xvY2sgaWYgYXN5bmNocm9ub3VzIGNsb2NraW5nDQo+ICsJCQkvLyBpcyB0byBiZSB1c2Vk
Lg0KPiArCQkJY2xrX2lwZyA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCAiaXBnIik7DQo+ICsJ
CQlpZiAoSVNfRVJSKGNsa19pcGcpKSB7DQo+ICsJCQkJZGV2X2VycigmcGRldi0+ZGV2LCAibm8g
aXBnIGNsb2NrIGRlZmluZWRcbiIpOw0KPiArCQkJCXJldHVybiBQVFJfRVJSKGNsa19pcGcpOw0K
PiArCQkJfQ0KPiArDQo+ICsJCQljbG9ja19mcmVxID0gY2xrX2dldF9yYXRlKGNsa19pcGcpOw0K
PiArCQkJaWYgKGNsb2NrX2ZyZXEgPj0gY2xrX2dldF9yYXRlKGNsa19wZXIpKSB7DQo+ICsJCQkJ
ZGV2X2VycigmcGRldi0+ZGV2LA0KPiArCQkJCQkiUEUgY2xvY2sgc2hvdWxkIGJlIGxlc3MgdGhh
biBDSElcbiIpOw0KPiArCQkJCXJldHVybiAtRUlOVkFMOw0KPiArCQkJfQ0KPiArCQl9IGVsc2Ug
ew0KPiArCQkJY2xvY2tfZnJlcSA9IGNsa19nZXRfcmF0ZShjbGtfcGVyKTsNCj4gKwkJfQ0KPiAg
CX0NCg0KW0pvYWtpbSBaaGFuZ10gV2hlbiBTT0MgaW1wbGVtZW50cyB0aGUgc3luY2hyb25vdXMg
Y2xvY2soY2xrX3NyYyA9IDEpLCBpdCBqdXN0IG1lYW5zIHRoYXQgQ0hJIGFuZCBQRSBzaGFyZSB0
aGUgc2FtZSBjbG9jayBzb3VyY2UuDQogICAgICAgICAgICAgQWxzbyBjYW4gc2VsZWN0IGEgZGlm
ZmVyZW50IGNsb2NrIGZyZXF1ZW5jeSBmb3IgUEUgY2xvY2ssIHJpZ2h0Pw0KDQoJCSAgICAgY2xv
Y2tzID0gPCZzeXNjbGs+LCA8JmNsb2NrZ2VuIDQgNz47DQoJCSAgICAgY2xvY2stbmFtZXMgPSAi
aXBnIiwgInBlciI7DQogICAgICAgICAgICAgKmFzc2lnbmVkLWNsb2NrcyA9IDwmc3lzY2xrPjsq
DQogICAgICAgICAgICAgKmFzc2lnbmVkLWNsY29rcy1yYXRlcyA9IDw0MDAwMDAwMD47Kg0KDQoJ
CSAgICAgV2UgYWxzbyBuZWVkIHRvIGdldCBQRSBjbG9jayBpbmZvIHdpdGggdGhpcyBjYXNlLg0K
IA0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQo+ICAJbWVtID0gcGxhdGZvcm1fZ2V0X3Jl
c291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gLS0NCj4gMi4xNy4xDQoNCg==
