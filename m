Return-Path: <linux-can+bounces-6111-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A042D13D1C
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 16:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2334B301471E
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 15:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67E0362156;
	Mon, 12 Jan 2026 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="el4MPhvu"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011020.outbound.protection.outlook.com [40.107.74.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3103E331226;
	Mon, 12 Jan 2026 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768233097; cv=fail; b=IHAZvg9PoYkBd7N++NN/fL1t96rbs11DBAjC1ql0WDZ1sEsgsGfGG3ddO79xKVp8qGtQNoXsMMeL4Fdz5GqrP+fcgZAHuM6dBuhNqjzvIfS80qCqnsNrmcAH50CfXkqrhrEdR9KRTqQDAvwjO2BZFBw0+Tc2bZALSKw5f+yivhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768233097; c=relaxed/simple;
	bh=b0P3bHBAL5RH0ceWQY3idt8L0TiCqeDga3IpslyhVgM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jFe/rmruY0P148WdJU0yr1gkeh/sAP9+eFqREDf8KqkVrryGLMk5HKXUXe6VzsfTLGacQbwAnGaEkGFiyim3KWxXqJKJLJA+EqM0DQl9qddRo+WIVwTSWk7RyhKrpg7zK34e/f593aHYlh9pjZT6J8WQzZtsl4bhLfyRXaHtH8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=el4MPhvu; arc=fail smtp.client-ip=40.107.74.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKBXddEH/q+1U5UhrWaI5xkBhH7Jy35POEQZfr7QNbOOpEbOPH8ezyyOIEyzR7rSUSB1SEM2cyhVpYpso9G/ZKwYBQx//e1c0r/OLVeoN044gW49qdWF/AigZpLKbxg2aoe4u/OXMt8Gj9qB5Egz8K97tv69bfrxW6RhYZXNf8A8wPGKOBywESJeOQ55Z9zASkQxYrbmOU/MGypWAhM1+gdyiWJGMFbHV0sCLmPZjWyuDRatDyu5qcOoNi1eaqJMmMki4Du9xjMHC5ZrwXEy3LDFVEg0nAaBA/mqAgHWKcFOm7gWCUpIi7L0az2uxHcKnJ2T9nKwj+azG9zEITZ7zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/WF0Zya4gaX5TtAe/a5gVtSd8P3K0k/swj4iLA5mnE=;
 b=IL8nedSiLTrzcDucvt+SZ+Ekf6o0C/PpfVzQsVla6EMtJZFmuTiNw7fAYe6WOYo2VTUPF94JLyflz2PI4MCZgDX17epIEVGTPPUXOsl5YDFCjoJfJbneNn2RF39t2h3+GfehNlYqJQTxyBr46UNAJV026ev2I2wvEZ584VRbeliWaL2+R1x85tEOXBJ9bhnO7iSQTjHfidz5Zk5bab8tMUvHlMNQHppHYiSJ9bnYcBxXoxDngY657gYY6bKlMI7zkoJ0sr+0xT3C2Y2A3QT8ihDmvZwvwqEHmNu2ab86RAkmoovm7Zf9TXFIolM7NqQOy1gAvUjn/nj1bTsjOoyrwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/WF0Zya4gaX5TtAe/a5gVtSd8P3K0k/swj4iLA5mnE=;
 b=el4MPhvuHCqsgndtd2/lOg2kJaXnhKh0LBLAZaiE7+tfxUIzaG9ETeW07cOJ7GMu6BlZpzO3kTeAOzohTyDuqCEIVBU7Cz92nhWi2j7iyYsV3+dVhT2kxjXbxp6gSaNcOrr8qcJ+x6csMNlmWYsawKvcl3OVqEWm24dL2+sl1dY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB10250.jpnprd01.prod.outlook.com (2603:1096:604:1e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Mon, 12 Jan
 2026 15:51:30 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9520.003; Mon, 12 Jan 2026
 15:51:30 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	magnus.damm <magnus.damm@gmail.com>
CC: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v4 0/2] Add FD-Only mode support for R-Car CANFD
Thread-Topic: [PATCH v4 0/2] Add FD-Only mode support for R-Car CANFD
Thread-Index: AQHcXu2fhdR1pKPEyEKRLFIPV1MEa7VO+JWw
Date: Mon, 12 Jan 2026 15:51:30 +0000
Message-ID:
 <TY3PR01MB11346C434E9B17EE780A010FB8681A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251126155911.320563-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251126155911.320563-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB10250:EE_
x-ms-office365-filtering-correlation-id: 23ff1099-0c0f-487a-cb99-08de51f27405
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?u69mPDf4DDv03IZvQVSyZmgwU/qm7ur/0tTukCjx1aaHkAule23UZI5LMSwA?=
 =?us-ascii?Q?YIrgSVbofZTZepA7grF8zGCwZWOv+2voILcI14+OOPBJvg/2bNSnC01ggDEj?=
 =?us-ascii?Q?IFZ034RWsVkdzrQ95O7Ckc0lKycKW07CEzmaGBC7nSK91Jdr8ETbV6vI0WDk?=
 =?us-ascii?Q?D6P2QRGfyMX2GU7bxqmdYsPZq/Q0BGHQXJohlvlRJycKgIKTUm9+7wrntgaR?=
 =?us-ascii?Q?fxf3UWHPn2w8YZoE15PhGM+aRFKhBl6nFMzuwJAA6GHh02BSkE1sQ3RV57yC?=
 =?us-ascii?Q?+1SMrXWUluFYL99a2f82uasYk4LJ9/qmvT9zxHb+BOAAXAm93tyDN2CaOIYl?=
 =?us-ascii?Q?184V7WJY9RNpx1G6XMvSOVGQJeYP5hBm6p36LiByzY8hYd/kp2qZQ5ImsFOt?=
 =?us-ascii?Q?Yv4fy4Dx0Wv9g9P2kz2bVQLqAe9rcCWx2rw2u2XnRnkpCYkFnKkH0UB5APhY?=
 =?us-ascii?Q?qSf7siVahVMu4jml1cCLLTcwL1yJOmillQSWFHGFThOo+YK34xyVT3j64Zye?=
 =?us-ascii?Q?gwcpaRUhoroZVyg9i4OjijhuCdFKrNBXog6S47qLkxrOZbKOrWMos79hP6TY?=
 =?us-ascii?Q?TNpfkXI180ZfmFQ1JRr808IieRXuH72rZZgrOYeTtCjgHl5oMQk3cMgv80AN?=
 =?us-ascii?Q?BQDG8+hgWCmHReFZzisZPaWlwT0DFxCCIKNKClCcMIe5cbo1Sx1JIeO++e62?=
 =?us-ascii?Q?QYxtQV31R3yUYF2Ppry/hBzgOOk1jlQnPm1kmvX43ViH96NI9LgRwwl0acAH?=
 =?us-ascii?Q?ySMiNenWJ+VUBAHwFwBAqJy11750eBWThjDpA7RIHKAhrWXGFAu5B/gWVO6H?=
 =?us-ascii?Q?wXMLt1s8umUIlYmMMKhmzHnx4x5VtsPFW014bogGs/ouymBIB7DWBWd4TQg5?=
 =?us-ascii?Q?Il7AUAh4hRyWEgbDLzQEHlUNK3oox6lKcoziG3mFYykp0C2vNsIkV/1eGlxt?=
 =?us-ascii?Q?nuTmtfSI/3Q1CCxRWIauDZ/VngmUu9KyQGVOqhOFMtXOXNROMnPfpDWC4QFg?=
 =?us-ascii?Q?ZwzazqdXO8r4z9CyKVpu1vpUmNWSj9tgWS6BySMBYYIEFEJfoG0aHQTKXI4x?=
 =?us-ascii?Q?1Yqfx2sTzxc/LXviiYmnsyTmGk47/7BZanGFV6o220vgy/O0nhj+79c7tch6?=
 =?us-ascii?Q?XJx3+O5NC3qXLrTP7k+gcU9RPwEfcbOSIq18TiTRcQt25LkQWyjBty1dvCyg?=
 =?us-ascii?Q?rK/agLaLWfLQ7pLUiFruUEjc2nt9rqwrSW96gjdgQeZDc5MTk6uYtkhdCVYs?=
 =?us-ascii?Q?kCOkun+7/Cg82B6jqm6a8YEDE6YYH3wUWhmPdkKBh2lqvEKG+VMgXl1ub1IQ?=
 =?us-ascii?Q?BNMIfIfND4Tlge556YC/fndxBAcVVJ3kphD/dPRfyhrB9wQnbiXR+lBPtLzV?=
 =?us-ascii?Q?VIkaEwufXPUh29Nzqry1wpD60mTxr3EoXHZoW5KVms11sFFWK9Nkj16nwoYy?=
 =?us-ascii?Q?SYhN4cbuiXVJRju1aMRy0k6iPrUOPTN4WlQPNN9qjdCQ33T4auFt029m35AL?=
 =?us-ascii?Q?l0LfRaz7E7bg96mHNyE0jX705JFnYkX3SA9H?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AZzwCi+3/CtatJ50/lyuqz99+HJ1X4lKUGnYaaaPo7u5ZSy4sfFBErIuK2c+?=
 =?us-ascii?Q?89fXQc4cC1KxDDbJR4MYPV1N+oYlgs+XO3+ImklFwUStE2Az3gIK16qs6F5k?=
 =?us-ascii?Q?HtBToBVuWxpv6s2tt7RR52zqHy6g4E93OQ7vCzEUhpHHoBti82bW9Q/q2NdV?=
 =?us-ascii?Q?xII0F/UQ++xlAmcplVxuKl+MWZ2ldKH7jRUNiuC7xqKVLELCZk0rHQ3xC+DF?=
 =?us-ascii?Q?Rr6RMyfZoxRLl4rj9vyvDOCm5Sv5A5gJqvfcBMTPaZ7K/fkG8/ZTkDhUc6DP?=
 =?us-ascii?Q?/N7dHNBv7wwFaR52RqLcfPeI4I9/1wowfDOS2o+QxM2hNhptVRyBm8aDZSOA?=
 =?us-ascii?Q?PKE7pQOIVfpMkNndRgyix0OZJaAnHTkNKBO57KdYhaWbTdL2SYoTlGWnLs5O?=
 =?us-ascii?Q?b370KevEl+KSPvLxPVis6ZtdzduUHLLsXhf1vl21Nu7JKy9sRPqBvTyfwTVV?=
 =?us-ascii?Q?iYMKITLs5sSAyOI7yAvOPpbcr9MTycwaBhDnwCg4CsohXFZq5Z7mxgOeKBFc?=
 =?us-ascii?Q?proohU7iA8eeqXvktUoCHTM5bkKBpnAONX4kUz/t2kqpADAAbrQvm7DjvB57?=
 =?us-ascii?Q?1WrMs9PrPu1brD/4dSERtfvzGK85uMgkTeXQ2RyuTtTpSKTyD9RRwmF4zvQ0?=
 =?us-ascii?Q?v2AUdBUYaAUJ6gxsnAgBoUij5NIW0misfN47OMYceuGuBN/GuCd2xpAJTfS0?=
 =?us-ascii?Q?0yXX2Fxyfm4eDqck/jRlBY1volSPPFzT8XiSuqwruN0UR8d1y1unstQZyyli?=
 =?us-ascii?Q?9sALYf2cxgrf0jSWTof5kQa00lUHKI2PpemxuOyyCSy0DeqC0OiUw9GvVdF7?=
 =?us-ascii?Q?RT71xvyaRPF2kXXxHwBSj49ze3PuyLk1+NAojxFG6pZsatsNL2u/Fai7KQ/y?=
 =?us-ascii?Q?0gMc/9lndzhL84RNI+rPICboApa8WcunsotvqJ46lGQByTll5Wq8rMG9Q1B+?=
 =?us-ascii?Q?20J2L6g+rWDOA64gCyIDslOZGzj2BXBE2lVHaJey28nKFWW1ZEC5bxquYzy/?=
 =?us-ascii?Q?HM0dIPY1ap8NHIyYZvohiXtDGS3v0pKCwWqDkexYyDbEHr12dzzxtNIdXsqj?=
 =?us-ascii?Q?1YozLEwpxG1n8spzz4KrcRAutFOrs1KhKwYZX513586kxbRVyiSe1mXXt34H?=
 =?us-ascii?Q?Y55CLfWgVGCAcmPJJZzn63Sm4s6AbGojAKfUPI4ah0GX9CJG/YBTnEnqlH++?=
 =?us-ascii?Q?YIJx4JAmsBmF5WgjfKZSl29XLv0mA+cjDn6JwC2w8gC/eankb2Z50Zw3NVlP?=
 =?us-ascii?Q?b+2Fumj4z3iz1DZtYs6k1BwJNExLk1ZgPXIC0Eq5JrTZGBJRkmKR5EJ5kkAU?=
 =?us-ascii?Q?Pjmvbpxb/DnAXxePuuv/q9k8szV/vEjwEs1maifdDJdYI48mJgS9vZwG5xX1?=
 =?us-ascii?Q?nri2F/lOrksdT6YPD1uulNnUYmLzNDbk2mWJQPcO3b9+Jk96dOlTJvPIUQVH?=
 =?us-ascii?Q?VLQiyDyBzOmtdpPidwWF0BiVKJPuEQoPGTg/D3KtNcB0kAEeE/R7W/eATWnn?=
 =?us-ascii?Q?wurOXfAf2jzByBGed0s5X2fuHHyM+Hqva2IgJWHrIxBrQ97qyseYafFwv9Db?=
 =?us-ascii?Q?iroukpxCK40s/1sza+oej6GI0p9wElblZFEtnoI4AmGQyL4pW5cd1m07YJU2?=
 =?us-ascii?Q?pYT8dWrD8a11eqbeBSEZppuxrl4gSgOdD32hwm1ls5XYe3aTvVmudOuQaTHM?=
 =?us-ascii?Q?7G0D22CyXsU14Y+7XESnflbSnZ00umMQi7W3+0JSCq6zUBK6tjfkG+b2HPNX?=
 =?us-ascii?Q?v0W2YYd6EA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ff1099-0c0f-487a-cb99-08de51f27405
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 15:51:30.3476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gL9djC/TQHJDBlEmXRclZlO16p/GdHhlcWBuHqjYUZnNIpvbpfkj37qYjvMj9TAAlyxGyFmJmMRJmdHXJJlGu95FRND1NeekqhW51U0cw3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10250

Hi All,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 26 November 2025 15:59
> Subject: [PATCH v4 0/2] Add FD-Only mode support for R-Car CANFD
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> The RZ/{G2L,G3E} and R-Car Gen4 SoCs support additional CAN FD mode calle=
d FD-only mode. In this mode,
> communication in Classical CAN frame format is disabled. Update binding/d=
river to support this mode.
>=20
> v3->v4:
>  * Dropped the node added in example for just testing.
>  * Dropped the dependencies from covering letter.
> v2->v3:
>  * Added check to disallow the usage of both fd-only and no-can-fd.
> v1->v2:
>  * Added conditional check to disallow fd-only mode for R-Car Gen3 in
>    bindings.
>  * Dropped has_fd_only_mode variable from the struct rcar_canfd_hw_info
>    as it is checked by the dt schema validation.
>=20
> Logs:
> root@smarc-rzg3e:~# /cip-test-scripts/canfd_validation.sh FD-ONLY
> [   13.914196] rcar_canfd 12440000.can: global operational state (canfd c=
lk, fd-only mode)
> FD-ONLY
>  [INFO] Testing can0<->can1 with bitrate 1000000 and dbitrate 4000000  [I=
NFO] Bringing down can0 can1
> [INFO] Bringing up can0 can1  [INFO] Testing can1 as producer and can0 as=
 consumer  [INFO] Testing
> can0 as producer and can1 as consumer FD-ONLY  [INFO] Testing can0<->can1=
 with bitrate 500000 and
> dbitrate 2000000  [INFO] Bringing down can0 can1  [INFO] Bringing up can0=
 can1  [INFO] Testing can1 as
> producer and can0 as consumer  [INFO] Testing can0 as producer and can1 a=
s consumer FD-ONLY  [INFO]
> Testing can0<->can1 with bitrate 250000 and dbitrate 1000000  [INFO] Brin=
ging down can0 can1  [INFO]
> Bringing up can0 can1  [INFO] Testing can1 as producer and can0 as consum=
er  [INFO] Testing can0 as
> producer and can1 as consumer
>=20
> EXIT|PASS|canfd_validation.sh|[00:00:19] ||
>=20
> root@smarc-rzg3e:~# /cip-test-scripts/canfd_validation.sh CANFD
> [   13.914196] rcar_canfd 12440000.can: global operational state (canfd c=
lk, fd-only mode)
> CANFD
>  [INFO] Testing can0<->can1 with bitrate 1000000 and dbitrate 4000000  [I=
NFO] Bringing down can0 can1
> [INFO] Bringing up can0 can1  [INFO] Testing can1 as producer and can0 as=
 consumer
> [   37.246104] can: controller area network core
> [   37.250607] NET: Registered PF_CAN protocol family
> [   37.291606] can: raw protocol
>=20
> EXIT|FAIL|canfd_validation.sh|[00:00:04] Problems while producing data
> EXIT|FAIL|from can1 and consuming from can0||
>=20
> root@smarc-rzg3e:~# /cip-test-scripts/canfd_validation.sh CAN
> [   13.914196] rcar_canfd 12440000.can: global operational state (canfd c=
lk, fd-only mode)
> CAN
>  [INFO] Testing can0<->can1 with bitrate 1000000  [INFO] Bringing down ca=
n0 can1  [INFO] Bringing up
> can0 can1  [INFO] Testing can1 as producer and can0 as consumer
>=20
> EXIT|FAIL|canfd_validation.sh|[00:00:03] Problems sending data from can1
> EXIT|FAIL|to can0||
>=20
> root@smarc-rzg3e:~#
>=20
> Biju Das (2):
>   dt-bindings: can: renesas,rcar-canfd: Document renesas,fd-only
>     property
>   can: rcar_canfd: Add support for FD-Only mode
>=20
>  .../bindings/net/can/renesas,rcar-canfd.yaml  | 38 +++++++++++++++++--
>  drivers/net/can/rcar/rcar_canfd.c             | 14 ++++++-
>  2 files changed, 48 insertions(+), 4 deletions(-)
>=20
> --
> 2.43.0

Gentle ping.

Cheers,
Biju


