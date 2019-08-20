Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C95E95D95
	for <lists+linux-can@lfdr.de>; Tue, 20 Aug 2019 13:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfHTLjk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Aug 2019 07:39:40 -0400
Received: from mx.krause.de ([88.79.216.98]:42982 "EHLO mx.krause.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729556AbfHTLjj (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 20 Aug 2019 07:39:39 -0400
Received: from [172.20.10.125] (port=50719 helo=mail.horstmanngroup.de)
        by mx.krause.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <t.schluessler@krause.de>)
        id 1i02UB-0001R5-03; Tue, 20 Aug 2019 13:39:35 +0200
Received: from HG-SRV-053.HG.local (172.20.10.125) by HG-SRV-053.HG.local
 (172.20.10.125) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 20 Aug
 2019 13:39:34 +0200
Received: from HG-SRV-053.HG.local ([::1]) by HG-SRV-053.HG.local ([::1]) with
 mapi id 15.00.1367.000; Tue, 20 Aug 2019 13:39:34 +0200
X-CTCH-RefID: str=0001.0A0B0206.5D5BDBF7.0007,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   =?utf-8?B?U2NobMO8w59sZXIsIFRpbW8=?= <t.schluessler@krause.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: Add GPIO support for mcp251x driver
Thread-Topic: Add GPIO support for mcp251x driver
Thread-Index: AdVWmfxSduWoGL3+RY65gXm3I2iEOP//6gGA//7FmmCAAo4bAP//3hPQ
Date:   Tue, 20 Aug 2019 11:39:34 +0000
Message-ID: <e75d6bcd96e0414b99c4d24a41163369@HG-SRV-053.HG.local>
References: <73336c447238499985c2ca6df1075a52@HG-SRV-053.HG.local>
 <fc7330ce-c277-088a-3a35-e8780c852f99@pengutronix.de>
 <ef7d794e0f9e4d2e8c3a32310d90d180@HG-SRV-053.HG.local>
 <c84b55f8-c22b-3dbc-208d-e63b6c60c8e0@pengutronix.de>
In-Reply-To: <c84b55f8-c22b-3dbc-208d-e63b6c60c8e0@pengutronix.de>
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

T24gOC8yMC8xOSAxOjIzIFBNLCBNYXJjIEtsZWluZS1CdWRkZSB3cm90ZToNCj4gPiBUaGFua3Mg
Zm9yIHRoZSBwb2ludGVyLg0KPiA+IA0KPiA+IFdoYXQgZG8geW91IG1lYW4gd2l0aCAicHJvcGVy
Ij8NCj4gDQo+IFRoZSByaWdodCB3YXkgdG8gZG8gR1BJT3MgaXMgdmlhIHRoZSBncGlvY2hpcCBm
cmFtZXdvcmssIHVzaW5nIGN1c3RvbQ0KPiBpb2N0bCgpIGlzIG5vdC4NCj4gDQo+ID4gQ2FuJ3Qg
d2UganVzdCBhZGQgdGhlIHJlbGV2YW50IGdwaW9jaGlwXyBjYWxscyBpbiBtY3AyNTF4eC5jPw0K
PiBPZiBjb3Vyc2UuDQo+IA0KPiBEbyBhbGwgbWNwMjUxeCB2YXJpYW50IHN1cHBvcnQgdGhlIEdQ
SU9zPw0KDQpZZXMsIGFsbCB0aHJlZSBkZXZpY2VzIGZlYXR1cmUgMyBnZW5lcmFsIHB1cnBvc2Ug
aW5wdXRzIGFuZCAyIGdlbmVyYWwgcHVycG9zZSBvdXRwdXRzLg0KVGhlIGlucHV0cyBjYW4gYWxz
byBiZSB1c2VkIHRvIHRyaWdnZXIgc2VuZGluZyBvZiBwcmVsb2FkZWQgQ0FOIG1lc3NhZ2VzLiBJ
IGRvbid0IGtub3cgaWYgdGhpcyBpcyBjb21wYXRpYmxlIHdpdGggdGhlIExpbnV4IENBTiBpbXBs
ZW1lbnRhdGlvbiBvciB3aGV0aGVyIHRoaXMgb3B0aW9uIGlzIHdhbnRlZC4NClRoZSBvdXRwdXRz
IGNhbiBhbHNvIGJlIHVzZWQgdG8gc2lnbmFsIHRoZSByZWNlcHRpb24gb2YgYSBDQU4gbWVzc2Fn
ZS4gUHJvYmFibHkgdGhpcyBvcHRpb24gc2hvdWxkbid0IGJlIHNlbGVjdGFibGUgdGhyb3VnaCB0
aGUgR1BJTyBpbnRlcmZhY2UgYnV0IHNvbWVob3cgZWxzZS4gRG8geW91IGhhdmUgYW4gaWRlYT8g
UHJvYmFibHkgdGhpcyBzaG91bGQgZ2V0IGFkZHJlc3NlZCBzZXBhcmF0ZWx5IC0gSSBqdXN0IHdh
bnRlZCB0byBtZW50aW9uIHRoYXQgdGhlIEdQSU9zIGNhbiBhbHNvIGJlIGNvbmZpZ3VyZWQgdG8g
aGF2ZSBkZWRpY2F0ZWQgZnVuY3Rpb25zLg0KDQpUaW1vDQo=
