Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD113E4DC3
	for <lists+linux-can@lfdr.de>; Mon,  9 Aug 2021 22:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhHIUZk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Aug 2021 16:25:40 -0400
Received: from mail-fr2deu01on2070.outbound.protection.outlook.com ([40.107.135.70]:26561
        "EHLO DEU01-FR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236220AbhHIUZk (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 9 Aug 2021 16:25:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJoL0r0NQhnBv4d+GvTPMHSQRgy6dftXPXLCCAOHtSvFQY5rHdY2LJ6I3G4ArMkxqNJ2hHBdpaQSdHOycalXeuVbuakhS50MxAUzLegMZTM3x/wiBRkJ5K/1yqQRIer+dwdNrFpgqkqdUsYmFHmLX3QTTSl7pgNDlkaH0iEMtvmM6lOAWOhoWmr6Ruez8KQ3RyQW3n0FxTg1W3KtgEml1Wc7jmMI6MAoiqszYk3eRiYqqnKmQ4QylAGCq621HVUtRx1I6xnDN35mRJx0EIN7GANGKEFyB2vypg0XFhL/7u2LT55WYfXk1wRT0yCiJNjMiXgsbqzO6eHPfOZyzMokKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oBxPBun8VVEsRw2Rb01f9kqbjcaFZPSbk1hyh/Ojyw=;
 b=LUWjcIRV+fx99f+dRYqE91viBQdjVwAtjxK5rxSL7/KKDBo28kDoF/g+6lXuTuJHlBTu71WoeGq9xaxZ2LFrfbtfUg8DH1ncAcyDfbOWDi4ALef6m5maICAMjejr4XEcHVLvYsKbKQdv4mFQheJjHRkhkN3J7Ob/YFbkMiG8mtw538qirnnStvfBTehQpnqN7PORS4jMj37lINaV+pepw4XZ1jRy94tLCKIgxk5QAGlQ+onAI6ouvsXCVy9u9gR7lqoS/GdAxv3nLqrQ4lkvPnm59iXZDWMy89npXSMOG2/E0eO339slUk4P6KenI/TOI1CZvDziBk0x2wuh3JfeAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arecs.eu; dmarc=pass action=none header.from=arecs.eu;
 dkim=pass header.d=arecs.eu; arc=none
Received: from FRYP281MB0614.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:47::10)
 by FR2P281MB0388.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:3b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5; Mon, 9 Aug
 2021 20:25:16 +0000
Received: from FRYP281MB0614.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7dd0:6928:5a70:923a]) by FRYP281MB0614.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7dd0:6928:5a70:923a%6]) with mapi id 15.20.4415.013; Mon, 9 Aug 2021
 20:25:16 +0000
From:   Hussein Alasadi <alasadi@arecs.eu>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: [PATCH] m_can: fixed typo in m_can_set_bittiming() causing
 corrupt DBTP register content
Thread-Topic: [PATCH] m_can: fixed typo in m_can_set_bittiming() causing
 corrupt DBTP register content
Thread-Index: AdeNQ/Q4bqZPOm0YR2qWN96aJuPPYAABe62AAASFYOA=
Date:   Mon, 9 Aug 2021 20:25:16 +0000
Message-ID: <FRYP281MB06149A25C5C0F55E9AC1B635D1F69@FRYP281MB0614.DEUP281.PROD.OUTLOOK.COM>
References: <FRYP281MB06140984ABD9994C0AAF7433D1F69@FRYP281MB0614.DEUP281.PROD.OUTLOOK.COM>
 <20210809181051.5a7vckphc5mizv2f@pengutronix.de>
In-Reply-To: <20210809181051.5a7vckphc5mizv2f@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=arecs.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29b00453-246c-4f07-17e2-08d95b73ccdf
x-ms-traffictypediagnostic: FR2P281MB0388:
x-microsoft-antispam-prvs: <FR2P281MB0388F94EEB259F9076B66D31D1F69@FR2P281MB0388.DEUP281.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vSbWxP8YlhSCma2f7AYlw9hGHTTth14Sy3dxf92Xn0HVqo47Ben9beAUCZcWBY39rqsGjNPxWJPDaogOOiQTdtULBi3yjZiGW4jt66ffQWysBjj6D9qjt6OJs2Pin5mxcRDO1xKb60iiCe1g+m/LtSlvwgsQ0UZLrhf6q5ca9tAO21881dAEGGDmIpEr3KD9A6ka1zdn8wxKyAfWKlRFv+D7xbZxyTDEYwWbpk6r7h5KwxA/W3u0n5A9EOBW3nEqOnTsu9W6+ctMNItB8RupcGVDRpaVhbf3vkBYQMi1gFOUii8c1ziNkvkv8LbhRvCxdO8NOwECKocfkle4X3hiRwRvJ0mNZg3gt56b2BSFsgBfupZZ8wrmRt2Eq3BjpIzUvNn0EicqB/XoZhRXyajtoICgeWxrSaiu75Oem9OKdgIBurAtXLayquxA5hKD6UcV738gUiaDvDI0xnjRtp+rAVDlq701cs7pCB3Qj6hLy5roctLQIw0a+mQSVIlHOsosYtLrmRtb15PzH/nU4ge623zGFHiFCJMqEKo8N9O+6WdypQJbNLiV3b6i85lT9/qlJVbzM3RA5WcjVgRNkmTRgRLZHiQiTwN4vpWrZRvoheUArQq9lfyvnVZktCGxPvNKcT3AaU9BB4AlExi1bvHWoDkw+3z3oQ4JCe+V5E0fBqoZNpGnO9uXDExFOCtRkOOSGFbm4tpuDHwLPFOAWZaLMI9r9gv1wpao+/Yb+KjNyjj2uUlMkb3TBcOx3IVgyizFh62812NOBk6Oko82vn0jPK6jxZ1OyTe5vZVq7pp+dLYlP5g7YEqY+hNF0JjI2F7u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB0614.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(39830400003)(396003)(136003)(366004)(376002)(33656002)(4326008)(86362001)(6916009)(9686003)(53546011)(76116006)(6506007)(8936002)(66556008)(55016002)(66446008)(5660300002)(64756008)(8676002)(7696005)(66946007)(66476007)(71200400001)(52536014)(83380400001)(316002)(2906002)(966005)(26005)(508600001)(186003)(38070700005)(122000001)(38100700002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SW1DNStyTFhHODRzNVBHMUZBMjNick0vMXlxZWUwdkFmalJjcUUvT0wrRWto?=
 =?utf-8?B?bTFVbzVUZGUvak1ZdE5wZ3BKREMvdTZMb1ptdzdxWVhuMGRoQVludHA1cmFz?=
 =?utf-8?B?WWpLSEQ5cUxmK0lNQlM3MDkvaWovUHprYnlrYStuYlBybGFrdTZUSmNLMEFj?=
 =?utf-8?B?bzFqOHRWMDBUYjFOcG1NeEhacTdGcWhxeENjdUxZR1Q3T0pTWDMyRHI4ZTNu?=
 =?utf-8?B?aG53Y3huNVQwU2RwT1RuMFNTc0NYMTB2UFFMNG9oYU5BaHhLTzB3Ym5YY04z?=
 =?utf-8?B?RTlScjVCbWJrLzk1YVRvZ2RqNWxrUzRNSy84bDZZeFJOaWZKL3E3Smd6ZGNq?=
 =?utf-8?B?VHNuTUk4T1pzNzFyeEhteHZzbHdwemZrK2FqbFMrQkE2eDVvVmF2RllHUFVv?=
 =?utf-8?B?Tkw3REdVcHpzdHVwd0pFTWZFTm1WcG4rc0VKcG1iUGV6QUVGYXdEaWxLZTI2?=
 =?utf-8?B?dXhDMUZhVVBhU3hMVkFMN2lPSzlYdFpkM0p2ZnE4YkRuYWN1S0NmY2JoNGVL?=
 =?utf-8?B?c0hNMmtSdDRkcEptMzNTUEdwemtJTVBGakdTT05LVzRnZCtwWEFjdk9JRURh?=
 =?utf-8?B?RUpXN3NHYWw4ZWl2WUQycm1XdWhyb21DQUdtTC9EdnF3T3VYN0ZuZ1RWbVRy?=
 =?utf-8?B?dmlHSTVLU1pvUkY5YWdzaUd4UkRpN3dzdS8zTDEvV3RrWGsrSlowTFlJTjdI?=
 =?utf-8?B?eU10bDV6M2ZjdWZBMkxOSlhldWYyMzdTZG1EWkNoS3FDaFlRaExvZ3NuZ2t1?=
 =?utf-8?B?Rkt6aFNoZE5FdXVJazVFRWFGSlRPcFd5bkszdGcxd0pDaE1udU40UzRRNlRM?=
 =?utf-8?B?eVBuenFtZFR1Y3Uzc1R5Ym1pUWVhTWRYWlp4ai92aWxjcVJwMlZWVlR3U3Zv?=
 =?utf-8?B?YVRLUjZWaW1kakgyMHk5K3FROXpOTytTTytmbDkvcFpxK1NTYlozY3laYXFN?=
 =?utf-8?B?by9wOS8wRnZlNG5PaGxtTlhqSVQ3aG1zV1NYK3JpeDg1N1BHeFUycHlqZGt3?=
 =?utf-8?B?eTdpekhRSENKeUJtYVNndXR3aG1tQXRXVUF0V3ZMdHEzRlhOREVBK0MrOFVD?=
 =?utf-8?B?YWhHS0xBb3hqcC9lQ2dwN09TQWdrVHhxd3NrNG1rS1NzNjBweEVqVDJGYmJz?=
 =?utf-8?B?SkVjS21naENUMXcwVXplem5rM0ttZjJmZVE5WWZCemErQ0U4cGhING1TUXVE?=
 =?utf-8?B?V0VNa1M4YzAwQUhRV0R4YUliRjFOQUhzbm9qWklmRUp2WGtrR3JyaWlieWsv?=
 =?utf-8?B?RjBrZllzekxsVnJva2wyU3hMMENmb0RJNExwRGI5NlFKWXNmWjVVOExteEVy?=
 =?utf-8?B?bmVOS0l3UmFvNVJsQU8zT2tvbGdESDZsakd4M1JwQnRyNTUxcmtNOTVnQWoz?=
 =?utf-8?B?cEFqZmZMK0FYVjJBSXRZVHdaR2tvTFgyR2srMkphcmowSWZYU0lHTmVjaTJv?=
 =?utf-8?B?MlFSRjlVcTBvOGh0c1VsWEdHdGRvcUNVVnE4Nlo0TThNNkZrSEQwdGo1bC81?=
 =?utf-8?B?YlE1dlRWNjR4akgxdHU0Si94Tm13cHNJd2paUjhFaE5pU2JKQjd6SkhaQ09u?=
 =?utf-8?B?eDRLcjFrSFB0UUdLKzRwN2xWZmhpdmhoYnhheGNUR1NUaSsvc1JUL0tMQUk4?=
 =?utf-8?B?U29NbElERkludVZleWtPRjEzcitIdWlaMUFSSi9sTjZSc1h3a29XTGQ3MS9t?=
 =?utf-8?B?NGtxRVprZE44RU1TYkZ0RC9tUkZCcTdEMUtHU1QyM1IxaWZwQURCSGcwUHhq?=
 =?utf-8?Q?1qmybiyyevwbuYib400YpSWknNoFgbw2LNbnpbZ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arecs.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB0614.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b00453-246c-4f07-17e2-08d95b73ccdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 20:25:16.5040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40e33a7-902f-4fef-acb0-37bc625d7548
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: att3d2IivwFuwLcCFY3XA0+8y58PB4kLanarX3R7wevAhu4HBIPdpWD0KL/qQycHSy6mVTKnHR3lHOKrDNG9bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0388
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGVsbG8gTWFyYywNCg0KSSBob3BlIGl0J3MgaW4gdGhlIGNvcnJlY3QgZm9ybWF0IG5vdy4NCg0K
Rml4ZWQgTV9DQU5fREJUUCBjb3JydXB0IHJlZ2lzdGVyIGNvbnRlbnRzOg0KKiBOQlRQX3h4eCBk
ZWZpbmVzIHdlcmUgYmVpbmcgdXNlZCBpbnN0ZWFkIG9mIERCVFBfeHh4Lg0KKiByZWdfYnRwIHdh
cyBub3QgZ2V0dGluZyBPUmVkIHdpdGggdGhlIHBvc3NpYmx5LWV4aXN0aW5nIERCVFBfVERDIGZs
YWcuDQoNClNpZ25lZC1vZmYtYnk6IEh1c3NlaW4gQWxhc2FkaSA8YWxhc2FkaUBhcmVjcy5ldT4N
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9tX2Nhbi9tX2Nhbi5jIGIvZHJpdmVycy9u
ZXQvY2FuL21fY2FuL21fY2FuLmMgaW5kZXggMGNmZmFhZDkwNWMyLi5mMzgwOWY0Y2ZjN2IgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL25ldC9jYW4vbV9jYW4vbV9jYW4uYw0KKysrIGIvZHJpdmVycy9u
ZXQvY2FuL21fY2FuL21fY2FuLmMNCkBAIC0xMTY4LDEwICsxMTY4LDEwIEBAIHN0YXRpYyBpbnQg
bV9jYW5fc2V0X2JpdHRpbWluZyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgRklFTERfUFJFUChURENSX1REQ09fTUFTSywgdGRjbykp
Ow0KICAgICAgICAgICAgICAgIH0NCg0KLSAgICAgICAgICAgICAgIHJlZ19idHAgPSBGSUVMRF9Q
UkVQKE5CVFBfTkJSUF9NQVNLLCBicnApIHwNCi0gICAgICAgICAgICAgICAgICAgICAgICAgRklF
TERfUFJFUChOQlRQX05TSldfTUFTSywgc2p3KSB8DQotICAgICAgICAgICAgICAgICAgICAgICAg
IEZJRUxEX1BSRVAoTkJUUF9OVFNFRzFfTUFTSywgdHNlZzEpIHwNCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgRklFTERfUFJFUChOQlRQX05UU0VHMl9NQVNLLCB0c2VnMik7DQorICAgICAgICAg
ICAgICAgcmVnX2J0cCB8PSBGSUVMRF9QUkVQKERCVFBfREJSUF9NQVNLLCBicnApIHwNCisgICAg
ICAgICAgICAgICAgICAgICAgICAgRklFTERfUFJFUChEQlRQX0RTSldfTUFTSywgc2p3KSB8DQor
ICAgICAgICAgICAgICAgICAgICAgICAgIEZJRUxEX1BSRVAoREJUUF9EVFNFRzFfTUFTSywgdHNl
ZzEpIHwNCisgICAgICAgICAgICAgICAgICAgICAgICAgRklFTERfUFJFUChEQlRQX0RUU0VHMl9N
QVNLLCB0c2VnMik7DQoNCiAgICAgICAgICAgICAgICBtX2Nhbl93cml0ZShjZGV2LCBNX0NBTl9E
QlRQLCByZWdfYnRwKTsNCiAgICAgICAgfQ0KDQoNCk1pdCBmcmV1bmRsaWNoZW4gR3LDvMOfZW4s
DQoNCkguIEFsYXNhZGkNClByb2pla3RsZWl0ZXIgRW50d2lja2x1bmcNCkFSRUNTIEdtYkgNCkxp
bmRiZXJnaHN0ci4gNQ0KODIxNzggUHVjaGhlaW0sIEdlcm1hbnkNCsKgDQpBUkVDUyBBZHZhbmNl
ZCBSZXNlYXJjaCwgRW5naW5lZXJpbmcgJiBDb25zdWx0aW5nIFNlcnZpY2VzIEdtYkgNCkFtdHNn
ZXJpY2h0IE3DvG5jaGVuIEhSQiAxNzQwNzUsIFNpdHogZGVyIEdlc2VsbHNjaGFmdDogUHVjaGhl
aW0gYmVpIE3DvG5jaGVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNYXJj
IEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPiANClNlbnQ6IE1vbmRheSwgOSBBdWd1
c3QgMjAyMSA4OjExIFBNDQpUbzogSHVzc2VpbiBBbGFzYWRpIDxhbGFzYWRpQGFyZWNzLmV1Pg0K
Q2M6IGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1fY2Fu
OiBmaXhlZCB0eXBvIGluIG1fY2FuX3NldF9iaXR0aW1pbmcoKSBjYXVzaW5nIGNvcnJ1cHQgREJU
UCByZWdpc3RlciBjb250ZW50DQoNCkhleSBIdXNzZWluIEFsYXNhZGksDQoNCk9uIDA5LjA4LjIw
MjEgMTc6MzY6NTIsIEh1c3NlaW4gQWxhc2FkaSB3cm90ZToNCj4gRml4ZWQgTV9DQU5fREJUUCBj
b3JydXB0IHJlZ2lzdGVyIGNvbnRlbnRzOg0KPiAqIE5CVFBfeHh4IGRlZmluZXMgd2VyZSBiZWlu
ZyB1c2VkIGluc3RlYWQgb2YgREJUUF94eHguDQo+ICogcmVnX2J0cCB3YXMgbm90IGdldHRpbmcg
T1JlZCB3aXRoIHRoZSBwb3NzaWJseS1leGlzdGluZyBEQlRQX1REQyBmbGFnLg0KDQpUaGFua3Mg
Zm9yIHlvdXIgcGF0Y2ghDQoNCkNhbiB5b3UgcGxlYXNlIHJlLXNlbmQgdGhlIHBhdGNoIHdpdGgg
eW91ciAiU2lnbmVkLW9mZi1ieToiLiBGb3IgZGV0YWlscw0Kc2VlOg0KDQpodHRwczovL2VsaXhp
ci5ib290bGluLmNvbS9saW51eC92NS4xMi9zb3VyY2UvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1
Ym1pdHRpbmctcGF0Y2hlcy5yc3QjTDM1Ng0KDQpyZWdhcmRzLA0KTWFyYw0KDQotLSANClBlbmd1
dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUgICAgICAgICAg
IHwNCkVtYmVkZGVkIExpbnV4ICAgICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0
cm9uaXguZGUgIHwNClZlcnRyZXR1bmcgV2VzdC9Eb3J0bXVuZCAgICAgICAgIHwgUGhvbmU6ICs0
OS0yMzEtMjgyNi05MjQgICAgIHwNCkFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2IHwg
RmF4OiAgICs0OS01MTIxLTIwNjkxNy01NTU1IHwNCg==
