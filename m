Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5777294916
	for <lists+linux-can@lfdr.de>; Wed, 21 Oct 2020 09:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502054AbgJUHs7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Oct 2020 03:48:59 -0400
Received: from mail-eopbgr30064.outbound.protection.outlook.com ([40.107.3.64]:1543
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407784AbgJUHs6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 21 Oct 2020 03:48:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXvjRY/QJf9O6B9m3srAe58hHl8cLBH1SFYa9Ok9Hers50uKGqxxyvjVKE1RT6FshkNrqCG/ZH52K+n3Kfq6n01jUHA6t7w+bUm4dwJ/QrHDfI5KWzxnSs2T0dyiM19l9fEAlaExSFa9GwJ2K0/DBJ/hZYYutmc3chLgvAwRf428FDSFsrwQcTkN6iiwIaWjI29TQq7eJ3KJQwnYQ9TDt1kietdfB5p1RGbEXXNq7HpJH7P1/3hBoxlWy5tO3rd5YEX3o6UXs/hVV2Pwv+9krP1SzTK1WmThdGMSX+MO1SZXFmCSD+VV2c9roGGpv8X0RIVt+qdUlkIpg6cIyBAioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koLMzYgFS90hnftn2kJgQQn/n6HPlU3g90uzE6whCeE=;
 b=nwY7ioJdSxMY20hDurc19sM0eP3DELj44wETz2dOiQ4WeW4v+pMpPq9MZrkKd0M67Ps1ncL160NrDFSAXFCHkpNe/zKTmt3HNFSjv9Gtnhuj001eBHEMopdED2Lad5GyPsEROVB2QDwcqSEopJzK1ZlRsWJzxLrndzMjp6EidnAK8ew08sUqbMD/2BwrMKts5qslt0YHlPn1jI4Tb7C8tCMRiwgoHa1bXoH6Dlu1zuv3lGuTuwLagDHGa/J/mdTZkYKzSUroDyIi2Njm7UKGI04AtFZW8mY5dGmLIbjLjhBRV6j2V/gcDbigBZesl+ChXOOtVlGFAFt7PMtT+gDvyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koLMzYgFS90hnftn2kJgQQn/n6HPlU3g90uzE6whCeE=;
 b=fTZ+WJWtL+MCVFkU8ev+YOQXmsUpV16QoqTShldCE04rhCIOFptVyyKScjwu03IidO+pT08OC0fOm4hU9Nrn/v2SM7WMVMiDmZGKTbQEOt5mKErx6tJse+m+W/M010E8Y+WCaKUvJPkWuumz/WOVQMTWeKLu5RNhCqHFIHx41K8=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBAPR04MB7333.eurprd04.prod.outlook.com (2603:10a6:10:1b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 21 Oct
 2020 07:48:55 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc%9]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 07:48:55 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        =?utf-8?B?U3TDqXBoYW5lIEdyb3NqZWFu?= <s.grosjean@peak-system.com>
Subject: RE: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to
 get the correct length of Classical frames
Thread-Topic: [net-rfc 04/16] can: dev: can_get_len(): add a helper function
 to get the correct length of Classical frames
Thread-Index: AQHWpld3JYwxX9rMjEG1n6sDbfgT6KmgCb4AgABSX4CAABLvgIAAOoiAgAAPxACAAILcAIAAXIsAgAAMbKCAAAO2AIAABvLQ
Date:   Wed, 21 Oct 2020 07:48:55 +0000
Message-ID: <DB8PR04MB67958C71CF633A3F0FB2B6D4E61C0@DB8PR04MB6795.eurprd04.prod.outlook.com>
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
 <DB8PR04MB6795FF1C5CF1D638ABA3FC08E61C0@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <7dde6b81-cd60-523f-8dbe-9cab3cc061b4@pengutronix.de>
In-Reply-To: <7dde6b81-cd60-523f-8dbe-9cab3cc061b4@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f067e04-5a73-4132-db6a-08d87595c2eb
x-ms-traffictypediagnostic: DBAPR04MB7333:
x-microsoft-antispam-prvs: <DBAPR04MB7333624D947D3B625BC0DCE2E61C0@DBAPR04MB7333.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y+MJyV0vuXIgtLxWhf/FiyT4NwQqTqfzo6SpWI+F1QtW6lJcg0fRF+vNUNWOPMYHIeZF+oNOEOBEaErFunZYQVHnnYPZ2USnp1khhqwCZ4vzD24hGFqLGVfR4eY08I3dv2zcIYBl52xYI7GlQAPd7uGG5eCHvwCBYhKf1JEUfNam8TswKhJ124P5XGwTW03/xaO2HPLfDVAU4WKH30gtYtd/6GopIpPnwTNzCdkIYxwfRnp1dWBn+1qvpEd+688xH750Fug1ynIQ4n5FQlKC2q3pQl5puzVroBkWanW6jj/7SOFrJvRjfN8JuWO8zOsIuZd0pkVy/gUbLVOd5yOloOnL5/s6LHJ3OAuNYCSX3ppBU1hSWNJPSwrexl+CvVvxvla3mLWdBDB+4iBt9zGAuSxldx2PeRjwFA5EtwYOSq3HHVH1p4lAUtY3Y9CWP/PGRdje4f3CatQ0llQBGaFQEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(316002)(33656002)(86362001)(2906002)(6506007)(8676002)(53546011)(4326008)(71200400001)(8936002)(54906003)(55016002)(5660300002)(186003)(478600001)(110136005)(52536014)(66476007)(7696005)(66946007)(9686003)(64756008)(83380400001)(966005)(26005)(76116006)(66556008)(66446008)(15583001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tY/fMPUX0EFhHka0EqUBrbN2cXhezx3/7hZiY0fjfTznDjOdFi8AG7ykqdhUX9+QQ6NuqbE9ymXFUE3S8H9sIzP9HPg2gxZNKSFHRtg7xwY05MeJWOh5jHTg6v4rSc9Iny8p+07x/pHjiHztPQcGr4ytj7WYb4t4erT7zX7Whn70VdW0MHTd+aCHRWetvPVGmpKDi2Y5knnFPOJszDs6lbkeyOcpROBbcIQytAbg4baE6bRJGBk6/yY9zmETBST/PLEOi4FVv6Rl7CX4jov+QZ0p9nrCBADYjP4VMIQPb3hrK31aPD7kAVWSSg86jNWOseOo0qrZ5tcuTx4A2lbE+2K7A1fjUdGvqc37oo95BR3toHII0eYKtIH/Gg6klm4cmzMXNpNj5Ema7OOH+BxK3Ta5zMAPn2+1XrkXzcUwN3FgbgzHtEMoAQdyJxRrQKL7TLmf1fJCWRviYofYfvsgysg4VA1kKzv/dvCradV9aVr573S61eD80VCuDDmLYX97cD4ljDb/b8pJ0rk+uzd6kC857N6a/5Oy0+MnCeTOEW5AT4rcF35cfWHIhgdjINSVxhJfwQEVUtU6mIVHuYDg/vqpvFIkyq2uTo49fxVE6ItODLzbXJo4eB4FBDgyDz5XSr4B65mPKsNvJ0s7LTG0OA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f067e04-5a73-4132-db6a-08d87595c2eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 07:48:55.1917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nm1t4nljrRy3pDpLE3rONZgFJ6l4WJZPK6YykFuzcJmi5f+v0w3VuJ8hIayw0PN1d6xZULYonqjbUP59OVEPsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7333
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjDlubQxMOaciDIx5pelIDE1OjIxDQo+
IFRvOiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsgVmluY2VudCBNQUlM
SE9MDQo+IDxtYWlsaG9sLnZpbmNlbnRAd2FuYWRvby5mcj47IE9saXZlciBIYXJ0a29wcCA8c29j
a2V0Y2FuQGhhcnRrb3BwLm5ldD47DQo+IGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgU3TDqXBoYW5lIEdyb3NqZWFuDQo+IDxzLmdyb3NqZWFu
QHBlYWstc3lzdGVtLmNvbT4NCj4gU3ViamVjdDogUmU6IFtuZXQtcmZjIDA0LzE2XSBjYW46IGRl
djogY2FuX2dldF9sZW4oKTogYWRkIGEgaGVscGVyIGZ1bmN0aW9uIHRvDQo+IGdldCB0aGUgY29y
cmVjdCBsZW5ndGggb2YgQ2xhc3NpY2FsIGZyYW1lcw0KPiANCj4gT24gMTAvMjEvMjAgOToxMSBB
TSwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+IEkgd29uZGVyIGlmIGl0J3MgYXBwcm9wcmlhdGUg
dG8gYXNrIHRoaXMgcXVlc3Rpb24gaGVyZSwgd2h5IHRoaXMNCj4gPiBSQVdfRExDIGlzc3VlIG1p
Z2h0IHJ1biBpbnRvIHNvbWUgYnVmZmVyIG92ZXJmbG93IGlzc3VlPyBXaWxsIGl0IGNhdXNlDQo+
ID4gZnJhbWVzIGRyb3BwZWQgZmluYWxseT8NCj4gDQo+IE9uIHRoZSB3aXJlIHRoZSBkbGMgZm9y
IENBTi0yLjAgZnJhbWVzIGNhIGdvIGZyb20gMC4uLjE1LiBJbiB0aGUgUlgtcGF0aCB0aGUNCj4g
RExDIGZvciBDQU4tMi4wIGZyYW1lcyBpcyBjYXBwZWQgdG8gOC4NCj4gDQo+IFNvIHVzZXJzcGFj
ZSBvbmx5IGV2ZXIgc2VlcyBhIG1heCBkbGMgb2YgOC4gVGhpcyB3YXkgeW91IGNhbiBsb29wIG92
ZXIgdGhlDQo+IHN0cnVjdCBjYW5fZnJhbWU6OmRhdGEuIElmIHdlIHBhc3MgdGhlIGRsYyBvZiB0
aGUgd2lyZSB1bmNhcHBlZCwgeW91IG1heSBsb29wDQo+IHVudGlsIDE1IDopDQo+IA0KPiBJbiB0
aGUgVFgtcGF0aCB3ZSBjdXJyZW50bHkgZHJvcCBDQU4tMi4wIGZyYW1lcyB3aXRoIGRsYyA+OC4N
Cg0KVGhhbmtzIE1hcmMsIG5vdyBJIHVuZGVyc3RhbmQgdGhlIG1lYW5pbmcgb2YgInJ1biBpbnRv
IHNvbWUgYnVmZmVyIG92ZXJmbG93Ii4g8J+Yig0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhh
bmcNCj4gcmVnYXJkcywNCj4gTWFyYw0KPiANCj4gLS0NCj4gUGVuZ3V0cm9uaXggZS5LLiAgICAg
ICAgICAgICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAgICAgfA0KPiBFbWJlZGRlZCBM
aW51eCAgICAgICAgICAgICAgICAgICB8IGh0dHBzOi8vd3d3LnBlbmd1dHJvbml4LmRlICB8DQo+
IFZlcnRyZXR1bmcgV2VzdC9Eb3J0bXVuZCAgICAgICAgIHwgUGhvbmU6ICs0OS0yMzEtMjgyNi05
MjQgICAgIHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgfCBGYXg6ICAgKzQ5
LTUxMjEtMjA2OTE3LTU1NTUgfA0KDQo=
