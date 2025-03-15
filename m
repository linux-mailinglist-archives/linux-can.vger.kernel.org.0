Return-Path: <linux-can+bounces-3097-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2162A630B5
	for <lists+linux-can@lfdr.de>; Sat, 15 Mar 2025 18:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00121899DD7
	for <lists+linux-can@lfdr.de>; Sat, 15 Mar 2025 17:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28651F866A;
	Sat, 15 Mar 2025 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Ui982Ou0"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011030.outbound.protection.outlook.com [40.107.74.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0D917995E;
	Sat, 15 Mar 2025 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742059545; cv=fail; b=o6O9tZgejtSnE71tmjLPamfFkqULTafJ4N9Gq56JkV/PId/6JQCxVHI7M9Kdr9ZYv1Zg9ILb57u/BTMUQKOQCqPU+z4UU9MhZpbH0sgVGcRBBcz3BQKl2JlWsqp6co44qOf40rarVwDMwV4KgXzr4WAjRJY/pCL/zU6HpzyQlVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742059545; c=relaxed/simple;
	bh=NxQ9vUvuNOOa3WIhlzDsZXHvkBE/MWfHjq+OP9VpwnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hd1YzlecNxZd49cC2Z/D7u0TOBbczr6jdTFyiV1O8p1kd2KnStDyC2Hi6nl+Fls4nfV2b8QDFca2Qi8+/WbdNhjhPdZrSFnEH6fc1OmurvhoLWl8Wpn9eNc06ZQlCaHVyjF2c4/nzWJu2N9o2E2sppfYPBiuqfmdXWkKpdER4eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Ui982Ou0; arc=fail smtp.client-ip=40.107.74.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgIzaLA9FwTWTGsYH+DBX9SDOrHEbfSFFhbX2uicACfdncX6tKm9/ICxk67jwrFpMMS0pqUeff+y55M4CoxccXrX35FoRMloC7yHg72pM/dFtbYYuV9E+4eItwTv7aNhw0Zy3PagjI8bKOm4mbVdTED5B9AKtDNSz4SBEY7WFfL8H2fv6YcRBU/FRzAFZWVLzDx2iEWiPPXkD22BxeGkWK3kSQR4OT3dnQjxpY3Zt/E/zixOvheq/SOkrGJCOjIwBlYH4EYLtw+v16hYQA2p8ZybO8kpC78ll3tvkNoppCXRyGn40Uj5ualcSV9FIRRxPGPGAry28upqLp/uCKFKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxQ9vUvuNOOa3WIhlzDsZXHvkBE/MWfHjq+OP9VpwnU=;
 b=L7qt8JvenlOG4DZlcaRVRKZmvy3oZhD4cR5sxeKLgo64Z/eybRE24JP9+PTTfJrJqbybuIXnxHDv1R8PFOwcsCgMEn+Obll8W0rugHV2Gm44W6Q9GudPHry1rvwXmc+DId79Q+mZD//vnT9yXnaSI+PabKLQbLIZXsF0FPHwKMRFYSV7p8R/Zl2qP3rDOTYMzY+I8D/FZMztI6TeSL+TvctKB6WKM6ygqLylw14M4MpVSfl5W/Dw0Gy1EIU0uXKnrxYE3XwaE3J4VKA3P8QkRb7dbvY7vR+fMyEvfN994Cwa6KRXFHtuMDg/RAjvF5bS/i/vDLkgCzUhU8qVjSfSiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxQ9vUvuNOOa3WIhlzDsZXHvkBE/MWfHjq+OP9VpwnU=;
 b=Ui982Ou0zxuhMSupEnnAxmFNsK2ytk9Cyq8nPxFEfZl98AbqlEmZ+WaqIwZ0mD+LbDdzyJjpQEc6R84Ly/LwVGrZgzJSlJ90gwuD9ub14sBFFdOXMRGbTCj1uuKaBWKITf4bJzDOPFwrK6pG7QVbQx7cfP7SY+UM/+a6zmXLLV8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8193.jpnprd01.prod.outlook.com (2603:1096:604:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Sat, 15 Mar
 2025 17:25:35 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 17:25:35 +0000
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
Subject: RE: [PATCH v4 05/11] can: rcar_canfd: Add shared_can_regs variable to
 struct rcar_canfd_hw_info
Thread-Topic: [PATCH v4 05/11] can: rcar_canfd: Add shared_can_regs variable
 to struct rcar_canfd_hw_info
Thread-Index: AQHbjpVbFtAUUF3UbUWhs5SvNVFUPrNywpMAgAG+kYA=
Date: Sat, 15 Mar 2025 17:25:35 +0000
Message-ID:
 <TY3PR01MB11346BDB68256E541427CDEF186DD2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
 <20250306124256.93033-6-biju.das.jz@bp.renesas.com>
 <CAMuHMdWM5Ns8LbqRMRnHgrOdtdO2Hi0OmsCGE0Tu69OALT+8kA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWM5Ns8LbqRMRnHgrOdtdO2Hi0OmsCGE0Tu69OALT+8kA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8193:EE_
x-ms-office365-filtering-correlation-id: 71ea0c40-e096-4a92-78a0-08dd63e665c7
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eFJlQTNoTmJYNVNKbVJiMEhlejBQTy9TWmVSSnAveDJ0SlM0VkpVb3lYSHVS?=
 =?utf-8?B?N2l4YkhHM3lnNmh3SFRTV1EyQUQwcUdUK093dzJxWDlUTWx2SHVsSnBEVDRD?=
 =?utf-8?B?bGo2R1B0cUxjano0WHFCaHF0a2p0SEMwb1o5QUtoZmhkZ1JYeURtdlAxYlVj?=
 =?utf-8?B?QVFLTjZ4cWNRdGRkaGs5U09Xc1RaMVlJYlFlTEhETFJXYW9sY3I3aVFGZ1N2?=
 =?utf-8?B?WW1kMXRaYXVwWEw3b3NpN2FTd1hzOG9iV2pIamV6RHlzVTdUMUFGWWc4Qk81?=
 =?utf-8?B?Q3B4RFNzUko0QnluSWh4TmZMaUpmbnZXVTlDY1hBckR6elV6SWw5REprQXRD?=
 =?utf-8?B?L0d3NFg3YU5BNFkxQlJYSW03VFVCYWRFTFpaMitzZUFDZm1Pa21mM2tuKy8w?=
 =?utf-8?B?eDJXMmI2WEN6WWhiZUZRMDlyMTVFLzd1M1REZXhHU2JRdlZEbzJmaGQrR2Fx?=
 =?utf-8?B?WXg5Nk1sazg0TFI5dElOenlURHZ4WFRxWXNQRkdEZWZFOWpqemgrM2x6ZW00?=
 =?utf-8?B?OXJsWXkvQ1FhV3d1bDNmN3h1QmNlWUZ0b3NmZ3JqRTdRV05oZm1WaVVqcW1j?=
 =?utf-8?B?Zmd1TzliN2dZVER2SG1tOE4yNFczam5SY0FpVnJkMElEM2ZYRy84cktFYWJ4?=
 =?utf-8?B?MW8rZTAxOWY2OUZiQVFHK3JVOXk5SXdtUWlGWlBKazcxcHBhMlJHRTlNaTFC?=
 =?utf-8?B?WWlXYVlpSWo0RW9VREVadmlnTU5sTVFKM2dkT0FUcDNmWXlpMFBMblMvV2pz?=
 =?utf-8?B?ZmFLK2RBK2hFY1JnOU5hSGs3S2hVS05EaWI0QnhDVjdHYkJ1cVQxcjl1YUpm?=
 =?utf-8?B?cDRLUHM5cXp0d2hDb3pNRWVxZkZDMENXK0MrVlFUVEJidnIzdlNxTGt6bXM1?=
 =?utf-8?B?WVhoTmFtY0c5TXNzN1dneEFjdlNXcEx3Mzd6bm1DYnQ0cFdqZzAwNUdyK2pm?=
 =?utf-8?B?UGZxUGVNUFBzMXhaanRrRnYybmlrTzRUTGhRTHB1V1cvUzlZSXpvTk91blht?=
 =?utf-8?B?QTQyQ05CTnlRbi9oeUhrYWxpTGl6TkxBcUpnV3Rpc2V2TFJqbDdQZlR4MVoy?=
 =?utf-8?B?cFQvRDVaYVFJOTVJUGJjU29kSlhjNHBNeC9ub094SzVvWHduamhZNlVTWDA3?=
 =?utf-8?B?ei9JbEUyRnhyS3lVNWg3Q1ZZU0ZiMUx6NjV0UjMwaVMydEJpdDFCc01qNkp1?=
 =?utf-8?B?RDlDd0gxcVQrRlBwbFRtalhCaU5Ta3F4UUJUdHJsSExXRXhiblliSFRLTXpm?=
 =?utf-8?B?V0dnNU9rM055ZHhUd2FxaEltZ0xZelI3MVpVd2IxOHJyZHdWY0wzdUw3Y0c2?=
 =?utf-8?B?cERJUzAxTnFxKzk2SUloOHdMaXRPd2wxcm5DQzJEN3VnQjE0QkF6OGVyV21i?=
 =?utf-8?B?L0lGUlVBR25Gcm0rSGNnWUM0YUNENzM2TGV4dlBhcEtML2dxbENISFZ3WWZL?=
 =?utf-8?B?MHdZRHc2OXdnQTJuZDdZeStwdkRSb09rMkFIZjRKYjNGcDRab0ZTa0Vic0E4?=
 =?utf-8?B?YWVRcVMxbXAwOEZJVUJVUVd5TTRjNFgvVURmZm1rRlRtODlrLzlXYm85Y1gw?=
 =?utf-8?B?NzhXVjJHVTFZUEhhd0UrbTczNWZaaDhEMzUwcWtjM0lOTjd2clRGdU8wNTNC?=
 =?utf-8?B?SDdHQlFGVTZIQmo0T1ZYUWdEa0ZtdGdydFFtNmJmenNLZEJteFpORVdYaHVm?=
 =?utf-8?B?cjBJVERsbFNCRVc1dUpGYUpJZkszSXk0SzBJQ0xJeE5SZFBDck5IU2RJZkJi?=
 =?utf-8?B?QXZYcExoSXZiREVGVHRVVE5zWWZYOEoyQWVRRXppMitnb0hLdzFvZ0V3aDlE?=
 =?utf-8?B?SW5rNWxTRitveFlqbGNsMUJqRDUxajlDTmZFR3VPTG1FaG9hWXlvQVJ3bUNS?=
 =?utf-8?B?ZVV2RlRhb2NpS2FPZkgvSmlpRGx5SGIvZklUYWhLZUlZTHMwSHhXeWIxamxJ?=
 =?utf-8?Q?qILF8TcRJ9rwLT6SPt18emzReqjPGYtk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?enRORUlxaVlqUVdsKzVJM3FYVkZBNjQyVjRmVDB4ZkZtTU4xclpsb0hxeFFI?=
 =?utf-8?B?cmJWSVNlbjVxSklOVjRxeWNlZ0ZmVEs2Y0FJaEthVHNlN3l0REtnbUd5dm0v?=
 =?utf-8?B?Zk1pa1cwdjlYK2phQkNUYUN6OTlpb1RVbjY0ZEVvZER3Y1EyaUhhWVNkcHVn?=
 =?utf-8?B?RXR6YUdYY2N1M3lydTFBdFQwQlM1bHR6RUNYUENxVVRIeElMRFdGWWJhQ0Fy?=
 =?utf-8?B?Z3ZVQUxDa1RiM3Fkbll5dHRYR01MMlNUcGtEYjM2RWZFbzg0UHJWY1N1c2JD?=
 =?utf-8?B?Mjg5MlFrRWxvT3ByRUZCNVIzN1NDQ29YYmNGODJtYzR0cHA2djREK3l1b2RX?=
 =?utf-8?B?S01URzF4cDlDWm5YMy9zajBqem1EcElsUkNqSWpxZmg1cmEzV080eGhCNytW?=
 =?utf-8?B?YVFVSVlrWC95RU92bCtIRnI5ejZZaUZSNWUzVUZWcGc5Q2Y1Ym5nZDdUQVB2?=
 =?utf-8?B?Z29NRXpUeXNkL2RhQlRmT0ZmMGF2TTdZUlNvaDJycGtsWG5LdkxPWlBJY3pG?=
 =?utf-8?B?ck1YZS84cEtCMU85QWZCVytaWXVSbTlZKzFpNGlxa044YlVRNW1VYXJVa1NC?=
 =?utf-8?B?WWJPMXg1TEN6Tlh0M2pKREl0RE9OS2FabXNVOHB6MnE2VThWNDhuMXluSkRi?=
 =?utf-8?B?TWFNbUViNTdET3c4K1lCV0FiN2FTaUZVQm9meUZNZjJDMzRvaXB4T2pEalk2?=
 =?utf-8?B?YXZzODFLSEs0OUVGQS92MVdjRHcrRHBVU25LWWxlbG03eG9sYjV3WmU2NkVC?=
 =?utf-8?B?NXNzWE95N2ZkSTVOc0MwSm9nc1A0NGNES0VZTTlVYUROZDBIb1RPN2V3MENV?=
 =?utf-8?B?eGdoV3hwYkdFQUJDd2VzYVpNV1RmSFlHdVlqSlhFMXFUem0vUm1wK214NEZz?=
 =?utf-8?B?Mm1yUHBMQyt6dklOWjUzQUZ6b1E3ODhpMmQxWGQwdWVRWndrSVFkNHFLMm1q?=
 =?utf-8?B?MmVLNHRnVHRmOEhBTVU1SFgxZDJ0YUFXWW1wMkxkbzdhYW84T1dyeXRKNHdU?=
 =?utf-8?B?Zi9JOFlqa2JONy9lUWlMdXdYT1lNQXRvMlozMHlJaFpQaHNBSTVFMWRRTW1H?=
 =?utf-8?B?c2NGYmkwcEZzZCt0MTJXa1RFZTRybDJ3K1I4ZndpY3F5SlR3MERneTZJd2lu?=
 =?utf-8?B?OW9UTjFacllJUzVIUUZQKzJDeUR6eGprUVY5dVdYeFY1dmFMTWliQzArL3pT?=
 =?utf-8?B?TGh4N1dKODB4M1Y4eDZ4NHcxS2htYWxzdFpoYWwxdnIrQkpUbDBFMUVXY1M3?=
 =?utf-8?B?enIvbW5Sa2hCMVh1YjlINEsySGk1dUJKYWZGWFVJVGpXNi95bEFTbzNQQk53?=
 =?utf-8?B?d0lhMllYL1g1SXFOZHFDaEJoMkNXaHkrem5XWmNuZzVFS2c4L0JKNVNadkZy?=
 =?utf-8?B?RndHQUVaK0dWWWgyczJLMWpRd2VSNDlUVkZtbG9iWm5qdmdRMFJVb0FkOGc3?=
 =?utf-8?B?WG9GRjFlVHJRbzd2OGZqM1RJa1VVUWcxdGl2bjRkREtzNXNVbUYxK1dmT01m?=
 =?utf-8?B?L2VhUDlyYzF1eVlxZzRkOVFwY1BnckxOZThVRmdFR0ZIRXVZVmxpbjVwUlJp?=
 =?utf-8?B?WGdObzhVbTdpUmZnSU5pZ1Y1U0FLcmtaSUU1MjF4aHhrYmZlcnFubnB0VmVw?=
 =?utf-8?B?M2NYcitEQ3NsTWdSVXRQaWJjUzhlU2lNemYvbm44VzhhVDl3U2pwVk9UWDVQ?=
 =?utf-8?B?VWlWRjlBZXFtSjhtaVNhM1YyZDlmVkM3QnZ1NlRZNU1MalY5R1RWZzZXaTZY?=
 =?utf-8?B?NVUwcUo5bktldFRXWEgwVThld0NDYU9LL3h4eGpwT1N1OW9WUFRXWC8rTW9F?=
 =?utf-8?B?eHoxZ2xydG4xMXl0REFnUjhxQWdiblc3MExQeG1zT2RhY1NKYlVXbDdidW9p?=
 =?utf-8?B?dDFaenRhWHJRaE04Q0JMZnFQK2wyUG9aSCszYTBpOXpLS2FwZkdOMG0rM2pK?=
 =?utf-8?B?Nnd4ZkgzUlRkUldwMUZ1aHhQalNRUWhIMkJETVlpQmFMMmpQakZCUVc2aGpo?=
 =?utf-8?B?NXFQWTdFMjJ2Y2YxNXZhREpIRTJzV3REdDUzYlFZam02UklGMU43TWNpeU9h?=
 =?utf-8?B?UUx3anNVY3I1S1ZzUGxmbUV6dUMrMUg1VGFxZHBHTDZmMFNPMXRGc0tzRUo0?=
 =?utf-8?B?ZnFNMUlYVERXWDdGeDdzZ1pDeUNGMVBtRCtuSkNiRTFxWmcvaGhTSWNSTDVO?=
 =?utf-8?B?Mmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ea0c40-e096-4a92-78a0-08dd63e665c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2025 17:25:35.7351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aEVuimDishAnwzuTVfbmNuAVecVz2J8QrDGzBijZD4h9LZKBqpNgqw35CR3BFWX5JpMmTGX850cC+1VXPo/Eh8IWMsXNWab+ZwxO9zMfea8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8193

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogMTQgTWFyY2ggMjAy
NSAxNDo0Nw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDA1LzExXSBjYW46IHJjYXJfY2FuZmQ6
IEFkZCBzaGFyZWRfY2FuX3JlZ3MgdmFyaWFibGUgdG8gc3RydWN0DQo+IHJjYXJfY2FuZmRfaHdf
aW5mbw0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IE9uIFRodSwgNiBNYXIgMjAyNSBhdCAxMzo0Mywg
QmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiBSLUNhciBH
ZW40IGhhcyBzaGFyZWQgcmVncyBmb3IgYm90aCBDQU4tRkQgYW5kIENsYXNzaWNhbCBDQU4gb3Bl
cmF0aW9ucy4NCj4gPiBBZGQgc2hhcmVkX2Nhbl9yZWdzIHZhcmlhYmxlIHRvIHN0cnVjdCByY2Fy
X2NhbmZkX2h3X2luZm8gdG8gaGFuZGxlDQo+ID4gdGhpcyBkaWZmZXJlbmNlLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiAN
Cj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRl
cmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+IA0KPiBPbmUgbml0IGJlbG93Lg0K
PiANCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiArKysg
Yi9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiBAQCAtNTE3LDYgKzUxNyw3
IEBAIHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8gew0KPiA+ICAgICAgICAgdW5zaWduZWQgc2hh
cmVkX2dsb2JhbF9pcnFzOjE7ICAvKiBIYXMgc2hhcmVkIGdsb2JhbCBpcnFzICovDQo+ID4gICAg
ICAgICB1bnNpZ25lZCBtdWx0aV9jaGFubmVsX2lycXM6MTsgIC8qIEhhcyBtdWx0aXBsZSBjaGFu
bmVsIGlycXMgKi8NCj4gPiAgICAgICAgIHVuc2lnbmVkIGNoX2ludGVyZmFjZV9tb2RlOjE7ICAg
LyogSGFzIGNoYW5uZWwgaW50ZXJmYWNlIG1vZGUgKi8NCj4gPiArICAgICAgIHVuc2lnbmVkIHNo
YXJlZF9jYW5fcmVnOjE7ICAgICAgLyogSGFzIHNoYXJlZCBjbGFzc2ljYWwgY2FuIHJlZ2lzdGVy
cyAqLw0KPiANCj4gc2hhcmVkX2Nhbl9yZWdzPw0KDQpXaWxsIGZpeCB0aGlzIGluIG5leHQgdmVy
c2lvbi4NCg0KVGhhbmtzLA0KQmlqdQ0K

