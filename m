Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9F97F7253
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2019 11:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfKKKg4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Nov 2019 05:36:56 -0500
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:57543
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726887AbfKKKg4 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 11 Nov 2019 05:36:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/DDDfSvZNioDSMWR5lz+ZRgRUisFaC7GfxYAEO1ldnMr35fyFN59n2RDVhPAiVj+2fpOQ+UQi1cO/3iur7E4IN3zMMcARTO5Rc2tQeOmJ4Fr1lfiIXYbkT42Bkfzoo5IBiViB9wOON2BlT3Flljim5AWfOYM8dkip2xBE76jPbU7ecuik0346SC/PvL8mkjhFJXBOxzM4KhYT26UuwdrpEvL8TaiofE8sruXqnJcw9iG1pFvvyTUPcJ0Gddf1vWZ62PivFfFMBLkV9rGSD7vV918K3CzdBsqclSWVHDu+S5CheM65MFN6GZofi7tv0vU6tRPBV056FQ9pHlIxixaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBv7zT/3PPUG9ciO0czGnN0ytYBItQNo7l+pHezljSc=;
 b=G6UbK0TZi8rWBjO6E76+c+ki4vB5hZUFaL0oCTqdVwUE9KnQ0MjHr69+8gWP2y6sRVSndn8Do+HWCVmL+Jb/cNgyx3eKRJyy7XVD1kN68BBTawvumYIh3Uf2YOIxbMHCQ6xUkOgI7ELlGVUfQQGXR3jjEG12Yq/hoglqoRMfdoPNd9/PA7GXc81FVsBAOiQUCJ1UXwCFA5f1QPmYPPgpyN51EOQ2OcsqyPRh+h522jxDXzik3R8NReodwlzxK0F+49FlmunzX9X1Q8vkbRClQc975AR3X7nkpd1SKpKapA9WXEVO5W42iE7zhKQAo+AHqtTHBROEmZwfItNQspZNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBv7zT/3PPUG9ciO0czGnN0ytYBItQNo7l+pHezljSc=;
 b=lWDh4OM5lg0f2s19rA1jXiXiGQA7jxlXhHWNZDx5dukEkbA4wjzIBRfO2dC246XErZdgT9ADsvEPtRMjkOYev/szsL+bo+giGQuvVL+zJ4EZDEN2t+Yo0dvhiyo6d1scCD3CPT+fz9ZH+qyZz4LDJoDk1gJy2qRMcvK+8dkm+C8=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB5036.eurprd04.prod.outlook.com (20.176.234.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Mon, 11 Nov 2019 10:36:51 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6%4]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 10:36:51 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "sean@geanix.com" <sean@geanix.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Topic: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Index: AdWYdOEh/tYWI8MXSASMqe9cVeZH0AAAx0KAAAByFCA=
Date:   Mon, 11 Nov 2019 10:36:51 +0000
Message-ID: <DB7PR04MB461893DB29EE914EEEF410CDE6740@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <DB7PR04MB4618BF9DE9152B2F1D49A702E6740@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <bcbae072-3aec-34f7-9b7e-58d78000bd39@pengutronix.de>
In-Reply-To: <bcbae072-3aec-34f7-9b7e-58d78000bd39@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea76eb8d-a7bd-4a47-c572-08d766931052
x-ms-traffictypediagnostic: DB7PR04MB5036:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR04MB5036A8BDBDD7072CBB27B91DE6740@DB7PR04MB5036.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(189003)(199004)(13464003)(9686003)(14444005)(478600001)(6306002)(74316002)(486006)(64756008)(66446008)(66946007)(76116006)(3846002)(66476007)(55016002)(966005)(66556008)(6246003)(6436002)(6116002)(2201001)(110136005)(33656002)(316002)(86362001)(14454004)(7736002)(102836004)(81166006)(81156014)(2906002)(52536014)(26005)(76176011)(71200400001)(71190400001)(53546011)(6506007)(66066001)(5660300002)(229853002)(8676002)(476003)(99286004)(186003)(11346002)(8936002)(25786009)(256004)(2501003)(7696005)(305945005)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5036;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QzsLeSw9WagoKGzc58Lz3uR9b5zkzlQZSjalbo62/eep/YD0i60althL9awsXojzPzAJx07gQMTn64Rc/p7yepG17WjBIiPZi5l6JmsUAvzttoHdtFT7fH6P2nECqVQrB/tzCyYEOXhb7kIPpGsG9Nc9FylYlYwJ64+LqugGXoMfKQuyu1AUyuOPAD85aGH82XPIeM5P533BXt2noJPQe3gaCH9WpKr2Yz33gkj1r08SWr/4QdtSpR7/wU5/kQph89iI7kAWIHkOi5kx/6CTabDkiEKrd1vN9sFsc92seD4v64A/upphT8VL0yCzDx1qc3kK2/dR0H0QENu2UPjrIiw/Z9+kULz2XnVxwBGVna/PGEMzXZZovcpq7zvpaVFl00u+p+dfmec29wxBJygc/lX3rFJ6SlfGpN+oNN6qBzUp6DVbdIP+Kgp7quDvTeYVfeaRZbCom6c0XcIzTXAQykJXbk6Iy6RqAJrAQgaEMCA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea76eb8d-a7bd-4a47-c572-08d766931052
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 10:36:51.4711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7sphxIJPNBC9ouo0R/eQeF+k7JbaxZcVqkEA3vAQSkC52HZ3p2cdtTag7H46mCyq6vMxYX8Zft7nM5uruEyxew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5036
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMTnlubQxMeaciDEx5pelIDE4OjA5DQo+
IFRvOiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsgc2VhbkBnZWFuaXgu
Y29tOw0KPiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBXYWtlIHVw
IGlzc3VlIGFib3V0IEZsZXhjYW4gZHJpdmVyIGluIHY1LjQga2VybmVsDQo+IA0KPiBPbiAxMS8x
MS8xOSAxMDo0OCBBTSwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+IEkgY2FtZSBhY3Jvc3MgYSBz
dHJhbmdlIHBoZW5vbWVub24gYWJvdXQgd2FrZSB1cCBpbiBGbGV4Y2FuIGRyaXZlcg0KPiA+IHdp
dGgNCj4gPiB2NS40IGtlcm5lbCwgSSBjb25uZWN0ZWQgdHdvIGkuTVg3RC1TREIgYm9hcmQuDQo+
ID4NCj4gPiBJIGZvdW5kIHRoYXQgQ0FOIGZyYW1lIHdoaWNoIHRyeSB0byB3YWtlIHVwIHRoZSBz
eXN0ZW0gd2lsbCBub3QgYmUNCj4gPiByZWNlaXZlZCBhdCBhbm90aGVyIHNpZGUgaW4gb3JkZXIu
IExpa2UgYmVsb3cgY2FzZToNCj4gPg0KPiA+IFNlbmRlcjogY2FuZ2VuIGNhbjAgLXZ2DQo+ID4g
wqAgY2FuMMKgIDREOcKgwqAgWzhdwqAgODkgNzIgMEMgNUYgQzggMTUgMkQgM0ENCj4gPiDCoCBj
YW4wwqAgMEFBwqDCoCBbOF3CoCBCNyBEQyAxNCA2MSA3RiBBMCA4RSA0MA0KPiA+IMKgIGNhbjDC
oCAzMDTCoMKgIFs4XcKgIDQyIDVDIEQ3IDNCIEQ2IDFEIDM2IDU2DQo+ID4gwqAgY2FuMMKgIDBE
OcKgwqAgWzddwqAgQjAgQzMgMUIgN0IgOUIgM0EgMTkNCj4gPiDCoCBjYW4wwqAgNjZCwqDCoCBb
OF3CoCA4QSBCMCBEOSA1NiAwMCA0NiA3NiA0OA0KPiA+IMKgIGNhbjDCoCAyMkTCoMKgIFs4XcKg
IDQ0IDRCIEZEIDUzIEIyIEQzIEE1IDMzDQo+ID4gwqAgY2FuMMKgIDQ3RcKgwqAgWzhdwqAgQjkg
NkIgNzIgMEIgNEMgMTUgOTYgNzINCj4gPiDCoCBjYW4wwqAgNTRDwqDCoCBbM13CoCAzRiBCRSA4
Rg0KPiA+IMKgIGNhbjDCoCA3QzHCoMKgIFs4XcKgIEVFIEE3IEI0IDExIDZDIDgwIDhGIDdEDQo+
ID4gwqAgY2FuMMKgIDVENsKgwqAgWzVdwqAgRUIgMjAgMUUgM0UgREINCj4gPiDCoCBjYW4wwqAg
Nzk0wqDCoCBbOF3CoCBCMSA1NiA5RSAxMyA2RCA4OCBDRSA1Mg0KPiA+IMKgIGNhbjDCoCA1ODTC
oMKgIFsxXcKgIDA4DQo+ID4NCj4gPg0KPiA+DQo+ID4gUmVjZWl2ZXI6IGNhbmR1bXAgY2FuMCAm
DQo+ID4gwqAgY2FuMMKgIDBBQcKgwqAgWzhdwqAgQjcgREMgMTQgNjEgN0YgQTAgOEUgNDANCj4g
PiDCoCBjYW4wwqAgMzA0wqDCoCBbOF3CoCA0MiA1QyBENyAzQiBENiAxRCAzNiA1Ng0KPiA+IMKg
IGNhbjDCoCAwRDnCoMKgIFs3XcKgIEIwIEMzIDFCIDdCIDlCIDNBIDE5DQo+ID4gwqAgY2FuMMKg
IDY2QsKgwqAgWzhdwqAgOEEgQjAgRDkgNTYgMDAgNDYgNzYgNDgNCj4gPiDCoCBjYW4wwqAgMjJE
wqDCoCBbOF3CoCA0NCA0QiBGRCA1MyBCMiBEMyBBNSAzMw0KPiA+IMKgIGNhbjDCoCA0RDnCoMKg
IFs4XcKgIDg5IDcyIDBDIDVGIEM4IDE1IDJEIDNBDQo+ID4gwqAgY2FuMMKgIDQ3RcKgwqAgWzhd
wqAgQjkgNkIgNzIgMEIgNEMgMTUgOTYgNzINCj4gPiDCoCBjYW4wwqAgNTRDwqDCoCBbM13CoCAz
RiBCRSA4Rg0KPiA+IMKgIGNhbjDCoCA3QzHCoMKgIFs4XcKgIEVFIEE3IEI0IDExIDZDIDgwIDhG
IDdEDQo+ID4gwqAgY2FuMMKgIDVENsKgwqAgWzVdwqAgRUIgMjAgMUUgM0UgREINCj4gPiDCoCBj
YW4wwqAgNzk0wqDCoCBbOF3CoCBCMSA1NiA5RSAxMyA2RCA4OCBDRSA1Mg0KPiA+IMKgIGNhbjDC
oCA1ODTCoMKgIFsxXcKgIDA4DQo+ID4NCj4gPiBZb3UgY2FuIHNlZSB0aGF0IHdha2UgdXAgZnJh
bWUoY2FuMMKgIDREOcKgwqAgWzhdwqAgODkgNzIgMEMgNUYgQzggMTUgMkQNCj4gPiAzQSkgd2ls
bCBiZSByZWNlaXZlZCBhdCA2XnRoICwgaXTigJlzIGhhcmQgdG8gdW5kZXJzdGFuZC4NCj4gDQo+
IC0gV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB3YWtldXA/DQo+ICAgLSBDbGVhbiByZWJvb3Q/DQo+
ICAgLSBpZmRvd24vaWZ1cD8NCg0KCUNsZWFuIGJvb3QNCg0KCVNlbmRlciBzaWRlOg0KCWlwIGxp
bmsgc2V0IGNhbjAgdXAgdHlwZSBjYW4gYml0cmF0ZSAxMDAwMDAwDQoJZWNobyBlbmFibGVkID4g
L3N5cy9idXMvcGxhdGZvcm0vZHJpdmVycy9mbGV4Y2FuLzMwYTEwMDAwLmNhb3dlci93YWtldXAN
CgljYW5kdW1wIGNhbjAgJg0KCWVjaG8gbWVtID4gL3N5cy9wb3dlci9zdGF0ZQ0KDQoJUmVjZWl2
ZSBzaWRlOg0KCWlwIGxpbmsgc2V0IGNhbjAgdXAgdHlwZSBjYW4gYml0cmF0ZSAxMDAwMDAwDQoJ
Y2FuZ2VuIGNhbjAgLXZ2DQoNCj4gICAtIHNlbmRpbmcgb3RoZXIgcGFja2V0cz8NCglOby4NCj4g
LSBEb2VzIHRoaXMgaGFwcGVuIG9uIGV2ZXJ5IHdha2V1cD8NCglZZXMuDQo+IC0gSXMgdGhlIHdh
a2UgdXAgZnJhbWUgYWx3YXlzICJyZWNlaXZlZCIgYXMgNnRoIGZyYW1lPw0KCU5vLCBkaWZmZXJl
bnQgd2l0aCBkaWZmZXJlbnQgZnJhbWUgZ2FwLg0KPiAtIElzIHRoZSBzaXR1YXRpb24gdGhlIHNh
bWUsIGlmIHlvdSBhZGQgc29tZSBkZWxheSBiZXR3ZWVuIHRoZSBmcmFtZXMsDQo+ICAgdXNpbmcg
dGhlICJjYW5nZW4gLWcgb3B0aW9uIj8NCglUaGUgc2l0dWF0aW9uIGlzIGRpZmZlcmVudCB3aXRo
IGRpZmZlcmVudCAiY2FuZ2VuIC1nIG9wdGlvbiINCj4gLSBIb3cgYmlnIGNhbiB5b3UgbWFrZSB0
aGUgLWcgdW50aWwgdGhlIGZyYW1lcyBhcmUgcmVjZWl2ZWQgaW4gb3JkZXINCj4gICBhZ2Fpbj8N
CglJIGFtIG5vdCBzdXJlLCBJIGNhbiBkbyBhIHRlc3QgbGF0ZXIuDQoNCj4gVGhlIHJlY2VwdGlv
biBwYXRoIHdvcmtzIGxpa2UgdGhpczoNCj4gSW4gdGhlIGludGVycnVwdCBoYW5kbGVyIHRoZSBy
eC1vZmZsb2FkIHJlYWRzIGFsbCBtYWlsYm94ZXMgYmFzZWQgb24gdGhlIGlmbGFnDQo+IHJlZ2lz
dGVyLiBJdCBpdGVyYXRlcyBvdmVyIGFsbCBzZXQgbWFpbGJveGVzLCBzdGFydGluZyB3aXRoIHRo
ZSBmaXJzdC4gQWxsIG1haWxib3hlcw0KPiBhcmUgcmVhZCBpbmNsdWRpbmcgdGhlIHJ4LXRpbWVz
dGFtcCwgc29ydGVkIGFuZCBhZGRlZCBpbnRvIGEgcXVldWUuIEF0IHRoZSBlbmQNCj4gb2YgdGhl
IElSUSBoYW5kbGVyIHRoZSBxdWV1ZSBpcyBhZGRlZCB0byB0aGUgcGVyIGRldmljZSBxdWV1ZSB0
aGF0cyByZWFkIGluIHRoZQ0KPiBOQVBJIGFuZCBwdXNoZWQgaW50byB0aGUgbmV0d29ya2luZyBz
dGFjay4NCj4gDQo+IE1heWJlIHNvbWV0aGluZyB3aXRoIHRoZSB0aW1lc3RhbXAgb2YgdGhlIGZp
cnN0IHBhY2tldCBpcyB3cm9uZywgYXMgdGhlDQo+IGNvdW50ZXIgaXMgb25seSAxNiBiaXRzIHdp
ZGUsIGl0IHdpbGwgb3ZlcmZsb3cgcXVpdGUgb2Z0ZW4uDQo+IA0KPiBNYXliZSB5b3UgY2FuIHRy
YWNlX3ByaW50ayB0aGUgbWFpbGJveCBudW1iZXIsIHRpbWVzdGFtcCBhbmQgY2FuX2lkIGluDQo+
IG1haWxib3hfcmVhZCgpIGFuZCBhbmFseXNlIG91dHB1dCBhZnRlciB3YWtldXAuIEZlZWwgZnJl
ZSB0byBwb3N0IHRoZSBvdXRwdXQNCj4gb2YgdGhlIHRyYWNlciBoZXJlLg0KDQoJSSBhbHNvIHN1
c3BlY3QgdGhpcywgYnV0IEkgY2hlY2sgdGhlIGZsb3cgb2YgdGhlIHJlY2VpdmUgcGF0aCBpcyB0
aGUgc2FtZSB3aXRoIHY0LjE0IGFuZCB2NC4xOS4NCglBbm90aGVyIHRoaW5nIGNvbmZ1c2VkIG1l
IGlzIHRoYXQgaG93IGRvZXMgdGhlIGRyaXZlciBoYW5kbGUgdGhlIGNvdW50ZXIgb3ZlcmZsb3cu
IElmIHRoZSBjb3VudGVyIG92ZXJmbG93IGluIG9uZSByb3VuZCBtYWlsYm94IHJlYWQsIHRoZSBy
ZWNlaXZlIG9yZGVyIGlzIG5vdCBjb25zaXN0ZW50IHdpdGggcmVhbGl0eS4gSSBkbyBub3QgdGhl
IGhhbmRsZSBvZiB0aGlzIGNhc2UgaW4gZHJpdmVyLg0KCUkgd2lsbCB1c2UgdGhlIHRyYWNlX3By
aW50aygpIHRvIHBvc3QgdGhlIG91dHB1dCBoZXJlLg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0g
WmhhbmcNCj4gcmVnYXJkcywNCj4gTWFyYw0KPiANCj4gLS0NCj4gUGVuZ3V0cm9uaXggZS5LLiAg
ICAgICAgICAgICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAgICAgfA0KPiBFbWJlZGRl
ZCBMaW51eCAgICAgICAgICAgICAgICAgICB8IGh0dHBzOi8vd3d3LnBlbmd1dHJvbml4LmRlICB8
DQo+IFZlcnRyZXR1bmcgV2VzdC9Eb3J0bXVuZCAgICAgICAgIHwgUGhvbmU6ICs0OS0yMzEtMjgy
Ni05MjQgICAgIHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgfCBGYXg6ICAg
KzQ5LTUxMjEtMjA2OTE3LTU1NTUgfA0KDQo=
