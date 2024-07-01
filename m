Return-Path: <linux-can+bounces-933-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6213091E4A1
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 17:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80EAE1C21688
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 15:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7186616D4D8;
	Mon,  1 Jul 2024 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="iSgg82nL"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2128.outbound.protection.outlook.com [40.107.105.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C0416D4E2
	for <linux-can@vger.kernel.org>; Mon,  1 Jul 2024 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849018; cv=fail; b=VgtUcWvhhoM3Pwck3pLUkcag5VbyLYCgiSl2rwdA7RVSMi6O0jeur+St8Wfv1fDRQdwFIPSU8JtZcyK4BcVxF2j3YGYvE1NrtTw+V7rDRZQ55hnSAJ4m0r0ngjCMQHybhSl+rfYOe6Suz3I0UuHexs8sqYb+bI4HLU6dRJM9h60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849018; c=relaxed/simple;
	bh=kM6HF7+HIsTiI+XfhuWmkBKRzL0InCxn5dc3xlM5uG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o+kSwn5IIXmlHtgV6uOoY6VjCbHmJZZurJFxqvU1nlXS0IYJ4q2QgcXro/b1Xv1q6cUkT7C2vYzhqAigCC+LcwPoi1Tcu4JNto0owpd87kDT+QsMEPVEV0Cz7OT+NOU8XGhkZRsa6hCaPf5a1l8OwOsKrmeU19Pxon8kymoscDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=iSgg82nL; arc=fail smtp.client-ip=40.107.105.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeCNixd10HEIuRc0Kve+74wMgyBdSrpCNSv3gkpAuj5p775Q3AlCo8ZfvM99sVL6HShTvg8Ia+mXDTTO2c0iMmDx0r1MvZWCRk3lOHv4htWF66jaDm3Zscms/9fn6ZOJjmMU/mGCqOG3RAO0Dav9KYmkJ75BAsTsoB96fC7VIAtw25Qq7nM37KbEPFosfv4vPV7u/n46LmdWSzWuf0f7cqp48iRwPP2mmjEtTliyhbjd6hO9Vz8+o7LCGDZURhKhMfZG5So7vahm60gZGV2KxoEiLhWR0mOAdvDoQc+v/R3AgD2lguBnmLDuseu6sejDACk0EXVn3fr6sLa/QQ5OwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYA4Z0vPmMMBpdubpF7tl/WToyrvPONzDDpG4HhQiqs=;
 b=oRv0/aoSObpq5ac/YsLzkD6CiMtqIhkolgcmtu+ek15cJG/QId+ZXmMyZhEa1xkMJi4+UsbdvQMuhQpKqvNGuDPuc238aPfctjyzsFs6LcPzXXYasge21L4DiGqzrN6pBdq6ne/rOktEZw5RojsJH+kDqdBsHbLpjsAXaDkQsNnRhkz6KrtU5FZSW9eYBloVJW8ZSlWZDMuqphT0JS3pkUHvNn+4nT0R3/qHCf1GxpaY0L5h0zsW73xDah2PIgmeRvXAHrR4h/1a+apX0azexZA41PAGVlyWR5hNtkE88jCW5Q+TtvPT24jV2mNP6LDS76vxbMrmaBURVphtKDlLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYA4Z0vPmMMBpdubpF7tl/WToyrvPONzDDpG4HhQiqs=;
 b=iSgg82nLzjjmxDPzgehM8T9/8YkiVVCiameo9rrPpIdvKmdtXXTXY4txidMq9ENgAzUylVwt/aXoBLbBm/y3Pi7g865KSsa6FwrYvqXsIbOHMwMvBTq2GL7UhuVoqL0arKeju/Ir+G6yKpch7q60y4YcCwNOcnqVUMeY2L5S6GE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0519.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:50:06 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 15:50:06 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v2 13/15] can: kvaser_usb: Remove KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP
Date: Mon,  1 Jul 2024 17:49:34 +0200
Message-ID: <20240701154936.92633-14-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701154936.92633-1-extja@kvaser.com>
References: <20240701154936.92633-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0112.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::20) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB8P193MB0519:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f860ac1-8013-44df-4974-08dc99e57a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9AlFNL0gfPVk3U16w6ttoSKavduuIcvq3MobPmIF+4PBtMrdKZoZtE+zk9M/?=
 =?us-ascii?Q?gKENaS9aA9GXXLetNhwHoKeraJu0MW3KPXEpfaXBc7KkJOTeE4Bwn39A0aiZ?=
 =?us-ascii?Q?mm7T5WQd7I2oZv/U2G/OD7Jwyn+Gx7LH2Bhtrn3AOjbmNETjfdZVZkMTxOFz?=
 =?us-ascii?Q?eMNKjQFkktT+8LJK0pVxike3W5LTk0n0HaUmnIU5kHC/vohkHroOeLnFi/RU?=
 =?us-ascii?Q?EnR3yX/+/u+X2pschwhwSRLVLmhbPVeD6iQC9sORGx/QB3Os8c3TTMVm7z9U?=
 =?us-ascii?Q?6+TPPrqbVoiDGHujW6DJpWFGDRG8FPt4e+Iv/jQQSMOzgOXJdRZa9MYog/k3?=
 =?us-ascii?Q?5B9PWDCr9xpFDQtdEhAtgkX+ybf4UF30NO/zi2dNv/NNZrCcmTHVjAz1wQ/z?=
 =?us-ascii?Q?qpg2wZ5LnMyHkFsZ5EcRP9KsmjTOigOEryz0QqujhR2XzaJpc231/Bg4/Av+?=
 =?us-ascii?Q?q23zRMA2DoGqrxFxN1OvaeIDCLpxZ6EK3t8EeVi3HN8d0iQxy+yxkuK/Gord?=
 =?us-ascii?Q?VboJwJkLENvR6m7G8oWZcZxILiqWYpT6ijqZ8P5IdmsS2bWnlrGa2mEPEy9f?=
 =?us-ascii?Q?vOTBU07P9vJgliIZPj+6gjOt5uhn+5ZrCga3sTvNtkW469Pzvtj2kHey6S7f?=
 =?us-ascii?Q?aIbv+16FA+J+heC4eu3xQ8zjC7u/mL3PmrfgUWE1/lzeSNy2hWmGPhCPTjq5?=
 =?us-ascii?Q?XblsgnEO72Str9dRiXvH8a6TZpMH2EmPXs6tozGrL43OqAxTpTzVf4ISUczm?=
 =?us-ascii?Q?XwHZq26FcnsqFEUvxRHlK5+KI2Gex6pknzOhe/uekfBHuW0MBxoQyjA73ypZ?=
 =?us-ascii?Q?sk00SfpikCfYMhY819LvUJrBIPIJ3do7n9QWFn1Okf7kAsrn9wMFp+YgzJyP?=
 =?us-ascii?Q?iATGG+Xus5bYfxIP0K5M0XfDrmPSTDFN0J1eOTY4ZupN6fvq43IjbuyEF2le?=
 =?us-ascii?Q?l6zzJXf++EqDYPKuYb78ydSWq+7wTSGRNFFRKZ1zHAiFX8JYTe6bn8m5BxZ3?=
 =?us-ascii?Q?PNQTO85ROw8bRPGIR91Zj1c0eUkUZDLnIMOO4BKnselpU93K/xwgOhg9zQxd?=
 =?us-ascii?Q?So5RPKiQCJuzY7zM2jom6qO2nQq9mFZiXQVcnF+XoV42MRNiqhi7bBy5ehuH?=
 =?us-ascii?Q?y1/KOk07wc3FVXDJf9sWAUGvE5iL6rN9syyjQnripSiukJyOQGsquuJikvZd?=
 =?us-ascii?Q?9z83xJORP9ha1Pbz9zJLPkrQhE4wx8AQ082bI00nier5AR/My0tXqbuLDAXi?=
 =?us-ascii?Q?wGYzvDWTJ3rykE7GmWSDurhHRipyIOp929ntCrev/KGxb+PNP5wqwpzp0hn+?=
 =?us-ascii?Q?fueZP5gKzeZvHNfAOdTGvR8QvO9l9uHAhoPHPB4tujI2HQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dtU7NW1uBpPPuUVSKbBgGYG/KVVikSc3HqJW1/5wBw2tVL/wJiGTovZg5u89?=
 =?us-ascii?Q?/xbzClePwSz4kXL+9q7deiJlKiVZQYm83uLd0xByvtNTvZ1/A6hQwrZLFWGx?=
 =?us-ascii?Q?6AhOVVVAK55UsqyQaGaJIySddvUFQXBqLOC6P0gOyKFITCphyv8T0h2IeJTF?=
 =?us-ascii?Q?JRf79yOUtchQihicGnIu/fIuvRqhGfC40wTGhfRFGvnercqiN8JFOSp4aGrd?=
 =?us-ascii?Q?bRbOt+ESaoUch4Gc07UYIURlWir6T1DA4Q9lFVX/P65LOdNTpeKlInvEqL7c?=
 =?us-ascii?Q?A4ti0blJtjNCNcdGQ1Xx8NyQ1KmbkxS8pugeJMkALKRFnzGTeChBe9AMrTF8?=
 =?us-ascii?Q?uGjlHFeRd2V5kGvQbe+TlkNvoMSxsH8dbQ7C7aEIReEwFAnFLVfJP9F4PlIm?=
 =?us-ascii?Q?arkVw+Ask57LU5XN5c4kEqZkJY/dtBsP9En1AHoQ7iYOBsUkjCjInR3FwZH1?=
 =?us-ascii?Q?Id6jXP/9i3IcTUFvHcZEZioIgF3OxD40hwGibkoI1Qnf5Nd7ErJBOOCFjSyK?=
 =?us-ascii?Q?bqlvRB9dJopMXrQrihQSjWBv0R/O/EGSFPMPxyaqkbwDMk2je7ox/Gviio7p?=
 =?us-ascii?Q?XZHkazrc33WmbYUL+Tsrc3oI0Nov419RfzMPqWIBYisybP4lFPjmgVPllWNY?=
 =?us-ascii?Q?gkIwK8wFcCiwVvIyQOXffb70QfUuhWk2XDu9HH2bvRUaLc83XVRUctVdxPLB?=
 =?us-ascii?Q?f+nj9xhJ1DADB6C2Vk7Fy0AY0Y7RUWxPy6uYh69jMGUJEh/g7cPRA9BHBP6e?=
 =?us-ascii?Q?HjInCdGTF3LiIQPCTkEh+ELiy4AOI0NRWdRoPalx4DzoIiCeYTRcG1nQHLN+?=
 =?us-ascii?Q?AKgSO5iLBMGM+IO0cY0x1zTprW473Wzz5AxFFIJL/ZutOdCjMThTeB3RIT/s?=
 =?us-ascii?Q?1krpQUJic2T3rMqa5RXKb0/1WuG0CB28J0b/2RMV/xzAFvhZo8xNx552bvFf?=
 =?us-ascii?Q?TWMoK5Wj5YDOs0QE8f60DETEWIEXXpKDKf0mxibEWkIT99CjZwO2QYl9rwkd?=
 =?us-ascii?Q?lOG3cUFoTau+UuKJC9MZD56wBetGaFVv90UxtN6X2ia+GUfllkIGez2477+y?=
 =?us-ascii?Q?5Dc0lU0h6ku7tKdGXChirQnnI67wizIJzQfUSRaX+707xs/i7F/Zx07DEumA?=
 =?us-ascii?Q?p3a+FhAj8wFr35kzjTEkzf1NvMPDhVjaxs8TAKNcioCIqDJimwWTXogK3jO7?=
 =?us-ascii?Q?sgJjIyBh9LS124KxT/ia1Grvg8u5NdGvQlvZ/1zxqW01JrN04UcDbH6feXV+?=
 =?us-ascii?Q?8q7KRVgTqFrtzB89PT2poWVtGkNg0HuQiVmCHty94Nr0gl0IHjF7bswfOZ5y?=
 =?us-ascii?Q?mJIunl9pYVxJwL6C1ALBXlE89s6qptDZH98zLNXZgmgsTHUqkzNDP8VxL0aU?=
 =?us-ascii?Q?+DBvYieGBucv9MNmHGXxXMFIfxMkqF463VEM+mD7Gax9cXekTzvWvqnxbUBa?=
 =?us-ascii?Q?iim4ePEN5QUZ2T5oqMQ7OrLPV+mo9Jf6+tJWIHhqWZsNIWxNyUcEKdUvg6Iv?=
 =?us-ascii?Q?2I3RScfkx8g+kKbHK0IncJzOgUmMTYIds282eTJX6/o8+1x2qSgvESP+XF2L?=
 =?us-ascii?Q?wjuisj6lCTDlxglnMf9qJcCAPx7tOMXVn4ckNb6h?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f860ac1-8013-44df-4974-08dc99e57a21
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:50:05.6859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esqaqpZCFSwYdSlf2Q1Kd/Ejaup82SebUlfUWJM5IiGsYElq4vrcm0ouEy6TgfTwd4z8mT1WXrHjDkV132lS6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0519

Remove KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP, since all devices got
hardware timestamp support.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - No changes

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  1 -
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 26 ++++++-------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 591f707d2895..078496d9b7ba 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -41,7 +41,6 @@
 #define KVASER_USB_QUIRK_HAS_SILENT_MODE	BIT(0)
 #define KVASER_USB_QUIRK_HAS_TXRX_ERRORS	BIT(1)
 #define KVASER_USB_QUIRK_IGNORE_CLK_FREQ	BIT(2)
-#define KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP	BIT(3)
 
 /* Device capabilities */
 #define KVASER_USB_CAP_BERR_CAP			0x01
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 576ddf932f47..a4f32d57173a 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -94,29 +94,26 @@
 #define USB_MINI_PCIE_1XCAN_PRODUCT_ID 0x011B
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_hydra = {
-	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
+	.quirks = 0,
 	.ops = &kvaser_usb_hydra_dev_ops,
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_usbcan = {
 	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
-		  KVASER_USB_QUIRK_HAS_SILENT_MODE |
-		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
+		  KVASER_USB_QUIRK_HAS_SILENT_MODE,
 	.family = KVASER_USBCAN,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf = {
-	.quirks = KVASER_USB_QUIRK_IGNORE_CLK_FREQ |
-		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
+	.quirks = KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err = {
 	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
-		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ |
-		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
+		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
@@ -124,14 +121,13 @@ static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err = {
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err_listen = {
 	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
 		  KVASER_USB_QUIRK_HAS_SILENT_MODE |
-		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ |
-		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
+		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leafimx = {
-	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
+	.quirks = 0,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
@@ -862,14 +858,8 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 
 	netdev->flags |= IFF_ECHO;
 
-	netdev->netdev_ops = &kvaser_usb_netdev_ops;
-	if (driver_info->quirks & KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP) {
-		netdev->netdev_ops = &kvaser_usb_netdev_ops_hwts;
-		netdev->ethtool_ops = &kvaser_usb_ethtool_ops_hwts;
-	} else {
-		netdev->netdev_ops = &kvaser_usb_netdev_ops;
-		netdev->ethtool_ops = &kvaser_usb_ethtool_ops;
-	}
+	netdev->netdev_ops = &kvaser_usb_netdev_ops_hwts;
+	netdev->ethtool_ops = &kvaser_usb_ethtool_ops_hwts;
 	SET_NETDEV_DEV(netdev, &dev->intf->dev);
 	netdev->dev_id = channel;
 
-- 
2.45.2


