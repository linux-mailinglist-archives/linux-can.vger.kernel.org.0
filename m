Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8299F2D05F3
	for <lists+linux-can@lfdr.de>; Sun,  6 Dec 2020 17:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgLFQ3b (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 6 Dec 2020 11:29:31 -0500
Received: from mail-am6eur05on2103.outbound.protection.outlook.com ([40.107.22.103]:7593
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726762AbgLFQ3a (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sun, 6 Dec 2020 11:29:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcVhGKOe8HXnGollsXusUA/KA2Wae9ouOdp96Z17yplHbZfby3VjTBcjW1CcCTkdW9QEWD1dMoWBdf3M/DOAgBWAaUyPSf2tbEs9zprgvelAHohZPhNc40o7puPervY/JdMgBgmrqsX/x3M1PmZ4Q4tJLHWV2KOVT/bcCbzzKHZJtmDaq3u5PRvOqc+ZRfAWLpOU2JhsnbWxZBmNuu0exM963x6CYpam1z0eGuye+w0HFjH/DdITNMw1wspTIDf1EIMd3wQ4r4X8N9YZ45XWhMvSVyKd3ywa7mozIEt7O/eTu5YU6Vx/vj1laFNj6MILvsyEnsewYnylhDFy5mjIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiVL6FqF+Jo75vPonh1Skrjt+IKl0HZ8TtIktjRHOgg=;
 b=L2kjwugVYqMeFPUYIp4Qrl3KEUNwlsVXSPnj142K+A2jm5/PhA6OEfoB/m/Bs1f5dgZAtHGPrZhGOyuC4TZadwBAhypKSQHS6qh+WZxlsYUyccCp1AwHTr38evJfeOJ7FFzKFq4/KtS7hnTDpynxSTdnByuP7T0ZgzhVmCggFN3HCaqVyoqB8u1JIki8oE35WCa7ja+ysBwCPUXoFer8i5viEWTqcrdOQ7xxVaWPI+WePKLEreip06tMgab0YysH+CTog7hC27fVmB7PbtAmmWyQ3eA0wr2lhjc6vBd0VKDGpX6woCJfC5AgFANIlsDziHUvsGQZ/cd7vh9s393b5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiVL6FqF+Jo75vPonh1Skrjt+IKl0HZ8TtIktjRHOgg=;
 b=G+93y1wSp89JSHvPlJuoYTYkTe1QX13rzTgQdS/855Ia8ymun5RYFWWCah0+bwSBExP2QPZIhjhB1TTq1bjSASM8IPUlg3e8ZitKGXTCArVp25u5TCM61+euca3mjxRtAJ3QISxFM3ey0lM+V9rOSOxdBAZFNZa4jiuphqZnAv4=
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:12d::21)
 by DBAP190MB0856.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Sun, 6 Dec
 2020 16:28:40 +0000
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::14dd:59d7:acaf:be4a]) by DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::14dd:59d7:acaf:be4a%4]) with mapi id 15.20.3632.023; Sun, 6 Dec 2020
 16:28:40 +0000
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
To:     Patrick Menschel <menschel.p@posteo.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: AW: mcp251xfd No Oscillator (clock) defined
Thread-Topic: mcp251xfd No Oscillator (clock) defined
Thread-Index: AdbLuKAjW6Ey/8Z7T1qzpJx8c3rFuwAAn6qAAAMOkYAABiTcAAADGfBg
Date:   Sun, 6 Dec 2020 16:28:40 +0000
Message-ID: <DB8P190MB06340912153C0DE9B67A684DD9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
References: <DB8P190MB0634231494D3D788E87DCE54D9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <611813e9-943a-33be-4e9b-5cb1397ac5d9@pengutronix.de>
 <DB8P190MB0634B2D31F9222E9053CC2DFD9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <fc13f0e7-d672-d62c-a51c-c7bccabc5f4e@posteo.de>
In-Reply-To: <fc13f0e7-d672-d62c-a51c-c7bccabc5f4e@posteo.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: posteo.de; dkim=none (message not signed)
 header.d=none;posteo.de; dmarc=none action=none
 header.from=schleissheimer.de;
x-originating-ip: [62.153.209.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2e8e06e-5cd9-4c9d-de19-08d89a03fd92
x-ms-traffictypediagnostic: DBAP190MB0856:
x-microsoft-antispam-prvs: <DBAP190MB085647079F2100C1D5C0B991D9CF0@DBAP190MB0856.EURP190.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nEKt31FjLjruk/xinyPedXw31R3erxzztnEiHUoPpCLLSKw7mYe1aXmAFLylbUhMAYmqDsNzkhqrp+p8kF11xa3siXue7jSetxH+IYR9rDvYAPHyn/5EmK46ROkzCsOdJwgGqloKIwQhlJML+yq0zozAyFgw5C4XcDwF9ZFVDSSLRpRpvTebyOlkXm2h6jhpWv9gLSNw58P4U4Z+pfhJOXBzlAFXt4GhOf+6uWVbosfa2oKbeQ4uQ91XQKZaooQbuwVh5p4IpOzok1mSi9vWRADEYC3ZYlK2+s3uoOtavaXLdaY4u9d7ImMeVQdOu+WlkQ2PcVbU43vHnixARK3GMReoOl76mSqMWffiXchbr/cr1NYbmCdGUmOaaf58RO+YZueZ60Gv5ayL5oWFWia5TQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P190MB0634.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(366004)(39830400003)(186003)(316002)(110136005)(71200400001)(55016002)(7696005)(83380400001)(9686003)(6506007)(66574015)(33656002)(26005)(2906002)(66446008)(66556008)(66946007)(64756008)(66476007)(478600001)(76116006)(8676002)(5660300002)(8936002)(86362001)(52536014)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QVdINE4vWi9BR0IvTmV4Z3ErUDlhVW9uUlhEK3BKbDFKcWxTaElPYnhLc0hL?=
 =?utf-8?B?Qk9EMDZ2SHhMaWJPWFVaY2Fad1pwdFZuOEdnQ254MUZvQy9VZHdGWG5YVHZU?=
 =?utf-8?B?SU01b0hFaVpFWFRjdThEVXp0bWxYeFZFWU5QWGt1MkNxL09sTHFCL1FseFBx?=
 =?utf-8?B?eEY3TFJrcGxGeVBxVWxxZVBPWWp4bGI1R3BxL054dHpROFYvMGNDOC9BekNx?=
 =?utf-8?B?VUt5ZHdwb3MxdDRXWjVrMzltekQydVVRa2RnUnJzd2huU1R0ZVZ6SjRQbWlq?=
 =?utf-8?B?VTg2WFU3bWttSXA2SzNVeUkvVGRBT3pXWGlVLy9hVUg1OThkUG03NFNHcEtr?=
 =?utf-8?B?RUFZQ1RiNkdOY2gwWDVIU0tMSkljbE9wclU2WFVBL09NVnZ3MExuS0JMR0hI?=
 =?utf-8?B?Rk1KQ3dPdDhZOGZHd3hyV0lHUFBoWlBBTklLRkRRVTEyajM2YjdaL0x3VitO?=
 =?utf-8?B?K2FDUUdCTUE4QWZndEdxYi9yTnpreWkwaHAwak10K1YvSGw5V28wQlJFYkFy?=
 =?utf-8?B?RE9xSGZwMkkrTkhidWxVYnBPUGhvUmNqNE52Q202TmFzS2daYVdoT24zNFZO?=
 =?utf-8?B?SDkzMXFNNnpyaXRiazBpaXlpalpGMmxIaFNTQVdJdHowQlh6QzNWNEdVK1ln?=
 =?utf-8?B?S1FNTXU3OWRnQkIyQm16RmdWZGRQZUEvK09pcHZSMEViWm90cFhMKzV2UGRk?=
 =?utf-8?B?a0lpU25OU3lZR0ZoMlFPTGJGZTQ4SXdtYm80Z0pEYlBTYjkxdWZkejZaNkZE?=
 =?utf-8?B?ZHVuTDlNbUtJQWx2N09vK1ZsNm1VWTlPekFIRG13MENjZFIzSkJPYjFjQ0tH?=
 =?utf-8?B?cnpGQjhxeDdSZTlMR2pwR2ZtTkdHZS9wSUtKSTkyQm9MNTAxRlNlVFhEcGxO?=
 =?utf-8?B?RHU5RlhnODRpaEhYVFo5UHZFZTZXZDh0eUplZE92OUFiS3lWWThwamlGRW1z?=
 =?utf-8?B?TWdaY2xIdng4ZldScWFTWWFJSTRPd1EySjhXclJKZ3RjQTJLaXVucmhLeFlq?=
 =?utf-8?B?SGRiRWlzT0d4T1Z0d1B0d2tpU2t2V3BrbjN2RmN0b0E2RkJxZHl4MVAxaXpj?=
 =?utf-8?B?MmZSMHl5dVM2SnorZ0dlZDJGL09xb1hjL0tsRU5iZlAxWHNlNHlVOUhWUGdw?=
 =?utf-8?B?cENWc29iNUVJTmV0TmdZYWxIQ1Nwcitzb2RNVTRHOTVWUkF6V3ptdUFhL29n?=
 =?utf-8?B?RkhHelhzalY4aGlVM0kvWFFPanBKZnpBSE5yN1ROY3QvWUEzY1dtNzQzVjdw?=
 =?utf-8?B?VDNHa0t6MHFwWEF5c0VKdFErdmdRODROaEFidWJjSC95MFM4L0dMVTMrUXNu?=
 =?utf-8?Q?KAytuiw4ii69M=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e8e06e-5cd9-4c9d-de19-08d89a03fd92
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2020 16:28:40.1261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7vazDE2GCyal8Fud0XFc5YTRaaRVLhqwOVHwYCri8lBzbW+Pbd3rzwlsNVjssg7W2R0t5IT8ESWgMl79oibJIflN81soFsI9jdaSz7J9tM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0856
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBWb246IFBhdHJpY2sgTWVuc2NoZWwgPG1lbnNjaGVsLnBAcG9zdGVvLmRlPg0KPiBHZXNlbmRl
dDogU29ubnRhZywgNi4gRGV6ZW1iZXIgMjAyMCAxNTo1Ng0KPiBBbjogU3ZlbiBTY2h1Y2htYW5u
IDxzY2h1Y2htYW5uQHNjaGxlaXNzaGVpbWVyLmRlPjsgbGludXgtY2FuQHZnZXIua2VybmVsLm9y
Zw0KPiBCZXRyZWZmOiBSZTogbWNwMjUxeGZkIE5vIE9zY2lsbGF0b3IgKGNsb2NrKSBkZWZpbmVk
DQo+IA0KPiA+IGR0b3ZlcmxheT1zcGkxLTFjcyxjczBfcGluPTE4DQo+IEhvd2V2ZXIgdGhpcyBs
aW5lIGlzIG5vdCBiZSBuZWNlc3NhcnkuDQo+IEl0IHNldHMgdXAgc3BpZGV2IGZvciBzcGkxLg0K
PiBodHRwczovL2dpdGh1Yi5jb20vcmFzcGJlcnJ5cGkvbGludXgvYmxvYi9ycGktNS40LnkvYXJj
aC9hcm0vYm9vdC9kdHMvb3ZlcmxheXMvc3BpMS0xY3Mtb3ZlcmxheS5kdHMjTDM0DQo+IA0KPiBU
aGUgbmV4dCBvdmVybGF5IHJlbW92ZXMgc3BpZGV2IGFnYWluLg0KPiBodHRwczovL2dpdGh1Yi5j
b20vcmFzcGJlcnJ5cGkvbGludXgvYmxvYi9ycGktNS40LnkvYXJjaC9hcm0vYm9vdC9kdHMvb3Zl
cmxheXMvbWNwMjUxeGZkLW92ZXJsYXkuZHRzI0wzNQ0KPiANClRoYW5rcyBmb3IgcG9pbnRpbmcg
b3V0LCBidXQgaWYgSSBkbyBub3QgaGF2ZSB0aGlzIGxpbmUgSSBnZXQ6DQpbICAgIDQuODk3NzAx
XSBtY3AyNTF4ZmQgc3BpMS4wOiBOYXRpdmUgQ1MgaXMgbm90IHN1cHBvcnRlZCAtIHBsZWFzZSBj
b25maWd1cmUgY3MtZ3BpbyBpbiBkZXZpY2UtdHJlZQ0KWyAgICA0Ljg5NzcyMF0gc3BpX21hc3Rl
ciBzcGkxOiB3aWxsIHJ1biBtZXNzYWdlIHB1bXAgd2l0aCByZWFsdGltZSBwcmlvcml0eQ0KWyAg
ICA0LjkzNjU5MF0gbWNwMjUxeGZkIHNwaTEuMCAodW5uYW1lZCBuZXRfZGV2aWNlKSAodW5pbml0
aWFsaXplZCk6IEZhaWxlZCB0byBkZXRlY3QgTUNQMjUxeEZEIChvc2M9MHgwMDAwMDAwMCkuDQoN
ClNvIEkgdGhvdWdodCBJIGhhdmUgdG8gY29uZmlndXJlIENTIHdpdGggdGhpcz8NCg0KU3Zlbg0K
DQotLQ0KU3ZlbiBTY2h1Y2htYW5uDQpTY2hsZWnDn2hlaW1lciBTb2Z0LSB1bmQNCkhhcmR3YXJl
ZW50d2lja2x1bmcgR21iSA0KQW0gS2Fsa29mZW4gMTANCjYxMjA2IE5pZWRlci1Xw7ZsbHN0YWR0
DQpHRVJNQU5ZDQpQaG9uZTogKzQ5IDYwMzQgOTE0OCA3MTENCkZheDogKzQ5IDYwMzQgOTE0OCA5
MQ0KRW1haWw6IHNjaHVjaG1hbm5Ac2NobGVpc3NoZWltZXIuZGUNCg0KQ291cnQgb2YgUmVnaXN0
cmF0aW9uOiBBbXRzZ2VyaWNodCBGcmllZGJlcmcNClJlZ2lzdHJhdGlvbiBOdW1iZXI6IEhSQiAx
NTgxDQpNYW5hZ2VtZW50IEJvYXJkOg0KSGFucy1Kb2FjaGltIFNjaGxlacOfaGVpbWVyDQpDaHJp
c3RpbmUgU2NobGVpw59oZWltZXINCg==
