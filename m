Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B623CB777
	for <lists+linux-can@lfdr.de>; Fri, 16 Jul 2021 14:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhGPMsP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Jul 2021 08:48:15 -0400
Received: from mail-eopbgr50110.outbound.protection.outlook.com ([40.107.5.110]:34438
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232757AbhGPMsP (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 16 Jul 2021 08:48:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7y0s/L3Gs83gw/AoiJlVJskUiWHNot8KBzPNtc1gNM8MIg6bdQsCcKHiXa6y5GMfi8vNrgqPERoMw6rW08rgSAkfDlyPkilSBrtFK6Ns5M/LznyPsRZPrHdTimHUxtu3GIAy5/OmVu+SalpizfOhQIjJCyieH8FgFoTi+a2NrtPYq1IiyyVRP5QbCO9dBGlKD42D4MfIytQVEZx2bGi8xeoWSAnRTHomBnfCPwZnyfKUh6Q0xFP3Rm/WP2O4xFt2dTpkB6IO2tNjigAWxIs5hZPT7JbiUQ1/kBipoTfcy9P7YJupqK00pIBZtFshFx4ovkDTajxOXbquWp3FwZR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLq/uo93iLV/jjAWrFv6FAZ+bwMVsZyDYUuLSZEAbfc=;
 b=XARAMyPXoFheY75rnbpHrnQnFSrJjwS1DjwfnbjQg4P62Ia2wn17IeCGxX1ZO+uuQbhFSr4tuj/5jd7xxbdE9iDoXfqBI2WLc3rImY+De2nMu1wG/yRuv0hk/SBp9kPTWqVlrIiGOJd7Q+XmQPZYzaJFUMezrT8LPrSegV4Btqmy3sYxuP/WxlLNmNeHlcQVdWb3nNovXWnipysWbTqCQPA4HOD16hw79/cEWSaU6s4McglFkQhMvFDNRi0oEOz7PbITgmZKMOgwhJ7fwnPD/VlBCro9YpZsY6a2m6NLZS/RkuennidnvZJaLeLjdIaoWq1P/wtZfkSupOISFlrKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLq/uo93iLV/jjAWrFv6FAZ+bwMVsZyDYUuLSZEAbfc=;
 b=M4gJxNrjkSzUpR3aTlr80wuubSNjbafn+9uELG57Dohr9Rlz7LUB7/XdCr2kynsTzoJbjkcf2xFDywzx0eN+2veoK5LpYpx7OXHg0WWKH+T+PFcnLjLMB7IxNBO6vUy6kt8CPJQfcBLPACGCPl4eDV+WQFPVcJAAbHbZqxSHvHM=
Received: from AM9PR03MB6929.eurprd03.prod.outlook.com (2603:10a6:20b:287::7)
 by AM0PR03MB6306.eurprd03.prod.outlook.com (2603:10a6:20b:158::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Fri, 16 Jul
 2021 12:45:18 +0000
Received: from AM9PR03MB6929.eurprd03.prod.outlook.com
 ([fe80::6872:4ae0:6563:df20]) by AM9PR03MB6929.eurprd03.prod.outlook.com
 ([fe80::6872:4ae0:6563:df20%3]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 12:45:17 +0000
From:   =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <Stefan.Maetje@esd.eu>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH 1/1] can: j1939: j1939_session_tx_dat(): Fix build failure
 introduced by renaming skcb to se_skcb
Thread-Topic: [PATCH 1/1] can: j1939: j1939_session_tx_dat(): Fix build
 failure introduced by renaming skcb to se_skcb
Thread-Index: AQHXej8Hd0fdRD76sEm/UF9pwFuutKtFicgAgAAClYA=
Date:   Fri, 16 Jul 2021 12:45:17 +0000
Message-ID: <a7c4f2e9e1eb413827e5b226060083f09f0b8471.camel@esd.eu>
References: <20210716123437.20825-1-Stefan.Maetje@esd.eu>
         <20210716123437.20825-2-Stefan.Maetje@esd.eu>
         <20210716123602.lrtgklvsp2c5poly@pengutronix.de>
In-Reply-To: <20210716123602.lrtgklvsp2c5poly@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5-1.1 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc03e183-9e2e-4882-9063-08d9485790e5
x-ms-traffictypediagnostic: AM0PR03MB6306:
x-microsoft-antispam-prvs: <AM0PR03MB63062AC797F5C7FDC203A68881119@AM0PR03MB6306.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q7IlnAJSHegj4NjLmAzLx7/Xf9zfesHg1PtnZRzWY/qenvs3oUEO1msUw9edEqTpoATQcG63SNyzcuLk8PEsj4X2pK95Dy46R0nWID0QlQ86vQqvkI1Gq5Jh7YXj17YZMgrWFkWM+43/EvVhqwmt92CP00u+CYwdBxKd1Jp5YPpgleqKzIYiqWNcdvSNOSIpRekTlp16o1zefXZFgEpQtEE06T4gTJLmO5VeOGtZ871Nm1wVYQN3eMXv0MisfI44H9xgQdr6SXQqvd7S8qR06+uwmektQThSMMjIGg2ukZEfwMrk5e5Vki5UUKOiZqh4WheYWGQFSz1kBx5BBTptkXIak9mD+a3ccY2cqu3tEfgWxuLVDHu+ninifrsEYs/uC49Dt27rb2Ieqq1mGxqhkLUAPIBeFXtaIjA1h25EtnX+FBb60gp5CJyJs7sgTDiIKW4uL4CIwx8OmenkaeRjryYOaHT7kEG+DZpcAFt4qbhBO98JXbbSou/8zyYk72xPZwaZfpUXG4QEYgdai7mAvw02DBsTnJb+g9Ig4NM8y3PNJ2wkzKlGLUDrQJPF3ZLFO19umFYPg5TD+dUPHECZaifddGsBjceeBpq636MMZkUnlkitt/wLOP2ysWgGBdOl6t+m/XcJSAGV0ZBJJk5oP74mRk1fosdhv/ySxGOkbGF3lqPXLOyT6jqxirXsaT6pV/ZWslreFeOu4XSGXyAuMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR03MB6929.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(366004)(376002)(39830400003)(2616005)(186003)(83380400001)(6512007)(86362001)(508600001)(4744005)(38100700002)(85182001)(6506007)(53546011)(54906003)(122000001)(6486002)(85202003)(316002)(4326008)(66574015)(8676002)(6916009)(66946007)(71200400001)(66476007)(2906002)(5660300002)(66446008)(66556008)(91956017)(64756008)(36756003)(8936002)(76116006)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0Y5NmNJWmxLZ3ozS01NbDJueEMvNytqZllXV2FpVE83aC9lT1d2S3BiVTZM?=
 =?utf-8?B?c0ttTW1VV1JGY0p2dGNlRzNJKzhETE9VRUc3dkhEeTA3YUpKZGRJOGwySDlj?=
 =?utf-8?B?cWE4VkJLWWZSNjJ0MG5MZ211SzFaeUw5MitwK1U2bUozQ3NIMFZQM0J2MWFT?=
 =?utf-8?B?VEV4S0FuaC9LQTgvVDluUkN5VUZKTTZsWHA0UGpzc01tNHQyZ3FMR0VYMmUr?=
 =?utf-8?B?MGlJeGlTY0luNW0zb3Z1UUNmWHNzdXlxQVQzVnZBMkR0R3U4TjZWcmVPN0tM?=
 =?utf-8?B?UEt1WUlrNjU2UGxJc0V5SFQ4NlJ5TzQ5V2kyM0pHQ0VDcktPN1dHRTN4aTRV?=
 =?utf-8?B?MnlOK3RLQ1RYczBKd2VkSXQwbFhVMStCM0hKSFJ4Y2dYZzF4dy92MlllazBW?=
 =?utf-8?B?Y2g3K0ZHRHl3YXFxU0lzT250VFZTR0Joc2dNYUZkOUtDa29ra0w1ZGlMcVd4?=
 =?utf-8?B?RTV4VFAycXpDMVprbGUyWW1FZzRwOG1zdmlVdGZIOHBJOE1ydEpHZmo5dmNZ?=
 =?utf-8?B?ejlPTGxKQzAvMjZzUWpPWUpMUzRyWTY0c0JNZ052ZW9xNGVOMU1QVnp1TzZ6?=
 =?utf-8?B?WlVGTXdDQXNYMWsvL3hqb0Vra1lQVjhFS0hQVkVmZjl1cWh0VG01SDlZK1Q4?=
 =?utf-8?B?eFdnWHJEQnNTa1dhMUZxSmxXTzZOOUw2WndweUdveHFLZDgvR09yb1NOSmh1?=
 =?utf-8?B?UTV1cHpKTVBiL1VkUGNLTVQ4dERFVE93eUFtQ3lVWE51MTJUOTRqL21GYmJF?=
 =?utf-8?B?dGFLSGpjQXcxRGlzT0JzOHNPSFArQ040OUhUTWF1V3QyeThaQVlwUzNtWEJk?=
 =?utf-8?B?ZENHVGRuWkd2UTlRbHc5MFNIVW5SZE9wVWEzSVVKM3YvMUlIL3RjWExJTmtx?=
 =?utf-8?B?cGoxdGEzM25UNlVmOFdWOWtQNmt5c0RERjhyMnpnMlpHVnpCQllQUHBjL2No?=
 =?utf-8?B?bzhOY0dJSHUralBmTmJZWVlWOGQwdFkvTzJub3FJaVo2Uk43OWN3RVBuTjRV?=
 =?utf-8?B?MUF0T0J1TnI5a3Z3dGRpWXROM0ZXK3M5WXNkYUxSWWI1L2NtbG5TRWduSFRa?=
 =?utf-8?B?bHVlWXFmYkRYL3NpR3dQKzFBdXVMc0NQbWJPa1NKaEJ1K0REcmdTV0pUekpN?=
 =?utf-8?B?cTJZc1NPRXdJc2FodklKR2dxeTJVL2ZYbGNBM3BZN1FWclZYZit5RVpLTGNk?=
 =?utf-8?B?SXpGcEQ1S0xJODVzKzhST2NFRk8yRzcwVVVveGNGTGJRejJjTi85TGpPSElt?=
 =?utf-8?B?dk11Zi84cS9hLzd6OFR6dTJldmUrNUdFcEZGazVZdkhDM0pJampHOXJxSjJn?=
 =?utf-8?B?MHdpMjkrOEpMTXVuT1JYK3M5OEVpNDVDZ01tVkJvYzlSaFpEcG1UNks1WGJG?=
 =?utf-8?B?QW5hdFNOTWVCbEtDUXk3S01pSldUOUxOVDY0bU1oY3RwYXhzT1dsc0pTczZm?=
 =?utf-8?B?dGtPa0VlRkVIT0J5azhha2U3VGhLSDliaDBpYUx6azB5NU4zSjFmVHdTL0Jz?=
 =?utf-8?B?ZVJxcUF4QmtBVk83bnFEZUpYTFlNbmVnVnBJSDduZFgwMWZnbUpJcFRBSkgr?=
 =?utf-8?B?OEd3SnBTMWpxK1lCY2ZveTRGY21VYWdvSVhhazl2dGxmWDRnRE83UE0wZXFG?=
 =?utf-8?B?OE5MdjVQMzk2RVl1bndaZWF6bVhKdjZETGhYeCtjeTJ4aGU2MkoxejZMQ3FQ?=
 =?utf-8?B?bkNnRTJ1UklFNFdrWFNZa0RIajZ0akZZdXcxVlYrTWl5S2FYWEluV1VLdkNI?=
 =?utf-8?B?d0wzeWI3d2tkelZjRDdkZWhzdlVpSGc5SisvTnF2RU9XV3pEMmZtMFpVQWx5?=
 =?utf-8?B?NmdMT3ZLakpRd3pvblJXT3lCMkQyUHFaMlZuM1Y2aGs5d3pkVGdlVEkwSktn?=
 =?utf-8?Q?g1W7YPzPuSkKg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DABFAF641A4550408790BC3D0B7AF3EC@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR03MB6929.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc03e183-9e2e-4882-9063-08d9485790e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 12:45:17.8440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6WBo41wW9IWbn2Xz+WGGd9QSQkJYnia5e554kxohCf7tphumsn1+gjomQ/XUJy5570dvqAli7tD4h81nbGNJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6306
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

QW0gRnJlaXRhZywgZGVuIDE2LjA3LjIwMjEsIDE0OjM2ICswMjAwIHNjaHJpZWIgTWFyYyBLbGVp
bmUtQnVkZGU6DQo+IE9uIDE2LjA3LjIwMjEgMTQ6MzQ6MzcsIFN0ZWZhbiBNw6R0amUgd3JvdGU6
DQo+ID4gVGhlIHBhdGNoIGEyZWE1MDYwOGEwMmFjNDgzNzFhOWZhYjAxNjdjMWI0NDQ1NzkxM2Ug
cmVuYW1lZCB0aGUNCj4gPiBzZXNzaW9uIHNrYiBjb250cm9sIGJ1ZmZlciBmcm9tIHNrY2IgdG8g
c2Vfc2tjYi4gQnV0IHRoYXQgcGF0Y2gNCj4gPiBtaXNzZWQgb25lIG9jY3VycmVuY2Ugb2Ygc2tj
YiB3aGljaCBsZWFkcyB0byBhIGJ1aWxkIGZhaWx1cmUuDQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBy
ZW5hbWVzIGFsc28gdGhlIGxhc3Qgb2NjdXJyZW5jZSBvZiBza2NiIHRvIGZpeCBpdC4NCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gTcOkdGplIDxTdGVmYW4uTWFldGplQGVzZC5ldT4N
Cj4gDQo+IFRoYW5rcywgSSd2ZSBhbHJlYWR5IGZpeGVkIHRoZSBoZXJlIHllc3RlcmRheSwgYnV0
IG5vdCBwdXNoZWQgaXQgeWV0Lg0KPiBTb3JyeSBmb3IgdGhhdC4NCj4gDQo+IE1hcmMNCj4gDQpJ
dCdzIGZpbmUgdGhhdCBpdCBpcyBmaXhlZCBhbHJlYWR5LiBJZiB5b3UgY291bGQgcHVzaCBpdCBu
b3cgdGhlbiBJIGNvdWxkIGVhc2lseQ0KdGhyb3cgbXkgcGF0Y2ggYXdheSBhbmQgc3RhcnQgb3Zl
ci4NCg0KU3RlZmFuDQoNCg==
