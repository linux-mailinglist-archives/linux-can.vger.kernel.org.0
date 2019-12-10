Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE09118514
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2019 11:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfLJK3B (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 Dec 2019 05:29:01 -0500
Received: from mx.krause.de ([88.79.216.98]:42650 "EHLO mx.krause.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbfLJK3B (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 10 Dec 2019 05:29:01 -0500
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Dec 2019 05:29:01 EST
Received: from [172.20.10.125] (port=32831 helo=mail.horstmanngroup.de)
        by mx.krause.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <t.schluessler@krause.de>)
        id 1iecfU-0004aU-0c; Tue, 10 Dec 2019 11:23:00 +0100
Received: from HG-SRV-053.HG.local (172.20.10.125) by HG-SRV-053.HG.local
 (172.20.10.125) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 10 Dec
 2019 11:23:00 +0100
Received: from HG-SRV-053.HG.local ([::1]) by HG-SRV-053.HG.local ([::1]) with
 mapi id 15.00.1367.000; Tue, 10 Dec 2019 11:23:00 +0100
X-CTCH-RefID: str=0001.0A0C0202.5DEF7204.0039,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   =?utf-8?B?U2NobMO8w59sZXIsIFRpbW8=?= <t.schluessler@krause.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Subject: RE: [PATCH v4 4/4] can: mcp251x: add GPIO support
Thread-Topic: [PATCH v4 4/4] can: mcp251x: add GPIO support
Thread-Index: AQHVlAx16WZ4Fg24GEakbYkr3OtTR6euwVaAgABx/ICABCsiYA==
Date:   Tue, 10 Dec 2019 10:23:00 +0000
Message-ID: <8ed73361acfa4d6aba703a6164d2d4b9@HG-SRV-053.HG.local>
References: <e33b49a7-823e-5960-4d83-71ecf259ba87@pengutronix.de>
 <A75EE596-C8A0-411C-A7F1-5F694C9C21DA@krause.de>
In-Reply-To: <A75EE596-C8A0-411C-A7F1-5F694C9C21DA@krause.de>
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

T24gMTIvMDcvMTkgODo0MCBQTSwgVGltbyBTY2hsw7zDn2xlciB3cm90ZToNCj4+IFRpbW8sIGNh
biB5b3UgdGVzdCBpZiB0aGUgZHJpdmVyIHdvcmtzIGZvciB5b3U/DQo+IFllcywgSSBob3BlIHRo
YXQgSSBjYW4gdGVzdCBpdCBvbiBNb25kYXkuDQoNCkkgdGVzdGVkIHRoZSBkcml2ZXIuIEV2ZXJ5
dGhpbmcgd29ya3MgYXMgaXQgc2hvdWxkLg0KSSBkaWRuJ3QgdGVzdCB0aGUgc3VzcGVuZC9yZXN1
bWUgZnVuY3Rpb25zLCBhcyB0aGlzIGlzDQpub3QgaW1wbGVtZW50ZWQgZm9yIHRoZSBSYXNwYmVy
cnkgUGkuDQoNClJlZ2FyZHMNClRpbW8NCg==
