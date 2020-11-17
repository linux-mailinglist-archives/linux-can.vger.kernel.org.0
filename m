Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA012B660D
	for <lists+linux-can@lfdr.de>; Tue, 17 Nov 2020 15:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgKQOAh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Nov 2020 09:00:37 -0500
Received: from mail-eopbgr70102.outbound.protection.outlook.com ([40.107.7.102]:47963
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730074AbgKQNOj (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 17 Nov 2020 08:14:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIVcg3y/YVmNzvCZNUMuJxC1ek545kJkWWHDQ7dOw+cihaS0toczZ6L2GZCO7ZHH20c7n+fHxr5sO9mzuGymv745zv2zud5EB35MMZg1iNewSYOhdlwakaYwTC/2OzX4C1UC4Lzg9zmaS/vnMhk/fceZSKZz9Mwpuf9p3U2C4MymT2qvOkaZ5No1O5DxIO2iAiJhdrrEONlccw8iCxoNq761nz86PBBHb5zqYoWZPz+tifQaNegv4hN8zUY3EwmtCAh0h5Ph4qcWHjau2fq7G8OrYc8895ORtz8SO2Z9uBlFSGwYBQ94dqJtE6P/Y3PwyBuNWMc7w9/lMv+IVQkKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sABNTY3qJhePIoSNll0bSdzCAtC81Yt3Vcn1bT55ypU=;
 b=nRkOJnBHoxVjePV6nqKoVvKbMe0JgvT4j7juSSMB0PEQEdeWFPg2W06Fqb80d4PeSoCnjEBGV69ynE4zsPqMiBvLTDbPBtYWgtNSjzSf3PnAxaOCXFsweX8LyC7BJUbDkVGqXPD6RwaWG0LJX7zSr0T0EbxspMyb5KzvBc23MH9rupxYshcQbHypHGCYGJuqgj1mWzKzt+fk3KM6dyGBTFATxr5p2zbgt2stbygEPq+LCRlU7P1gXAEQbSJv8GLZTulWP5WuMUxdR6RXM3gMzN3p/HQHCeDiqDq+5Uz4AArrKarCAYljq5+Y32cVCEw/VJKzqJq3lCt+ueuaM613cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sABNTY3qJhePIoSNll0bSdzCAtC81Yt3Vcn1bT55ypU=;
 b=gPe7Upv7QzTVf4VrCpu2fxmzJ8ltz0lXMuUcLXrhsiG+28ueU1Iqr8aNpBokGnunTmeqgYTnb1libw90Z4jwbtyDGpx4kgqLVslw7xssMjrITlRG7CstFagDBXiC+rhQ46LacR5hzWjkCNrOk0SvAQRd0gdU4noGFMFN5U5uncU=
Received: from AM4PR0302MB2754.eurprd03.prod.outlook.com
 (2603:10a6:200:8e::10) by AM0PR03MB6244.eurprd03.prod.outlook.com
 (2603:10a6:20b:158::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 13:14:35 +0000
Received: from AM4PR0302MB2754.eurprd03.prod.outlook.com
 ([fe80::2497:a954:4f67:a8ed]) by AM4PR0302MB2754.eurprd03.prod.outlook.com
 ([fe80::2497:a954:4f67:a8ed%11]) with mapi id 15.20.3564.028; Tue, 17 Nov
 2020 13:14:35 +0000
From:   =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <Stefan.Maetje@esd.eu>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
Subject: Re: [PATCH 1/1] can: drivers: add len8_dlc support for esd_usb2 CAN
 adapter
Thread-Topic: [PATCH 1/1] can: drivers: add len8_dlc support for esd_usb2 CAN
 adapter
Thread-Index: AQHWvEiMFwZvp6EI2U+2g4zdSsoCuanL9UKAgABZWwA=
Date:   Tue, 17 Nov 2020 13:14:35 +0000
Message-ID: <762c024cc1ffd2427ad9a948fc1bababf0981139.camel@esd.eu>
References: <20201116184430.25462-1-stefan.maetje@esd.eu>
         <20201116184430.25462-2-stefan.maetje@esd.eu>
         <4579b52c-6046-12cb-1d46-e4357c690f4f@pengutronix.de>
In-Reply-To: <4579b52c-6046-12cb-1d46-e4357c690f4f@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=esd.eu;
x-originating-ip: [217.86.141.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 559a0c47-f891-488a-7bbc-08d88afabac5
x-ms-traffictypediagnostic: AM0PR03MB6244:
x-microsoft-antispam-prvs: <AM0PR03MB6244F949FD05ABC65983C48881E20@AM0PR03MB6244.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ymy/ZFPS/VaYIgWBszI1TQ28mh95zrH7jJqRsPc0CLmt+d1a2qoJk+Hw4+CNGJ25t6HGY5TjTRfB64Wsbic5TYWi2V1Z1MzDOfef4J/eoR3++AhWdfhkbSJu36saMIAYKHzvLPntNVQJiqA7JvkYru5MBHsCJFHtRAUGhMedNy6tscatRjOKVMYKMLGkJSgFA0WGnx04q5SZXR6PiMjf8elgKLZd9jgkZ1ki2zXEKuyqKXo2v846Hff0C57TtTu8/OXjzS/QAbyStGyoYxx68XdexynrXReBQ0Ft2QZBrYc58R0whBNFYJofHwhkGKuADfV2i1iyI6tcIoEOxb94fSwFNUsbWwOGB69vBdqrf8oaKg9wMs+N904EmI3IEU0MO/qlKJqXSaOh3vTCSDFhQcCCUL4QO35/0c0kFPmPhfyarLu04Q7c3AdVrTcvLwK4uXBb2twnO07H7l2O23p+QGMWNiCDkBoXWFArSqEp2h0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0302MB2754.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(64756008)(66556008)(66446008)(66946007)(66476007)(71200400001)(53546011)(85202003)(508600001)(8676002)(8936002)(26005)(186003)(36756003)(6506007)(110136005)(6512007)(966005)(76116006)(86362001)(83080400002)(6486002)(85182001)(2616005)(2906002)(5660300002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: aPEi8YWlmjvg//hVVby5WLO7i8Dad73EyCLOq9ZIzqdeMr7B1Q1XqdtBYoXvVK/h5rKvMTcNVgY5l3fmLcuspjARCAZdgAx6G/2gwsLGLRaK3+phUi67VOv5VbS+lDquAlFQvhJMY1PM/yQuM45aPf0mR19L33JrhRpPhxF65KMloHQhLRonTdP+x9CXYN6RXS6b70semmeDR0b7aecEzh0XG27C+MrvG54T6hbH7OisOpBH2ZgkGWmipA5OGFChLRFsHBUpmiJo7a1uCx0bF3eV8HGzOUeoKcn71YUz0f8K58H7pMN97i+KAyJCQv2YrcZnvnXMs8QYW6m5SQs0XWs+pRen4WyM7OHvUVFLEbBdbpEY0JBeHhyR/Mo52LohHRNZZ6EJNA2LU3kQDSvP8aqX73H9m9wOnDkl7aJP6jMHZmPR+F782SYCNNMuV2Inmi+tzFuWiEUmAYWh/ggF/qAk7sOWFt6rE/2fOmodDXEomnEkhEGKEk0wc8Icx7vjvaFXCaCswDUpakBmaR/f+74PqedCW6IiBtedK1icKci0wtB9MTYkDncT84bLMcj9hCn/zryR8BDINMxcLeBvxIWvfrm3bUfqibV2WlT1chjaMd//kBL8wSSpr6+ApgcInE0rdM98HVL/QI5NnVNX/AzNJhl889b5YgezZDPE4ES5Xr5SfCZn6sGTKe60oqeWi5Ad2JJbjmmQBIMHPRfU17UvAH4g58RZQ2WqH+N5RqDDORMEIOhMqySuu3ficnadyhqCO+KQtBHhk7IDUPoX6A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <40A02242B48C0C448B6083C67BADA56A@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0302MB2754.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559a0c47-f891-488a-7bbc-08d88afabac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 13:14:35.1367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBsM6KVoIh1zktW85GmtbuB7C7/mhDPg+qIpPMeMt37uSHhlkEhJsXkq+kNzdGil9YoOGgUGhWFR12PjF3ZC4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6244
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

QW0gRGllbnN0YWcsIGRlbiAxNy4xMS4yMDIwLCAwODo1NCArMDEwMCBzY2hyaWViIE1hcmMgS2xl
aW5lLUJ1ZGRlOg0KPiBPbiAxMS8xNi8yMCA3OjQ0IFBNLCBTdGVmYW4gTcOkdGplIHdyb3RlOg0K
PiA+IEZyb206IFN0ZWZhbiBNw6R0amUgPFN0ZWZhbi5NYWV0amVAZXNkLmV1Pg0KPiA+IA0KPiA+
IFN1cHBvcnQgdGhlIENsYXNzaWNhbCBDQU4gcmF3IERMQyBmdW5jdGlvbmFsaXR5IHRvIHNlbmQg
YW5kIHJlY2VpdmUgRExDDQo+ID4gdmFsdWVzDQo+ID4gZnJvbSA5IC4uIDE1IGZvciB0aGUgQ2xh
c3NpY2FsIENBTiBjYXBhYmxlIENBTiBuZXR3b3JrIGRyaXZlciBlc2RfdXNiIHRoYXQNCj4gPiBz
dXBwb3J0cyB0aGUgZXNkIENBTi1VU0IvMiBhbmQgQ0FOLVVTQi9NaWNybyBkZXZpY2VzOg0KPiA+
IA0KPiA+IC0gZXNkX3VzYjINCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gTcOkdGpl
IDxzdGVmYW4ubWFldGplQGVzZC5ldT4NCj4gPiBUZXN0ZWQtYnk6IFN0ZWZhbiBNw6R0amUgPHN0
ZWZhbi5tYWV0amVAZXNkLmV1Pg0KPiANCj4gSSd2ZSByZS13cmFwcGVkIHNvbWUgbG9uZyBsaW5l
cyBhbmQgYXBwbGllZCB0byBsaW51eC1jYW4tbmV4dC90ZXN0aW5nLg0KPiANCj4gVGhhbmtzLA0K
PiBNYXJjDQo+IA0KVGhhbmsgeW91IGZvciByZWZvcm1hdHRpbmcgdGhlIHBhdGNoIGFuZCBpbnRl
Z3JhdGlvbiB0byB0aGUgdXBzdHJlYW0gcGF0aC4NCg0KQmVzdCByZWdhcmRzLA0KICAgIFN0ZWZh
bg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCkRpcGwuLUluZy4gU3RlZmFuIE3DpHRqZQ0KU3lzdGVtIERl
c2lnbg0KDQplc2QgZWxlY3Ryb25pY3MgZ21iaA0KVmFocmVud2FsZGVyIFN0ci4gMjA3IC0gMzAx
NjUgSGFubm92ZXIgLSBHRVJNQU5ZDQpQaG9uZTogKzQ5LTUxMS0zNzI5OC0xNDYgLSBGYXg6ICs0
OS01MTEtMzcyOTgtNjgNCkVtYWlsOiBTdGVmYW4uTWFldGplQGVzZC5ldQ0KUGxlYXNlIHZpc2l0
IG91ciBob21lcGFnZSBodHRwczovL3d3dy5lc2QuZXUNClF1YWxpdHkgUHJvZHVjdHMgLSBNYWRl
IGluIEdlcm1hbnkNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KR2VzY2jDpGZ0c2bDvGhyZXI6IEtsYXVzIERl
dGVyaW5nDQpBbXRzZ2VyaWNodCBIYW5ub3ZlciBIUkIgNTEzNzMgLSBWQVQtSUQgREUgMTE1Njcy
ODMyDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0K
