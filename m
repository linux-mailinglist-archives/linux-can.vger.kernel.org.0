Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383E75546B2
	for <lists+linux-can@lfdr.de>; Wed, 22 Jun 2022 14:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351980AbiFVJWT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 22 Jun 2022 05:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352484AbiFVJWS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 22 Jun 2022 05:22:18 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AFA534BA9
        for <linux-can@vger.kernel.org>; Wed, 22 Jun 2022 02:22:17 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-99-ZMj6y0FbM960kuDBi-9YiQ-1; Wed, 22 Jun 2022 10:22:14 +0100
X-MC-Unique: ZMj6y0FbM960kuDBi-9YiQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Wed, 22 Jun 2022 10:22:12 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Wed, 22 Jun 2022 10:22:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vincent MAILHOL' <mailhol.vincent@wanadoo.fr>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: RE: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
Thread-Topic: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
Thread-Index: AQHYhYfqVaqlcIuK10S0028j1oZk3K1bJ6wg
Date:   Wed, 22 Jun 2022 09:22:12 +0000
Message-ID: <48caa879b0064ced97623bf1dad5b2d9@AcuMS.aculab.com>
References: <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-2-rhett.aultman@samsara.com>
 <20220611153104.sksoxn4dmo5rgnk3@pengutronix.de>
 <CAMZ6RqJvU=kvkucq0JiKgTVxTBJveCe47U-UCguKTdpLvh7kHw@mail.gmail.com>
 <YrHM8mqG3WVVesk4@kroah.com>
 <CAMZ6RqLVu-kPy-EAy52a5VvRmv=9RUTC2nw0gwQUgg_rTgiB5A@mail.gmail.com>
 <YrHfuVF4bPXzihEZ@rowland.harvard.edu>
 <CAMZ6RqL42DKD3evR4skswaJnAwOAO_qrZgXoLax7O95xVKUomQ@mail.gmail.com>
In-Reply-To: <CAMZ6RqL42DKD3evR4skswaJnAwOAO_qrZgXoLax7O95xVKUomQ@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

RnJvbTogVmluY2VudCBNQUlMSE9MDQo+IFNlbnQ6IDIxIEp1bmUgMjAyMiAxNjo1Ng0KPiANCj4g
T24gV2VkLiAyMiBKdW4gMjAyMiBhdCAwMDoxMywgQWxhbiBTdGVybiA8c3Rlcm5Acm93bGFuZC5o
YXJ2YXJkLmVkdT4gd3JvdGU6DQo+ID4gT24gVHVlLCBKdW4gMjEsIDIwMjIgYXQgMTE6NTk6MTZQ
TSArMDkwMCwgVmluY2VudCBNQUlMSE9MIHdyb3RlOg0KPiA+ID4gSSAocHJvYmFibHkgd3Jvbmds
eSkgYXNzdW1lZCB0aGF0IHVyYjo6dHJhbnNmZXJfYnVmZmVyX2xlbmd0aCB3YXMgdGhlDQo+ID4g
PiBhbGxvY2F0ZWQgbGVuZ3RoIGFuZCB1cmI6OmFjdHVhbF9sZW5ndGggd2FzIHdoYXQgd2FzIGFj
dHVhbGx5IGJlaW5nDQo+ID4gPiB0cmFuc2ZlcnJlZC4gUmlnaHQgbm93LCBJIGFtIGp1c3QgY29u
ZnVzZWQuIFNlZW1zIHRoYXQgSSBuZWVkIHRvIHN0dWR5DQo+ID4gPiBhIGJpdCBtb3JlIGFuZCB1
bmRlcnN0YW5kIHRoZSByZWFsIHB1cnBvc2Ugb2YNCj4gPiA+IHVyYjo6dHJhbnNmZXJfYnVmZmVy
X2xlbmd0aCBiZWNhdXNlIEkgc3RpbGwgZmFpbCB0byB1bmRlcnN0YW5kIGluDQo+ID4gPiB3aGlj
aCBzaXR1YXRpb24gdGhpcyBjYW4gYmUgZGlmZmVyZW50IGZyb20gdGhlIGFsbG9jYXRlZCBsZW5n
dGguDQo+ID4NCj4gPiB1cmItPnRyYW5zZmVyX2J1ZmZlcl9sZW5ndGggaXMgdGhlIGFtb3VudCBv
ZiBkYXRhIHRoYXQgdGhlIGRyaXZlciB3YW50cw0KPiA+IHRvIHNlbmQgb3IgZXhwZWN0cyB0byBy
ZWNlaXZlLiAgdXJiLT5hY3R1YWxfbGVuZ3RoIGlzIHRoZSBhbW91bnQgb2YgZGF0YQ0KPiA+IHRo
YXQgd2FzIGFjdHVhbGx5IHNlbnQgb3IgYWN0dWFsbHkgcmVjZWl2ZWQuDQo+ID4NCj4gPiBOZWl0
aGVyIG9mIHRoZXNlIHZhbHVlcyBoYXMgdG8gYmUgdGhlIHNhbWUgYXMgdGhlIHNpemUgb2YgdGhl
IGJ1ZmZlciAtLQ0KPiA+IGJ1dCB0aGV5IGJldHRlciBub3QgYmUgYmlnZ2VyIQ0KPiANCj4gVGhh
bmtzLiBOb3cgdGhpbmdzIGFyZSBhIGJpdCBjbGVhcmVyLg0KPiBJIGd1ZXNzIHRoYXQgZm9yIHRo
ZSBvdXRjb21pbmcgVVJCIHdoYXQgSSBwcm9wb3NlZCBtYWRlIG5vIHNlbnNlLiBGb3INCj4gaW5j
b21pbmcgVVJCLCBJIGd1ZXNzIHRoYXQgbW9zdCBvZiB0aGUgZHJpdmVycyB3YW50IHRvIHNldA0K
PiB1cmI6OnRyYW5zZmVyX2J1ZmZlciBvbmNlIGZvciBhbGwgd2l0aCB0aGUgYWxsb2NhdGVkIHNp
emUgYW5kIG5ldmVyDQo+IHRvdWNoIGl0IGFnYWluLg0KPiANCj4gTWF5YmUgdGhlIHBhdGNoIG9u
bHkgbWFrZXMgc2Vuc2Ugb2YgdGhlIGluY29taW5nIFVSQi4gV291bGQgaXQgbWFrZQ0KPiBzZW5z
ZSB0byBrZWVwIGl0IGJ1dCB3aXRoIGFuIGFkZGl0aW9uYWwgY2hlY2sgdG8gdHJpZ2dlciBhIGRt
ZXNnDQo+IHdhcm5pbmcgaWYgdGhpcyBpcyB1c2VkIG9uIGFuIG91dGNvbWluZyBlbmRwb2ludCBh
bmQgd2l0aCBhZGRpdGlvbmFsDQo+IGNvbW1lbnQgdGhhdCB0aGUgVVJCX0ZSRUVfQ09IRVJFTlQg
cmVxdWlyZXMgdXJiOjp0cmFuc2Zlcl9idWZmZXIgdG8gYmUNCj4gdGhlIGFsbG9jYXRlZCBzaXpl
Pw0KDQpJSVJDIHVyYiBhcmUgcHJldHR5IGJpZy4NCllvdSdkIGJlIHVubHVja3kgaWYgYWRkaW5n
IGFuIGV4dHJhIGZpZWxkIHRvIGhvbGQgdGhlIGFsbG9jYXRlZA0Kc2l6ZSB3b3VsZCBldmVyIG5l
ZWQgbW9yZSBtZW1vcnkuDQpTbyBpdCBtaWdodCBqdXN0IGJlIHdvcnRoIHNhdmluZyB0aGUgYWxs
b2NhdGVkIHNpemUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

