Return-Path: <linux-can+bounces-6526-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLrqICLmiWlPDwAAu9opvQ
	(envelope-from <linux-can+bounces-6526-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 14:50:26 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D749910FE2D
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 14:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4E193019119
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 13:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1D63793BC;
	Mon,  9 Feb 2026 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="I2qeZY0N"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021130.outbound.protection.outlook.com [52.101.65.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2129B274B48;
	Mon,  9 Feb 2026 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770645021; cv=fail; b=UuCKeYdSTaCVn97lUfsYm0my4MO9oaJQvOB4qVr8vSo8fb+DUdOVsjUu4bzt4GzzjJ3a0s/GulMZQrgTt5T008czkVgHbbnfZ2QfBC0rp1obj2JR+oytka1tG631GwT4B43ARXfnRFkzV1bv6mEEvOR7TuqU3RckkF+ylmqnRws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770645021; c=relaxed/simple;
	bh=H/c+4MoMAVbcRkqrDB9/XRYxknuVh9ILK2oJPiitUsk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X9cfmFhG1qfc3d34uhbytguoduHbtma1nm6US0YrnSP5ya3FBhqnWZ0OZTIcdUkmOnV2an6xfFKm8NjmOTJHijleGMZbzq7Q220XPFfwZXEwMBPfrvpfUgd29fVFbP1bCxJwlmC63q8wOIK+Nz3Z9Wl2GcrOEBShX7IdKN+47ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=I2qeZY0N; arc=fail smtp.client-ip=52.101.65.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yj1bxPT9siEg2/nCi+/xQF0xHGvbK40fmzmQW3NhOJk1bcZmZtrH11K4rxQQvOa3tanRm0vsYYudZZqM6h80wzFVc3QtqPxT2cXGaXszLHQnsuGzwNdGWrnEBHQPnZYmdGysm9H3wCL2YDE2ZG3MEkbqo2ZKkB1jLLr0lUh2KC4BpYbLsNRuU4n+SXWD+foUqUK5DkR2PnkmpiQ+9UebwKqW/sSj/zT0VSyMKwcA8oB0qgv9sGiyMksNxCF2roKlx61dNwBh0pA1ocLSDK+Wb3Uh4u+/IqvJ3Pb8ahbcAobEPJZcIvM+cPz+viWM3KiD95qncVUWOR6FflVTOaeJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mHlKpobSsJIPzeG5XT3Vq/A+QPdwfR2/LMFWjLikmc=;
 b=h7oIklHnqiT5kWOQq/4Wk3mi+2UqI21MjqsmPWFjWwoiRabPJq8u1AeCvDBd0e+z1ZbmM5bWQsjxyGkXWwGSSC0sNeDn/uBcNdsWmXL33srxbfplrBFf1LOexYWywgo5oNVG6/l58Q3vbJvly1E/2XDdJ46ccA/2p+4IW6PiJNMNHhFpCgPipsYMAECvrDbGFFONEQqa4cgTvhWYY+nO2doxaSQWGi8wTL+9MahE7+HT/HORWk67Z17TDRQkvzq3uFR8Di+bcaES1l7G2571hu1QSaGzsJLVbOhw1o+OMqQjfXnVAYJ5M4brwXRcUUiB/hz2KtQ/n+CPkpRX8CYb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mHlKpobSsJIPzeG5XT3Vq/A+QPdwfR2/LMFWjLikmc=;
 b=I2qeZY0NKH6xxAASxrKiiYsUdyM6mA/9+32vXvaa565n0kimHVTpQEC49/BERn3vnkTyGUxizlCgIQy8QbddBOLjuBa+QhC/iswLYxeMEYUnlzkgbdvsDwmxMz6ILLSee2QmEil02TBRLVyqcauxx3g7FrJK9ErYmetzTkfoXfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com (2603:10a6:20b:5c1::5)
 by AS8PR02MB8779.eurprd02.prod.outlook.com (2603:10a6:20b:53d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 13:50:16 +0000
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714]) by AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714%6]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 13:50:16 +0000
Message-ID: <793644d5-4d4f-8ee5-7fcc-369536801683@axentia.se>
Date: Mon, 9 Feb 2026 14:50:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
Content-Language: sv-SE
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton
 <jon@solid-run.com>, Mikhail Anikin <mikhail.anikin@solid-run.com>,
 linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <CAPDyKFpbpcg3ei51hEcG5FzJL7tK44PdBcMbxfOdON7ozxP2Xg@mail.gmail.com>
 <9f49bf4d-48ab-cb8e-db39-3f573d20bcff@axentia.se>
 <CAPDyKFo2Zm2LKP6=m=fJEbo1a2ZpBn10EGaucFS7zGfGJV_6tg@mail.gmail.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <CAPDyKFo2Zm2LKP6=m=fJEbo1a2ZpBn10EGaucFS7zGfGJV_6tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0000382C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:f) To AS8PR02MB9235.eurprd02.prod.outlook.com
 (2603:10a6:20b:5c1::5)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9235:EE_|AS8PR02MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: f0eb3dc6-9949-4f6a-fcc8-08de67e227fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWtxZHYwR2JJYWFOTEFJL3M5VlRsWGlzbTdqRkwxdVN3bG1MSWdSNkhlSmVN?=
 =?utf-8?B?M1c0c3plRU41Vk55eHBkbU1MTG9rbTgxUFd3YkYzZjlnaTV4TkxWYnpnWFFa?=
 =?utf-8?B?REE4K1lzcXBLWWJhRTZuc3E2ZDllcUVTZW9POFlkTm9udVB5TGpCS2J5bmlF?=
 =?utf-8?B?anFMcXZINVNMQzJIMHRtY1lydWVtOC9DK0t0cjFUUldGUlovZENidXg3TjE4?=
 =?utf-8?B?d2I5UmpaQ2JPZURGazFGaHF5WkdmUlpxeEtWcHI3UHo5K3F5N2RVcmRwdXJs?=
 =?utf-8?B?NEVlMExJRTVLRi8zQUYxKzdzcFIva0dERDk2ZnpZSWRHVjNaRkFzb1lQY1lN?=
 =?utf-8?B?Nkk3UlYrSlg4VndjcHBPRzUrTTdQWGxKM05XMTVRYXhRSE5VZXpKYVdqaHVQ?=
 =?utf-8?B?TndIRWZGdjdPcUFBWDg2MnM0cW1NNEQ5TkIvMnZ2THptNzdudndudnN5L0s1?=
 =?utf-8?B?NmsrNUVTS0t3b1ZRb0ZhTTd5QWdONDFUdk9udnF5NkdaeWx1dlN3bUJvL0hN?=
 =?utf-8?B?aGdTKzh6dEtYQTBIYmMxZjNzNCs4Yjl0eDRiakNzSUlPMWxrNDBkTTVvNTQ0?=
 =?utf-8?B?WVVvaTI3SHpRRjRRc1FJOUdXY2FiUThwNEVvVmdOT2hNbU1Xb3BMY3BubFpV?=
 =?utf-8?B?UzA1WmdoQXYwVzBQQTdTamtJbUM1bStSRmZuOFkwQnBoZXFYRTJFQ0lic0cr?=
 =?utf-8?B?Ly9nMWdIOGNOLzNwdEhDdjE2a29iNDE2bkpOOWF4eUxtdTNtMFFLd1BBSGZz?=
 =?utf-8?B?eU1Zb3pETHlyZFNtaUtsQTRXVjF6UmtvWTVtNkRyTkljY1lLSGpNZjRwY1Nu?=
 =?utf-8?B?QVNvT1pacVV0K0llYm5laTJXT3VvY0ZLd2h5SkNDV1RzM1NqYm1kb1M3d2VT?=
 =?utf-8?B?Nk9HdzJLc055b291ZE0rZm1FNngzejVKU1JhWm55WW4wVFgrSzJZaG03eWhZ?=
 =?utf-8?B?azAzalRBYXpjcXRDSkJWWmZHMmtjbHkxZEFDNzFsWUFHODd0WmZOdU82ZlNF?=
 =?utf-8?B?cW1nZWw4WXowLzdYZ29tVTFqTVhoUCtvc1oyTEF2OEdqMVNvMHlJYTcyRlBH?=
 =?utf-8?B?REV2YkZ3ZHB0NmZQZGhQbWxSQkRzellHNC9MeFAxVXFlV3hVOTFBVlR6Vkto?=
 =?utf-8?B?aHJCUTJGd2VBWEwrdGFwbW03VE4yK1hjOVdORWdlOHVJeW15cjRmbkZIV3JB?=
 =?utf-8?B?d0s4R3h0QU55b0c0L3pqKzMybEIxZVdDVkxwV1Q3eU0xalVOQ2N4aytQOU5Q?=
 =?utf-8?B?ZDZydW1NeHdSdWdnWVkwWEhEeGNiSTU2ZFV1aGhRU3hDOTYrK2ZVcUlQSTVE?=
 =?utf-8?B?dGZiak1ZS2dwdUFidFdXYjF1OHpJMGR5Z1gvU0JvVytWZHFQeXB0b0owQWhE?=
 =?utf-8?B?dWFQRXBoY05IWVMvbjNQL2NVSU1CZFh1WFNHRitpRVMrT1d6RVE3MStodGJ5?=
 =?utf-8?B?WU04am1vQ2FEdnpwNDFWem1OSDlvbnp6SFRacXlqcEhOY1hhM1ByY1N3amJk?=
 =?utf-8?B?QWp6b1E5c1EyT1JaMW5ZMTJoL2lGVHlSSWlYbW1MMnJxelRLaFJrbkNTNlJH?=
 =?utf-8?B?dm5YU3VxM0ZTZktnZndMblRPSVdDNVBnRzZNVzNUSk5XaTNxMTIwRFdPYzhD?=
 =?utf-8?B?U3M3dklQY2tYRThhS3JjUm9NR1VVSXhNYThPYThFbFFyd0QzMEdzUWIxQWFS?=
 =?utf-8?B?Y0JZdXRKaGI2b3hYdi9YeVRSaUhFK3RQbE9iR1pmRE1mMUVCZE9zRkdNeUsz?=
 =?utf-8?B?YWlWMGEwWmtQWXZnZXdRSW5TWVpvbzVPaVNZMzM0ZzlPU0htRDluZnkrRi9u?=
 =?utf-8?B?cC9abFJDamp3R0hxTTlzWGs1bUprM3lFaU11dW4ycVBBUUJ4RnlkTjBRWHVP?=
 =?utf-8?B?SENMMHEwOUw3NElKYlp4SG5SZStMNkNSRGlqMTM1RXJBNnRHZzFMOXl4akhz?=
 =?utf-8?B?YzZtL212Uit6NCt4cDNVOW8zMzRYTThVNmVaOUhYN1ppdk54WWk2OWZvZDdz?=
 =?utf-8?B?VGxxdjU4N1htbTZ4RjBGTjZCUE43bzVPUnIxZlRUNU5GdHRyZWczTVV6Wk90?=
 =?utf-8?B?Q1dNN3ZjT29NN1NqMGRBR0gxVHYxWmhsMVR5SXhpS1VEbHpxeWtNaUFVMFdy?=
 =?utf-8?Q?qTCk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9235.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlZZdkxNUlpBZkoxZzRNY0ZWSnBMOUt2RFNmVzFDdkxkZGxLbGNtNWFQcWJt?=
 =?utf-8?B?aWxJaHVrb01TU0xia2JXeTQ2dmxOU3dzYmV6NUpHeFpPa2pnczhzcDZEZmdK?=
 =?utf-8?B?b1VoUzZQVkRvVHFoajMvSmNTY0pHdmpPaTQxdStUVUVsMzlsY1J2UTBXbnZM?=
 =?utf-8?B?c0ZsemdUOFVzNERzNksxNHY0QlZBdzcrVE1PZTFVdjI1NXg3cVhmQ2toOTFN?=
 =?utf-8?B?dVlVckg2ZjQzU3FHUXBqamllZmJsNGlUZDNRalRsSzh1OXU5TTkvKzZrbmho?=
 =?utf-8?B?ME9XVm00T1dtOXB2MEtKTStvcG9ldG93NzZ6cFNOK0ZxUUZ1YkFBc0xtTEcr?=
 =?utf-8?B?N1gxa2V1M0xTeTBwOEI3amxTRkQ1VEdldmtIeHZyTmczRTA1TlF1dXdIY3VX?=
 =?utf-8?B?Zm9UcEFVMWJ0M3JoQTlkbGhtbko2VkYvYU5xWVdjMG1kc3dXODlXQ1pFNk9D?=
 =?utf-8?B?MUJNV2FkZnlzMTVMcEErV01xTEhuaTc2RkNieUxOaUlvdlNtSW0yL1lYU1dq?=
 =?utf-8?B?LzlXclBmQjhYcHhYQjdyQUtMNi9tYnRVb2lGWjhLS1IzOXJibFJWaFF6NFM0?=
 =?utf-8?B?WllDd1NoQTFPWUVvZWxsci8wUlpma3AwbDVIZ3E0S21oUGovSHJBaHZZcFE4?=
 =?utf-8?B?QnY2T1pUWGNaOVBOMnM1VDUvQzdQQlI1Z0wvWHJqdExuVEVTd3pPZGRRQ0w0?=
 =?utf-8?B?alErbVY2bU1LczFnKzBRUTcveUtNWFBFMWU4Y25uRDJIc0NMRmhnZHkwZFRi?=
 =?utf-8?B?eVBNc0JKZEVZdmpHTE54NEo4c1Q5S3ZpVU14VEovTTdGbWFvVVFxYXZkbHhs?=
 =?utf-8?B?ajMrTmtkTFFDZUlxY2l4M2lJODRiUG9SVlNrWU9jcWRySHJFcXpsNGM3NnlK?=
 =?utf-8?B?empsaDU4b0dwbnV2WU50L2xzMi90YVpUV3RRdTRhTUFkSU1vZzg3WFgvTnFj?=
 =?utf-8?B?MStObXRyZzBxSU0xbW9TTmVYSjRqSVVrYlpCdTRUUlM0UThXZTZhQXgzWDEz?=
 =?utf-8?B?RDNTY1N3V2JjTVNsaDhhNWQrVDNPSS9MN0Z6emV4YUpQdCtPSG5PMkJMbm9h?=
 =?utf-8?B?eUx0cGt6a1RBYTYxVUpvalpFRnYwRlNjQjlkOURBMTZXY3ZhS1BKMXFlZ1pH?=
 =?utf-8?B?ZHhBWjhMNHJZU2o5MUViT0ZNbWo4eHFtYVpMOUtLbW5qWXAxRjF0VWxqS0Rh?=
 =?utf-8?B?V3RlUWxuNUE4U2NLdEErOFJ3VW5GUERvRXpqRi9HVU5XQXVuY0xXUEtDbU01?=
 =?utf-8?B?c21ydlprV2VyU1dkdDRyWW5VaU5zRmhaRVEyWHphMVZaU0Nkem45ZUxHeENU?=
 =?utf-8?B?ZW9UTE44Q2kwclBxVlFWRDd2T2ZocGREdUJuNGFMWWdGblJRRng4UUJXR3JX?=
 =?utf-8?B?ZW53dDRFd0psVDRuT001S0F2dnNHVzFnVG5NdFFabUt0WGhYanFPeFhoT3Zn?=
 =?utf-8?B?RVJtaC83RHNkYlFDZXJrcE4wUTNkUktTZENYK2pGN0pONGFIUXE3ZnJ5dXh1?=
 =?utf-8?B?YTY2bzE5cHlzWmpQYVAvNW9pSUs3Y05uUTZteHdpUldZUzhaTEhETlhqOW1q?=
 =?utf-8?B?M0pmZHBZa2Q4U2s1RU83Y21KbUFRUFdFRDdNKzUxOFhGc3lWMytWQ2ZiUEJs?=
 =?utf-8?B?bEF5cjl5eW1yT3BYczZ3NnIvd3VvMU8wYUZiUEV1ZDIyaVU1RHRYMXQ0WWth?=
 =?utf-8?B?MW5CTjFRV3lnRy9PWkxyTDB4T0hSQU5HNUZzMVNsYVl6WGRZNWRDTHlkak5U?=
 =?utf-8?B?cFduRmdvZFBEZEhuZXBqZHU2Vnp1M0MxMmUwZGNsZTZnSFRneSt4WXFOcGF3?=
 =?utf-8?B?d0RzRXZWb1l4Wm1LNTFmQXpMSVoyc1hGOXgzQWxNcUFEWlNBNlYwNTdtTTV5?=
 =?utf-8?B?S2s2b1RHZmdXaHIrb2xmODRWWVgvdjBMa25JUzNWTk4rd0FzNmlYdWdKQXVO?=
 =?utf-8?B?L01sQ1VidlJZRk8vcDU5bzZNVFNZQ04zTERIVStoWloyVmZtMXlHYnlQWS9G?=
 =?utf-8?B?WFZ4V0ZrdXBGa1dUMGFkeHBHdVowdW9vNzdQZU1landzRXhvOElycmpYOVdl?=
 =?utf-8?B?U0pkZnd5Tk0zemwwOWNYQUh6VHE4d1JYa0pZR0hYRkxlalVTVWxQd3ZMdWNy?=
 =?utf-8?B?NGpUVlN3RGtqQnFlYTNoWUo4S1dOQVh4WnFGT1pESEVTS2VFYXhUZ2hCZmFx?=
 =?utf-8?B?MUVPODgzY3BuUDRJTTdiaUFQb1lNckRMSE9ZVjlweHJPcWNSQWtlbnI2bjk4?=
 =?utf-8?B?T1A3Vk0zeU9JTHhQZERxMTFKcnlUMTJBWVVWbHZZVXNnWklHOFloRlorTC9h?=
 =?utf-8?Q?sNWR+2s0WtyMQQytpu?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f0eb3dc6-9949-4f6a-fcc8-08de67e227fc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9235.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 13:50:16.5879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ehqZjtZ/RnSoC5SL2MqhnOvVcVpNPvpQx97+8S1FCtkXHgMsKRJSWeotaISTdN2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8779
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[axentia.se,none];
	R_DKIM_ALLOW(-0.20)[axentia.se:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6526-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[solid-run.com,pengutronix.de,kernel.org,linaro.org,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[axentia.se:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peda@axentia.se,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D749910FE2D
X-Rspamd-Action: no action

Hi!

2026-02-09 at 14:39, Ulf Hansson wrote:
> On Mon, 9 Feb 2026 at 14:16, Peter Rosin <peda@axentia.se> wrote:
>>
>> 2026-02-09 at 10:57, Ulf Hansson wrote:
>>> I have already applied for v8 and it's going to be in my pull-request
>>> for v7.0 in a few hours.
>>>
>>> Please send incremental fixes on top instead of a new version of the
>>> series, then I can pick them as fixes for v7.0.
>>
>> Hi!
>>
>> Sorry for being late with this, but as the mux maintainer I'm not
>> fond of
>>
>> 028ec00381f5 ("mux: add help text for MULTIPLEXER config option"
>>
>> and would not like to see it in rc1. Can you prevent that some way?
> 
> Sorry, but my pull-request and branch was already prepared.
> 
> Please send an incremental patch on top then I can pick it up as a fix
> for 7.0-rc1. Unless you want to manage this yourself via your tree.

That unfortunate. The patch series has not yet made it to the next
tree since it has not seen any updates the last few days. What testing
has these patches received?

Cheers,
Peter

