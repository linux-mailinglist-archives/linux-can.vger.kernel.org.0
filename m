Return-Path: <linux-can+bounces-3192-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B4CA6B6C4
	for <lists+linux-can@lfdr.de>; Fri, 21 Mar 2025 10:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF65319C6A4C
	for <lists+linux-can@lfdr.de>; Fri, 21 Mar 2025 09:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FCB212B1B;
	Fri, 21 Mar 2025 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="JA5crPs2"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011056.outbound.protection.outlook.com [40.107.74.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E833C1F03F8;
	Fri, 21 Mar 2025 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742548198; cv=fail; b=oIiJW9W66OVl+gjX6KSy+GYJx38nhbyGNcYd4nqbY692oZBKC7llYbqaje8RQwg3PwW5XY5cQ+hJdtgnMtwG+DRX+Gv1P5C/V5ZKUwr4PjXlglW6iDiaq+1VRInsm/eRc/QhYi5OxPdWocvkEtixl9pIBK5d/sxvaGbcCG2OcY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742548198; c=relaxed/simple;
	bh=8dxtaPOL7KkYsIQGFW7fcfsZHhyF8yBQPonWH142Wz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hm6Hnv+hRE6FEQye1KlF06W8uokUuyH9equGkhp3fL07ZnOGTyICwF3gBAAlBOLPAK7Yz19EbxwrOSAWGocQs3bw8QRv3RhjQ46hr89UpZE22ymuyyQh6n003NhE7OLKLjPABVFmbY7vfndG7lP4Ne//EQm365ZI2/NW5V1WyzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=JA5crPs2; arc=fail smtp.client-ip=40.107.74.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uw70Zh/XxvFDGHR5l90QZCOhEmCAlaVb8WPu/JRd/GFjyIKKPs34Occ1XVMqFTx23KoybzGLUdEwzGrvVdNt4aFX2s9iCCaa1RciihsQkMM039IZaLRhnSPg9DxcAAt/8Ub90H3yx1U0+NtlF2+mNF0YF2h0CjhpN3nSGT0/OBilQdZ+Zptu27GacwBxeCjsdpdnBDkXfX5Rz8lODOWua8U7dAmgDU+WD1Y86jwJc67KmDx8c6wNhWTpFfboTx5lmwdXjoDs0syt5CmmsO+6JKA8a/N8Wm0MYwIMrEvv/iYeaG3sjbHMCFLzW/9Mb8GYdsxJtgaW36pJGqekbysdWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Szcgn13p4BmGQskFWA2f2jSHe4/ZIMwZDTLTigJaUfs=;
 b=jOB0tgu/qlf9UWs7A3g0u7A0bHHBvjwk8JsIJI7uA/PHVdE7hLuCwP81lyVplEbIBRLsSNJ7jzEWKeaFoD7Z4Fblg+GlsoAZttS37gGtDUrLRCm1e6q12xBdYmhxWSd7J1s9XecxF2B6ah22krKHA4xmy+cRgee54hbf6NNChXRr4m4x8hI/aTymwqbOzOhdUwGexpxLB/ym8AqnmA30qNqSkbrI4nesmtgRX/RtFuNBXUz/Izs5CVSFZopGnzrwYIGV2UZkqOiogC+gd0P40KVH2tUlFJ9ku2FemcYI6R7JsNbqDZoWMGBtr1QTFD2DM5cddLcB18epKTBKwzvnPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Szcgn13p4BmGQskFWA2f2jSHe4/ZIMwZDTLTigJaUfs=;
 b=JA5crPs2SiJZDV0WPQuSejxK5NeSrAefW5tjE1+h7N78jARIHwuRUBikr5GcQrG79YMdXRyMK7UqjlnFoRoaXnzliJk3bSKdUQtFaBX67se+QP+xbtjz2LrOvHGDTE+PsdtArDqiNWM2a8sqKupfsDzB1euy2JjiqKh9Sn7PJW8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB15216.jpnprd01.prod.outlook.com (2603:1096:405:268::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 09:09:50 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 09:09:49 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@baylibre.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v6 00/18] Add support for RZ/G3E CANFD
Thread-Topic: [PATCH v6 00/18] Add support for RZ/G3E CANFD
Thread-Index: AQHbmXgHmSPBpEBLxEys/EeBP+gtyLN9Tssg
Date: Fri, 21 Mar 2025 09:09:49 +0000
Message-ID:
 <TY3PR01MB1134629652B0B20A2CC5E354086DB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250320091101.33637-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250320091101.33637-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB15216:EE_
x-ms-office365-filtering-correlation-id: 3d9791d8-a85a-4c80-ff49-08dd68582209
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?XhuWLx6WDf0vXDvRvFFdJ2/nLGvv/yGGOEiKu/p493T4Pc3xeH/+fRHDmN?=
 =?iso-8859-1?Q?rUDcyC+8KH9cbxSbDVBObg6/aesVCJoijr7RSTtcCrES5qMH0OUFd125Sy?=
 =?iso-8859-1?Q?4QoAfP4kpBSojEBurZRMRT3/slTLvSSxfGH1mGwhsVQkqL/eWgKBQeEUFu?=
 =?iso-8859-1?Q?ltJDd9rKx/Gr5eiXx5UkD7iTLiMUcAvQkDq1PAxLWX33+SViwvQdTByEyS?=
 =?iso-8859-1?Q?qgFixTKP0he4XP7aC/QzMEyzoWa4KHumh3Lq1WVk06cr1EYtRMNUYOJjgK?=
 =?iso-8859-1?Q?DOg6RdLdAe5bjvAlEGGOCRTBzHR8BaJ0ZBMrNQmxu3WoeU07la2YcmRUKG?=
 =?iso-8859-1?Q?jJImc1mVEgM+BXCHugaOVy+SlriOZE2T5qGmWZQAvDX1T2vL/LKaXkFPaV?=
 =?iso-8859-1?Q?Mp6R6UVCnLSXFFbODRD6ppb3hmljLAbq68skpdkkQQKCHVr2JoiNgDGdTU?=
 =?iso-8859-1?Q?STgXbYWmDlN5k0+ii/+6gxGlkjtcbSUkP8dUjytksOV1+RJCM5UDFfVJF2?=
 =?iso-8859-1?Q?EGcFU1T6UsrrCI0HML6hSBdueLqH9LGkwghyz7oYp13QavPbKpjN25q0QA?=
 =?iso-8859-1?Q?Xo/kjvq2kY5s8MojTo+Q5l3l604ioS/hg0x19A9FJ4AjolCecqU+58oJc2?=
 =?iso-8859-1?Q?41YoBgM15N4x5jDyaA5nRKI3txddy5JEQEWqUWsSzdF7dBuKZW8R7UHqFC?=
 =?iso-8859-1?Q?6P+sNe0qmXP4uTiOZ5pwtQ1/v4FKrS48PMlxwE4VytKC9Z1bb6PF3Wu+4x?=
 =?iso-8859-1?Q?AiHStiwQ1FPU9eZsdcw5TWxi1iXJz0jcRhDYfPU2eOlZ1NqEisWb8T448R?=
 =?iso-8859-1?Q?+AM4tri4fB54aBvZnvPFdRzwqOvLWuy3SLG4VPYILvB1OT404+QDx6sCmi?=
 =?iso-8859-1?Q?iabMQ33RjJlqHqiHUSzx0XCdyB/VTRfNEdcsANIIl57ymWZDCoPYX9LPCr?=
 =?iso-8859-1?Q?DHUBAQ20qf4Mifipnkqr52vIK3SE2hkx2VwcXxu0+UCUx/vcOTyWtESxLW?=
 =?iso-8859-1?Q?5XxNTl9QXz+P7DCWCD++UtvYM/Fr+YHLcUB7FGyekVUhtHJAhfNN892Ylh?=
 =?iso-8859-1?Q?UH4GAErTzslHe7sNuZ5P5GhGqwrfVgaGE7J/oK6y1N6jaF5CDF8ZZeaJgZ?=
 =?iso-8859-1?Q?W3bx4ukHFZQMAnfvfJci/ZERJdftzU4lXwl/2ANi0jHNzFiEAkV+pPngIR?=
 =?iso-8859-1?Q?QASB87NDer4YxhunOq0PTsjlvJxMOJoPVJ9aXWjkLdwAKsz3xmgnvYC/ax?=
 =?iso-8859-1?Q?HRD4SSuOTtuMaaurtyGnsW4qcr6AnXuSNiStjMoI6SsPoEseJwjPeSXSa2?=
 =?iso-8859-1?Q?ZBnqgkjADihen2Hc/mQYNhGmWGHjfn2YYhBT7wSnOk63gfu3/vHi+84Pj1?=
 =?iso-8859-1?Q?5G0Pr6y+sn/BbKap22HlIogw5f6lDpnQ1KphhnBuai0n2k0UD6zPoMfNva?=
 =?iso-8859-1?Q?tO/e1B6J/wLaml/QETBXyxrNFpra+mCZrFJwJA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ItTgXqnuSwNnyHrOjII3cJQRM1Iz5hmXtyV8d+VJVEyOFt5t51qkbovJDJ?=
 =?iso-8859-1?Q?SM+R623UQZhkkTkvsfBOOHEhKRZYiot0HBr1CoT4AiA4OQXK2iy7+PFxYW?=
 =?iso-8859-1?Q?0SEpCUO8YDJApmtpEu2LVMWWtIFQ6QOQOLcB7SmbRJROne2P2vKeTHH2ZY?=
 =?iso-8859-1?Q?IfeOanEObWq2SrjK9566foZqoJLM2XbkU6/Rf2PORFrNU1Mx2T2irGdw0O?=
 =?iso-8859-1?Q?R7es9yROQBcFie5cNQaaPED6Z9KvXsWhiIbT+tits+lzaVRUgzrOpbaVVG?=
 =?iso-8859-1?Q?20Qea3ynJhqnPoc+zYanuRiKR1djyirJhTHz2G5zwGWdVcO8gi942ZYH/J?=
 =?iso-8859-1?Q?JneyL4mX2hOFRcHRl1Is5ExnAvl0oG0VFG3kbeODA7eLJPGyTTPmlYAkmq?=
 =?iso-8859-1?Q?+KuJHMOknUSXkfXWJ+dtdWQBYuTPnxQuYd6AU5TCrE4hKqnfKF0ov1vyys?=
 =?iso-8859-1?Q?J9HI6WaKMNd1v/R50n5dJuzW4S8vU7M4UuYzdi/iMDWy20oNrX5cyiP4Xk?=
 =?iso-8859-1?Q?nh7MHaIBwGUY2BpDnKyL3Px7ZfK7ULKUgQmwFE4Oq2icQP31toTA+P1noG?=
 =?iso-8859-1?Q?VqBqhyrZkNJESDn7eADkKs+/8RTFltKOtlHRW2fxDmQGiF2DLqpvKC4+KF?=
 =?iso-8859-1?Q?4f9MqhiC9sHWIBh10nV7Rmxp4r6baoE6Jyy7cZ3M3MSMk3o75C3pC7QF0h?=
 =?iso-8859-1?Q?rGljtlFOMxclZ8OQr76RkSA/Mr37iVkR72YZ5wuI0lmoizg7iSXJcKxBcs?=
 =?iso-8859-1?Q?Q6yHWXYXqWym+FSJ+K4Gddb4xsX0RPtdx4z3G/oHFhE6CaCKC1+irGJXag?=
 =?iso-8859-1?Q?rn4cVJUMjNxfVfNez/y38IOD49w4ooTBBdrIyUNjMAMQ5JSQeOLzPC2Odn?=
 =?iso-8859-1?Q?XAViyHj2/d15v6r4ishT2lmk5bylBSDK/ORt9/MfqtiHLsm4AvFS0ofOEc?=
 =?iso-8859-1?Q?4mjBu9Th/aUqh4DZx6Y7LTjxqxArp1dynGud26HpyVOxMcZYMb1YYsN7dj?=
 =?iso-8859-1?Q?S2S7t2GJtb9iNdibTEWrpg1Wz+pCKvgJ+ET3Y29+1O2fGtmR5FJVCVvxJ2?=
 =?iso-8859-1?Q?Jur0sMMoEOtq6ji+8XtBVG/PLhoeXovjcjk82Hfzc+F3JWRP0v6VMECjxB?=
 =?iso-8859-1?Q?zlFsaBM4KVJhLYWkblp2K6wFCkMiB44R1n9S1RZ/LPORdnZQMppY0mDB5L?=
 =?iso-8859-1?Q?7rqir5ZXzxTuPuNI1yx+aODZ4DrVcaHj5MZpS0c/vcCL0mVoU6FzIKcmtC?=
 =?iso-8859-1?Q?8q5eYflC0mSNKYuXKMx7yhSmQu2xG6cx7NwXvXQMbsHwVCLshUVsS0lvIB?=
 =?iso-8859-1?Q?defqNIYTay79bXP19nF+O3P3CrYJXDoJHEERwKuUuGuPwvQHfiBqLzi3xo?=
 =?iso-8859-1?Q?0xhhB105Lar5X9Qsfu54pECaznhDr/JFK6C+hq5DrPxwUOAvIuFA+W/Em7?=
 =?iso-8859-1?Q?prQ3l+YV7OnxdnOw9zVMfQ90e388fNy+llpoc89IssGUoXcV2CG0RrUjc7?=
 =?iso-8859-1?Q?Zv0V5/5XYLcQxm/lyEl/pJHTnCkgwfUeYR7whXTFePLrR1puB9bI6v3AOY?=
 =?iso-8859-1?Q?3expAQC72Wnh6cNixfaMwPGMA/QjsSTxx4jZqnDRd8qmdJDSwFDxFOGoEG?=
 =?iso-8859-1?Q?BTLhia6up9aN7KjJ9EaaDGTNnZQeVOzvgeLOiXoCeUOdCoZYuBnvWeWQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9791d8-a85a-4c80-ff49-08dd68582209
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 09:09:49.3718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3DqKpVD9CfqBsK322LFaGvuxXVjdmo6Lfmbhh2EkB5ICmUZIXiALmVAN9uzTs7Mia/AAWZqZ7mC5jMcveiEOaZQ/+ES00Jj8VH3NEDiRArM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15216

Hi Marc,

The Fixes patches[1] hit on net-next

[1]
https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/com=
mit/?id=3Dd5cd454825566989f97e0748e1047b9532338b99

Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: 20 March 2025 09:11
> Subject: [PATCH v6 00/18] Add support for RZ/G3E CANFD
>=20
> The CAN-FD module on RZ/G3E is very similar to the one on both R-Car V4H =
and RZ/G2L, but differs in
> some hardware parameters:
>  * No external clock, but instead has ram clock.
>  * Support up to 6 channels.
>  * 20 interrupts.
>=20
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
> Biju Das (18):
>   dt-bindings: can: renesas,rcar-canfd: Simplify the conditional schema
>   dt-bindings: can: renesas,rcar-canfd: Document RZ/G3E support
>   can: rcar_canfd: Use of_get_available_child_by_name()
>   can: rcar_canfd: Drop RCANFD_GAFLCFG_GETRNC macro
>   can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros in RCANFD_GERFL_ERR
>   can: rcar_canfd: Add num_supported_rules variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add rnc_stride variable to struct rcar_canfd_hw_info
>   can: rcar_canfd: Simplify RCANFD_GAFLCFG_SETRNC macro
>   can: rcar_canfd: Add max_aflpn variable to struct rcar_canfd_hw_info
>   can: rcar_canfd: Add max_cftml variable to struct rcar_canfd_hw_info
>   can: rcar_canfd: Add {nom,data}_bittiming variables to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add ch_interface_mode variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add shared_can_regs variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add register mapping table to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Add shift table to struct rcar_canfd_hw_info
>   can: rcar_canfd: Add only_internal_clks variable to struct
>     rcar_canfd_hw_info
>   can: rcar_canfd: Enhance multi_channel_irqs handling
>   can: rcar_canfd: Add RZ/G3E support
>=20
>  .../bindings/net/can/renesas,rcar-canfd.yaml  | 171 +++++++++---
>  drivers/net/can/rcar/rcar_canfd.c             | 256 ++++++++++++++----
>  2 files changed, 327 insertions(+), 100 deletions(-)
>=20
> --
> 2.43.0


