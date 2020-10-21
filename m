Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3572948A2
	for <lists+linux-can@lfdr.de>; Wed, 21 Oct 2020 09:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437106AbgJUHLn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Oct 2020 03:11:43 -0400
Received: from mail-db8eur05on2040.outbound.protection.outlook.com ([40.107.20.40]:2529
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436990AbgJUHLn (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 21 Oct 2020 03:11:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+ja4ogpnEbyUyk5X7+BWE+NnPytFtA8Q0Y5tUEZKOyO96a0xer86CRdRWZPXQiHCf3zSmy015DkY5W0PKvHOsKsQAIZvE18Kq258MKSe29V1dsIlMZ0T0uV/Uck0LZ8cTYfy58pU5b8DFAIDPH/5y63+JrxmnPeyqcdZ8NDgqNyX6HAjQZ9nw2I8JLf8YRzbcG0xc9Q9TVqvZ0Lr1RYo4Q6c8IuhXI64uGS/vN1XZwwuHqbbIr8iqtIFds3YMekpzGQ9hRNAKfnDDL5eauGcLaulofkM+jF5DmJiXg2lLRflvxjfAo4U7yWKLSgbXm0fDHBOGbsM3b+Hqgpg713RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZwggIor27PZ/Q66kJAIll5Yk7ZqKJoremfWzAO2jBg=;
 b=Cp1tlIn0n0S3lFhnwF36Ke+/xcmSNn5vsKGxoE3kkndIh/HGYcdHkO39is/90y7lK55NMe6+64OLhhLGgz0+FlbKDYq/5Nk/tRLdoQal0YYNvbyRUwyHMBdU2sjZ030vdWhW/1ccJmdrBJS9Ac4nDoPuq/wDai+vnDMHBuvxqt9OXpGDReRnnjRJc87MeRZreJmNPJZ5dyVCTe0AHSU/OS/aqd8ZgKibnImanPSDzEhHTqz+5pAscRbqym38jNg9B1PciilJSZhRE02hO+UmIFBnUk2QXTxklIgfJlFSRrTeCw8eX77XsBvn74XWeXrb0k4Sv9TIvte3IOWNnH8KkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZwggIor27PZ/Q66kJAIll5Yk7ZqKJoremfWzAO2jBg=;
 b=NjyyZsomCkNVkFL9AERMYjI7Iivj62/spGY/L85XIMsukhw3pJfP2MrECoRGHp8IzNEe530qkNgm9QLm13YRqXXS6+DFKu0Nx+1ktbkjC7RoZx+eNd9PSlJHU+N2RE4wWUUAOo3gn1iyrYgY36m5cWbqxI4jLVPy4JyQVVPTrJM=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB3PR0402MB3769.eurprd04.prod.outlook.com (2603:10a6:8:f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 07:11:38 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc%9]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 07:11:38 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        =?utf-8?B?U3TDqXBoYW5lIEdyb3NqZWFu?= <s.grosjean@peak-system.com>
Subject: RE: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to
 get the correct length of Classical frames
Thread-Topic: [net-rfc 04/16] can: dev: can_get_len(): add a helper function
 to get the correct length of Classical frames
Thread-Index: AQHWpld3JYwxX9rMjEG1n6sDbfgT6KmgCb4AgABSX4CAABLvgIAAOoiAgAAPxACAAILcAIAAXIsAgAAMbKA=
Date:   Wed, 21 Oct 2020 07:11:38 +0000
Message-ID: <DB8PR04MB6795FF1C5CF1D638ABA3FC08E61C0@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20201019190524.1285319-1-mkl@pengutronix.de>
 <20201019190524.1285319-5-mkl@pengutronix.de>
 <fbbe1b80-c012-dc87-1eb0-4878cd08cce1@hartkopp.net>
 <ebf50f35-f093-b2c9-a27c-cef73d403efb@pengutronix.de>
 <20201020113023.102360-1-mailhol.vincent@wanadoo.fr>
 <6f869e47-9a76-3398-0b64-2d573d412f4c@hartkopp.net>
 <20201020160739.104686-1-mailhol.vincent@wanadoo.fr>
 <a9605011-2674-dc73-111c-8ebf724a13ac@hartkopp.net>
 <20201021005226.2727-1-mailhol.vincent@wanadoo.fr>
 <CAMZ6RqKFST4dcWZP_8NdDMB6GT09vhVWgN+nuMWkVovkh-EZdw@mail.gmail.com>
In-Reply-To: <CAMZ6RqKFST4dcWZP_8NdDMB6GT09vhVWgN+nuMWkVovkh-EZdw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7bd462b4-6bfe-400b-fa0e-08d875908d96
x-ms-traffictypediagnostic: DB3PR0402MB3769:
x-microsoft-antispam-prvs: <DB3PR0402MB37698F0041E39323644BB54DE61C0@DB3PR0402MB3769.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JMis8p6x2R9OraWDTBLXp0q5bcwp190OigxHK+mEqhkwanmmfzBrSQttq6R1+iMpT3QQDZtiANdydMgpA9ALT8rz3evDjVTdZHNn6nsQZOdUXs19X3e+bqlKFMmqlxW7pExgW8m/sQANuOs273xOT0g/ug09DeveFP7L36ynQpWVnDfYBmjqGy3oKMAhbag5B+AgZuYYT6L+PhU88qaQsq4wBiHfpwo5MHLEBLmNPtARHv3Bz7u823ux/KBMefgqWLwpFQWJs5Qms2XIJzr0V3DRz8OTgbtHzQ8AX7M5ixfYIYwfuZqU5WH7kt3Bk3rVKYJAJ4i7HpcYGxq6H0BF4XisT0G2F7kkCEaR9WNKjBtY+MMOpSmaQcIYpYqj+2cr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(53546011)(110136005)(186003)(6506007)(55016002)(26005)(478600001)(86362001)(54906003)(316002)(7696005)(33656002)(4326008)(66446008)(2906002)(76116006)(9686003)(8936002)(8676002)(52536014)(64756008)(66946007)(5660300002)(66556008)(66476007)(71200400001)(83380400001)(15583001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xg7PdXkW8a4dNbYz8RYn3g15OT7f7PD7BwQHVHxrM18XaBDlyGCQolaasI1iCoez0KZPzsUl+M5BbB4/LqJCqu7A+VBnKYtMVS1Rs2VUJExRYTo6T0xttMRHobatSzkC80p9T/2aOPKRsW2TisjVVFmNgVTlgT8Cy9oIvDoVMTu9gcsh9n3DHQat37mFpDgPmq0JW/UQpwUeuBs1JcxA9DaR1d91rlZgk6TNPRHLr7YuzclQBsvQhn4JKRI/lwt8Jhd2ChrM3pLQY+I2pufpJ+POJ0yHg3YCowlYO2j6nVLheJm357mfJxe992HR4y8iI4pUgfqgk8HgkL/PFIqb7fEBQVbJglSD46R802rXTgJggIO+k2dLNN/wrpF8tTY2CB/SusFnn/hBBMTf1Ylnox0JREpYpSShf3CyRcIo/YMyPpqOEa5C9ZnDcLisolcpwmNjkAXMCx/CHncWKXtPPs7qI6yZ2XhmFpcXaOIU+dJ+knxTx2U2oWhHxyyfYUouDV/wVijYJoe5DDsSzlI38ez1f1wg97hnU12ZZZwwllZSc0gPR2wahiajm4OhEIklsh4m9tbfbUq6isfwd1G5eQsN96uT586LzSYd07tYDiF4+jtuz/cQLkBYPgBxGcE6MXq1Gbbmo4kmO/sEDb+gHg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd462b4-6bfe-400b-fa0e-08d875908d96
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 07:11:38.2813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2vejGttonJhxnjwqZNGZz61wEKnGmTtKpQUWuDgEAAVJpy/sbCzb9JqIEqz8xuyGyq/9iBkswYKEEOgwSEUVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3769
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpbmNlbnQgTUFJTEhPTCA8
bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+DQo+IFNlbnQ6IDIwMjDlubQxMOaciDIx5pelIDE0
OjI0DQo+IFRvOiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPjsgT2xpdmVy
IEhhcnRrb3BwDQo+IDxzb2NrZXRjYW5AaGFydGtvcHAubmV0PjsgbGludXgtY2FuQHZnZXIua2Vy
bmVsLm9yZw0KPiBDYzoga2VybmVsQHBlbmd1dHJvbml4LmRlOyBWaW5jZW50IE1haWxob2wgPG1h
aWxob2wudmluY2VudEB3YW5hZG9vLmZyPjsNCj4gU3TDqXBoYW5lIEdyb3NqZWFuIDxzLmdyb3Nq
ZWFuQHBlYWstc3lzdGVtLmNvbT4NCj4gU3ViamVjdDogUmU6IFtuZXQtcmZjIDA0LzE2XSBjYW46
IGRldjogY2FuX2dldF9sZW4oKTogYWRkIGEgaGVscGVyIGZ1bmN0aW9uIHRvDQo+IGdldCB0aGUg
Y29ycmVjdCBsZW5ndGggb2YgQ2xhc3NpY2FsIGZyYW1lcw0KPiANCj4gPiA+IEZyb20gYSBmaXJz
dCB0aG91Z2h0IEkgd291bGQgc2VlIGEgbmV3IGZsYWcgQ0FOX0NUUkxNT0RFX1JBV19ETEMgaW4N
Cj4gPiA+IHRoZSBuZXRsaW5rIGludGVyZmFjZSBvZiBJRkxBX0NBTl9DVFJMTU9ERSBmb3IgdGhl
IENBTiBjb250cm9sbGVyIGRyaXZlci4NCj4gPiA+DQo+ID4gPiBUaGlzIGNvdWxkIHN3aXRjaCB0
aGUgc2FuaXRpemluZyBBTkQgdGhlIENBTiBjb250cm9sbGVyIGNhbiBwcm9wZXJseQ0KPiA+ID4g
ZXhwb3NlIGl0cyBhYmlsaXR5IHRvIHN1cHBvcnQgdGhpcyBtb2RlLg0KPiA+DQo+ID4gQWJzb2x1
dGVseSB5ZXMuIEluIG15IGZpcnN0IG1lc3NhZ2UsIEkgbWVudGlvbmVkIHRoZSBpZGVhIG9mIG1h
bmFnaW5nDQo+ID4gdGhhdCB0aHJvdWdoIHNvY2tldCBvcHRpb24sIGdsYWQgdGhhdCB3ZSBub3cg
c2hhcmUgdGhlIHNhbWUgaWRlYS4NCj4gDQo+IEFjdHVhbGx5LCBJIGp1c3QgcmVhbGl6ZWQgdGhh
dCBJIHJlcGxpZWQgdG8geW91IHRvbyBxdWlja2x5LiBJIHdhcyBub3QgZXhhY3RseQ0KPiB0aGlu
a2luZyBvZiB0aGUgc2FtZSB0aGluZyBoZXJlIHNvIGxldCBtZSBjb3JyZWN0IHdoYXQgSSBwcmV2
aW91c2x5IHNhaWQuDQo+IA0KPiBJRkxBX0NBTl9DVFJMTU9ERSBpcyBhdCB0aGUgbmV0bGluayBs
ZXZlbC4gTXkgaWRlYSBpcyB0byBoYXZlIGl0LCBpbiBhZGRpdGlvbiwNCj4gYXQgdGhlIHNvY2tl
dCBsZXZlbC4gRXhhbXBsZTogYWRkIENBTl9SQVdfUkFXX0RMQyBpbg0KPiBpbmNsdWRlL3VhcGkv
bGludXgvY2FuL3Jhdy5oLg0KPiANCj4gVGhlIHJlYXNvbiBpcyB0aGF0IGlmIHdlIG9ubHkgbWFu
YWdlIGl0IGF0IHRoZSBuZXRsaW5rIGxldmVsLCBzb21lIGFwcGxpY2F0aW9uDQo+IG5vdCBhd2Fy
ZSBvZiB0aGUgUkFXX0RMQyBpc3N1ZSBtaWdodCBydW4gaW50byBzb21lIGJ1ZmZlciBvdmVyZmxv
dyBpc3N1ZS4NCj4gVW5sZXNzIGFuIGFwcGxpY2F0aW9uIGRpcmVjdGx5IHJlcXVlc3RzIGl0LCB0
aGUgY3VycmVudCBiZWhhdmlvdXIgc2hvdWxkIGJlDQo+IG1haW50YWluZWQgKHJhdGlvbmFsZTog
ZG8gbm90IGJyZWFrIHVzZXJsYW5kKS4NCg0KSGkgVmluY2VudCBNYWlsaG9sLA0KDQpJIHdvbmRl
ciBpZiBpdCdzIGFwcHJvcHJpYXRlIHRvIGFzayB0aGlzIHF1ZXN0aW9uIGhlcmUsIHdoeSB0aGlz
IFJBV19ETEMgaXNzdWUgbWlnaHQgcnVuIGludG8gc29tZSBidWZmZXIgb3ZlcmZsb3cgaXNzdWU/
IFdpbGwgaXQgY2F1c2UgZnJhbWVzIGRyb3BwZWQgZmluYWxseT8NCg0KQmVzdCBSZWdhcmRzLA0K
Sm9ha2ltIFpoYW5nDQo+IFNvIHRoZSBmdWxsIHBpY3R1cmUgd2lsbCBiZSB0byBoYXZlIGJvdGgg
dGhlIENBTl9DVFJMTU9ERV9SQVdfRExDIGF0DQo+IG5ldGxpbmsgbGV2ZWwgYW5kIENBTl9SQVdf
UkFXX0RMQyBhdCB0aGUgc29ja2V0IGxldmVsIChpbiB0aGUgZXhhY3Qgc2FtZQ0KPiB3YXkgd2Ug
aGF2ZSBib3RoIENBTl9DVFJMTU9ERV9GRCBhbmQgQ0FOX1JBV19GRF9GUkFNRVMgZm9yDQo+IENB
Ti1GRCkuDQo+IA0KPiANCj4gWW91cnMgc2luY2VyZWx5LA0KPiBWaW5jZW50IE1haWxob2wNCg==
