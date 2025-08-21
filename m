Return-Path: <linux-can+bounces-4287-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1EFB2FD20
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 16:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5311D233DA
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 14:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96912DF6FD;
	Thu, 21 Aug 2025 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="pwYWAjsn"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023117.outbound.protection.outlook.com [52.101.72.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129992857EC;
	Thu, 21 Aug 2025 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786872; cv=fail; b=UiaaN+NFlCyqDJCG9MDOJ37UacwlORICogPw9AWxiKxb1vEVi8toDpxpl9/ec1/Oz76GM7O+KHjOb6pqY0mjvfo7Ixe9O77trO0EkVsWta+OovPdY8RB2ZRawFG5N0cdbVoreAAlE6p+PkuK/YT+hOH8k/aOY7kO10qlr70AbRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786872; c=relaxed/simple;
	bh=COe7rj3kwMtyOnAZ7713zbdvnYm0Hz99NHxyY8Vzvh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fxLqD4J44k/JANc1MAjfrrCj28vFuipkKOFX0RlRIOqoT5DsbyOkZyxZ+tZA81ZMMVScyY2/h9j3sZkZgHRIcx9bkQpTPzkjPO+GOy/aTOt3smmexhnhbCQPEJkN2cV5LLLi/wOn4mgPJiUKUZB9o0TBs2eNQMUt1l9J/j54XFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=pwYWAjsn; arc=fail smtp.client-ip=52.101.72.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQfGZ5EJ+ojpHHXEF2Qe7zK5ZJF3K15Cg/lmCPj7svjhsaN1Kjk0rxLl7hYwxqfYfSNS8uGYeb7PQn61e2QUAp9ZrfCnz7WEX/rph5Xe0sLDgiFhOKrWQ/H54b7ndQGGkqsNmdFsURW627z4Cr8m7d6gBdY5DkYr3emPoJi08X/tpVOhE1js1TB3UqLTA8HDQajb4l1VOF0ayuvpbCWBRhiE51teG7UYnXo4iLP/Kurou5VolsnrxUvxaT0BRkioDDQ1nW+0WLmfOgSKTQjMmRlhwpBBYMMb4KlxLb8irK7+oNivtxIaQ6cNzZvyaaKiAk3DjRwxzUIzqKVlqiSJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXuiPnCfaetb/zItQESXRiJnBvEUZ1E6QZwmNMkEAtw=;
 b=B7B4Ab+eC65hnf23r0l8GyfUqj5I1+4Eps/PKSwE5U0DIHhnzS1dQKmjSJw/Ajcnxsy/ifnTYxRdjSppdYDfCi0bbDS3xeSom+xwnu9FiZKapu33qopgxiSdpxcrAVOB5+cz6PLDI1w2tLiK52qDLVvjiu1pZCFe+vxXioN4hzq5WgEpmhtgt0dYwaI2M2iCfkxZdiRCAXZpjQK9Pl+ivZxxEv1KlNH/1oXiX3g0/6vDwsPL0W2KHpSQeHc3P/i5MJvhzkLSo0rSZ5zov6Ubu7vSRLxEie/95+EF83VsRZS/1xFjfhjo8kdu3Eu4Cf3dMIbUOD4Xv9jefx8Jbk4Aew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXuiPnCfaetb/zItQESXRiJnBvEUZ1E6QZwmNMkEAtw=;
 b=pwYWAjsnkElbIBnBGtBnaMOOBPdU/0b5jgPsvXSIIsfBmPoUewPpXftvz0QuISdGEjhv9ohHUxpekX0EoUkORcjVXY8D1/XBVwr+p800XlMCuTbdPhiNoHw1+abaUo8gUL7gwEl64Er1w/vY9f6kzPCmz7PqKBhcWT2QqtE1aLE=
Received: from DU6P191CA0014.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::15)
 by GV1PR03MB10313.eurprd03.prod.outlook.com (2603:10a6:150:163::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 14:34:23 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::58) by DU6P191CA0014.outlook.office365.com
 (2603:10a6:10:540::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 14:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server id 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 14:34:22
 +0000
Received: from debby.esd.local (debby [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 793F67C162E;
	Thu, 21 Aug 2025 16:34:22 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 63D4F2EA436; Thu, 21 Aug 2025 16:34:22 +0200 (CEST)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Frank Jungclaus <frank.jungclaus@esd.eu>,
	linux-can@vger.kernel.org,
	socketcan@esd.eu
Cc: Simon Horman <horms@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org
Subject: [PATCH v2 0/5] can: esd_usb: Fixes and improvements
Date: Thu, 21 Aug 2025 16:34:17 +0200
Message-Id: <20250821143422.3567029-1-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9D:EE_|GV1PR03MB10313:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e859ce-5a1c-435b-b4aa-08dde0bfd25e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|19092799006|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEd1L1h2RVZHaXpkY203VnN4eWhlN1hvK0hGQnFVVE5lVTI3dysyK2FQREVw?=
 =?utf-8?B?aUFZY3I2c0FlSjcwZVBtai9vTVZoUVhubXdhOGtRei95emhhS0dYZFBXZnM4?=
 =?utf-8?B?R0VwTTZnTmlqdkkwdGZUR2pERjhOalFpZUNybE5FOUdkcFp4a0h5WEVER2Ft?=
 =?utf-8?B?blJpVFdPbEJmZW42cFN4WlozdVhUeG1rdk5ibEh2UlFMamtrWVRwMHJzcVdD?=
 =?utf-8?B?WlliNWJ5WERpcVc1dk0rWFVvckttODljYUs5NmVDOFlIZElkL1BOVWZxNE1U?=
 =?utf-8?B?UTluNHpnZHJIWnNEQStwSG5aNXV6WTZyRnd5VVNwODVveGFBc2V4ZndBYnhY?=
 =?utf-8?B?MVc5djJUeEZuUmF4WCtyZEpZdHlTS3ZEZk8zR253OExKNEpIdEdkUjRoZVJo?=
 =?utf-8?B?YW9qQ2hpZkRZL2pZZjUwQ21UUmJnWFhZYVl3ZEd1ekJIZnFYY1lrWFpvTnlI?=
 =?utf-8?B?VG5YVVNvODllcVlib2RLeTZqcVAxVHgvTms4U1p1WG0xalZvVFd3VmhhSUlJ?=
 =?utf-8?B?YVBrZG9JSy9QWXRCUGdWYi9QZmZjaGQ5T3l6V2VuS0duMkxtZWU0bmVJUjRv?=
 =?utf-8?B?eU5mQ0FqTDRoUWQzSlpOdTJwNUMrOXMwdGhGbGJ4SWNUSmlBV29FWHEvVngw?=
 =?utf-8?B?T3FLNkNGclZ2MFNRcEdMRVNFRlZxR0NHcU9PSzlwWEVURFVzZ0xOQmdYQUhu?=
 =?utf-8?B?NUczaHQ4dVhKVmd4Q1haV0hESGxnYU4vb3YzYjMwZU5oU1N0NDNFUFlVS3lD?=
 =?utf-8?B?a2xvbkJFTkpNc1BaTFI4Wm9FWVBsV1FaRFQxVm9XY1g0YUFtdXd0aTdBSWxz?=
 =?utf-8?B?UVNEY0JWb0FYRzVoOGRLVHhBc3U4YUdHR2lDVkE2NTBtU3hoSms1WHBjaWNS?=
 =?utf-8?B?QUlwTHh2Z3JxaVJhMFFtRm5wczlEQ2lERmFXanFVQitrYW9OV0s4RmJEWEwy?=
 =?utf-8?B?YnJPV1RyQUV1YVllMmh2VURRQm12Qis1S0syOUJnOW5mejVIOHhNVDM1MG1v?=
 =?utf-8?B?MGVzaDNRQk9ycldaaldJcEdQcnpPVjgwUWNOTVU0YTRtaFBSN25SeklxZjVW?=
 =?utf-8?B?ZFYwQnV2U1pSeWxCa1Y1d3U4WXN0cG5OblRRR3I1ZllCMnJ3c2gzbWVycE9T?=
 =?utf-8?B?bE5ZeDgwYUJHN2NNUk5BbnFMakhXK2ZsTk5vOGN4MFQ2dTAwMEtwRDUvVzRh?=
 =?utf-8?B?dE0zRm4vVW9OaUxUTm1VVDU2cU1SQzdFaWl1aytmNFFEUzY0RzQ0ZThiYmdt?=
 =?utf-8?B?emxTQm1tSW91bEI1TUxyNHY2Vk5CeTFjOWxjQnhoMjh1TEJlcVZ5WGY0bGQz?=
 =?utf-8?B?WllYNW1NOGpoVnJNVkdRTkR4WmRXOVdmQVBnV2s1cWg1WFBCYll0ak9LZTU0?=
 =?utf-8?B?TDZzYXZEOU0xWG1XZjNGZFhRZ01nd09pb05MWDZZemJFQXNHWlZzaHhWN2px?=
 =?utf-8?B?NlVvVGh3NTN2RTBySlg5RGFnOE5oVjA1bnlLZEJWQmFWSmJZN01XaXZCVTNR?=
 =?utf-8?B?dUY0QWsxWnhvTFNrV21FU2Myelg3WDRheFFUSUxLa2dzNFl0OEdxRFZSK0Z2?=
 =?utf-8?B?R0dSWWgyN1d6RE9WZXQ1eHkvTlNaYTFLNFFQVDB3bkRJdVZ3RE51TFJUL2lu?=
 =?utf-8?B?TEVnOE5NdVlaOW5HUFVESnM5S0FCUnV2UlIyejQ2REdFTkMwK2laSjBncmtG?=
 =?utf-8?B?dHJCdlE5TmtoQytWeUV0cmJMR3l6UURqQVZjUUd3VHU1dTg0SGw1ZW54MmZl?=
 =?utf-8?B?bkQ5Qm1KL3g2dENUVWU5SE9IVGNGREMyRVRITlV6SnY0cGw0Q2tNb3lQNXhY?=
 =?utf-8?B?d0gxWUdDNC8vZGU4YjZHY040T2gwVFY1ZjR5ZXY0Y05UcXdxcFY3WmlmVlEy?=
 =?utf-8?B?K1ZJdSs1bmpjeTFjZ2lrcGlscEt3Z0VJT2t3MUhMQnBpQzBvbVdlRG5nYmR0?=
 =?utf-8?B?cnh5cmw1bXM1SFRVaG5odHpGcHlXY2RMeE1vYzNQc29mN2JtdEtYV1o4SFMz?=
 =?utf-8?B?d2xDRHFyR3VWR3RSV3RlUjd4aStJR0JJSVJmMVZuenRHeVArYXJucVorUkJP?=
 =?utf-8?Q?MomLf3?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(36860700013)(376014)(19092799006)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 14:34:22.8137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e859ce-5a1c-435b-b4aa-08dde0bfd25e
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10313

The first patch fixes a condition where the esd_usb CAN driver
may not detect connected CAN-USB devices correctly after a
reboot. This patch was already presented on the list before
starting this series and changes due to that feedback are
integrated.

References:
https://lore.kernel.org/linux-can/d7fd564775351ea8a60a6ada83a0368a99ea6b19.camel@esd.eu/

The second patch fixes situations where the the handling of TX
context objects for each sent CAN frame could go out of sync
with the acknowledged or erroneous TX jobs and then lose free
TX context objects. This could lead to the driver incapable of
sending frames.

The third patch adds TX FIFO watermark to eliminate occasional
error messages and significantly reduce the number of calls to
netif_start_queue() and netif_stop_queue().

The forth patch makes some error messages also print the error
code to achieve a higher significance. Removes also a duplicate
message and makes the register / unregister messages symmetric.

The fifth patch avoids emitting any error messages during the 
disconnect of CAN-USB devices or the driver unload.

Previous versions:
 v1: https://lore.kernel.org/linux-can/20250811210611.3233202-1-stefan.maetje@esd.eu/

Changes in v2:
  - Withdraw "can: esd_usb: Fix possible calls to kfree() with NULL".
  - Reworked now first patch:
    - Functions esd_usb_req_version() and esd_usb_recv_version()
      now allocate their own transfer buffers.
    - Check whether the announced message size fits into received
      data block.
  - Second patch: Added a Fixes tag
  - Third patch: Added a Fixes tag
  - Forth patch:
    - Convert all occurrences of error status prints to use
      "ERR_PTR(err)" instead of printing the decimal value
      of "err".
    - Rename retval to err in esd_usb_read_bulk_callback() to
      make the naming of error status variables consistent
      with all other functions.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
Stefan Mätje (5):
  can: esd_usb: Fix not detecting version reply in probe routine
  can: esd_usb: Fix handling of TX context objects
  can: esd_usb: Add watermark handling for TX jobs
  can: esd_usb: Rework display of error messages
  can: esd_usb: Avoid errors triggered from USB disconnect

 drivers/net/can/usb/esd_usb.c | 238 ++++++++++++++++++++++++----------
 1 file changed, 171 insertions(+), 67 deletions(-)


base-commit: 0e6639c8505d70e821bc27f951a0ff6303f10d4d
-- 
2.34.1


