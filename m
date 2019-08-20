Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBDB895959
	for <lists+linux-can@lfdr.de>; Tue, 20 Aug 2019 10:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfHTIWC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Aug 2019 04:22:02 -0400
Received: from mx.krause.de ([88.79.216.98]:50209 "EHLO mx.krause.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbfHTIWC (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 20 Aug 2019 04:22:02 -0400
X-Greylist: delayed 330 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Aug 2019 04:22:01 EDT
Received: from [172.20.10.125] (port=25777 helo=mail.horstmanngroup.de)
        by mx.krause.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <t.schluessler@krause.de>)
        id 1hzzJc-0007iV-07; Tue, 20 Aug 2019 10:16:28 +0200
Received: from HG-SRV-053.HG.local (172.20.10.125) by HG-SRV-053.HG.local
 (172.20.10.125) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 20 Aug
 2019 10:16:27 +0200
Received: from HG-SRV-053.HG.local ([::1]) by HG-SRV-053.HG.local ([::1]) with
 mapi id 15.00.1367.000; Tue, 20 Aug 2019 10:16:27 +0200
X-CTCH-RefID: str=0001.0A0C0209.5D5BAC5C.001C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   =?utf-8?B?U2NobMO8w59sZXIsIFRpbW8=?= <t.schluessler@krause.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: Add GPIO support for mcp251x driver
Thread-Topic: Add GPIO support for mcp251x driver
Thread-Index: AdVWmfxSduWoGL3+RY65gXm3I2iEOP//6gGA//7FmmA=
Date:   Tue, 20 Aug 2019 08:16:27 +0000
Message-ID: <ef7d794e0f9e4d2e8c3a32310d90d180@HG-SRV-053.HG.local>
References: <73336c447238499985c2ca6df1075a52@HG-SRV-053.HG.local>
 <fc7330ce-c277-088a-3a35-e8780c852f99@pengutronix.de>
In-Reply-To: <fc7330ce-c277-088a-3a35-e8780c852f99@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.30.30]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

TWFyYywNCg0KVGhhbmtzIGZvciB0aGUgcG9pbnRlci4NCg0KV2hhdCBkbyB5b3UgbWVhbiB3aXRo
ICJwcm9wZXIiPyBDYW4ndCB3ZSBqdXN0IGFkZCB0aGUgcmVsZXZhbnQgZ3Bpb2NoaXBfIGNhbGxz
IGluIG1jcDI1MXh4LmM/DQoNClJlZ2FyZHMNClRpbW8NCg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSBbbWFpbHRvOm1rbEBwZW5ndXRyb25p
eC5kZV0gDQpTZW50OiBNb25kYXksIEF1Z3VzdCAxOSwgMjAxOSA1OjA3IFBNDQpUbzogU2NobMO8
w59sZXIsIFRpbW87IHdnQGdyYW5kZWdnZXIuY29tOyBsaW51eC1jYW5Admdlci5rZXJuZWwub3Jn
DQpTdWJqZWN0OiBSZTogQWRkIEdQSU8gc3VwcG9ydCBmb3IgbWNwMjUxeCBkcml2ZXINCg0KT24g
OC8xOS8xOSA0OjQ5IFBNLCBTY2hsw7zDn2xlciwgVGltbyB3cm90ZToNCj4gd2hhdCBkbyB5b3Ug
dGhpbmsgd291bGQgYmUgdGhlIHJpZ2h0IHdheSB0byBjb250cm9sIHRoZSBHUElPcyBvZiB0aGUN
Cj4gTUNQMjUxeC8yNTYyNSBmcm9tIHVzZXJsYW5kPw0KDQpZb3Ugd2FudCB0byBpbXBsZW1lbnQg
YSBwcm9wZXIga2VybmVsIGRyaXZlciwgYXR0YWNoaW5nIHRoZSBHUElPcyB0byB0aGUga2VybmVs
IEdQSU8gZnJhbWV3b3JrOiBTZWUNCg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvbWtsL2xpbnV4LWNhbi1uZXh0LmdpdC9jb21taXQvP2g9bWNwMjV4eGZk
JmlkPTU1ZWIzYWZhNWMyOWJkMGQ1MDQ2YTQwY2MwODAyYTQ5NTQwNmFjMTUNCg0KZm9yIGFuIGV4
YW1wbGUuDQoNCj4gSXMgdGhpcyBzb21ldGhpbmcgdGhhdCBzaG91bGQgYmUgZG9uZQ0KPiB1c2lu
ZyBhIFNJT0NERVZQUklWQVRFIGlvY3RsPyBXaGVyZSBzaG91bGQgdGhpcyBnZXQgZG9jdW1lbnRl
ZD8gSSANCj4gY291bGQgaW1hZ2luZSBzb21ldGhpbmcgbGlrZSB0aGlzLCBidXQgYW0gbm90IHN1
cmUgd2hldGhlciB0aGlzIGlzIHRoZSANCj4gcmlnaHQgd2F5IHRvIGdvLg0KDQpNYXJjDQoNCi0t
IA0KUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUg
ICAgICAgICAgIHwNCkluZHVzdHJpYWwgTGludXggU29sdXRpb25zICAgICAgICB8IFBob25lOiAr
NDktMjMxLTI4MjYtOTI0ICAgICB8DQpWZXJ0cmV0dW5nIFdlc3QvRG9ydG11bmQgICAgICAgICAg
fCBGYXg6ICAgKzQ5LTUxMjEtMjA2OTE3LTU1NTUgfA0KQW10c2dlcmljaHQgSGlsZGVzaGVpbSwg
SFJBIDI2ODYgIHwgaHR0cDovL3d3dy5wZW5ndXRyb25peC5kZSAgIHwNCg0K
