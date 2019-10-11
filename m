Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 299CAD405A
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2019 15:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfJKNDC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 11 Oct 2019 09:03:02 -0400
Received: from mx.krause.de ([88.79.216.98]:56473 "EHLO mx.krause.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727855AbfJKNDC (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 11 Oct 2019 09:03:02 -0400
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Oct 2019 09:03:01 EDT
Received: from [172.20.10.125] (port=41923 helo=mail.horstmanngroup.de)
        by mx.krause.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <t.schluessler@krause.de>)
        id 1iIuUL-0001in-0b; Fri, 11 Oct 2019 14:57:45 +0200
Received: from HG-SRV-053.HG.local (172.20.10.125) by HG-SRV-053.HG.local
 (172.20.10.125) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 11 Oct
 2019 14:57:44 +0200
Received: from HG-SRV-053.HG.local ([::1]) by HG-SRV-053.HG.local ([::1]) with
 mapi id 15.00.1367.000; Fri, 11 Oct 2019 14:57:44 +0200
X-CTCH-RefID: str=0001.0A0C020D.5DA07C49.0038,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   =?utf-8?B?U2NobMO8w59sZXIsIFRpbW8=?= <t.schluessler@krause.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: Add GPIO support for mcp251x driver
Thread-Topic: Add GPIO support for mcp251x driver
Thread-Index: AdVWmfxSduWoGL3+RY65gXm3I2iEOP//6gGA//7FmmCAAo4bAP//3hPQgAAtdAD//93nwP+xbWIg/2IPu4D+wXQTAA==
Date:   Fri, 11 Oct 2019 12:57:44 +0000
Message-ID: <b8a6ebf1b77c41ca8accaa1ad14d8542@HG-SRV-053.HG.local>
References: <73336c447238499985c2ca6df1075a52@HG-SRV-053.HG.local>
 <fc7330ce-c277-088a-3a35-e8780c852f99@pengutronix.de>
 <ef7d794e0f9e4d2e8c3a32310d90d180@HG-SRV-053.HG.local>
 <c84b55f8-c22b-3dbc-208d-e63b6c60c8e0@pengutronix.de>
 <e75d6bcd96e0414b99c4d24a41163369@HG-SRV-053.HG.local>
 <a65d9365-fe29-423e-bae0-2bfefb773e69@pengutronix.de>
 <c1dc8274b8bd4214b27a3ddddf54284c@HG-SRV-053.HG.local>
 <27efa196-05be-cf23-db49-45458c66a88f@pengutronix.de>
In-Reply-To: <27efa196-05be-cf23-db49-45458c66a88f@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.35.50]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

T24gMTAvMTAvMTkgMDA6MDIgQU0sIE1hcmMgS2xlaW5lLUJ1ZGRlIHdyb3RlOg0KPiBQbGVhc2Ug
c2VuZCBwYXRjaGVzIHZpcyBnaXQgc2VuZC1lbWFpbCBpZiB5b3UgZW1haWwgc2V0dXAgYWxsb3dz
LiBUaGlzIG1ha2VzIHJldmlldyBlYXNpZXIuDQoNCkkgd2lsbCwgc29ycnkgZm9yIHRoZSBpbmNv
bnZlbmllbmNlLg0KDQo+PiAxLiBIb3cgdG8gaGFuZGxlIHBvd2VyIG1hbmFnZW1lbnQ/IERvZXMg
dGhlIGRyaXZlciBoYXZlIHRvIHJlc3RvcmUgdGhlIA0KPj4gcHJldmlvdXMgZ3BpbyBzdGF0ZT8N
Cj4gSSdtIG5vdCBzdXJlIGlmIGEgZnJhbWV3b3JrIHRha2VzIGNhcmUgb2YgdGhpcy4gSGF2ZSB5
b3UgaGFkIGEgbG9vayBhdCBvdGhlciBHUElPIGRyaXZlcnMgaW4gZHJpdmVycy9ncGlvOg0KDQo+
IGdwaW8tNzR4MTY0LmMJDQo+IGdwaW8tbWF4MzE5MXguYw0KPiBncGlvLW1heDczMDEuYw0KPiBn
cGlvLW1jMzM4ODAuYw0KPiBncGlvLXhyYTE0MDMuYw0KDQpBbGwgb2YgdGhlc2Ugc2VlbSB0byBu
b3QgaGFuZGxlIHBvd2VyIG1hbmFnZW1lbnQgYXQgYWxsLCBidXQgb3RoZXJzIGRvIGEgY29tcGxl
dGUgcmVnaXN0ZXIgYmFuayByZXN0b3JlLCBlLmcuIGdwaW8tYnJjbXN0Yi5jIG9yIGdwaW8tcHhh
LmMuIFNvIEkgdGhpbmsgaXQgd291bGQgYmUgYmVzdCB0byBzdXBwb3J0IHRoaXMgaW4gdGhlIG1j
cDI1MXggZHJpdmVyIGFzIHdlbGwuDQoNCj4gT3RoZXIgZHJpZXJzIHVzZSBzcGktPm1vZGFsaWFz
LCB0b286DQo+IFNvIEkgdGhpbmsgdGhpcyBpcyBvay4NCg0KT2ssIHRoYW5rcy4NCg0KUmVnYXJk
cw0KVGltbw0KDQo=
