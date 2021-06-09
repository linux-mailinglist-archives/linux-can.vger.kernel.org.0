Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E393A09C7
	for <lists+linux-can@lfdr.de>; Wed,  9 Jun 2021 04:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhFICHC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Jun 2021 22:07:02 -0400
Received: from mail-eopbgr150070.outbound.protection.outlook.com ([40.107.15.70]:53123
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231643AbhFICHC (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 8 Jun 2021 22:07:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBjw7SronskmPaaZZAF/Dlpw4ASMMdG/RAAKtTW54IGfJkAWZx9weGSHnMQY5tLcJZoftrOQUi8v/JysG7AKxSXHVKB0q7FmneqqL6WFTpV7K9Ws5YOoNv3uqjltEquhORooPErUGA7rjtkiSmr6F9gdIut/fZD8YvbqP4TIrynVJrHq3MxMG/c///xM4W38gS9ntGZOX9JYhwHWm9Fdt+7AHlIIEc9nBom5Deupie40v7JfyOOcS8zM9tIjeUmCQxdzUQD3WmRBqcoH0bEIqfEVs/QOQMZiZg77mdTqtxJRG06OydsgXMbTEw5C33+AnPep60Kcw5+qhZ27KA26Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNZ3y6ep5Z1TZu1LrNq7BnCD9+6QrSYj6eONhQtGmdk=;
 b=hO7XvwuA9eym8DgIW6ng1MFrSmxxLUhGFKfSFMqC7Dn5/L87ArmY+pJo8OjW0GXt6b+N2FM/djXQVtsJCyD30X+CaqWk5ZoC4LxlsWfX3HWJFkCCpF4953/g3gInsnTyT3t9vETYv7r/Ep2ZF0VgwlRcjkAvhO7yxkKs4Z35bTqqMIXxJF2SZ8+7gNjZURDIxWqLEi5aAvjgjGmMzF00kpcfuW03bfjDmSQvhMece4wuhE1ejZM1mgSCYGFGk0qKYrde12U1ardIcTuobUN7mIZGgTpAfZaLXwf+Jb5zdtTENc/yGrW5/4OxhvM92RFMzi3aJwowzNjckITfzU2sGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNZ3y6ep5Z1TZu1LrNq7BnCD9+6QrSYj6eONhQtGmdk=;
 b=lxZ4gKzsDIs8glmXizHk8mL8RXgl21U87gWHQauMCZ8xYkA3KZwqfohTrxJBGOYsMzP/iAny/6wYRlL4Sv21W+QBtIDh2Vk+j3Kgg+Q15WI4IW1fMpKxgkNL7xoJvjVB2PO1mM9M1325sSO/eWby0C0ZfXYNTySt5PkM5ncp2dA=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBBPR04MB7705.eurprd04.prod.outlook.com (2603:10a6:10:209::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 02:05:05 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3400:b139:f681:c8cf]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3400:b139:f681:c8cf%9]) with mapi id 15.20.4219.020; Wed, 9 Jun 2021
 02:05:05 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Angelo Dureghello <angelo@kernel-space.org>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: [PATCH 1/5] can: flexcan: add platform data for ColdFire
Thread-Topic: [PATCH 1/5] can: flexcan: add platform data for ColdFire
Thread-Index: AQHXXKdgvJCjcluaLk24fTStAj47TasK53Uw
Date:   Wed, 9 Jun 2021 02:05:05 +0000
Message-ID: <DB8PR04MB6795AC38C4A930DFC5DF1A86E6369@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210608204542.983925-1-angelo@kernel-space.org>
In-Reply-To: <20210608204542.983925-1-angelo@kernel-space.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel-space.org; dkim=none (message not signed)
 header.d=none;kernel-space.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d5659bd-61ca-49d2-9fde-08d92aeafff2
x-ms-traffictypediagnostic: DBBPR04MB7705:
x-microsoft-antispam-prvs: <DBBPR04MB77059CEDB4559B600935B5C7E6369@DBBPR04MB7705.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dBg9FYt53Q6VzO383cJrSNK18DX1g9vDytI/E/nYfWywBoo4hUQLB7bnCaHvSnYP/+UCdxlcgomGWHcy7CrPSwNSssYbKxtXU6Mk6xobBmEJypyGA05Rog62tr9qvQbrnNxke2B+9KG4SALEUe4SJ3v4k+lziT7MDA23fGsud2ayO6Z/7jrcmowJp8K9g/kcbyQaxEhFXI+WSyOSM2r3dmB5texlFDv8gH6mL/kD/KP1kZ1y/rY7wSeX4aI0xxRnOByMc2J9MjKA29DI3Wvfruw+seuqI/Cz71Nz3Kia2CwnaZ6OIqVITwaf+lIHI+UeQmqM5FY4E9qmP4APspQK1oqHxL5F5w7fFXaoPiAdM1yDMbw5DXYGi20Aw/+brV5KzpoyPD8AElizk6WIuPDKmqVO0qxYfwDe+2W9Ho9HzqWNey0rGJD6t25cwp0PpWxCiXo7UvX4hCh5y2s7pCO/QS05AG3oeQp12kUUK5+QXCAAcxK4qK0axE02GsM9UTfbjBtQd3t/iroQaPVFF0YhBE8jqq7U8gP9wnM7JcFGeN3YWQkHVps8l8mW5wBR+mk0reoWedapcYZVAp5ufgKMlcePBJ0MKhYhYwSwvX9TdLS2fG+NODBTBnw3hRMBTo4CAZzonbGdh+KLJKJPdgtH0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(186003)(86362001)(53546011)(26005)(6506007)(9686003)(54906003)(66446008)(110136005)(76116006)(83380400001)(5660300002)(52536014)(38100700002)(122000001)(66556008)(4326008)(66476007)(8936002)(8676002)(71200400001)(64756008)(55016002)(2906002)(33656002)(66946007)(316002)(7696005)(478600001)(2004002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?YTZ5b2tJQUxlK001bEtEVVNmRlYxWUp5NHY0UCtLSjh4eUFEZFJTV1JyMjhw?=
 =?gb2312?B?QSttSThRMkVZSXlrVlFDRFNVT1FIVjFBNzVpV0xZMmpWK01LZ1pvQ2l5eTYx?=
 =?gb2312?B?VTdYNVhxYXAxTU43SzY3SEdZM01lWWR2Vk5PVkVtM3gwcmlaZUxWZkxCZ0py?=
 =?gb2312?B?bUpkSUNjVHhJbzVyM3ZQbVhmemlRRXA5aG5xMjFib28vdGFEUU04di9URklV?=
 =?gb2312?B?eXdNcGY1eURpMzMwTXgyQU5QZlpLNXFtOFV4RmhnS0V4U0RiL0ZOblNPb1Bn?=
 =?gb2312?B?ejVJcE1xbFE3Z2trZ1YvSTFKUzcwdzhpWDloME1sOFk5Q1E4UG4rRGpBZVUz?=
 =?gb2312?B?dFRJcDRhbmlJZ3BLZnE2aU1RTllqaThZa0xuU3d3Qm9GdHZ6OW1VdStwSzgz?=
 =?gb2312?B?NkFQbEw5UTIrQWtWRFMrWXVaTHR3TGx0YWllWTAwNXJqM1hlUWlESnZWdzVS?=
 =?gb2312?B?SSs4dXQ5Q1dxY28wNXBsVnUvNEhlQ3F3cTQ1Z05SZGQ3WDlZNTZuYmcwT0dq?=
 =?gb2312?B?Y0k4WVFlekFvTFBBZ2ZjaVhOOU9aZGMwYVZwT1REcU5BTlVYUnFwdDRtQyty?=
 =?gb2312?B?dTA3NGsyWTJzZDMybUp3RWJoTGs2U0RtdkdzUVNUNEpnckNjakVjM0h3TTNK?=
 =?gb2312?B?Zks5cEtadFMybEsraEdHUmNwbm8wWXlUdW9kRTh1RmFIRGdmS2gxUG1RTjhi?=
 =?gb2312?B?Qkdaa0R2Ly9Qa2lLR0NkdEpLRVpxTFZJRFB4NENqL0d5UStMT2JCN0w0V0Ew?=
 =?gb2312?B?cjdablY3aG8wUHdJVDZ5VnM5MkIyeSswcnNMT1EwOUZWVDRPYm9odHJkMVdr?=
 =?gb2312?B?RSs1dVk2QUN0bzNxcVUxQlJDVGswUm1FL3pRcDFPNXBjc2FRY0JST0ZKN252?=
 =?gb2312?B?em1mOG9HNHFaOWRIcWdmS1YxSCt5cFpCc09Wb0t6TlpvM0VHVzVNbnBDcTFH?=
 =?gb2312?B?K081alhWSHBLeUdobk43NGUrZmdyUk5YM3R2b3ltR1FJYmkvMnFhL2tjTTJD?=
 =?gb2312?B?NlJQWEIvNVZLcmxyOFBobWdjaDlPOERDQWpCcFVybHVWVnI4NFYrd2QzcmZp?=
 =?gb2312?B?SWtYT0NoRU0wR3gvc3ZZTW41ak5uNW84cmhHZnRvWXhCbDNreEM2SXFUV1dw?=
 =?gb2312?B?VHlxWERlSmwreGRQeGlpd3FLdWkvRzdmTmorWitGY01yVFd3d0kvSG1xeGpB?=
 =?gb2312?B?SDFpeUkvMksxRk1TK2Q3ZEVQdGRPd2hWUEZhRVh3S2hQL2drTEVOcWMwSUJt?=
 =?gb2312?B?eVY0SmQrR1libk9oYW16T0o0K01nUndtQm05aU41d0dsWE90eHVLNG9rUUZ4?=
 =?gb2312?B?RU5mdGM0bXdmNVdHa1FodGpmVWJmUGxZeU9TSGF6bEdnRStxS2dpL3RWYkpK?=
 =?gb2312?B?VWtpRGdNcVBaQTFtZ0lEcE5kcEVUN2VhYk1iQVZWRFhFdGdsSU9lMENoc1pz?=
 =?gb2312?B?OVE1TnJkejY0V0c4MGwzanZCNE1FZkE0Y1E0K1NWaTlOMDdIdHFpeEcwYWhP?=
 =?gb2312?B?SGZJcGtEcllaL205RmdKaFdEcWNOWkRiYUFWNldJMFZDSDFnbTFIMmlZTWVy?=
 =?gb2312?B?Yk5LL2ZVNTc4dFJ0QWhUWmRGZnRvU3J2bFpxTGJaNDU3azlyNGRlT3ljUmNZ?=
 =?gb2312?B?NDlEUDl3RjFaejgybmlMTDNsVDZtMmpJLzYyUzNHY1ZkUEVOVWlmdkVxcjUx?=
 =?gb2312?B?czNEeFNKQ1g0ejlnMnROM2FMbzhsZzFCQ1NoamNMaVhONkkzNmFwN05NMCtw?=
 =?gb2312?Q?WMMtqgkzOuGXS44PVzeeyICeEuI0d1Q6IgxFX16?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5659bd-61ca-49d2-9fde-08d92aeafff2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 02:05:05.2488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGtehHZ3X/4I7YwAvZs/BU32/lkzr/wQ2tPlZs2kXL0YLIs8ZiR00tAGnTdZnO1Vsnu4f/JT+V1QEUMolt2kKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7705
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZ2VsbyBEdXJlZ2hlbGxv
IDxhbmdlbG9Aa2VybmVsLXNwYWNlLm9yZz4NCj4gU2VudDogMjAyMcTqNtTCOcjVIDQ6NDYNCj4g
VG86IGdlcmdAbGludXgtbTY4ay5vcmc7IHdnQGdyYW5kZWdnZXIuY29tOyBta2xAcGVuZ3V0cm9u
aXguZGUNCj4gQ2M6IGdlZXJ0QGxpbnV4LW02OGsub3JnOyBsaW51eC1tNjhrQHZnZXIua2VybmVs
Lm9yZzsNCj4gbGludXgtY2FuQHZnZXIua2VybmVsLm9yZzsgSm9ha2ltIFpoYW5nIDxxaWFuZ3Fp
bmcuemhhbmdAbnhwLmNvbT47DQo+IEFuZ2VsbyBEdXJlZ2hlbGxvIDxhbmdlbG9Aa2VybmVsLXNw
YWNlLm9yZz4NCj4gU3ViamVjdDogW1BBVENIIDEvNV0gY2FuOiBmbGV4Y2FuOiBhZGQgcGxhdGZv
cm0gZGF0YSBmb3IgQ29sZEZpcmUNCj4gDQo+IEFkZCBwbGF0Zm9ybSBkYXRhIG9iamVjdCBmb3Ig
Q29sZEZpcmUgYXJjaGl0ZWN0dXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvIER1cmVn
aGVsbG8gPGFuZ2Vsb0BrZXJuZWwtc3BhY2Uub3JnPg0KPiAtLS0NCj4gIGluY2x1ZGUvbGludXgv
cGxhdGZvcm1fZGF0YS9mbGV4Y2FuLW1jZi5oIHwgMjcgKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2ZsZXhjYW4tbWNmLmgNCj4gDQo+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvZmxleGNhbi1tY2YuaA0KPiBiL2lu
Y2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9mbGV4Y2FuLW1jZi5oDQo+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uNzFmZTFhOWRmMDg0DQo+IC0tLSAvZGV2L251
bGwNCj4gKysrIGIvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2ZsZXhjYW4tbWNmLmgNCg0K
U2hvdWxkIGxvY2F0ZSBDQU4gaGVhZGVyIGZpbGUgaGVyZT8gaW5jbHVkZS9saW51eC9jYW4vcGxh
dGZvcm0vDQoNCkJlc3QgUmVnYXJkcywNCkpvYWtpbSBaaGFuZw0KPiBAQCAtMCwwICsxLDI3IEBA
DQo+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5ICovDQo+ICsvKg0K
PiArICogRmxleGNhbiBvcHRpb25zIGZvciBDb2xkRmlyZSBmYW1pbHkNCj4gKyAqDQo+ICsgKiBD
b3B5cmlnaHQgKEMpIDIwMjEgIEFuZ2VsbyBEdXJlZ2hlbGxvIDxhbmdlbG9Aa2VybmVsLXNwYWNl
Lm9yZz4NCj4gKyAqDQo+ICsgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNh
biByZWRpc3RyaWJ1dGUgaXQgYW5kL29yDQo+ICsgKiBtb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1z
IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQ0KPiArICogdmVyc2lvbiAyIGFzIHB1
Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLg0KPiArICoNCj4gKyAqIFRo
aXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNl
ZnVsLA0KPiArICogYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGlt
cGxpZWQgd2FycmFudHkgb2YNCj4gKyAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBB
IFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUNCj4gKyAqIEdOVSBHZW5lcmFsIFB1YmxpYyBM
aWNlbnNlIGZvciBtb3JlIGRldGFpbHMuDQo+ICsgKi8NCj4gKw0KPiArI2lmbmRlZiBfUExBVF9G
TEVYQ0FOX01DRl9IDQo+ICsjZGVmaW5lIF9QTEFUX0ZMRVhDQU5fTUNGX0gNCj4gKw0KPiArc3Ry
dWN0IG1jZl9mbGV4Y2FuX3BsYXRmb3JtX2RhdGEgew0KPiArCWludCBzdG9wX21vZGU7DQo+ICsJ
aW50IGNsa19zcmM7DQo+ICsJaW50IGNsb2NrX2ZyZXF1ZW5jeTsNCj4gKwlib29sIGJpZ19lbmRp
YW47DQo+ICt9Ow0KPiArDQo+ICsjZW5kaWYgLyogX1BMQVRfRkxFWENBTl9NQ0ZfSCAqLw0KPiAt
LQ0KPiAyLjMxLjENCg0K
