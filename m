Return-Path: <linux-can+bounces-4327-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4DDB31C27
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 16:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AA21D63B16
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 14:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9873074A0;
	Fri, 22 Aug 2025 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="TYlTT6OI"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011035.outbound.protection.outlook.com [40.107.74.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E957C2FDC59;
	Fri, 22 Aug 2025 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872844; cv=fail; b=n93v9wsiip1nNQMwzQkg7ufgZWiRX/qa5tY+spS+REPRfGAtbtCIS++OSamtPOB78vxTLHGUqXWgzOysg2VuZOX9N55MTK7jlbfU76iHd4oKycYKnVBcjmrfVVdNAZp0HvJZq53hVe4Gy+e7lPP2gVtc1EBFJTYqG8229KFJ7/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872844; c=relaxed/simple;
	bh=XazwoD3nWu26rDgdrORF6tmRMjQgSsMhXpSafisoS34=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cLUxrWktsiavFTk7U15hS0PVtjWTURPAVxvzLxt2ujXS9L9Weu/LZyRFTuY0CSGVUkL2zTXVTum8o/UKzPaRdRjnteXwMFHrNBKWJ7L7QHUayFSJ9Gb+IroLpuhOexROb24wGZkztVfIY8yeYH5aErjr10qPWlRorPYiRZhLFes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=TYlTT6OI; arc=fail smtp.client-ip=40.107.74.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzL3pII2UDJ0JHq91G8GFAkqMirTjkZYNQMyW0AlSbco7KwFYfHaPf448sgw5Uv4PMEiQtESgeRbC2xGJzQ9hmbdk7VgYnRG/VZdPkTERmG+XDuD+aB7dLdbrbF7L6vh+ftBiAyE35kZws9cOi8xuWAY46s8ohlFSATYR7l9JQ5A1PQ4KmaPhFvZhKPHAXG10LIyqQN1TUsBzR5cPulwAKAe8FrSQaT6UPW+61A8zrzdTp36d2XngVv8zsPqH5QyEQMSjCxDVdPFSWsKQr0Fsl2V5TqWvNJtzQQBJFgxBNtFAl29Vt19fjLGsbsYICzUh/5Q4TpWAubjlj58jYcS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIFhqc5kB6pQW5D1ezt7766IgXKQwaOtt3k4+T8vIWA=;
 b=gkxLAiXjTe11taQ2Jp0AzQdUphYkUt+tGF2EHdZyD8NO3J4lhwCoGVPneSGQpD2Td8RqH+4WE8UO5k5uF7u2IqZneV9cVrwnDFIa+ef0rnWKs1K4cQB0ChKKlXxKuc6Pf5p7VSS2erGsRp27ke6amhb4PPE+sqXDs6FL8ftFMHlxIx3dxtfUMfiOx+MhFxDTG6UqOTxAw9kJBKTEJkwRSt8uN8PIjFlbVA41CHBmyVeL4F0Yxq0lCE/oLEBSQkZBvUtGhkZlPXj81epfClhQSRuzvOWVIL0mUAyBLCXkhiDUiHKx/B1bDN95KuBtZb3csSw8pnVnhE2hlzfCjkuVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIFhqc5kB6pQW5D1ezt7766IgXKQwaOtt3k4+T8vIWA=;
 b=TYlTT6OIdjv6oLGzSR5l1/8/Rr+cV1tjkY6OIAWw7BNStvDlh2jbfOMPvfe8as1b0ONLXVwPFHghnuW41V1mqQ7/eEakPue8pqENpOkJ2ncQ7Dj/izRB4jwxQIcm0XM6RDss0pTpCELn7eAQUn1LzbOXZA5q+AKEQSpaJy5AfU4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB11975.jpnprd01.prod.outlook.com (2603:1096:400:387::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 14:27:18 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%7]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 14:27:18 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 5/6] can: rcar_canfd: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
Thread-Topic: [PATCH 5/6] can: rcar_canfd: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
Thread-Index: AQHcE0pHuVULRlPiik2Jvs8LYJDFBLRuuwcw
Date: Fri, 22 Aug 2025 14:27:18 +0000
Message-ID:
 <TY3PR01MB11346467D642D0419396AEDB3863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <cover.1755855779.git.geert+renesas@glider.be>
 <fa657e1c325a62e475ad9e01e0c2ad2c3cc940a6.1755855779.git.geert+renesas@glider.be>
In-Reply-To:
 <fa657e1c325a62e475ad9e01e0c2ad2c3cc940a6.1755855779.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB11975:EE_
x-ms-office365-filtering-correlation-id: 9cd77a7e-658c-4870-1941-08dde187ffed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0e25t4qQNHefrZr1MtmjiIQWsAJjbEnuGSv2Y9U9HL7KNCUMYbidNG9kFTNM?=
 =?us-ascii?Q?DvQuZK6FlBoKSumFwWU9R58u1K/vgC9C69OTQ049geTQaXOhTM05kBtqGS4g?=
 =?us-ascii?Q?Arhy/xzFbWgtZsso3zsQxhtIcNO8I4DnnU0t+OGNEn4fpG2IDzySWkmhkg1L?=
 =?us-ascii?Q?Zq2Nsf8uRr5HJSoDGQ2QwvrC/StBL43ht2ZIuV3C+uOLoxuQtBKadHZUS26D?=
 =?us-ascii?Q?HejOhM7A71cVYAavgIoYNnm9Jhtr687uWZj00wyiOoKAghkRFRr7S292lEDj?=
 =?us-ascii?Q?OnFlU32A7NzZ1T29irbIJ8eba+dxKvYc8z//XX4YWCDnAqvMoDpyl7xk2U96?=
 =?us-ascii?Q?erbTlmbRy2sfXd0TCenN/TeqJ8JkYKB7bhyMk6Yc7EFUAkjCyO4WKZtOiZ2M?=
 =?us-ascii?Q?p3gMCekuDW9xY69Mxox7KA0zo3GjPiW6vX21q5k+WAxwUplNCyf8LufETOua?=
 =?us-ascii?Q?niOQDrcPHaPGkHHzeE+lMxFJgNzD/e2aBnESiCzZ7g0rZqKsZxwDwoOxeFA2?=
 =?us-ascii?Q?RHuUoFXr9pDV6UKyFHAmwycjvmcFBbH61X82Fm8oiES8H8j+v6b12GicIGPp?=
 =?us-ascii?Q?yISf3U0zdpByPIoarQgMFwTPvqb7Qd2up+W1DZws2p4LWm/3E+iOo+QXiqml?=
 =?us-ascii?Q?4bkyi89I7YB5XxUU82nfcymp4a3CQxska53YOp6xXOlRHwIv4nWqpnws4Cft?=
 =?us-ascii?Q?AkYpiodJtOawoqIR4b0yzDmAKt21MQAR7WpGzkNG3t0p1Kpr7S4xN3XocVHa?=
 =?us-ascii?Q?JX8O7+JL8Mgj1kYLy+wH0WDacnFxUoj2mmmZ4gwL7j3ortASMVW9Ykx468N1?=
 =?us-ascii?Q?YGUjnmH05VLnajg3nkfcm3lUIZg1rfJ08P9SvFAhYbVz994pAs1o/cxVi+uw?=
 =?us-ascii?Q?SXUAjd96Vtj2XjmiOB30MQ4S3CbwffVrgAyjU2WZtwj3grGj5v5lmlCLH060?=
 =?us-ascii?Q?CtTaI/ovVZG8pshOWVONxMv0drrY/SJbTGYi9+z5MrV+Re3WLGqZLv7UD6uH?=
 =?us-ascii?Q?SH1umab+xxJtzToRIf5rw2nKavN0M635gHctR2+f5c17t0ZF3ZUZbVCXJ99K?=
 =?us-ascii?Q?6CFuy04gznz3sS/fMMXP9jySSgb8VM63Q1ISjnIESMfk1puEvcfFZOD721Jz?=
 =?us-ascii?Q?S/bMDn949j8OdVJnxZe75D0WsOJ0kCP/9jDoeRW5xrWMBNIJleOTdV7zWi6Z?=
 =?us-ascii?Q?qL0mtePGylqdYiAtSLqmFEWaRCnINcoGrt5BnycPWFfpQ1CKIDcVsJl92duQ?=
 =?us-ascii?Q?cEfTcXNXHSmoc8xRO9aLRoFGcpsDAI0pEIAlM1vNqxG/hCZ0piGAnIX18TW+?=
 =?us-ascii?Q?xeFxpgE61TP9uLPoVo2uioyhE8mLEH+6j68+XRZNG79JLMA15CYjuHZcbnsA?=
 =?us-ascii?Q?XmnfGBEAWRyJ7cXL+pVe9Nd8qSHI7TIQFyaKxJ+7WfAJbunwkeDUHivZ2P/R?=
 =?us-ascii?Q?8FtIRevhuYo/YYWbvGLYhFsMrLm76fSaRYcQLowWPTCs0xcU3/kmVg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VMXXr5TgLp6Yo2scDEj13KAuMQmVglyzBTl/UJMBX6BabSF1ZiNTj6bQumQD?=
 =?us-ascii?Q?vHvanFnWBi6rnC/28oxMaQ6C6u2lAxj3S5H+GCQHo5Uhx5UXtQg2Wt3Jb1Ky?=
 =?us-ascii?Q?alPJCBxYK/YN7N0FF7j0pRbvr4qPkZ36g0FJuDew7ZepVg2xdwGmF0cVDjWN?=
 =?us-ascii?Q?f1HeJWf8+/QY8gg36HMbK32PQnVyUZXykfK9YA5Qtn24MmqNqttvff0mQSUv?=
 =?us-ascii?Q?ZlOLaRG/oVQIGxGy2qzUIq/FS0Q+HKTvfc+1u+4EVymjtNPf0Fz0RK17aeso?=
 =?us-ascii?Q?8Sw7EPsTBNgxqvZjcj7l7bbOO93m9aXzyntLBtTahFxH/A5eD0fTQ/VsOjco?=
 =?us-ascii?Q?DY/ujUz3HcTo8DmcjhCAP/KKmbaLqVf+msK6dEEM6SsI21FWq3vpsgbpRb83?=
 =?us-ascii?Q?kHJLBNhGgHAjr0S/n4N7B2LGIpT8X6HiwSZVGjmgmxRqO9zv8HfPc69YBjJD?=
 =?us-ascii?Q?6/4XodBIZ08avD3GUt3c9Or3BV+UjiT57koy5LTEX/ATLcZRFwvaZAZwILXQ?=
 =?us-ascii?Q?kbonGlxJLRqhwL3Zdk8Dow00QvtkOXhJ9KHFWoaosS9+5MI+i/RbcdV/xp5R?=
 =?us-ascii?Q?BxOlsAZDpvq8VcnFAVVyPp1irGo+5g0HGwZFjS24nbb0wFlV+RiOwT4ToqFT?=
 =?us-ascii?Q?PLec7zzZ2sffnCC2aLbnkOaya0KpT5Fi8XbgTQuml1JyuL6sZhnsp4KyUgiN?=
 =?us-ascii?Q?Gwc+eMV5evl8QETaCFeciBcv6C2V8zYoIQz0cRg/+WaDNouIENDeo8kfwe08?=
 =?us-ascii?Q?AtquZ/hH449FgK3U0MNsjQ150N/NtesijsvhmGznjPOnnJcri8ICXeAQto1d?=
 =?us-ascii?Q?NPuD6roqWFpMUhmQ49BzjKXBm/H6s1N5RtDm0Pau7in06Pivho4gL7N1Jh8Q?=
 =?us-ascii?Q?MCoGvj8/vl4DqtxiD/HG/4qtgtCIntFOJWpaCqoBAP5GhevFk/FSx7xU0jfp?=
 =?us-ascii?Q?UaxnljIH9y7vrgDgSOnbbjeq/kSQLx+gHkrU3mkVdjLhNPFbvofTAZZ6X6Cm?=
 =?us-ascii?Q?fLZIa9h64RKcBRacj+tg8g22Wxo+YjUBz537MXQC+70ly0RcLu/Tu9iMnnqu?=
 =?us-ascii?Q?LBgWTTVyLAUcl99ykxD+kpznL98oZVY3p9O5QZyb/PfUop6hKOGjF2ZdeZYR?=
 =?us-ascii?Q?9JLEzy95d8WQymX7D78VrdCciFAZ2/PZnsf1XpqFjdec3YKaGXwRbloVRf4M?=
 =?us-ascii?Q?SBQOURI8Evne4FReNTXFZO/FEKCQvKt4PET4nhWdVa5enb+CrE7TPlMwLoDy?=
 =?us-ascii?Q?ioHcZuEx9Xlkjo8CLRjtBt+11kBwZGADQsrA1Xvei0pZk9zfRW1Hd6e1C0Mq?=
 =?us-ascii?Q?Pmq7jsMksxgx1S/2CvQrHggzrrlhPaTZwUBeu7AnyD8+iznuHwEyzszIESno?=
 =?us-ascii?Q?3y/hms27PVCMdyl53ko1P2TXQh2kTVO21enLHVuXJWxHAy1JHVq+XIyIDm4H?=
 =?us-ascii?Q?08hFOLfHFBoxBDgtJGHg3Ts3x+275GIAVLB7ydLgjwJdUFwQEdXGECji/xc0?=
 =?us-ascii?Q?LOO1KItSWrEoOt8/bdB2K30Faq7WPVOiKVmm8BTUPIj9XvYoOxSTKxszER5f?=
 =?us-ascii?Q?p+M4eUCZdoDB3nhZyDFNqd+a7GElAG/dgJhYuzT1nPvo7Cx6goGWzP2dH7oG?=
 =?us-ascii?Q?5g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd77a7e-658c-4870-1941-08dde187ffed
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 14:27:18.3181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d6MLqbupN2yafg+fgfkAMLTVVMzPUxkPe7D0xE9Z7PRwJBzEoMr8JjvEdvdHzGaTx2hbamIo1wnbZANojDOhYiku5nellLKF1Oc9YLAzhFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11975

Hi Geert,

Thanks for the patch.

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: 22 August 2025 10:51
> To: Marc Kleine-Budde <mkl@pengutronix.de>; Vincent Mailhol <mailhol.vinc=
ent@wanadoo.fr>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Cc: linux-can@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Geert U=
ytterhoeven
> <geert+renesas@glider.be>
> Subject: [PATCH 5/6] can: rcar_canfd: Convert to DEFINE_SIMPLE_DEV_PM_OPS=
()
>=20
> Convert the Renesas R-Car CAN-FD driver from SIMPLE_DEV_PM_OPS() to
> DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the __m=
aybe_unused annotations from
> its suspend and resume callbacks, and reduces kernel size in case CONFIG_=
PM or CONFIG_PM_SLEEP is
> disabled.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

