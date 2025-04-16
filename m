Return-Path: <linux-can+bounces-3414-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F6CA90850
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 18:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D58AD7A6746
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 16:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83E82080F6;
	Wed, 16 Apr 2025 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="BZuxgm6t"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011003.outbound.protection.outlook.com [40.107.74.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC20191;
	Wed, 16 Apr 2025 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819688; cv=fail; b=YSjFKUDlGyFhQLHMsByyLXMkUtXox0CidzS9dwkmuMCWtmHmw9eREWAqSZmlhud4edxXtVMrTuuGigIubtSWrCNNFACqFZv/21o7f4SvY3pvg5S4wuBxblipIEf/9l+exmBF+KkZY45WAdL0eh23zziYznzyOq35IGXgsNr/Tcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819688; c=relaxed/simple;
	bh=bztcOakGlKJwhnwRwNf3gizTGJrT0GqkyaNYNP1PGwc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QlS5k20XjQ9bUa4HXpmM/E7YM3vhUCoN+5qHTftzfmu9T/20/evVKu6KaIRTuviGv50FzOeCkS5kp8uycqvpD+/wWAylX4OsM6LvzQ1M0C5cWe0ClaCip4sWIVpzAY6ft63zB5Dki9CyT4lttQ70Uqefd/y55xOLUvgsja4YeZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=BZuxgm6t; arc=fail smtp.client-ip=40.107.74.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxCIXjoWxk+CER/fKtBIZkhZH1Xdv243CfxiBh17AqwPxdDfdIA8pfnUyrqLU0rl3N/xgY0hYULRVnQfH2YB8X+uHz/7wxlldpaMZsLX6XF3Tk82bzXGfG/bNeFoZw4tLaIpoFxFTwPMcM6qE/tQjcT/4QsT++8hnXCSRi4lAffbIjqcLMfseNxcNpZTR4qE3AU7RDKdYX1xbP7XG7d3XXnYIO3MtyidXqnXTXPa9sfkqYHjIuy2ZqdMdoQWrLWfRqSwVqeNzS8UYPGZ99r6iQeudqgHA894pBR0WqQjsgoVDa8QLl42LN/WthMGjqq0b1zxPnuxwJy4b6BVMOCGcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bztcOakGlKJwhnwRwNf3gizTGJrT0GqkyaNYNP1PGwc=;
 b=k9zP7En/oPHtaG5hDX2DjkpNGfZlTuyYKk01ZQj8MJKdi/aCQy59Typ2ArOl/WJeHvl/zCEXrrrxVbAjnqVwYIBitT3lEXqGZU6dbCovxrK+Wy7JLWkyr1vNLEwb7C7H4uNFEtsa3fNDeszswGDtlz/wuqYtTS69UwKqNHXB+tQq/5df6jL+c+1YCbQEHoHWb1lpOMRmkuW0usOjU9yTWMqRqE8/ocQJTTFOjRctd/3l2UjBqUFEz48zwm3lwKjEFKgMWwlwZdXNeXRQVdNPplAjqYRgOJKr/C6Hutr4d/3l8kQ33o+ZpLjNCXIGnh5lsfApxBaIfqwVHLRzGFI3Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bztcOakGlKJwhnwRwNf3gizTGJrT0GqkyaNYNP1PGwc=;
 b=BZuxgm6tCjccC3s6jMCd+LSe4QBuWi1S7SUEOqEb0m/7oDaXeFlU2wWY/5VswXN1eMp+CbRZnW3UoTU5zU8aVA7aKOHtMM6FkXcEG6V3gnBw+XyE8PA+YqCzR1enqLEdiEV7tjo0THOSi5xldtJrC4fDk1F1dmuHRCsmtXLnAcQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB7801.jpnprd01.prod.outlook.com (2603:1096:604:17b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Wed, 16 Apr
 2025 16:07:56 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 16:07:56 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v8 05/19] can: rcar_canfd: Update RCANFD_GERFL_ERR macro
Thread-Topic: [PATCH v8 05/19] can: rcar_canfd: Update RCANFD_GERFL_ERR macro
Thread-Index: AQHbo7kz+TWxGxcpz0iI9MFwwDjMerOmYXAAgAAqLPA=
Date: Wed, 16 Apr 2025 16:07:56 +0000
Message-ID:
 <TY3PR01MB11346BB742B1BC44EB659721A86BD2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250402102226.28032-1-biju.das.jz@bp.renesas.com>
 <20250402102226.28032-6-biju.das.jz@bp.renesas.com>
 <CAMuHMdXT9sPDdcbro_8auzz4dRUTxwotuzninVKRmELcDNhfiQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXT9sPDdcbro_8auzz4dRUTxwotuzninVKRmELcDNhfiQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB7801:EE_
x-ms-office365-filtering-correlation-id: edb20842-5959-4f2a-de94-08dd7d00d9bf
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q1dYTmhiVGd1WTI3N1FRWVlDblFtSlN3QjNZOXUzWkxWdkJvbVRjOExvb3Bi?=
 =?utf-8?B?OFRqN05QQ1UxalhIWGpXRWdQRUg2WVlKK2M5dTlxUGdVeTVrNnVtR28zczlZ?=
 =?utf-8?B?djBDMjZJTjhGRWtZancyUDY0WExpeW1PMHhyTEJpdHJZVkUvNU1uY0MramJK?=
 =?utf-8?B?M1BVUGhWQ0VIbGdOK2N2dmpyU0pKbFBXZUNCWXFyODM5R1Vqc2xTa3dMVVFV?=
 =?utf-8?B?YXAzOEE1NldkbGFsV3ZSWkZvVnBxYU1YRFRjdFM4MnZmZ0YvWkpqNm81WEV2?=
 =?utf-8?B?QnVMWGtHQkhUWHM5UjRGL2owVnhQV3Awd1dEMHVDUHN4a2YvN0c4UEdsVUJP?=
 =?utf-8?B?RkZtblBVNnBIdERpbkpFcm9QZWdyeXB1cUZtTWlnTTQrSDQ3S3luRzdic3pC?=
 =?utf-8?B?MkcxajJBRFV0dEw5UGE4TnNMeU05eWZVSFNoVnpGeHNhdzRtVWZVeTlDR3g3?=
 =?utf-8?B?Q01VOThUTGZlN24wbEFYVm5SWGh6OTROdXJ2ZmRqdlcxNkhCS1hsZElOMEdl?=
 =?utf-8?B?empqL0xSVnJIWFFKaXhPMmdISVFEWnU1OVI4eHVjM2UyRmp0NnVOTllqUDVw?=
 =?utf-8?B?bHl5eXlPdUx1T1hldDdneHFxUmZIbFNqdG9kT1o3WHROK3BLdXhKdEo1WWE4?=
 =?utf-8?B?VjdHQW4zUG1SUURnMmVQWDhrV1N0VlJsR0hnUjlCR2xUUlZJVm5ldFhCWVZB?=
 =?utf-8?B?WXRHbzZqSU1vZzFIby9QQmFYNHZ2d2dVNVdEMlZlNjh6RzNxUW5DbW1ZTUlY?=
 =?utf-8?B?TzU0bkVHaVVHcGc5SCtKYUNBUGQrOUl4b0hDaFlSZmIza0QrbExBeFRmQlR4?=
 =?utf-8?B?WlJydEhiZHc1QU5XMTY2VE9mcmZZeXVmYlpDRlVTSTFRM2c0a3VmQWxOOWlU?=
 =?utf-8?B?VVZKalBEMlZmdFlXdzdkWm9SalFpOHMxdDN2QWZ4QkpxQkFlU05hcmMxRjE2?=
 =?utf-8?B?WXZHVGZKcUZCNUJ6WXByelM3K01LNWRydjJxdmhsbWZaTjBqblJLT0JDc2s3?=
 =?utf-8?B?cTNzWHFNcHJZMUlpaDI3TUo3RDNYcDBhVzY3T3YvQmhSbVRIQWJmOUZEN1Yr?=
 =?utf-8?B?RXdwUzc3cEcxSHE2RFdFYVAveTZnU01ITFpkMUFVZTBwQ1p6SlRxVnpTWVBt?=
 =?utf-8?B?cFpHZUNOd1BhaU1PNURNWEVQZm10QTNaNUtaQ1QxMXpKVlFaYjk1WjV3NnA5?=
 =?utf-8?B?Mk1jMG1mRTMzSXJsaHRsSHZkYmt0cWFBbVlaNFcvM3RzUC9vWVRkNWNZUm5I?=
 =?utf-8?B?QkwxeDVVNTJwREtIbkRuOGZvUnNCb2UzM0VJdnRzYVNTLzhMbnJGaHA3T3VH?=
 =?utf-8?B?VXk5TUgvT2NqWnRIbFBEeEUwNGFHakRGMExUcTNlTWhiRlRZUU9Hbm5ubWdU?=
 =?utf-8?B?Wi9LUU1WU0l4bko1NVIzZXRhclVJNkkvc21pNHQ3N2FTbUQrZ0p5ZzJEZkVH?=
 =?utf-8?B?OGRKcWxRbjk1Zi9HUDBRQlFUbFFoUk1HcFk2VDBZRnI4NmYzNnd0VUVUTGww?=
 =?utf-8?B?dWlqdkNGbVhSTFJWakxmWWljWE1CWEdxMHp2cnhuYUo4L1E3SlpGakhLRDFT?=
 =?utf-8?B?eURlTXVBUTlaak1IZGRDVjFCeHU5RDNCYlVaRTgyZHBlU0dYeFN4aUlNcUdh?=
 =?utf-8?B?MnkxdjB1MGp2Rm9pbjZPSlIxeUlGUVZxMUxmVEhqbFdrT2RTbGM0WXlJOTZx?=
 =?utf-8?B?V0lwVmlIWHRkQ1BHYmQyNEFuUzdDNFJtVHJmc2ZSVFYzWFMzNjBEOHJBVkp6?=
 =?utf-8?B?M2FtN3M2VWl4RDVtcjVUclRndno2RG5uYmxzTm9HU0NNNFpxSWtuVkVwLzlq?=
 =?utf-8?B?WTZac1FKVllzRWhZVmFjWTRlOTE4NHZ5ZFVsdXZpdTVLL2pySDVEdWFSdzUw?=
 =?utf-8?B?NXhOYzJTOS90YysrM0VaNmpxOWlpZFlNN2EzQndabGdlcHp4c0ZtNDVQMFhh?=
 =?utf-8?B?K2Z3QWRHbkhZZDZlTHpjUElqSVo4YjNSQWF3UjFCWHliY3JYaDhaZm1paE5j?=
 =?utf-8?Q?Bdj7ViLGSM+xweaCPV7h1f80kk5Id8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWI4M2Zha2ZKZ2d2NzBLbEV3STlMRWxBR3FxUkp5ZnJPTjkrdUNvbXF1aDAr?=
 =?utf-8?B?K3hSZ1h0ck01NUNIYXJDalQ5bk80UVIyaFdvcDlHTXgyQTNRS2RYSlJvL01N?=
 =?utf-8?B?RUd1cCsxNEF2RVdsdmhHU1ZNbGdtejZVNnY1VWdDK2k1N1A3ZHoxYVRmV3dJ?=
 =?utf-8?B?Wm1uVnYxWFV2aG5ESCtncW1kWE0vc20yNE15enRRRjNyYkJZbU1RSDB2VFlT?=
 =?utf-8?B?dHdGNEpNbkx5blR2bktZUHVEM05DVWtqZDJzRW83SEZXZUlCaXVFVTk1SzFp?=
 =?utf-8?B?ZjlsUElKNDNUWG9mK1pzZFJVK2E0cWMrcnNXRXV1MDNYV2pXM3VJckJLeml4?=
 =?utf-8?B?L2VOelRrbnJ1OXVveHBmejA5d2picWZ6VDVQd0FxTENkK29qTldsT1prcHUy?=
 =?utf-8?B?WGhZaUZVSmRVWHZqcmtCc3FSd2RZZnJQdTRNQWZQUE9USjlpakdPTlNiQzFQ?=
 =?utf-8?B?aFBHVGd5N2dUSHMyZ1lndmRFbE9FWkVOMnAvU1dKK2FoTDdkNThta2tpMENZ?=
 =?utf-8?B?NzFwaURUbllhNld0UklOSHVpOUtCREllSFBPcFVuRmxRbmNtakp5WXY5Y29h?=
 =?utf-8?B?K25WOGJiTjFGbmhlWnNQelhSRnRrdW1PaWFjV0JyTVJsblhubkQwU29zVTZw?=
 =?utf-8?B?M2VHWUhtdVBrWTFjUnM5b1FRUzFJK3dKamp1elBHZnp2Y1pnaFI2ZnRTTmFD?=
 =?utf-8?B?ei8wWWtacldwTHN3RSsvb0tUNDVKWWJhVFZYNGppQ3l6RkpBeW44WjhzMFdi?=
 =?utf-8?B?U0YzVjRtUUpaVWFtdWpOVkxubXpvTFN2RDY4WEUzMnc4REROZDNNOTdYZUlN?=
 =?utf-8?B?V2I4NVRZbnNET2x6bzVkdnI0VzZLOEc4TTR4ZWdSL0krZmxDbW15b01uRE9i?=
 =?utf-8?B?VzBSQWltaXBpajRndnFoR0NDN1Y0LzhEWTIzOUxoLzU3MW93a05Fa1R1QXhX?=
 =?utf-8?B?R3QzNnQrYnNGdEMrOVF4M1IwTGdtVVZPcW9QTTd4aU10R1RBVTRNcitFc1JM?=
 =?utf-8?B?U3dNdnhPOCs3S3VET0U1aXU5Lzk3NWw0aS9QVGxNZW80QVV6cWVMeEpkNldN?=
 =?utf-8?B?bndJcHprMEh6V1Q1b1pIRDVxRllwYUNDQnhEb0ZiUmRpMlJkT2VIRmRXKzVZ?=
 =?utf-8?B?bzE1U0NUMjZFVmNWZndnUmtyN3BxT2YxbWV3bkdGQlZCbWVwc0hPZWFqRmtD?=
 =?utf-8?B?eHZRQmZSN1RnUUFOdmVzenljcDNsc0dpV3NnOE5YT1UwbXNWb1dQcFNXWnNt?=
 =?utf-8?B?NDNhZGRQdXpaYjZyOXMxTm1heXdJSFdrWlpJL2RTcVJYcmNHWGNQcnplZXRB?=
 =?utf-8?B?ZVFOdnhaRnVSWmN0RlExZFo0MkZmQk5XQTBaeVRjei82WDZuVDhiMFNjWTNN?=
 =?utf-8?B?K2E5akJTQ3VwdzFUYnRXZmh2M0o1OVBxSi9iaUNpUXlDaGFUN0Rqdll4RndN?=
 =?utf-8?B?NUFmNEpaS0JVem1MRVNOb0d1TWVuSGxHU1lTMkEyM3lxakxiZm1yRDVSTERm?=
 =?utf-8?B?QXZmQmJlRUwybkErbWdXWTZLclJ0QmxZK3k4ZXVNTVZwWCtndDJoVmxGNEJr?=
 =?utf-8?B?cmc1U25aWXNzdzZZeVpBR3J5N3ZWdmVZZmkrME1UTWVqaUErdkFBcHUvKytZ?=
 =?utf-8?B?ZlBpTHNFdVBxTitZK25VVENSdzNpSC82bXJFcDlZU0lRUjhGVU9KSDdIWmtN?=
 =?utf-8?B?blMrOWhqVGJVOXc4cHlETE12eHdDKzhDcVRWc0VvL2pOb1dkd0RjTnlEN241?=
 =?utf-8?B?bXlMTk1lajV0VjFibXRsdmdFUkZtTmd2WVlQc1pEUDBJeVlvRkVFMWpyTGNv?=
 =?utf-8?B?Y1VGbHZXRjBMNVR3TCt6eW9ZaDBITGM4L2tqc1hqK1NFWTAvdjRiWnZKOGFL?=
 =?utf-8?B?WkFvZjFQMzE4eGxaMXpNNlhFVGRwVVFCdElOWmgzcmNubWo1eFRpbG5xa0VL?=
 =?utf-8?B?RVN0ZGROTW9UanJ1T01DNHVaMXc3Z3lVRzI4dkdLOUp5bTEreGFDeU1Lbm9O?=
 =?utf-8?B?aTNSYnhIdEJDeEtwSUI5MWJvMi9XU0F1eHpFdFdWdlJEMnYxc0MxUVA4cnVQ?=
 =?utf-8?B?N2Y4cWVXTVBNdjFmRGpzWFJMOUtQczBZVndLa2NvaWVYSmxOUm9rNWVxQTdV?=
 =?utf-8?B?RU9mOFQ3VTJmczIyeUJGQ0lyK3hGMXhNelFISi9SNDdnSGJKMmFRVmtZaU0r?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb20842-5959-4f2a-de94-08dd7d00d9bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 16:07:56.2719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bQ27yZCbiu4TKSJJWUMp6qkbn9n+Ow5bS9lPJqbCgRjAv0k4AruyhQ06E8hfykVd/P7q4woItUmu2EThfU7xw7p8SOzHrRaJ5hihwH7oLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7801

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDE2IEFwcmlsIDIwMjUgMTQ6MzYNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2OCAwNS8xOV0gY2FuOiByY2FyX2NhbmZkOiBVcGRhdGUgUkNBTkZEX0dFUkZMX0VSUiBtYWNy
bw0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IE9uIFdlZCwgMiBBcHIgMjAyNSBhdCAxMjoyMiwgQmlq
dSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiBSZXBsYWNlIHRo
ZSBtYWNybyBSQ0FORkRfR0VSRkxfRUVGMF83LT5SQ0FORkRfR0VSRkxfRUVGLiBUaGUgbWFjcm9z
DQo+ID4gUkNBTkZEX0dFUkZMX0VFRiogaW4gUkNBTkZEX0dFUkZMX0VSUiBjYW4gYmUgcmVwbGFj
ZWQgYnkgRklFTERfUFJFUCgpDQo+ID4gYW5kIGRyb3AgdGhlIHJlZHVuZGFudCBtYWNybyBSQ0FO
RkRfR0VSRkxfRUVGKGNoKS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1
LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPiB2Ny0+djg6DQo+ID4gICogVXBk
YXRlZCBjb21taXQgZGVzY3JpcHRpb24uDQo+ID4gICogUmVwbGFjZWQgdGhlIG1hY3JvIFJDQU5G
RF9HRVJGTF9FRUYwXzctPlJDQU5GRF9HRVJGTF9FRUYuDQo+ID4gICogRHJvcHBlZCB0aGUgcmVk
dW5kYW50IG1hY3JvIFJDQU5GRF9HRVJGTF9FRUYoY2gpLg0KPiA+ICAqIERyb3BwZWQgdGhlIHRh
Zy4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHVwZGF0ZSENCj4gDQo+ID4gLS0tIGEvZHJpdmVycy9u
ZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvY2FuL3JjYXIv
cmNhcl9jYW5mZC5jDQo+ID4gQEAgLTc0LDE4ICs3NCwxOCBAQA0KPiA+ICAjZGVmaW5lIFJDQU5G
RF9HU1RTX0dOT1BNICAgICAgICAgICAgICAoQklUKDApIHwgQklUKDEpIHwgQklUKDIpIHwgQklU
KDMpKQ0KPiA+DQo+ID4gIC8qIFJTQ0ZEbkNGREdFUkZMIC8gUlNDRkRuR0VSRkwgKi8NCj4gPiAt
I2RlZmluZSBSQ0FORkRfR0VSRkxfRUVGMF83ICAgICAgICAgICAgR0VOTUFTSygyMywgMTYpDQo+
ID4gLSNkZWZpbmUgUkNBTkZEX0dFUkZMX0VFRihjaCkgICAgICAgICAgIEJJVCgxNiArIChjaCkp
DQo+ID4gKyNkZWZpbmUgUkNBTkZEX0dFUkZMX0VFRiAgICAgICAgICAgICAgIEdFTk1BU0soMjMs
IDE2KQ0KPiA+ICAjZGVmaW5lIFJDQU5GRF9HRVJGTF9DTVBPRiAgICAgICAgICAgICBCSVQoMykg
IC8qIENBTiBGRCBvbmx5ICovDQo+ID4gICNkZWZpbmUgUkNBTkZEX0dFUkZMX1RITEVTICAgICAg
ICAgICAgIEJJVCgyKQ0KPiA+ICAjZGVmaW5lIFJDQU5GRF9HRVJGTF9NRVMgICAgICAgICAgICAg
ICBCSVQoMSkNCj4gPiAgI2RlZmluZSBSQ0FORkRfR0VSRkxfREVGICAgICAgICAgICAgICAgQklU
KDApDQo+ID4NCj4gPiAgI2RlZmluZSBSQ0FORkRfR0VSRkxfRVJSKGdwcml2LCB4KSBcDQo+ID4g
LSAgICAgICAoKHgpICYgKHJlZ19nZW40KGdwcml2LCBSQ0FORkRfR0VSRkxfRUVGMF83LCBcDQo+
ID4gLSAgICAgICAgICAgICAgICAgICAgICAgIFJDQU5GRF9HRVJGTF9FRUYoMCkgfCBSQ0FORkRf
R0VSRkxfRUVGKDEpKSB8IFwNCj4gPiAtICAgICAgICAgICAgICAgUkNBTkZEX0dFUkZMX01FUyB8
IFwNCj4gPiAtICAgICAgICAgICAgICAgKChncHJpdiktPmZkbW9kZSA/IFJDQU5GRF9HRVJGTF9D
TVBPRiA6IDApKSkNCj4gPiArKHtcDQo+ID4gKyAgICAgICB0eXBlb2YoZ3ByaXYpIChfZ3ByaXYp
ID0gKGdwcml2KTsgXA0KPiA+ICsgICAgICAgKCh4KSAmICgoRklFTERfUFJFUChSQ0FORkRfR0VS
RkxfRUVGLCAoX2dwcml2KS0+Y2hhbm5lbHNfbWFzaykpIHwgXA0KPiA+ICsgICAgICAgICAgICAg
ICBSQ0FORkRfR0VSRkxfTUVTIHwgKChfZ3ByaXYpLT5mZG1vZGUgPw0KPiA+ICtSQ0FORkRfR0VS
RkxfQ01QT0YgOiAwKSkpOyBcDQo+ID4gK30pDQo+ID4NCj4gPiAgLyogQUZMIFJ4IHJ1bGVzIHJl
Z2lzdGVycyAqLw0KPiA+DQo+ID4gQEAgLTkzOCw3ICs5MzgsNyBAQCBzdGF0aWMgdm9pZCByY2Fy
X2NhbmZkX2dsb2JhbF9lcnJvcihzdHJ1Y3QgbmV0X2RldmljZSAqbmRldikNCj4gPiAgICAgICAg
IHUzMiByaWR4ID0gY2ggKyBSQ0FORkRfUkZGSUZPX0lEWDsNCj4gPg0KPiA+ICAgICAgICAgZ2Vy
ZmwgPSByY2FyX2NhbmZkX3JlYWQocHJpdi0+YmFzZSwgUkNBTkZEX0dFUkZMKTsNCj4gPiAtICAg
ICAgIGlmIChnZXJmbCAmIFJDQU5GRF9HRVJGTF9FRUYoY2gpKSB7DQo+ID4gKyAgICAgICBpZiAo
Z2VyZmwgJiBGSUVMRF9QUkVQKFJDQU5GRF9HRVJGTF9FRUYsIGNoKSkgew0KPiANCj4gQklUKGNo
KQ0KDQpPb3BzLiBNaXNzZWQgaXQuIFdpbGwgZml4IGFsb25nIHdpdGggaGVhZGVyIGZvciBGSUVM
RF9QUkVQLg0KDQpDaGVlcnMsDQpCaWp1DQoNCj4gDQo+ID4gICAgICAgICAgICAgICAgIG5ldGRl
dl9kYmcobmRldiwgIkNoJXU6IEVDQyBFcnJvciBmbGFnXG4iLCBjaCk7DQo+ID4gICAgICAgICAg
ICAgICAgIHN0YXRzLT50eF9kcm9wcGVkKys7DQo+ID4gICAgICAgICB9DQo+IA0KPiBHcntvZXRq
ZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAt
LQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBp
YTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRp
b25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0IHdo
ZW4gSSdtIHRhbGtpbmcgdG8NCj4gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIg
b3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAtLSBMaW51cyBUb3J2YWxkcw0K

