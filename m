Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 513B0F8D6E
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2019 12:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfKLLCN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Nov 2019 06:02:13 -0500
Received: from mail-eopbgr150045.outbound.protection.outlook.com ([40.107.15.45]:36030
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbfKLLCN (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 12 Nov 2019 06:02:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qkx2LFHt/mHRmy8/XXf75uWR2tz/sWnTyb4ry2MAG4Mxcd4UQLFHo999cYffdAIDkDDeukoawlUF34KHJwDrJ0jab36X++afY59uqcnOOJ4CSdhdPh+eheFGI07tNL5FY2KjAlHAIchfHW6uNdCOuUMfZpsocTi+GWOCRhMB1msrg6FJOVgBlxCeI7XdFITcOovioBl05YRtBomb9+ARbtlYmAPwO3mXWWdkWbHyYLQRWnhD8er3H64Kqx8DEtvMydxJbFmWtxa6tf1y1AwcjPrhSPXH4XVpgo0VVVdKGZHgfXmQR6qVpETyHnm9H/VQwbgN2CewuDXivso5RjrAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvQVQdD311wi8dMnBKgk82aAZyVS9RY/HfoO2H1yBCc=;
 b=e+w1TyYoufKYM3jQpL1uysV2XP4gftfvanE6VabRNxbWXP03mimWjAEDenXcNLwBkcy+o+YNIBjSHZV6HrGvtcmjC14ZyU3zkfABq5lVhihKWS2AJCl2fGorRLYcErKKQQZcxSKKrpFaaYAi7Byk8HQoaDLY7pxqxFuZBs1eDCgBs7A+wMSkWwq9SVk5du6tX3ziuoeMUmOg9u3LSSJFxdEzVsgG3mPnhA4DU0GXI8R7RD5a7iRbQnKpuDcrstFy6b64yMdyRkz9G1FeeJJasokpwBmQrtqfpHzkJUA1/FcjBH5yP31apXr1ZcBtFbIxi84MyPjChx9qoTYXxWNzcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvQVQdD311wi8dMnBKgk82aAZyVS9RY/HfoO2H1yBCc=;
 b=K3NZtjWGpKwFdexEz7agjh7NPA7NfM7sCGhq5fJuD9M/vz/DnH962BMF6WLRFIGVgHVPrtIZlyWUjIS7vKHci0Rpn86dkmx6CSSV4bENVTgV5QgL9gJz5PbJzQ7trbF+Ds2h6oyRKa5njgLUnPNEvQgDSkopg1caTzXI8sQnFGc=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB5130.eurprd04.prod.outlook.com (20.176.233.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 11:02:07 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 11:02:07 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "sean@geanix.com" <sean@geanix.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Topic: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Index: AdWYdOEh/tYWI8MXSASMqe9cVeZH0AAAx0KAACvRiZAAA1AVAAAAc9fQAACXyQAAAWdfoAACB6aAAAAdeDA=
Date:   Tue, 12 Nov 2019 11:02:07 +0000
Message-ID: <DB7PR04MB4618888D202DAC80E6CC1BE6E6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <DB7PR04MB4618BF9DE9152B2F1D49A702E6740@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <bcbae072-3aec-34f7-9b7e-58d78000bd39@pengutronix.de>
 <DB7PR04MB4618061107733A9D53F75FA3E6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <a232c1f6-cd91-8526-6fc9-163e9500bdf9@pengutronix.de>
 <DB7PR04MB4618BCC08EE8A9BDDA208C2AE6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <65288408-c12b-8a5f-9b56-132f0f4b3057@pengutronix.de>
 <DB7PR04MB4618C4D57D79DF5CE1CE5FBBE6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <ea3765aa-25ab-fe12-3c95-8444a75641dc@pengutronix.de>
In-Reply-To: <ea3765aa-25ab-fe12-3c95-8444a75641dc@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63b1d2bb-f88f-45b8-4803-08d7675fc27b
x-ms-traffictypediagnostic: DB7PR04MB5130:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR04MB5130DF192740CE32361FE978E6770@DB7PR04MB5130.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(199004)(189003)(13464003)(66946007)(74316002)(66476007)(8936002)(486006)(52536014)(26005)(6306002)(2501003)(3846002)(6436002)(6116002)(66446008)(9686003)(66556008)(64756008)(81156014)(186003)(81166006)(33656002)(55016002)(6506007)(476003)(8676002)(53546011)(256004)(110136005)(102836004)(14444005)(305945005)(76116006)(316002)(7736002)(71200400001)(71190400001)(2201001)(229853002)(86362001)(966005)(11346002)(2906002)(14454004)(446003)(6246003)(25786009)(478600001)(99286004)(66066001)(5660300002)(76176011)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5130;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VCFNRbPnrKpFBtR/Usg2n/u1u0caCYsWBdYWDslKz5jcZX3CfbFigMzDTehpo0amVmSDPYvs6HSXAfjHybB2vfW/HisWFeh/7JfoKD28Bie1PzGLDKK9mPPaHbdy2Uow87bd+0MByKnXlBnl6nZ3MJw5YqtfmLfWbsnbRbDT1Ev2bL2EO4Ifg5Mqb05NtLDsAvXb1zkSfWl8ZUsJ/j1JKZbLZ8F5lVq5lTGVG+/tEnIY1yQrG0xAupkSq1sCnbUpjMeEo5RqcjhkrbcB/SkrZcmt8a+J4X5MXtXzGpzQp0HDmK3aowAdQb28i3at2cpqYJdxsjCYCOdJJKOXndOsd0kgRd233QhyqmKs1ddhLZvoU75H4hO5/XMESMvp8LwxDJTGUFCru8TpioggkSTqs04SezdZIM48kwkwvpOhidw5A0xphVhRKUdY4uG/ceoFR7YAt1hfUJchUcvytfgwwM7WXhldFF/vnQSthjgkWoo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b1d2bb-f88f-45b8-4803-08d7675fc27b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 11:02:07.7748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: okzZ6+5MVyZDRWo0qdQR936gxkFZLo4RvJ63bLPUBxR9gUNXHGh4PcbhNU/ng3YKPKxvPmX6/pQwYaMwnYLJPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5130
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMTnlubQxMeaciDEy5pelIDE4OjQ2DQo+
IFRvOiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsgc2VhbkBnZWFuaXgu
Y29tOw0KPiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBXYWtlIHVw
IGlzc3VlIGFib3V0IEZsZXhjYW4gZHJpdmVyIGluIHY1LjQga2VybmVsDQo+IA0KPiBPbiAxMS8x
Mi8xOSAxMDo1MyBBTSwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+Pj4+IFllcywgdGhlc2UgdGlt
ZXN0YW1wcyBhcmUgYWxsIG92ZXIgdGhlIHBsYWNlLiBJdCdzIGR1ZSB0byB0aGUgImJpZyINCj4g
Pj4+PiBnYXAgb2YgMTAwbXMgYmV0d2VlbiB0aGUgQ0FOIGZyYW1lcy4gV2hhdCdzIHRoZSBjb25m
aWd1cmVkIGJpdHJhdGUNCj4gPj4+PiBvZg0KPiA+PiB5b3VyIGJ1cz8NCj4gPj4+DQo+ID4+PiBp
cCBsaW5rIHNldCBjYW4wIHVwIHR5cGUgY2FuIGJpdHJhdGUgMTAwMDAwMA0KPiA+Pg0KPiA+PiBX
aXRoIDFNYml0L3MgeW91IGhhdmUgb3ZlcnJ1bnMgZXZlcnkgNjVtcyAod29yc3QgY2FzZSkuDQo+
ID4NCj4gPiBZZXMuIFdoYXQncyB0aGUgYml0cmF0ZSB5b3Ugd2FudCBtZSBoYXZlIGEgdGVzdD8N
Cj4gDQo+IERvbid0IGtub3csIGFsbCA6KQ0KPiANCj4gPiBJIGhhdmUgYSBxdWVzdGlvbiwgbWFp
bGJveCByZWFkIGhhcyB0YWtlbiBjb3VudGVyIG92ZXJmbG93IGludG8NCj4gPiBjb25zaWRlcmF0
aW9uLCB3aHkgZG9lcyBvdmVyZmxvdyBxdWl0ZSBvZnRlbiB3aWxsIGNhdXNlIHRoZSBmcmFtZQ0K
PiA+IGRpc29yZGVyPw0KPiANCj4gSWYgeW91IHNlbmQgcGFja2V0IHdpdGggMTAwbXMgZGVsYXkg
YW5kIGhhdmUgNiBwYWNrZXRzIGluIHRoZSBtYWlsYm94ZXMsIHRoaXMNCj4gbWVhbnMgeW91IGhh
dmUgbW9yZSB0aGFuIDEwIGNvdW50ZXIgb3ZlcmZsb3dzLiBUaGlzIG1lYW5zIGl0J3MgaW1wb3Nz
aWJsZSB0bw0KPiBzb3J0IHRoZSBDQU4gZnJhbWVzIGJ5IHRpbWVzdGFtcC4NCg0KT2guLi4gVW5k
ZXJzdG9vZCwgdGhhbmtzIGEgbG90IQ0KDQo+IFdoeSBkb2VzIHRoZSB3YWtldXAgZnJvbSBmaXJz
dCBwYWNrZXQgdG8gSVJRIGhhbmRsZXIgdGFrZSBzbyBsb25nPw0KDQpJIGRvbid0IGtub3csIEkg
dXNlZCB0aGUgdXBzdHJlYW0gZHJpdmVyLCBpbiBvdXIgbG9jYWwgNC4xOSwgb25seSAxIHBhY2tl
dCBpbiB0aGUgbWFpbGJveCB3aGVuIHJlc3VtZSBiYWNrLg0KDQo+IEkgc3VnZ2VzdCB0byBzZXQg
YSBmbGFnIGluIHRoZSBzdXNwZW5kIGhhbmRsZXIgYW5kIGV2YWx1YXRlIHRoZSBmbGFnIGluIHRo
ZQ0KPiBpbnRlcnJ1cHQgaGFuZGxlci4gSWYgdGhlIGZsYWcgaXMgc2V0LCB3ZSBoYXZlIHRvIGln
bm9yZSB0aGUgdGltZXN0YW1wLg0KDQpOb3QgcXVpdGUgdW5kZXJzdGFuZCwgY291bGQgeW91IGV4
cGxhaW4gbW9yZT8gVGhhbmtzIPCfmIkNCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQo+
IE1hcmMNCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgIHwgTWFy
YyBLbGVpbmUtQnVkZGUgICAgICAgICAgIHwNCj4gRW1iZWRkZWQgTGludXggICAgICAgICAgICAg
ICAgICAgfCBodHRwczovL3d3dy5wZW5ndXRyb25peC5kZSAgfA0KPiBWZXJ0cmV0dW5nIFdlc3Qv
RG9ydG11bmQgICAgICAgICB8IFBob25lOiArNDktMjMxLTI4MjYtOTI0ICAgICB8DQo+IEFtdHNn
ZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2IHwgRmF4OiAgICs0OS01MTIxLTIwNjkxNy01NTU1
IHwNCg0K
