Return-Path: <linux-can+bounces-7492-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mD2RB6TC+WmxDQMAu9opvQ
	(envelope-from <linux-can+bounces-7492-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:12:52 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A92894CAAD3
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4E2C3048F03
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DB9346E7E;
	Tue,  5 May 2026 10:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I7bn2aId"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013059.outbound.protection.outlook.com [52.101.83.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B8F344DA0;
	Tue,  5 May 2026 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975545; cv=fail; b=E1Me5sE3DjBXMAayGrXnxSL8w3FEN9RVPue2wJq/DQM072mvkHpzFqjumfu5cQOE4AwPrgCfNr1p6ZUs3gWRac1eNjdw9UblCg0uuhypC1yA2zPlkKuVDA3i1upNUOhyXuM+iEcFChy8fwoxBKuSp0MyPiow/T95Hrsdm6VueCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975545; c=relaxed/simple;
	bh=tJBIdZPxfCHg+G7YLZZitSSWGK2U+K9p7e8Og83D3EM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VxJsikNrHX+iZZhGDiz1MMrQD9s+PN6T6vM4bzoTzECx3R4bXY24ShnYxiYk3TPhyw4kFI3kgNV5k9pBCubsYUICidmzG1C3hIBucmNu1A1/IHMFVT0ejVYB8mxf9rPCzVQg6bP0bc39Hg8k24ppRJ42sHeWqGFHmDIyYZiQqiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I7bn2aId; arc=fail smtp.client-ip=52.101.83.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfLV3/hZd/wUxqA51R0IM4i3dBC/3nVSA3oSL2zKzZil9cmwJbtyMOb+8QdJA8JEqVc0ad9TuEGVNXHrCORp4KUZN+7NaNhs9bsHT1ice8DYP9bE6UUSzxqgB23o4bME7VtHPlxhwx/Na3vPRj9o6y2OAoHCBbCoA8cJH/v2VGPtKkc+Ccc4ux186WZfmHKTvdllyEi5I69xwJ0WVQl/r0rjFuRUNmJJJesscHx+2moz7lwk523w/sW+y3q0yLHl6HnwARNoFxogF+IOJamHg7T0IorSkkSXN1W2TfSB5vZx8Jp7g4K3UDoLo+MokLRji05E6NYF3PujBqjwE6qo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h88n+XTwigi2Yy2QhJ661l0nuu7DDirR9Z8PxEAYqaw=;
 b=Xos7kY0wrNnRMQ2mlGEYxEx1/FwtvqQ0NcJ1hZLJeEyw2Z9duVqRtJCWnE6RitlKL1EF8RqEv4gFxm/aBYsjHeLqQ1SnCHV/3l2IUUiYGVHZ832XfmIHPgvuVq/1rahJuwNdDzrE6nS59Iu11n4xNCF7fVVvRDpW6b/WiHP6KXoUIoB8ecmPaH9fghqnqm7grcCz48Wxn2UFkN/Xcm5i3Ge/dML/ABIJiglebTSUcRWaR8auu97/R5vjgsaDrCAMX7zJReG6VsDb3Djh5bL+1RuogffcJLCOz7IUB2pO6oUiHVDMW8VMSj3rkQaOe9uSlKx4M1Oxqw9G+JrUCIKNtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h88n+XTwigi2Yy2QhJ661l0nuu7DDirR9Z8PxEAYqaw=;
 b=I7bn2aIdvDjwjE1xl5T+QAfFQu3zDNpahgQfmo27PH7R3mAs3siN3nrcdRJn/eh5ldKGjR7sA2bc2atx9r++zG9tS+CMqTGOZpFOkdZZs+XYU5HKV/fQUK+1OSoU07BEipJB+j+0GxbOvykPAGXvzs94ji1SzhQLZFlRKqsF+U0PTrgVancpMaeYJDaHfSUwXRYImXWr4sqFpRsBqNtx+Ix2D3AczJReEnuieuAGDyFFi7+/92DJ2UzZQ55/t3jkyWDa6qM90GeXj0h+xfewwcctPLfT5XghA74lfEHnQdBghtzZseVk3pI3hCJ2+bJhMChelGDP0Q7+RVjIeJ3DAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA1PR04MB11083.eurprd04.prod.outlook.com (2603:10a6:102:484::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 10:05:38 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:05:38 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Yixun Lan <dlan@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: [PATCH v8 phy-next 03/31] PCI: Add missing headers transitively included by <linux/phy/phy.h>
Date: Tue,  5 May 2026 13:04:55 +0300
Message-Id: <20260505100523.1922388-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::10) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA1PR04MB11083:EE_
X-MS-Office365-Filtering-Correlation-Id: 696a714f-fc8e-49cb-832d-08deaa8ddb2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	hAfJk+FNsYX+BdPmjOEB0AOYpLVqRX3xOQ18FXAxhEuRO0yl5R0lSH31DQl2wyPBuTwqPS425FsmzdhGBFwqsyk/Tp+4PvX9MPgLfFAL+yFVClD3Wkk9sDkw6MkZ2Yy02np8idRWAba62m1pBk2rFmW9eeZFOTjLf6NeIQoY44o+x7EPTOkLFwe1D0wemeKpGbf8k46GpPZ912F1imYW7FhgFaeAPGKHOEC9GyfBh9kxvn1QClWjbFvIpKgEO9qZfSnqYdywM6cdyGjXBB2L0Y7HfSvfM1eEOEpGi5AqQUTVa8U7mPuz5ct4kSN5q9s7q6eT0a3N9A9N55c2nTnMmkQK/hhSYzRz7bZcPusiMyqbAKPhn6fF0P7/rJb+kLpchXt5mQkIVk6zZKLsS6FZxPy8Ge3zzazraQ7+2IIJnndqGZG1FGVFzyaH0s+ObsFcEtaYsnxpBeufOShw41vrgf1vNlPorJUsQacID0mcErjaYl+6qvvTippk6ClVg2aLyJZFabG0J0cyNvjFxENhjvW/Z/vE2wmoUp/mwm8CwXZIRgZUnjjqVHSzLgMFsKw7+xb2XQHIn0/aoV5ucsvnLj1wekDV4wK4+JD3WkBEbLZonCZfZk7NIbFAGmcPTX79tlPmJwFMvcwgBDZuONmaGDwsNrJD0tbFAxaax10B/OxRcWA2Vobs4YvgpJwdiPWS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjVJQTdENXE3eTA2WVM5WjBOUDVKSXJ1Uk5pb3BxMy9GZXhIZUdJWVpRTlJS?=
 =?utf-8?B?WmlhVXVWZi9sWlY4S1l1bjBjcEhLcFdKWkpmV0RwVzJ5Y2lLTitLUU9sTUJV?=
 =?utf-8?B?M1N0eTVmWnphS1MraElqaHFiK2hZdk84YjFlQjN5a1RYZTIzL1NOOGFhVndH?=
 =?utf-8?B?RTk4YklWalFLMzVhVDNhRi9hdE5Ha09lTThNNmh6VUNsNVF4emNmVVhmS2lI?=
 =?utf-8?B?QXNuMjBSMFRRSUxjMHBUUGJjS2NYQi9JWXRhUFczTktmWC9GUTNUa1h5STRU?=
 =?utf-8?B?ZVo1V3dPNTNUbTR5NHJ0Qk9id08yZFN4VkZDZ0xtYVJsMklQa05NRlN3S3M3?=
 =?utf-8?B?amM4eEt3QTR2Vm5DMTVpU0tQL0ovU2x0TFVkZWl2MElnZ0U1QkFYeDFMYUR0?=
 =?utf-8?B?a3VFUkpzNkpkMmUzVmNOTEN3ZGFNdUlXYmxMMUpwdjh5WUpSd3FtNFdDQUhl?=
 =?utf-8?B?ZjVTTGljSGxIZzBKODdiYWdYZnlFbkNHN0Y2a0d5MFpaaFhlTGtPVjBxeGdB?=
 =?utf-8?B?THR3NDMyT3FyRTZmZG1PVXhkWnZXN3prUXhuRkxPd0VCOUhqaDQ4QXVGaHNB?=
 =?utf-8?B?Zk0raGIyYUIyRFgyRkRoenplYWFPdDY2emp0Snk1R2swQnNrMmw1YllVSnZK?=
 =?utf-8?B?emNQWnQxWUJ3QkJVZCtIS3EwNnpRUm03UTdTMEV5K0dnRWFzREtXa1RRcU5H?=
 =?utf-8?B?d294bGJNNHA5dkJVc1ZSaDBWUzRadUk4eFhxNFVnUGg3MXhkTW9ubzF5azhz?=
 =?utf-8?B?SjJNUUJFOS93MFRVQm5MVXJmQTBFcjZhSUFnemE5TzFYRTFlUDB1Z0c3dlpo?=
 =?utf-8?B?YnE1R0xiZHVRcDFOaU1LTGM2ZWNMTklnaWhGYWNvYWNNR25icHBhQmFXY0Fs?=
 =?utf-8?B?VWZOZ2FvMkw2R0FVaDR1Z0FEbmtTT1pQL2RJZVE0NVhZK0dHRGUwMWZEeEtw?=
 =?utf-8?B?cSsyc0lFYmJDS0VEdDNmeWs2RGJNcjMzcC95Ymx5dzV0M0lleVNCRFI2TGtz?=
 =?utf-8?B?ZU5nVlVxVTl6S1BOQ0RxNGFNcmY0dVk1SktRMU95MS9yZ1gyWXcyMVlpN2xL?=
 =?utf-8?B?RWZaOVZYZkY4Z3ZxSTBmMGxsRjVBOG9aWTNVQm1wRUNWRHQrakRCMlhmYUpH?=
 =?utf-8?B?U0xuMWFCYWxITTluTVAxL0NvdlZlWDYvR2pLbVZDbFdoZkNzRGhvb0VwVVhk?=
 =?utf-8?B?WTJ6ZzdubmZyVENCWGVwZmxnWXpwWHRKT1VvUzllV3A2Yk5WSkRuNXQwNEk4?=
 =?utf-8?B?UW50WDVGSkx0WXpGQW1HYmZPclZ0dGx1NzNoSVBOUGlRQ3BMUFRrZTQ1MGx5?=
 =?utf-8?B?a3FiTzNwYXNPaXcxemE3YXpEM3g0NkN6WFArUHMvNklXTUxiMFo3cHduREYv?=
 =?utf-8?B?ekdhSDhKeFhjSjRtOW5sRE1aTlJ0Tlg4Zk9mOCtNN3lvVmxOR3NDdkFYQW1u?=
 =?utf-8?B?VGllSUlRU0tWdmJvWWRsMVFhWllkZXdTelNWM0JKOWtKcDRPenFLZDVrZHFp?=
 =?utf-8?B?YnJQUEZkNHRqazJNRjg0RlljMnkzYXBRMkVrWDZGOUlqeW9MUFYwRjQ3MkF2?=
 =?utf-8?B?TVpjT253OTJvc1E1cEZOQzhjK0JLNjR1MXBMMU9DQmgydDliSnBhd1lCeHpQ?=
 =?utf-8?B?WUhYdG9BRmVBb3N5dzVGeWNkS1F6dVBsTzI1dHZCZXJ4WE1zWk9NaGR3YUhN?=
 =?utf-8?B?UHFlbGpROE5LQUpFdmpVWHVVTHdvTTA1Ujg1TjZkdkpRMTNBblpXS3VDZGNS?=
 =?utf-8?B?WHdTUzhaOXhTcllzQ1V4WGkxbC8wT3Jlc1ZURS9pZ3p5VEZ3SWptN3VoMTZS?=
 =?utf-8?B?cWxPc0UyMSszVlExMERLR3c0d1NwWGtLSThMd2srVUZrcGVxRWphNEd1Yllm?=
 =?utf-8?B?MXhoWisyblV0azkxZmhWS1hTQ1I4NnlyYWlycU9FczYyWVBZWENselN0eWtH?=
 =?utf-8?B?ZkZkRk83QkhQSjBmaHBkaG1LKzNkVDgzcjBKUHF0aEl5dzZ5QXZpYTc0Zlk0?=
 =?utf-8?B?WXRWNS9nRk9KV09aSWc2YlVwcW10cUR0VzZQek9kUFAwZXRIb20zT0ZuSENr?=
 =?utf-8?B?aFBmZjdXWm9rK0xhSnFzWUNzUkg3cjYzcHRTK0w4RWNKMFZaMTVvK1MzUnhY?=
 =?utf-8?B?Y1NZd2cvVFFtVmU0RjVwR2kycTRrNWZlbE9LcC9qS0k1ODNUUVcyTldLTDl1?=
 =?utf-8?B?NVB6SitsVWdQWlFHaTkwai9wMUczcGRHOWFTWjM5QS9zdjFDNTZSdmRtZldv?=
 =?utf-8?B?V28raGFySDFSanI3ZVRuT1gzeTRRSTBNZlZnU1RCaHhSdFhPQTVuYVd1Unpq?=
 =?utf-8?B?VkxlQzd4c2tMNVl5WlUwS1U1VVNxTkMvYmkzMVZRN1BGcE9hak9oZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696a714f-fc8e-49cb-832d-08deaa8ddb2f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:05:37.9669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkzW8mWjG14A57lYKYUMBn7fQaxI8pw/HaEhMZqFhz8zVJ/P9RY+cvfUwWRNLB5AcuJsX2LiEiGf1VsvAvwtEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11083
X-Rspamd-Queue-Id: A92894CAAD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7492-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,google.com,sntech.de,gmail.com,nvidia.com,rock-chips.com,starfivetech.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The tegra as well as a few dwc PCI controller drivers uses PM runtime
operations without including the required <linux/pm_runtime.h> header.

Similarly, pcie-rockchip-host, pcie-starfive as well as a few dwc PCI
controllers use the regulator consumer API without including
<linux/regulator/consumer.h>.

pcie-spacemit-k1.c uses of_get_next_available_child() and of_node_put()
without including <linux/of.h>.

It seems these function prototypes were indirectly provided by
<linux/phy/phy.h>, mostly by mistake (none of the functions it exports
need it).

Before the PHY header can drop the unnecessary includes, make sure the
PCI controller drivers include what they use.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Yixun Lan <dlan@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Kevin Xie <kevin.xie@starfivetech.com>

v5->v8: none
v4->v5: fix pcie-spacemit-k1 driver, previously missed due to limited
        build coverage
v2->v4: none
v1->v2: collect tag, adjust commit title
---
 drivers/pci/controller/dwc/pci-keystone.c     | 1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
 drivers/pci/controller/dwc/pcie-histb.c       | 1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 1 +
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 3 +++
 drivers/pci/controller/dwc/pcie-tegra194.c    | 1 +
 drivers/pci/controller/pci-tegra.c            | 1 +
 drivers/pci/controller/pcie-rockchip-host.c   | 1 +
 drivers/pci/controller/plda/pcie-starfive.c   | 1 +
 9 files changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 278d2dba1db0..fe4836925c4e 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -24,6 +24,7 @@
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/resource.h>
 #include <linux/signal.h>
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 731d93663cca..ae27ce05247c 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -21,6 +21,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/workqueue.h>
 #include <trace/events/pci_controller.h>
diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index a52071589377..432a54c5bfce 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/resource.h>
 #include <linux/reset.h>
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 257c2bcb5f76..35a297923e7f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -19,6 +19,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/module.h>
diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index be20a520255b..41316aa54106 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -13,9 +13,12 @@
 #include <linux/gfp.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/types.h>
 
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 9dcfa194050e..f1d08814a73c 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/resource.h>
 #include <linux/types.h>
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 512309763d1f..a2c1662b6e81 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -36,6 +36,7 @@
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index ee1822ca01db..46adb4582fcc 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -24,6 +24,7 @@
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 
 #include "../pci.h"
 #include "pcie-rockchip.h"
diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 298036c3e7f9..22344cca167b 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include "../../pci.h"
 
-- 
2.34.1


