Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3D12BB13A
	for <lists+linux-can@lfdr.de>; Fri, 20 Nov 2020 18:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgKTROH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Nov 2020 12:14:07 -0500
Received: from mail-eopbgr680130.outbound.protection.outlook.com ([40.107.68.130]:12749
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730232AbgKTROG (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 20 Nov 2020 12:14:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6AXTAZ2bOOgkInlnC1imn7ip15pUeD7SYd+SHRoIW2uAM8AXNEGHMTf9N3Q2JV2H9go5+/t19IcLrGfcFQemnxyuARZtv7VBZnvIxlMw7CSj9HCmJohICsRLzKYSSbw+ZqDg4BPRcBUEOtrpv5vzG0+XF8a7r1Ai26eOUHvXNpxrpVnJLLVHi35xj7PS8xE8ORVKqg47Bx5qneCIzyn3QpMIH1pvyXCwHlV4K2+RRYVOUCQqJoGEQlxhflf0As95bjmz2OX5HI/oEu5m0yDn8ahxKluW99+unnARjx2XisS10ADFfxwCd/z+ons8uYESFL5wTY4/30DviXSF/xf2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iuqta0/BfKZuim0T/RRoAgaY/OthHVtOae9etrhDuk=;
 b=E9zh2jgsm1PF4KzwDw1CtIT7QawzryYltBT0z0IfNYwMoUcUGnDqx/us0mp+AQIvWnSSrfgN2SC3jJO3i9+JCxbngNo2xbxYh6x9NPLUX669IMYXrlPVH0LcqOAZQ/g3SbduB7LoOKhE5OO102cZjmHGj589gG31e90llhpX+HrhbooHA11YIDpzZow5Oh9n/yfU7+oiHK51auhXGdDExfGpkPzegR3MOfRWlZ2QSuvCR9JZUTSWCoWZs3mLzTK8Q509gSgWGDcI6Fj23IKMFpaGAdkUoFGWD7ji67alqfT6D+wjcYpAiiWWG5WIGJ5u65UEg//EqQ+o4ysEBRIRrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=enphaseenergy.com; dmarc=pass action=none
 header.from=enphaseenergy.com; dkim=pass header.d=enphaseenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=enphaseenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iuqta0/BfKZuim0T/RRoAgaY/OthHVtOae9etrhDuk=;
 b=a4Ji/8o/vG+zxlUjFv3l8hVqYqwIT4jRN47rJTKRZOhzS/i4tXpXBaNL9rT8nknbaoec8aYqMQ4YjiDZtxwSEZuAwj/R6RuQ2VysWOS7+FDqaQF8jqz11hj5o+YtdBk3QimZMC+OGUcmvi69xWfwsabOfmNwq2sfYte9xV/d4YU=
Received: from DM6PR19MB3673.namprd19.prod.outlook.com (2603:10b6:5:206::16)
 by DM6PR19MB3497.namprd19.prod.outlook.com (2603:10b6:5:202::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Fri, 20 Nov
 2020 17:14:03 +0000
Received: from DM6PR19MB3673.namprd19.prod.outlook.com
 ([fe80::7505:95f8:9549:fff1]) by DM6PR19MB3673.namprd19.prod.outlook.com
 ([fe80::7505:95f8:9549:fff1%7]) with mapi id 15.20.3564.028; Fri, 20 Nov 2020
 17:14:03 +0000
From:   Jin Park <jpark@enphaseenergy.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: Question on CAN FD Driver for mcp251xfd
Thread-Topic: Question on CAN FD Driver for mcp251xfd
Thread-Index: Ada+6SXgGDp9dY+gRy+LbXKWK3qUSwAIyAyAABURNSA=
Date:   Fri, 20 Nov 2020 17:14:03 +0000
Message-ID: <DM6PR19MB36739C691B6C35B4AD7DF77AB1FF0@DM6PR19MB3673.namprd19.prod.outlook.com>
References: <DM6PR19MB3673FBAAA7A80E458659666EB1FF0@DM6PR19MB3673.namprd19.prod.outlook.com>
 <f168b9a4-79ae-7a8b-b074-632f86e8596b@pengutronix.de>
In-Reply-To: <f168b9a4-79ae-7a8b-b074-632f86e8596b@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=enphaseenergy.com;
x-originating-ip: [209.37.103.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3751c87e-1f14-4e06-21db-08d88d77ae46
x-ms-traffictypediagnostic: DM6PR19MB3497:
x-microsoft-antispam-prvs: <DM6PR19MB3497505CA81B237FB442F19DB1FF0@DM6PR19MB3497.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gslz9klCop+uv3I0ny7yLF9+9xhOiGG+tUjM1/DV/mVdtG0GTkO3FCgQuK75c7MMP7N05Dc4ZzUO7pKXAQj4JbHD9odPG+k5eka9rutbVSL8EAtZuh1a2KU86m3hjHVA2ZKFC1RjwpN+zF+LvZgC/uMjEu6NYi7YZXejZXBk1M403PdyXW57HpPSYcYJHwqAt+FF0FUNdSnkAIojEKUUkaZfVh/Vy+YmpQpqZLqvZ+us1KNf2Or4IPxn9oXh0+Au+Qi+EmQNiTCwWxHDFgEM1YNEG5E8PjRH9eG2Njuw1m8MQ60pasgzzOLuFuoASpP2vJ6neyxmj4Y0QRwzH03YFl4MdJRfAFJPK95cZVga9v3bYpU9HFU9mNrLMS+zFtVwk2U9IEVpUqGPh7y6jFptzgwpDQPRO5x5jTqegzsPDlVAP7yg1iZLSQ1AJwjBq6xeXeaxaZG6x0ldyFYnROuYmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB3673.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(86362001)(33656002)(186003)(478600001)(7696005)(83080400002)(83380400001)(4326008)(110136005)(966005)(26005)(316002)(6506007)(9686003)(71200400001)(76116006)(8936002)(2906002)(55016002)(52536014)(64756008)(66556008)(8676002)(66476007)(5660300002)(66946007)(53546011)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lcr0N5PGg+Ls5mok9VjJ6BONZob8smi+/6aO+BO1ZdvsB8mlhiuS49v2sigZfC2zBM9HDDzW/Gi7q/IYjv2bVsqO9xJcjaS3/QkhhJZoat6qzh17aBZ+0Hr5O/LrAlnK0nMTCi/YXA/XkhUsYbMP8nglqt6o53Y6X8FyQ4S8Fk5w2f1EfMswwabY09JNyjiFYaLsGbRI4zyey4LFJ4aly1IHl1N+kpH34SfzyDItPSayCSF0hvtQWS2rSLenyd2Hgrk5NSThd3YxIowV64sIYvRi6geJYyYZjWHXa+tYctAEYDm8H1GbkKoFl62DnFuhrm1UnGQacueltsRSLxJahGketuprRCnTpHjicNQyEti6go/YkVmnDUUo8usqbt0dJSWwuxmxhZ4eViXG+aZB8NFy1MV61r7kOJUdhjSnsibSPNu4qaHqKtW2cs3VYohQOTw/uBIHrQFRcZ6A6+bMUrfviJGP74GGV4J6fBKX41cP6/o8+Hl64SmA5aP8ITtbuwrhkISJ+F9UPaB6hicrc2VzNqP8IUY4vqOzYCP15bgG+88ZhyNkn66wbFGoX6B25LUF0deofn+cBkaIcsLC8J0ftCxAHEcfE/gJsHVSX1NfX0kTKY6u8Zds8cLuQ5A+oaPs6/kwjDv6Dby6iY3lElxG3OOcq21qXfvDPAEQ+dIRVe/UBAIujxKrfD9jMD0C8sZYJh4ZFlA/NwrigSPRNm/PMIvMHHkUZffdWx/dgBUkmDn8dsoxihaEh2KKtlvyyaQ1uy70YqZwrc8oYey80gnMvIYqG93S7qtbvZSppdJulC5/VAy9/oApWmUGwUjCFHjmf39xhWPOXKicEJjKAvAhXjaFQ2HXMYMFzGuFT+VQtJZTR/qAmAbdsAJt3wZ2Wk08Kr8KaPGJmI04e9jA3w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: enphaseenergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB3673.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3751c87e-1f14-4e06-21db-08d88d77ae46
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 17:14:03.6302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7df9352f-c5eb-4007-a723-44c078605c7a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KK2wmU6g3aVFDfGNcqccDnTLX5np+eRC4XRaw8MMrAFYPyrV998v/LLsUKxGEO688445Y0T4vWYHslrKXmT+IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3497
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGVsbG8gTWFyYywNCg0KSGVyZSBhcmUgbXkgYW5zd2Vycy4NClZBUi1TT00tTVg4TS1OYW5vIGJv
YXJkIGRyaXZlcyBNQ1AyNTE3RkQvTUNQMjUxOEZEIChDQU4gRkQgY29udHJvbGxlcikgYW5kIFRD
QU4zMzJHIChDQU4gRkQgVHJhbnNjZWl2ZXIpIGZvciBDQU4gRkQgY29tbXVuaWNhdGlvbi4NCg0K
MSkgV2hpY2ggY29tbWFuZHMgaGF2ZSB5b3UgdHJpZWQ/DQoyKSBXaGF0IGFyZSB0aGUgZXJyb3Ig
bWVzc2FnZXM/DQpQbGVhc2Ugc2VlIGJlbG93IGEpLCBiKSwgYyksIGFuZCBkKS4NCg0KCWEpIEJh
c2VkIG9uIEJpdCBSYXRlIFN3aXRjaGluZyBmZWF0dXJlIGluIENBTiBGRCwgdGhlIGJpdCByYXRl
IGF0IGRhdGEgcGhhc2UgYW5kIGFyYml0cmF0aW9uIHBoYXNlIChvciBub21pbmFsIHBoYXNlKSBj
YW4gYmUgc2V0IGluIENBTiBGRCBwcm90b2NvbC4NClNvLCBJIHRyaWVkIGJlbG93Lg0KLSBjb21t
YW5kDQppcCBsaW5rIHNldCBjYW4wIHR5cGUgY2FuIGRiaXRyYXRlIDEwMDAwMDANCg0KLSBlcnJv
ciBtZXNzYWdlDQpSVE5FVExJTksgYW5zd2VyczogT3BlcmF0aW9uIG5vdCBzdXBwb3J0ZWQNCg0K
CQ0KDQoJYikgVG8gdHVybiBvbiBGRCBtb2RlLCBJIHRyaWVkIGJlbG93Lg0KLSBjb21tYW5kDQpp
cCBsaW5rIHNldCBjYW4wIHR5cGUgY2FuIGZkIG9uDQoNCi0gZXJyb3IgbWVzc2FnZQ0KUlRORVRM
SU5LIGFuc3dlcnM6IE9wZXJhdGlvbiBub3Qgc3VwcG9ydGVkDQoNCg0KDQoJYykgVG8gc2VuZCBD
QU4gRkQgbWVzc2FnZSwgSSB0cmllZCBiZWxvdy4gVGgNCi0gY29tbWFuZA0KY2Fuc2VuZCBjYW4w
IDEyMyMjMQ0KDQotIGVycm9yIG1lc3NhZ2UNCkNBTiBpbnRlcmZhY2UgaXMgbm90IENBTiBGRCBj
YXBhYmxlIC0gc29ycnkuDQoNCi0gaGVscCB0ZXh0IGZvciBjYW5zZW5kDQogICAgPGNhbl9pZD4j
e1J8ZGF0YX0gICAgICAgICAgZm9yIENBTiAyLjAgZnJhbWVzDQogICAgPGNhbl9pZD4jIzxmbGFn
cz57ZGF0YX0gICAgZm9yIENBTiBGRCBmcmFtZXMNCg0KPGNhbl9pZD4gY2FuIGhhdmUgMyAoU0ZG
KSBvciA4IChFRkYpIGhleCBjaGFycw0Ke2RhdGF9IGhhcyAwLi44ICgwLi42NCBDQU4gRkQpIEFT
Q0lJIGhleC12YWx1ZXMgKG9wdGlvbmFsbHkgc2VwYXJhdGVkIGJ5ICcuJykNCjxmbGFncz4gYSBz
aW5nbGUgQVNDSUkgSGV4IHZhbHVlICgwIC4uIEYpIHdoaWNoIGRlZmluZXMgY2FuZmRfZnJhbWUu
ZmxhZ3MNCg0KZS5nLiA1QTEjMTEuMjIzMy40NDU1NjY3Ny44OCAvIDEyMyNERUFEQkVFRiAvIDVB
QSMgLyAxMjMjIzEgLyAyMTMjIzMxMQ0KICAgICAxRjMzNDQ1NSMxMTIyMzM0NDU1NjY3Nzg4IC8g
MTIzI1IgZm9yIHJlbW90ZSB0cmFuc21pc3Npb24gcmVxdWVzdC4NCg0KDQoNCg0KDQoJZCkgVENB
TjMzMkcgKENBTiBGRCBUcmFuc2NlaXZlcikgY2FuIHN1cHBvcnQgNU1icHMgYXQgZGF0YSBwaGFz
ZSBpbiBDQU4gRkQgbW9kZS4gDQpDdXJyZW50IHN1cHBvcnRlZCBtYXhpbXVtIGJpdHJhdGUgaW4g
dGhlIGRyaXZlciBpcyBub3cgMU1icHMgYXQgbm9taW5hbCByYXRlLg0KKEZZSSwgYml0IHJhdGUg
aW4gZGF0YSBwaGFzZSBhdCBDQU4gRkQgcHJvdG9jb2wgaXMgdXAgdG8gOE1icHMpDQogICAgICAg
IFdoZXJlOiBCSVRSQVRFICA6PSB7IDEuLjEwMDAwMDAgfQ0KICAgICAgICAgICAgICAgICAgU0FN
UExFLVBPSU5UICA6PSB7IDAuMDAwLi4wLjk5OSB9DQogICAgICAgICAgICAgICAgICBUUSAgICAg
ICAgICAgIDo9IHsgTlVNQkVSIH0NCiAgICAgICAgICAgICAgICAgIFBST1AtU0VHICAgICAgOj0g
eyAxLi44IH0NCiAgICAgICAgICAgICAgICAgIFBIQVNFLVNFRzEgICAgOj0geyAxLi44IH0NCiAg
ICAgICAgICAgICAgICAgIFBIQVNFLVNFRzIgICAgOj0geyAxLi44IH0NCiAgICAgICAgICAgICAg
ICAgIFNKVyAgICAgICAgICAgOj0geyAxLi40IH0NCiAgICAgICAgICAgICAgICAgIFJFU1RBUlQt
TVMgICAgOj0geyAwIHwgTlVNQkVSIH0NCg0KDQoNCjMpIFdoYXQgZG9lc24ndCB3b3JrIGV4YWN0
bHk/DQoNCkkgd291bGQgbGlrZSB0byBzZW5kIGFuZCByZWNlaXZlIG1lc3NhZ2VzIGluIENBTiBG
RCB3aXRoIEJpdCBSYXRlIFN3aXRjaGluZyAoQXJiaXRyYXRpb24gcGhhc2U6IDFNYnBzLCBEYXRh
IHBoYXNlOiA1TWJwcykuDQpTbyBmYXIsIENBTiBGRCBtb2RlIGRvZXNuJ3QgdHVybiBvbiB3aXRo
IGFib3ZlIGNvbW1hbmRzLg0KDQpUaGFua3MsDQpKaW4NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogTWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25peC5kZT4gDQpT
ZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTksIDIwMjAgMTE6MTEgUE0NClRvOiBKaW4gUGFyayA8
anBhcmtAZW5waGFzZWVuZXJneS5jb20+OyBtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9y
Zw0KU3ViamVjdDogUmU6IFF1ZXN0aW9uIG9uIENBTiBGRCBEcml2ZXIgZm9yIG1jcDI1MXhmZA0K
DQpIZWxsbyBKaW4gUGFyaywNCg0KcGxlYXNlIHVzZSB0aGUgbGludXgtY2FuIG1haWxpbmcgbGlz
dCAobGludXgtY2FuQHZnZXIua2VybmVsLm9yZykgZm9yIGNvbW11bml0eSBxdWVzdGlvbi4gVGhl
cmUgYXJlIG90aGVyIHBlb3BsZSBpbnRlcmVzdGVkIGluIHRoZXNlIHF1ZXN0aW9uLCBwbGVhc2Ug
YWRkIGxpc3Qgb24gQ2MuDQoNCk9uIDExLzIwLzIwIDQ6MDMgQU0sIEppbiBQYXJrIHdyb3RlOg0K
PiBJIGFtIHVzaW5nIE1DUDI1MVhGRCBTUEktQ0FOIE5ldHdvcmsgRHJpdmVyIHdpdGggVkFSLVNP
TS1NWDhNLU5BTk8gDQo+IGJvYXJkIG5vdyBhbmQgd291bGQgbGlrZSB0byBhc2sgd2hldGhlciBp
dCBjYW4gc3VwcG9ydCBDQU4gRkQgZmVhdHVyZXMgYXMgd2VsbC4NCg0KWWVzIGl0IGRvZXMgc3Vw
cG9ydCBDQU4tRkQuDQoNCj4gSSB0cmllZCB0byBjb21tYW5kIHdpdGggQ0FOIEZEIGZlYXR1cmVz
IGluIHRlcm1pbmFsIGFuZCBpdCBkaWRu4oCZdCB3b3JrIA0KPiB3aXRoIENBTiBGRCBjb21tYW5k
cy4NCg0KV2hpY2ggY29tbWFuZHMgaGF2ZSB5b3UgdHJpZWQ/DQpXaGF0IGFyZSB0aGUgZXJyb3Ig
bWVzc2FnZXM/DQpXaGF0IGRvZXNuJ3Qgd29yayBleGFjdGx5Pw0KDQo+IElzIHRoZXJlIGFueSBw
bGFuIHRvIHJlbGVhc2UgQ0FOIEZEIExpbnV4IERyaXZlciBpbiB0aGUgZnV0dXJlLCBpZiB5b3Ug
DQo+IGhhdmUgd29ya2VkIG9uIENBTiBGRD8NCg0KSXQgc2hvdWxkIGJlIHdvcmtpbmcuDQoNCk1h
cmMNCg0KLS0gDQpQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICB8IE1hcmMgS2xlaW5l
LUJ1ZGRlICAgICAgICAgICB8DQpFbWJlZGRlZCBMaW51eCAgICAgICAgICAgICAgICAgICB8IGh0
dHBzOi8vd3d3LnBlbmd1dHJvbml4LmRlICB8DQpWZXJ0cmV0dW5nIFdlc3QvRG9ydG11bmQgICAg
ICAgICB8IFBob25lOiArNDktMjMxLTI4MjYtOTI0ICAgICB8DQpBbXRzZ2VyaWNodCBIaWxkZXNo
ZWltLCBIUkEgMjY4NiB8IEZheDogICArNDktNTEyMS0yMDY5MTctNTU1NSB8DQoNCg==
