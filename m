Return-Path: <linux-can+bounces-346-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C24F0860EAB
	for <lists+linux-can@lfdr.de>; Fri, 23 Feb 2024 10:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37841B20E7B
	for <lists+linux-can@lfdr.de>; Fri, 23 Feb 2024 09:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFAF58AC3;
	Fri, 23 Feb 2024 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="Jkn315AT"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2106.outbound.protection.outlook.com [40.107.247.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244641F93F
	for <linux-can@vger.kernel.org>; Fri, 23 Feb 2024 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681963; cv=fail; b=ZrQbYu1sq0q3lnh+wAXOONJo6TClJjXjg3mtbRPSmzc7mZryWtrjV9CkVzN8+uEwyPMgeXqR5AYVo1rBttrk6UwgYiGHdNct69Kb0dQi3bFYwmj7aY53vaxV2uXFzV409/WAab63xqBgQG3Xo0l1r6d9lI1YpVDZwJYhbjAwtIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681963; c=relaxed/simple;
	bh=tojrwA4s7G8y60cgyJBiwhX/Vn0H6UbZLpsiGvGisk4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eOrqexbaunXSU9dZYq5rpUBNI3th+aB9q0QTao87Gf82K0s6ivfo+03bLwkboRDuSkh1CHr5t7lYgK+Nck+D36zStK25/yGHVO5LYYol8rofA93pBb3GzJ306X14BqCVZL8d0ulDcwgyB6OC1IC23haTa0DfkAIpiZCF95zC4mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=Jkn315AT; arc=fail smtp.client-ip=40.107.247.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oje9QC/PWM+favxN2Z6TgqI+1WLuImhzJWfiYn2ILqsjuasp+3KxgvhW8Si7Fnwu1oNlRdon2k3NRHVMabmcAVGv243pJbHT2Yy0QxTzTuk2s9Ettgf30udsYUqRKe5s32jAy5VDFF+mgsdGnKOTxEnTtpeuyXEMX94qcJxfkqYF5phhVBDyg1MvIBzqHO0P/y821z9ceiE3o+1Be7WTdqDPtEVUCK/fsauDDa1BVnLhMNHcW+CZnD7y0+74akgYlM3adR8L0kN7Ia8upHImICtMIo/cQHHzL2f4p82aUt+TqWmomy4JMjL0f3yZSLitgW4/y4a7cZ6RTN3yhdzfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSxZIGXsYxo8jqCRWomhR8QKd8xaQ+mnDBNnUGgh2tQ=;
 b=VDVshztmxhctWMbow6Xf3fjcLYWWH2A7uODCO2w8jNpl8+vPu0K2DmGRNRx/gJsYg0M5cuQTsSxuM4TvSVUwP9FEVui9sjd8k1XXk1jq6vUMaNJIjgLorvE48Dvb2/+T3U5bVCwScbs3T3WvC+rdVV5Ixy4/0JQ7uC62vaGPEG7Y+EE3ivAc2A4+encYw13DTYiDBzwNtZ09aN+441GPYpXv1WITXFFM/xrTRFO9Yidu8SZNSr8+XFCa5hN2cx3g6d3KJPj4D9IPkd8L8imbbELPf8qA9vqFPO6LJf//kPGK4N2iqx7GCLx01lMwP7qFrQpyO1oyyyTqPUZ50aM+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSxZIGXsYxo8jqCRWomhR8QKd8xaQ+mnDBNnUGgh2tQ=;
 b=Jkn315ATzKH1LR+ArMKtYh5PklnwTCoq85vdd3wHLGerQFD/5zZKOQUMiNJK68xLeXtL8PzPqPLxWMsQjCPDCAo4yFL0uGZZnh9WHdmI/SYunftscpf97ISabPsxonujQ8sv2p5f6bkN6cXD5YcaSVFY3cyX4fLJ4/Lmf2JoTtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM0P193MB0532.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:169::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 09:52:37 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::8236:dccd:3358:876]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::8236:dccd:3358:876%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 09:52:37 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH] can: kvaser_usb: Add support for Leaf v3
Date: Fri, 23 Feb 2024 10:52:17 +0100
Message-ID: <20240223095217.43783-1-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0094.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::35) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM0P193MB0532:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d7cf1f-b87c-4d58-a174-08dc34552a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jtO4CYZpp54xXRlwIakB3NRdq4Xi34PyLTCDMO8S8QPPu0RItLp895cKypzyA1cnv6vcpxbCrTegkBzim0vpcdxnrPWuWcprklLRla72im3UAXPlQ5pDuyrvKSEmR67ip7yoDyhILC55uDEIkkuVcJGECyMRnjwKlzgOJA3SjcperC82u9RGvJ0jMQ9OmzrbApJbsrUqjXV6NHg74BTReoMm9c6Y4sIZCZi4Z3OnYSIbpG7n6a4wWOsqS4nYEGNRqlFfKhzCm8wo9OpQZ4TnLzYYnI50TuIoGhgu+NtcHhc4RX9WJ1iWVXRwBlF2HupflvrHHvBIY7h+W9cx9OYg49EU/WOELbIC8JF4aEcTh9Sra+t2yNGCQuPbHIbmYIwCKHTnbJWjffJ+6d8I6/MFCpEqBT3WYLXVM8k9A44WSwnDYMK+j2e7Ztsb5UZCvW9RvGPpsL6GPzB4LF90v/m/oi+KrjXXph7zOW/Q/4P8MY7q+EzTcVoLX2uwBtQurkih5evyuPfqX/JedxnsFZ3gqlpG1EA9U45yHwZHzckQJsM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+HJPmzKJt7QgwYz4UIY5NKORUB6VD9qFw7ho2LZw0DwJI+mbKIBgNgjNqz/H?=
 =?us-ascii?Q?t7x1EaL7ZBHfsof4pDP/NLGu3DFkc8cOYT9H9oUgD1kzoayCwfmOG9znsYcw?=
 =?us-ascii?Q?OHQae2tMFt1VcYW9camA7rFyIpMK6RnhID3CiZciJUHvhSO0bpcPG0OVr4Qh?=
 =?us-ascii?Q?QTnE1fASYuhwPR3F4ci6g/zzMfL2+1hLIXlnh0kfR6M8Jruizp5laBdoXO8k?=
 =?us-ascii?Q?tP8mMp82liMDdFZLpDpwwiPNKrlGLtDYzbL+Dima59Q3CR85lK/kXR38Dn3h?=
 =?us-ascii?Q?rt8IQE9mBfAdmlSTBpjTIRiNs832L/OjNw1bIbr1Ms1xQlAPSXEU6H36U1tX?=
 =?us-ascii?Q?uW5qxyzzOBTvJwUyP3UvOTKOZaUgg4dHNcOHpZmvQCqjvFo36yoeTnD4xSoX?=
 =?us-ascii?Q?NUzoE88zaZfwYEPsP+tS1N7e1xAaO/GKkGrnwpmCnGoQu1YwOYZkuW3t93IL?=
 =?us-ascii?Q?QAf+gtBByNbc+/JfdxqKwARXOxhREygq/elK+8aebwn8aocxiGHlc022FY9K?=
 =?us-ascii?Q?pnPeO6AqopiEYTWJq4UO/xPyrj2mWSZq0NxvinWmHzITMXp4TIYWAUG+RujI?=
 =?us-ascii?Q?J+XwQrV6wqffLI2XUghJb/Chd6WapIvnNPPUcigLzz6Ow6d1puaZiCqs/tAB?=
 =?us-ascii?Q?kuFtYRpq5yrtkPwhptUvE6D8FnzQxRAP60eYitUnEtaDJIf+9n3VeJZLJAwP?=
 =?us-ascii?Q?5cMHW+0/WtgBreSfMEt87n7cTIz226hjPWuNNqoh56SfUa+L0owiC+Owgnp9?=
 =?us-ascii?Q?leaQNhSi/bPL25LDD6I/mmvGxFkp5UahQ9E3XvnWR18nkYrFKApfeVoIIRZD?=
 =?us-ascii?Q?bkAb+7vKX7xtmuajZ1T5mF0BoQqoqvWaRUm81CaNx4Fbr0fRW7geRV0mmUfU?=
 =?us-ascii?Q?o7hfsHgYVFX5q7gEMULEfjAJjHVfSjQnYJSp+scyDffjnYoHMaIETdGhL4zu?=
 =?us-ascii?Q?/oM+SobXJJUeAjQ9Pk95hhupXZWJUIv5gXvtfL89Up77JGuNXOBCJUGAI1y6?=
 =?us-ascii?Q?P8wiyJzj0p/4vvEJe/LqCR3Pr2Znwrei8wX3XH1REzjJtBel5Rw6w1q875Gl?=
 =?us-ascii?Q?SbYQJTj7Y2pvLIPRTahE9d2kUiwKWi3mYPax8/EGIfrCucV8OL/w3SkXheiE?=
 =?us-ascii?Q?bnMFJ8O396aVIXucVypgYyDTobDLjDukbKTElDRg9Ob6eo9fu0s4qyFY1fCV?=
 =?us-ascii?Q?LmfFmdQxlOnmIpKDa5folvAQY5ztNTCyd2UWSU5EZ4mdIWnWQvBBDy7W53Nq?=
 =?us-ascii?Q?W5hRbRlfo4AGcHrfMcJrMSW4brNa4rCJ8XetyJ71LaqQm4CbIv8rA0HQyv8G?=
 =?us-ascii?Q?2I1DD4XWyLtz/WwaUNw9On2OD/c6T8wp6rPq90nskRukFeaUzulM4qaGvmUV?=
 =?us-ascii?Q?O2TVlDOHVi/gCBbttjXBlMBsRM3doAxiweRqQS2zjB95KTSfJ33kf5069Nm5?=
 =?us-ascii?Q?vg6652V3gGFhMD+N1rvS4E8ArqaDbNRM25AMvFz05t+hH5Uv/WuiMYUsDL8z?=
 =?us-ascii?Q?kJCo4YwShd+9vggFSdghMxjjYQRjqMPs0oxzPtrKxcvDipr7PF5Bjvs7WPxs?=
 =?us-ascii?Q?dCAp6vjxeajNt6RuidBlMdUqDaQc40npBJ6D7Uag?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d7cf1f-b87c-4d58-a174-08dc34552a80
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 09:52:37.0675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSE94PtS/+WKqZVUKZ+Xr4smhEtxaa6Tc4SV7dHk683dbd+XRwhl/yPyJ3q0WvG+4m04LvsScsRpnmGaOB/X2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0532

Add support for Kvaser Leaf v3, based on the hydra platform.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/Kconfig                      | 1 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index d1450722cb3c..bd58c636d465 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -100,6 +100,7 @@ config CAN_KVASER_USB
 	    - Scania VCI2 (if you have the Kvaser logo on top)
 	    - Kvaser BlackBird v2
 	    - Kvaser Leaf Pro HS v2
+	    - Kvaser Leaf v3
 	    - Kvaser Hybrid CAN/LIN
 	    - Kvaser Hybrid 2xCAN/LIN
 	    - Kvaser Hybrid Pro CAN/LIN
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 71ef4db5c09f..8faf8a462c05 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -88,6 +88,7 @@
 #define USB_USBCAN_PRO_4HS_PRODUCT_ID 0x0114
 #define USB_HYBRID_CANLIN_PRODUCT_ID 0x0115
 #define USB_HYBRID_PRO_CANLIN_PRODUCT_ID 0x0116
+#define USB_LEAF_V3_PRODUCT_ID 0x0117
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_hydra = {
 	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
@@ -235,6 +236,8 @@ static const struct usb_device_id kvaser_usb_table[] = {
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_HYBRID_PRO_CANLIN_PRODUCT_ID),
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_V3_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, kvaser_usb_table);
-- 
2.43.1


