Return-Path: <linux-can+bounces-1462-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA82973DFF
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 19:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF05B1C24EF3
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 17:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833581922E3;
	Tue, 10 Sep 2024 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="pMIHsmk2"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2100.outbound.protection.outlook.com [40.107.21.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8C64A02;
	Tue, 10 Sep 2024 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987766; cv=fail; b=AEaXeRO0yZFbyaDhAYbYEnSZC5phFLU8UiLHjOZHZa2y4B32YKmS5UkhchrHBkubLfVVYQ4Tye53bU/5pEIuzlRSGEF/NTdGFg3vYS4TOUdExxkigRijGwVpumx9/NaGmQKBMzZLGWkK6sj2hxZt4kwoOnIe5cravs69AEEiB98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987766; c=relaxed/simple;
	bh=WDTbtMze1UwL7SoxKXScdmwcQJ+Jf1m04Sp8IR4LfQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JEkeMGw1z4CZ55vJZXziQ7eQfUfuH3XaEwnjin+Xy1k2P42Khp2ksrCGQLl3pnyEregLgiY1eV1pvs70WGXjIXt24Yp2vDLA+fvSWeET9P5qPsvLctrrpmnTODslc9KcJ7v54J0WoGN4GRE8qKh85qKZ0KwQb1266Y8CUaHXih0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=pMIHsmk2; arc=fail smtp.client-ip=40.107.21.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0k9OisQg15hXGsqL+AwUTGA4ZFVa8PXpwBDCJdm4MBARvjf7qumHmKhnPzTmuH0XJNvipT7mAziUM0/Xkrd2sRlpvzywTYo9fQbnnynkqi2nsW9Qqh+Cam3a9/DQoo7QoM3Q1et8x2Zrds0a24yQeMSVE6HGIgh2A7MSKdwmTqCNtChwd2DmBACH0MR+KnNuGU1dOy95kI6nSS3jLG9hzy9Xo1f0a5yefMXDlTDeJYBJ4zB51V3rKOJdjZ4afxMYpOsqrdOX9kvXCV/cCj8UlPib5cQrlq5o1azaEfKvLBeDTaNb3NcWpi2Ppgofm7XOQCW+P5wyVBPHd9go6uHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgGr9/YeP2rWznS+dSK0uIZFM5o4NWxH6S2S4dx/PrY=;
 b=sOBBwBIu3K8VVrbSr6GFSbk9sNVK34+fXyrvzLYyLjSGWJorLTl80jWSuHv9prtZfJsxefi399zkmDLUAXNIaS6QJIbOTU8pWu9mqLtGAQNuek5QVfrN+plYS500TyCMqowVWOmKymWQ6yb/XnmO6xmbmquzkHZwAA2SvklaEyyKPMvPKfjcaitoDgQuOvfjIxSwlYlto+h5tuE4G1L2B+KCx8qymiSjxO3tjTgFemJv01xhDQUZerVyVIxzjQL9fvohPhOxCCRADLy+Li2x8WuMnzz4njZW0TEcSQYH9szUJrE+/UB3GOzus1c8N3/883ucqWoGcwX7Vw3vKMKWTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=esd.eu smtp.mailfrom=esd.eu; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgGr9/YeP2rWznS+dSK0uIZFM5o4NWxH6S2S4dx/PrY=;
 b=pMIHsmk2+55ZKWUF6EoDIY7n/opZegpm67HXvefNCahPyFHACk/ejSDdBkhZ/B++bCVMCrLlpTrAzp8GDvxm5je17/BjffTMp93xYJW2fcj7UgIeDZdpf9rNwTu3MNSUA3oFZMhh1+5c2sAkYv8mQmADMQiKfOmdCZFsMhGoE/E=
Received: from AM0PR08CA0011.eurprd08.prod.outlook.com (2603:10a6:208:d2::24)
 by AM7PR03MB6149.eurprd03.prod.outlook.com (2603:10a6:20b:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 17:02:37 +0000
Received: from AMS0EPF000001A0.eurprd05.prod.outlook.com
 (2603:10a6:208:d2:cafe::fb) by AM0PR08CA0011.outlook.office365.com
 (2603:10a6:208:d2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Tue, 10 Sep 2024 17:02:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AMS0EPF000001A0.mail.protection.outlook.com (10.167.16.230) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024
 17:02:37 +0000
Received: from debby.esd.local (debby [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id DCF737C1278;
	Tue, 10 Sep 2024 19:02:36 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id C39622E4473; Tue, 10 Sep 2024 19:02:36 +0200 (CEST)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Frank Jungclaus <frank.jungclaus@esd.eu>,
	linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org
Subject: [PATCH] can: usb: Kconfig: Fix list of devices for esd_usb driver
Date: Tue, 10 Sep 2024 19:02:36 +0200
Message-Id: <20240910170236.2287637-1-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A0:EE_|AM7PR03MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 985a1b45-cfb2-49f2-b91c-08dcd1ba5f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0h2eUR3QkZSVTdobkF6SU5seDFMbTB0L0FCOGplMzRxS2MrVS9Zc1YvY2Vx?=
 =?utf-8?B?OHZ1c29yb2VEWVBUMFlRNDNXYWVNZTlVYVlGTFBPbjk1L1NhZGV3SWVTekdp?=
 =?utf-8?B?NC9RcXZac1Y5NjNxZWY5OEQvSVc4RmpjdFhra25QM3ZKR2FpTzYrdUdCZXls?=
 =?utf-8?B?YWRqaHltU2V0aENTMWo5YnV6eENtWlpNZHkxeE80RGd5c1oxT1Frc3kxSmFS?=
 =?utf-8?B?Ym5JWmlzazYwTUsxZlpyZ0t6S1J2UzQ5Vy9VM0QwYXFaM0svKzljcG5VWmZY?=
 =?utf-8?B?VkVGelo3M3dmaWFKQS9tNTd4R3M4Tm1Xc3d6dDFiQ2R5SnIrcGlBRWNEeHk0?=
 =?utf-8?B?OE5LSWRrNEREL1pYZ2lEamZkRFo3ZXh3dHppcDJXdmpkRThRbUhKa1R3a0dw?=
 =?utf-8?B?d214YXp0SkdSQitPYWMrR0VCS29nSkl6YmFHYmZ4R0pMK01DRFdGRVFHRTdw?=
 =?utf-8?B?TEZaZTVzL2M5U3VaM3B2WVlCcndxMUMrVVB0NEdsTzFkU3luWVZDeGx6N2NE?=
 =?utf-8?B?YlZuOGlwTE1YZ3NWV2x6OEU0LzJrTHI5OGxNZ0IzUTNXYUZoakNOWGhIT2p6?=
 =?utf-8?B?akU2dTlHNU9wNWRDTEZUNEpNSHIwcWdzNWR3aitEVVhQUG9aUXVTYlQ0WnBY?=
 =?utf-8?B?MkIxcUlGbUIvcEQySkVNS3UxblF4VWJlWGUvaERpWlM5d2FZSzhmYTZ2RTVN?=
 =?utf-8?B?WjBMWVFVTXpCQ01QOVN3RnVFMjdtaERDRWY4WGsxVmUzQzlPQzhDWWdTMUxL?=
 =?utf-8?B?aUJXNDhINTBNeVZ6M2Jyay9Zc1JaWTZJS01ZSUllWkVXL3ArRGJiS0xuV2ow?=
 =?utf-8?B?eERCMjRONmY1UlV1RXpGc0JXa1JVMHJscnRqOUZqVVAyY08yYUNqbVM3NHk0?=
 =?utf-8?B?ZW5DV0FtYUJLaHRaL0c5dWZRMVlkUG5kUGFlUVFja1UxQklEU1d2cldVLzBW?=
 =?utf-8?B?Z1AvajdUcXRHMHY1VzBzMit2VWo0ZEowNFBmWjNDMTJLczNoYjJ0bDNjOThY?=
 =?utf-8?B?OTZhUHFkSDBRejd6V1BLcHp2Q2pEdnNmQUQ2eWV5N2djSjZQdEFaaHROK2Rz?=
 =?utf-8?B?enl3c2h6aUd1QldyZnJKMEZGTUtWbEF4OWVGM0JxVlJ2RmJYakNVOGJaNTl0?=
 =?utf-8?B?M294eDBRNFFsTjVITkpoaXI1bzlReDhiMC9EZk4ydzVDR1dQZGN5dmdMbWs1?=
 =?utf-8?B?MENJR0J6K0dsd2w1TVBpOFFxTld6RUptb04zV05UUU5sN2VpMk9Vb29MRnVa?=
 =?utf-8?B?SnFVaHdaUEpOb0Z4YUt6Z2NqbWRvczV0TjUxNGlBRjRzeXJyVTNXSExKZXgr?=
 =?utf-8?B?TkowRDg3bGF2b2RiVU52V0FVVmQwc0FGVjd6R1grZkw2YldDQ2V4UXp2RTY1?=
 =?utf-8?B?QnROK3BRbi9HaUgzSUErSDRCRGdDVHhwdDVzOWJkNFFJWVFPQTlNTmduUzVZ?=
 =?utf-8?B?UjVSOGg1aDFjQlRMNUIzR2VudFZ3eEdVT1BVRW9EOUt5QzlEUXQ0emEwYjFj?=
 =?utf-8?B?cExYMjdycmYvNTgwUmFEd3pCSkY5d0ExUDV4SzBUdGFLYTQxUmsraTNwcGVp?=
 =?utf-8?B?QnQ1TGtnVVNCeGk5SE9IUWVwTS9pbW00dG1iVDY0TnVRb1RvU2RnYmdEYm44?=
 =?utf-8?B?c1ErRDQxOWk1ME9WaXJBTDc3Y3g5ZzRtdnk4eEloRlNQUlRzRjRIWmN5UUU3?=
 =?utf-8?B?M3VrY2JHeTRGck9BdVRmVHdoL0ZrQzVhellhQkxHSklRQ2tQSE5qVzVnb2tk?=
 =?utf-8?B?UGJtVGxzdHI5ZkpObWlVQ3pQMFNoY0N1UXRDeEc2YmZBbWVNRGNhdk5ucGlO?=
 =?utf-8?B?R1Y0SUx0VWlLWEdUbDBnOFpWb0ZUWDlNY2dlZ1pxYmIvQmRJRFFiMGJUOGFM?=
 =?utf-8?Q?JFpo39c5wIFWI?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 17:02:37.1962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 985a1b45-cfb2-49f2-b91c-08dcd1ba5f53
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6149

The CAN-USB/3-FD was missing on the list of supported devices.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/usb/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 3e1fba12c0c3..9dae0c71a2e1 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -17,11 +17,12 @@ config CAN_EMS_USB
 config CAN_ESD_USB
 	tristate "esd electronics gmbh CAN/USB interfaces"
 	help
-	  This driver adds supports for several CAN/USB interfaces
+	  This driver adds support for several CAN/USB interfaces
 	  from esd electronics gmbh (https://www.esd.eu).
 
 	  The drivers supports the following devices:
 	    - esd CAN-USB/2
+	    - esd CAN-USB/3-FD
 	    - esd CAN-USB/Micro
 
 	  To compile this driver as a module, choose M here: the module

base-commit: d7caa9016063ab55065468e49ae0517e0d08358a
prerequisite-patch-id: 3d2c55f88f01d775c3f9e410cb2cdf6d0ed16670
-- 
2.34.1


