Return-Path: <linux-can+bounces-6551-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B9/FqRoj2lHQwEAu9opvQ
	(envelope-from <linux-can+bounces-6551-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 13 Feb 2026 19:08:36 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B71A138D18
	for <lists+linux-can@lfdr.de>; Fri, 13 Feb 2026 19:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EDE74300BE88
	for <lists+linux-can@lfdr.de>; Fri, 13 Feb 2026 18:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046EC2727FC;
	Fri, 13 Feb 2026 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sCAyiMF3"
X-Original-To: linux-can@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A85273F9;
	Fri, 13 Feb 2026 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771006110; cv=fail; b=BuPwl6UIKfaScYCIbXwHgDekObIV9hi/pYvogNs1MmYqI2j0ZpNm79dC3QLY+az+GkdGQzY4OyosZl7viWMpHO0SQjTijvrsgyV7wgAQpC3xgvWtGE/aYUtyY4+nKoRSSKJVHcA4vfMVyO4OFz0NVu6WWQtuj1rKhnSDDr767KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771006110; c=relaxed/simple;
	bh=ck1w/qQpddkPNSvdlTsFv5B4XvMwTwnA9jGrQVjjxG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=OJyWv9gBx2mKPhr+UT/z/9NOP9BHTVjC4E7fj9duE8jRbPQbI3mLopFFOBdpepI2K/Q+RzMHtxDfsI4z+TGy78xo/qbcSCPb2h8+6F8H1Ie0E4+nV2X/iSMtl9NXFi86wvOU/ucoTyPMsqhL3YLxHNRGO4hPrXt29Z87avBJkp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sCAyiMF3; arc=fail smtp.client-ip=52.101.85.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7dWEzAFG53rt/TiTqb9cEeJoF6hte5lt2p3LQN2JUUD1KMsWML8ByucBaVvG6VAWWtSHqK8YQNlfkEssOOlVRuaOsKqN2Aq1rs9BVfVm+YbHEW6skGZQHA3fDHzkntqrNoaOerbieJkVDUrDF7uSFa3mR+rReJVrSXb/Ef3ft2N/N/aFgdmDKaSQJo7LGzKDUCtvF66CXYCWCrpbSeoVvjcCX9mSpqi8BTnVjYKO5TlLo7S12uSYOsVxuwKvMxT/5ySgEYc/UeoXMhLZYyirG4p5lcrpDBOPKqz4sF9AKvNsjz+kgol1zaaLaHGJsjHLOLrWueVhDywyVxZ6hnOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfUFlNtf3ZgN/OLB2fdgDerh+IkcI7gso3NChdzr83c=;
 b=msITAGZThviD1UTCVrzCy48t40DnYPp7bcxus3KovI8GWh/F8oI3nPcFJrQuvQEQtblR9TMH4JW93JC98L09L7UDnVZbDke15DK31Z3JjvpSDm28Ft4C+6IHTReOtTqmU4Lhp764RVWtfV7lt42mlTiiD9UAiK0oMJdZxS3MPt4D0flSXi92muiUN2fmB4hVRlxyzmL03ZWcZ88wc2XEQlcS9Px+wuBTAfICv01Y05qXFleFPuW14NnB+Rf8KGEAMwquqpmeQWETUhcElCNNGsUJL6aYlQecf3RgzQ08/qwhzvXBKEIqpuCRkoPsRGXb5CFL4vqtEVLhAasjg6GtGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfUFlNtf3ZgN/OLB2fdgDerh+IkcI7gso3NChdzr83c=;
 b=sCAyiMF3f1/rTASIBjYnT/swU8yVGxnYgrbFjRP9DWgFpNDKWAr3Klcdh4PysFlX6fjpK8MR8NbkKlnDx3VKF4UcosknQq9mzb9gExEw4dtrr1mwu+t2pqyLlANBLMcycNUF6cZni1BghuzCPoGePC2PdUI8mnXUN+aIG9VF6YE=
Received: from PH7PR17CA0019.namprd17.prod.outlook.com (2603:10b6:510:324::16)
 by PH0PR10MB997642.namprd10.prod.outlook.com (2603:10b6:510:386::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Fri, 13 Feb
 2026 18:08:27 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::a6) by PH7PR17CA0019.outlook.office365.com
 (2603:10b6:510:324::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.13 via Frontend Transport; Fri,
 13 Feb 2026 18:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 18:08:27 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 12:08:26 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 12:08:26 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Feb 2026 12:08:26 -0600
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61DI8QYJ1177577;
	Fri, 13 Feb 2026 12:08:26 -0600
From: Kendall Willis <k-willis@ti.com>
Date: Fri, 13 Feb 2026 12:08:19 -0600
Subject: [PATCH] can: m_can: set out-of-band wakeup if wakeup pinctrl
 exists
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260213-mcan-out-of-band-v1-1-af68d4c570b3@ti.com>
X-B4-Tracking: v=1; b=H4sIAJNoj2kC/x2MQQqAIBAAvxJ7bkGNPPSV6KC51h7S0IpA/HvSZ
 WAOMwUyJaYMU1cg0cOZY2gi+w7W3YSNkF1zUEJpoeSAx2oCxvvC6NGa4BpICT16Yf0ILTsTeX7
 /5bzU+gEloi8CYgAAAA==
X-Change-ID: 20260213-mcan-out-of-band-bae2065f0bf5
To: Markus Schneider-Pargmann <msp@baylibre.com>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
CC: <sebin.francis@ti.com>, <d-gole@ti.com>, <vishalm@ti.com>,
	<linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Kendall Willis
	<k-willis@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771006106; l=1339;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=ck1w/qQpddkPNSvdlTsFv5B4XvMwTwnA9jGrQVjjxG0=;
 b=+UsuZUFSPHgeZx+Uqp4RwKdgrx0RFZJ9vAnWj1Nsgkz2/4Z4zfh0n2DCVEQWr7Z1pdr2SZvsA
 cYz0I+Z5eaIBopv4nQdJ8Vo799vQrxuUDx0WZqmrDb/u3a+EwowfNAa
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|PH0PR10MB997642:EE_
X-MS-Office365-Filtering-Correlation-Id: ef46c845-fdfe-4f96-f372-08de6b2ae320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0ppZjl1cHl3ZHFJNk5NRnNXb09sRUF0Tm5YQ294WWxMdy9YNmt1WmpVbGxQ?=
 =?utf-8?B?WFpLYmRlMHFpVERoZzdLWkdEZzNuQXQ2VHFLZ1NyOXh5L3M3R1J3bVRSTWFn?=
 =?utf-8?B?R3A1enMwekU2c3lZVlNvbnhuZTJCajNHbzgxcVNJbEwvOTJ6akN6NjFHWmdJ?=
 =?utf-8?B?dG4waWVQWlBTWDYwSlMvdDRnRzg2cjNUcm5rTUpGT1lGRklJd1c1QUIwS25E?=
 =?utf-8?B?SnZtN0VYdW9teTRpT29ONEswV2lsRTdWYlNZSGtORC9TdWN4SUIzYW9ONXJR?=
 =?utf-8?B?SjhJampqdXlnRGcwZno3MXc3MnhqQmZNMHgwVjdsWjJIQVQ4alJjZzRGVXFt?=
 =?utf-8?B?dVcvN1dKYkcrMStOWTFIRS9zTmVzUFYyblpodHVMZitGS1RJYTFtZXJZYTBt?=
 =?utf-8?B?NDB5VFdPRjNYMTBTTXVJYTZoQUZyMU9mOUNOS0lWYW5uUnMyaDEyREJMeDZY?=
 =?utf-8?B?RW9DalhNVVJvREhFdlpvcGRsSlBTQ1l2YVQxSlNMMDZmbnhXSTVzUXpwZGJH?=
 =?utf-8?B?SnlvTE1RdkhVMVE4dFV5TTVVN3VuY2ZFTFNSQTJaUG1RKzdWaGduYjFNSGVn?=
 =?utf-8?B?Tmh4OS9QdUlqOU1IcE85bmYrTVNxU095STVSdVhKNWdwWVlkSnFNb3gzTFgy?=
 =?utf-8?B?dVlpN2IvZXNCVHJTQ2l2TDRmTmNqUllqMUZwR2hRM0I3c1R3bzVmVFdtaGM0?=
 =?utf-8?B?a0hza2FQOTBLNVI4aDJ4UFM4akZHMjNCVHRLelA5ZGpLZThTYWxHMFRsWFpI?=
 =?utf-8?B?M0RQSmMyMmp2Y2FndjZjK05LSE4vSE9qUHY2cENWTCtGMkVDSVpJUm40M25Q?=
 =?utf-8?B?NUFSVlNYMnBCaGM4VFBVYTRZOWJhd0ttN01sWDJqUDVCOUEzYVZZM3lJNWk5?=
 =?utf-8?B?OWNCQ3N2MlJMaGFscklmUkJKdElMY0FmTVd4MUZiVFRDTVlVbVg3L3JZMFJT?=
 =?utf-8?B?ZUVYRmphY3lTbytYQzNPWXhVQlZ2cjFmajM5Rmhib01XTzBPY0c4Qnk0VjdF?=
 =?utf-8?B?eUxmMkxRaXVFajEvSmROcS9IMzBTWWVJejlJQ2E1eEwwZThadjRuUHZnQzlp?=
 =?utf-8?B?Mm9qYzlGREh5L0tPOERHRXM2RDlDQktyZmR4Ti9HdVdpNE1xT2ZnenJndk5s?=
 =?utf-8?B?bkdzZVhpZGtPSERqaWpwRThKNnhNaVdkQjFNRUo2Rm5ORVU3aUwvR1h2eml0?=
 =?utf-8?B?SC9oWXFub29hUDcySXNmcWNRVW8rRkRUMG5BdWwxUXExTEU1WGFuN1U3T0da?=
 =?utf-8?B?L0xWWWFOZjNZYUcwVkZhd1JEQUVpSlMrazJoQmFERm5Ld1g3WVI5RHdubURC?=
 =?utf-8?B?OEwrYitvbDZPcFBRay9PM0hEdElEVy81NUt3OWEyRUFHZEZIck1iM2NjZXNw?=
 =?utf-8?B?MXBVSDI4SFF2ODlXMEN5Wm1wMWdmdWZROTJnOXA4Q0lsejEzRjdva0lPb0E4?=
 =?utf-8?B?SnBhQ3J3Y1RvSlIyU3ZUWmVIdjNJWnpmNXJUeDF4c2YwZUgxL3pZbHBIdXRq?=
 =?utf-8?B?aU1iZnVwY3pocGF0bUgyQnBSZnZCQkEzNENHcnpoUHFEU2xEbkI1MDk4UGdH?=
 =?utf-8?B?ZVR0UDUzYzlmRC9GZWNiSkR6WGNJaUdlb0kvbVg4VEk5a3RrVml3R2NpVml5?=
 =?utf-8?B?RDIrRU94aHVtVUFBcFYzVzYyYnRlVStobEVpNmNqbWovR1dDMzNhNmE4Tkxl?=
 =?utf-8?B?SklLMm1rRHl4QVpQSDlZNUVtQkhVdmV3eWxoWFpEQ2w1ZXRBaFFjL2xDemlG?=
 =?utf-8?B?akc5SlRVbE5HczNIOFkxUzNyVEFyOUZsa1VXREROOE5seHZORjFSNXExWHhV?=
 =?utf-8?B?Q2hhRExJcGVleFdKMGJBOE1WaTBmWCtwSjhlbVFJVlZ3QXRpOTRXOFJXNUZY?=
 =?utf-8?B?eWc5NVAzeHA0UkpCM3lDNG5WRmZoN0hqZDRNY2hTY25KSEhDNEZxckx6Wmd2?=
 =?utf-8?B?U0xJdWZkbFY5OWt1SzY1ZDZXeFRuN3BKbmxFQmtmWlk4bDF3WEltNklhaFRE?=
 =?utf-8?B?L2p0R0NaUEVmN25FMEJEdXNWQkNCN2EyZVZOZk1uTHRndFNzYkl2MkQ0bDlF?=
 =?utf-8?B?OVFEUlBaWG5KbEoycms0UWF1TktwMHg3R0pDVDc0bjMvQ0t3d3g3RGtuS09z?=
 =?utf-8?B?L1ZvaE5TZ0IzOExWcUtSSW9sVGFzRUtic1QxY25ZYU91WCtpb25JRU9HYzF4?=
 =?utf-8?B?R2RaWlRKV1l3V3QwUkVGM3R6cVB4SVlacDN5NFZNS3BhSWFQbXpzS2lqbVlj?=
 =?utf-8?B?ZlZiRVkrMjdhbXFPUUduUjlaRzd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1hTCMqbhVi39KIm7ouq0PVHLEYipYf88qg3LX3zqccSPPP2sa747mdTMO5sKhEDRHPDlLWUTzI00GMacsq3y1qjOWnSgcXuE3efU9FvovbR0u5J/X9Af8iYtCnjGu/8X3TdhjTWt1zmblcBy4XEEIQvy0Qwj3/SsGCmLSXobR0ZEnFeQ6Sq8N4o6A0sJv9tVr2hP0zWf6XGjzK9Yv3YUOKCGcGpHY3/lGOxXTWPCHjqmX6kTi+Evmg0HDNW9b3TOHP2Q4bsnPcVVyrtpoxs8Iyco6OCGGsA16oL7Gq5OlyjjXY9lFVyuT3K718wQR8MhLEB70byST2+X1PyXkMfDIT+3jkmzPMYXWkwuDUpk4IUsN+rOhEgyeoTRKapYmmvgm4KLE4VL26Ijj1DTrRsYmhuKwkP2ly3HmwbNcd4jIboPY3eRuOxiBEfQhq62rMYH
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 18:08:27.5794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef46c845-fdfe-4f96-f372-08de6b2ae320
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997642
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:mid,ti.com:dkim,ti.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[k-willis@ti.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6551-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[ti.com:+]
X-Rspamd-Queue-Id: 7B71A138D18
X-Rspamd-Action: no action

In TI AM62X, AM62A, and AM62P SoCs, the m_can pins can act as a wakeup
source in the deepest low power states. However, the m_can pins are a part
of the MCU domain which is OFF in deeper low power states. Since the m_can
pins continue to be ON even if the MCU domain is turned off, set
out-of-band wakeup for CAN device if `wakeup` pinctrl state exists and
device may wakeup.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
Tested on CAN IO wakeup from DeepSleep low power mode on AM62P EVM.
---
 drivers/net/can/m_can/m_can.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index eb856547ae7df27a844b236a0c1d4498cbb8b60f..8b277f5e208ffa634439b9ea8495ed56f12cfccb 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2622,7 +2622,9 @@ int m_can_class_suspend(struct device *dev)
 		cdev->can.state = CAN_STATE_SLEEPING;
 	}
 
-	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
+	if (m_can_class_wakeup_pinctrl_enabled(cdev))
+		device_set_out_band_wakeup(dev);
+	else
 		pinctrl_pm_select_sleep_state(dev);
 
 	return ret;

---
base-commit: af98e93c5c39e6d0b87b42f0a32dd3066f795718
change-id: 20260213-mcan-out-of-band-bae2065f0bf5

Best regards,
-- 
Kendall Willis <k-willis@ti.com>


