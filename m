Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32B4EF117A
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2019 09:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfKFIyB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 6 Nov 2019 03:54:01 -0500
Received: from mx.krause.de ([88.79.216.98]:38904 "EHLO mx.krause.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728463AbfKFIyB (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 6 Nov 2019 03:54:01 -0500
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Nov 2019 03:54:01 EST
Received: from [172.20.10.125] (port=55950 helo=mail.horstmanngroup.de)
        by mx.krause.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <t.schluessler@krause.de>)
        id 1iSGz7-0004tC-0L; Wed, 06 Nov 2019 09:48:13 +0100
Received: from HG-SRV-053.HG.local (172.20.10.125) by HG-SRV-053.HG.local
 (172.20.10.125) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 09:48:12 +0100
Received: from HG-SRV-053.HG.local ([::1]) by HG-SRV-053.HG.local ([::1]) with
 mapi id 15.00.1367.000; Wed, 6 Nov 2019 09:48:12 +0100
X-CTCH-RefID: str=0001.0A0C0207.5DC288CD.0022,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   =?utf-8?B?U2NobMO8w59sZXIsIFRpbW8=?= <t.schluessler@krause.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: [PATCH v3 1/3] can: mcp251x: Correctly handle restart-ms
Thread-Topic: [PATCH v3 1/3] can: mcp251x: Correctly handle restart-ms
Thread-Index: AQHVgDkyBp0wzV7t3U+u7zxV5U2YOKd9AlQAgAAY0gCAAABrAIAA34zA
Date:   Wed, 6 Nov 2019 08:48:12 +0000
Message-ID: <1ac246df7c14426ba4ad204ff294c00c@HG-SRV-053.HG.local>
References: <1570801101-27864-1-git-send-email-schluessler@krause.de>
 <b1831201-b94e-6d0d-3194-94ced931f7b0@pengutronix.de>
 <4041ff15-c88f-163f-ebd6-73ddee163436@hartkopp.net>
 <69de9a4f-751c-cda9-20df-b8174ae7b7bc@pengutronix.de>
In-Reply-To: <69de9a4f-751c-cda9-20df-b8174ae7b7bc@pengutronix.de>
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

T24gVHVlc2RheSwgTm92ZW1iZXIgMDUsIDIwMTkgOToyMCBQTSBNYXJjIEtsZWluZS1CdWRkZSB3
cm90ZTogDQo+Pj4gSSB0aGluayB3ZSBkaXNjdXNzZWQgdGhhdCBxdWl0ZSBzb21lIHRpbWUgYWdv
LiBCYWNrIGluIHRoZSBkYXlzIHdlDQo+Pj4gZGVjaWRlZCB0aGF0IGlmIHRoZSBjb250cm9sbGVy
IGRvZXMgc3VwcG9ydCBhdXRvbWF0aWMgcmVzdGFydCB2aWEgdGhlDQo+Pj4gIjEyOCBvY2N1cnJl
bmNlcyBvZiAxMSBjb25zZWN1dGl2ZSByZWNlc3NpdmUgYml0cyIgYW5kIHJlc3RhcnQtbXMgaXMg
DQo+Pj4gPiAwLCB3ZSdsbCBsZXQgdGhlIGNvbnRyb2xsZXIgZG8gdGhlIHJlc3RhcnQuDQoNCk9r
Lg0KTWF5YmUgdGhpcyBzaG91bGQgYmUgYWRkZWQgdG8gRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5n
L2Nhbi50eHQ/DQpPdGhlcndpc2UgSU1ITyB0aGlzIGJlaGF2aW9yIGlzIG5vdCBzZWxmLWV4cGxh
bmF0b3J5IC0gYXQgbGVhc3Qgbm90IHdoYXQNCkkgZGlkIGV4cGVjdC4NCg0KUmVnYXJkcw0KVGlt
bw0K
