Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8D9115E45
	for <lists+linux-can@lfdr.de>; Sat,  7 Dec 2019 20:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLGTqC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 7 Dec 2019 14:46:02 -0500
Received: from mx.krause.de ([88.79.216.98]:48424 "EHLO mx.krause.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbfLGTqC (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 7 Dec 2019 14:46:02 -0500
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Dec 2019 14:46:01 EST
Received: from [172.20.10.125] (port=6106 helo=mail.horstmanngroup.de)
        by mx.krause.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <t.schluessler@krause.de>)
        id 1idfvk-0004bJ-1w; Sat, 07 Dec 2019 20:39:52 +0100
Received: from HG-SRV-053.HG.local (172.20.10.125) by HG-SRV-053.HG.local
 (172.20.10.125) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sat, 7 Dec
 2019 20:39:52 +0100
Received: from HG-SRV-053.HG.local ([::1]) by HG-SRV-053.HG.local ([::1]) with
 mapi id 15.00.1367.000; Sat, 7 Dec 2019 20:39:52 +0100
X-CTCH-RefID: str=0001.0A0C0209.5DEC0008.0042,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   =?utf-8?B?U2NobMO8w59sZXIsIFRpbW8=?= <t.schluessler@krause.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] can: mcp251x: add GPIO support
Thread-Topic: [PATCH v4 4/4] can: mcp251x: add GPIO support
Thread-Index: AQHVlAx16WZ4Fg24GEakbYkr3OtTR6euwVaAgABx/IA=
Date:   Sat, 7 Dec 2019 19:39:52 +0000
Message-ID: <A75EE596-C8A0-411C-A7F1-5F694C9C21DA@krause.de>
References: <e33b49a7-823e-5960-4d83-71ecf259ba87@pengutronix.de>
In-Reply-To: <e33b49a7-823e-5960-4d83-71ecf259ba87@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-ID: <63B69570D0687E4E8EDD4F71DC55E2C6@HG.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBPbiAxMi83LzE5IDI6MTEgUE0sIE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXgu
ZGU+IHdyb3RlOg0KDQo+IO+7v09uIDExLzUvMTkgODowOCBQTSwgTWFyYyBLbGVpbmUtQnVkZGUg
d3JvdGU6DQo+PiBGcm9tOiBUaW1vIFNjaGzDvMOfbGVyIDxzY2hsdWVzc2xlckBrcmF1c2UuZGU+
DQo+PiANCj4+IFRoZSBtY3AyNTF4IHZhcmlhbnRzIGZlYXR1cmUgMyBnZW5lcmFsIHB1cnBvc2Ug
ZGlnaXRhbCBpbnB1dHMgYW5kIDINCj4+IG91dHB1dHMuIFdpdGggdGhpcyBwYXRjaCB0aGV5IGFy
ZSBhY2Nlc3NpYmxlIHRocm91Z2ggdGhlIGdwaW8gZnJhbWV3b3JrLg0KPj4gDQo+PiBTaWduZWQt
b2ZmLWJ5OiBUaW1vIFNjaGzDvMOfbGVyIDxzY2hsdWVzc2xlckBrcmF1c2UuZGU+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiANCj4g
VGltbywgY2FuIHlvdSB0ZXN0IGlmIHRoZSBkcml2ZXIgd29ya3MgZm9yIHlvdT8NCg0KWWVzLCBJ
IGhvcGUgdGhhdCBJIGNhbiB0ZXN0IGl0IG9uIE1vbmRheS4NCg0KUmVnYXJkcw0KVGltbw==
