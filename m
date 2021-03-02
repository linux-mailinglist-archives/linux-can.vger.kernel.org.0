Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14ACA32AEAA
	for <lists+linux-can@lfdr.de>; Wed,  3 Mar 2021 03:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhCCAAQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 2 Mar 2021 19:00:16 -0500
Received: from mx.krause.de ([88.79.216.98]:55227 "EHLO mx.krause.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381809AbhCBIqm (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 2 Mar 2021 03:46:42 -0500
Received: from [172.20.10.125] (port=33925 helo=mail.horstmanngroup.de)
        by mx.krause.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <t.schluessler@krause.de>)
        id 1lH0O7-0007QR-0i; Tue, 02 Mar 2021 09:28:15 +0100
Received: from HG-SRV-053.HG.local (172.20.10.125) by HG-SRV-053.HG.local
 (172.20.10.125) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 2 Mar
 2021 09:28:14 +0100
Received: from HG-SRV-053.HG.local ([::1]) by HG-SRV-053.HG.local ([::1]) with
 mapi id 15.00.1367.000; Tue, 2 Mar 2021 09:28:14 +0100
X-CTCH-RefID: str=0001.0A782F29.603DF71F.0044,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   =?utf-8?B?U2NobMO8w59sZXIsIFRpbW8=?= <t.schluessler@krause.de>
To:     'Marc Kleine-Budde' <mkl@pengutronix.de>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
CC:     "ukrfoil@gmail.com" <ukrfoil@gmail.com>,
        linux-can <linux-can@vger.kernel.org>
Subject: RE: mcp251x hangs during ifup
Thread-Topic: mcp251x hangs during ifup
Thread-Index: AQHXDwULsseziUMWSEmfL1A+/cbmIKpwOdWAgAAg2xA=
Date:   Tue, 2 Mar 2021 08:28:13 +0000
Message-ID: <638520bccd0c44d091d5715fe7d303ec@HG-SRV-053.HG.local>
References: <20210301165856.37gvqkomvjkjvbj2@pengutronix.de>
 <CAMZ6RqKfXR9cHxjvnPwxjWHWEuxYNV9V4qLSd0ZQGP0JOMKX0w@mail.gmail.com>
 <20210302071901.ptwvejkedascbdsv@pengutronix.de>
In-Reply-To: <20210302071901.ptwvejkedascbdsv@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.35.35]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

T24gMDIuMDMuMjAyMSAwODoxOTowMCwgTWFyYyB3cm90ZToNCj4gT24gMDIuMDMuMjAyMSAxMDo0
MDoyMSwgVmluY2VudCBNQUlMSE9MIHdyb3RlOg0KPiA+IFRoaXMgbWNwMjUxeF9od193YWtlKCkg
ZnVuY3Rpb24gd2FzIGludHJvZHVjZWQgaW4gYmVsb3cgY29tbWl0Og0KPiA+IDhjZThjMGFiY2Jh
MyAoImNhbjogbWNwMjUxeDogb25seSByZXNldCBoYXJkd2FyZSBhcyByZXF1aXJlZCIpIA0KPiA+
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRz
L2xpbnV4LmdpdC9jb20NCj4gPiBtaXQvP2lkPThjZThjMGFiY2JhMzE0ZTFmZTk1NGExODQwZjY1
NjhiZjVhZWYyZWYNCg0KPiA+IEkgYW0gYWRkaW5nIFRpbW8gdG8gdGhlIGxvb3AuIEhlIGlzIHRo
ZSBhdXRob3Igb2YgdGhlIHR3byBjb21taXRzIGFib3ZlLg0KPiA+IEkgdGhpbmsgaGUgd2lsbCBi
ZSBvZiBiZXR0ZXIgc3VwcG9ydCB0aGFuIG1lIGhlcmUgOikNCg0KPiBPZiBjb3Vyc2UgSSB3YW50
ZWQgdG8gYWRkIFRpbW8sIHRoYW5rcy4gSSB0aGluayBJJ3ZlIHBpY2tlZCB5b3VyIGUtbWFpbCwg
YXMgeW91J3ZlIGRvbmUgdGhlIG5ld2VzdCBjaGFuZ2Ugb24gdGhlIGRyaXZlciBhZnRlciBtZSA6
KQ0KDQpUaGlzIENBTiBjb250cm9sbGVyIGRlbWFuZHMgYSBzb2Z0d2FyZSByZXNldCBhZnRlciBw
b3dlciBvbiB3aGljaCBpcyBkb25lIGluIG1jcDI1MXhfY2FuX3Byb2JlIC0+IG1jcDI1MXhfaHdf
cHJvYmUuDQpTaW5jZSB0aGVuIHJlc2V0cyBhcmUgb25seSBwZXJmb3JtZWQgd2hlbiB0aGUgcG93
ZXIgdG8gdGhlIGNvbnRyb2xsZXIgaGFzIGJlZW4gZGlzYWJsZWQuIEUuZy4gd2hlbiBtY3AyNTF4
X2Nhbl9zdXNwZW5kIGlzIGNhbGxlZCwNCnBvd2VyIGlzIHR1cm5lZCBvZmYgYW5kIGJ5IHNldHRp
bmcgQUZURVJfU1VTUEVORF9QT1dFUiBpbiBwcml2LT5hZnRlcl9zdXNwZW5kIGl0IHdpbGwgYmUg
cmVlbmFibGVkIGFuZCByZXNldCBpbiBtY3AyNTF4X2Nhbl9yZXN1bWUNCmFuZCBtY3AyNTF4X3Jl
c3RhcnRfd29ya19oYW5kbGVyLg0KQ291bGQgaXQgYmUgdGhhdCBtY3AyNTF4X2Nhbl9wcm9iZSBk
b2VzIG5vdCBnZXQgY2FsbGVkIGluIGFueSBjb25maWd1cmF0aW9uPyBPciBjb3VsZCBpdCBiZSB0
aGF0IHRoZSBjb250cm9sbGVyIGdldHMgcG93ZXIgY3ljbGVkIGR1cmluZw0Kb3BlcmF0aW9uIHdp
dGggdGhlc2UgT3JhbmdlIFBpIGJvYXJkcz8NCg0KUmVnYXJkcw0KVGltbw0K
