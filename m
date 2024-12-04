Return-Path: <linux-can+bounces-2339-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C62209E3F56
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 17:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61FA16479F
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599A320C485;
	Wed,  4 Dec 2024 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="A90HbsGo"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2096.outbound.protection.outlook.com [40.107.241.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F2C215F44
	for <linux-can@vger.kernel.org>; Wed,  4 Dec 2024 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328410; cv=fail; b=kqtSY24LQklLZaE+QMtA0zAfg+/A151nUAbUnS+Or3cKKs4EvSL5K6OM+YhbVb16nE1KPO/ia4CaCljCfXRFdMyTIaYrqbt2HicB5ktnDciVCpe87FwUrIJ33blB62uRchdqPHF9WnpjhfXldIAC4w+O4vZrwg+8imrDJ4Kq04o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328410; c=relaxed/simple;
	bh=2yZvHPxG3n4EY1rJXOEcxE5qWcp2Z5p67iTHaQHpfUA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oeHKWgVgzOqDSjpmk671Dh2FiLu9jf0pJjFYo9b9Uz6iE7pS6DDcLH62bamQa1kvyEj5vKRgvVTBfRc7qedEYQeNLzgTqbm4sVYYOPg4wnGvR9RLhOyPFNsklC7CL1TGElvpLla+M4F4zOBxSawyOu0KnDwL5os3xNX7zcnZVCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=A90HbsGo; arc=fail smtp.client-ip=40.107.241.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qf2jR+aLNQCFPin6k6CJiR5l2FXIs+935ATueCqLAXtcdMh3iwF/Q6WZTlfnblsCTd0f8j0G6YkYBF1Yxv4csF2ObKpAzSB4Ty2zPLxiy5I0u2cNLEpjspIZ4HlnAKKLhKY4GA8lLNFYHd+vx06UTc1mO0Ab/rlMgs00cwI0AU16YyPNuhbMctv7qSYBLm0NpISsMzlOoXFYPvGOIAhtAYkq7izqIBCxyS3D/RkoyOXYipvrAnPOhNkxwTBtCELatCqVEsfVRNFpY74nwBhQJo4oGTeyBnY2qLiMl0un+UDDhx0VMgu/RDHTybFRVHBk4t3x3BAsFUGxL5iQblZziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2e618NuX+xiK5sJGShcSu9loPIrrvIZ+a5jE1qXBTMY=;
 b=spGRD3eV31ldZ/IFAckY6zy5Z2BrTJybMi5kjiGvrqJ4xnNEMm27ZLONhMEQIS+wArfpWpomx+KqYPlhlPq7XKSBas7LBnev0ci4C2TO/a6xnVU9dwMnGbNaXwRtzN0INl1y03tucWORbqBG07MOmbZcqOwuRmmFimyWU89qxwvdnzCMuyScOd7QkZsFJ6qpbgxhOhR5jswUUj3ZkTrwY1vxnRl8LKaeLd6wsWexyf09mIwy1YDmHoQpSE2y91Rhp9EdYuF6nvfcLBcALTbaXw5UNWuDBupfchiGJozFZ2S4e7Uzk140Ai2dXzk2C1jwEX3Z8w9Q0T4CaI+5b0Rgbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=esd.eu smtp.mailfrom=esd.eu; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2e618NuX+xiK5sJGShcSu9loPIrrvIZ+a5jE1qXBTMY=;
 b=A90HbsGoxHYz23qi7gvNWQfn7wrPenDkPfs5O+2vtSLamKYueEgO9OePakIzPesVT7PNNzclWx/OR6QH05drV4gjREJBOzqLaXz2QdS2Dn130/QOr79ANoTlE200HOtQiPzuacTyI57lkbZUQHkzqnSXAvFtuLyhayTnnCUEC0A=
Received: from DU2PR04CA0333.eurprd04.prod.outlook.com (2603:10a6:10:2b4::25)
 by AS8PR03MB7157.eurprd03.prod.outlook.com (2603:10a6:20b:2ed::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 16:06:41 +0000
Received: from DB1PEPF00039230.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::ee) by DU2PR04CA0333.outlook.office365.com
 (2603:10a6:10:2b4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Wed,
 4 Dec 2024 16:06:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DB1PEPF00039230.mail.protection.outlook.com (10.167.8.103) with Microsoft
 SMTP Server id 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 16:06:40
 +0000
Received: from debby.esd.local (debby [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 5FD907C1635;
	Wed,  4 Dec 2024 17:06:40 +0100 (CET)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 545502E189B; Wed,  4 Dec 2024 17:06:40 +0100 (CET)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Frank Jungclaus <frank.jungclaus@esd.eu>,
	linux-can@vger.kernel.org
Subject: [RFC PATCH 0/1] can: esd_usb: Fix device probe routine
Date: Wed,  4 Dec 2024 17:06:39 +0100
Message-Id: <20241204160640.884578-1-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039230:EE_|AS8PR03MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a5810c-54c9-448a-c710-08dd147da3d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXJsZ0xmcGtjY29jZ0lxN0xNTVFNdWN6alc2U2xjYkFDUEZ3azJMUUNxc3di?=
 =?utf-8?B?NTlOYndjZVJsS2tmWVloangwelo4TVhCejJnTzA4ekJ1WThsZ3pRcW5lZEVp?=
 =?utf-8?B?Y2hTSm8wTGp3MDdXNkl4azJUODZuYjRxQjVSVmFzNlVyVVJuS2FRTFEyZWVx?=
 =?utf-8?B?UUV3cHJuZERrLzY0SVBlRDVVK0FBeThVSm9iNDNPNE9TWG1abDVCL1NRRkN3?=
 =?utf-8?B?dmphOHh4TnZtcnVtVFRXbVh5UlVjZUNKN09RTmdFTUhjMGZpaWpwVEJTNk5L?=
 =?utf-8?B?SHRMRG1pQklSTVhJQnZqZWhEWWp4WGU2MXRtV1BPN3VLcU1JY3UxWnpUNzdE?=
 =?utf-8?B?U0RvdUIyZHpwMTliRmp1WG9QK0QwdkhnVjQ3NE0yanYvTU9raUlhUjNTenVU?=
 =?utf-8?B?amh6Y2E0TFBscitQYzAwSXZQVFc4Wk1MQ1hRclNRZ05mbHRHdVp1QnEzV1hQ?=
 =?utf-8?B?amwvdUFLNXNPWFRuZzdkbEkwVi9zM1RHZWM2eEhBZlowODJ3eFpPNTB3cnNE?=
 =?utf-8?B?eXhSMVZCNnduc0x4VW9PZTh2bThhWUlFU1BIUTVFdTIvL2JPZ0VzdnJ4MlAz?=
 =?utf-8?B?ZVdDbjU4dndOZkFEdHFDMU5sOTNra0VIb3N0VFMwR21zZnYxb3pOQlBnOWI0?=
 =?utf-8?B?bmJJWC96THY0bDdWMDVqWVRKZlRuOTJ5cGViQjEwb2NYeWN1ZVJuQWVkZC9Z?=
 =?utf-8?B?bVpUYnNIZHlwWEk1cGRJYVAyTzBOTk53ekdRTS9lejFtV2FVemUwN05qUGxu?=
 =?utf-8?B?MElkQjB3bXRaVUdLUUFFL1R3ZUd1UW8wUHlCaGdWQ1VBRWpWVUZyQUJSdVZ3?=
 =?utf-8?B?SWN6eXJGb0Q0QzlsMldQUytSMWhiSFhIcStLNjRXa3pRR3JIWlYyL1FaVkFq?=
 =?utf-8?B?REl4aytUYUdPUVFzd3lWVHYxdmFFeFJjSmZzLzFlaXpzdjI5b2JKdk9kZDNw?=
 =?utf-8?B?RGZ1eldtdkVtVXlOYW1hTzNRNTFUTVlpNFJIdEhSSzBYSWJYbmh5VHEwWjh2?=
 =?utf-8?B?Z2tzei9JTWN2ZmcxV1JGSWZpQTFTMlJJSUFDTm9KZ3M2cFYrYTdVbWJMRDVX?=
 =?utf-8?B?ZG52NFRlRjVkVnU2cHk5aWV3K0wwYW9iYnpDK2NWUGIrWnNHNWNaTDdrSnJt?=
 =?utf-8?B?WFMzNmxoZUpDYjNMUTZPT1RjclJKd3NtanVzcUE3cnowY2xDeGJFZUV5d3Jl?=
 =?utf-8?B?K0VwMURmVWcvUWt5UVdHUTBObDE4NUlkUDNyMTJEaFBPR1VGVWFNTHJ1dmdk?=
 =?utf-8?B?ZHdOWnJCYUtNVTRQVFAxYUp4NGpNRDlVQS9VeFZJUURtUHdkZkVOeXdMMjdl?=
 =?utf-8?B?Ti9wZ0V5SzhiWHQrL1BJSGlwOGJVTXdObm9Ka2RVT2FEQWV5dEp4UENud0xs?=
 =?utf-8?B?TlN3OWIxUHlpKzJVd2FzbjdyR01CMFNMbDZzZ25mdmVUUitobnZGNzJLV295?=
 =?utf-8?B?TnFEeEI2V1dLUE5oS0NMNkxlS0FTandtOTlBbGEwdHdBQWtiT2NPdnU1SDU4?=
 =?utf-8?B?MDlvd25FUHprb1l1c09oN2R3RDVsVXlndG96SEw1ang0VXhNOVdDVGRpWXZN?=
 =?utf-8?B?TVA2WXMxMDJaaG5pZlQrTW9aeEg2b0tOTjNsK3FCVUR3a1R4WnQ0QjlFbU1j?=
 =?utf-8?B?V2tZUHBOc3Vaak1pWkNMcFVkSjZ0QUZmTnl3WHgxWUMxc1RQZ3lUL0hEbXNB?=
 =?utf-8?B?V1NVS0xWS2NFRHF2Y3p2Y25QalFGWW0vWWkraU9RRnhueEg4RXM0Tlo1NGRF?=
 =?utf-8?B?alo2anlOVVNTNy9pVXE0T216QlYyMlh5ZWNWYk9XcllMNkpxVFZwZVRadGs3?=
 =?utf-8?B?WE5xRTNUN1h2VmN4c3N5RzNIUHI0QUNlSUFJWFlFYVpMelhoSEs1V2ZPc0pw?=
 =?utf-8?B?WGtocmdBcWJZN3htN3ZDV0xJTzBsdVRadnc4UXBSeHVud3RqUmRXWTRLTzdP?=
 =?utf-8?Q?CEbqzsF/Mfwjr5XfjINrHJ/RD44WEQ1L?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 16:06:40.7508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a5810c-54c9-448a-c710-08dd147da3d2
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039230.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7157

The included patch fixes a possible failure to detect the CAN-USB/* device 
after a reboot. Being a fix for a complete device failure I believe it qualifies
for the -stable kernel series.

I'm sending this patch as a RFC only with "Cc: stable@vger.kernel.org" for the 
following reasons:

- The patch size exceeds the maximum size of 100 lines for a stable patch
  mentioned here: https://www.kernel.org/doc/html/v6.12/process/stable-kernel-rules.html
- The patch carries a Fixes: tag for the commit where the support for the
  CAN-USB/3-FD hit the 6.6 mainline kernel even if the erroneous code was
  present in previous releases. I have done this because the internal structure
  of the driver changed with this commit. Backporting to earlier kernels would
  need some adjustment of the patch.

For the moment it would be fine for me to get the patch in the mainline kernel
and the -stable kernels down to 6.6. Earlier kernels need to be addressed with
adjusted patches if this is feasible.

Any comments on how to proceed further? Will the patch size disqualify the
patch for inclusion in the -stable kernels?

Stefan Mätje (1):
  can: esd_usb: Fix not detecting version reply in probe routine

 drivers/net/can/usb/esd_usb.c | 122 +++++++++++++++++++++++++---------
 1 file changed, 92 insertions(+), 30 deletions(-)


base-commit: 38f83a57aa8e644f37a88d4771d756303cfa7365
-- 
2.34.1


