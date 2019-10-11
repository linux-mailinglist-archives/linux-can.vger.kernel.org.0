Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC7DD43FA
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2019 17:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfJKPQ6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 11 Oct 2019 11:16:58 -0400
Received: from mx.krause.de ([88.79.216.98]:51167 "EHLO mx.krause.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfJKPQ6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 11 Oct 2019 11:16:58 -0400
Received: from [172.20.10.125] (port=57003 helo=mail.horstmanngroup.de)
        by mx.krause.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <t.schluessler@krause.de>)
        id 1iIwf0-0006dI-1c; Fri, 11 Oct 2019 17:16:54 +0200
Received: from HG-SRV-053.HG.local (172.20.10.125) by HG-SRV-053.HG.local
 (172.20.10.125) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 11 Oct
 2019 17:16:54 +0200
Received: from HG-SRV-053.HG.local ([::1]) by HG-SRV-053.HG.local ([::1]) with
 mapi id 15.00.1367.000; Fri, 11 Oct 2019 17:16:54 +0200
X-CTCH-RefID: str=0001.0A0C0202.5DA09CE6.005E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   =?utf-8?B?U2NobMO8w59sZXIsIFRpbW8=?= <t.schluessler@krause.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] can: mcp251x: Add GPIO support
Thread-Topic: [PATCH v3 3/3] can: mcp251x: Add GPIO support
Thread-Index: AQHVgDkz1ZvvhErBD0CxKEcJ7UQz66dVVyCAgAAoX3D//+ILgIAAKhIA
Date:   Fri, 11 Oct 2019 15:16:54 +0000
Message-ID: <5fe5b1d031b84141aa736b707020841a@HG-SRV-053.HG.local>
References: <1570801101-27864-1-git-send-email-schluessler@krause.de>
 <1570801101-27864-3-git-send-email-schluessler@krause.de>
 <c00ad0e9-08ae-ddbe-a0ad-6ab5ee5bff41@pengutronix.de>
 <ce2e1ba6e3654a8fac3c35f301ef7802@HG-SRV-053.HG.local>
 <e5e1aefc-208f-8457-27ff-90d94964230f@pengutronix.de>
In-Reply-To: <e5e1aefc-208f-8457-27ff-90d94964230f@pengutronix.de>
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

T24gMTAvMTEvMTkgNDo0MCBQTSwgTWFyYyBLbGVpbmUtQnVkZGUgd3JvdGU6DQo+IEp1c3QgdGhl
IGdwaW8gY2hhbmdlcyBpcyBvay4NCg0KVG8gYmUgYWJsZSB0byByZXN0b3JlIHRoZSBHUElPIHN0
YXRlIGFmdGVyIHJlc2V0LCB0aGUgcHJpdmF0ZSBzdHJ1Y3R1cmUgY29udGFpbnMgYSB2YXJpYWJs
ZSB0byBob2xkIHRoZSBjdXJyZW50IHZhbHVlIG9mIHRoZSBvdXRwdXQgY29udHJvbCByZWdpc3Rl
cjoNCg0KPiArI2lmZGVmIENPTkZJR19HUElPTElCDQo+ICsJc3RydWN0IGdwaW9fY2hpcCBncGlv
Ow0KPiArCXU4IHJlZ19iZnBjdHJsOw0KPiArI2VuZGlmDQoNCnJlZ19iZnBjdHJsIGlzIHRvdWNo
ZWQgaW4gdGhlIF9yZXF1ZXN0LCBfZnJlZSwgX3NldCBhbmQgX3NldF9tdWx0aXBsZSBmdW5jdGlv
bnMuIFNob3VsZCBJIGFkZCAjaWZkZWZzIGFyb3VuZCB0aGUgYWNjZXNzZXMsIGluY2x1ZGUgdGhl
IHZhcmlhYmxlIGFsd2F5cyBpbiB0aGUgc3RydWN0IG9yIHNob3VsZCBJIGFkZCB0aGUgI2lmZGVm
IGZvciB0aG9zZSBmdW5jdGlvbnMgYWdhaW4/DQoNCj4gKw0KPiArCXByaXYtPnJlZ19iZnBjdHJs
ID0gcHJpdi0+cmVnX2JmcGN0cmwgfCBiaXQ7DQo+ICsNCg0KUmVnYXJkcw0KVGltbw0K
