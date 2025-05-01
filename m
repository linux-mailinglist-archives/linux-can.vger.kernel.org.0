Return-Path: <linux-can+bounces-3512-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1990FAA5AA4
	for <lists+linux-can@lfdr.de>; Thu,  1 May 2025 07:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD50A3AB7E2
	for <lists+linux-can@lfdr.de>; Thu,  1 May 2025 05:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8494422FF2B;
	Thu,  1 May 2025 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="RN4DED99"
X-Original-To: linux-can@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011016.outbound.protection.outlook.com [52.101.125.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A160F17A2F5;
	Thu,  1 May 2025 05:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746078386; cv=fail; b=U7t/honyehnWNVTPNhL7pzvLICJ1Oh0KwI2oTriaa91h2itF1rG0D2dhhh15ujFT6vSSxcUb/ZWyEbdIC+5hdogarnT3ogqdU+/FU9k3JZvXkYn6L315nxkacuUj45/wT+uL+dg+JOSBOXe/+ih7z1mrXpQMUIsS7/Nf4MXVH8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746078386; c=relaxed/simple;
	bh=DQpSESMDU+uxnBKqMXCY7D3L46iY4fDAfr1SI1GLcmA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E2dQqE7RM2Fn+bw8DsBpMRcgFSd+XVRLxLE21RyUhArjZUEcmPZ+6ogpkKK/CJYPkbTJRprcH06uPApAe8wHxyCG+EpMRkTSRToO4dH7PbZV3A5yrzvzCjdbTGjMpaQjxhp6fLSTdpnRsPhbjlYMWDmV9pv9Mc/YzVl6EgRnWhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=RN4DED99; arc=fail smtp.client-ip=52.101.125.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeL3Fy7UmYGA8moWZnKnPMJYmNSukkcdLAtZYayLox4qciWFk+xG5pc7uBu7AjES2rcEp7Igz9gNTbUMKbplJgnOO32XytAUXGGnZ/qZO01h9EkxzjWTdSR+AYjzbKHad3rw4sEGfUOd7C/0NSpO9sWJfCob6BrlOI93Q8pqNVeyl+LdHNB0t4JyPJW9QOD1rIhMxiiNmw8pDiug4G12jPzknupKiDeeJ9am+B7/2nQ3Ohc8rxnfm4hdJ3uuz7sxFy7+UIIFF2Hz0k8L7ETeWfJDFf3sSuxokNVQP/TG5IlN0IIu4Y7NFqr3eu8aCeAoYkaZ3idGEIyktQfJ2BJptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NITyKT43F/I3FlBUboZdoSj76UxQ8noXHKBdoRuzAY=;
 b=HIVHAoYoRFUVHkcq0ky/2NcyBUovqh5EnR20NCAOVmj+5VMy2gUBLX9MLj+3+REGYPuFdaURCukFZtqePdMgcwit/vGNyPUuZkifzc6D0rTG0ukLsEiQ1HrjsxxVIc8xy64mZ4nh82CcO0rvCmDr7bfm4jCwbwtgg0ThSKQMtw9+Vc4Rjww1Boi0T9gZzef80L7t7t4PAy1TLFBfF1Ts0rLtgb3vjKQvgVzQNSiLmdx50w2beGy5hmPgxajd9YiO3TyPdHfma/XzVh2QFVZdfP8Z5ZQBmZXuXFcT3YQ2tqMlKGZzZNv0BbP0HJ/C/afaotFOcb0denrRBQF17qd/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NITyKT43F/I3FlBUboZdoSj76UxQ8noXHKBdoRuzAY=;
 b=RN4DED99/UzVdpspKgWojosw8/JwMaDLU3+uun7B5JcdCmsj8gprXS4FLOBF9OhtvT3CSAibpBWmzUkGUL4yOLYhlqmmnu+yRq1RPxijx3F4ASroCpCQNJNAO7SF3n2baEWiJH8HeHxbUbIdc6unlWcXx+IAkHeIiVky+jY1cCs=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB16244.jpnprd01.prod.outlook.com (2603:1096:405:2da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 1 May
 2025 05:46:21 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8699.012; Thu, 1 May 2025
 05:46:20 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>, Fabrizio
 Castro <fabrizio.castro.jz@renesas.com>, Simon Horman <horms@kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v9 00/19] Add support for RZ/G3E CANFD
Thread-Topic: [PATCH v9 00/19] Add support for RZ/G3E CANFD
Thread-Index: AQHbr1upw8DnItcxo0+49n48ulKPo7O9Wcsg
Date: Thu, 1 May 2025 05:46:20 +0000
Message-ID:
 <TY3PR01MB113469091B3337AA31CC24EE186822@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250417054320.14100-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250417054320.14100-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB16244:EE_
x-ms-office365-filtering-correlation-id: 648ed8c3-c2d2-4ac5-b884-08dd88738028
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2t45z1yC4FJMKj3rIj47AHW4n7IFS2bmFW1niQtDJP9E5cVoUkcwD+52WA9d?=
 =?us-ascii?Q?ykxunWTuXwjtKPLcNe1eGp6dmQYAKdhgrxws609LD1SXCzHI+pEeNFIB44xM?=
 =?us-ascii?Q?SZRnNtTSHs3gOpMPT7lDLrH8L09ZnkI3SE+98B7lFapKtTpMo9Fbf/oEpOt3?=
 =?us-ascii?Q?3vxltgnB3bRw+XcWbLyKt7XmFTFDmK3npx4Krr2qfEeaf0a7fVkxmwGFg6gE?=
 =?us-ascii?Q?LZL5zPtY3e6MPWMXP/WizpuRGZWtyiJMGIuyQ5wtIpT1y3RJ8Ays4lniA2ZD?=
 =?us-ascii?Q?X0QDs1TtRdUo6y5mHTdQAL5x4B30iGkHznVglbKx4otyi9ZX+Ql1lS3A9cE6?=
 =?us-ascii?Q?tOSx6HbLlIaLAtd3Orz9+BS0TaZnOw+oaSqMf6ZKaUyWax3mMJhm3khpkBgC?=
 =?us-ascii?Q?HgmThUoIcuMT+60W9vVJ5j6bYIoPNXr3Y3lwVw5HTHOadXDZsK0+dmCrr3Jb?=
 =?us-ascii?Q?O0z933IW4w7RmBHTnYF7ulIghc344yfDMnydQ3w5/Be+SnUzDVqf7vjyAfkl?=
 =?us-ascii?Q?eIkCNURTScVpiEa9kz0jOvag5AbUCFfNohA6lIUdP0P4IQEw40vb49qqyT70?=
 =?us-ascii?Q?T1q916csPBdJYwY7XokQDxy+vrguUDebbXAfbwQkPOwIGwgn5fPHzToo3oga?=
 =?us-ascii?Q?Kb52EY8DQDVMV0bmz48pt/VzP3Fc+Dz/pCjbnQyw1GdsSrdz5oOVh24Larlj?=
 =?us-ascii?Q?9FDeR9GCxlLlHep7qwPr/gjc4FZW7uh1Y2cToosOspVpH+vp5uxHHpuN4RaP?=
 =?us-ascii?Q?UamYcl1zj9AW3BwjAksfkBgTYqjOJZwjiI1Hgokx4EWv1pdsBP5hyMERVgtH?=
 =?us-ascii?Q?c5XcrFKH8gT6GlgMSmtmGGMtFa55/0+wsr4Mc7WqO6vIzODtB64x0/g/eZVk?=
 =?us-ascii?Q?YJ/wJ+M1RflTTEVsSa58ZapkO32ypzAiTKCjKWoeul0mDvrbvrp4Bnlu041K?=
 =?us-ascii?Q?xAbr6aOEjRNTeCkzlOPyY4Cw2NrUtD/ATOgA1zokSTNrc6ofmPtZtuRGG3R3?=
 =?us-ascii?Q?u5n0SvoddJ4a1C48eAGkp21uVzA5vY1QbXbQoX4+NAIB0a9NzVBxOxdx2eFl?=
 =?us-ascii?Q?iaFl1JC/s7gw8vVTKBYj8hm8+Kqa0cJzk3xNTayL3Mxk1jhWiGlpSo1nhSoP?=
 =?us-ascii?Q?+AOLKerglgaTtXsC1VuW606kiq1IoPnWKTBI/tlrF+f7W0q1CB3oJUIlx2NH?=
 =?us-ascii?Q?aUwEjQJ5bMKMxm4fsnTLwvQCmPyRZ7lMi1VpgF/mSGFc2UPcP0frruEeqw1r?=
 =?us-ascii?Q?ZZxsACD0QbmoNfxZ8pzyMDkpkIhscKDhek/XA6+HpFwGPvyMq1VnTY0wwESj?=
 =?us-ascii?Q?p+3goQN2zOhtUs6mOqC13pqf1Wtlih8zmSEKHUt3HcmV1DMCunRjpthCmtXJ?=
 =?us-ascii?Q?KzW57jsrdVllacLjjO+heDdBopfxwKMnsd/ypo/bX+w3jJ0nonH/XULdXOCX?=
 =?us-ascii?Q?WzhokYnBKxDgi3v6zCpGvliyLVgbFfmal0xml540bPEcDzlKIXrDCA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pfevKTLvqoMezEPeponvXBlfrkqzf8DeKkX0LcwNAt2l/PDEVyrPTW9l4ft5?=
 =?us-ascii?Q?G1+6eRXHi9sHJHxZ+yh+wUeYL5ApoeKB/Js4FYgGwa95CAqvm4JMAIeggHgt?=
 =?us-ascii?Q?xG7r2pqi0NM5j1xuQH+Rq3sGGVQHQOKQo7n870fiMEc7GgpRL3o8qCTT+FCO?=
 =?us-ascii?Q?NUQQ285MhMkLWwPu+K9Rc2yIMVBkXPg8K6WxwKvZXaVLxVQQdNeBavAKdq6F?=
 =?us-ascii?Q?yulG6B7RMzdKy4ycutBSt+8q9h/MfeYNG6zPg/17n10lfMY2IjwDqNVTVcJw?=
 =?us-ascii?Q?CKIX3e5kp1PjnxMoKwchxTpF20UgfweSNJ167mXsMfQb7JUo/7cACtggY7Bk?=
 =?us-ascii?Q?YJPT5k2+QBNbo3WVXjC1TeAZPz3eewdYlisYaeTTgQlGQG8NfksenzHgwX+T?=
 =?us-ascii?Q?MejuIUlMy2HE8hNRBf+jzgQJhvWYELNXRjCM6O6E8FUbaCrMoBHsv2Wo5Y1e?=
 =?us-ascii?Q?6sna9k4x6Cx3BztahwJpLf8bJDXn56mZqYU5Mw84PKxw8afu66Vb/fy11584?=
 =?us-ascii?Q?SR3QtKX4iABC4Xoae4HNRR0IItu9QdZ1I0X+kzDleI9XhWzD3FPR+R1p+9P5?=
 =?us-ascii?Q?Gb0cPb0HWUidekGoq0nYwEC/GaZu949XZ9n5nRei+MxNEtnlru/gJgqxfuTL?=
 =?us-ascii?Q?vCBdMeXyNTJ3Ec4dtBctWmD1Y66fMK8/v9lI1g+77+2PcOxnO+yITxYzR4k6?=
 =?us-ascii?Q?PhmfH4k2GPtM7HPwA+wLUjnxbWOewFDWMKD+juAGNJ8zzDJATzRWqKv6STqm?=
 =?us-ascii?Q?AV27qPqmJBd3KAAMIR3PR1wP4V2CrA2OIvOemq+oRV1BF/YS0KWIZuhhm/fW?=
 =?us-ascii?Q?ao9pbqPb/isM7leOTxAHzHjxrz4+UUbNUjTlv14uSXn9HCrHzmDvX04FTgOZ?=
 =?us-ascii?Q?BYs5lC3CdHqT71/m6wZkmIjWKflZbfKObrcepSv3gR9gXP9EYksPOWLo6ZEz?=
 =?us-ascii?Q?goe9HMm1YdPKdXvyrekuApVGGmofpeuTGvmRf3mrUZp5FOGLND8/iqYL1w2g?=
 =?us-ascii?Q?hXxtsZt/zJc1pzCgKzRAs04Wl7m8bvVcXM0xgXYT4YfbJR2bde2qwRNzerdW?=
 =?us-ascii?Q?0mOUv302ReXownjrFnLSol82tpwDeoE22bym3Kb0g9jHGolaAQz+fHE/yoL6?=
 =?us-ascii?Q?f5xQKAMxfMumYNGxv7jF7y2ehAAn061EkZn0hdgNwqgNYsHSuzXbnzxEajGd?=
 =?us-ascii?Q?OU+4IenFYJFDivrs8Wd6/SSe6Tyluyu+wDIpF3eWvKh0fIB1nF+mT3rIEXVk?=
 =?us-ascii?Q?782Hc23tTswacHZ15L4mpirHzrM7YaQYackL5r/J1TsEuMt16Wea/AdettPM?=
 =?us-ascii?Q?3gWXnnzGR8FofpaYo2J3aKD9XOQX7q/ZgQgKjsbCMFoOxi8M0qzQ/kUxNIMJ?=
 =?us-ascii?Q?aGub7OLDeCUwLFrxwNSESacInRZszg1b7pZwjynUfyLNwiWTJBRw5SMjZ8pS?=
 =?us-ascii?Q?o0sJLhb53rHxLlMOwGTwEg8crI4tv39nsv7RRTooyhMmD6FxKtbNe4dscfH3?=
 =?us-ascii?Q?L76ly/rLVD7yc5DMNTf7pKZL8a/DZWGsq9Q7kjBm8OFbPjGD30LxcessrZNb?=
 =?us-ascii?Q?IX3vfupyQd7GzZ4poQRzmEeJmZw7kylJvodRyydzOQ1oxH2cIczZU47f2vA0?=
 =?us-ascii?Q?JA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648ed8c3-c2d2-4ac5-b884-08dd88738028
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 05:46:20.8821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IvP5Zj+pBpzyKghHxhYRVD3fAxLMDkJOCh8mqTnRMGFuOtpF6fY4NP8UXNa1syDynoSc4HE9BCvsf/SNrrIVYw7ij+M2bATXhOIcpD+w84Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB16244

Hi Marc and Vincent,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: 17 April 2025 06:43
> Subject: [PATCH v9 00/19] Add support for RZ/G3E CANFD
>=20
> The CAN-FD module on RZ/G3E is very similar to the one on both R-Car V4H =
and RZ/G2L, but differs in
> some hardware parameters:
>  * No external clock, but instead has ram clock.
>  * Support up to 6 channels.
>  * 20 interrupts.
>=20
> v8->v9:
>  * Collected tags.
>  * Added missing header bitfield.h.
>  * Fixed logical error ch->BIT(ch) in rcar_canfd_global_error().
>  * Removed unneeded double space in rcar_canfd_setrnc().
>  * Updated commit description in patch#15.
> v7->v8:
>  * Collected tags.
>  * Updated commit description for patch#{5,9,15,16,17}.
>  * Replaced the macro RCANFD_GERFL_EEF0_7->RCANFD_GERFL_EEF.
>  * Dropped the redundant macro RCANFD_GERFL_EEF(ch).
>  * Added patch for dropping the mask operation in RCANFD_GAFLCFG_SETRNC
>    macro.
>  * Converted RCANFD_GAFLCFG_SETRNC->rcar_canfd_setrnc().
>  * Updated RCANFD_GAFLCFG macro by replacing the parameter ch->w, where w
>    is the GAFLCFG index used in the hardware manual.
>  * Renamed the parameter x->page_num in RCANFD_GAFLECTR_AFLPN macro to
>    make it clear.
>  * Renamed the parameter x->cftml in RCANFD_CFCC_CFTML macro to make it
>    clear.
>  * Updated {rzg2l,car_gen3_hw_info} with ch_interface_mode =3D 0.
>  * Updated {rzg2l,rcar_gen3}_hw_info with shared_can_regs =3D 0.
>  * Started using struct rcanfd_regs instead of LUT for reg offsets.
>  * Started using struct rcar_canfd_shift_data instead of LUT for shift
>    data.
>  * Renamed only_internal_clks->external_clk to avoid negation.
>  * Updated rcar_canfd_hw_info tables with external_clk entries.
>  * Replaced 10->sizeof(name) in scnprintf().
> v6->v7:
>  * Collected tags
>  * Replaced 'aswell'->'as well' in patch#11 commit description.
> v5->v6:
>  * Replaced RCANFD_RNC_PER_REG macro with rnc_stride variable.
>  * Updated commit description for patch#7 and #8
>  * Dropped mask_table:
>      AFLPN_MASK is replaced by max_aflpn variable.
>      CFTML_MASK is replaced by max_cftml variable.
>      BITTIMING MASK's are replaced by {nom,data}_bittiming variables.
>  * Collected tag from Geert.
> v4->v5:
>  * Collected tag from Geert.
>  * The rules for R-Car Gen3/4 could be kept together, reducing the number
>    of lines. Similar change for rzg2l-canfd aswell.
>  * Keeping interrupts and resets together allows to keep a clear
>    separation between RZ/G2L and RZ/G3E, at the expense of only
>    a single line.
>  * Retained the tags for binding patches as it is trivial changes.
>  * Dropped the unused macro RCANFD_GAFLCFG_GETRNC.
>  * Updated macro RCANFD_GERFL_ERR by using gpriv->channels_mask and
>    dropped unused macro RCANFD_GERFL_EEF0_7.
>  * Replaced RNC mask in RCANFD_GAFLCFG_SETRNC macro by using
>    info->num_supported_rules variable.
>  * Updated the macro RCANFD_GAFLCFG by using info->rnc_field_width
>    variable.
>  * Updated shift value in RCANFD_GAFLCFG_SETRNC macro by using a formula
>    (32 - (n % rnc_per_reg + 1) * field_width).
>  * Replaced the variable name shared_can_reg->shared_can_regs.
>  * Improved commit description for patch{#11,#12}by replacing has->have.
>  * Dropped RCANFD_EEF_MASK and RCANFD_RNC_MASK as it is taken
>    care by gpriv->channels_mask and info->num_supported_rules.
>  * Dropped RCANFD_FIRST_RNC_SH and RCANFD_SECOND_RNC_SH by using a
>    formula (32 - (n % rnc_per_reg + 1) * rnc_field_width.
>  * Improved commit description by "All SoCs supports extenal clock"->
>    "All existing SoCs support an external clock".
>  * Updated error description in probe as "cannot get enabled ram clock"
>  * Updated r9a09g047_hw_info table.
> v3->v4:
>  * Added Rb tag from Rob for patch#2.
>  * Added prefix RCANFD_* to enum rcar_canfd_reg_offset_id.
>  * Added prefix RCANFD_* to enum rcar_canfd_mask_id.
>  * Added prefix RCANFD_* to enum rcar_canfd_shift_id.
> v2->v3:
>  * Collected tags.
>  * Dropped reg_gen4() and is_gen4() by adding mask_table, shift_table,
>    regs, ch_interface_mode and shared_can_reg variables to
>    struct rcar_canfd_hw_info.
> v1->v2:
>  * Split the series with fixes patch separately.
>  * Added patch for Simplify rcar_canfd_probe() using
>    of_get_available_child_by_name() as dependency patch hit on can-next.
>  * Added Rb tag from Vincent Mailhol.
>  * Dropped redundant comment from commit description for patch#3.
>=20
> Biju Das (19):
>   dt-bindings: can: renesas,rcar-canfd: Simplify the conditional schema
>   dt-bindings: can: renesas,rcar-canfd: Document RZ/G3E support
>   can: rcar_canfd: Use of_get_available_child_by_name()
>   can: rcar_canfd: Drop RCANFD_GAFLCFG_GETRNC macro
>   can: rcar_canfd: Update RCANFD_GERFL_ERR macro
>   can: rcar_canfd: Drop the mask operation in RCANFD_GAFLCFG_SETRNC
>     macro
>   can: rcar_canfd: Add rcar_canfd_setrnc()
>   can: rcar_canfd: Update RCANFD_GAFLCFG macro
>   can: rcar_canfd: Add rnc_field_width variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add max_aflpn variable to struct rcar_canfd_hw_info
>   can: rcar_canfd: Add max_cftml variable to struct rcar_canfd_hw_info
>   can: rcar_canfd: Add {nom,data}_bittiming variables to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add ch_interface_mode variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add shared_can_regs variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add struct rcanfd_regs variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add sh variable to struct rcar_canfd_hw_info
>   can: rcar_canfd: Add external_clk variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Enhance multi_channel_irqs handling
>   can: rcar_canfd: Add RZ/G3E support
>=20
>  .../bindings/net/can/renesas,rcar-canfd.yaml  | 171 ++++++++---
>  drivers/net/can/rcar/rcar_canfd.c             | 278 +++++++++++++-----
>  2 files changed, 340 insertions(+), 109 deletions(-)

Gentle ping for review.

Cheers,
Biju

