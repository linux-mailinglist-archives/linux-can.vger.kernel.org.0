Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16E32B8F3E
	for <lists+linux-can@lfdr.de>; Thu, 19 Nov 2020 10:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgKSJqG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Nov 2020 04:46:06 -0500
Received: from mail-am6eur05on2050.outbound.protection.outlook.com ([40.107.22.50]:58080
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbgKSJqG (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 19 Nov 2020 04:46:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVkT8sCiP45wZzj/fPfEKZQtwWumeEvHlSuOQ5evu2BRFAwNi99Sm6rf5ZEdnpU9ORY6TOek2NuzVWU4DakBcbsapzfxF5qzyu6KEco6/p1Z1rK4T5DG+3EAQQDB+JBLzCOOppMwJTNk0eVVE2KmViS8qjO7ZP3Ai2tp5X1wUEl7w+2B8yzO/HDvYK33OuD+LopeDE5/GcDnAwnQONuh52EUnSsdPJdzzWLDWw2Og0RaQPKEyjD/UQCZ7HcQjdCYZmXC81x1vc+yRCiS9JVBfNODNS4UtGPTWnF5DBIRvHM6yKn/Xym8J4kwKUbjWP9pgkkEy1BwHEEdWQ9HXRvn1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGrmspxTaRqfPszbXAeEcUTlOXU9ekY7SQX7jbJvQaY=;
 b=FtqSVbiKBWYbjFros6UzFWDzMOJ+cJhnW3SCl8o/03guId28j0Q0kTVr7xlPbv42RQzD6+0izlepUX68HLmeSfUW9WPvP0BnjKxT0OTneeye3PeQZDhXSgxbvGRrFFvhXD49LKieQcxYYOad3IQKE5ZqT4mPZoFBh3cbrRotDJ1uzFHQYeXik5cIYvmwKj1r/t9Nf5aD1XgCpld2CTBRrJ5UvhI8v90OGRAOGN3cANSULAQI3AIyzzvuHt0VzGhc499IUiFASA+iptHHNvkwAsEmUodBoGqC4Hl6dshgbrvxxzed/luGTqJr9qIvgr9Q85LsbHpEMMMXviyTtmjkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGrmspxTaRqfPszbXAeEcUTlOXU9ekY7SQX7jbJvQaY=;
 b=Yy5yExu96Ec9IHvcfVYUSc5IF8R7aKV39gip+6Xl/lZew5nSP66H8Xzp1pHeNVM8IlSocn+W1xukYTzc6Qd8AYrxlyz6mF2cfOAZsRoDGXKOsvnSCbK7xcKw3evVar1ZazWTe9818sQOORR8x9KRUxOTM26VuslZaUp2FGBsc54=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB5308.eurprd04.prod.outlook.com (2603:10a6:10:1d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 09:46:01 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc%9]) with mapi id 15.20.3541.028; Thu, 19 Nov 2020
 09:46:01 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH 5/5] can: flexcan: flexcan_close(): change order if
 commands to properly shut down the controller
Thread-Topic: [PATCH 5/5] can: flexcan: flexcan_close(): change order if
 commands to properly shut down the controller
Thread-Index: AQHWvlFiBeKSWZY/B02/BKBoydufJanPNCmA
Date:   Thu, 19 Nov 2020 09:46:01 +0000
Message-ID: <DB8PR04MB6795CBAA8B6729A478E2BE9CE6E00@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20201119085251.2949181-1-mkl@pengutronix.de>
 <20201119085251.2949181-6-mkl@pengutronix.de>
In-Reply-To: <20201119085251.2949181-6-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05f863f5-0148-4e68-0956-08d88c6fece1
x-ms-traffictypediagnostic: DB7PR04MB5308:
x-microsoft-antispam-prvs: <DB7PR04MB5308E04B8AB9B0913DD7698AE6E00@DB7PR04MB5308.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HPuu+ghJqzSoIBSC1mRaZ1pV2nAEyD6z1bqy9tHfAfTnkmYAU3n7UFg2rcoKGsJHa79Ysgln6oOCKGMocCfMVHAULbQa1mwQvs/gWcX6ReH/8t4f/9mrPKETq4/5MVahoe7rDH8RRhrmV+c9LwFjcmD49a91hU7D+KV6wpp3VZNoUxLcgSCwYrwAxWVked4nbsZlkoEixPIWHjPouNA8PZrxf59e0/MgADpkcg/ZtObgBjg819CElb1DpFtUaajD4qls1eyYisZrKYtUSj7y8wtgBlcV5RrfIroDljbMhUzZuTd7lxFSBil6RRFVdkAQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(66446008)(86362001)(7696005)(110136005)(52536014)(5660300002)(76116006)(83380400001)(55016002)(186003)(26005)(33656002)(53546011)(6506007)(66556008)(9686003)(2906002)(478600001)(64756008)(316002)(66476007)(66946007)(8936002)(8676002)(71200400001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wWrtyLz5d58kFJSXUaeuEmRUl7/W62EZTf4iN/ueyecOhZLXapdEQfqgUmsXiJgX+uMBSltp+lDCSMDWfEZwzob5MRy8a01yFaSEyzGged5I7N6Q511I50wWlbqV+pCJgJ25iYcF6Jjdbwdye1ag2QcKJoDTWVrsqKDoUinRy+9c/kqP1rxE1bSuhQYIv8fAJp8jt5ylE/i8C8seDrwJ+Q3vKnlxMiLadKLXgKP/iF6agDH5MexJEm8L5N7G1kQ6REH2IidYQLqIpWfKhS7YdTzdWSCX+QGP5/wJCbrsoZLxSPnEZHCLWuBTB/xn3+hfa2whmh3+6ezC6gnhikM5r7JtD3OWLSJX3tT6j+0daQtPI1lUNnhsYNyIDAKmSR3/wlOxUxXUDQkProk4nWwpEww3MiLZotpZBqyw389jFDH5hboBYnJ55UYFaz1uDCdk5ZtZMcyBX36vTB7FFHtHw1YMgIN6KBEXzU29wxu+ZuwJXiDsrcTPtPTO4oEq3WDscwBNW4a51uSKLlHYr5dhHPmP7d9l8Phh3lYyx4Rc0MruQY9Hp11swOY+0DboG3NKMHGZwoWTiXFeg2/CAbyNJuIJa6+3Fwwn08BUmmQREpKkCT7era3JiYmXyXOqxsSFEI/NPyzU4w7NzLSqZhJabf2vssyQCDtxjpJuQlJzRAjoE3ngI/QYiaG45MJdjPcmYhdcWEXPvbSWh6O4qOXMOj2ULoiip/K/fZyOKF7z/zCnAU9Iuo+e3DqVAZbRB3IJ9rek/Kx1RGopMpMVX9vr3mdszWJM6Bb6bsmEXLKvgnZbSDaVc4qVI16A5KNVOxN1d+VA5nhZFlZSOJ/4Q7Rr6BQaM0mhN9RkuDxwmC/q2cApI19qS4RLKpwU/1zk9Ut0KTX3E7++tUIzoI70MzXbzg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f863f5-0148-4e68-0956-08d88c6fece1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 09:46:01.5578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LC4+kffUZcMeVOG2GIF/Kv2y18onSs048gfIVz5dFEgfaS5pOjAOCih2kPV1Amglvynb+lzX4TPJEpMHRs4Grg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5308
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjDE6jEx1MIxOcjVIDE2OjUzDQo+IFRv
OiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnDQo+IENjOiBKb2FraW0gWmhhbmcgPHFpYW5ncWlu
Zy56aGFuZ0BueHAuY29tPjsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBNYXJjDQo+IEtsZWluZS1C
dWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTdWJqZWN0OiBbUEFUQ0ggNS81XSBjYW46IGZs
ZXhjYW46IGZsZXhjYW5fY2xvc2UoKTogY2hhbmdlIG9yZGVyIGlmIGNvbW1hbmRzDQo+IHRvIHBy
b3Blcmx5IHNodXQgZG93biB0aGUgY29udHJvbGxlcg0KPiANCj4gVGhlcmUgaGF2ZW4gYmVlbiBy
ZXBvcnRzLCB0aGF0IHRoZSBmbGV4Y2FuX2Nsb3NlKCkgc29yYWRpY2FsbHkgaGFuZ3MgZHVyaW5n
DQo+IHNpbXVsdGFuaW91cyBpZmRvd24sIHNlbmRpbmcgb2YgQ0FOIG1lc3NhZ2VzIGFuZCBwcm9i
YWJseSBvcGVuIENBTiBidXM6DQo+IA0KPiB8IChfX3NjaGVkdWxlKSBmcm9tIFs8ODA4YmJkMzQ+
XSAoc2NoZWR1bGUrMHg5MC8weGI4KQ0KPiB8IChzY2hlZHVsZSkgZnJvbSBbPDgwOGJmMjc0Pl0g
KHNjaGVkdWxlX3RpbWVvdXQrMHgxZjgvMHgyNGMpDQo+IHwgKHNjaGVkdWxlX3RpbWVvdXQpIGZy
b20gWzw4MDE2YmU0ND5dIChtc2xlZXArMHgxOC8weDFjKQ0KPiB8IChtc2xlZXApIGZyb20gWzw4
MDc0NmE2ND5dIChuYXBpX2Rpc2FibGUrMHg2MC8weDcwKQ0KPiB8IChuYXBpX2Rpc2FibGUpIGZy
b20gWzw4MDUyZmRkMD5dIChmbGV4Y2FuX2Nsb3NlKzB4MmMvMHgxNDApDQo+IHwgKGZsZXhjYW5f
Y2xvc2UpIGZyb20gWzw4MDc0NDkzMD5dIChfX2Rldl9jbG9zZV9tYW55KzB4YjgvMHhkOCkNCj4g
fCAoX19kZXZfY2xvc2VfbWFueSkgZnJvbSBbPDgwNzRkYjljPl0gKF9fZGV2X2NoYW5nZV9mbGFn
cysweGQwLzB4MWEwKQ0KPiB8IChfX2Rldl9jaGFuZ2VfZmxhZ3MpIGZyb20gWzw4MDc0ZGM4ND5d
IChkZXZfY2hhbmdlX2ZsYWdzKzB4MTgvMHg0OCkNCj4gfCAoZGV2X2NoYW5nZV9mbGFncykgZnJv
bSBbPDgwNzYwYzI0Pl0gKGRvX3NldGxpbmsrMHg0NGMvMHg3YjQpDQo+IHwgKGRvX3NldGxpbmsp
IGZyb20gWzw4MDc2MTU2MD5dIChydG5sX25ld2xpbmsrMHgzNzQvMHg2OGMpDQo+IA0KPiBJIHdh
cyB1bmFibGUgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZSwgYnV0IGEgY2xlYW51cCBvZiB0aGUgZmxl
eGNhbiBjbG9zZQ0KPiBzZXF1ZW5jZSBoYXMgcHJvYmFibHkgZml4ZWQgdGhlIHByb2JsZW0gYXQg
dGhlIHJlcG9ydGluZyB1c2VyLg0KPiANCj4gVGhpcyBwYXRjaCBjaGFuZ2VzIHRoZSBzZXF1ZW5j
ZSBpbiBmbGV4Y2FuX2Nsb3NlKCkgdG86DQo+IC0gc3RvcCB0aGUgVFggcXVldWUNCj4gLSBkaXNh
YmxlIHRoZSBpbnRlcnJ1cHRzIG9uIHRoZSBjaGlwIGxldmVsIGFuZCB3YWl0IHZpYSBmcmVlX2ly
cSgpDQo+ICAgc3luY2hyb25vdXNseSBmb3IgdGhlIGludGVycnVwdCBoYW5kbGVyIHRvIGZpbmlz
aA0KPiAtIGRpc2FibGUgUlggb2ZmbG9hZCwgd2hpY2ggZGlzYWJsZXMgc3luY2hyb25vdXNseSBO
QVBJDQo+IC0gZGlzYWJsZSB0aGUgZmxleGNhbiBvbiB0aGUgY2hpcCBsZXZlbA0KPiAtIGZyZWUg
Ulggb2ZmbG9hZA0KPiAtIGRpc2FibGUgdGhlIHRyYW5zY2VpdmVyDQo+IC0gY2xvc2UgdGhlIENB
TiBkZXZpY2UNCj4gLSBkaXNhYmxlIHRoZSBjbG9ja3MNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1h
cmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IC0tLQ0KPiAgZHJpdmVycy9u
ZXQvY2FuL2ZsZXhjYW4uYyB8IDUgKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvY2Fu
L2ZsZXhjYW4uYyBiL2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMgaW5kZXgNCj4gMGZiNzY4ZGVl
OTlmLi4wMDJlOTNmMmIyNDkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2Fu
LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvY2FuL2ZsZXhjYW4uYw0KPiBAQCAtMTc4OSwxNSArMTc4
OSwxNiBAQCBzdGF0aWMgaW50IGZsZXhjYW5fY2xvc2Uoc3RydWN0IG5ldF9kZXZpY2UgKmRldikN
Cj4gIAlzdHJ1Y3QgZmxleGNhbl9wcml2ICpwcml2ID0gbmV0ZGV2X3ByaXYoZGV2KTsNCj4gDQo+
ICAJbmV0aWZfc3RvcF9xdWV1ZShkZXYpOw0KPiArCWZsZXhjYW5fY2hpcF9pbnRlcnJ1cHRzX2Rp
c2FibGUoZGV2KTsNCj4gKwlmcmVlX2lycShkZXYtPmlycSwgZGV2KTsNCj4gIAljYW5fcnhfb2Zm
bG9hZF9kaXNhYmxlKCZwcml2LT5vZmZsb2FkKTsNCj4gIAlmbGV4Y2FuX2NoaXBfc3RvcF9kaXNh
YmxlX29uX2Vycm9yKGRldik7DQo+ICAJZmxleGNhbl9jaGlwX2ludGVycnVwdHNfZGlzYWJsZShk
ZXYpOw0KDQpIaSBNYXJjLA0KDQpJcyBpdCBhIHNwZWNpYWwgdHJlYXRtZW50PyBmbGV4Y2FuX2No
aXBfaW50ZXJydXB0c19kaXNhYmxlIGNhbGxlZCB0d2ljZT8NCg0KCWZsZXhjYW5fY2hpcF9pbnRl
cnJ1cHRzX2Rpc2FibGUoZGV2KTsNCglmcmVlX2lycShkZXYtPmlycSwgZGV2KTsNCiAgCWNhbl9y
eF9vZmZsb2FkX2Rpc2FibGUoJnByaXYtPm9mZmxvYWQpOw0KICAJZmxleGNhbl9jaGlwX3N0b3Bf
ZGlzYWJsZV9vbl9lcnJvcihkZXYpOw0KICAJZmxleGNhbl9jaGlwX2ludGVycnVwdHNfZGlzYWJs
ZShkZXYpOw0KDQoNCkJlc3QgUmVnYXJkcywNCkpvYWtpbSBaaGFuZw0KIA0KPiAgCWNhbl9yeF9v
ZmZsb2FkX2RlbCgmcHJpdi0+b2ZmbG9hZCk7DQo+IC0JZnJlZV9pcnEoZGV2LT5pcnEsIGRldik7
DQo+ICAJZmxleGNhbl90cmFuc2NlaXZlcl9kaXNhYmxlKHByaXYpOw0KPiAtDQo+ICAJY2xvc2Vf
Y2FuZGV2KGRldik7DQo+ICsNCj4gIAlwbV9ydW50aW1lX3B1dChwcml2LT5kZXYpOw0KPiANCj4g
IAljYW5fbGVkX2V2ZW50KGRldiwgQ0FOX0xFRF9FVkVOVF9TVE9QKTsNCj4gLS0NCj4gMi4yOS4y
DQoNCg==
