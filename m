Return-Path: <linux-can+bounces-4333-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4DCB31CA1
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 16:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEDFD1CC1F35
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706B4311979;
	Fri, 22 Aug 2025 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="FD2N0jRd"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011042.outbound.protection.outlook.com [40.107.74.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191630AAD8;
	Fri, 22 Aug 2025 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873820; cv=fail; b=LicXaJY+C6lqfuTOCUuk1b8UY9P67pMtJIwUX4nwS/BeMtxiqJJDkJRZrTBCnXBnCrDa/nqKIlr+K2mM4BSmGhNBRHS6WZQ8YbP6xsejessxJ4IMQKb138jcHzNfWJaqO6G8U4OmShxnp3sFu8+HUcAzzUIjdRIG/Wftoy9+bEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873820; c=relaxed/simple;
	bh=SecVvJ3UMdWldpD68C2qmw1rz1py9BgpKAQvF2ZMRDA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gKwZzNiG5UcvTJrTPG3XKXIzDf29YuLJGk9Hiq+gjZYxPUQmi5s1LkVGaN4762GINCnpdKlk/WkvVUHGgFq5IU32ZS40oiBskAtaJ7WP1g+u2P53WDVwhzr/9xvRTefyqjQ+aJwOgqv2PG04ZeJ9q+5bgR3P2+AzeiHN2/uxf5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=FD2N0jRd; arc=fail smtp.client-ip=40.107.74.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjSrUv8kUAJSoD8C4Q/TdT84QvRKh5gRRboRaTTH4wsEV1o1XBaQamuiU/pogJ0mWQipKSub3M9eUzxS+jB+G8RfdY8iDmaBXmprVtqgV3/w4ww3CHzdDLMBiCI3aYUn5luDAMiO20waI6d1lAyxWt2Mf7LCXnJ9h7vqVM9OzniZF7mxkDrhCDRHvNzd+Vmxt0xfjCLFhzu7AWsezBfSi5R7K2y+7YDCbI856YpLtft3gNnLzCvUWXmP4AlxqYtt7JzKyTRJaLIQ9iQmnmvlWVOG04KPFDTI3RXGq7Lun0NXGv3bhScEl9AuAXnI0VqQ3WUlD3BDnWumlCmmVc5Gfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsZn4e8BXHlcr5ZzhYH3XPp6i7OwbzofFAkAzqdgs/M=;
 b=PUHr8tnhlRLuylHXauRQuI431nX1AAcM/g6+ST0ptYww1Tbx58qKbHTi6FxqYQ9HqWAf0l0mzIOLHvxCMjgKD847SW21jayZvDE40RGYD52bpMgBrwUa5p/V7RO08a5rMsjKj7giNNAeXWpNeERJGlhP1Y8ybYOp5bnEy8OfNo/YRAXu9bz8KpAxIT/X5MuzhBXfY8gaqTCWaYI1HqhzIIWlNVdp94xw1hbeIRg89oCo+2w+DJ0Xv3dxflTiO7ghREeQIQtIjzO284oKWvuVyRlf7f6ceV6p/Zc1tVUSjxi3Y5fVmbnqSoVtdmdoLb840NFsqnawbL6DSMglK3U1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsZn4e8BXHlcr5ZzhYH3XPp6i7OwbzofFAkAzqdgs/M=;
 b=FD2N0jRd/cDzQd8q71xWck5FXCOmEe/0sJNrVEmvMd/7/FIL783D4E4hu9WHA8jM4OJB9xsIqhALBFIFmYMX62XrPKBy/Q3gE3MqZkIgOCeVz8vTrZ3AoW5/1wvc63VX9sRoGmFBsvbkkzk11VARaqRUuW8jGqQMOyaFXvLKwZE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB14442.jpnprd01.prod.outlook.com (2603:1096:405:245::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 14:43:35 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%7]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 14:43:35 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 11/11] can: rcar_can: Convert to %pe
Thread-Topic: [PATCH v2 11/11] can: rcar_can: Convert to %pe
Thread-Index: AQHcE04b5lISDR8zJEmj+P5xsPH6YLRuv4kQ
Date: Fri, 22 Aug 2025 14:43:35 +0000
Message-ID:
 <TY3PR01MB11346A05C66746D0A867281E2863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <cover.1755857536.git.geert+renesas@glider.be>
 <adb2dc49c78b45191de410f645a5e423d341f94e.1755857536.git.geert+renesas@glider.be>
In-Reply-To:
 <adb2dc49c78b45191de410f645a5e423d341f94e.1755857536.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB14442:EE_
x-ms-office365-filtering-correlation-id: 337114f0-9960-413a-475a-08dde18a460d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mK9NGBLseh5sdNxje1UIpR0Ejv8uy3kLVzkzAPyE3uMxwKJXU4/25e+C3uUU?=
 =?us-ascii?Q?Ia/7Z8GqTG5A2z4lCa/ISN7D9G/W5naIBBQ71Okp6LS/4+SmrQSN4mNuIrlJ?=
 =?us-ascii?Q?bk3Xprm5LuYjo1IaSoZifIFfZkrtEq50ONUeSzFayfO7zGawKM0EHs58Cjtw?=
 =?us-ascii?Q?By/+VfLIufHcxvvqwFIUDQ/TTP6kL56OuKyNcPX4QfBaix3NvwhQ08xQE71J?=
 =?us-ascii?Q?+RurCChfhaVjZvMtCpvKNxqpnfsVJkuWXRtqT6GFehTPhPrbcZorJYyqU/E+?=
 =?us-ascii?Q?VmPakuFXHsxTR8tw469dzldN4nCEGRybUZF/SW6F3BXOpFbi2U22ScebFR6B?=
 =?us-ascii?Q?jJPkemBFVtQs1eNJxu7VYMKlohONlbxqWU4Mg35ZskMKb/h/Tvn19bHVzMxd?=
 =?us-ascii?Q?WSwXttn72OCNVOAvi/0ZCNQ4VxgeFDzPT8GC6GAxPg28AwClRiwxaymPvBfY?=
 =?us-ascii?Q?52uoGpkT/0WZmxaq/TLNyHCFHCMTK9XkjGAlpux4i86DckjzsfZE5UvcQGen?=
 =?us-ascii?Q?One+KEeqpmqeMAF0Hxwcev+4VwC9DQy9v5WqVnpTZzt1QbfYFo9jH0YgSD2s?=
 =?us-ascii?Q?AVo3MWDo4B0Crw2+Gv4zY4U3IE2tZHM7TYWoPjtt0LqxXBaKStsXE+8jUjzh?=
 =?us-ascii?Q?MpME3KlcA5FlfEZnF4Hzpk/p41TOhw6PsUwKVhMmoH9ViA07aT1M6izK7/vR?=
 =?us-ascii?Q?d6s1Pn5PuqL6riNuYwgdwIEJzcKTNN5yOnBxVd2lBiRXheyqydmP2NACd1Km?=
 =?us-ascii?Q?PAv01BVbNbJrmmVN3GEBaKzFa1ib36AHU22zE9XroHUbv+tkuKwIHRjOcF+r?=
 =?us-ascii?Q?H4ZZVx0S3pRK7zyuyYk8AyIFBu9dJGUSQo3blNdfKvMgUkwmq6upfOTnLpdF?=
 =?us-ascii?Q?MeZdRBIB/3UkW62X2I53SYysIFgIRXZL0/DljqX4/3beyX/Af5m1ubMPfcCK?=
 =?us-ascii?Q?7W8NJ9/U+u7eW+Zgh6sVcRpgwbW4bM1PbNksE6was26IUl95JesN53II8PC7?=
 =?us-ascii?Q?IUwcEnUGYFk3zPe2nJ0z/ALH1vvdhKAtskp9JcEkuPgyCsn9X3uubdS0OzaK?=
 =?us-ascii?Q?oejaaVZkSvp45+Tr+KsnXtpXF93TPxXARKr3aQMvXvwnMl6nxgNE4Te+vE5u?=
 =?us-ascii?Q?VfXOOv4pW27MLZJpWeCCVDxdJa39f10hyyMxd2xG0FiDahzGfNiOKFxenQgk?=
 =?us-ascii?Q?qK1CP0ijKN47wqttkwfkDQU1F9WBtCY6x0G1+IMy58WxssmGqBRcWRLpl4va?=
 =?us-ascii?Q?55TsX+Eh+Fo2tiu5Kb7uwwK1xBUlxhoFVwMbwCMNpaqOkDf6H5ASASv/E01q?=
 =?us-ascii?Q?WFenpZb+2cWyyBPtPAmotSLOFslDQX0VLVrc9zpn1fwPWYIrxZzusHyqUzEb?=
 =?us-ascii?Q?EiA+MptqqzU6im4EOfYqYC1P6r+8WGFy/5QiFXPjS/Xo7/vH48c3CGxMoKuM?=
 =?us-ascii?Q?HyoHWXv7upjW1Zj4X2woL0E5Vjnxs8x/z8erClUVhj8OmXd3c38I9Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6VM6q7xOAHymKHR5zvcCnKswdHucvQcrE8C45ICU0OZuepFDzuggABeSXs2t?=
 =?us-ascii?Q?GrvSqdiGIjZpFQXrWszkPI4k75kGWQKRdRQi8/HCNSL9QBG+0U/vpZKHH1vT?=
 =?us-ascii?Q?5tr+Sh0Akx1HzUEDCs3XxcZyLHN18DMsff0AM8YcZsZbW9eVjNIoz5zO7ObY?=
 =?us-ascii?Q?LxVGwdWwQTg/LtuTmt+7xHO/L5vGktI7Ac7FcA+3A+WfX2vCW0AtAlpKqqRz?=
 =?us-ascii?Q?61Z7Ew28VUqY0yEfJOVvhhL3iLnuGMPN/r44aG3gzwPpj7ePuHyC9IMYvrO7?=
 =?us-ascii?Q?5Vy4hSqa9mtqp8RskN44ZYPGkZ0otNINDp6Wk+Ecb12/C8sC59KfljMffbWb?=
 =?us-ascii?Q?qa0PnZmRtng+fgQm75wPpQRiDrFvZLrtCvQsDJzoQj4XkYqGL/53T/Jjhe+b?=
 =?us-ascii?Q?vKLUqlQf2V8CjrXCpeCpZBmBvpOUNf0P9fLMqCmYXfJjiJtJxlNvHJO8Hxxp?=
 =?us-ascii?Q?8y3O2wY1H6o4t1A3bLCUrx+2PjshYJvm1oTrtb9ECgFbPi/tj/Lj4QqFJ4ET?=
 =?us-ascii?Q?7pJ/NvNGtmQMcBS3f8ZQLfh3WB5iP/0OINjd/KwKtSqrKJNBTY9FSDh8lNnO?=
 =?us-ascii?Q?O7hq2gmnZ85rRn+QS1iEIONVevA1ttNE5xyW3pRKIJjeCQZk1K2ZMznoMB78?=
 =?us-ascii?Q?RPIniZpz3m3lBgpA/XyoesNFmFardZhWIpLYmUvcGdNTdUymyWqg+yFjlohk?=
 =?us-ascii?Q?iaJr4MrH2wyFD9exVBAQV8TJKtVLI94KOyHw1B/Ne4KSL9SPaGnXBr9iNK3O?=
 =?us-ascii?Q?sg+naMflLwvcwV9Pou3ww3CHJq+JjQcrLX6GdFFGj3yANG2QMCxwaLCSTvHi?=
 =?us-ascii?Q?5Wu4z/GrUnRqpNTeEWyvXW8cobBmf4dur3oUXrvd8Y9E3Pnrz4dHnemBeqaK?=
 =?us-ascii?Q?RlusK2qPeb2sdvx0AnJppe0KB7AIS8vKqXVUrz/ui4RTtfdHl1z3z/ELlcU/?=
 =?us-ascii?Q?qTtKI2hfccv7FdSOED1ZCgF0h+ELkIrbQxoAWNSBwBmrkasD5vJ57LnIcpQ/?=
 =?us-ascii?Q?I21vP1LmHvEYKcGHosm86owhKt3zmd6je1yoN+AIVoI69QDllC/okCzg0e/S?=
 =?us-ascii?Q?zMFpoXLcv5SO7MWPS/u3p5agnv7QDX6e9Z54By9RxsyagXChPV+cxYEkPo4n?=
 =?us-ascii?Q?f0HrzjDzJ7XklxgYv0T9VJIokl9bE+mBmGIni2x1Il/zPZUiidcDhNXjv9mc?=
 =?us-ascii?Q?FfGKQEo9Hc8rmBAJ/pz2Y//fGExy8dT+YmQH8gZ8c2iAVds9G99xplIUXH0W?=
 =?us-ascii?Q?5ObhK2F9m57hem5hfy1lZmDCpCTteMTG1W5EyjDnArp2EeRz/wryfzDQ4wCZ?=
 =?us-ascii?Q?JAKvpR7XMJdlbbnywJJmdIxsCe97BS9BQ15pVPg4gn0t5H1SMVTbAiaQbeBq?=
 =?us-ascii?Q?rHDZtHtkm9FKPpw4bXJXX+nE0AGlIXYL0cO2eftz2w3wNe2VSXpBaiRwKvz/?=
 =?us-ascii?Q?VMqrIPzUaBECi+ZbF/XQ2ryFcno0Sr8jBnhTkL5G9bwBTv5+QZ/95EjzuAby?=
 =?us-ascii?Q?A6xKD2DQhObnYceLhpkvDN2I+Uatk2fjRe311v9YFC9YFcRE9N8rPmfk8qMl?=
 =?us-ascii?Q?fi10dcBcrQtFHBz5kbe5/G7NU5BjaHFyLn7PXrTz8POlrQlAmNjmzw/EHJjU?=
 =?us-ascii?Q?jA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 337114f0-9960-413a-475a-08dde18a460d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 14:43:35.3007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 09J3eTJR1opspK/mDFCWfMDGW9KlIdHg9Tdaj2Uoh2PXRQo1UKKiGlJrMGV0hTsRAucTRatFL3uu1j6lxp1+nYTB2i6yPjA6UPth/TLsD1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14442

Hi Geert,

Thanks for the patch.

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: 22 August 2025 11:17
> Subject: [PATCH v2 11/11] can: rcar_can: Convert to %pe
>=20
> Replace numerical error codes by mnemotechnic error codes, to improve the=
 user experience in case of
> errors.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

> ---
> v2:
>   - New.
> ---
>  drivers/net/can/rcar/rcar_can.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_=
can.c index
> 51bf8f7e71824ac8..5f85f4e272054789 100644
> --- a/drivers/net/can/rcar/rcar_can.c
> +++ b/drivers/net/can/rcar/rcar_can.c
> @@ -521,20 +521,20 @@ static int rcar_can_open(struct net_device *ndev)
>  	}
>  	err =3D clk_prepare_enable(priv->can_clk);
>  	if (err) {
> -		netdev_err(ndev, "failed to enable CAN clock, error %d\n",
> -			   err);
> +		netdev_err(ndev, "failed to enable CAN clock: %pe\n",
> +			   ERR_PTR(err));
>  		goto out_rpm;
>  	}
>  	err =3D open_candev(ndev);
>  	if (err) {
> -		netdev_err(ndev, "open_candev() failed, error %d\n", err);
> +		netdev_err(ndev, "open_candev() failed %pe\n", ERR_PTR(err));
>  		goto out_can_clock;
>  	}
>  	napi_enable(&priv->napi);
>  	err =3D request_irq(ndev->irq, rcar_can_interrupt, 0, ndev->name, ndev)=
;
>  	if (err) {
> -		netdev_err(ndev, "request_irq(%d) failed, error %d\n",
> -			   ndev->irq, err);
> +		netdev_err(ndev, "request_irq(%d) failed %pe\n", ndev->irq,
> +			   ERR_PTR(err));
>  		goto out_close;
>  	}
>  	rcar_can_start(ndev);
> @@ -786,8 +786,8 @@ static int rcar_can_probe(struct platform_device *pde=
v)
>  	}
>  	priv->can_clk =3D devm_clk_get(dev, clock_names[clock_select]);
>  	if (IS_ERR(priv->can_clk)) {
> +		dev_err(dev, "cannot get CAN clock: %pe\n", priv->can_clk);
>  		err =3D PTR_ERR(priv->can_clk);
> -		dev_err(dev, "cannot get CAN clock, error %d\n", err);
>  		goto fail_clk;
>  	}
>=20
> @@ -813,7 +813,7 @@ static int rcar_can_probe(struct platform_device *pde=
v)
>=20
>  	err =3D register_candev(ndev);
>  	if (err) {
> -		dev_err(dev, "register_candev() failed, error %d\n", err);
> +		dev_err(dev, "register_candev() failed %pe\n", ERR_PTR(err));
>  		goto fail_rpm;
>  	}
>=20
> --
> 2.43.0
>=20


