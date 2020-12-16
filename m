Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A946C2DC5B6
	for <lists+linux-can@lfdr.de>; Wed, 16 Dec 2020 18:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgLPRuj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Dec 2020 12:50:39 -0500
Received: from mail-eopbgr150102.outbound.protection.outlook.com ([40.107.15.102]:39402
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727109AbgLPRuj (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 16 Dec 2020 12:50:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLCAt6Xlbd0/RRVUTgFEVgllY36SBKeyj86vAoX5HPI9gB42F1WqYMXKFjDFk8EFLHiLxp141q4c1vgLdn2OFYyDeKWcbd+OBKHJaJ8DQ56KPZFe/itmXHdmIqhHkx3YAddW8EylcOsqLQJrASOISbf3neLyKTrFsAb+4nJyR4cYb2Wd0lDtRULLNWKLnvsT0WlU7tbbhIqLvQAAth12XnrbnhiM1dAQ/jezU4FcgVMVviMiiByRq8Rjwd274kiKzkHD/gz7TTYajStQRXRfcHruX3m3xqSRjzjLA9W2/KN/b5z8f3ygS+9AewIL56by7dWx1k31l+DPHqc6GuPHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMoe6Vm61H7b33BxosLsUpzSQ/8p8Bnct9GYN697LdI=;
 b=cgsCgJiN+NMcr6sf2hR0FZvN3SgHR1tDs7+vXTPKgWsPj7GncxwNpH9aIV0Ei8ePipntnIowidE29sFxg2zBDoFU/edvCFLksgGRhgzLq5Ob1jk8muKIVs/X5Y9evTX5hXJ2wQc58kXx96FvRJ7XsattbO2cpSv5CDsWE1IyQQmroX5uoOdqCT7QIp/VykwwPOANhxMbgRGP+B5yor3frGPRTcWQ16/p7TmoRae77qykg4Jm+kJy2F+3RbGLA91+TQpLTlPVcC3ZvCfCaevL0lNWojxKAAlWDoKELB03tdiDO4zmrXPdv1y4aBj/1wDSPDbBJVSSrE657V406XqOzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMoe6Vm61H7b33BxosLsUpzSQ/8p8Bnct9GYN697LdI=;
 b=VvsrGq9x5XqCJTyxfVgl/OL8hSUxyqr6JSP9/dC6yaVPpYTnkAxnS+OZU8DC392tF4hmalEHk1D2JPNhcsrSUG5pMzwpafHWdShwVh5J/cutkN2ac577zK+ECg/FrxFiGM4/1cdbbe8rnHzDmGKR2v1dAI7YFaR6FuyiWYBQMRU=
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:12d::21)
 by DBAP190MB0838.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Wed, 16 Dec
 2020 17:49:51 +0000
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::fc76:b821:1966:db40]) by DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::fc76:b821:1966:db40%8]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 17:49:50 +0000
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: AW: assignment of spi to can channels
Thread-Topic: assignment of spi to can channels
Thread-Index: AdbTmBm1lZbEHNKQRxyl9xCamZQMEQAFv+GAAAj51EA=
Date:   Wed, 16 Dec 2020 17:49:50 +0000
Message-ID: <DB8P190MB0634B8626AEF0F14A653DC67D9C50@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
References: <DB8P190MB06343276BF64CB3530DEB5D6D9C50@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <32e1f29b-b16e-bc8e-e57a-92c67d45a335@pengutronix.de>
In-Reply-To: <32e1f29b-b16e-bc8e-e57a-92c67d45a335@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=schleissheimer.de;
x-originating-ip: [62.153.209.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19bc25e2-eedc-4ac9-4e80-08d8a1eafcd4
x-ms-traffictypediagnostic: DBAP190MB0838:
x-microsoft-antispam-prvs: <DBAP190MB08381ABC0878E42DF78180ABD9C50@DBAP190MB0838.EURP190.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9P2Cfg+8AAm2buF94DQZAVE+t+37xE6FOABlEE8Niy/1D17N5RINTA4o/zOiQb07uizEtKuPpYchj5sQsx84zuHeKaeL+4FnLbmwJOath3DZpaDo3mQHhn2SCiYaOA6vRO5i+MZxz2QaFiq547YIw3x+CB7NSkMN4wqlWE4Z01Rvpy0hrp6ufnB8m+CeJPRma34RIqbslrIWpWGAfAwAix5jcLU1DbiBilNTQ4NXK15/Q6tNcKI6T28PVUMjBBCWXUXIhBnQoeG1ihoK074I6XG7M3ZsaniMU3kVcZ9JOQuhfW7WYvbnlleSzjzBVjrlVbyHdSpmbMKrumgzRBUdMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P190MB0634.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(39830400003)(136003)(376002)(66946007)(52536014)(33656002)(8676002)(7696005)(9686003)(110136005)(66476007)(64756008)(66556008)(8936002)(86362001)(478600001)(186003)(6506007)(83380400001)(316002)(76116006)(55016002)(26005)(66446008)(2906002)(71200400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?b3ZKQW5tdU93V1VJZWdqeWUxV1lxRDhMSjB1NHVFUDl3NzhjbWNIQWxKcEt3?=
 =?utf-8?B?ZEtodG1yeWVCalV2WmJGZHlvTGxJb1lMZkVGc1RJODZzQUNHaWpBSjNJeUVt?=
 =?utf-8?B?bzJjcVFkd0QyTnNSK0U2Z0xxbGJHZlEzTlh2SE1uSzhMbGJ1NzU4d3lxU1Fu?=
 =?utf-8?B?MEt0SS9CaUExT2tMaDZuVnU1dUFkRlpRcXArR25NZVhtV2Rvc3RqMSsxMWpj?=
 =?utf-8?B?QW9YUVp0YkVqeW1WaldzUGdKQk81bm9KQldqMWNkNis2UDA4NDltZzJCV0xh?=
 =?utf-8?B?cVhpNllIWnBZSEdVbW05cXZYb1ZDV2dSMkt3TTJNTi93UGNuWXAzTXpVaG5L?=
 =?utf-8?B?MXdHMkZla3ZZamR4czQyVm1uVnljYVBRcmk2SzArekRmZmo4MTRmWHBxUExH?=
 =?utf-8?B?K3VlQXdKZjVKek5VM1RYQm5HSjYrM2V4akFxZk1vVm1Hb1BYK3VPRjZoS2hn?=
 =?utf-8?B?dWh5cFNJNVQvcGtaaGNWejcvbjhVdmwrRHdzMXc4S1NDcmlNZzlsTGFhWnAw?=
 =?utf-8?B?Q1BtN0RKU2hJaGhUMTBvSHE2RDk2SnlqZis3RHhUYUw0ZWR4Wjg1UHIzY2lU?=
 =?utf-8?B?eGc1WXROV0EyZjFPNjdHSS94dHM2R1FRUHNZNFNuZ0pJZE0yRWRnY0dlblVD?=
 =?utf-8?B?ZnMvRnlZdFFzQkg4UFVsTDVESlRCQ2ZaelI4Ykdhay9uWlNzUWx1RDhrU2RC?=
 =?utf-8?B?NWRFa1ZCL0tJWVpzSCtxSnBFRlE5R1h1TjViUkpkanJpZ1YvamxtRlk5OFFP?=
 =?utf-8?B?WkV3Z1pzWitCZXZZbEZIZXZydFN2S0NpelBzZnE2czF0aktrMjIwUCtFUDAy?=
 =?utf-8?B?Vk1FMnM4MmdLWEVDYVJDdndTQjNHVXhKSVlSUWRJNVlYTmd0TWZDYnlERkds?=
 =?utf-8?B?TVB3SWE2U0FXakp2alpja0lPNEJ4enBOSUxwRk5mdyt4YThBUnppb0wrZWVw?=
 =?utf-8?B?WFRQRWpwMnA0RWZMeFYxZER1QnlneWRLeEswYmpGMHlkQnBSakQxQVdZdkUv?=
 =?utf-8?B?YlFxODNHMFh1SFRPMlFNbEtmNDh3bnh2bVFxaU56QkdUb2hQQ2NvRndob0pQ?=
 =?utf-8?B?RzNEc3JqTmxaQTByc2QxaHRvU1VUWGJFYjZySHY1R1locGR0bDk5YnNMcTIr?=
 =?utf-8?B?UllDTEZYRUtXVlNYdUFpVTFpWW5NUjJZS3FyYkdUOXRSTG9WeUpYS1ltTlhO?=
 =?utf-8?B?QXlJNzk3R3FUbmVUOTlQNS9GV1dEMEUwWVR5V0ZnODRIVmUwdkFBallWdzEz?=
 =?utf-8?B?dFdEOWE1a2ZyMUkvdGlTdFVrRldNczNNaXRSOGx0T2NrbHBFNG85QVNXZm9Y?=
 =?utf-8?Q?ho86o34VbgjV0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bc25e2-eedc-4ac9-4e80-08d8a1eafcd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 17:49:50.7991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YEqr7vwJtap7wFxvmhdNHeGpOLrDy9ouspPdoe59prWsQsgxMy5Dx0v933/GlZtQRQpJuaxICtifW09N5xiyNj8T8v+HbLKA7J8b21GySgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0838
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiAtLS0tLVVyc3Byw7xuZ2xpY2hlIE5hY2hyaWNodC0tLS0tDQo+IFZvbjogTWFyYyBLbGVpbmUt
QnVkZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gR2VzZW5kZXQ6IE1pdHR3b2NoLCAxNi4gRGV6
ZW1iZXIgMjAyMCAxNDoyNw0KPiBBbjogU3ZlbiBTY2h1Y2htYW5uIDxzY2h1Y2htYW5uQHNjaGxl
aXNzaGVpbWVyLmRlPjsgbGludXgtY2FuQHZnZXIua2VybmVsLm9yZw0KPiBCZXRyZWZmOiBSZTog
YXNzaWdubWVudCBvZiBzcGkgdG8gY2FuIGNoYW5uZWxzDQo+IA0KPiBUaGUgY2xhc3NpYyBzb2x1
dGlvbiB3b3VsZCBiZSBhIHVkZXYgcnVsZSBpbiBlLmcuIC9ldGMvdWRldi9ydWxlcy5kLzcwLWNh
bi5ydWxlcyINCj4gDQo+ID4gU1VCU1lTVEVNPT0ibmV0IiwgQUNUSU9OPT0iYWRkIiwgREVWUEFU
SD09Ii9kZXZpY2VzL3BsYXRmb3JtL3NvYy8qLyovKi9zcGkwLjAvbmV0L2Nhbj8iLCBOQU1FPSJt
Y3AwIg0KPiA+IFNVQlNZU1RFTT09Im5ldCIsIEFDVElPTj09ImFkZCIsIERFVlBBVEg9PSIvZGV2
aWNlcy9wbGF0Zm9ybS9zb2MvKi8qLyovc3BpMS4wL25ldC9jYW4/IiwgTkFNRT0ibWNwMSINCj4g
PiBTVUJTWVNURU09PSJuZXQiLCBBQ1RJT049PSJhZGQiLCBERVZQQVRIPT0iL2RldmljZXMvcGxh
dGZvcm0vc29jLyovKi8qL3NwaTIuMC9uZXQvY2FuPyIsIE5BTUU9Im1jcDIiDQo+ID4gU1VCU1lT
VEVNPT0ibmV0IiwgQUNUSU9OPT0iYWRkIiwgREVWUEFUSD09Ii9kZXZpY2VzL3BsYXRmb3JtL3Nv
Yy8qLyovKi9zcGkyLjEvbmV0L2Nhbj8iLCBOQU1FPSJtY3AzIg0KPiANCj4gRmlndXJlIG91dCB0
aGUgZXhhY3QgREVWUEFUSCB3aXRoDQo+IA0KPiA+IHVkZXZhZG0gdGVzdCAvc3lzL2NsYXNzL25l
dC9jYW4wDQo+ID4gdWRldmFkbSB0ZXN0IC9zeXMvY2xhc3MvbmV0L2NhbjENCj4gDQo+IE5vdGUs
IHdpdGggb2xkZXIgdmVyc2lvbnMgb2YgdWRldiBpdCB3YXMgcG9zc2libGUgdG8gcmVuYW1lIGlu
dGVyZmFjZXMgd2l0aGluDQo+IHRoZSBzYW1lIG5hbWVzcGFjZSwgZS5nLiB1c2UgIk5BTUU9Y2Fu
MCIuIEkgdGhpbmsgdGhpcyBkb2Vzbid0IHdvcmsgd2l0aCBuZXdlcg0KPiB1ZGV2cyBhbnltb3Jl
LCBzbyBpbiB0aGlzIGV4YW1wbGUgIm1jcD8iIGlzIHVzZWQuDQo+IA0KU2luY2UgSSBhbSBvbiBz
eXN0ZW1kIDI0MSBvbiBhIFJhc3BiZXJyeVBpIEkgZGVjaWRlZCB0byBnbyBmb3IgdWRldiBzdHls
ZQ0KDQpjcmVhdGVkIC9ldGMvdWRldi9ydWxlcy5kLzcwLWNhbi5ydWxlcyB3aXRoDQpTVUJTWVNU
RU09PSJuZXQiLCBBQ1RJT049PSJhZGQiLCBERVZQQVRIPT0iL2RldmljZXMvcGxhdGZvcm0vc29j
LyovKi8qL3NwaTAuMC9uZXQvY2FuPyIsIE5BTUU9ImNhbjAiDQpTVUJTWVNURU09PSJuZXQiLCBB
Q1RJT049PSJhZGQiLCBERVZQQVRIPT0iL2RldmljZXMvcGxhdGZvcm0vc29jLyovKi8qL3NwaTEu
MC9uZXQvY2FuPyIsIE5BTUU9ImNhbjEiDQoNCmFuZCB0YWRhYWFhYToNClsgICAgNi45MTc1Nzhd
IHNwaV9tYXN0ZXIgc3BpMTogd2lsbCBydW4gbWVzc2FnZSBwdW1wIHdpdGggcmVhbHRpbWUgcHJp
b3JpdHkNClsgICAgNi45MzY5NTddIG1jcDI1MXhmZCBzcGkxLjAgY2FuMDogTUNQMjUxOEZEIHJl
djAuMCAoLVJYXy4uLg0KWyAgICA2Ljk1NjUyM10gc3BpX21hc3RlciBzcGkwOiB3aWxsIHJ1biBt
ZXNzYWdlIHB1bXAgd2l0aCByZWFsdGltZSBwcmlvcml0eQ0KWyAgICA2Ljk3MTk0Ml0gbWNwMjUx
eGZkIHNwaTAuMCBjYW4xOiBNQ1AyNTE4RkQgcmV2MC4wICgtUlhfLi4uDQpbICAgIDcuMDA2NTE1
XSBtY3AyNTF4ZmQgc3BpMS4wIHJlbmFtZTM6IHJlbmFtZWQgZnJvbSBjYW4wDQpbICAgIDcuMDQx
NjgxXSBtY3AyNTF4ZmQgc3BpMC4wIGNhbjA6IHJlbmFtZWQgZnJvbSBjYW4xDQpbICAgIDcuMDkx
NTYzXSBtY3AyNTF4ZmQgc3BpMS4wIGNhbjE6IHJlbmFtZWQgZnJvbSByZW5hbWUzDQoNClRoYW5r
IHlvdSBNYXJjIQ0KDQogICBTdmVuDQo=
