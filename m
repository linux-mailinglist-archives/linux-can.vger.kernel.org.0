Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B633E4AB9
	for <lists+linux-can@lfdr.de>; Mon,  9 Aug 2021 19:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhHIRXP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Aug 2021 13:23:15 -0400
Received: from mail-eopbgr40108.outbound.protection.outlook.com ([40.107.4.108]:53027
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234095AbhHIRXO (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 9 Aug 2021 13:23:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dvrgvo4UWsiNxeFECIsSqBxQ00VYziOybgNX0vkP2rybgstU2xayp1Tb78/9OZFcu+eSgE6uChbA7OS+vlJzFibRXtz2galmxEk8jSfoG2M80DENS3UVlo6kfsghj+ZCCVU3+pKS9cENc6biyvM3fe5WaZGumjeuRp300sYlt7okaT9Pc0ocbkePPdTgzW6NKZXUF5brqFl3IJBCrOtR8E4DYdc8wRVIy0fcai9Ro86cY2KuxCu4uCtBEbZS6DGJx6N4xFdXntApMhcorybhD9gDHRRow87KzR3F5MoyLu5dKQGpd42qRJ9RF5EfNv56ohzRkNBftvNiUwsxATzlqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufSYIfcBBLeXYkjIUrq463bxCOz+pBiNziYfGGL3rNQ=;
 b=fMlA8JQoePDL1QLBuf6V1s0n94H3UTUJK1pwUs3OaC3KvDJpIw+YdFJ6rwcxgIbAIMwBBxGpnXy5n4v25+WBprj5BRwEH3Cf/mt3XlKJvW0aMkp3nlPz/YouuszhgiOxZ/t4O/7CwM7hrEQMssIyf8fDaQtuNv6pCt0rd7VJmygCRzZGA2Ku7W5VhLF+GXJJjMJPD3snWj+8ktIscgEocOaZa7kq5v4wFPvl0aCHc9y3tK3dB/bVx5O3dZJEH+wY04sH8JEgJN0ZNEEZuMer6UI4CLYulRqaGVQHeLhAGYElACDtddMp6pgF2O1lplrgY3wi9c4CYfjTGpqkoMZx3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufSYIfcBBLeXYkjIUrq463bxCOz+pBiNziYfGGL3rNQ=;
 b=IDbvTmwsmYEbY6s+vQK34yExTI5Y1aV3FoTVvoHickKvqrIP9VUzmvVuVPXYhj0onmNwQhfBGj7GdyfFyq7jEJdmCZiJjJE+Q6g8fjR+nR75OKeWlCdsPOHuG6jwpI1BmHS2A8tMeWXk0sUdAEp/4LRpUj+JDNi/EAmuYT7GX2k=
Received: from AM9PR03MB6929.eurprd03.prod.outlook.com (2603:10a6:20b:287::7)
 by AM0PR03MB5826.eurprd03.prod.outlook.com (2603:10a6:208:15d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Mon, 9 Aug
 2021 17:22:51 +0000
Received: from AM9PR03MB6929.eurprd03.prod.outlook.com
 ([fe80::1846:f0d4:5710:e65d]) by AM9PR03MB6929.eurprd03.prod.outlook.com
 ([fe80::1846:f0d4:5710:e65d%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 17:22:51 +0000
From:   =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <Stefan.Maetje@esd.eu>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH] mailmap: update email address of Matthias Fuchs
Thread-Topic: [PATCH] mailmap: update email address of Matthias Fuchs
Thread-Index: AQHXirCeglqz0Unlkk66HIEFwudub6tmlDoAgAQ1gACAAKdAAA==
Date:   Mon, 9 Aug 2021 17:22:51 +0000
Message-ID: <1b5875759dc9d68f2379cde389b1bf5595ee3964.camel@esd.eu>
References: <20210806104833.102081-1-mkl@pengutronix.de>
         <10024d316c23d7be2ce6037f7994aa2af033208f.camel@esd.eu>
         <20210809072414.syapcl2v7urytygg@pengutronix.de>
In-Reply-To: <20210809072414.syapcl2v7urytygg@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb50679e-db96-437b-c507-08d95b5a510f
x-ms-traffictypediagnostic: AM0PR03MB5826:
x-microsoft-antispam-prvs: <AM0PR03MB58268B3D9856C89FF62BEB7181F69@AM0PR03MB5826.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MJGQFJ6zuiwFE99/XARgrkVYt/voa/GWfDyQXAVM1hebkJ2C8h+cFcSefsrT2Kbh6ROWPYvjOSooD2lYayD8V9ms08KVzJkDvSx/0sy8+w5qhyvj8O84SF1arB76V6fkGTbmhcfxN4XXYllAyD64TN9Fgi3nJyHwispgTAMYFNpZy9wZhv4Cs9iDsazGNiPR+P8ORnUkCftkPwGzwp0v0/xVRKF2PEx+Q4um+n7WUWoFTm83nEzptZvWkRcOYpkBh12XLwo16oP7K5W909rHHD7HRT8Upf/93YpsCi9kqekKnVhsl56sqBuoEukM7/MSrv62hiC+v/Vu3U5r82orN4YTazgUjfOzojXvKuU1DRHpsulaHqlM+w5M/0oZwTHyInWWJhlb7heYhxZpSZNEs2J00ZbCdwllN6dl8+5v2guVSKZ03gluom8NqAv1ENeXIuY7CiXyeOj2NGzFt6ku3KNSEJ42Jb6+g/0Gcp2Phr50drVsDmuNJ6Dj12rpTDkVqe1KTlZD02CM0SLP/odr+PF7+D4m0Ah8lJP7t1O7/p9r45mVLwvJVksfFIVI+ptQ7Vk/w3RZutjyg8bUF+p88mlD1eDpDtZxvj0vRusbn9I2hPlU1hd8gsp6UUmoM8JqQ1Rqw/PZtGROjhkd799QkDDr6vLsf+QtFhI6sBbUb3dEb+es2LbKejHbyGDTBiAiuBRxPfZt2FCqZrBFyEefsbanfDG401HcxiafBw5hVpIt3XUyoCsrAUxzBTEXHZaJg5JKDCIDT33Sm5iphVZy4F5NFmOPeL8ZUtq3hhyUR3HPVHhsCqclf9nbVWAYKxgP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR03MB6929.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39830400003)(366004)(136003)(6486002)(85202003)(53546011)(15650500001)(6512007)(83380400001)(85182001)(64756008)(66946007)(6916009)(8936002)(8676002)(2616005)(66446008)(66476007)(2906002)(71200400001)(66556008)(6506007)(66574015)(186003)(38070700005)(122000001)(26005)(76116006)(91956017)(36756003)(5660300002)(86362001)(478600001)(54906003)(316002)(38100700002)(4326008)(966005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2E0T0pHTkoxTXlmbFRRdGNmRHZCVWsvMWl6dlV0UDNtNGFINGMxZENBZ0NY?=
 =?utf-8?B?ZmpBSWZHbDlBT2E2a1FwM2xlTnA3cHQxTXRwNythWG15ejlzZi9jRmYyQ3hx?=
 =?utf-8?B?cnRQWVdId2lqSmhaNTV3YnpaM2Evc2RGRVN2RDdpbk9TdmtkVEtFMWhBcTZB?=
 =?utf-8?B?ZlpoeVJXdjVSZ2MzYm1QWVJ4L1VrMThVVmFSMXNwYmtGWmIvREcyckt5eVpS?=
 =?utf-8?B?UVA4U3MyTWpMRmdHRHJRbllYNjZyQURBcWJpSmlMRnJoTVJwc2hSQ3JRWldt?=
 =?utf-8?B?b3FtYlE0VkIrSUlCU01JZ2tkU25vbTZNcWRFSDFoTzVaam5WOG5ZblNweXlh?=
 =?utf-8?B?bG92M3V0RVU4VDBRQzBlaklPVDBqajhXVUgwMEhmc1RyYjIwSHJ0NWlrOUxi?=
 =?utf-8?B?d1lFZnZ1OVNUQjYvOTNlTGp4cUdjcURZQzcrZG56VUNtaCtSVnVzdml0ZUpy?=
 =?utf-8?B?U0ZLbTlOT3FhUHVVcThHamJVYkRZZndGRU9hSTUwU0k2U2dqeUtHODdMWE51?=
 =?utf-8?B?SnMzUUpza2I1OVVvODRLdkJtSUhjQVVhcUpsQ21vTCtNbkFodEZmYmppQ2Rh?=
 =?utf-8?B?NDVyWlpNb3J1cmxsOVlmYnlZM3QwRkp3Y2tVZ2VmdG1uNGJZaUo2aUIrVG1u?=
 =?utf-8?B?RzI0MC9IeEtYYUJVcGNvTTBjclArS0pSazVpMDBkcmgwVk1RWEhtT1QvcmtO?=
 =?utf-8?B?S0pDVEc5MDhiTVFUV1Y5eHZjbmF6QkU5cVVqVkRUUnFpNVhMWUcxZnkyOVZM?=
 =?utf-8?B?V2lrdXU3Vll0V2IwL0QwQ1dPQk10aGwwdUtZUzN3dEUyWGh2U2NlUVZ6R0dp?=
 =?utf-8?B?Snd3eVJjQWlXVnFEaE5pdGhzYUNmOUx0dWI3U0drd2tHNmg2djRSYVpoL0x5?=
 =?utf-8?B?K1pwS09hcFBwbE0rM01yNkpQUjlMMExjVlYwMzdDQVdkYTlPR0dQZjZML1Yy?=
 =?utf-8?B?bTVPdzQrY0tjektRRnVrTml2d3B2c293VkxmVGRrZnVXSDAwdW9sOUdOcEw1?=
 =?utf-8?B?dWh2ZnAzUm4yMWJiSmRPckJXMWt2UzZMMDJlUXNCUVVRSys4S3ZzNmNOakZZ?=
 =?utf-8?B?bjRvaGNUcVJFay92ekpuV1l3YTN1a1pYcEVlbVFsQkdzY1ZGcC9KSWQyUVZI?=
 =?utf-8?B?UXRUOFVPRzhBY0lrSUg4NFRVdmpWWVhKZHdQZzZlVTlLclVhVThsRE4wYWJF?=
 =?utf-8?B?bmhNMjFMNERKSmtVdllzYWR0STRTSlFQR3FaUUg4Wi96N1ZvTFlPWThqNnor?=
 =?utf-8?B?Q0lWZHFFVmNLVTJ1VHZvUjV4U0RmYTN1TnhjMEF3RUZIQ2xHVXRlcExTaGtk?=
 =?utf-8?B?MlRScGhJVTQxbXluSFZkSk9ienl3K2lCTmZpQllkbGFWalNROUNYMER5VzJP?=
 =?utf-8?B?QmlkckQyS3ZrU29icU4ydEZpR01JM2dDc3FFTXJ6R3FWVk9qWG5wSkg0WXJu?=
 =?utf-8?B?a2tRQk1uRnM1dlFKYW03cW1KMjFVemk3QTNBM2RteDNRWDk4UlVib3NlZ3ht?=
 =?utf-8?B?QzNLTnhVY0tXbWlTbFpzc3NiSkhUbkdHSUJJUmNPblp1QStja0d6UG81MWtu?=
 =?utf-8?B?bFM5NGtwWWV5THBwUk9haEFiazM2QzZBaE1OKzZjeXNJTDRjbm9OZEV1TkZh?=
 =?utf-8?B?K05uOW1VWXp4U1ppTjJmR2FLcHFkOXNlZnZ0cGt0c1dnM0p0M0ZTVTlwcmtw?=
 =?utf-8?B?dXhOSzlvb0FsK05jSDdtR0ZRYTV5bnBWK05WK3BKTC9aS1VpZnh5c1Q5SVJu?=
 =?utf-8?Q?RAT4xjQNSMDBHBO8cqTPwrbnKBROv7LGj1wUdjk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5626F1432F4C447B18205D281C30815@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR03MB6929.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb50679e-db96-437b-c507-08d95b5a510f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 17:22:51.3523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oG2BtVQNx71dAxvtYp5oU8NpogxqxlhFbrx+JVZJr+lLnA1wTO7VEGqjh2wwccEi+FFEwr4s7gL21RrGxtNfgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB5826
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

QW0gTW9udGFnLCBkZW4gMDkuMDguMjAyMSwgMDk6MjQgKzAyMDAgc2NocmllYiBNYXJjIEtsZWlu
ZS1CdWRkZToNCj4gT24gMDYuMDguMjAyMSAxNTowNzo0MywgU3RlZmFuIE3DpHRqZSB3cm90ZToN
Cj4gPiBJIHdhcyBub3QgYXdhcmUgb2YgdGhlIC5tYWlsbWFwIGZpbGUgYW5kIGl0cyB3b3JraW5n
cy4gDQo+IA0KPiBUaGUgbWFpbG1hcCBmaWxlIHdvcmtzIG9uIHRoZSBnaXQgbG9nLCBhbmQgdGh1
cyB0b29scyB1c2luZyBpdDogZS5nLg0KPiBzY3JpcHRzL2dldF9tYWludGFpbmVyLnBsLg0KPiAN
Cj4gPiBNeSBxdWVzdGlvbiBpcyBzaG91bGQgdGhlbiBhbHNvIDx0aG9tYXMua29lcnBlckBlc2Qu
ZXU+IGJlIHB1dCBpbiB0aGlzDQo+ID4gZmlsZQ0KPiANCj4gUHJvYmFibHkgeWVzLCBhcyB0aGVy
ZSBhcmUgdHdvIHBhdGNoZXMgYnkgaGltIGluIHRoZSBMaW51eCBrZXJuZWw6DQo+IA0KPiA+IFRo
b21hcyBLw7ZycGVyICgyKToNCj4gPiAgICAgICBjYW46IGRldjogYXZvaWQgY2FsbGluZyBrZnJl
ZV9za2IoKSBmcm9tIGludGVycnVwdCBjb250ZXh0DQo+ID4gICAgICAgY2FuOiBlc2RfdXNiMjog
Rml4IHNwYXJzZSB3YXJuaW5ncw0KPiANCj4gSSdsbCB1cGRhdGUgdGhpcyBwYXRjaC4NCj4gDQo+
ID4gYmVjYXVzZSBoZSBpcyB0aGUgY28tYXV0aG9yIG9mIHRoZSBwYXRjaCB5b3UncmUgcmV2aWV3
aW5nIGF0bS4NCj4gDQo+IEZvciBjby1hdXRob3JzaGlwLCB1c2UgdGhlIENvLWRldmVsb3BlZC1i
eSB0YWcsIHRoYXQgd2FzIHJlY2VudGx5IGFkZGVkOg0KPiANCj4gaHR0cHM6Ly9lbGl4aXIuYm9v
dGxpbi5jb20vbGludXgvdjUuMTIvc291cmNlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0
aW5nLXBhdGNoZXMucnN0I0w0NDkNCg0KSSB3aWxsIGRvIHRoYXQuDQoNCj4gU3BlYWtpbmcgb2Yg
dGhhdCBwYXRjaC4gQ2FuIHlvdSBwbGVhc2UgY3JlYXRlIGFuIGVudHJ5IGluIHRoZQ0KPiBNQUlO
VEFJTkVSUyBmaWxlLCB0b28/IEkgc3VnZ2VzdCB0byBhZGQgeW91cnNlbGYgYXMgTTogYW5kIHRo
ZQ0KPiBzb2NrZXRjYW5AZS51IGFzIFI6LiBUaGUgY2hhbmdlIGluIHRoZSBNQUlOVEFJTkVSUyBm
aWxlIHdpbGwgYmUgYSBzZWNvbmQNCj4gcGF0Y2ggaW4gdGhhdCBzZXJpZXMuIEp1c3QgaW5jbHVk
ZSBpdCB0aGUgbmV4dCBpdGVyYXRpb24gb2YgdGhhdCBzZXJpZXMuDQoNCkRvIHlvdSB0aGluayBv
ZiBzb21ldGhpbmcgbGlrZSB0aGUgcGF0Y2ggYmVsb3c/IEknbSBjdXJpb3VzLiBTaG91bGRuJ3Qg
dGhlcmUgDQpiZSBzaW1pbGFyIGVudHJpZXMgZm9yIHRoZSBkcml2ZXJzIGZyb20gVmluY2VudCAo
ZHJpdmVycy9uZXQvY2FuL3VzYi9ldGFzX2VzNTh4LykNCmFuZCB0aGUgUEVBSyBkcml2ZXIgZmFt
aWx5IChkcml2ZXJzL25ldC9jYW4vcGVha19jYW5mZC8pPyBXaHkgYXJlIHRoZXkgbm90IHRoZXJl
Pw0KSGF2ZSBJIG1pc3VuZGVyc3Rvb2Qgc29tZXRoaW5nPw0KDQpkaWZmIC0tZ2l0IGEvTUFJTlRB
SU5FUlMgYi9NQUlOVEFJTkVSUw0KaW5kZXggNDFmY2ZkYjI0YTgxLi5mMjVlM2Y3OWIzOTIgMTAw
NjQ0DQotLS0gYS9NQUlOVEFJTkVSUw0KKysrIGIvTUFJTlRBSU5FUlMNCkBAIC00MTExLDYgKzQx
MTEsMTQgQEAgRjogICAgICAgaW5jbHVkZS91YXBpL2xpbnV4L2Nhbi9lcnJvci5oDQogRjogICAg
IGluY2x1ZGUvdWFwaS9saW51eC9jYW4vbmV0bGluay5oDQogRjogICAgIGluY2x1ZGUvdWFwaS9s
aW51eC9jYW4vdnhjYW4uaA0KIA0KK0NBTiBORVRXT1JLIERSSVZFUlMgRVNEIEhBUkRXQVJFDQor
TTogICAgIFN0ZWZhbiBNw6R0amUgPHN0ZWZhbi5tYWV0amVAZXNkLmV1Pg0KK1I6ICAgICBzb2Nr
ZXRjYW5AZXNkLmV1DQorTDogICAgIGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmcNCitTOiAgICAg
TWFpbnRhaW5lZA0KK0Y6ICAgICBkcml2ZXJzL25ldC9jYW4vZXNkLw0KK0Y6ICAgICBkcml2ZXJz
L25ldC9jYW4vdXNiL2VzZF91c2IyLmMNCisNCiBDQU4gTkVUV09SSyBMQVlFUg0KIE06ICAgICBP
bGl2ZXIgSGFydGtvcHAgPHNvY2tldGNhbkBoYXJ0a29wcC5uZXQ+DQogTTogICAgIE1hcmMgS2xl
aW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQoNCg0KPiA+IGFuZCBoaXMgZW1haWwgYWRk
cmVzcyBzaG93cyB1cCBpbiBNT0RVTEVfQVVUSE9SKCkgbWFjcm8uIEhlIGFsc28gbGVmdA0KPiA+
IG91ciBjb21wYW55IGFscmVhZHkuDQo+IA0KPiBJbiBuZXdseSBhZGRlZCBjaGFuZ2VzLCBpdCBt
YWtlcyBzZW5zZSB0aGF0IGFsbCBlbWFpbCBhZGRyZXNzZXMgYXJlDQo+IHdvcmtpbmcuIDpEDQoN
ClNvIEknbGwgcmVtb3ZlIGhpcyBzdGFsZSBlbWFpbCBhZGRyZXNzIHRvZ2V0aGVyIHdpdGggdGhl
IE1PRFVMRV9BVVRIT1IoKSBtYWNybw0KYW5kIGZpbGUgdGhlIGF1dGhvcnNoaXAgY3JlZGl0cyBp
biBhIGNoYW5nZWQgY29weXJpZ2h0IGhpc3RvcnkgYXQgdGhlIHRvcCBvZg0KdGhlIHNvdXJjZSBm
aWxlcy4NCg0KQmVzdCByZWdhcmRzLA0KICAgIFN0ZWZhbg0KDQo=
