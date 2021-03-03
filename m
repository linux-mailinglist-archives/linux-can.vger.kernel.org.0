Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8AE32C59A
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 01:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355381AbhCDAXr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Mar 2021 19:23:47 -0500
Received: from mx.krause.de ([88.79.216.98]:32906 "EHLO mx.krause.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234633AbhCCK0n (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 3 Mar 2021 05:26:43 -0500
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2021 05:26:42 EST
Received: from [172.20.10.126] (port=18615 helo=mail.horstmanngroup.de)
        by mx.krause.de with esmtps (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <t.schluessler@krause.de>)
        id 1lHNzq-00024M-1K; Wed, 03 Mar 2021 10:40:46 +0100
Received: from HG-SRV-053.HG.local (172.20.10.125) by HG-SRV-054.HG.local
 (172.20.10.126) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1979.3; Wed, 3 Mar 2021
 10:40:46 +0100
Received: from HG-SRV-053.HG.local ([::1]) by HG-SRV-053.HG.local ([::1]) with
 mapi id 15.00.1367.000; Wed, 3 Mar 2021 10:40:45 +0100
X-CTCH-RefID: str=0001.0A782F22.603F599E.008A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   =?utf-8?B?U2NobMO8w59sZXIsIFRpbW8=?= <t.schluessler@krause.de>
To:     'Marc Kleine-Budde' <mkl@pengutronix.de>,
        =?utf-8?B?dWtyZm9pbC5jb20sIEPRgtGD0LTQuNC+0L/QsNC6INCj0LrRgNCw0LjQvdCw?=
         =?utf-8?B?LCDQktC+0YHRgtC+0YfQvdGL0Lkg0YDQtdCz0LjQvtC9?= 
        <ukrfoil@gmail.com>
CC:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can <linux-can@vger.kernel.org>
Subject: RE: mcp251x hangs during ifup
Thread-Topic: mcp251x hangs during ifup
Thread-Index: AQHXDwULsseziUMWSEmfL1A+/cbmIKpwOdWAgAAg2xCAALbIgIAAvOSAgAAFCQCAAAEPgIAAA2GAgAACIoCAAASdAIAAAmwAgAAf3qA=
Date:   Wed, 3 Mar 2021 09:40:45 +0000
Message-ID: <ce8e93fce5e44fa9a4c097d06e3e2be1@HG-SRV-053.HG.local>
References: <CAMZ6RqKfXR9cHxjvnPwxjWHWEuxYNV9V4qLSd0ZQGP0JOMKX0w@mail.gmail.com>
 <20210302071901.ptwvejkedascbdsv@pengutronix.de>
 <638520bccd0c44d091d5715fe7d303ec@HG-SRV-053.HG.local>
 <CACGOs=TG4jyXKHBfPGDEJp1gSA+PyNVqCM7grPGMpe9+wYDBLA@mail.gmail.com>
 <20210303072653.zb66tkdlsxtval5n@pengutronix.de>
 <CACGOs=TJhoV99D=V-7xa8LG6Ftx8SWUO_XCHGAP3L1_UGLVm3w@mail.gmail.com>
 <20210303074841.me5egjpecebrpxc4@pengutronix.de>
 <CACGOs=SOxiN1PKhZvhTizH92vneKUOfjxL+9fg4-=JmHHgYtNw@mail.gmail.com>
 <20210303080825.lcpphr2ihvuugfl7@pengutronix.de>
 <CACGOs=SSEvb=5AG9a7dSpOuiaq-wX+FLe3NAMEtKcMFdwJx8Pw@mail.gmail.com>
 <20210303083336.4rn47cnzcexk7czq@pengutronix.de>
In-Reply-To: <20210303083336.4rn47cnzcexk7czq@pengutronix.de>
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

T24gMDMuMDMuMjAyMSAwOTozNCwgTWFyYyBLbGVpbmUtQnVkZGUgd3JvdGU6DQo+IFRpbW8sIGNh
biB5b3UgY2hhbmdlIHRoZSByb3V0aW5lIHRvIGtlZXAgdGhlIGludGVycnVwdHMgZW5hYmxlZD8N
Cg0KSSB0aGluayBpdCBzaG91bGQgYmUgcG9zc2libGUgYnkgaWdub3JpbmcgdGhlIGludGVycnVw
dCBpbiB0aGUgaGFuZGxlciBpdHNlbGYuIEFzIGZhciBhcyBJIHJlbWVtYmVyIGRpc2FibGluZyB0
aGUNCmludGVycnVwdHMgd2FzIGltcGxlbWVudGVkIGluIHRoZSBkcml2ZXIgZXZlbiBiZWZvcmUg
SSBhZGRlZCB0aGUgR1BJTyBzdXBwb3J0LCBzbyBJIGRvbid0IGtub3cgZXhhY3RseSB3aHkNCml0
IHdhcyBtYWRlIGxpa2UgdGhpcy4NCk1heWJlIGxhdGVyIHRoaXMgd2VlayBJIGNhbiBoYXZlIGEg
Y2xvc2VyIGxvb2sgaW50byB0aGlzLg0KDQpSZWdhcmRzDQpUaW1vDQo=
