Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B55BBF731B
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2019 12:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfKKLcN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Nov 2019 06:32:13 -0500
Received: from mail-eopbgr140044.outbound.protection.outlook.com ([40.107.14.44]:16867
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726810AbfKKLcN (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 11 Nov 2019 06:32:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTK4QLzedhd89k52owfQChvjYLiWWqSnWPIX6nEtaRWNE4po8O1Pl1DMt6yVf3Dgmu4Yy+2YTakvpOXPS6OcJ2QzF1xFaKoLyIJIbq2x0lebLhKSPbEGa9/hIejaK8SGSToApwbSnnK35NtBzKxtTT2xGhswrun6hy1ipy7MSKrlkmfm341m+Kktu+qF89Ufi0U0CfTUEeCRM2wB7+9HjsMoNUicoxY2G9JNNupPJzEM+Wz8+sZAmiPoHHry4b+nfHtFKlYbHDOefDTiDosq37kOcnl7FlDixNfwfDPZMTKHUhe8APqB2ENs8hzI8HrgJuQXanzmTzfbTybYkpREPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2TNNfA/62nwLpCNsVl6cQtc/GX5Q3lpKVrzQbN1yO0=;
 b=R2Wz+BdyAUjiSoDq+n7DJVz2R4IJB+gBAiQFB554BoQXAUi9QmLOmD8rZ8NqxiPIz3f/VkH1Mkhu4NldG5Dk0BRAyxMM69fep4KhlsKcq6pzVKGcBm7oMBmpdYKwOmoYrhhKlk6YSB62Pm80WSnQDZAk4E9q4LVDx4VVYyLoPOfeqUMKLK4o85jaHX/sAGsyGcdPIF9dR+aBFXEudjQYaafhHhVDtpvelWUYUM9UlZG+2smJqAJC9QDbLIU71SIswjPjirkNaHB39Sr3Vz6hyOEFsLgkCkwWLX6DcGzgtl3pe9LEnO5toaKnNe9RNiX1TLrlI+rk87KR6MJTcmikwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2TNNfA/62nwLpCNsVl6cQtc/GX5Q3lpKVrzQbN1yO0=;
 b=YqHgzifzsjEog9gqnjXrKK8AWJKeyKVxQ5eE1sFOyqXUEv/NIsfdVZHwfTYKDnDJzHZPY9dTK01D7IV91OgUllUtifeV4Upwu7mUChJNisRR5kFNMW1Ak58Qre2n6ueciIDQAMG/4B3HHz1SzuMkaX7d+5VozsrZ9ze81f+hdEc=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB5545.eurprd04.prod.outlook.com (20.178.85.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Mon, 11 Nov 2019 11:32:09 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6%4]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 11:32:09 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "sean@geanix.com" <sean@geanix.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Topic: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Index: AdWYdOEh/tYWI8MXSASMqe9cVeZH0AAAx0KAAAKuhmA=
Date:   Mon, 11 Nov 2019 11:32:09 +0000
Message-ID: <DB7PR04MB4618B47ED891C8C7FFBD9141E6740@DB7PR04MB4618.eurprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 1102cd3a-f316-4187-76ce-08d7669aca2e
x-ms-traffictypediagnostic: DB7PR04MB5545:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR04MB554506923BAD1ED1A2E7BCCEE6740@DB7PR04MB5545.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(189003)(199004)(13464003)(5660300002)(14444005)(33656002)(3846002)(7696005)(52536014)(256004)(76116006)(8936002)(2906002)(8676002)(66446008)(64756008)(66556008)(66476007)(6116002)(66946007)(81156014)(81166006)(2501003)(66066001)(71200400001)(71190400001)(9686003)(53546011)(6506007)(6246003)(6436002)(25786009)(99286004)(478600001)(2201001)(102836004)(186003)(86362001)(55016002)(76176011)(316002)(6306002)(110136005)(14454004)(229853002)(26005)(11346002)(966005)(7736002)(446003)(305945005)(486006)(74316002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5545;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4XwtWM1h7dR+lwhpAiZEox+TAf2EFcPagzCcLHOutkdb49k1v0I3g7VDZbyWTn9WBbmkue8NFG1EOncCswGozrFzz+mFijn1oR2cDkHoHIWrkij26WP394KDaVUfeijQiWoxoM+xGK8uYdURummRmlnf2oagLpzdJ6NVAKzwZPzSawISyKVyu+KpFclEuHs1NrnUrrnGcYz2MSrXc0v5o0T6KC/FjNyudRrAw8FcJa5SpkwHsItej/s7JrkwgWw6Lc85Sjw+GElEB2flwNQoQvKf+jv/B8XAzztO/aEcqCFF8BICcwkowX5TeKId2K6z4ZdPRfQFUCFBc2Xt9UA9VBrD0Gtoj/gE4qd9vcXmlgnqmeAFO8/mtHtlEozr233dr7cjrBhtBk06L7MNuQ20+SCQ51gquG4C9W+q62rV8o97MFEGA87qyafP0YZw7ObRvwRkEt90yRrZnCQ4pT0rCID4usdTzVGGuJaJfsgwVdo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1102cd3a-f316-4187-76ce-08d7669aca2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 11:32:09.8304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1z5sCMQmAtAgzZtn4+fwhhGQZOdfbIZferQMvWu1raXFmRuQlyJfP/cgn9Jyldf6HlCM/NgGvIqRd8nyzBy2og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5545
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
ICAgLSBpZmRvd24vaWZ1cD8NCj4gICAtIHNlbmRpbmcgb3RoZXIgcGFja2V0cz8NCj4gLSBEb2Vz
IHRoaXMgaGFwcGVuIG9uIGV2ZXJ5IHdha2V1cD8NCj4gLSBJcyB0aGUgd2FrZSB1cCBmcmFtZSBh
bHdheXMgInJlY2VpdmVkIiBhcyA2dGggZnJhbWU/DQo+IC0gSXMgdGhlIHNpdHVhdGlvbiB0aGUg
c2FtZSwgaWYgeW91IGFkZCBzb21lIGRlbGF5IGJldHdlZW4gdGhlIGZyYW1lcywNCj4gICB1c2lu
ZyB0aGUgImNhbmdlbiAtZyBvcHRpb24iPw0KPiAtIEhvdyBiaWcgY2FuIHlvdSBtYWtlIHRoZSAt
ZyB1bnRpbCB0aGUgZnJhbWVzIGFyZSByZWNlaXZlZCBpbiBvcmRlcg0KPiAgIGFnYWluPw0KPiAN
Cj4gVGhlIHJlY2VwdGlvbiBwYXRoIHdvcmtzIGxpa2UgdGhpczoNCj4gSW4gdGhlIGludGVycnVw
dCBoYW5kbGVyIHRoZSByeC1vZmZsb2FkIHJlYWRzIGFsbCBtYWlsYm94ZXMgYmFzZWQgb24gdGhl
IGlmbGFnDQo+IHJlZ2lzdGVyLiBJdCBpdGVyYXRlcyBvdmVyIGFsbCBzZXQgbWFpbGJveGVzLCBz
dGFydGluZyB3aXRoIHRoZSBmaXJzdC4gQWxsIG1haWxib3hlcw0KPiBhcmUgcmVhZCBpbmNsdWRp
bmcgdGhlIHJ4LXRpbWVzdGFtcCwgc29ydGVkIGFuZCBhZGRlZCBpbnRvIGEgcXVldWUuIEF0IHRo
ZSBlbmQNCj4gb2YgdGhlIElSUSBoYW5kbGVyIHRoZSBxdWV1ZSBpcyBhZGRlZCB0byB0aGUgcGVy
IGRldmljZSBxdWV1ZSB0aGF0cyByZWFkIGluIHRoZQ0KPiBOQVBJIGFuZCBwdXNoZWQgaW50byB0
aGUgbmV0d29ya2luZyBzdGFjay4NCj4gDQo+IE1heWJlIHNvbWV0aGluZyB3aXRoIHRoZSB0aW1l
c3RhbXAgb2YgdGhlIGZpcnN0IHBhY2tldCBpcyB3cm9uZywgYXMgdGhlDQo+IGNvdW50ZXIgaXMg
b25seSAxNiBiaXRzIHdpZGUsIGl0IHdpbGwgb3ZlcmZsb3cgcXVpdGUgb2Z0ZW4uDQo+IA0KPiBN
YXliZSB5b3UgY2FuIHRyYWNlX3ByaW50ayB0aGUgbWFpbGJveCBudW1iZXIsIHRpbWVzdGFtcCBh
bmQgY2FuX2lkIGluDQo+IG1haWxib3hfcmVhZCgpIGFuZCBhbmFseXNlIG91dHB1dCBhZnRlciB3
YWtldXAuIEZlZWwgZnJlZSB0byBwb3N0IHRoZSBvdXRwdXQNCj4gb2YgdGhlIHRyYWNlciBoZXJl
Lg0KDQpIaSBNYXJjLA0KDQoJZWNobyAxID4gL3N5cy9rZXJuZWwvZGVidWcvdHJhY2luZy90cmFj
aW5nX29uDQoNCgl0cmFjZV9wcmludGsoIlxubWFpbGJveF9udW0gPSAldSwgdGltZXN0YW1wID0g
JXUsIGNhbl9pZCA9ICV4XG4iLCBuLCB0aW1lc3RhbXAsIGNmZC0+Y2FuX2lkKTsgIEFkZCBpbiBt
YWlsYm94X3JlYWQoKSwgYnV0IGlzIHByaW50IG5vdGhpbmcsIGNvdWxkIHlvdSBnaXZlIG1lIHNv
bWUgZ3VpZGFuY2U/DQoNCglJIGFsd2F5cyB1c2UgcHJpbnRrKCkgdG8gZGVidWcsIGJ1dCBJIHRo
aW5rIGl0IGNhbm5vdCBwcmludCB1bnRpbCBzdXNwZW5kIGV4aXQgdG90YWxseSwgc28gZHVtcCBt
YWlsYm94IG51bSwgdGltZXN0YW1wLCBhbmQgY2FuIGlkIGZhaWxlZCBiZWZvcmUuDQoNCkJlc3Qg
UmVnYXJkcywNCkpvYWtpbSBaaGFuZw0KPiByZWdhcmRzLA0KPiBNYXJjDQo+IA0KPiAtLQ0KPiBQ
ZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICB8IE1hcmMgS2xlaW5lLUJ1ZGRlICAgICAg
ICAgICB8DQo+IEVtYmVkZGVkIExpbnV4ICAgICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cu
cGVuZ3V0cm9uaXguZGUgIHwNCj4gVmVydHJldHVuZyBXZXN0L0RvcnRtdW5kICAgICAgICAgfCBQ
aG9uZTogKzQ5LTIzMS0yODI2LTkyNCAgICAgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBI
UkEgMjY4NiB8IEZheDogICArNDktNTEyMS0yMDY5MTctNTU1NSB8DQoNCg==
