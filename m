Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135041F9506
	for <lists+linux-can@lfdr.de>; Mon, 15 Jun 2020 13:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgFOLLW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 15 Jun 2020 07:11:22 -0400
Received: from mail-eopbgr140115.outbound.protection.outlook.com ([40.107.14.115]:52550
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728285AbgFOLLW (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 15 Jun 2020 07:11:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C98V40EAzu2wcKbMbsp97yTyFAaFGk0CbjIKtpb4pHaGj1RRgjf//nK/1APwUF0h1qeNhVze9uYVMe9a4Pj9T5q6E3c04iWJVZhYzZmk1lgcBGM6hpNc49elrK+3IXeIkD5ZJpetaZu/M09PZWonflVAapV6LiqVurbkZuLAg6SeuKCdVllsSv1JOqwLV18Cz28IZMbC3QF6yJ5bFQJlsK1ASwvcoz5FoS5K5b15iEplPAxnOgRHnFHV94db3SD9LxioaO5jHlINLZrElWc8oDbAwObPZPhKchgtZ3zFLhG7qJ8Qlw2AgX3BVNVWOryLUIZmmoOqIrL2P3x8OPc8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bv6KwY43H7w80Op9mnmLYroWVzFErG6lMfxEuY2tvSQ=;
 b=RGPqROh/BoROOh0YxsA54C0uxg1/YfVfKj8W+rDfjBnDzhVgTCmwjtMy55ZjmvcCfbeHRyqeXgctgpg6Fze0OaJ5KTETQTP30qUn4fOtFkn9FCYVGhSMsJH+hZxAyxUGyLfoZb5s21d6PKmgqbmtvm0ZQnCbTn8uI2jWzNWHvsDyF0OMyWkY3VC9d52/H/99uXVNMgC4AjMqYBqM6CRTNEJzCrSpw4k0EPytHFWQSU49A6qM86x7zzT5o0OTctLXwcaoHE4Gj0nZc556CWVq1WDTGFLcz7sJoEqyzVF1gWwLBrocItKFchdY6FHbANRdhetZ2RYCQ/VZQAxzVIMrrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sma.de; dmarc=pass action=none header.from=sma.de; dkim=pass
 header.d=sma.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sma.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bv6KwY43H7w80Op9mnmLYroWVzFErG6lMfxEuY2tvSQ=;
 b=uqM8IBzVKtU8hgv2W1mksUflE6Yn6fLEV20f6pmKNHFhd4ZVTnB8Un93PHkV/Yr0CmeS7HBfqfUjWw+ecGfMobnvgJfIH+NZfcoO+Z3UB0V5r4W3imavN9uPEU7LsdanM1hKXGZWpEt7Mhsioiq9ESE5knjp80t6rXRklbCORbo=
Received: from AM0PR04MB6273.eurprd04.prod.outlook.com (2603:10a6:208:137::18)
 by AM0PR04MB6162.eurprd04.prod.outlook.com (2603:10a6:208:147::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.20; Mon, 15 Jun
 2020 11:11:17 +0000
Received: from AM0PR04MB6273.eurprd04.prod.outlook.com
 ([fe80::d016:2e70:4030:4fdc]) by AM0PR04MB6273.eurprd04.prod.outlook.com
 ([fe80::d016:2e70:4030:4fdc%6]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 11:11:17 +0000
From:   Felix Riemann <Felix.Riemann@sma.de>
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Andre Kalb <Andre.Kalb@sma.de>
Subject: RE: [PATCH] can: c_can: Handle lost bus-off interrupt while IRQs are
 disabled
Thread-Topic: [PATCH] can: c_can: Handle lost bus-off interrupt while IRQs are
 disabled
Thread-Index: AQHWA1tqGNdHGBlIIU2zdPpKElX6gKha4XMAgAAHV9CAAFzIgIAA8mwAgASDhoCAAKhIwIAumyKAgAAFPQCAQe+IcIADFsMAgAAI+4CABPAU0A==
Date:   Mon, 15 Jun 2020 11:11:17 +0000
Message-ID: <AM0PR04MB62731627E4FC7368DB5051D4889C0@AM0PR04MB6273.eurprd04.prod.outlook.com>
References: <20200326134015.GC27785@x1.vandijck-laurijssen.be>
 <AM0PR04MB5427D3BF64C3D3DA3961920488CF0@AM0PR04MB5427.eurprd04.prod.outlook.com>
 <20200326193837.GF760@x1.vandijck-laurijssen.be>
 <AM0PR04MB542742337A89900E12A8732288CC0@AM0PR04MB5427.eurprd04.prod.outlook.com>
 <20200330070203.GE22500@x1.vandijck-laurijssen.be>
 <AM0PR04MB54271EA5CC205263750BDBD288CB0@AM0PR04MB5427.eurprd04.prod.outlook.com>
 <20200429084733.GA27733@x1.vandijck-laurijssen.be>
 <20200429090618.GB27733@x1.vandijck-laurijssen.be>
 <AM0PR04MB6273640802E04C4009CE5BC588830@AM0PR04MB6273.eurprd04.prod.outlook.com>
 <20200612071044.GA25294@x1.vandijck-laurijssen.be>
 <20200612074253.GB25294@x1.vandijck-laurijssen.be>
In-Reply-To: <20200612074253.GB25294@x1.vandijck-laurijssen.be>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vandijck-laurijssen.be; dkim=none (message not signed)
 header.d=none;vandijck-laurijssen.be; dmarc=none action=none
 header.from=sma.de;
x-originating-ip: [93.209.171.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22eecfe5-d54b-4118-2912-08d8111cd365
x-ms-traffictypediagnostic: AM0PR04MB6162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB61622C1744C74A2EE5AE9186889C0@AM0PR04MB6162.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xBrIP9atUIZ4Pz6eVL56RV7Lj/zCJD/bftDHI42oBS/0gui2J4d8n8Ah8YYal2DH7q/x6zhFRTiACgkQ537vEgjIlhID/bVjNQTgZDniWjUvqmuE6sr0Xx/pBc8NeEAIpCGVe0CEGoPctcaZcjrwb6GHKBK6Rf+K/9rQKd/27AbFp/dx3jqdQMsrZxjWwus0wIrvYiSUBMhesqvkTkpXkx+wta84XopQTDYLlK4oaAZmRNvlQV3/dDp3IvJGxopBF6UqbXHyBTQl03Bd8B1XlBWBdoI+iDyNKczm5YlpHxI5PW2FL+QdKI4mehLe7iHyGhr3RQ272Q1f1M4bHv7x2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6273.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39850400004)(186003)(26005)(8936002)(8676002)(33656002)(71200400001)(54906003)(7696005)(53546011)(2906002)(6506007)(316002)(76116006)(64756008)(66946007)(66446008)(66476007)(66556008)(6916009)(4326008)(86362001)(5660300002)(52536014)(478600001)(9686003)(55016002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BaN07wV2X5VnWeG5m1bHibsseJ5RVXawvmFBmtbfmezxDWfou1lqVK7gDHvWTIKcA3ORqbeV8fTOni6oKrEVbdBtslMInvrX3O7FK4jwZks3aBXSMPAu31Gs9M9HAfSpMv1gHYGyXOOLw4460AahrTCDwrgBTiNoMMhXZKuHtJ3y237H4E+L4nBN7x6BtDwXCOtZr4B6uZdaT2c/S5ohhHtFhcPQdAuTzB5H3RIp2ofhAtDilK1hR9Oiu7nQeiEgkOzyQR4Yoa2YWHvove9S/B8yKVgW1IAtaHPy2ar/p08AfrDELxg/sP/h7H3YKlt7hdDS+U5W9Z3ScSfrlU7IGQxF1gPzWxoSNd7zMsSU6BYASzHmyFgmGmLkjNxmxRmE7/v/fU2ATPvDWJ4rvdSNHv8xbL/En06n35Sgz5nLpw+TaOLJcIfwYTSvqhW7GDkJw0ZHt1nLEuT2TyAgRUJk6t2wgAdwKTd1irJoHQiEhcRJAf4cxObT3aM25wSim4xi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sma.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 22eecfe5-d54b-4118-2912-08d8111cd365
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 11:11:17.5294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a059b96c-2829-4d11-8837-4cc1ff84735d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BtRLSUAROHwS/Gvl2xIeym77PopziemhE3mU7/4yeKPEwRExULH4rd5tpL8/oOL+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6162
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgS3VydCwNCg0Kc2VlIGJlbG93Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IEt1cnQgVmFuIERpamNrIDxkZXYua3VydEB2YW5kaWpjay1sYXVyaWpzc2VuLmJlPg0K
PiBTZW50OiBGcmlkYXksIEp1bmUgMTIsIDIwMjAgOTo0MyBBTQ0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBjYW46IGNfY2FuOiBIYW5kbGUgbG9zdCBidXMtb2ZmIGludGVycnVwdCB3aGlsZSBJUlFz
IGFyZQ0KPiBkaXNhYmxlZA0KPg0KPiBIaSBGZWxpeCwNCj4NCj4gTmV4dCBxdWVzdGlvbiBjb21l
cyB1cC4NCj4gU2VlIGlubGluZS4NCj4NCj4gT24gdnIsIDEyIGp1biAyMDIwIDA5OjEwOjQ0ICsw
MjAwLCBLdXJ0IFZhbiBEaWpjayB3cm90ZToNCj4gPiBUaGFua3MgZm9yIHZlcmlmeWluZywNCj4g
Pg0KPiA+IEknbGwgdGFrZSBhIGxvb2sgaG93IHRoYXQgY2FuIGhhcHBlbi4NCj4gPg0KPiA+IEkg
dGhpbmsgcGFja2V0IGxvc3MgaXMgYmV0dGVyIChsZXNzIHBhY2tldHMgbG9zdCkgdGhhbiBiZWZv
cmUuDQo+ID4NCj4gPiBLdXJ0DQo+ID4NCj4gPiBPbiB3bywgMTAganVuIDIwMjAgMDg6MDg6Mjgg
KzAwMDAsIEZlbGl4IFJpZW1hbm4gd3JvdGU6DQo+ID4gPiBIaSBLdXJ0LA0KPiA+ID4NCj4gPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4NCj4gPiA+ID4gSSBoYXZlIHRo
ZSBpbXByZXNzaW9uIHRoYXQgdGhlIHJlY3YgcGF0aCBpcyBjb3ZlcmVkLCBhdCBsZWFzdCB0aGUN
Cj4gPiA+ID4gbnVsbCBwdHIgd291bGQgaGF2ZSBjYXVzZWQgaXNzdWVkIGVhcmxpZXIgYWxyZWFk
eS4NCj4gPiA+ID4gV291bGQgdGhlIHByb2JsZW0gYXJpc2UgaW4gY19jYW5fZG9fdHggZmV0Y2hp
bmcgYSBOVUxMIGVjaG9fc2tiPw0KPiA+ID4NCj4gPiA+IEl0IHJlYWxseSBsb29rcyBsaWtlIGl0
Lg0KPiA+ID4NCj4gPiA+IEFkZGluZyBhIEJVR19PTiB0byB0aGUgbG9vcCBpbiBjX2Nhbl9kb190
eCB0cmlnZ2VycyB3aXRoIGEgTlVMTCBza2INCj4gcmV0dXJuZWQgYnkgX19jYW5fZ2V0X2VjaG9f
c2tiKCkuDQo+ID4gPg0KPiA+ID4gRm9yIHRlc3RpbmcgSSByZXBsYWNlZCB0aGUgQlVHX09OIHdp
dGggYSBjaGVjayB0aGF0IHNraXBzIHRoZSBza2IgaWYgdGhhdA0KPiBoYXBwZW5zIChub3Qgc3Vy
ZSBpZiB0aGF0IHdvdWxkIGJlIGEgdmFsaWQgZml4IGluIHRoYXQgcGxhY2UpOg0KPiA+ID4NCj4g
PiA+IHdoaWxlICgob2JqID0gY19jYW5fZmZzNjQocGVuZCkpKSB7DQo+ID4gPiBwZW5kICY9IH4o
KHU2NCkxIDw8IChvYmogLSAxKSk7DQo+ID4gPiBjX2Nhbl9pbnZhbF90eF9vYmplY3QoZGV2LCBJ
Rl9SWCwgb2JqKTsgaWR4ID0gb2JqIC0NCj4gPiA+IHByaXYtPm9iai5zZW5kX2Zyc3Q7IHNrYiA9
IF9fY2FuX2dldF9lY2hvX3NrYihkZXYsIGlkeCwgJmxlbik7DQo+ID4gPiBpZighc2tiKQ0KPg0K
PiBJdCB3b3VsZCBiZSBpbnRlcmVzdGluZyB0byBrbm93IGlkeCBhbmQgcHJpdi0+dHhfYWN0aXZl
IGhlcmUuDQoNClRoYXQncyB0aGUgc3RhdGlzdGljIG92ZXIgYWJvdXQgMTYwMCBsaW5lcyBJIGNh
cHR1cmVkLiBGaXJzdCBudW1iZXIgaXMgbnVtYmVyIG9mIG9jY3VycmVuY2VzOg0KDQogICAgOTky
IGNhbjA6IFNraXAgQCBpZHggMCwgdHhfYWN0aXZlOiAweDENCiAgICAyNTUgY2FuMDogU2tpcCBA
IGlkeCAwLCB0eF9hY3RpdmU6IDB4Mw0KICAgIDI1MCBjYW4wOiBTa2lwIEAgaWR4IDEsIHR4X2Fj
dGl2ZTogMHgyDQogICAgIDExIGNhbjA6IFNraXAgQCBpZHggMCwgdHhfYWN0aXZlOiAweDcNCiAg
ICAgMTAgY2FuMDogU2tpcCBAIGlkeCAxLCB0eF9hY3RpdmU6IDB4Ng0KICAgICAgOCBjYW4wOiBT
a2lwIEAgaWR4IDcsIHR4X2FjdGl2ZTogMHg4MA0KICAgICAgOCBjYW4wOiBTa2lwIEAgaWR4IDYs
IHR4X2FjdGl2ZTogMHhjMA0KICAgICAgOCBjYW4wOiBTa2lwIEAgaWR4IDIsIHR4X2FjdGl2ZTog
MHg2DQogICAgICA2IGNhbjA6IFNraXAgQCBpZHggMSwgdHhfYWN0aXZlOiAweGUNCiAgICAgIDUg
Y2FuMDogU2tpcCBAIGlkeCAyLCB0eF9hY3RpdmU6IDB4NA0KICAgICAgNSBjYW4wOiBTa2lwIEAg
aWR4IDAsIHR4X2FjdGl2ZTogMHhmDQogICAgICA0IGNhbjA6IFNraXAgQCBpZHggMiwgdHhfYWN0
aXZlOiAweGMNCiAgICAgIDQgY2FuMDogU2tpcCBAIGlkeCAwLCB0eF9hY3RpdmU6IDB4M2YNCiAg
ICAgIDMgY2FuMDogU2tpcCBAIGlkeCA2LCB0eF9hY3RpdmU6IDB4NDANCiAgICAgIDMgY2FuMDog
U2tpcCBAIGlkeCAzLCB0eF9hY3RpdmU6IDB4Yw0KICAgICAgMyBjYW4wOiBTa2lwIEAgaWR4IDIs
IHR4X2FjdGl2ZTogMHhmYw0KICAgICAgMyBjYW4wOiBTa2lwIEAgaWR4IDIsIHR4X2FjdGl2ZTog
MHgzYw0KICAgICAgMyBjYW4wOiBTa2lwIEAgaWR4IDAsIHR4X2FjdGl2ZTogMHgxZg0KICAgICAg
MiBjYW4wOiBTa2lwIEAgaWR4IDUsIHR4X2FjdGl2ZTogMHgzZQ0KICAgICAgMiBjYW4wOiBTa2lw
IEAgaWR4IDQsIHR4X2FjdGl2ZTogMHgzZQ0KICAgICAgMiBjYW4wOiBTa2lwIEAgaWR4IDMsIHR4
X2FjdGl2ZTogMHhmOA0KICAgICAgMiBjYW4wOiBTa2lwIEAgaWR4IDMsIHR4X2FjdGl2ZTogMHgz
ZQ0KICAgICAgMiBjYW4wOiBTa2lwIEAgaWR4IDIsIHR4X2FjdGl2ZTogMHgzZQ0KICAgICAgMiBj
YW4wOiBTa2lwIEAgaWR4IDEsIHR4X2FjdGl2ZTogMHgzZQ0KICAgICAgMiBjYW4wOiBTa2lwIEAg
aWR4IDEsIHR4X2FjdGl2ZTogMHgxZQ0KICAgICAgMSBjYW4wOiBTa2lwIEAgaWR4IDcsIHR4X2Fj
dGl2ZTogMHhmMA0KICAgICAgMSBjYW4wOiBTa2lwIEAgaWR4IDYsIHR4X2FjdGl2ZTogMHhmMA0K
ICAgICAgMSBjYW4wOiBTa2lwIEAgaWR4IDYsIHR4X2FjdGl2ZTogMHg3OA0KICAgICAgMSBjYW4w
OiBTa2lwIEAgaWR4IDYsIHR4X2FjdGl2ZTogMHg3MA0KICAgICAgMSBjYW4wOiBTa2lwIEAgaWR4
IDUsIHR4X2FjdGl2ZTogMHhmMA0KICAgICAgMSBjYW4wOiBTa2lwIEAgaWR4IDUsIHR4X2FjdGl2
ZTogMHg3OA0KICAgICAgMSBjYW4wOiBTa2lwIEAgaWR4IDUsIHR4X2FjdGl2ZTogMHg3MA0KICAg
ICAgMSBjYW4wOiBTa2lwIEAgaWR4IDUsIHR4X2FjdGl2ZTogMHgzOA0KICAgICAgMSBjYW4wOiBT
a2lwIEAgaWR4IDUsIHR4X2FjdGl2ZTogMHgyMA0KICAgICAgMSBjYW4wOiBTa2lwIEAgaWR4IDQs
IHR4X2FjdGl2ZTogMHhmMA0KICAgICAgMSBjYW4wOiBTa2lwIEAgaWR4IDQsIHR4X2FjdGl2ZTog
MHgzOA0KICAgICAgMSBjYW4wOiBTa2lwIEAgaWR4IDQsIHR4X2FjdGl2ZTogMHgxYw0KICAgICAg
MSBjYW4wOiBTa2lwIEAgaWR4IDMsIHR4X2FjdGl2ZTogMHhmYw0KICAgICAgMSBjYW4wOiBTa2lw
IEAgaWR4IDMsIHR4X2FjdGl2ZTogMHhlDQogICAgICAxIGNhbjA6IFNraXAgQCBpZHggMywgdHhf
YWN0aXZlOiAweDgNCiAgICAgIDEgY2FuMDogU2tpcCBAIGlkeCAzLCB0eF9hY3RpdmU6IDB4NzgN
CiAgICAgIDEgY2FuMDogU2tpcCBAIGlkeCAzLCB0eF9hY3RpdmU6IDB4MzgNCiAgICAgIDEgY2Fu
MDogU2tpcCBAIGlkeCAzLCB0eF9hY3RpdmU6IDB4MWMNCiAgICAgIDEgY2FuMDogU2tpcCBAIGlk
eCAyLCB0eF9hY3RpdmU6IDB4ZQ0KICAgICAgMSBjYW4wOiBTa2lwIEAgaWR4IDIsIHR4X2FjdGl2
ZTogMHg3Yw0KICAgICAgMSBjYW4wOiBTa2lwIEAgaWR4IDIsIHR4X2FjdGl2ZTogMHgxYw0KICAg
ICAgMSBjYW4wOiBTa2lwIEAgaWR4IDEsIHR4X2FjdGl2ZTogMHhmZQ0KICAgICAgMSBjYW4wOiBT
a2lwIEAgaWR4IDAsIHR4X2FjdGl2ZTogMHhmZg0KICAgICAgMSBjYW4wOiBTa2lwIEAgaWR4IDAs
IHR4X2FjdGl2ZTogMHg3Zg0KDQpJIHVzZWQgYXRvbWljX3JlYWQgdG8gZ2V0IHRoZSB2YWx1ZSBv
ZiB0eF9hY3RpdmUuDQoNClJlZ2FyZHMsDQoNCkZlbGl4DQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KU01BIFNvbGFyIFRlY2hub2xvZ3kgQUcN
CkF1ZnNpY2h0c3JhdDogVXdlIEtsZWlua2F1ZiAoVm9yc2l0emVuZGVyKQ0KVm9yc3RhbmQ6IFVs
cmljaCBIYWRkaW5nLCBEci4tSW5nLiBKdWVyZ2VuIFJlaW5lcnQNCkhhbmRlbHNyZWdpc3Rlcjog
QW10c2dlcmljaHQgS2Fzc2VsIEhSQiAzOTcyDQpTaXR6IGRlciBHZXNlbGxzY2hhZnQ6IDM0MjY2
IE5pZXN0ZXRhbA0KVVN0LUlELU5yLiBERSAxMTMgMDggNTkgNTQNCldFRUUtUmVnLi1Oci4gREUg
OTU4ODExNTANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0K
