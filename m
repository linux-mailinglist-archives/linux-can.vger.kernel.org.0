Return-Path: <linux-can+bounces-4325-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E7FB31C14
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 16:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1273A66020B
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 14:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A20C3054CF;
	Fri, 22 Aug 2025 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="o5+K287F"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011069.outbound.protection.outlook.com [40.107.74.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D429322C70;
	Fri, 22 Aug 2025 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872690; cv=fail; b=e4TMk/KuRsqRF1ofa5Y4IVjC7n3UrOCQ4kzm9oYf8/zTFy7A8sYnpyY6VNCQ+gxZORxlHAsocXMkTqmG4dSEUX4gIwu+niItcwL1KdubzfZmRQcnXnQ89os6veiFnVuV9Xy74ElYoy3uG0JRKW4q3Ts3KmrLIGtjcgkqIi3PeiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872690; c=relaxed/simple;
	bh=g8hKAp1cOeACbD4Me1MF9Y/uP/L3GjS8sjDG4EGSmds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rYanU6e3O0BJUKZneQoXUUJbm8RIfPh6ahLNVDUV3vXoK2+Jn7JatK8LGt5BkVh3u/LShAHk5O2O1Uh36srWUEaQTr/J95ItxpS9vLOBDNLr2/2kM/YeCsS+mWBSfQ0xrIYwKvdqBJGIZ4wE6r4vAURmu1EEbFvGqI4A1mEhj7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=o5+K287F; arc=fail smtp.client-ip=40.107.74.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwQe+6+yXqkXY1w7jpLZIeFqIV6XLGNYlYza098MMZbQ5wiNZBHsjS1Pje0/lSLLjZep2hoBeMHuf7fn6ZDuEAyPY9ork1+/RSIkx8hgwJ4q940rkeGUpCXeQbpMmcgOpTdSKqtQYcsqLfZjr3pI1K+6kfYHz1kE7m3mthIYbPRT+26WlABco7SetBdBpQeTTxl3X5vcByzMKlMwdyBlu3gcMaK7HOh9Qr2+r1kfFDkdNqdK0iL1+x4jR2Bl6I3GfFoVLr8xBH7fdiuGhGcJWoP+hxeUBpnXwXskOJNY/KrDshufmazRH3ma/RtpJnoMkUPjLyZ/8qc1RFJakRPP6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8hKAp1cOeACbD4Me1MF9Y/uP/L3GjS8sjDG4EGSmds=;
 b=GoiyKkrM0c6JzDC4t+nIUCPR4hPbcmROT95Y0A0ym2GS/+ZvTOQhzf4oJDYGj8FQE0I+SGqiyo73KI4U7heyF6fWFwsW8jcbDyciWEeu1RrXFeFCePpm9Nu4dkvad9+ziZhpNDHshEBNt6ORBq4yQD/Hw/mVq1Lz1JtExgpyD9uYZ0Aez0LqbLuEij4hhw1QLcrpWX0iyWqUpxeilkuEoRySqrmQxRniUr6vL3sAYZ21VekD93CCbJHpd1qJqMabQodBh0TDS6zGkgPvua1OEACg7nM8TaxK6m4Okm8WzANK/vQrA7Ex7ODzVJ6g33AucJ/alr7BybmeBo2tRBgmHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8hKAp1cOeACbD4Me1MF9Y/uP/L3GjS8sjDG4EGSmds=;
 b=o5+K287F3yvEOQDT8/ADpt+S5dyc6FKgvnweLnUtu7DDX+SvMEhPY3x8TA74QL1/d1mCU+ocp9KdJ0Sd7WzeggA73HkjHG2n1IBq8mYjbR3mskPOqIs0lQb50Q7C1aZZNTSnIKPcl113JDlb4EYu7E1SYjDfwnWraQRgKVAHVe0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB11975.jpnprd01.prod.outlook.com (2603:1096:400:387::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 14:24:31 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%7]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 14:24:30 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/6] can: rcar_canfd: Invert reset assert order
Thread-Topic: [PATCH 1/6] can: rcar_canfd: Invert reset assert order
Thread-Index: AQHcE0pEjeyYOgHaEku65WL1tzQIm7RuuZqA
Date: Fri, 22 Aug 2025 14:24:30 +0000
Message-ID:
 <TY3PR01MB11346F4D879EC61CB598D5FF9863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <cover.1755855779.git.geert+renesas@glider.be>
 <f48b37ece8058e0d94d79bfd9188fef046114c06.1755855779.git.geert+renesas@glider.be>
In-Reply-To:
 <f48b37ece8058e0d94d79bfd9188fef046114c06.1755855779.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB11975:EE_
x-ms-office365-filtering-correlation-id: 8f7fc49d-c34a-49d4-9880-08dde1879be9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?doI2GyKvdr8r2BVlCQMqeiMZhJ45LNXg3Hl1NaGnbfE65QGrzPCRBxjXRZKs?=
 =?us-ascii?Q?bNR5yfhqDIsjTGGV5zlKhQlg20d0rHtvD+eY1E7eLrIlPciiGa4q9YjjLhMi?=
 =?us-ascii?Q?HbvIqhGrisYSVLmOfopMCUqHVLzl6SqFptiGeRIh8xM/I+zLZLhMRXbpLvEC?=
 =?us-ascii?Q?phI9+dpZPOLiI0c2eolbDrikF4PACfnxHsx8XSC3kDxUKdb8go5H6h2/R00X?=
 =?us-ascii?Q?lCOWw1ssq7oA9CYBmH1k8o2i8kk0BdGKvdqX0dW9isOzdhxuWBDI8gKAvZPB?=
 =?us-ascii?Q?cFlWEzz8K1UKR/spa3iZUS2/solh4pJAc3C8TmiBD4n0V6P0RadNz7YFQvYp?=
 =?us-ascii?Q?H0IleCB9eiYQ8Tt+xjp84U74/VziQr/1BiIoB/onik5D9giq48ZevWnFjPUq?=
 =?us-ascii?Q?vhcDtJjn7YmZP1nSY3A3S8jrR+kbuRa2Ekt4rX75H7UiqufydoOkLphm/Exd?=
 =?us-ascii?Q?QPBjXzUR7/YYxAqb/Y1vpPjQ8IbuE+lnI5ovfFGMB0ZAq48WayOtlZ2JZinn?=
 =?us-ascii?Q?a8hYa1So15mix4ly64RAvwY2qqW60YUL8vsIcWagdvIGIsUXiXEHzrBWdTCE?=
 =?us-ascii?Q?kEGQsauPm070juPL+LbCpW9lVIc4IsrIiCBfWDapiwyCrEG9MXyI+hvMqpVv?=
 =?us-ascii?Q?XLJNZoQKyIrV4s3ko+jc3gYGfS2Lv9TsT3vQktlZnG4IjSwPl3+3Mtq/lpqT?=
 =?us-ascii?Q?j/Q8E1uhuidnH453NgLbtNjHuwWiK4Fp4AMK368s2jRpS9RsQRdsuCp7I0Uc?=
 =?us-ascii?Q?XYss4nqKFV8vqc8A7xp6QsnUu4FbyMn/lj4Phh9h5tUeF3lT0x3CCRFDKR/f?=
 =?us-ascii?Q?tSSd46W3JPm2hU7Ui6IeZM3lk53bRZtTDYmc+oTp4Lw6ktOSLFMTRLBnMaXr?=
 =?us-ascii?Q?PxOkGR2BOgfu8CRJX8xcDawgkYNE1CUhpnwivR6o1rWbLYLpcQ/UYSwTMUcQ?=
 =?us-ascii?Q?glJ6VEK+9JxtIhNkrOn1uuIt38RnWZq4YVMUpEFx51r9g/q/YtUyqS6wlVk8?=
 =?us-ascii?Q?WK8r3vzZ3CgNAjz3SpdiUqlXfYzgl5xQX2UEaJlmqIFFIBacpNwiHbbECght?=
 =?us-ascii?Q?bHdRYUsAAUbafRxlwT7xohBSzX8DlVjPWHgbx8EBsTzO7bYrZrwQPh+wKK5O?=
 =?us-ascii?Q?2xYkMcn2uuxh/2R6Yd8/7Xm09HCF7YpVEov3vA2iMA473oZ7KcEiacEz40O6?=
 =?us-ascii?Q?cT1wYCzSze5ATEzvKwuZgrBpSHC60AnK9x2F6Szo0mBoI3TRC1bpSBmpfxAj?=
 =?us-ascii?Q?M/lyOK4osYXTuhwRaRMGQTiykpBkMAm0GzWvGmb7D4lkIZxSCXWGFHFAAgvi?=
 =?us-ascii?Q?LeEtzmTmnZxOtU9nKqlRW/L6dGFHZhVzLNEpmLiC14Plp/kMm0HCpNzGHwCr?=
 =?us-ascii?Q?APA/j0d46rYXcSZll/2EkFGXvPCLM2N3P/DoenKIkJtvHP0q0lzSViGB/YB4?=
 =?us-ascii?Q?IfKCt118m/rInSbaWgtPJF8p/10vvbHwCJO32yGlxILaCcEHcvbwag=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aqHLufLCYY9qDm8ZVdNNlVfViCiMUg7mUp0LK0Zzwxam/E8UpcgEsZxHYXNy?=
 =?us-ascii?Q?KcaiV2mZhu4wjn2XITFpnpjJ8O+p05zg9a12E3Trd6UV9/xvhXc2MrNVKglo?=
 =?us-ascii?Q?waxSSnKoUx4CjX11m2gpRZ87mXuGdtBshOkfPdPm2QqMCX+6k3c6wktFMf4z?=
 =?us-ascii?Q?r3RHt+dMfqCMqcLHaEaoMoSnEdhjTXByUOp6lGZq+GUV9E0SkGMxwghTwSE7?=
 =?us-ascii?Q?loQG3Ai2sKec9+ECZDMAvd5y3voMbxnpp6AswqpKg3m3BJkyPAg9I5PFYFxW?=
 =?us-ascii?Q?Uk676GKusxnFp6vl5OUvjvilriEqzb2yi6hO4zGbN2b2phNGU+2wKUK27Krn?=
 =?us-ascii?Q?kmyxisAruryOY79WHwBdLoGg2riqbCJVyfEIdQdS6PNmMsDp+5hU9wV/eIhd?=
 =?us-ascii?Q?FRCUS/ZehPM6RCu/jhm3GzGvMQEKw9oGQVgpjh9NDH95xxr1iLwOemiCHMqj?=
 =?us-ascii?Q?90YMeNqkwpAdq1HB9ri7YjPhHUM1tR5z0HYXnfc6+TL8CPg02pj80Mu1rKdm?=
 =?us-ascii?Q?Sb7+WbQSeIRgAYFsbZRkjYDMSz/uBy4ef0hDFrFSxXDbcUxAhi/6tgjbM+6H?=
 =?us-ascii?Q?9MlPO6nVGY2Gz1RNg4T0sRedqxy7haGzl4DukHyvKjLlnhbE5nulax1kYKhB?=
 =?us-ascii?Q?wWANxRnL8YyP0qQgnUa6y7o2lbLjE2rVkuTgKhT7Ni8rAZ+8JlAqEu0ZgwHK?=
 =?us-ascii?Q?a74qOIeCYaej4V2cFBGKdVkOiM+oA1u688OzEyfLaNdIbiK60naQ0D37F80z?=
 =?us-ascii?Q?bmOcPMJqOgLOaQ06Ca05eOUTtcH5NS9u01GoPugDdymhyUlHxLD2dTL9O0D5?=
 =?us-ascii?Q?Qk8GXm9kfdl2k/cImR7lWCuoSytzQjFy49B+0oTnEeQCGfVcsh0e2/VmDg1r?=
 =?us-ascii?Q?iCNlUKDfcjzz6+fdi37EqDP5beAbRDKP2vmrCuwzt6twbWMlgfb7iwZubb6T?=
 =?us-ascii?Q?l1E2EY8SxDiSU0PUoSJTFKVaNtafYFDcniSn56HE6VlbaXMKVis1rDseIbUX?=
 =?us-ascii?Q?QxvzheiTzG2AzJbMvAWvK5EKNIlEWWsDDW7oJRsyNFycBM1AaksbPn5v3+w5?=
 =?us-ascii?Q?AAz5sUA0XbnsM/X/F6XFTy1ezU8G0l2CGvKNI6BXnHXdgJd1y6TPofpcHfbU?=
 =?us-ascii?Q?2+GIeDB7ZIYioFiEdrSGHJIKG67vxSkw9f480Qe6skZHWNUpogkVY5AmNOyZ?=
 =?us-ascii?Q?LwIZjqmb9om4eBFzHnmghnlJ/5TfRSllQXDZeYgwrpJWRRbDOaQQwkfrgtnq?=
 =?us-ascii?Q?54HLvAbFQxE6dni9Tr0rRjG2wYLCukCMraF24LiS2Ma8g+NS79eR1k1/JBqh?=
 =?us-ascii?Q?Bcv9p36s+EAwOUAGrj86Tw7uCG9NAbC4N1d7ebKerd7oWz+hkP5sKnEekPB6?=
 =?us-ascii?Q?uMX+2mjlXqXfgAD5cWeewqYmyKMjMZW3vDDLzkKdWf+g04V5NIylPWrxcRo/?=
 =?us-ascii?Q?SMxxLeBr224ZD0+EZAUyQKrgMrvQfF7rD/v5QnhIJkshNwa6wzuqba5C6z5g?=
 =?us-ascii?Q?7su6Op4P9gzP/kRgdd0diJkT/2/n1MLFpHGrxGVFhAxqF0tn7IY9+NIvErsL?=
 =?us-ascii?Q?Pfmt/Zbd/YEkq1rAFC/nmVKB2dDLPrW/9DdNjQSGskB2QdN0wMHdahPT054k?=
 =?us-ascii?Q?ZQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7fc49d-c34a-49d4-9880-08dde1879be9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 14:24:30.8669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vbXq050jxRkUCvZLYC0YenAY+XC8VrLPR2M+OSPaSiA6T+capg908Bph3bUGEikfHEC3pdZQL9CW9tfpndkr2n6BsvJmU02T0ONSnX8scqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11975

Hi Geert,

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: 22 August 2025 10:51
> Subject: [PATCH 1/6] can: rcar_canfd: Invert reset assert order
>=20
> The two resets are asserted during cleanup in the same order as they were=
 deasserted during probe.
> Invert the order to restore symmetry.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju


