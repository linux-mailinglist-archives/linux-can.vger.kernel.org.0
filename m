Return-Path: <linux-can+bounces-5617-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25EAC7E1BD
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 15:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6975F3AB794
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 14:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27D12D7D30;
	Sun, 23 Nov 2025 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="wemjh4Vk"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011048.outbound.protection.outlook.com [40.107.74.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925671DFDB8;
	Sun, 23 Nov 2025 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763907448; cv=fail; b=HL6taeSxcAhZY+4MNcNjYV8TM1X1VeH15+lLsboceCjI26NB7OukOpuzqCy15kJ1j6eyxmcwMCnfTKF71/M1ZAJw633f09diNWAE2OlXHziX6cg2b6+hfg+VBUUSMvOzbfbkCO7bTMOCC9oA298g81JwNVVQnf3UX89fsWcQYXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763907448; c=relaxed/simple;
	bh=fJrAzmZPSkjowKE4dTJmr86/RWk3Xb72Hp7hi4/hYn0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fWuDRQArMHXyz4KpEfvtjW9TatJggQ11Qvf69MyxI+Mw12KYU09+WWSZu/Zkt95Mlp5sQjo00odR6PsrEeA2LshTGZDcXnCN2l6u93h3nwBL7Tqcvm8YPjwiS8cuFqfBW/gmi+E10DGNTkh8qwxhfgsewqG6A/2KfGZ9C6qgtjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=wemjh4Vk; arc=fail smtp.client-ip=40.107.74.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GallgbZeIJtSadD1tgXmpWJGgBQmXCu9FSw8ZVE4zBdInLHrEJrArzbERoacNoCbgkuv9rl1EJIN28Und439FfTvfrDrIoNaHz3fiQDkPlSxJ+Y/6gtaZY5u3zwHnPKy2Z8Vk9XgN6UQ2yPN6mdY2QsYANR0Ul6AsxPSa/WzTHxoISzYFUpNcsCmNzayPssEsTyFdPOc3ufsX7Vrz1dGL/hlbVorYEMnBx3HlUT7fSiyP2y6EuDKIrP+smiPdPwpmyiHTNn1dH5V1UXHk6D2e0iXyPjdFLban9A6xti/hkLrOtdsJks+m9ubVomm83JaRS+9Ki8wBOkDb4MZQYJnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJrAzmZPSkjowKE4dTJmr86/RWk3Xb72Hp7hi4/hYn0=;
 b=wrRaVP/V4TN5bI6+6IwMjzFtpFcHtByq1q9rSpamCruoaRzfErALFUDNk7NXBle5fPxVX0DVXqNdwUDKKDXg5SAP5nON4pniclup/TB5TWwHNC+4bdIBibiPc17CuXOlKkpHq1aPYYhh42D9NSsKoEtb79fqWReR6OCeQce5MHmQzHs+5/1oh5Tc49+ue2ogrfJeS7GaNQ/G41cKvd1CjbC9ubVYQYJGxuyWJp1ftKlM4X4hggRTv/VEQ180w86KjvR5mm/jnGMBp6wfOP9kQxOXU8LZJkMigFekoIE3HlZEzjvoqCFnQ9mIXMjMubpdU55N1Cp9vEL8BMJc7IZZXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJrAzmZPSkjowKE4dTJmr86/RWk3Xb72Hp7hi4/hYn0=;
 b=wemjh4Vkcqj87rJ6hI3cwUyoIbxYDmzmdAXa98BQAintdKwBC/wqvql/hB8wDCia4C/YZ0aJSPirUHwxwxXZDyThhRFKfQvvswsqNlrnZ6OiXCLwQSG77CqeSllTj1uC3J8/xn/OZFUo71VQFucHGXUQUDw576L1fKSVffCIHx8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB13492.jpnprd01.prod.outlook.com (2603:1096:405:1d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.7; Sun, 23 Nov
 2025 14:17:18 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9366.007; Sun, 23 Nov 2025
 14:17:18 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, biju.das.au
	<biju.das.au@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent
 Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>
CC: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: can: renesas,rcar-canfd: Document
 renesas,fd-only property
Thread-Topic: [PATCH v2 1/2] dt-bindings: can: renesas,rcar-canfd: Document
 renesas,fd-only property
Thread-Index: AQHcXGubPTkKPcpfPUaJAr71uDlXKbUAQHWAgAAKwkCAAANJAA==
Date: Sun, 23 Nov 2025 14:17:18 +0000
Message-ID:
 <TY3PR01MB11346729E8758CFEF18C9E99686D3A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251123112326.128448-1-biju.das.jz@bp.renesas.com>
 <20251123112326.128448-2-biju.das.jz@bp.renesas.com>
 <3928e893-66e1-4873-a78b-75e38e746661@kernel.org>
 <TY3PR01MB113460EC3CED97F90FE121AD486D3A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB113460EC3CED97F90FE121AD486D3A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB13492:EE_
x-ms-office365-filtering-correlation-id: d5fd2793-1a9c-4297-320d-08de2a9b02c5
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjhXcjM1WVFBZVVRZjFSN1RROHZOTXJJUnUxQThaeXFIbFE1L3lhME8rYlJp?=
 =?utf-8?B?K3JCNG0xOUQwa0svNWJoSTdUVnltV3hyWGhWUU1zZ2h6S0J3aVB3MzhZZVV1?=
 =?utf-8?B?RDFwT3ZVdFhuTlNiNDJHWXltT3ZsOTg3V1JpSW91bjZWb0VCTnNnUm84enFL?=
 =?utf-8?B?QXFZUWdNVjRTVnF5Ymcra2dqK3hrc1Y0VGlrQWVGV1dQQm5CbGtlQ0R1WVRU?=
 =?utf-8?B?MW85V05BSDQ5MEMzOUorc3kxc1RYSlcxZkprNExodU5zalVxTm1yQndQZkl0?=
 =?utf-8?B?NHZPeGNEMlRCRFJhVllhQ0ZUUTlOOTVQS2VOWmNNaWkrblN0Q2U1M1BxeXRa?=
 =?utf-8?B?NThueUYrNDJKejlOMURnNHNyTDlLRmkyYi9PTFpidnc0SDVBejZIWU91dGVO?=
 =?utf-8?B?bGFMQWJtaXR1UzFQSnQ4OTUxTWhldVBnMkgweTZLdmlLUzRXeU8zbk1LSHRL?=
 =?utf-8?B?U28za1VCTURuamhOeWNaWWlUZ2pPVk9oY0JCcVplMzROOWlHQ2pmL3VBcVlL?=
 =?utf-8?B?SnlPSmJIU2R6NXJ5TU1VL3d4bERYQyt1REhPZFdvSnM1ZnZEbTE3YW9Ha0M5?=
 =?utf-8?B?TmFRbGxRWnZFNVh0aU5sbUFjbCt1dEdHQ3NmR1hob1ZBa1lTR0NPeU1JR015?=
 =?utf-8?B?emkxRHdPT3JMSlZKVW9TVlpHdC9BNjh5YVh4dEo5T3hDNUJ0WlU2a1MreHNC?=
 =?utf-8?B?M09xR2U1N053TjRObytyMGFWWG1XUk1sVGpObUhNaXZqUVhzZnpVK1o5dldS?=
 =?utf-8?B?OHJjOGkvUHVrZU4yK0FpTEZTSDd1cUllcEVBYWVldzFGcVM0UENDUGFvWjRX?=
 =?utf-8?B?bWpmRmtaemFTQlI3a0xrOENnWTR4Qk5RUlhHcmY1RTlMTm4rQnJ3L2JOeG1u?=
 =?utf-8?B?YjgrQWozdjBLa1Zxb0hsZENPWVQ5SEdDYUsyam8zb25NRDN0RVFsYVlJcys0?=
 =?utf-8?B?bTRzUko4bkJWL3RFQU9GR3RxdkNmYVYzQ2YwZzB6Ni9XVHU5b3A2SDBZQjVv?=
 =?utf-8?B?YWtDTkRUUXFZajQ1dkJ4OFMwd3NKaDRSYWwxNFNVbnUxOFZscWRhaUdYc09i?=
 =?utf-8?B?QTdYNWU1WEJrQ2NybjA3UnlHamsrQU5lblFsUEJDSUtEa2d0aWhQazREekNl?=
 =?utf-8?B?cEFjb3ovN0pHZ2FSaXVLbnorZ2tibUxjQ25tam8xN1JuUlorMzFtUUtjRjh4?=
 =?utf-8?B?WHgzU1ZxdDZGYWx4WWVUOVhBdm1lMnVYbXBTd2dOYUhEVVJ0TCtobktLZ2JJ?=
 =?utf-8?B?Z3pHWDlvcmhJNFVTdzNSL0lGL25NOGtuMm55T2ZSNk1pWnJIZkcyUVBQdGNU?=
 =?utf-8?B?ODZsMWg1WGVqeDJFQ1k3VjNYSThjZENHZFVUcWFES0hOejFqOWFXLzRHdmZF?=
 =?utf-8?B?V0E3c214bUtYb0xTcVlFN0EvbjhERjRZdUFUUnVZLzQxQm15ZDBIaUZhL21T?=
 =?utf-8?B?S3NIak9WZjhrNGV3dnk0N3IrejFydUh6UGdkTk5rZFNwLzEvS1Nzc0MzanF0?=
 =?utf-8?B?V2RCdGMzdEI4VmZxZDBwU2liU29OWGZJS3BkdnVkQnkyNlFsQy9vcnNXM0dW?=
 =?utf-8?B?T3NhbVNURlJ6QU9mYjhweU5GQUVVbXQybFVVWk9kUGNuK2ZweFFqS293NXha?=
 =?utf-8?B?SGhsUStDSTVBV005MksreHAwR3lVR0lld29xT0hYUkJoSXhiakplTGNSZENL?=
 =?utf-8?B?dGNQTXIra2hwaVl5SHZ3RkRKWHo1SHB4L2ZCeFlnOFVOWExsVVpXREozSjc5?=
 =?utf-8?B?NzAxSlEvbUtCRVV3Q0FCekR3STNCZFlZNStHU2hQclAza0YzUTd4ZS96QnNN?=
 =?utf-8?B?WXcrSTQrY05PMzd4N1VLcjRlT0pIdTMyeUpjazcxUDNBRlpzL1M5b2MzdVpU?=
 =?utf-8?B?MWJCYU8rSlo0UTNkNnpYWnBUK2JCdG80Y05mWkozRHhsdEN4dDF1UndrOHN1?=
 =?utf-8?B?emFjWENUeEVPQURvSVZIU3NlSUY5aVE4U0xHeERPOEhQU3ZxRnpXZEtpSklq?=
 =?utf-8?B?bWRlUFpvRURBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejFGbnY5STRaMUxNVDFMS0IxSEVsL2drcjdsM1A5WnAzaTg0K2RFUkkvaHFZ?=
 =?utf-8?B?Szg0ZXh1am82RHVsQW1IcEw5QmpwMWkzOHlOeWs5THhCWjNPcGJHdTFmZjU5?=
 =?utf-8?B?bWJQNS9remRRdTlYRGhaTDR3ak1VUzF3aU9BVUNyclJCc29WWWI3TlNzVnFq?=
 =?utf-8?B?OGpPcXdQOWVSbUNOTWVaa1dCRjVQR05mbnJBSkRodE04SWxJYnROSTBOS1BP?=
 =?utf-8?B?MGlTZzV4SEdQWVNVTmFhK2VnQ1ZjWUw3amRLYXVTS3BFT09UV0dIVlA2ekdx?=
 =?utf-8?B?OS9Pd1NmZlU0VnVVU2EvY3BhVERYZ09ldUhkWkJIRXhTTGJnVnNFNWVTUjVv?=
 =?utf-8?B?V21ZV0FVY1ZBc3BlM3VoaGhpbzhJQ0pRSzI5bjlyODlHdmFYRU13bTJML0JT?=
 =?utf-8?B?YXlQcndjcmJkamZ5UW1MaFNub1hKUUVRcTVXSTIyc2g2Q0VSWnMwa24xUzlT?=
 =?utf-8?B?RWNZRUlpeFh3OWhiTzFQdDhTak95VGZWdUNOSnp1MGRJQVVDWFNKUk50bVVF?=
 =?utf-8?B?UjNRMk9XaktFOU1vVlRpb0FrTFRPcUxWSHU3L2ZlL3dDaGozbGd0U2VQengy?=
 =?utf-8?B?SzVKVG5oSW00OVdQZUNtT3JWVk5HYVZWRGl3ZFZLZlJUZW1HSWV1SHJoSUZz?=
 =?utf-8?B?VGFxSTVqYUZJZ0Z5TWtOODVkQk9ZUnU2M2YxTmk0NG5TMFc0VnVDMlhjYzNn?=
 =?utf-8?B?dGhUVUJtTlQ5cm1KYjZTY0xUak5WbEM3OVFHdmZXRXJiNnQrZkdhVmlEb0RM?=
 =?utf-8?B?cHdURzBqd1l6Q0VtaFAwOHVqcEZyajV0V1RmVU5NcHNWODFxTUgzdVRNeUJn?=
 =?utf-8?B?bi9XN1ZGRGg1YkcvMEsxeUMxMGROYS9LekVFY3ZteHN2L2ZjVk5LNXkrd1Fj?=
 =?utf-8?B?SmVCdlJ0dEVWWldkZWRpbUdNMUx3cHVFbkk0WXUyOW5vSHJOV0dGZlVVbGZw?=
 =?utf-8?B?K25MUDZzODRIa3NCbUxndFpYbG1TdlhJbTRqY25zcEV3S0dkdC8zUC9FS1lJ?=
 =?utf-8?B?UjgxcnZxc2NPQ3hrWnJBNTBtZ2pMajB4NGQvUlZZWk9yZ3lzbi8vdW5sb2M3?=
 =?utf-8?B?YjIxS3JIeWJOeDVoeFdyMFp0V2JTemVZNzlSM0JkRzE0NnRXNHVlWHF2MDk5?=
 =?utf-8?B?MXUwdzY2dXY2dE1FNDh1V1BQd0JXWC8wZXNINzd0SDFET0NsMXNsNlNRQ0cw?=
 =?utf-8?B?b2tjYkxQRlF5cjJHME5HcTY1R09seHlaWTh1ZGphTVRtSWUwOW9TbGhvS3Fu?=
 =?utf-8?B?aC95Rk04ZTBZYklsWmJ5NWhWbFJWdEI1bXBLRGZQL2NDNndrdzRWZEdSb0xN?=
 =?utf-8?B?ek4vbTJRc1RNbk1yR1QrUmJZdkdLTFZzbFI5eCtXbEh1NThtanZPZEFpWlJW?=
 =?utf-8?B?SXFKc1BlNUo2NFIwaGFQQzhLcGdVVTBNTDNjeGxSVk5OYW1aTkhUSXRFQVhk?=
 =?utf-8?B?TU5YR0pFWkpYMkV6WXNWYXBuc09DMm11bDA2ZXI0d29OT0tmQXRGeUpXT04w?=
 =?utf-8?B?K3d4OXcySUZIK0R2VEZObWl2alZYNFVnYTN1L3BuUHhiRzV3c0UxMGMyTGN2?=
 =?utf-8?B?Q28wZ2F4NnJ5T1ZPZ1kwZ0t6ZCtWSjF5REZBL3hNeW94WHJOMDJBRXN6ZDdF?=
 =?utf-8?B?L3RzZXcxTkh0TVVtc1h0M2ZraHhLVENrbDVUQ1J6dmsycEN5b21WVUo4azdF?=
 =?utf-8?B?QkdaRHVZRlBBeCtVelhmSWhWR3VkdHVhRzdXNFgvTTdQeElmNEQwbVRXR25Y?=
 =?utf-8?B?aURLbklDUGJJa0FYYktqSlJ4VnRUeFFueldUTmthdmdDREFId0J2TjE5Tld3?=
 =?utf-8?B?SXk2bkxOa05ia0E3dm9pRjNaQnp6aUQ1bTVOYmU4ZXdSWWg3N29QU01iNWdy?=
 =?utf-8?B?bTVIVkJocVJzRUpsVmZZN05TU1Z1ai9sMmJCbjFGSHcvVzFySmZqWTY0bkhx?=
 =?utf-8?B?eTNCTExlQW1KZDAwa0dLVWN0dHFWVngvN3U4bEkySVJEdFlKeUhxU3hWYVRl?=
 =?utf-8?B?by9BbGVsQ0ZPdklKTFQ2TUt4RHoyYk9iVUp0cE5HaVpSTUl0MjJXTjlXbHB3?=
 =?utf-8?B?eGpCa1EyZ2tDYlFqRkcwN1MyVllEZmFqYUpBM3RpZ3hBdWlMVzltcWpqQ1hW?=
 =?utf-8?B?OG9zL3dpZVpGMFhJQ0dsMW5NZVgwcThqcE5kVEZrRnR5L2lpZDlDRW1RS1du?=
 =?utf-8?B?TUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fd2793-1a9c-4297-320d-08de2a9b02c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2025 14:17:18.7460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dLI0JGJUJy9c/9iQsVds0z0vXRpEMadZh1AM1eoZV21SuUYep+5nW7HoKUMtxv/Tg5j0uN8nFnDoW/lVrxLNusTes7GU51Zgc7y1OL4PbNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13492

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBCaWp1IERhcw0KPiBTZW50OiAyMyBOb3ZlbWJlciAyMDI1IDE0OjA2DQo+IFN1Ympl
Y3Q6IFJFOiBbUEFUQ0ggdjIgMS8yXSBkdC1iaW5kaW5nczogY2FuOiByZW5lc2FzLHJjYXItY2Fu
ZmQ6IERvY3VtZW50IHJlbmVzYXMsZmQtb25seSBwcm9wZXJ0eQ0KPiANCj4gDQo+IA0KPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6a0BrZXJuZWwub3JnPg0KPiA+IFNlbnQ6IDIzIE5vdmVtYmVyIDIwMjUgMTM6MjYNCj4gPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gZHQtYmluZGluZ3M6IGNhbjogcmVuZXNhcyxyY2Fy
LWNhbmZkOg0KPiA+IERvY3VtZW50IHJlbmVzYXMsZmQtb25seSBwcm9wZXJ0eQ0KPiA+DQo+ID4g
T24gMjMvMTEvMjAyNSAxMjoyMywgQmlqdSB3cm90ZToNCj4gPiA+IEZyb206IEJpanUgRGFzIDxi
aWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiA+DQo+ID4gPiBUaGUgQ0FORkQgb24gUlov
e0cyTCxHM0V9IGFuZCBSLUNhciBHZW40IHN1cHBvcnQgMyBtb2RlcyBGRC1Pbmx5DQo+ID4gPiBt
b2RlLCBDbGFzc2ljYWwgQ0FOIG1vZGUgYW5kIENBTi1GRCBtb2RlLiBJbiBGRC1Pbmx5IG1vZGUs
DQo+ID4gPiBjb21tdW5pY2F0aW9uIGluIENsYXNzaWNhbCBDQU4gZnJhbWUgZm9ybWF0IGlzIGRp
c2FibGVkLiBEb2N1bWVudA0KPiA+ID4gcmVuZXNhcyxmZC1vbmx5IHRvIGhhbmRsZSB0aGlzIG1v
ZGUuIEFzIHRoZXNlIFNvQ3Mgc3VwcG9ydCAzIG1vZGVzLA0KPiA+ID4gdXBkYXRlIHRoZSBkZXNj
cmlwdGlvbiBvZiByZW5lc2FzLG5vLWNhbi1mZCBwcm9wZXJ0eSBhbmQgZGlzYWxsb3cgaXQgZm9y
IFItQ2FyIEdlbjMuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgdjEtPnYyOg0KPiA+ID4g
ICAqIEFkZGVkIGNvbmRpdGlvbmFsIGNoZWNrIHRvIGRpc2FsbG93IGZkLW9ubHkgbW9kZSBmb3Ig
Ui1DYXIgR2VuMy4NCj4gPiA+IC0tLQ0KPiA+ID4gIC4uLi9iaW5kaW5ncy9uZXQvY2FuL3JlbmVz
YXMscmNhci1jYW5mZC55YW1sICB8IDI0DQo+ID4gPiArKysrKysrKysrKysrKysrLS0tDQo+ID4g
PiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4g
Pg0KPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbmV0L2Nhbi9yZW5lc2FzLHJjYXItY2FuZmQueWFtbA0KPiA+ID4gYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9yZW5lc2FzLHJjYXItY2FuZmQueWFtbA0K
PiA+ID4gaW5kZXggZjRhYzIxYzY4NDI3Li5hNTIyNDRmMGI1ZDEgMTAwNjQ0DQo+ID4gPiAtLS0N
Cj4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vcmVuZXNh
cyxyY2FyLWNhbmZkLnlhbWwNCj4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9uZXQvY2FuL3JlbmVzYXMscmNhci1jYW5mZC55DQo+ID4gPiArKysgYW0NCj4gPiA+
ICsrKyBsDQo+ID4gPiBAQCAtMTI1LDkgKzEyNSwxNyBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4gICAg
cmVuZXNhcyxuby1jYW4tZmQ6DQo+ID4gPiAgICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwj
L2RlZmluaXRpb25zL2ZsYWcNCj4gPiA+ICAgICAgZGVzY3JpcHRpb246DQo+ID4gPiAtICAgICAg
VGhlIGNvbnRyb2xsZXIgY2FuIG9wZXJhdGUgaW4gZWl0aGVyIENBTiBGRCBvbmx5IG1vZGUgKGRl
ZmF1bHQpIG9yDQo+ID4gPiAtICAgICAgQ2xhc3NpY2FsIENBTiBvbmx5IG1vZGUuICBUaGUgbW9k
ZSBpcyBnbG9iYWwgdG8gYWxsIGNoYW5uZWxzLg0KPiA+ID4gLSAgICAgIFNwZWNpZnkgdGhpcyBw
cm9wZXJ0eSB0byBwdXQgdGhlIGNvbnRyb2xsZXIgaW4gQ2xhc3NpY2FsIENBTiBvbmx5IG1vZGUu
DQo+ID4gPiArICAgICAgVGhlIGNvbnRyb2xsZXIgY2FuIG9wZXJhdGUgaW4gZWl0aGVyIENBTi1G
RCBtb2RlIChkZWZhdWx0KSBvciBGRC1Pbmx5DQo+ID4gPiArICAgICAgbW9kZSAoUlove0cyTCxH
M0V9IGFuZCBSLUNhciBHZW40KSBvciBDbGFzc2ljYWwgQ0FOIG1vZGUuIFNwZWNpZnkgdGhpcw0K
PiA+ID4gKyAgICAgIHByb3BlcnR5IHRvIHB1dCB0aGUgY29udHJvbGxlciBpbiBDbGFzc2ljYWwg
Q0FOIG1vZGUuDQo+ID4gPiArDQo+ID4gPiArICByZW5lc2FzLGZkLW9ubHk6DQo+ID4gPiArICAg
ICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL2ZsYWcNCj4gPiA+ICsgICAg
ZGVzY3JpcHRpb246DQo+ID4gPiArICAgICAgVGhlIENBTkZEIG9uIFJaL3tHMkwsRzNFfSBhbmQg
Ui1DYXIgR2VuNCBTb0NzIHN1cHBvcnQgMyBtb2RlcyBGRC1Pbmx5DQo+ID4gPiArICAgICAgbW9k
ZSwgQ2xhc3NpY2FsIENBTiBtb2RlIGFuZCBDQU4tRkQgbW9kZSAoZGVmYXVsdCkuIEluIEZELU9u
bHkgbW9kZSwNCj4gPiA+ICsgICAgICBjb21tdW5pY2F0aW9uIGluIENsYXNzaWNhbCBDQU4gZnJh
bWUgZm9ybWF0IGlzIGRpc2FibGVkLiBTcGVjaWZ5IHRoaXMNCj4gPiA+ICsgICAgICBwcm9wZXJ0
eSB0byBwdXQgdGhlIGNvbnRyb2xsZXIgaW4gRkQtT25seSBtb2RlLg0KPiA+ID4NCj4gPiA+ICAg
IGFzc2lnbmVkLWNsb2NrczoNCj4gPiA+ICAgICAgZGVzY3JpcHRpb246DQo+ID4gPiBAQCAtMjY3
LDYgKzI3NSwxNiBAQCBhbGxPZjoNCj4gPiA+ICAgICAgICBwYXR0ZXJuUHJvcGVydGllczoNCj4g
PiA+ICAgICAgICAgICJeY2hhbm5lbFs2LTddJCI6IGZhbHNlDQo+ID4gPg0KPiA+ID4gKyAgLSBp
ZjoNCj4gPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ID4gKyAgICAgICAgY29tcGF0aWJsZToN
Cj4gPiA+ICsgICAgICAgICAgY29udGFpbnM6DQo+ID4gPiArICAgICAgICAgICAgZW51bToNCj4g
PiA+ICsgICAgICAgICAgICAgIC0gcmVuZXNhcyxyY2FyLWdlbjMtY2FuZmQNCj4gPiA+ICsgICAg
dGhlbjoNCj4gPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ID4gKyAgICAgICAgcmVuZXNhcyxm
ZC1vbmx5OiBmYWxzZQ0KPiA+ID4gKw0KPiA+DQo+ID4gWW91IGRpZCBub3QgcmVzcG9uZCB0byBt
eSBmaXJzdCBwYXJhZ3JhcGggZnJvbSBwcmV2aW91cyB2ZXJzaW9uLiBBcyBJDQo+ID4gc2FpZCwg
eW91IG5vdyBuZWVkIG9uZU9mIHRvIHJlc3RyaWN0IHRoZXNlLCBzaW5jZSB5b3UgYXJlIG5vdCB1
c2luZyBzaW1wbGUgZW51bS4NCj4gDQo+IFRoaXMgaXMgcmVzdHJpY3RpbmcgZm9yIFItQ2FyIEdl
bjMuIERUIGJpbmRpbmcgY2hlY2sgcmV0dXJucyBlcnJvciBpZiAncmVuZXNhcyxmZC1vbmx5Ig0K
PiBpcyBkZWZpbmVkIGZvciBSLUNhciBHZW4zLg0KPiANCj4gQW0gSSBtaXNzaW5nIGFueXRoaW5n
IGhlcmU/DQoNCkZvciBlZzoNCg0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL25ldC9jYW4vcmVuZXNhcyxyY2FyLWNhbmZkLnlhbWwNCisrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL3JlbmVzYXMscmNhci1jYW5mZC55YW1sDQpAQCAt
MzA4LDYgKzMwOCw3IEBAIGV4YW1wbGVzOg0KICAgICAgICAgICAgIGFzc2lnbmVkLWNsb2NrLXJh
dGVzID0gPDQwMDAwMDAwPjsNCiAgICAgICAgICAgICBwb3dlci1kb21haW5zID0gPCZzeXNjIFI4
QTc3OTVfUERfQUxXQVlTX09OPjsNCiAgICAgICAgICAgICByZXNldHMgPSA8JmNwZyA5MTQ+Ow0K
KyAgICAgICAgICAgIHJlbmVzYXMsZmQtb25seTsNCiANCiAgICAgICAgICAgICBjaGFubmVsMCB7
DQogICAgICAgICAgICAgfTsNCg0KDQogIERURVggICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL25ldC9jYW4vcmVuZXNhcyxyY2FyLWNhbmZkLmV4YW1wbGUuZHRzDQogIERUQyBb
Q10gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vcmVuZXNhcyxyY2Fy
LWNhbmZkLmV4YW1wbGUuZHRiDQovaG9tZS9iaWp1L3NoYXJlL2xpbnV4LXdvcmsvbGludXgvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vcmVuZXNhcyxyY2FyLWNhbmZk
LmV4YW1wbGUuZHRiOiBjYW5AZTY2YzAwMDAgKHJlbmVzYXMscjhhNzc5NS1jYW5mZCk6IHJlbmVz
YXMsZmQtb25seTogRmFsc2Ugc2NoZW1hIGRvZXMgbm90IGFsbG93IFRydWUNCglmcm9tIHNjaGVt
YSAkaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL25ldC9jYW4vcmVuZXNhcyxyY2Fy
LWNhbmZkLnlhbWwjDQoNCkNoZWVycywNCkJpanUNCg0KDQoNCg0K

