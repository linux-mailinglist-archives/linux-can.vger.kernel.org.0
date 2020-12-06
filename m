Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C2E2D04D8
	for <lists+linux-can@lfdr.de>; Sun,  6 Dec 2020 13:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgLFMlR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 6 Dec 2020 07:41:17 -0500
Received: from mail-am6eur05on2136.outbound.protection.outlook.com ([40.107.22.136]:46816
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725767AbgLFMlQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sun, 6 Dec 2020 07:41:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuLV/77Mw4qy1LGsAeTgHT50aCdb2m+J209S5lWdS3hFbQplSjgXuIJZOi9k0PYgChHqg9LFFxWqeBB5WPaVRgOeZjKlywg+rT4Zeqy4YPrsweR/s/ue0m2RzeB7WNpXvzFj9coOxygiDPwiD7X8TKEwFX0y0sfg/9kLZgH9lenZDnZZBVI238JSoI+x6/0oerUXfgViwDHF86ar7y1BT7zt91HmHGM0yL+kwkiTXZ/7MKrSFDkjzCA+iAfTlzsdpzaaoxDRwkxtji53T8IKoJ9hGeVtyDxkzLBThmFj1h/ojI405VVrjMB4YaG9KwqW+uRZ4PIlNIP7aiQ8zwaowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95PUGcwqhq5ZmpkqGgWY2MqZXN/yL4A8Z09e1hST/CA=;
 b=VknVn2l6j6Lp5iH0A+kLCvpc0P4ZioESTkOmBfVucN0JxrABf2bFl+MHXpWyGDUteEj5FItpGijw5isK92Ak+xCo45mMFn1UC4NHPHq/C1usi4nfIQZQB5dVlQpc8i8a2CB8AbvLhp5PMnwycd8FD/aNXvQqrgrWvwYXfqkM1SqeDkTg2BMN5+W7ZnFSFGPQA4SLqvejhHhKGPUXPZco91d+5wupN97O2fLLcqu3Jm08DGlw2S4gpGzW1ETqQBx54pEtFdWa0LctLFLo8NlR/ySuuwhIFAETuMN7WFWvUFIW5gTqOKDHDWi34qapR910/9aur70nrdAw71RjSUHsAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95PUGcwqhq5ZmpkqGgWY2MqZXN/yL4A8Z09e1hST/CA=;
 b=NE6A/tdbZn/NhlllchY0vY2TArm1yuxxANsFevIwS+mYgzIZjHuHbM2s8OIB4ufqFygAz5vhnWyeRzqI4Bk3gaS0zQHqTJh26By5PGKqK+gqmM+GTNBXnehdH1c0Ta7QSiexb892rjdMIMhDrvbDjQgZhQ1GaXdGFIgS2s6XkZo=
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:12d::21)
 by DBAP190MB0822.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Sun, 6 Dec
 2020 12:40:27 +0000
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::14dd:59d7:acaf:be4a]) by DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::14dd:59d7:acaf:be4a%4]) with mapi id 15.20.3632.023; Sun, 6 Dec 2020
 12:40:27 +0000
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: AW: mcp251xfd No Oscillator (clock) defined
Thread-Topic: mcp251xfd No Oscillator (clock) defined
Thread-Index: AdbLuKAjW6Ey/8Z7T1qzpJx8c3rFuwAAn6qAAAMOkYA=
Date:   Sun, 6 Dec 2020 12:40:27 +0000
Message-ID: <DB8P190MB0634B2D31F9222E9053CC2DFD9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
References: <DB8P190MB0634231494D3D788E87DCE54D9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <611813e9-943a-33be-4e9b-5cb1397ac5d9@pengutronix.de>
In-Reply-To: <611813e9-943a-33be-4e9b-5cb1397ac5d9@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=schleissheimer.de;
x-originating-ip: [62.153.209.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19bae584-92cd-4965-15c3-08d899e41c1a
x-ms-traffictypediagnostic: DBAP190MB0822:
x-microsoft-antispam-prvs: <DBAP190MB08224F78D9121CCF87E6EB23D9CF0@DBAP190MB0822.EURP190.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Ru0oABpfpd3Nut1hpp6+MuOlxKt6JC/jaEQSHozAgg2pXS57F8Y0ocFVZZcbzwsb8dsGIsurlHx1lB0w0btduaKZcXenjWbSWQ6sWTmqxsMJUnksT4CTuYMWrEuQJ7yYEZc3o2prmw1TK1YCtH50UbIRr69NodYYPNT4K+WtvmZ48fS8KAYiIBMA3CNK6E0esS+zSW/rdldJIUt7PxF1YHXLtDBWHCQlxWmqL/+2nN+lc/Tp4D4QWoOmawEEr0UOoA1zM9cFSxbWEY9sLszp87KXX0F7Hp0eEJddip7lLc/A+uKuoCmceiP7N/0DTR2CmwxEvgo+9CZN2Ez/x601A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P190MB0634.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(39830400003)(366004)(478600001)(71200400001)(186003)(9686003)(66556008)(2906002)(8936002)(64756008)(66476007)(66946007)(33656002)(7696005)(6916009)(5660300002)(52536014)(66446008)(76116006)(26005)(83380400001)(8676002)(316002)(86362001)(55016002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ck1TMUZ2aEw2REEvWm9xUlZ5djBYaFRpdk9acGprUThIQVBkemdJdERpMnkw?=
 =?utf-8?B?S2JpLzR2Ujgrc2lKY1RxUCtQVDBBMkFnZnFKOHBuSE4rZkJqWmFRY2NFZUtv?=
 =?utf-8?B?WE5DNS9jU0JUdnhQUnljaTlxVmRVZXloTFFvanRTZlBUajBMMk9WZjkvT0F4?=
 =?utf-8?B?d2g3b0lPY0VycXdmUVBPUmQ5L3pYWDNsMzlHWG5iSzE5UWpOTloxbmRVeEVk?=
 =?utf-8?B?RVJWQ3QrVW9wVnpiSkN5b1JIQnVEL1R2K2FCSThFU0t0d09kYkQ3Y3pPRFlh?=
 =?utf-8?B?U1M3clhMNjR0MVRvYmV5N0lBcS9OL1Yzb1hGS211dzB3YWZtNG5yYmpFSjZa?=
 =?utf-8?B?ZCtnajQ1a2xHQXVBUkt1cm9kM1lpNE5ETDlMbnNsa1lISHQ3TkxVWE5LeDg2?=
 =?utf-8?B?NDNpNjYva3drRlRKQ2xiOEhBNS9EOHhiamRhNlFjYVdzbURIY3lSN09qMGVW?=
 =?utf-8?B?MkM3eDREMHlmQVVyU1hCN08yeXYydmViWjJWNjBqOFBGbDFJUXMxTzZDN1hw?=
 =?utf-8?B?L1RsQjVONTRGU1J2bjFzREZDR3dGeFNpM3RNb0lzbkZRYnBaaTdFS2dSVGxq?=
 =?utf-8?B?ZXJrWmMxOFVwSXlWc09DTGNoVGdaZldaOENONUZ6QTRVV29PM2N4Q21YbHhP?=
 =?utf-8?B?ZlJidFZhSG1yc0NUaXNoZHo5aUxNRmZPNGZTVTNoSGZ0SEV1N0crdFFEd2Nz?=
 =?utf-8?B?VXBYbm1nR2xzdVVKSGVMR0V2dUtERGhFc2gzNHJBZ0ExWDA2amtoemxwRTJz?=
 =?utf-8?B?eFduMEw5RkFFd3NwRVIzRHFSbkYrNzdwT3BBQjJ0ZFdPYzVHS2JKMmVpUjFa?=
 =?utf-8?B?dFZLVlFtSWwwOWpCNy90cGowZnhpUlNiZjdadEV6UHM4YU1vNUQrZ3RjSmcr?=
 =?utf-8?B?V3p6N0ZYL2RuNVhsWFd0REVraktibjU3SFM5MERCdXZXZG5URk16dm5PUmNC?=
 =?utf-8?B?eW9BYXBWL2NvVlZJQnFGMFVlNG9CRFFFRmlxeStkUlFNY0RnenQxcGhBRzJO?=
 =?utf-8?B?aGQ0SDBDWklqRWorVDljVUZPVEZrd0pBWDZNcFF0c20zSDRLQ2ZRcE1KNkht?=
 =?utf-8?B?T0Y3WFB1QUl4cUVEb2twUGlhK3JXRkgzUDJMdDNYU3VoSXBHc0U3UmlrTlVY?=
 =?utf-8?B?TEdpSkhIOXZoSWNvQnBJL0NFcDVzL3lIWmprQk5jTkZWQ0RYaDVwUllBL0Rr?=
 =?utf-8?B?L3JoRXFjY0ZoeEFvbVRtQW9ybVlOWGlhdnIwNEVMbTJqSGRRTXlvRHdXanJZ?=
 =?utf-8?B?dzZNTTRUVmY1RUYyVlBjeDQwZmF3L0lsbWxjQnJpZHJERTBTLzArMHUveENZ?=
 =?utf-8?Q?kqUzRB0tZUdYs=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bae584-92cd-4965-15c3-08d899e41c1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2020 12:40:27.5472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kG/K7wZNq8c4h/5yHPMiUJnwf4+5BzPSey2BM3RmZ7PdmL+IMljVwSS964JJHOr/2pIBzuhyrig/2Hz6CmQeBskpYRbCT7I0gMUOlmCDDUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0822
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiAtLS0tLVVyc3Byw7xuZ2xpY2hlIE5hY2hyaWNodC0tLS0tDQo+IFZvbjogTWFyYyBLbGVpbmUt
QnVkZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gR2VzZW5kZXQ6IFNvbm50YWcsIDYuIERlemVt
YmVyIDIwMjAgMTE6MzMNCj4gQmV0dGVyIGFkZCB0aGUgb3ZlcmxheXMgc3RhdGljYWxseSBpbiB0
aGUgYm9vdGxvYWRlciB2aWEgY29uZmlnLnR4dDoNCj4gDQo+IHwgZHRvdmVybGF5PW1jcDI1MXhm
ZCxzcGkwLTAsaW50ZXJydXB0PTE4DQoNClRoaXMgZGlkIHRoZSB0cmljaywgdGhhbmtzIGEgbG90
Lg0KSSBtaXhlZCB1cCB0aGUgaW50ZXJydXB0cywgc28gaGVyZSBpcyB0aGUgY29tcGxldGUgc2V0
dXAgZnJvbSBjb25maWcudHh0DQoNCmR0b3ZlcmxheT1tY3AyNTF4ZmQsc3BpMC0wLGludGVycnVw
dD0yNQ0KZHRvdmVybGF5PXNwaTEtMWNzLGNzMF9waW49MTgNCmR0b3ZlcmxheT1tY3AyNTF4ZmQs
c3BpMS0wLGludGVycnVwdD0yNA0KDQphbmQgZG1lc2cgc2hvd3M6DQpbICAgIDQuOTcwOTc0XSBD
QU4gZGV2aWNlIGRyaXZlciBpbnRlcmZhY2UNClsgICAgNC45NzU5MzNdIHNwaV9tYXN0ZXIgc3Bp
MDogd2lsbCBydW4gbWVzc2FnZSBwdW1wIHdpdGggcmVhbHRpbWUgcHJpb3JpdHkNClsgICAgNC45
ODYxNzVdIG1jcDI1MXhmZCBzcGkwLjAgY2FuMDogTUNQMjUxOEZEIHJldjAuMCAoLVJYX0lOVCAt
TUFCX05PX1dBUk4gK0NSQ19SRUcgK0NSQ19SWCArQ1JDX1RYICtFQ0MgLUhEIGM6NDAuMDBNSHog
bToyMC4wME1IeiByOjE3LjAwTUh6IGU6MC4wME1Ieikgc3VjY2Vzc2Z1bGx5IGluaXRpYWxpemVk
Lg0KWyAgICA0Ljk4Njk1MF0gc3BpX21hc3RlciBzcGkxOiB3aWxsIHJ1biBtZXNzYWdlIHB1bXAg
d2l0aCByZWFsdGltZSBwcmlvcml0eQ0KWyAgICA0Ljk5NDk1OF0gbWNwMjUxeGZkIHNwaTEuMCBj
YW4xOiBNQ1AyNTE4RkQgcmV2MC4wICgtUlhfSU5UIC1NQUJfTk9fV0FSTiArQ1JDX1JFRyArQ1JD
X1JYICtDUkNfVFggK0VDQyAtSEQgYzo0MC4wME1IeiBtOjIwLjAwTUh6IHI6MTcuMDBNSHogZTow
LjAwTUh6KSBzdWNjZXNzZnVsbHkgaW5pdGlhbGl6ZWQuDQoNCiAgU3Zlbg0KDQotLQ0KU3ZlbiBT
Y2h1Y2htYW5uDQpTY2hsZWnDn2hlaW1lciBTb2Z0LSB1bmQNCkhhcmR3YXJlZW50d2lja2x1bmcg
R21iSA0KQW0gS2Fsa29mZW4gMTANCjYxMjA2IE5pZWRlci1Xw7ZsbHN0YWR0DQpHRVJNQU5ZDQpQ
aG9uZTogKzQ5IDYwMzQgOTE0OCA3MTENCkZheDogKzQ5IDYwMzQgOTE0OCA5MQ0KRW1haWw6IHNj
aHVjaG1hbm5Ac2NobGVpc3NoZWltZXIuZGUNCg==
