Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0498565DD
	for <lists+linux-can@lfdr.de>; Wed, 26 Jun 2019 11:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfFZJqw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Jun 2019 05:46:52 -0400
Received: from mail.vanhool.be ([81.246.120.164]:63031 "EHLO mail.vanhool.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfFZJqv (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 26 Jun 2019 05:46:51 -0400
X-Greylist: delayed 1168 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jun 2019 05:46:50 EDT
Received: from mail.vanhool.be (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27BA7FC061;
        Wed, 26 Jun 2019 11:27:18 +0200 (CEST)
Received: from mail.vanhool.be (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CC57FC060;
        Wed, 26 Jun 2019 11:27:18 +0200 (CEST)
Received: from mailserver3.corp.vanhool.com (unknown [160.1.7.209])
        by mail.vanhool.be (Postfix) with ESMTPS;
        Wed, 26 Jun 2019 11:27:18 +0200 (CEST)
Received: from mailserver3.corp.vanhool.com (2002:a001:7d1::a001:7d1) by
 mailserver3.corp.vanhool.com (2002:a001:7d1::a001:7d1) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 26 Jun 2019 11:27:17 +0200
Received: from mailserver3.corp.vanhool.com ([fe80::6427:372:f132:9b49]) by
 mailserver3.corp.vanhool.com ([fe80::6427:372:f132:9b49%12]) with mapi id
 15.00.1395.000; Wed, 26 Jun 2019 11:27:17 +0200
From:   AVERMAETE Kristoff <kristoff.avermaete@vanhool.com>
To:     'Marc Kleine-Budde' <mkl@pengutronix.de>,
        David Jander <david@protonic.nl>
CC:     linux-can <linux-can@vger.kernel.org>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: RE: Linux J1939: built in-kernel vs. user space stack?
Thread-Topic: Linux J1939: built in-kernel vs. user space stack?
Thread-Index: AQHVK/Gtq8+36/xMOUugmilDCJp9mqatdIwAgAADVYCAACLecA==
Date:   Wed, 26 Jun 2019 09:27:17 +0000
Message-ID: <6622af4fcee74cbf9e8eae4be4c6c3a2@mailserver3.corp.vanhool.com>
References: <79f5ed74-671a-4253-2628-7d9df58f3694@pengutronix.de>
 <20190626101306.164d36f9@erd988>
 <92d20042-9195-8199-59fe-48ceaa7837cd@pengutronix.de>
In-Reply-To: <92d20042-9195-8199-59fe-48ceaa7837cd@pengutronix.de>
Accept-Language: nl-BE, en-US
Content-Language: nl-NL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [160.1.12.101]
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-GCONF: 11111111
X-TM-AS-SMTP: 1.0 bWFpbHNlcnZlcjMuY29ycC52YW5ob29sLmNvbQ== 
        a3Jpc3RvZmYuYXZlcm1hZXRlQHZhbmhvb2wuY29t
X-TM-AS-ERS: 160.1.7.209-127.5.249.21
X-TM-AS-Product-Ver: IMSVA-9.1.0.1976-8.5.0.1020-24716.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSVA-9.1.0.1976-8.5.1020-24716.003
X-TMASE-Result: 10--14.663300-10.000000
X-TMASE-MatchedRID: EMyCvCfVN1GlgxshcWfq4hjFEX4UJBCyUb4EdIZGxuD7jZ40qn7f4byi
        uLk/2fH4JSzNAX5Zpi9MP01kejT9olMH2K6Z+33Hc7uq4k7WFKOuQaF33T8MPkTqq9Xa45y5vf2
        yHAohazmI5rt/DRsq4nTy4RCE61JISR9dTjlQdMnF30Jee57vxo1j+mrGi/PFgptJLUV6SF2AGS
        sd6jlkoU9uF7F9cIpv6rDTpjQ7KPOeziiX8KrRquNBBVe5eLQFg4bLQO8HYqYRGC0rW8q1XdoNe
        lO7JXwb/ye/3Hc9K1rXX+MPQbzciTWg20/TdHCGNVRz+HwqL4JuchTq5J5u9CgVbxW7FDOVt2rb
        RfUdmZ5Fz/iQE/hT84pQp5zaCPbdZB7FaQ6KQ99YcYljwpu4xGskdVh5iWKKxKLCLOyCW5D1Zeb
        7KEkrKGInJfxdRvZ7tNvIx77SGgwtIbjApBhlePC3jJqTOlQ/nkX6ZrnAtcFa6MiUgjvzmWn2Ga
        /3mGosa8g5AKL3Rbc0NDCEqdL7DWrRCqFi6ztkwrUhv0kAAvF9LQinZ4QefFEOfJuMbL5P9zw4l
        zv7RUn3FLeZXNZS4KBkcgGnJ4WmGSr9BKUkBoeflXKHbedn0GshsMcPoCWZ+rohS8AhKqd+3Bnd
        fXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-2-1:0,12:0,22:0,33:0,34:0-0
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgYWxsLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgY2xhcmlmeWluZyBhbnN3ZXJzLg0KDQpJdCBh
cHBlYXJzIEkgaGF2ZSBtYWRlIHRvbyBtYW55IGFzc3VtcHRpb25zIGFib3V0IHRoZSBsb2FkIGRp
c3RyaWJ1dGlvbjogbGlrZSBKMTkzOSBjb25maWd1cmluZyB0aGUgQ0FOIGxheWVyIGFzIHN1Y2gg
dGhhdCB0aGUgbWFqb3IgbG9hZCBpcyBoYW5kbGVkIGJ5IENBTiwgd2hpbGUgSjE5MzkncyBqb2Ig
Y2FuIGJlIGxpbWl0ZWQgdG8gaW50ZXJwcmV0aW5nIG9ubHkgcmVsZXZhbnQgaW5jb21pbmcgZGF0
YS4gU29ycnkgZm9yIHRoYXQuDQotLT4gSSB3aWxsIGRpdmUgaW50byB0aGUgaW1wbGVtZW50YXRp
b24gZGV0YWlscyBhbmQgcHJvYmFibHkgbGV2ZWwgdXAgYWJvdXQgdGhlIEoxOTM5IHByb3RvY29s
IHRvby4NCk91ciBnb2FsIGlzIHRvIGJ1aWxkIEoxOTM5IG1vZHVsZXMsIGRlZGljYXRlZCB0byBh
IHNpbmdsZSB0YXNrLiBTb21lIGV4YW1wbGVzOiBkaXNwbGF5aW5nIGNlcnRhaW4gcGFyYW1ldGVy
cywgbG9nZ2luZyBKMTkzOSB0cmFmZmljIG9uIGEgbGluZSwgaW5qZWN0aW5nIChmYXVsdHkpIG1l
c3NhZ2VzIGZvciB0ZXN0aW5nIHB1cnBvc2VzLg0KDQpTbyBJIHdpbGwgbm93IGZhbWlsaWFyaXpl
IGJldHRlciB3aXRoIHRoZSBsaW51eC1jYW4gd29ybGQgYW5kIGhhdmUgYSBsb29rIGF0IGVjbGlw
c2UgdGl0YW4uIE9ubHkgdGhlbiBJIHdpbGwgYmUgYWJsZSB0byBoYXZlIGEgd2VsbC1mb3VuZGVk
IGFuc3dlciB0byB5b3VyIHJlYWN0aW9ucy4NCg0KQmVzdCByZWdhcmRzLA0KS3Jpc3RvZmYNCg0K
LS0tLS1Pb3JzcHJvbmtlbGlqayBiZXJpY2h0LS0tLS0NClZhbjogTWFyYyBLbGVpbmUtQnVkZGUg
PG1rbEBwZW5ndXRyb25peC5kZT4gDQpWZXJ6b25kZW46IHdvZW5zZGFnIDI2IGp1bmkgMjAxOSAx
MDoyNQ0KQWFuOiBEYXZpZCBKYW5kZXIgPGRhdmlkQHByb3RvbmljLm5sPg0KQ0M6IGxpbnV4LWNh
biA8bGludXgtY2FuQHZnZXIua2VybmVsLm9yZz47IEFWRVJNQUVURSBLcmlzdG9mZiA8a3Jpc3Rv
ZmYuYXZlcm1hZXRlQHZhbmhvb2wuY29tPjsgS3VydCBWYW4gRGlqY2sgPGRldi5rdXJ0QHZhbmRp
amNrLWxhdXJpanNzZW4uYmU+OyBPbGVrc2lqIFJlbXBlbCA8by5yZW1wZWxAcGVuZ3V0cm9uaXgu
ZGU+DQpPbmRlcndlcnA6IFJlOiBMaW51eCBKMTkzOTogYnVpbHQgaW4ta2VybmVsIHZzLiB1c2Vy
IHNwYWNlIHN0YWNrPw0KDQpPbiA2LzI2LzE5IDEwOjEzIEFNLCBEYXZpZCBKYW5kZXIgd3JvdGU6
DQo+PiBEbyB5b3UgdGhpbmsgaXQgd291bGQgYmUgYW4gaW50ZXJlc3RpbmcgY29udHJpYnV0aW9u
IGlmIEkgaXNvbGF0ZWQgDQo+PiB0aGUgZnVuY3Rpb25hbGl0eSBpbiB1c2VyIHNwYWNlPw0KPj4g
VGhhdCB3YXkgd2UgY291bGQgdGVzdCBvdXIgYXBwbGljYXRpb24gY29kZSBhbG9uZyB3aXRoIHRo
ZSBpc29sYXRlZA0KPj4gSjE5Mzkgc3RhY2sgb24gd2hhdGV2ZXIgQ0FOLWVuYWJsZWQgTGludXgg
cGxhdGZvcm0gaXMgcHJvdmlkZWQgdG8gdXMuDQo+Pg0KPj4gRG8geW91IHRoaW5rIHRoaXMgaXMg
YSBiYWQgaWRlYT8NCj4gDQo+IFdpdGggImlzb2xhdGluZyIgdGhlIGZ1bmN0aW9uYWxpdHkgaW4g
dXNlci1zcGFjZSwgeW91IG1lYW4gaGF2aW5nIGEgDQo+IHNlcGFyYXRlIHVzZXItc3BhY2UgSjE5
Mzkgc3RhY2sgdGhhdCBjYW4gYmUgdXNlZCBmb3IgdGVzdGluZyB0aGUga2VybmVsLXN0YWNrPw0K
PiBUaGF0IHdvdWxkIGFjdHVhbGx5IGJlIGEgZ3JlYXQgaWRlYS4NCj4gDQo+IFRoZXJlIGlzIEox
OTM5IHN1cHBvcnQgaW4gdGhlIGNhbi11dGlscyBhbHJlYWR5Og0KPiANCj4gaHR0cHM6Ly9naXRo
dWIuY29tL2xpbnV4LWNhbi9jYW4tdXRpbHMNCj4gDQo+IEJ1dCBhIGZ1bGwtYmxvd24gYWx0ZXJu
YXRpdmUgaW1wbGVtZW50YXRpb24gdGhhdCBjYW4gYmUgdXNlZCBmb3IgDQo+IHJlZ3Jlc3Npb24t
dGVzdGluZyBtYXkgYmUgbmljZSB0byBoYXZlIG9mIGNvdXJzZSwgaWYgaXQgY2FuIGJlIEdQTCdl
ZA0KDQpBbiBfYWx0ZXJuYXRpdmVfIGltcGxlbWVudGF0aW9uIG9mIGEgajE5Mzkgc3RhY2sgKGVz
cGVjaWFsbHkgd2hlbiBpdCBjb21lcyB0byAoRSlUUCkgZm9yIHRlc3Rpbmcgd291bGQgYmUgbmlj
ZSB0byBoYXZlLiBUaGlzIGlzIHdoZXJlIGVjbGlwc2UgdGl0YW4gY29tZXMgaW50byB0aGUgZ2Ft
ZS4gSG93ZXZlciBmcm9tIG15IHBvaW50IG9mIHZpZXcgaXQgbWFrZXMgbm8gc2Vuc2UgdG8gcG9y
dCB0aGUgaW4ta2VybmVsIHN0YWNrIHRvIHVzZXIgc3BhY2UuDQoNCk1hcmMNCg0KLS0gDQpQZW5n
dXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAg
ICAgfA0KSW5kdXN0cmlhbCBMaW51eCBTb2x1dGlvbnMgICAgICAgIHwgUGhvbmU6ICs0OS0yMzEt
MjgyNi05MjQgICAgIHwNClZlcnRyZXR1bmcgV2VzdC9Eb3J0bXVuZCAgICAgICAgICB8IEZheDog
ICArNDktNTEyMS0yMDY5MTctNTU1NSB8DQpBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4
NiAgfCBodHRwOi8vd3d3LnBlbmd1dHJvbml4LmRlICAgfA0KDQoNCkRJU0NMQUlNRVI6DQoNCkFu
eSBlbWFpbCBjb21taXR0aW5nIG91ciBjb21wYW55IG5lZWRzIHRvIGJlIGFwcHJvdmVkIGJ5IHRo
ZSBtYW5hZ2luZw0KZGlyZWN0b3IuIFRoaXMgZW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBhcmUg
Zm9yIHRoZSBpbnRlbmRlZCBhZGRyZXNzZWUgb25seS4gSWYgDQp5b3UgaGF2ZSByZWNlaXZlZCBp
dCBpbiBlcnJvciB0aGVuIHBsZWFzZSBkZWxldGUgaXQgYW5kIG5vdGlmeSB0aGUgc2VuZGVyIGJ5
IHJldHVybiANCmVtYWlsLiBJbiBjYXNlIG9mIGRvdWJ0IGFib3V0IGNvcnJlY3RuZXNzIG9yIGNv
bXBsZXRlbmVzcyBvZiB0aGlzIGVtYWlsIHBsZWFzZSANCmNvbnRhY3QgdGhlIHNlbmRlci4gVGhh
bmsgeW91IGZvciB5b3VyIGNvb3BlcmF0aW9uLg0KV2FybmluZzogQW55IG1haWwgc2VudCB0byB0
aGlzIGUtbWFpbCBhZGRyZXNzIGlzIGNvbnNpZGVyZWQgYXMgY29tcGFueSBtYWlsIGFuZCBjYW4g
YmUgb3BlbmVkIGJ5IHRoZSBNYW5hZ2VtZW50Lg0KVmFuIEhvb2wgY29uZGl0aW9ucyBhcmUgYXBw
bGljYWJsZSBhbmQgdGhpcyB3aXRob3V0IHJlc2VydmF0aW9uIG9uIGFsbCBvZmZlcnMsIHNhbGVz
LCBwdXJjaGFzZXMs4oCm

