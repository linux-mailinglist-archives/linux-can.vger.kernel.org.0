Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDC03FADC4
	for <lists+linux-can@lfdr.de>; Sun, 29 Aug 2021 20:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbhH2S3C (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 29 Aug 2021 14:29:02 -0400
Received: from mail-eopbgr60138.outbound.protection.outlook.com ([40.107.6.138]:50855
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235765AbhH2S3B (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sun, 29 Aug 2021 14:29:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSxsnkyU41fRD2AS6KYsD/IAc1OjGkaIyz2rqAgpp1ojwGKPhq3IR4rpTEYeRNgZzSF2Mi0QYgdSHMwm5MaeSAOOWATHbIc/PYG68TmGT7vDG4tRLTTKrjQFSWJOlnbFm/h67bgBLTxD+M51jSYQTrbb43FbOauSBAZXY+FvEbBVNClWn70anq4cinZVYy1H/vcOtViqONrOiOpbqY6O16KubYwkQwXauJEWoCYMilbIa9CWnVD4xIsvSA7zwRKz97Wxnhli2+oOTUti5ScBkLKtyw8TPxyrC03mxbDxZgyypbLflgIoNKar9O8VUpUMxrAfJAcmZyN/xUlMcOiXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dShXKQJMLnbbqm7fGkY3sgPiK4EeKxybMARBv+QGDvE=;
 b=Tq9wVl4XX9sX356zNYfziANCe3IIjqwXJ8MORHVaQBuIj0AfrZIznuoxK474K5j0PYWTGf41GtwdITgap8sqcsefFwMWmOjBVc2Xg/im60lSsN7/kWuMhzSLOR2NVf6z8DiEi8USypujQhWbJ73DhefNU3vFmCoBI40slFshKsUEslOeGuxtyOAvCKixGqU6XTu+YQP0JMBMIseVp5Ux2x7hUsvKNuCxTfxdSHQDpRJO9XP9UXEDZ8Ff5NidOFpuKcE/yW+PMROgqHmz9xd/QS+oez6khbfc9F3l5Xam1/5vfasp/w3rD00vdrUAVpjlcdKLUThDEmA+yKY2ed1KQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dShXKQJMLnbbqm7fGkY3sgPiK4EeKxybMARBv+QGDvE=;
 b=lR2JpDa2XP5odtWnRdMaT2q+8RzAiF0H8gyH4mgNYYD2npmVzw0KWc7r9iw8ipCiibfx4Bhz2VVcb02jcv1ujuAqY2Sd7IX83WZm2m8a/sPYmBbRHhtEsdBJvCZ6BqfX+7eYFW3+KICDosTPrPLcLQNMqKN3lyeplJiLz5MkgVg=
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:12d::21)
 by DB9P190MB1611.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:247::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Sun, 29 Aug
 2021 18:28:07 +0000
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::396d:bf7c:32d7:426]) by DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::396d:bf7c:32d7:426%6]) with mapi id 15.20.4457.024; Sun, 29 Aug 2021
 18:28:06 +0000
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: AW: AW: [PATCH] can: isotp: omit unintended hrtimer restart on socket
 release
Thread-Topic: AW: [PATCH] can: isotp: omit unintended hrtimer restart on
 socket release
Thread-Index: AQHXZGiarGqUjPpuCESr46IsZOKw9auJVcCAgAFwdYCAAHML8A==
Date:   Sun, 29 Aug 2021 18:28:06 +0000
Message-ID: <DB8P190MB0634E1A09E060C9A5A539073D9CA9@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
References: <20210618173713.2296-1-socketcan@hartkopp.net>
 <DB8P190MB06343614CAD6B48C3EA0EF00D9C99@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <abc23fd0-9bb1-1cc7-fc67-0a3298673b86@hartkopp.net>
In-Reply-To: <abc23fd0-9bb1-1cc7-fc67-0a3298673b86@hartkopp.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hartkopp.net; dkim=none (message not signed)
 header.d=none;hartkopp.net; dmarc=none action=none
 header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f064ac2f-2b04-4e15-00e4-08d96b1abf03
x-ms-traffictypediagnostic: DB9P190MB1611:
x-microsoft-antispam-prvs: <DB9P190MB1611B4D002AEABD151094878D9CA9@DB9P190MB1611.EURP190.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0B8uodkSmOomxRs7BsRT60DrjvfFB1vnH6exvSjUtoQwkQpZXIID7/fa+ADHQuXNGUeorPeNfuuoK95L9IXiDRQS6/EkepugJSdBTRWpYN3kMApsn7+4S1Ht29YhrtLiK+xk99FGxcl4woYoF0hsc+5v1pqxBjykZuucVsK+0X4eXMxidHCZ5GLXlNgU8nz5un2WnZxAnXZp3QHW/Jslj8FiGWrRoBctZ/K3yE4AueaZ0DNNnBi3XUFBySkxNWkRy0fUF21XCniY25KlOWTaRZKXBAsfOP6WkMWBN5e3XXD0fFSEbTql03pkTm2O8cz7RkjD4DWL0D8fU7YXg8L5ii+tqNicOdCcECaTQQykHeSnbUoe+S0iolUZrSjC65NVGyIj8Pgy1K/1SsawsOSW0YyT5x6oa9XZ3u9qzsDp3SPOIuJdnIfKPGOTg5Vlu8tnzaPOpVDCEy95z6bj+C0Ho7l8/F2nOPb9FFuz7kJg9gRKEblP0SzgWI0m05BbSiwVQQQS2hWV20Bzk+RFFECq52QtvDedzGzGPDidAlDoM9pP71jgIWWK+6g4gEXVTZ2km7HfigkB4O21am8r6a+bJt6wdrHhS8t6IQb7Iav0F+HueKqgVX3JuHxq0yOgR+dTQ9ASH4NjoZQ1H8QLz13cAnq2LtGMkzMX3/wzIfsJU/NiNqySK/VNkqRHlwUNMcv1C+y45n/YxcTFAiNdmGf9AQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P190MB0634.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(136003)(346002)(39830400003)(478600001)(83380400001)(55016002)(71200400001)(6506007)(38070700005)(38100700002)(186003)(26005)(33656002)(2906002)(122000001)(7696005)(8676002)(8936002)(66476007)(66946007)(66446008)(52536014)(76116006)(66556008)(64756008)(4326008)(316002)(86362001)(110136005)(5660300002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1h1MDk1QXRVS0ltdFZGWmFLR2xveEc1OC8rcDZyY01kdW1TUzdQV3RQZ3ZS?=
 =?utf-8?B?dGlONk1xOXJiRGpsUEk0MWdTaTBFOGw0VkdubjdlUFV0UGNKK3dzdE92WE54?=
 =?utf-8?B?TXl3ZFhtUUlzTGN4L1BaaTZxQ0FTby9qS1RQYmZ0dWxZMmFiTkRSUDRDYXR2?=
 =?utf-8?B?V3Q5SzVVZXppVERGajQ1S0V6TXUzdWYxMExaMzZnNGY5NEdFbGpZOVM1ZnYy?=
 =?utf-8?B?SVJyL01vYjd6NmNsQ2pBYTliQjBqb1dDZTNDSy9xUTB6TEptSjloSW9GamhC?=
 =?utf-8?B?UFkwQS9yWURacDNHYjVWTHBuamtaaU5UQkhYeFBYQXFOcFByZmNFVE83WUs5?=
 =?utf-8?B?VHJhWUl0a3ZhaHpFc1JHRW83UlBCNFdhMXVhU2J0L1AydWZoQ0tlVmdiNmNF?=
 =?utf-8?B?SE42MFF1b0J1RnQwWHFnMTdnRFVwcWZQWDBBRzJMVXkzTjBETThVRkY1cEpU?=
 =?utf-8?B?cmxSenJ4dmoxNE9SMHlHbHNvLzBidXZCQzYyZzlxZ3hJZEczZjFCMjhYMTMw?=
 =?utf-8?B?ZU9jNHlNUTlFN3l2Y1RTNUNaS1NOcUtjZi84WnhXaE1UZVYvUjdrQnV6dXFN?=
 =?utf-8?B?RE9GR3dOZzd6bzJLLzBXcjRLTzgzK240T2RzaVVZL2djL3hrZUIyS1k0b1Fn?=
 =?utf-8?B?eXBMbHpXQU04bUN0Q1IxS3hLWW5LUG1NYTBKSy8wUXE4SFo3cVV2ZHE4V2ZI?=
 =?utf-8?B?L0NYV3NPeUhuMjJiZDVGZ2xhSjU2bjF0OERVMWdPR01iOFg3MXYvT3paM0FB?=
 =?utf-8?B?aldwaXUvc0FINFdjSUFHUHFnU3VFTE1zV2RQMVpuWUdKc21UL2xoUkMyRFc0?=
 =?utf-8?B?YUFQbWxaT01CTExRQTVuM3F0Zng2T1Fnd2YzeHoyR0lrZWJaTW1ZYk5xNmR1?=
 =?utf-8?B?TGtZemN0UXV0UUd6dk5TcDRTVzRDZnR4ZDVTWTNUWFd5VzlJVFBxVG16bzlH?=
 =?utf-8?B?ZCs5ajBvRVZMdUprdUdvcXRZbklVZ2V1NjBDb0U5V2t3aTZiaEhkeXZ4Ukl4?=
 =?utf-8?B?M09abmw0d0FweDU3dzZMM3dXNXBiVHEwN2Y5SWNINW85RndQWXRXSitMaHZH?=
 =?utf-8?B?NVZscGE0d2VGbFJmd2RQc2EwbHZpQ2g2T29nREs0RHVRenBRUkhxVnhGSDJT?=
 =?utf-8?B?TWFuN0NtM044RnpSemYwTFYxdW53OThuMTZjR2t6NU8vNUhkY1dXQmV2bXFN?=
 =?utf-8?B?VUNZek5nVExSSHkrVGdyWkJmS256SytDZVdpZzlHaVZKWHBJT3FxVmFZWXlE?=
 =?utf-8?B?aTZXZTBxdEo3T0swWWxjaVMrZStIRFNzL3d2bkRTK1Z4elBIR0VkaUx4QTcw?=
 =?utf-8?B?eFQwd3owK1V5UlRHdm9UMmk3VUxOdzZNaGNuVWtyYnd1WXF1QVVoc0YveGJr?=
 =?utf-8?B?UHBNYmRSQ0JZTG40Q2FMZStVQkUyMGVXMEUvaUd5a0pkQnd1REpPQUFBNXJs?=
 =?utf-8?B?Y2hZNmQwWGx5RklXZmQxNFB5SGJzZzhISGVKQkEvMHNiNm5GZG81VTRLQzRP?=
 =?utf-8?B?ZHRpcHFJaWRwUG5CMDRaamIrNm5xclNKd0tnQmtITEw2OU5ZcWdWYW0vb2sx?=
 =?utf-8?B?MXpFSTZJbVptVXlXaEU3OFNCSkZMMUp4OEVROHNxWDJvb1VWYjMxeWF2TVV5?=
 =?utf-8?B?STJ5aUVHWU1xZ3B3b0RRZlp1UWdNTko0bU5CSTdHdWFwSUNHd25wdjUrNTl1?=
 =?utf-8?B?dmtvRHZnNEpKd3VueEwzNC9KMVpyR1RvanIvV2YzUGFSYkFHbzkrQk9OaWYv?=
 =?utf-8?Q?qfASyiNYK5aJLAewQs+sa0LYYleRJZwv6vC/Aul?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f064ac2f-2b04-4e15-00e4-08d96b1abf03
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2021 18:28:06.5193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6ZK3lcEoPfv7dolq6+Z+VyOSwFryftnHJJmjR862ysP8cjwoEw0rpTBpMLHC3aMvL0dTPkN4aOBPwonALMrZ8pDMLssXi2Z8fKsBB/SQck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1611
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGVsbG8gT2xpdmVyLA0KIA0KPiA+IEJ1dCBJIGZvdW5kIHRoYXQgdGhpcyBwYXRjaCBkZWNyZWFz
ZXMgdGhlIHBlcmZvcm1hbmNlIG9mIElTTy1UUCBTdGFjay4NCj4gDQo+IEFGQUlDUyB0aGUgcGVy
Zm9ybWFuY2UgKGFrYSB0aHJvdWdocHV0KSBvZiB0aGUgSVNPLVRQIHN0YWNrIGlzIG5vdA0KPiB0
b3VjaGVkIGJ1dCB0aGUgZ3JhY2UgcGVyaW9kIHdoZW4gY2xvc2luZyBhbiBJU08tVFAgc29ja2V0
IGlzIGluY3JlYXNlZC4NCj4gDQo+ID4gSSBoYXZlIGNyZWF0ZWQgdHdvIHRlc3RzY3JpcHRzIHdo
ZXJlIG9uZSBwbGF5cyB0aGUgc2VydmVyIGFuZCB0aGUNCj4gPiBvdGhlciBvbmUgaXMgcnVubmlu
ZyBhIHRlc3QgYW5kIG1lYXN1cmluZyB0aGUgdGltZSBob3cgbG9uZw0KPiA+IGl0IHRha2VzIHRv
IHRyYW5zZmVyIGFuIElTTy1UUCBGcmFtZSB3aXRoIDEwMDAgQnl0ZXMuDQo+ID4NCj4gPiBXaXRo
b3V0IHRoaXMgcGF0Y2ggaXQgdGFrZXMgYWJvdXQgMzVtcyB0byB0cmFuc2ZlciB0aGUgZnJhbWUs
DQo+ID4gd2l0aCB0aGlzIHBhdGNoIGl0IHRha2VzIGFib3V0IDE0NW1zIG92ZXIgdmNhbjAuDQo+
ID4NCj4gPiBBbnlvbmUgYW4gaWRlYSBvbiB0aGlzPw0KPiANCj4gWWVzLiBXZSBub3cgc3luY3Jv
bml6ZSB0aGUgcmVtb3ZhbCBvZiBkYXRhIHN0cnVjdHVyZXMgdG8gcHJldmVudCBhDQo+IHVzZS1h
ZnRlci1mcmVlIGlzc3VlIGF0IHNvY2tldCBjbG9zZSB0aW1lLg0KPiANCj4gVGhlIHN5bmNocm9u
aXplX3JjdSgpIGNhbGwgZG9lcyB0aGlzIGpvYiBhdCBzcGVjaWZpYyB0aW1lcyB3aGljaCBsZWFk
cw0KPiB0byB0aGlzIGV4dGVuZGVkIHRpbWUgdGhlIGNsb3NlKCkgc3lzY2FsbCBuZWVkcyB0byBw
ZXJmb3JtLg0KDQp1bmRlcnN0b29kDQoNCj4gDQo+ID4gYnJpbmcgdXAgYSB2Y2FuMCBpbnRlcmZh
Y2Ugd2l0aDoNCj4gPiBzdWRvIG1vZHByb2JlIHZjYW4NCj4gPiBzdWRvIGlwIGxpbmsgYWRkIGRl
diB2Y2FuMCB0eXBlIHZjYW4NCj4gPiBzdWRvIGlmY29uZmlnIHZjYW4wIHVwDQo+ID4NCj4gPiBo
ZXJlIGFyZSB0aGUgc2NyaXB0czoNCj4gPiAtLS0gaXNvdHBfc2VydmVyLnNoIC0tLQ0KPiA+ICMh
L2Jpbi9iYXNoDQo+ID4gaWZhY2U9dmNhbjANCj4gPiBlY2hvICJXYWl0IGZvciBNZXNzYWdlcyBv
biAkaWZhY2UiDQo+ID4gd2hpbGUgdHJ1ZTsgZG8NCj4gPiAgICAgIGV4ZWMgMzwgPChpc290cHJl
Y3YgLXMgNzdFIC1kIDcxNCAtYiBGIC1wIEFBOkFBICRpZmFjZSkNCj4gPiAgICAgIHJ4cGlkPSQh
DQo+ID4gICAgICB3YWl0ICRyeHBpZA0KPiA+ICAgICAgb3V0cHV0PSQoY2F0IDwmMykNCj4gPiAg
ICAgIGVjaG8gIjdGIDAxIDExIiB8IGlzb3Rwc2VuZCAtcyA3N0UgLWQgNzE0IC1wIEFBOkFBIC1M
IDE2Ojg6MCAkaWZhY2UNCj4gPiBkb25lDQo+IA0KPiBJTU8gdGhlIGlzc3VlIGFyaXNlcyB3aXRo
IHRoZSB1c2Ugb2YgaXNvdHBzZW5kIGFuZCBpc290cHJlY3YuDQo+IFRoZXNlIHRvb2xzIGFyZSBp
bnRlbmRlZCB0byBnZXQgYSBoYW5kcy1vbiBpbXByZXNzaW9uIGhvdyB0aGUgaXNvdHANCj4gc3Rh
Y2sgd29ya3MuDQo+IA0KPiBUaGlzIGtpbmQgb2YgdXNlIGluIGEgc2NyaXB0IGxlYWRzIHRvIHRo
ZSBjcmVhdGlvbiBhbmQgKG5vdyBkZWxheWVkKQ0KPiAqcmVtb3ZhbCogb2YgaXNvdHAgc29ja2V0
cyBmb3IgKmVhY2gqIHNpbmdsZSBQRFUgdHJhbnNmZXIuDQoNCk1heWJlIEkgYW0gd3JvbmcgYnV0
IEkgc2VlIHNvbWV0aGluZyBkaWZmZXJlbnQuDQplLmcuIHdpdGhvdXQgdGhpcyBwYXRjaDoNCiAo
MDAwLjAwMDI0MCkgIGNhbmZkMCAgNzE0ICAgWzhdICAyQiAwMSAwMSAwMSAwMSAwMSAwMSAwMQ0K
ICgwMDAuMDAwMjYxKSAgY2FuZmQwICA3N0UgICBbOF0gIDMwIDBGIDAwIEFBIEFBIEFBIEFBIEFB
DQogKDAwMC4wMDA0OTYpICBjYW5mZDAgIDcxNCAgIFs4XSAgMkMgMDEgMDEgMDEgMDEgMDEgMDEg
MDENCg0KYW5kIHdpdGggdGhpcyBwYXRjaDoNCiAoMDAwLjAwMDQxNCkgIGNhbmZkMCAgNzE0ICAg
WzhdICAyQiAwMSAwMSAwMSAwMSAwMSAwMSAwMQ0KICgwMDAuMDAwMjYyKSAgY2FuZmQwICA3N0Ug
ICBbOF0gIDMwIDBGIDAwIEFBIEFBIEFBIEFBIEFBDQogKDAwMC4wMDE1MzYpICBjYW5mZDAgIDcx
NCAgIFs4XSAgMkMgMDEgMDEgMDEgMDEgMDEgMDEgMDENCg0KU28gd2l0aGluIG9uZSBQRFUgdHJh
bnNmZXIgdGhlIGZpcnN0IENvbnNlY3V0aXZlIEZyYW1lIGFmdGVyDQphIEZsb3cgQ29udHJvbCBp
cyB0YWtpbmcgYWJvdXQgMTBtcyBsb25nZXIgKHRoZSBjb25zZWN1dGl2ZQ0KZnJhbWVzIGFyZSBz
ZW50IGJ5IElTTy1UUCBTdGFjayBoZXJlLCBUZXN0ZWQgYWdhaW5zdCBhICJyZWFsIiBFQ1UuKQ0K
U28gaWYgSSB0cmFuc2ZlciBhIGxvdCBvZiBkYXRhIHdpdGhpbiBvbmUgUERVLA0KdGhlIG1vcmUg
RmxvdyBDb250cm9scyBJIGhhdmUgYW5kIHRoZSBtb3JlICJkZWxheXMiIGFmdGVyIGVhY2ggRkMs
DQphbmQgdGhpcyBpbmNyZWFzZXMgdGhlIHRpbWUgZm9yIHRoZSB3aG9sZSBQRFUuKQ0KDQo+IA0K
PiBUaGUgYmV0dGVyIGFwcHJvYWNoIHdvdWxkIGJlIHRvIHdyaXRlIGEgQyBwcm9ncmFtIHRoYXQg
Y3JlYXRlcyBPTkUNCj4gc29ja2V0IGFuZCBzaW1wbHkgcmVhZCgpIGZyb20gdGhhdCBzb2NrZXQg
YW5kIHdyaXRlKCkgdG8gaXQuDQo+IA0KPiBUaGlzIHNob3VsZCBib29zdCB5b3VyIHBlcmZvcm1h
bmNlIGV2ZW4gbW9yZS4NCj4gDQpTdXJlLCBJIGRvIGhhdmUgdGhpcy4gVGhlc2UgdHdvIHNjcmlw
dHMgYXJlIG9ubHkgbGV0cyBzYXkgYSAicmVwcm9kdWNlciIuDQoNCg0KPiBJcyB0aGUgcGVyZm9y
bWFuY2UgYSByZWFsIHJlcXVpcmVtZW50IGZvciB5b3VyIHVzZS1jYXNlIG9yIGlzIHRoaXMNCj4g
ZGVjcmVhc2VkIHNvY2tldCBjbG9zZSByYXRlIGEgZmluZGluZyB3aGljaCBkb2VzIG5vdCByZWFs
bHkgYWZmZWN0IHlvdXINCj4gd29yaz8NCg0KV2UgaGF2ZSBhIGFwcGxpY2F0aW9uIGhlcmUgd2hp
Y2ggZmxhc2hlcyBhIEVDVSBvdmVyIENBTiBhY2NvcmRpbmcgdG8gVlc4MDEyNi4NClNvIHRyYW5z
ZmVycmluZyB0aGUgZGF0YSBhcyBxdWljayBhcyBwb3NzaWJsZSB0byB0aGUgRUNVIGlzIGEgdXNl
LWNhc2UuDQoNClN2ZW4NCg0K
