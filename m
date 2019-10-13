Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6528D587B
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2019 00:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfJMWF1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Oct 2019 18:05:27 -0400
Received: from mail-eopbgr70107.outbound.protection.outlook.com ([40.107.7.107]:46375
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727632AbfJMWF0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sun, 13 Oct 2019 18:05:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJNs1wPbEDNdI3v+vxfK7rflLKWkNMit6FUtOfuYnvvM64RypKXW6aWF+MWCTVC5salzPHFQWcGNzdR+ivdXPMBTIlOGzathjI/hKPNtd6mWjjnXCIz5MXtrpZdvUVr0NcAj5Kgo94lFVp4zjnDzl/dKOI4fR/wHJZqg5rgH8cXB2AlrVtu+PqtQpENm1v9MWevZqgn7eFSA7/5zLFMWcWE22SHnoRINJQpT/mBJYmzlQNMSB3KVe6XcrovBtkMFb2BDEzHJ/snqOsrEdzeFggHs8gELxpcUC8Mw+6Y4MH5gLSKj4Tp3RUq8R6uaEqGtbrd4TiJLTQMMwH0PazY6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASymNDru1bnzLmJWiN9Q3aniLETGI9z0aT1xbw4fbqg=;
 b=fw20IVrb/bbzfIZvYnmIFT6zb0zA1xJtZQbR1lhhg1ytD4ScEumQ/2MKbbKu7zTqRk8ZwDiiFmHpXDSUZtEXeBJaAdDAcZch+oEdcOFKzV7XI0X0O9xtPApmqh5lGslWEYWBRnsCdf4yY05y7A03hofusOCBpAFhwrqro8I88PBK5WHCxypw9FDsVGNHeV1CbLGhIKWfp4KhLTkk+TYt3oS1HRorHWHeIx2j/mn/qCDPEEfHFaVPDrvY3QfCsXtkb/YOYUKqM0FU2GcXdz3SeKMjdyJgpWkz5+JCPb+B9ZYUpz9/JigtGRNhEX42x2cNiJ5nU+kc1NSCB0EDFmK3Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASymNDru1bnzLmJWiN9Q3aniLETGI9z0aT1xbw4fbqg=;
 b=an9oV3tDejXJ5zE3VsHLJltuqwYKqyErDijCT0o9M7Q1VT3evcAwsFm5gRl3yWeC4bVKP6h64vF9JY7o7A0qqwWVzsLcIqfF/hHzhs/b5L/uARGwGAgYvHTD570LFX5Aa+WwA3UlPhQBQf45/bMW5++zxJgRR0yfwf7cWUUn2lg=
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com (10.173.82.19) by
 VI1PR0701MB2783.eurprd07.prod.outlook.com (10.173.81.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.14; Sun, 13 Oct 2019 22:04:39 +0000
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::49b7:a244:d3e4:396c]) by VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::49b7:a244:d3e4:396c%9]) with mapi id 15.20.2347.021; Sun, 13 Oct 2019
 22:04:39 +0000
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH v2] can: ti_hecc: add fifo overflow error reporting
Thread-Topic: [PATCH v2] can: ti_hecc: add fifo overflow error reporting
Thread-Index: AQHVf4Lm9AlGYOjOLEacvFBHpPhAhadUMvOAgAESgICAA9/vgA==
Date:   Sun, 13 Oct 2019 22:04:39 +0000
Message-ID: <a0dda183-a8f8-3a3f-d2f0-292308796b37@victronenergy.com>
References: <20191010155341.5991-1-mkl@pengutronix.de>
 <abf0d3b4-c2eb-3444-bbbe-e17cde4048f9@victronenergy.com>
 <7828f3e6-3a8a-ff90-1bea-a49719e46db3@pengutronix.de>
In-Reply-To: <7828f3e6-3a8a-ff90-1bea-a49719e46db3@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-originating-ip: [2001:1c01:3bc5:4e00:fc62:6962:688d:c507]
x-clientproxiedby: AM3PR07CA0053.eurprd07.prod.outlook.com
 (2603:10a6:207:4::11) To VI1PR0701MB2623.eurprd07.prod.outlook.com
 (2603:10a6:801:b::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jhofstee@victronenergy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9426e113-317d-4d16-4764-08d7502957c1
x-ms-traffictypediagnostic: VI1PR0701MB2783:
x-microsoft-antispam-prvs: <VI1PR0701MB2783E52028FF90E1903BA62DC0910@VI1PR0701MB2783.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01894AD3B8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(376002)(346002)(39840400004)(396003)(199004)(189003)(52314003)(6436002)(7736002)(305945005)(6512007)(6246003)(31696002)(81156014)(14454004)(58126008)(316002)(8936002)(25786009)(81166006)(8676002)(36756003)(110136005)(478600001)(2616005)(46003)(64756008)(66446008)(66946007)(66476007)(446003)(11346002)(486006)(6116002)(66556008)(53546011)(386003)(2906002)(5660300002)(256004)(65956001)(65806001)(31686004)(6486002)(86362001)(2501003)(229853002)(99286004)(71200400001)(52116002)(186003)(76176011)(71190400001)(6506007)(102836004)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0701MB2783;H:VI1PR0701MB2623.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: victronenergy.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SIF/yUGrGBwZF6REx88kv1bLpDZifCM0JP2E0dJylSffv6GdaF+WoQqV0VblDQe4NY1cviPsVUgwrwL55nGnLrwfhWKj6lMg1hJ4zY7pvWFg04CMXmWv4NvoIXLLBBl6J8EHrh/SIywnFcGEShB1tOIf4iZwCkOFZyY0e4vPmzTWpZWleu/GqOBaX0kxpFjB4GkHCdB5GJq3+ixnywR4McGQ5122WWJT3QhqeeARLoIgfEbgAW2Y/0N8e6xO2AUjsbqT0yAWyteVEVTM2gzsA8Hz0//OmMvfvvMf3cTABL1we+CaPNKaejtGOEx1VLPXxt6wambubgRUzXx+emc4Pwd0UyJVwKf5yl/tzn+4ymZxGLGHY4ObxxlmjMF4+ozHAfC6yJ0ndPPjXCTlbWwTcIBoYVe19KkYt7EZnYZvmxs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A1247699DA75F43ABBF4691BF13D133@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9426e113-317d-4d16-4764-08d7502957c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2019 22:04:39.4389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jOitO6UPyFBlVyt95q1/aMpAHwyEy4iz+jOZs4TUwU+w9htIAZGC8vfTax3vFMotthAv673r0+Fsqrb2Gx3PSteoVdDvCJbzwrqUt4N4M+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB2783
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGVsbG8gTWFyYywNCg0KcmVwbHlpbmcgdG8gdjIsIHRoZXJlIGlzIGEgdjMgYWxyZWFkeS4uDQoN
Ck9uIDEwLzExLzE5IDEyOjU0IFBNLCBNYXJjIEtsZWluZS1CdWRkZSB3cm90ZToNCj4gT24gMTAv
MTAvMTkgODozMSBQTSwgSmVyb2VuIEhvZnN0ZWUgd3JvdGU6DQo+Pj4gICAgZHJpdmVycy9uZXQv
Y2FuL3RpX2hlY2MuYyB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCj4+
PiAgICAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+
Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4vdGlfaGVjYy5jIGIvZHJpdmVycy9u
ZXQvY2FuL3RpX2hlY2MuYw0KPj4+IGluZGV4IDZlYTI5MTI2YzYwYi4uODc4MTVhNWI5MTcwIDEw
MDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvbmV0L2Nhbi90aV9oZWNjLmMNCj4+PiArKysgYi9kcml2
ZXJzL25ldC9jYW4vdGlfaGVjYy5jDQoNClsuLi5dDQo+PiBJIHJlYWxseSBkb3VidCBpZiB0aGVy
ZSBpcyBzb21ldGhpbmcgdG8ganVzdGlmeSB0byB0cmVhdCB0aGUNCj4+IEhFQ0NfUlhfTEFTVF9N
Qk9YIHNwZWNpYWxseS4gSXQgaXMgYSBjb21wYXJpc29uIHZlcnN1cyBhIGJpdA0KPj4gY2hlY2sg
b2Ygd2hpY2ggdGhlIG1hc2sgaXMgYWxyZWFkeSBhdmFpbGFibGUuLi4uLg0KPiBZb3UgbWlzcyB0
aGUgcG9pbnQgdGhhdCB3ZSB3aWxsIHJlYWQgdGhlIEhFQ0NfQ0FOUk1MIHJlZ2lzdGVyIGZvcg0K
PiBfZXZlcnlfIG1haWxib3ggYW5kIHJlYWRpbmcgYSByZWdpc3RlciBmcm9tIGEgcGVyaXBoZXJh
bCBpcyBtdWNoIG1vcmUNCj4gZXhwZW5zaXZlIHRoZW4gZmlyc3QgY2hlY2tpbmcgaWYgd2UncmUg
d29ya2luZyBvbiB0aGUgbGFzdCBSWCBtYWlsYm94IGF0DQo+IGFsbC4NCg0KDQpXZWxsIHRoZSBs
YXN0IHBhcnQsIEkgYW0gYXdhcmUgaXQgYWx3YXlzIHJlYWRzIHRoZSByZWdpc3RlciwNCmJ1dCBu
b3QgdGhhdCBpdCBjYW4gYmUgc2lnbmlmaWNhbnRseSBleHBlbnNpdmUgY29tcGFyZWQgdG8NCnRo
ZSB3aG9sZSBzdGFjayBpbiBiZXR3ZWVuLiBJIGNhbid0IGVhc2lseSBmaWd1cmUgb3V0IGhvdw0K
ZXhwZW5zaXZlIGl0IGNhbiBiZSwgc2luY2UgZS5nLiBpdCBkZXBlbmRzIG9uIHRoZSBhY3R1YWwg
TDMNCnN0YXRlIG9uIHRoZSBhbTM1MTcsIGxhdGVuY2llcyBvZiB0aV9oZWNjLiBBbnl3YXksIGZv
ciBzdXJlDQp5b3UgYXJlIHJpZ2h0IGl0IGlzIG5vdCBnb2luZyB0byBiZWF0IHRoZSBtYnhubyBj
aGVjaywgc2luY2UNCml0IGlzIGxpa2VseSBpbiBhIHJlZ2lzdGVyLg0KDQo+PiBJIGxpa2UgdjEg
bW9yZSBhY3R1YWxseSwganVzdCBiZWNhdXNlIGl0IGlzIHNpbXBsZXIgLyBsZXNzIGNvZGUuLi4N
Cj4gdjMgbG9va3MgcXVpdGUgbmljZSBub3cuDQoNCkluZGVlZC4uDQoNCj4+IEkgaGF2ZSBteSBk
b3VidHMgYWJvdXQgdGhlIGVycm9yIGNvdW50ZXIsIHNlZSB0aGUgb3RoZXIgbWFpbC4NCj4+IEkg
ZG9uJ3Qga25vdyB3aGljaCBzb3VyY2UgaGFzIHRoZSB1bHRpbWF0ZSBkZWZpbml0aW9uLCBJIGp1
c3QNCj4+IGdvb2dsZWQgZm9yIHRoZW0uDQo+IEkndmUgbW92ZWQgdGhlIGVycm9yIGNvdW50ZXIg
aGFuZGxpbmcgdG8gcngtb2ZmbG9hZCBub3cuDQo+DQo+IFRoZSBrZXJuZWwgZG9jIGFsd2F5cyBz
YXlzOg0KPg0KPiAiU2VlIHRoZSBuZXR3b3JrIGRyaXZlciBmb3IgdGhlIGV4YWN0IG1lYW5pbmcg
b2YgdGhpcyB2YWx1ZS4iDQo+DQoNCkdvb2QsIG15IGludGVuZCB3YXMgdG8gZ2V0IGl0IHJlcG9y
dGVkIGF0IGFsbCwgSSBkb24ndA0KcmVhbGx5IGNhcmUgaG93LCBJIGp1c3QgcGlja2VkIHRoZSBv
bmUgd2hpY2ggc2VlbXMNCm1vc3QgbG9naWNhbCB0byBtZS4NCg0KUmVnYXJkcywNCg0KSmVyb2Vu
DQoNCg==
