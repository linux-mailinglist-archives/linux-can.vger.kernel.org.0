Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E931941EE
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2020 15:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCZOt2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 26 Mar 2020 10:49:28 -0400
Received: from mail-eopbgr00124.outbound.protection.outlook.com ([40.107.0.124]:6143
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726363AbgCZOt1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 26 Mar 2020 10:49:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBTvLt9EdW5NWT9rgZoBE2cdvPGitBzQ0hBVOOms+XoMlpmvecQeJB39Yq9ECjZWKPuhm1CBTlxQvIKHxScpXVD7m1V/DLcUS2xpyhQe2LhsdvPY3DsxdLkOJxzRCc2TD1zEWzKU7sUQpi5jvDxP1EqSGZvKMU6l1n1qKZb0bnF2axhzssfYZ6zbmDaU8+MkVg2uDQ4aWDOBSXQ2SiGYwUapp/HSiPp4hTNqzE/aTDtcOeE1VIhPhchOAzGIMQ/2hpZIUx8LOmpBsNi0hRQ4Ey7kwoOJQvy68y7Fg+6FdmHjFNbM4u8N/VomFuzSN3P4p6J7veRiECwXIRJGSpXi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iz6w4JR6do7sMzCd13OP16L5xWsnIs33II1R0GT0yr8=;
 b=QT4ge7C1ZTjL4pAYiwyysZDquO1fjsJPyO8KHSnj1QWTvdHkSJoZ0J707UpUGzTiu9DoFzbpNWbDPk0iEHsI3N7nEkO5B0483CWDSOozhTzpaC9ScZ497pZE77mBVIB28ulBchYjpSdRiylqnpxqRdthd+4BHubv6Rn9PlIdj8zxEUlbhBRMjw0mSAZwhVDrXVbm2BTJjWSmaHNSULbO1db3C33JQce6RBXkEaI+bdWtoZZFjBD2dS0R6v5DP+B1VQLN3eqlcP+/jG0GODAtbnZaJpO+pj469iHfosJ7BPCdC973tpwO0OkePX22ReRoyBtNzlGzPNEclnY5gPPS+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sma.de; dmarc=pass action=none header.from=sma.de; dkim=pass
 header.d=sma.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sma.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iz6w4JR6do7sMzCd13OP16L5xWsnIs33II1R0GT0yr8=;
 b=qTEGYEut17XVOe1w+BvdAK6p0I/FcD4O1SVpsNQVopvb/FU47ZXywNcqUpEHyvmw9CHkDrceqvcZVrTpcQ1+SMu9uckXdbXFnI3uRC638N/GL6d8LmqXzyFbDArcH9hFaNlxlD+TDXvNsWC7Pjrkf8jYrzAH+She8x/nunAHZr8=
Received: from AM0PR04MB5427.eurprd04.prod.outlook.com (20.178.114.156) by
 AM0PR04MB6193.eurprd04.prod.outlook.com (20.179.34.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Thu, 26 Mar 2020 14:49:23 +0000
Received: from AM0PR04MB5427.eurprd04.prod.outlook.com
 ([fe80::bd71:151e:5804:252c]) by AM0PR04MB5427.eurprd04.prod.outlook.com
 ([fe80::bd71:151e:5804:252c%5]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 14:49:23 +0000
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
Thread-Index: AQHWA1tqGNdHGBlIIU2zdPpKElX6gKha4XMAgAAHV9A=
Date:   Thu, 26 Mar 2020 14:49:23 +0000
Message-ID: <AM0PR04MB5427D3BF64C3D3DA3961920488CF0@AM0PR04MB5427.eurprd04.prod.outlook.com>
References: <20200326104318.15086-1-felix.riemann@sma.de>
 <20200326134015.GC27785@x1.vandijck-laurijssen.be>
In-Reply-To: <20200326134015.GC27785@x1.vandijck-laurijssen.be>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Riemann@sma.de; 
x-originating-ip: [93.209.169.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fa17642-8865-485b-cf90-08d7d194dfea
x-ms-traffictypediagnostic: AM0PR04MB6193:|AM0PR04MB6193:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB61930BB848240DAA46268E1B88CF0@AM0PR04MB6193.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(9686003)(7696005)(55016002)(26005)(186003)(6506007)(478600001)(86362001)(4326008)(6916009)(71200400001)(33656002)(76116006)(8676002)(66946007)(52536014)(81156014)(5660300002)(81166006)(2906002)(8936002)(66556008)(66476007)(64756008)(54906003)(66446008)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR04MB6193;H:AM0PR04MB5427.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: sma.de does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Te9eT1Ovrz60ZjPVi+rjuXYfkAgCb4VQ8ZVG79pTUa3bBWfnWI2mo1aqnAoW661SFpkZZNSSjVde/Lfwjf/xM7BTowpMT/HZNXG60InHijkHDrR1xHPVBS4Zhu/B2hE/WlZ2v6X/qCdzIveHppNS1a6e0C1MnBhVY64LIDg3NBgP3ACKTKDoe7orSn6JMhDMpythQ9f3COo0JL7oym+tJqD9wj07Swh+6o1wqrlcV8ry9EKoog3fg2ZzEQHJty1AcriJU3SxiicN3ua6CQybvoQ5X0jEMTbLc/pcAk9IBrdO6/J3Jt0McS2zmkhC/yKIaDPNLviMDSmwa2m/eV+KmIFNztiqSASh4XUUTEXQ/2a0PgQwjFwy9IuXbsZKf5UVyOsM5RfGDdyO7ZT6tKXfXBFJvfs4VtLx2ljC1mB3br8mqUXX0rVIL/cQMXDtjzGy
x-ms-exchange-antispam-messagedata: PY+EIOHnDt0qkolIRwkp/qpvHqQHF90caquB2j1XJ/Nmxw3JqVNYG23Uw51VW0RGN/JQTJPo9QxXMPHojrmPBtt7G5LkBA3QpBJc2f3k8TL0QBiLuLs0Psv7kAomTPkedeAfyt5kWY6mW/sirmybVg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sma.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa17642-8865-485b-cf90-08d7d194dfea
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 14:49:23.6928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a059b96c-2829-4d11-8837-4cc1ff84735d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PFedH230UKRIo5kj3kvKv3LvtsCcIjYcn7f1e7XtwhpMzngzmaduU/IYOuKK2QFL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6193
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgS3VydCwNCg0KeWVzIHRoYXQgd291bGQgYmUgM2NiM2VhYWM1MmMwZjE0NWQ4OTVmNGI2YzIy
ODM0ZDVmMDJiODU2OS4NCg0KSSB0cmllZCB5b3VyIHBhdGNoIGFzIHdlbGwsIHNpbmNlIHRoZSBk
ZXNjcmlwdGlvbiBtYXRjaGVkIHRoZSBwcm9ibGVtIHByZXR0eSB3ZWxsLiBIb3dldmVyLCBJIGNv
dWxkIHN0aWxsIHByb2R1Y2UgdGhlIGhhbmcgb24gb3VyIGJvYXJkIChiYXNlZCBvbiBBTTMzNTIp
IGVzcGVjaWFsbHkgaWYgdGhlIGJ1cyBvZmYgb2NjdXJzIHdoaWxlIHRoZSBidXMgbG9hZCBpcyB2
ZXJ5IGhpZ2guDQoNCldoYXQgSSBjb3VsZCBzZWUgd2FzIHRoZSB3b3JrZXIgYmVpbmcgdHJpZ2dl
cmVkIGJ5IHRoZSBpbnRlcnJ1cHQgd2l0aCB0aGUgYnVzIGJlaW5nIGluIHBhc3NpdmUgbW9kZS4g
V2hlbiB0aGUgd29ya2VyIHRoZW4gcmUtZW5hYmxlZCB0aGUgaW50ZXJydXB0IHRoZSBoYXJkd2Fy
ZSBoYWQgYWxyZWFkeSBlbnRlcmVkIGluaXQgbW9kZSBkdWUgdG8gdGhlIGJ1cy1vZmYgYnV0IG5v
ciB3b3VsZCBpdCB0cmlnZ2VyIGFnYWluIG5vciB3b3VsZCB0aGUgaW50ZXJydXB0IHJlZ2lzdGVy
IGluZGljYXRlIGEgcGVuZGluZyBJUlEuIFRoZSBzdGF0dXMgcmVnaXN0ZXIgYWxzbyBpbmRpY2F0
ZXMgYW4gZXJyb3IgKExFQyAhPSAweDcpLg0KDQpBIGZpcnN0IGF0dGVtcHQgdG8gZml4L3dvcmth
cm91bmQgdGhpcyBwbGFjZWQgdGhlIGNoZWNrIGp1c3QgYmVmb3JlIHRoZSB3b3JrZXIgcmUtZW5h
YmxlcyB0aGUgaW50ZXJydXB0cy4gQnV0IGV2ZW4gdGhpcyBzZXR1cCBjb3VsZCByZXByb2R1Y2Ug
dGhlIHByb2JsZW0sIGFsdGhvdWdoIGl0IHRvb2sgbG9uZ2VyIHRvIGRvIHNvLiAgU28gdGhlIHRp
bWluZyBhcm91bmQgZW5hYmxpbmcgdGhlIGludGVycnVwdHMgc2VlbXMgdG8gbWF0dGVyIGhlcmUu
IEFjdHVhbGx5LCBhZGRpbmcgYSBwcmludG91dCBhdCB0aGUgdG9wIG9mIHRoZSB3b3JrZXIgd2hl
cmUgeW91ciBwYXRjaCBjaGVja3MgdGhlIHZhbHVlIG9mIHRoZSBzaWVfcGVuZGluZyBhdG9taWMg
c2VlbXMgdG8gaW5jcmVhc2UgdGhlIGNoYW5jZXMgb2YgbWFraW5nIGl0IGhhcHBlbiBvbiBteSBi
b2FyZCwgYnV0IHRoYXQncyBqdXN0IGEgZmVlbGluZyBJIGdvdCB3aGlsZSBjbGVhbmluZyB1cCBt
eSBwYXRjaC4NCg0KUmVnYXJkcywNCg0KRmVsaXgNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IEt1cnQgVmFuIERpamNrIDxkZXYua3VydEB2YW5kaWpjay1sYXVyaWpzc2VuLmJl
Pg0KU2VudDogVGh1cnNkYXksIE1hcmNoIDI2LCAyMDIwIDI6NDAgUE0NCg0KVGhpcyBwYXRjaCBs
b29rcyB2ZXJ5IGZhbWlsaWFyLg0KSSB0cmllZCB0aGlzIDYgbW9udGhzIGFnbywgd2hlbiBJIGdv
dCBhIHNldHVwIHdoZXJlIEkgY291bGQgcmVwcm9kdWNlIHRoaXMgd2l0aGluIG1pbnV0ZXMuDQoN
ClRoaXMgcGF0Y2ggZGlkbid0IHNvbHZlIG15IHByb2JsZW0sIGFuZCBJIGZpeGVkIG15IHByb2Js
ZW0gd2l0aCByZWFkaW5nIHRoZSBJU1IgcmVnaXN0ZXIgb25seSBvbmNlIGluIHRoZSBJUlEsIGFu
ZCBfbm90XyAybmQgdGltZSBpbiBuYXBpIGhhbmRsZXIuDQpSZWFkaW5nIHRoZSBJU1IgaW4gQ19D
QU4gaXMgY29uc3VtaW5nIHRoZSBpbmZvLCBzbyB1bmxlc3MgdGhlIHRoZXJlIGlzIG1vcmUgc3Rh
dGUgdG8gY2xlYXIgKHN1Y2ggYXMgcmVjZWl2ZWQgbWVzc2FnZSBidWZmZXJzKSwgdGhlIGludGVy
cnVwdCBjYXVzZSBpcyBhc3N1bWVkIHRvIGJlIGtub3duLCBhbmQgdGhlIENfQ0FOIHByb2NlZWRz
IHRvIHRoZSBuZXh0IGludGVycnVwdCBjYXVzZS4NCkkndmUgbm90IGV4cGVyaWVuY2VkIGEgc2lu
Z2xlIHByb2JsZW0gc2luY2UsIHdoZXJlIGJlZm9yZSB0aGUgZml4LCBJJ2QgZXhwZXJpZW5jZSBh
IGZldyBvY2N1cmFuY2VzIGV2ZXJ5IG1vbnRoLg0KV2UgaGF2ZSBhbiBhbTMzNTggKGJlYWdsZWJv
bmUtbGlrZSBoYXJkd2FyZSkuDQoNCkkgYmVsaWV2ZSBJIHN1Ym1pdHRlZCBhIHBhdGNoIGZvciB0
aGF0Lg0KDQpSZS1zY2hlZHVsaW5nIHRoZSBuYXBpIGlzIGEgd29ya2Fyb3VuZCwgSU1ITy4NCg0K
S3VydA0KDQpPbiBkbywgMjYgbXJ0IDIwMjAgMTE6NDM6MTggKzAxMDAsIEZlbGl4IFJpZW1hbm4g
d3JvdGU6DQo+IFRoZXJlIGFyZSBhcHBlYXJzIHRvIGJlIGEgcmFjZSBjb25kaXRpb24gd2hlcmUg
aW50ZXJydXB0cyBjYXVzZWQgYnkNCj4gYnVzIG9mZnMgZ2V0IGxvc3QgaWYgaXQgb2NjdXJzIHdo
aWxlIGludGVycnVwdHMgYXJlIGRpc2FibGVkIG9yIGJlaW5nDQo+IHJlLWVuYWJsZWQuDQo+DQo+
IFRoaXMgdHJpZXMgdG8gYXZvaWQgdGhlIGRlYWRsb2NrIGJ5IHJlc2NoZWR1bGluZyB0aGUgTkFQ
SSB3b3JrZXIgdG8NCj4gaGFuZGxlIHRoZSBidXMtb2ZmIGNvbmRpdGlvbi4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogRmVsaXggUmllbWFubiA8ZmVsaXgucmllbWFubkBzbWEuZGU+DQo+IFJldmlld2Vk
LWJ5OiBBbmRyZSBLYWxiIDxhbmRyZS5rYWxiQHNtYS5kZT4NCj4gLS0tDQo+ICBkcml2ZXJzL25l
dC9jYW4vY19jYW4vY19jYW4uYyB8IDE5ICsrKysrKysrKysrKysrKysrKy0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC9jYW4vY19jYW4vY19jYW4uYw0KPiBiL2RyaXZlcnMvbmV0L2Nhbi9jX2Nh
bi9jX2Nhbi5jIGluZGV4IDhlOWY1NjIwYzlhMi4uMDk1MmFjMGI5MTIzDQo+IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL25ldC9jYW4vY19jYW4vY19jYW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9j
YW4vY19jYW4vY19jYW4uYw0KPiBAQCAtMTEyMyw4ICsxMTIzLDI1IEBAIHN0YXRpYyBpbnQgY19j
YW5fcG9sbChzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksIGludCBxdW90YSkNCj4gIGlmICh3b3Jr
X2RvbmUgPCBxdW90YSkgew0KPiAgbmFwaV9jb21wbGV0ZV9kb25lKG5hcGksIHdvcmtfZG9uZSk7
DQo+ICAvKiBlbmFibGUgYWxsIElSUXMgaWYgd2UgYXJlIG5vdCBpbiBidXMgb2ZmIHN0YXRlICov
DQo+IC1pZiAocHJpdi0+Y2FuLnN0YXRlICE9IENBTl9TVEFURV9CVVNfT0ZGKQ0KPiAraWYgKHBy
aXYtPmNhbi5zdGF0ZSAhPSBDQU5fU1RBVEVfQlVTX09GRikgew0KPiArdTMyIGN0cmw7DQo+ICBj
X2Nhbl9pcnFfY29udHJvbChwcml2LCB0cnVlKTsNCj4gKw0KPiArLyogVGhlcmUgYXBwZWFycyB0
byBiZSBhIHJhY2UgY29uZGl0aW9uIHdoZW4gdGhlIGRldmljZQ0KPiArICogZW50ZXJzIGJ1cyBv
ZmYgd2hpbGUgaW50ZXJydXB0cyBhcmUgb2ZmIG9yIGJlaW5nDQo+ICsgKiByZS1lbmFibGVkIGNh
dXNpbmcgdGhlIGJ1cyBvZmYgdG8gZ2V0IGxvc3QuDQo+ICsgKiBUaGlzIHRyaWVzIHRvIGF2b2lk
IHRoaXMgY29uZGl0aW9uLg0KPiArICovDQo+ICtjdHJsID0gcHJpdi0+cmVhZF9yZWcocHJpdiwg
Q19DQU5fQ1RSTF9SRUcpOw0KPiArDQo+ICtpZiAoY3RybCAmIENPTlRST0xfSU5JVCkgew0KPiAr
bmV0ZGV2X3dhcm4oZGV2LCAibG9zdCBidXMgb2ZmXG4iKTsNCj4gK2NfY2FuX2lycV9jb250cm9s
KHByaXYsIGZhbHNlKTsNCj4gKy8qIFJlc2NoZWR1bGUgd29ya2VyIHRvIGhhbmRsZSBidXMgb2Zm
ICovDQo+ICthdG9taWNfc2V0KCZwcml2LT5zaWVfcGVuZGluZywgMSk7DQo+ICtuYXBpX3Jlc2No
ZWR1bGUobmFwaSk7DQo+ICt9DQo+ICt9DQo+ICB9DQo+DQo+ICByZXR1cm4gd29ya19kb25lOw0K
PiAtLQ0KPiAyLjI2LjANCj4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KDQpTTUEgU29sYXIgVGVjaG5vbG9neSBBRw0KQXVmc2ljaHRzcmF0OiBE
ci4gRXJpayBFaHJlbnRyYXV0IChWb3JzaXR6ZW5kZXIpDQpWb3JzdGFuZDogVWxyaWNoIEhhZGRp
bmcsIERyLi1JbmcuIEp1ZXJnZW4gUmVpbmVydA0KSGFuZGVsc3JlZ2lzdGVyOiBBbXRzZ2VyaWNo
dCBLYXNzZWwgSFJCIDM5NzINClNpdHogZGVyIEdlc2VsbHNjaGFmdDogMzQyNjYgTmllc3RldGFs
DQpVU3QtSUQtTnIuIERFIDExMyAwOCA1OSA1NA0KV0VFRS1SZWcuLU5yLiBERSA5NTg4MTE1MA0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo=
