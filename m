Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E1595E1E
	for <lists+linux-can@lfdr.de>; Tue, 20 Aug 2019 14:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbfHTMJH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Aug 2019 08:09:07 -0400
Received: from mx.krause.de ([88.79.216.98]:33799 "EHLO mx.krause.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbfHTMJG (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 20 Aug 2019 08:09:06 -0400
Received: from [172.20.10.125] (port=54361 helo=mail.horstmanngroup.de)
        by mx.krause.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <t.schluessler@krause.de>)
        id 1i02wg-0002fs-0H; Tue, 20 Aug 2019 14:09:02 +0200
Received: from HG-SRV-053.HG.local (172.20.10.125) by HG-SRV-053.HG.local
 (172.20.10.125) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 20 Aug
 2019 14:09:02 +0200
Received: from HG-SRV-053.HG.local ([::1]) by HG-SRV-053.HG.local ([::1]) with
 mapi id 15.00.1367.000; Tue, 20 Aug 2019 14:09:02 +0200
X-CTCH-RefID: str=0001.0A0C020A.5D5BE2DE.0026,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   =?utf-8?B?U2NobMO8w59sZXIsIFRpbW8=?= <t.schluessler@krause.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: Add GPIO support for mcp251x driver
Thread-Topic: Add GPIO support for mcp251x driver
Thread-Index: AdVWmfxSduWoGL3+RY65gXm3I2iEOP//6gGA//7FmmCAAo4bAP//3hPQgAAtdAD//93nwA==
Date:   Tue, 20 Aug 2019 12:09:01 +0000
Message-ID: <9ad331156824495cbcb0c34930cd2b8b@HG-SRV-053.HG.local>
References: <73336c447238499985c2ca6df1075a52@HG-SRV-053.HG.local>
 <fc7330ce-c277-088a-3a35-e8780c852f99@pengutronix.de>
 <ef7d794e0f9e4d2e8c3a32310d90d180@HG-SRV-053.HG.local>
 <c84b55f8-c22b-3dbc-208d-e63b6c60c8e0@pengutronix.de>
 <e75d6bcd96e0414b99c4d24a41163369@HG-SRV-053.HG.local>
 <a65d9365-fe29-423e-bae0-2bfefb773e69@pengutronix.de>
In-Reply-To: <a65d9365-fe29-423e-bae0-2bfefb773e69@pengutronix.de>
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

T24gOC8yMC8xOSAyOjA0IFBNLCBNYXJjIEtsZWluZS1CdWRkZSAgd3JvdGU6DQo+PiBUaGUgb3V0
cHV0cyBjYW4gYWxzbyBiZSB1c2VkIHRvIHNpZ25hbCB0aGUgcmVjZXB0aW9uIG9mIGEgQ0FOIG1l
c3NhZ2UuDQoNCj4gTGlrZSBhIFJYIGludGVycnVwdD8NCg0KWWVzLCBleGFjdGx5Lg0KDQo+PiBQ
cm9iYWJseSB0aGlzIG9wdGlvbiBzaG91bGRuJ3QgYmUgc2VsZWN0YWJsZSB0aHJvdWdoIHRoZSBH
UElPIA0KPj4gaW50ZXJmYWNlIGJ1dCBzb21laG93IGVsc2UuDQoNCj4gRmlyc3QgYWRkIHN1cHBv
cnQgZm9yIHRoZSBJbnB1dHMgYW5kIE91dHB1dHMuDQoNCkkgd2lsbCBnaXZlIGl0IGEgdHJ5Lg0K
DQo+PiBEbyB5b3UgaGF2ZSBhbiBpZGVhPyBQcm9iYWJseSB0aGlzIHNob3VsZCBnZXQgYWRkcmVz
c2VkIHNlcGFyYXRlbHkgLSBJIA0KPj4ganVzdCB3YW50ZWQgdG8gbWVudGlvbiB0aGF0IHRoZSBH
UElPcyBjYW4gYWxzbyBiZSBjb25maWd1cmVkIHRvIGhhdmUgDQo+PiBkZWRpY2F0ZWQgZnVuY3Rp
b25zLg0KDQo+IE1heWJlIHRoaXMgY2FuIGJlIGNvbmZpZ3VyZWQgd2l0aCB0aGUgcGluY3RybCBm
cmFtZXdvcmsgaW4gdGhlIGtlcm5lbC4NCj4gQnV0IHRoaXMgaXMgZnV0dXJlIHdvcmssIGRvIHlv
dSBoYXZlIHVzZWNhc2VzIGZvciB0aGF0PyBJdCBtYWtlcyBubyBzZW5zZSB0byBoYXZlIHRoZSBj
b2RlIGlmIG5vLW9uZSB1c2VzIGl0Lg0KDQpObywgdGhhdCdzIHRydWUuDQoNClRpbW8NCg==
