Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E782FF7290
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2019 11:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfKKK5u (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Nov 2019 05:57:50 -0500
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:26784
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbfKKK5u (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 11 Nov 2019 05:57:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UetgKhal5vMYgSlhJDrEmX0QNm1ziyqCt6YFxwrrYl0NO+QJKg17xhujkOpb854/jL/V3I9IzOe06JOaoSvc+O6Q3IlUeIUV3PgeRkc76IXwVMFSLUtkNuxDtr6So5yJtsOGIDCuDE+Lva3mbHkSTWFRrJKXzlq6WpraiHNybVsxp52O7mGcBEfhpF2xg6I/aHg+X8fWSIxAoamMmVvYb+hGdiNPnzspa6vTboCW7eeYWPga4FmRtsvCcMj+kEg+T+zrkhKiMKhauJoDJ8Os4cITUH5g04OKk3wUZTK1LMAk7pQMJ6orlIDOTyvNq7AZ9O9kP6eKXpEtWYtZB7m6FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix04Huk9/S8V0MyhIkB6Ye2WAMKxZ0sBcqgRHaoKnE0=;
 b=KGo1VANYlub+ITRJU0SSBwa5Qc16XkXzOwMEXNEHLW1vNKyipLS7uxWeFyLVQPAKBqbbyQJUJwp6BRpjb1CGBEHsOI8qziy1iudlrblw3OzKPhudwbC2gzYsPzB42X19EmqFvQ7r9bkJEzs1z9ZoFVDnP+qVFvan9SmbO9nO37fQJhlEX4HlX2YKO4Y6LWl3R1+pfsap6VCEow/4QDmRi3FJbAGICSbve/jqyZpUT5mri+tHlgovWt80ptg3kOSySj85AA9CWjVt32Hk8Xyb/8NqchNk21eeUEhWfzib4ETxmELBvtnAnlZ4x6Yot9Jx68IlVKb+FNGXIBsGfCznKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix04Huk9/S8V0MyhIkB6Ye2WAMKxZ0sBcqgRHaoKnE0=;
 b=DOlxNTPI9u/vLwQUSD1W9rZT2YiKPK/AqUz1tiM8EbK3dhAIx7/hVUQsQu+p6ehGclS2weMoAYplJDPntGY3R2wWtcKdikVXRSxieVqJGyH31FYYdk4h1SRNoGgrEUGYGjiTQE46ONbykK6JhrihyV9P0w4lVmTKAuqDeD+Cohg=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB4266.eurprd04.prod.outlook.com (52.135.130.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Mon, 11 Nov 2019 10:57:45 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6%4]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 10:57:45 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "sean@geanix.com" <sean@geanix.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Topic: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Index: AdWYdOEh/tYWI8MXSASMqe9cVeZH0AAAx0KAAAByFCAAASdogAAAErMQ
Date:   Mon, 11 Nov 2019 10:57:45 +0000
Message-ID: <DB7PR04MB4618135E5FF6DCAECFC9CDB4E6740@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <DB7PR04MB4618BF9DE9152B2F1D49A702E6740@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <bcbae072-3aec-34f7-9b7e-58d78000bd39@pengutronix.de>
 <DB7PR04MB461893DB29EE914EEEF410CDE6740@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <70afffbc-344c-cbde-b602-6d32db1f2cd3@pengutronix.de>
In-Reply-To: <70afffbc-344c-cbde-b602-6d32db1f2cd3@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 570ad377-1f75-44db-afd3-08d76695fbcd
x-ms-traffictypediagnostic: DB7PR04MB4266:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <DB7PR04MB4266F485CA307484AD04D711E6740@DB7PR04MB4266.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(189003)(13464003)(199004)(256004)(966005)(478600001)(6116002)(6436002)(110136005)(102836004)(14444005)(99286004)(25786009)(316002)(3846002)(71200400001)(74316002)(305945005)(486006)(26005)(86362001)(71190400001)(81166006)(81156014)(6246003)(8936002)(14454004)(8676002)(7736002)(2906002)(6306002)(2201001)(446003)(11346002)(52536014)(9686003)(2501003)(476003)(55016002)(66946007)(5660300002)(7696005)(76176011)(229853002)(186003)(66066001)(53546011)(6506007)(66556008)(66476007)(64756008)(66446008)(76116006)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4266;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MelU3F96VlAdH1ZL2LMw2csnGVy91JwAQVsOg3shnOrcpHugBpGtPFWoHhtRHgp44Bsye3zXg7kPI3V+SonhKQgvZbKHQ64VtuuWBZ2+PbjEa+e1KWSZ+j57nmKgO6NGhMJtULk53p5aXis0Nm30iQLIFPBAPCBwtQpVJvtC8X0ORT3IEzFs6CWdz1CMjh1tiAfBNPKM8OZZfZJk2r1T3rasrc0ND3XaL2na+rJFvNdCIAkga9JXnLinpnZl7P/vPYXQfviKXFEFKQR6adHxXUVbf0G+EMMlnmRmu8u5KGxZ/m7GIIb97YRsTyWstgvtRHgspSmAYx7oHOy0qATodc5HgaCPX5xTseC4AuS+IcZMnOyzMJmYj4TsmzBxk3CN2E7JipSGTaZMug8Ftf5PFxdMILoij4wQP5GbLcEDJT9PUKnKFQ3WWW1lkcgry+nWHEB8L4zMMDLG7WrnuKdS5DAY5z8n9U4JWNUtu7AXvP4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570ad377-1f75-44db-afd3-08d76695fbcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 10:57:45.5496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lwXF0Ks0ss0zrqT1Y+fPBAfNxFMR3UVeFkUnFqJFDH6n+AkgMSxVvgrin80Z2k3TXAouNGQxokF4G5XKsemYkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4266
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMTnlubQxMeaciDEx5pelIDE4OjU0DQo+
IFRvOiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsgc2VhbkBnZWFuaXgu
Y29tOw0KPiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBXYWtlIHVw
IGlzc3VlIGFib3V0IEZsZXhjYW4gZHJpdmVyIGluIHY1LjQga2VybmVsDQo+IA0KPiBPbiAxMS8x
MS8xOSAxMTozNiBBTSwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+PiAtIFdoYXQgZGlkIHlvdSBk
byBiZWZvcmUgd2FrZXVwPw0KPiA+PiAgIC0gQ2xlYW4gcmVib290Pw0KPiA+PiAgIC0gaWZkb3du
L2lmdXA/DQo+ID4NCj4gPiAJQ2xlYW4gYm9vdA0KPiANCj4gRmluZSwgc28gdGhlIGNoaXAgc2hv
dWxkIGZpbGwgbWFpbGJveCAwIGZpcnN0Lg0KPiANCj4gPiAJU2VuZGVyIHNpZGU6DQo+ID4gCWlw
IGxpbmsgc2V0IGNhbjAgdXAgdHlwZSBjYW4gYml0cmF0ZSAxMDAwMDAwDQo+ID4gCWVjaG8gZW5h
YmxlZCA+DQo+IC9zeXMvYnVzL3BsYXRmb3JtL2RyaXZlcnMvZmxleGNhbi8zMGExMDAwMC5jYW93
ZXIvd2FrZXVwDQo+ID4gCWNhbmR1bXAgY2FuMCAmDQo+ID4gCWVjaG8gbWVtID4gL3N5cy9wb3dl
ci9zdGF0ZQ0KPiA+DQo+ID4gCVJlY2VpdmUgc2lkZToNCj4gPiAJaXAgbGluayBzZXQgY2FuMCB1
cCB0eXBlIGNhbiBiaXRyYXRlIDEwMDAwMDANCj4gPiAJY2FuZ2VuIGNhbjAgLXZ2DQo+ID4NCj4g
Pj4gICAtIHNlbmRpbmcgb3RoZXIgcGFja2V0cz8NCj4gPiAJTm8uDQo+ID4+IC0gRG9lcyB0aGlz
IGhhcHBlbiBvbiBldmVyeSB3YWtldXA/DQo+ID4gCVllcy4NCj4gPj4gLSBJcyB0aGUgd2FrZSB1
cCBmcmFtZSBhbHdheXMgInJlY2VpdmVkIiBhcyA2dGggZnJhbWU/DQo+ID4gCU5vLCBkaWZmZXJl
bnQgd2l0aCBkaWZmZXJlbnQgZnJhbWUgZ2FwLg0KPiANCj4gSWYgdGhlIGZyYW1lIGdhcCBpcyB1
bmNoYW5nZWQsIGRvZXMgdGhlIG9yZGVyIGNoYW5nZT8NCgkNCglObywgaXQgd2lsbCBub3QgY2hh
bmdlLg0KPiA+PiAtIElzIHRoZSBzaXR1YXRpb24gdGhlIHNhbWUsIGlmIHlvdSBhZGQgc29tZSBk
ZWxheSBiZXR3ZWVuIHRoZSBmcmFtZXMsDQo+ID4+ICAgdXNpbmcgdGhlICJjYW5nZW4gLWcgb3B0
aW9uIj8NCj4gPiAJVGhlIHNpdHVhdGlvbiBpcyBkaWZmZXJlbnQgd2l0aCBkaWZmZXJlbnQgImNh
bmdlbiAtZyBvcHRpb24iDQo+ID4+IC0gSG93IGJpZyBjYW4geW91IG1ha2UgdGhlIC1nIHVudGls
IHRoZSBmcmFtZXMgYXJlIHJlY2VpdmVkIGluIG9yZGVyDQo+ID4+ICAgYWdhaW4/DQo+ID4gCUkg
YW0gbm90IHN1cmUsIEkgY2FuIGRvIGEgdGVzdCBsYXRlci4NCj4gPg0KPiA+PiBUaGUgcmVjZXB0
aW9uIHBhdGggd29ya3MgbGlrZSB0aGlzOg0KPiA+PiBJbiB0aGUgaW50ZXJydXB0IGhhbmRsZXIg
dGhlIHJ4LW9mZmxvYWQgcmVhZHMgYWxsIG1haWxib3hlcyBiYXNlZCBvbg0KPiA+PiB0aGUgaWZs
YWcgcmVnaXN0ZXIuIEl0IGl0ZXJhdGVzIG92ZXIgYWxsIHNldCBtYWlsYm94ZXMsIHN0YXJ0aW5n
IHdpdGgNCj4gPj4gdGhlIGZpcnN0LiBBbGwgbWFpbGJveGVzIGFyZSByZWFkIGluY2x1ZGluZyB0
aGUgcngtdGltZXN0YW1wLCBzb3J0ZWQNCj4gPj4gYW5kIGFkZGVkIGludG8gYSBxdWV1ZS4gQXQg
dGhlIGVuZCBvZiB0aGUgSVJRIGhhbmRsZXIgdGhlIHF1ZXVlIGlzDQo+ID4+IGFkZGVkIHRvIHRo
ZSBwZXIgZGV2aWNlIHF1ZXVlIHRoYXRzIHJlYWQgaW4gdGhlIE5BUEkgYW5kIHB1c2hlZCBpbnRv
IHRoZQ0KPiBuZXR3b3JraW5nIHN0YWNrLg0KPiA+Pg0KPiA+PiBNYXliZSBzb21ldGhpbmcgd2l0
aCB0aGUgdGltZXN0YW1wIG9mIHRoZSBmaXJzdCBwYWNrZXQgaXMgd3JvbmcsIGFzDQo+ID4+IHRo
ZSBjb3VudGVyIGlzIG9ubHkgMTYgYml0cyB3aWRlLCBpdCB3aWxsIG92ZXJmbG93IHF1aXRlIG9m
dGVuLg0KPiA+Pg0KPiA+PiBNYXliZSB5b3UgY2FuIHRyYWNlX3ByaW50ayB0aGUgbWFpbGJveCBu
dW1iZXIsIHRpbWVzdGFtcCBhbmQgY2FuX2lkDQo+ID4+IGluDQo+ID4+IG1haWxib3hfcmVhZCgp
IGFuZCBhbmFseXNlIG91dHB1dCBhZnRlciB3YWtldXAuIEZlZWwgZnJlZSB0byBwb3N0IHRoZQ0K
PiA+PiBvdXRwdXQgb2YgdGhlIHRyYWNlciBoZXJlLg0KPiA+DQo+ID4gSSBhbHNvIHN1c3BlY3Qg
dGhpcywgYnV0IEkgY2hlY2sgdGhlIGZsb3cgb2YgdGhlIHJlY2VpdmUgcGF0aCBpcyB0aGUNCj4g
PiBzYW1lIHdpdGggdjQuMTQgYW5kIHY0LjE5Lg0KPiA+DQo+ID4gQW5vdGhlciB0aGluZyBjb25m
dXNlZCBtZSBpcyB0aGF0IGhvdyBkb2VzIHRoZSBkcml2ZXIgaGFuZGxlIHRoZQ0KPiA+IGNvdW50
ZXIgb3ZlcmZsb3cuIElmIHRoZSBjb3VudGVyIG92ZXJmbG93IGluIG9uZSByb3VuZCBtYWlsYm94
IHJlYWQsDQo+ID4gdGhlIHJlY2VpdmUgb3JkZXIgaXMgbm90IGNvbnNpc3RlbnQgd2l0aCByZWFs
aXR5LiBJIGRvIG5vdCB0aGUgaGFuZGxlDQo+ID4gb2YgdGhpcyBjYXNlIGluIGRyaXZlci4NCj4g
DQo+IFRoZSBvdmVyZmxvdyBoYW5kbGluZyBjb25zaXN0cyBvZiB0d28gdHJpY2tzOg0KPiANCj4g
MSkgTWFrZSB0aGUgMTYgYml0IHRpbWVzdGFtcCBhIDMyIGJpdCBvbmU6DQo+IA0KPiBodHRwczov
L2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvbmV0L2Nhbi9m
bGV4Y2FuLmMjTDgwMA0KPiANCj4gMikgU3VidHJhY3QgdHdvIHUzMiB0aW1lc3RhbXBzIGFuZCB0
cmVhdCByZXN1bHQgYXMgKHNpbmdlZCkgaW50Lg0KPiANCj4gICAgQSB1MzIgb3ZlcmZsb3dzIGF0
IDJeMzIgPSA0Mjk0OTY3Mjk1ID0gMHhmZmZmZmZmZg0KPiAgICAyXjMyICsgMSA9IDEgPSAweDAw
MDAwMDAxDQo+IA0KPiAgICBBIHMzMiBvdmVyZmxvd3MgMjE0NzQ4MzY0NyB0byAtMjE0NzQ4MzY0
OCA9DQo+ICAgIDB4N2ZmZmZmZmYgdG8gMHg4MDAwMDAwMC4NCj4gDQo+ICAgIExldCdzIGFzc3Vt
ZSBvbmUgZnJhbWUgYXJyaXZlcyBhdDoNCj4gICAgMHhmZmZmZmZmZSBhbmQgdGhlIG5leHQgb25l
IDB4MDAwMDAwMDIuDQo+ICAgIFRoZSBkaWZmZXJlbmNlIGZyb20gbmV3IHRvIG9sZCBpcyAtNDoN
Cj4gICAgMHgwMDAwMDAwMiAtIDB4ZmZmZmZmZmUgPSAweGZmZmZmZmZjDQo+ICAgIEludGVycHJl
dGluZyAweGZmZmZmZmZjIGFzIGEgc2lnbmVkIHZhbHVlIG1lYW5zIC00Lg0KPiANCj4gICAgVGhl
IHRyaWNrIGJhc2ljYWxseSBtb3ZlcyB0aGUgb3ZlcmZsb3cgZnJvbSAweGZmZmZmZmZmIHRvIDB4
N2ZmZmZmZmYuDQo+IA0KPiANCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0
ZXN0L3NvdXJjZS9kcml2ZXJzL25ldC9jYW4vcngtb2ZmbG9hZC5jI0wxMA0KPiA3DQoNClRoYW5r
cywgSSB3aWxsIGxlYXJuIGl0IGxhdGVyLg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcN
Cj4gPiBJIHdpbGwgdXNlIHRoZSB0cmFjZV9wcmludGsoKSB0byBwb3N0IHRoZSBvdXRwdXQgaGVy
ZS4NCj4gDQo+IE1hcmMNCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAg
ICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUgICAgICAgICAgIHwNCj4gRW1iZWRkZWQgTGludXggICAg
ICAgICAgICAgICAgICAgfCBodHRwczovL3d3dy5wZW5ndXRyb25peC5kZSAgfA0KPiBWZXJ0cmV0
dW5nIFdlc3QvRG9ydG11bmQgICAgICAgICB8IFBob25lOiArNDktMjMxLTI4MjYtOTI0ICAgICB8
DQo+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2IHwgRmF4OiAgICs0OS01MTIxLTIw
NjkxNy01NTU1IHwNCg0K
