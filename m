Return-Path: <linux-can+bounces-4510-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EFEB48A4D
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 12:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A69340DA8
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 10:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61C02F3C28;
	Mon,  8 Sep 2025 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="vGycD9dt"
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010045.outbound.protection.outlook.com [52.101.229.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254C52F3639;
	Mon,  8 Sep 2025 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757327834; cv=fail; b=d8dHznZiqFl1gcJeuUJKONfkbM2bxDL3/8pYWe7FYNz1WT05Rn9xKc4sKLgtb7eUm+OWb6Mk9DfrSbYabLRtgUsgzGXXsW4OBf37upgblPHdmLw/kwoB5QZPhicN2oMWGeRFHCNTuLHEazhi7QwSkVLs+6yBxBVN4JS0KbDL7cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757327834; c=relaxed/simple;
	bh=w3d3quDZOnLvMlRJi/V3pous42vs3oqm8KPZl6fVlJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sMLzx9a4Vtcon/DxnkYrssNpxUYzX+Xi2VWuMa8UUguRMb5lL+Lf7x4jSJuhOEiiiqOq0a9gOSNmvNk/3mUDVeouZcymNJLVXYxMRUsn8ixUne9e6p22vAIBMbuCmTy8NCqnT21u9ZyCzDaVlXDwMOuJIaUqHK2lgkPf5yzK6Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=vGycD9dt; arc=fail smtp.client-ip=52.101.229.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9VXoJ4oYdhzcUWDgwBvMuX5jn7hLnLFVOFEPIp9NKakJpy8Iko/2NId3Y77FN56vkrRNjvuaAE8zZlItAh6vr7vu7rs6J3ZiDDUIw2+r5lVk6gbqPJfT8sGm2isDQzxsOBWX3MuhWuOcAC+AssPCUfQ24DowFc64NHrF2dpE9y9TnxSKqSQyNAhL6L32yNP/SlehkyN/GMuqhZ07K3teTm9gpkM57e3oy5vchEJ9SKyyc7pUbDd/oae1CeAaOySVog0f9oHvrigohSxx3t4aaLJAid5CHOkWrPsWqqi9mmeLdO1+2Cw5ePda8IhxoNFP69luwM1CXciSSiVCIIjKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3d3quDZOnLvMlRJi/V3pous42vs3oqm8KPZl6fVlJA=;
 b=f64chmDmjXE+6AjkJKwVsNl38DGouXcfu/8UxzmttqPQ4Lusy9YtGgFWUCRn6ILcV+qfa4tz3xJPM/BM4jmEwYlPEgxy6IMl80uDcMbVUzhP9b4pmyT7u3Vd0Fax5Nx+PUJ1+Xo/JCqHz+YKHY9kebBjmkA4gx0NbgT+1xwIft+TqwHgw0VclDYiNW8JeCDpYs6KDW1L6i3lgJ5a2YVuNu+DzHoyli/i3oHHZJ16FC1vNuv1prDCcOS9Jg8PPaXbloCRR1JRBhnYFJsP9uTLLn7dqB6IDiiKmUsuCscpUI2Y459VqdIvlQjvLfSINj4saiLozLZ8bQPjBdXoC1/IzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3d3quDZOnLvMlRJi/V3pous42vs3oqm8KPZl6fVlJA=;
 b=vGycD9dticHOwN7d0HFMPDiTfhqPFqqBquc7miwjVSqXAN+9ucn20HR3KdFMpIRdr/yLxMPElXnHbH4YAmkxq4OH1bYMiLB0IK6nNY+3hQnYnB06/tYZ5NLgenDx/9rrSBPMYZfI+Ori7uxXcnwMFXToV10fy0C3/RRIGlUFfE0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB7460.jpnprd01.prod.outlook.com (2603:1096:400:f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 8 Sep
 2025 10:37:05 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 10:37:05 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>, biju.das.au <biju.das.au@gmail.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, magnus.damm <magnus.damm@gmail.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH v2 1/4] can: rcar_canfd: Add shared_bittiming variable to
 struct rcar_canfd_hw_info
Thread-Topic: [PATCH v2 1/4] can: rcar_canfd: Add shared_bittiming variable to
 struct rcar_canfd_hw_info
Thread-Index: AQHcEqXthX4MfiEpqE6L4G5a02KvfbR+X/EAgArTaTA=
Date: Mon, 8 Sep 2025 10:37:05 +0000
Message-ID:
 <TY3PR01MB11346B198D168F5F78BB74372860CA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250821141429.298324-1-biju.das.jz@bp.renesas.com>
 <20250821141429.298324-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdUhR1PgfY28uVCN6hQjO9sMRJFiTEUAnAqPX+px6Wp1QQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUhR1PgfY28uVCN6hQjO9sMRJFiTEUAnAqPX+px6Wp1QQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB7460:EE_
x-ms-office365-filtering-correlation-id: 092242f7-91c3-4023-bda4-08ddeec3a79e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bG9ibGZ6bFlSMnN4TU5uQTBtbDVjRGpNZlJ3Z3BLS0w4bjNIeU1ZU3B6cmU5?=
 =?utf-8?B?WEd2Uk5NMDhqT0F4NW9WSVJOaHpWZEdiNTVXc1E5MFpiVHJPWE9UNmFMM1FR?=
 =?utf-8?B?WVRNV1RqempDZ1dxcWJWWXJncDg1MVV6RjBYQ3VkRHdtNDI0UHBnRHlxNklT?=
 =?utf-8?B?M1c5c2N0UTlnQnA3WGthTFdoUENuRmpIRnQ2NDhpeEt6dnlUSzFXN01PRzZs?=
 =?utf-8?B?SWd6Zk9mTVJJR1A2eE1GS3A5QjBPZHRaS0dXYlRTZU1TN0xNR1ZxYnBnU0NU?=
 =?utf-8?B?UGN4RnZMSUtXTVZKa1Z1Wm9kMU83SXdmbDB5Y25CaDZMUnlZUnpGOFJTbyty?=
 =?utf-8?B?M1Q5L3ZZZkxEdHVZNlFTNUFmZENnQlMzNTBXZzJDQWxRem9RUzZDWkJ2bXJM?=
 =?utf-8?B?TFAzNThBTk1xbUN4NDhXRFJBNDd0d3VSc1RYdVZuODBpWjBWYWtPUUZUQk1E?=
 =?utf-8?B?QndQbGpuU0d1TWFlbjhBMFZsT3Z3RE9VR0FmYkN0K2dTVUdBMVVJcUlPMFdn?=
 =?utf-8?B?SkNTdlFqWEUxL01tL2pUVlBIRlBWUVI3Umk1Y251Tm9WLzU5Qks4dFdhMGww?=
 =?utf-8?B?UllzTGdkZ2oyUExsYnVnTGtsRnAyRjhENHliU2xXSzRyUHdrS1hka3JHdVRU?=
 =?utf-8?B?ZnB3cityQWk2dkRqMTJlb2h5d0FCbldTSkh3SndPQURzK0pXUHNVZVVya1Y2?=
 =?utf-8?B?b25TMnZlVEozU0UxNzVSdVhJZmZjeWUvN1Y0QUxmdEozeDVBZGs1Nll5Uk9Q?=
 =?utf-8?B?cmc1U2xZK1ZzRzYvRHY2V1dzUExyU3hPR0kwekQya0x0WVNERjRMb1hXbi9x?=
 =?utf-8?B?dG1ES0hLL2xuQkVKNDJTT2oyNythV2UyVkU1dGZJUGk5VjBSbU1rcTFwTzNW?=
 =?utf-8?B?d0xHakIzZGZpOU1KVUdlYVZPWW05MEtzNGNRL25iNDcyTGFhTHBndHhUUmYr?=
 =?utf-8?B?Wmp3cmhWZmFEQlNPUi9qWmRtZDhTWkZUckVKbFlKODJJTjkvVFJxVXRXeHpX?=
 =?utf-8?B?ei9SSW5YbXl6aWFER2g1UFQxNWp6MUQ4a1V5citZVGV1eXlkc3Nkano1L3gy?=
 =?utf-8?B?ZndnU0Z3ejJuT0VTWkdNZlppbmhwMEVYbEJwTmRBVmRaZm5raEduUWl3dW93?=
 =?utf-8?B?NUgvSUY3TVhjZU0yckFJQWwwMTB6aVh3UUxQZzBYanRmN1hrS1FKUE50aHNY?=
 =?utf-8?B?Zk9wZXJKd2V4ZSswdFo3R29wUnJJVGdXRjZodzhUaTdHWHZqeDZBalFqRFoy?=
 =?utf-8?B?V2dHZ25vdENyV01ITDk5OUJkSTRBaEdBcFA5N29OVm56KzBBVWtLUWZKWXBI?=
 =?utf-8?B?U044c0kvR0JweUlxRnRNUGVXTFR2TWRvUG9NeWFTeE5iWkR2UStDNWo5UFVa?=
 =?utf-8?B?OTQwZ29MNGdhY3lLYzRzS1prTmNCUDdsakVvOEljUXgvUThXWUhiZ3F0YU5D?=
 =?utf-8?B?TlVkay94bHJjN3hIdnRYc0xiaVFFeXBPM1ZWbkhiWVozT243bUdDTVJKOFgy?=
 =?utf-8?B?QjQ3UDhMbHZDMXp6b2xXMWw3bEZQV3ByQlhXemlJTWhVNk51bkNXN3NVeUZ3?=
 =?utf-8?B?OWQyVXpxaEg0NEpYWFlpRytvZ005NFlFWVNSNVNBUkVlVE9CSmdqSldhVUMx?=
 =?utf-8?B?TklDenNYSTBTSElDb1NVQnBheWlWZkEwWUNocnkyN0M1MitHT1pCWGpzMFd2?=
 =?utf-8?B?cGNIbGEzdTRHbENQTGliT0ttSWVySFBibXhlTVRXcFgxdDJWQXJkR0VmQzBp?=
 =?utf-8?B?SXprUlVMR3JETmNRb0RsMEE5UVFoQTdEUElkTXpYMVI1NTg1L3pxV29hb1pE?=
 =?utf-8?B?WXdBejk0ckcxM2xpZVJtU2Jzd2FhZFlHV2JWcElRdXRhMXkrNlI2UWhvNDZ6?=
 =?utf-8?B?UkZVc0dWN0lGWTNlUjVaVDZwaHVZMzBDTThwMlNhUU9IcFhCOGZOeEVDOGtY?=
 =?utf-8?B?YlZyODNybWJJcjJKK0ROZWx4dXlaUTVKS0J6UDFrbXBkdmJYcG1pMzZFYUtJ?=
 =?utf-8?B?VXJWZmdPK1N3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXpRTmtIL0JDREpNNlU3Y0s0ZlB6ZEFYbXp5U3hIMW5ZTEt2VS9DazVwTFFz?=
 =?utf-8?B?a1hvRmNUZDlEQUNGU3c5RnA3VWtlaEs2cVlyMTVVWE5YTU5pTXdjb3B0eHBz?=
 =?utf-8?B?WjliSkxFUWZHRit0WkxhMWdISS9ZYlBlZ3JxdG1OKzJUYU5rZ3Fhd1R6NllZ?=
 =?utf-8?B?bU9NbXQwSDJ4NDFnK0JWVG9mNytlc00yNnJ4MFNSV1l6aTNuN2J3Ri8yVkp2?=
 =?utf-8?B?VkpEbFJJTlBSMzVGMjIzMlBxL2RobUx2b0pJSHpnVG40elhJaEducUtKVllL?=
 =?utf-8?B?R09CcDNLTU1kb0FmazdtUnZBK3ZSczl3cXR6UnE2K3dvaGt3SmRZcWM1THJL?=
 =?utf-8?B?MlpXb3JOOTkyVEdRczZwUUh0ODdYenV2Skk0QnFKa2F0UE55WXFEeGZPR29M?=
 =?utf-8?B?emhGS0pCdUtQRkZjV0F0eDVlL3RvY1FzNVE5L1ZBTTdrWGhJcWdDSlZrNDJu?=
 =?utf-8?B?V0dYZS9raVlxSmYvZG9FczNRYzE1ekNFSFlHV2x5bFVjTW1FMnlzNm0xS2tG?=
 =?utf-8?B?SFZ5YUdLZzdFREIzdmYzZkNPUy9IMmUwT2RqSEVHaTBOMitNYjZ0ZjhGRnht?=
 =?utf-8?B?VWRVNERLOFFZQ0FGM0V0VUxpdnJFbzRmR3JiclZvcmtkY0VTSkhTYTdITGhQ?=
 =?utf-8?B?QkliYzFac0diRVlkVDA1VTZrL0lmSUIySFNMRVdESmxmMS9CU01WSUxqMlYv?=
 =?utf-8?B?b2Zrbk8xYVliWlcrandrTWlUaFduM3A0aXRXSVp4YzUzejhUWVZWSkd6czJS?=
 =?utf-8?B?V3Q1N2NEa0pvUDZZQXE0a2tja1JyMXNaemdtYTBUdTFjcTFMZlp2aHE5SFlN?=
 =?utf-8?B?OWZwTTkrWGpURGVVQmJ0RG1jbm9kalA2THN2QXA3Wnk3ZkErUjBKa2VDNTNP?=
 =?utf-8?B?QTJYOW9WSzNFK1UxTVh2c0RJWmxhdTBKbE1lTWoyNVhIK1NySGtlMm9LVGZW?=
 =?utf-8?B?MWEzOUEvSklweE80akZ5Z3IwRWJubEdxcTduNmRzeElCVDE4eENJZHlyUmZo?=
 =?utf-8?B?ejNKYVVQTkhzMmlCRFJqREdkUFU4eGpnenpQUENKdFZvbngwMWtVR2JWYkpr?=
 =?utf-8?B?RzVLdTJ2dGM4UElmVFlwSitlbFJvY3FSdFRzR0pkQi9VTUh6bS9RTnFpL250?=
 =?utf-8?B?ODJqeUJEMkVpU0k4ZTlDaXZYNVV2enZudHRzYS90dENyK2hqcGlZRytybC96?=
 =?utf-8?B?bllCOE5Xc01oTUtiVW9KeCtmcTVmSUkycVlUeFRaMW1oSjV4QzZXZjRLSjB5?=
 =?utf-8?B?MjZQT0lKK2RyU1d4NEtvUjR3RlRBbzNVenlQMUtkUThSK1lUeGdrTnQxbGRD?=
 =?utf-8?B?NGErMnpSbFVxMEhEb29Dbmx5cVhMbzFhUFk4NnhOcUZSRnN6SDM0eVQrL0s2?=
 =?utf-8?B?Vk9NOXlsRkJDVFVhY2xDV2d0OVlMeWJSR1U3Yytta1FBWDVrRXhSODFONzF3?=
 =?utf-8?B?ak8zeUtzTHRIZTVHL0x5MjdzOHlwWWJGQVZhYTRXbmVwNmZXS0s1c25naFg0?=
 =?utf-8?B?R2t1ZUJncEZmelhBc0d3Y0ZzV3F0bk9sMFlMR2srSjBER2hqOWtUQ3BEcVkr?=
 =?utf-8?B?UjMycENnRmVSeU5mZWp1RVVQOC8xQ1JWb1ZMRXU1M3I5K3BST0d3RDRXbkFO?=
 =?utf-8?B?YlkvaE9BUEhVVDB2Z2d2MEEreHd1YVhVWk90RkoyOHJYd2ZQa29rRy9CbjMx?=
 =?utf-8?B?VHRtRnYwQWhwUVlvTXJpUXJncHBlWWtGalQwSEtwNTdETjA0ZWFvOWhBeFdL?=
 =?utf-8?B?eHg5dFNmb0V4OSs5dm9ZRjhlSFUzZ0tya2VjdTl3bXpmbXpsMWtscStzaUxa?=
 =?utf-8?B?aTFjcjA4OGpPaVhTZ0U0a0lqcWxkSloxMStxUVc5UVpXYW1qdW14NnN4cFFH?=
 =?utf-8?B?UnBCYXVlOURXeTBtRXROMFV0MnBuanUxcmRIVjVWbjJDdXR0eEtFR3JsTFhm?=
 =?utf-8?B?N3RacGtXZVhydStQSVVtNWg3SWRZb282WXVmblRwUFdqWjBYUHNzN1NSMXl5?=
 =?utf-8?B?VjdlWW1qeGY3VUxzeVo5cnBVNXZwY0I0VGxHUzl1UjVUOFpmbURBMVF3R1Nu?=
 =?utf-8?B?bHVBd3V5VGZXR29VK2dIWDlabUNHRS9YeUx2ZWtTWDNwME1SYXZQQVlhd0RZ?=
 =?utf-8?B?ZGpBcm5MOWZ0Y04xWEcrOUhTSkFieC9PYTU5bko4a3JRZzB4aXU3ZFpnUmpY?=
 =?utf-8?B?VUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 092242f7-91c3-4023-bda4-08ddeec3a79e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 10:37:05.4637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZQIVoCPjWhdBuuxc+kPCE/GsU0nNiJuCbNeNCqJ5GxB6EnV+VFvaKVuHXicocRi/x/OaYN3xswAQ7KMHmMFCFD81arc2Hsm7JefHkFTtsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7460

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDAxIFNlcHRlbWJlciAyMDI1IDE0OjE2DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMS80XSBjYW46IHJjYXJfY2FuZmQ6IEFkZCBzaGFyZWRfYml0dGltaW5nIHZhcmlh
YmxlIHRvIHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8NCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBP
biBUaHUsIDIxIEF1ZyAyMDI1IGF0IDE2OjE0LCBCaWp1IDxiaWp1LmRhcy5hdUBnbWFpbC5jb20+
IHdyb3RlOg0KPiA+IEZyb206IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4N
Cj4gPg0KPiA+IFRoZSBjYWxjdWxhdGlvbiBmb3JtdWxhIGZvciBub21pbmFsIGJpdCByYXRlIG9m
IGNsYXNzaWNhbCBDQU4gaXMgc2FtZQ0KPiA+IGFzIHRoYXQgb2Ygbm9taW5hbCBiaXQgcmF0ZSBv
ZiBDQU5GRCBvbiB0aGUgUlovRzNFIFNvQyBjb21wYXJlZCB0byBvdGhlciBTb0NzLg0KPiA+IEFk
ZCBzaGFyZWRfYml0dGltaW5nIHZhcmlhYmxlIHRvIHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8g
dG8gaGFuZGxlDQo+ID4gdGhpcyBkaWZmZXJlbmNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
QmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBG
YWJyaXppbyBDYXN0cm8gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT4NCj4gDQo+IFRo
YW5rcyBmb3IgeW91ciBwYXRjaCENCj4gDQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL3JjYXIv
cmNhcl9jYW5mZC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5j
DQo+ID4gQEAgLTQ2MSw2ICs0NjEsNyBAQCBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvIHsNCj4g
PiAgICAgICAgIHVuc2lnbmVkIGNoX2ludGVyZmFjZV9tb2RlOjE7ICAgLyogSGFzIGNoYW5uZWwg
aW50ZXJmYWNlIG1vZGUgKi8NCj4gPiAgICAgICAgIHVuc2lnbmVkIHNoYXJlZF9jYW5fcmVnczox
OyAgICAgLyogSGFzIHNoYXJlZCBjbGFzc2ljYWwgY2FuIHJlZ2lzdGVycyAqLw0KPiA+ICAgICAg
ICAgdW5zaWduZWQgZXh0ZXJuYWxfY2xrOjE7ICAgICAgICAvKiBIYXMgZXh0ZXJuYWwgY2xvY2sg
Ki8NCj4gPiArICAgICAgIHVuc2lnbmVkIHNoYXJlZF9iaXR0aW1pbmc6MTsgICAgLyogSGFzIHNo
YXJlZCBub21pbmFsIGJpdHRpbWluZyBjb25zdGFudHMgKi8NCj4gPiAgfTsNCj4gPg0KPiA+ICAv
KiBDaGFubmVsIHByaXYgZGF0YSAqLw0KPiA+IEBAIC02MzIsNiArNjMzLDcgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8gcmNhcl9nZW4zX2h3X2luZm8gPSB7DQo+ID4g
ICAgICAgICAuY2hfaW50ZXJmYWNlX21vZGUgPSAwLA0KPiA+ICAgICAgICAgLnNoYXJlZF9jYW5f
cmVncyA9IDAsDQo+ID4gICAgICAgICAuZXh0ZXJuYWxfY2xrID0gMSwNCj4gPiArICAgICAgIC5z
aGFyZWRfYml0dGltaW5nID0gMCwNCj4gPiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHJjYXJfY2FuZmRfaHdfaW5mbyByY2FyX2dlbjRfaHdfaW5mbyA9IHsgQEANCj4gPiAtNjQ5
LDYgKzY1MSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvIHJjYXJf
Z2VuNF9od19pbmZvID0gew0KPiA+ICAgICAgICAgLmNoX2ludGVyZmFjZV9tb2RlID0gMSwNCj4g
PiAgICAgICAgIC5zaGFyZWRfY2FuX3JlZ3MgPSAxLA0KPiA+ICAgICAgICAgLmV4dGVybmFsX2Ns
ayA9IDEsDQo+ID4gKyAgICAgICAuc2hhcmVkX2JpdHRpbWluZyA9IDAsDQo+IA0KPiBJIGNvdWxk
IGZpbmQgbm8gc3RyaWN0ZXIgbGltaXRhdGlvbiBvZiB0aGUgYml0IHRpbWluZ3MgaW4gY2xhc3Np
Y2FsIENBTiBtb2RlIG9uIFItQ2FyIEdlbjQsIHNvIGl0IGxvb2tzDQo+IGxpa2UgdGhpcyBzaG91
bGQgYmUgMSwgdG9vLi4uDQoNCkFncmVlZC4NCg0KPiANCj4gPiAgfTsNCj4gPg0KPiA+ICBzdGF0
aWMgY29uc3Qgc3RydWN0IHJjYXJfY2FuZmRfaHdfaW5mbyByemcybF9od19pbmZvID0geyBAQCAt
NjY2LDYNCj4gPiArNjY5LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCByY2FyX2NhbmZkX2h3X2lu
Zm8gcnpnMmxfaHdfaW5mbyA9IHsNCj4gPiAgICAgICAgIC5jaF9pbnRlcmZhY2VfbW9kZSA9IDAs
DQo+ID4gICAgICAgICAuc2hhcmVkX2Nhbl9yZWdzID0gMCwNCj4gPiAgICAgICAgIC5leHRlcm5h
bF9jbGsgPSAxLA0KPiA+ICsgICAgICAgLnNoYXJlZF9iaXR0aW1pbmcgPSAwLA0KPiA+ICB9Ow0K
PiA+DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvIHI5YTA5ZzA0
N19od19pbmZvID0geyBAQA0KPiA+IC02ODMsNiArNjg3LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCByY2FyX2NhbmZkX2h3X2luZm8gcjlhMDlnMDQ3X2h3X2luZm8gPSB7DQo+ID4gICAgICAgICAu
Y2hfaW50ZXJmYWNlX21vZGUgPSAxLA0KPiA+ICAgICAgICAgLnNoYXJlZF9jYW5fcmVncyA9IDEs
DQo+ID4gICAgICAgICAuZXh0ZXJuYWxfY2xrID0gMCwNCj4gPiArICAgICAgIC5zaGFyZWRfYml0
dGltaW5nID0gMSwNCj4gPiAgfTsNCj4gPg0KPiA+ICAvKiBIZWxwZXIgZnVuY3Rpb25zICovDQo+
ID4gQEAgLTE5MTIsNyArMTkxNywxMCBAQCBzdGF0aWMgaW50IHJjYXJfY2FuZmRfY2hhbm5lbF9w
cm9iZShzdHJ1Y3QgcmNhcl9jYW5mZF9nbG9iYWwgKmdwcml2LCB1MzIgY2gsDQo+ID4gICAgICAg
ICAgICAgICAgIHByaXYtPmNhbi5mZC5kb19nZXRfYXV0b190ZGN2ID0gcmNhcl9jYW5mZF9nZXRf
YXV0b190ZGN2Ow0KPiA+ICAgICAgICAgfSBlbHNlIHsNCj4gPiAgICAgICAgICAgICAgICAgLyog
Q29udHJvbGxlciBzdGFydHMgaW4gQ2xhc3NpY2FsIENBTiBvbmx5IG1vZGUgKi8NCj4gPiAtICAg
ICAgICAgICAgICAgcHJpdi0+Y2FuLmJpdHRpbWluZ19jb25zdCA9ICZyY2FyX2NhbmZkX2JpdHRp
bWluZ19jb25zdDsNCj4gPiArICAgICAgICAgICAgICAgaWYgKGdwcml2LT5pbmZvLT5zaGFyZWRf
Yml0dGltaW5nKQ0KPiANCj4gLi4uIGhlbmNlIHlvdSBjYW4ganVzdCBjaGVjayB0aGUgZXhpc3Rp
bmcgc2hhcmVkX2Nhbl9yZWdzIGZsYWcgaGVyZSwgYW5kIGRvbid0IG5lZWQgdG8gaW50cm9kdWNl
IGEgbmV3DQo+IGZsYWcgZm9yIHNoYXJlZCBiaXR0aW1pbmdzPw0KDQpPSyB3aWxsIHVzZSBleGlz
dGluZyBzaGFyZWRfY2FuX3JlZ3MgZmxhZyBoZXJlLg0KDQoNCkNoZWVycywNCkJpanUNCg==

