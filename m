Return-Path: <linux-can+bounces-4051-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8E6B0ED5C
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF6916A231
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F09927603B;
	Wed, 23 Jul 2025 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="VsxhLCMM"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2132.outbound.protection.outlook.com [40.107.22.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB7A27FB10
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259745; cv=fail; b=f5Gtl/4+499/7aSsBqJPUBuA3NafNm4+yXoEJzrOKMVW1VtG3aIxIkog797l7hVhONr71tnm3tbWSTqxGGjwycOlSUOm65Yx2SPz8B/TUuSsRohkF17FnOmFNcmAZCmLER3wKIEqz3i1hfZ0kcwwM4ut4ybt+qozdzbty6Gqy+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259745; c=relaxed/simple;
	bh=aFBFRVHbX3BT7sK4wh+m4NoEUwVoJkp+UE4PEC0Lxwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rBTyfozImrLiDI7HTWpKYa/PyKeBs9KZx7ryW/pMIpMQ8P/lQhxj2BR3G7crThXNlhEifVwnqoQfSvp9LCaoDJr7khLgoMYiZIEaWSxLaemhxCjqeZyY/H0ojk2GuG22MNkAoYu5fEtx61jeLDMKLVBKj50W9zbATl+gngfGY34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=VsxhLCMM; arc=fail smtp.client-ip=40.107.22.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQy4jLM7SXIZG54gdXq392gziWCM3bnfFGsc51kJrpX7DIF7mli9eLDtXdRxiOZlhj3rzw7KbCbKG5vpGhpY3Nvi+2jQx1XVuQOmoi6Ong8IEoQJiIPfMbOkXNMQtkMzyImugd9p61ttWOBGHiZWYTN5mGzyS+jKlxPRW7Ih6TFZf0llwmTVqbE/6b+s8kSUWCaLgTDR5vVIyIn4t5gDdKmGZ7zWn4TR0nSr9reqYyeG4GA+uWPQq35z/uxEjudeouR5THi172xN3y36wM5c1VZf3o0MZ7xEsJWfH8CM9+qZjzOa7BlFnizpPAX2zpzpFaQFeJs/71SpdaH6A1DPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsuRxBnFTqOAPBD00PBe03KETj54yk4X6GjberfeS8Y=;
 b=hcwrCgpPA1c656DrOmp5HF0MJEXSIU0azsxVCJwRhdsW0s+EonwCD4q+WZrMsdAdS+aqJ3NhwMyT/1URtlmeWZvI1xtxDnnQ50zUnjKZcUEbKyEackyuvuQKpz1Q+FKPYbgF/BuC2v5LznH82rdHY9eyUfD5bYhMqEH+2ZJ6JuYOKvJfT+C2SETmu9TV7bMpaXxdF4F+FPEnhNZk1IXOZJ12iB+F8NC5Oev5QtoRLCKDof9xP3+lT5rIHQeXv7w1qKR8Hs/y40SFFpRUJgEySODMfovF6aIDSS+0XOHnkGx4SLZQpMh8F/0ZSFnxxXhT7bvDXnXj+SzOm/ASNZnPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsuRxBnFTqOAPBD00PBe03KETj54yk4X6GjberfeS8Y=;
 b=VsxhLCMMhbDQMBTwW+1y4VnH1oMw1HmHee9heGAmuOjr/1ffhubCPv1LdmHHEQ4ieaNu832gvVBdGWT+zO5YCCx2S0J95XjpMCPMRRqqffdhSZ13NsHuTyjyyY2B5Q3f9MU6D5oWmLsERZeEfpbNmMj/V/JwsrmiR91wBeTeiPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DU2P193MB2018.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:35:34 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:35:34 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 6/9] can: kvaser_usb: Store additional device information
Date: Wed, 23 Jul 2025 10:35:05 +0200
Message-ID: <20250723083508.40-7-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250723083508.40-1-extja@kvaser.com>
References: <20250723083508.40-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0064.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::26) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DU2P193MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dfb5c0d-ecb3-48d3-21e0-08ddc9c3e427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?abcje9McYrPi2805bW68xBHWGdlCGuZYVWIEQRebbL1d52Lh1/GbRQ2nj/jp?=
 =?us-ascii?Q?JuY4nSJ5nJG3HDdQct1XtupVUSswehrzD1cewd5fwzA1jn8O5UhOS55IzuqI?=
 =?us-ascii?Q?TlzvKYvBNba0EUjgp2D8XsVsMyxJvRZnSsSdhsZWX4MB3KNCJZmKSt01xM/H?=
 =?us-ascii?Q?XbuwsDbHkWnkB0sDO0c13icCkvaqkWoJ0RVpbqMUpDxdZ0njzYgoH3ZZ+JPi?=
 =?us-ascii?Q?jVFLX6YI3D9Q4Ga0CPXb5PThG3OJdPrAn8Zua6f0+Org85wGMeSJrmqsqPSP?=
 =?us-ascii?Q?9XJ0pSfx5D47O9X8IBwqlROfA79eSAHTg4Zm2rj9Igv7OFKDwg+tLjftgtmm?=
 =?us-ascii?Q?eM3E2g90NDmKUqggLkZV9Yflo7LsVVSB2RALBeEBAUqs7rg8NfaSb1gdbp3j?=
 =?us-ascii?Q?h6EZ2u0y1geZ8ydFAWYSfYlSSToIYb2jUOcNQ2WebIhQ1OvHj+QXvjuzGWpZ?=
 =?us-ascii?Q?WuMZOGuZwa5VzdyI8SvrQt6v7AAU5HFBhKZaCo8a37U1ldRWDjEC4U4mchPz?=
 =?us-ascii?Q?heNX2xs9bdC5qR8qi48Grw9c0y7Rmq8wWLAqHGwmXXV/KYK1NiibWcl26rYb?=
 =?us-ascii?Q?1DH5d2z6U1DjAGssVz4tpAjiqBEUt5YwskF1IcUpdloQ51m0n8f+Yd40L3iN?=
 =?us-ascii?Q?ggdQFHvdFN2FhPZEPq7zw4WUNlkbjTK9+SyOhKEd2o052trpeHhHeaWlRI3q?=
 =?us-ascii?Q?qFG1Y0Mhpdi/hmDPTkUkEvKC0pwElvEqIVPg/Al8o+OXTEnlMGnofYo4Zx6u?=
 =?us-ascii?Q?d7RzyZJxcs/KyyaN8dDroEzS8z7NZQG4ZZWqwRngO7y8w/LjeKhowbRz9pxm?=
 =?us-ascii?Q?l7rQUF/aQ2ciKgnDaP+hIfWVO3NR8XYe+4PPaDv/U9CQE4QM57oBCGZOaTjz?=
 =?us-ascii?Q?+OAzy/0zVDaEVkcaGpYq935XD/thLL91uN6l2T4NUb9R3HdhxB7Imix03BeE?=
 =?us-ascii?Q?C5JGRqp+JT3avqJrxWd+C2SWpCYVVDrx51/lr22DStphe36AjzRLWL4DWFlE?=
 =?us-ascii?Q?Eu8unKBkT7RqhVcNM5r44H3s47e0YuPnOB0phWHx0ws8Ohk26OwbLCsbrMRd?=
 =?us-ascii?Q?7143cAvcZFcGIX86emub9cttUiS46bNSi3W5mayGif9sUJQ/bzyVzj06ox44?=
 =?us-ascii?Q?WKjQc0LUWX7GsfCwE6vmqkfJeywFR4VS7xcq7ppHrNnGWyMKkQEPp5c1Sh3y?=
 =?us-ascii?Q?zjrgQs7Vir9dmSSst1tjaVlekNXEmlSPB3plRZN9n/tiS/kgXMbYA689WYh4?=
 =?us-ascii?Q?oAzZOUyba3beVDc+HPMPfIBhUNXK6rjjTavCb0MwcDngElFIC4xMRi9HJBX7?=
 =?us-ascii?Q?MFubBtkGL4ARD7Fx0pBiGsTF5oGlIG28W7uJs6/81ys7SIFdLX2D681qZlEE?=
 =?us-ascii?Q?S2twVs40iU3xQz+uvxV4bii99QVlbjPGZc51MXxW+HBBmIgE7Eko3cA0dPfv?=
 =?us-ascii?Q?ybg2n5aMXdE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QXgnzK9JcsGLlfynIQqtNbb2ZuOXaPT7UZvy4l4dp4K3eeNZwvfA/DcU+EXa?=
 =?us-ascii?Q?/8ZEFtMlnRjERzYCp1b+8Tosqn/xn3nR65Yk2R8Un358XoY3WcQEKtDYveTw?=
 =?us-ascii?Q?i6I/7BX2AXbWgqusTS2n4MRZtHyPFbatVSPS560uvM5q4cpONl4LUc1GZJGM?=
 =?us-ascii?Q?Ysf4EDvfVQGHJIxzohykHnH1lRL7lPmjDZBtwI0f1MTU8m1O1a/BOya+WJba?=
 =?us-ascii?Q?qDCFw0EBKJ8qrVxNVr1+97ApjQtutTo2EiJoJSiWrWafDFjNg0Iyvomisrn+?=
 =?us-ascii?Q?2iGrnihsLMjU2wR/ks8xvaFNgnQqrY0SQ/rB2O9/W6zTdLdWhbPvzWN+56Wv?=
 =?us-ascii?Q?xKvX+3oXGMCtaZhyn7zwvKI/fB3om9QyaadAJzGexNYqRzHtaIwk+PCD/9UD?=
 =?us-ascii?Q?GEYAosfUcNNWXm4/Lo08vygJUsyQvHxEVcSTksOdE/flRAAfvbYyQ+ceNiQZ?=
 =?us-ascii?Q?ulQfD/06Pu5QNZ22sFacvuUWzoX4sA99TCGE1wCRUOLohV7RWqpK7UwIAetB?=
 =?us-ascii?Q?ndAAPZswqEDiaEGQAo/g8oAOp3nSH0YsBoUzBaKKXr1YeeAqFKSGO2/EM4/r?=
 =?us-ascii?Q?VAOQt6HjMb2bVx9kLQo7b1mNDfDydkbcB7uO3SRaJ74HKK2NGgaLZF3hzr3B?=
 =?us-ascii?Q?kB6er2FrEw7m/exkZvGzinvBwKUQJOFHmaY8doCAkEA/A7VuJY/OcqTJ366I?=
 =?us-ascii?Q?CiI6bz9USFnDXdESegNEDhOfkUzOWdfLWjrJlJb/SgLYpXWCccomPRzuHQBI?=
 =?us-ascii?Q?/neKZFau3oJC6NUuBIANBt0FsEvWMjdB9efOAfv0cmjhcNoF609pFIiOmB6m?=
 =?us-ascii?Q?vuppXxx59b3hVPequNbhxPtOKYetbe8xs1jIgBZkX4UwX4S0bF2gNSYI2F3G?=
 =?us-ascii?Q?P/7dKvELL6WAnC6hBaglL6fSLE7Pp6XM2C+dglAu/L98KH0WW/S3c+RKeJh/?=
 =?us-ascii?Q?UN96jcz2zsqWeycUeOehRgU8rX6SPrWyDFYwVAlPmxX2+mLIWdDB3QlHWgv+?=
 =?us-ascii?Q?vmpiNBumCL/IHd3vo6UBZamPmJdmChuqwYZz40racEiPh38xF29Seu/vDL6o?=
 =?us-ascii?Q?q44tAisQ6FPIU8L1zCOETI8SDn14JSIMh8FZgvKoYU4eO7QhAiYCvB0jD7Xk?=
 =?us-ascii?Q?8L7iT/f6ZdLC5qEYUwVkoaii0sIEau/7tjPDIL90x1uXcGO0JFVNQ1f7V3hE?=
 =?us-ascii?Q?77i6raby/PifuQDQk6FJLfIb6iXh2fzBEq9pac/tlfzzpdsH6mVfC6EdgM8u?=
 =?us-ascii?Q?LtDlTo2HZX31n3w9nGpVITZ3Lt6Q8goSoSBcnz3FnokU2PiLFNYp5IqeZSfq?=
 =?us-ascii?Q?gqEC4HKDvSoR/H3VwOrfG4Y3Tn5ThozTmi32pswh726joLTjGkzDGEX9sq/r?=
 =?us-ascii?Q?eWixTvZM8v+MmbtpVTz24+8KQYFVuMtyVNxcX3eWSf2M0JwG49nAeVYvN/qH?=
 =?us-ascii?Q?R9aTiQdWu/WoySWZ+uaPLn9DxZFJhLRZNPG+P6qNSmIRJxfA9LYHYimBDJUh?=
 =?us-ascii?Q?3cxqaxelfUAmdg6HDsBtGuDcwdMEw+idLeV2veleaGBdZFwW6K/e78HbcqrR?=
 =?us-ascii?Q?ldZ+j9n4bZDy+IFWaPSZAIk3PJ3RLNfZ1G1FuHvC/wmE1SybmGef8RnPSQjP?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfb5c0d-ecb3-48d3-21e0-08ddc9c3e427
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:35:34.1999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zyj/Oa8+SoOPlj3uC1YQkQiTXnt/HonKyCcSGi696Z3xzdj25Bkq3XjKeS/RyzWOQyjA2U8fMBjZE+QMlaQC9Zgav4Tuakwd387lcGzQ4bQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2018

Store additional device information; EAN (product number), serial_number
and hardware revision.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h       | 3 +++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 6 +++++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 6 +++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index a36d86494113..35c2cf3d4486 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -111,7 +111,10 @@ struct kvaser_usb {
 	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
 	struct usb_anchor rx_submitted;
 
+	u32 ean[2];
+	u32 serial_number;
 	struct kvaser_usb_fw_version fw_version;
+	u8 hw_revision;
 	unsigned int nchannels;
 	/* @max_tx_urbs: Firmware-reported maximum number of outstanding,
 	 * not yet ACKed, transmissions on this device. This value is
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 4107b39e396b..a8930bf933a7 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -114,7 +114,7 @@ struct kvaser_cmd_card_info {
 	__le32 clock_res;
 	__le32 mfg_date;
 	__le32 ean[2];
-	u8 hw_version;
+	u8 hw_revision;
 	u8 usb_mode;
 	u8 hw_type;
 	u8 reserved0;
@@ -1918,6 +1918,10 @@ static int kvaser_usb_hydra_get_card_info(struct kvaser_usb *dev)
 	err = kvaser_usb_hydra_wait_cmd(dev, CMD_GET_CARD_INFO_RESP, &cmd);
 	if (err)
 		return err;
+	dev->ean[1] = le32_to_cpu(cmd.card_info.ean[1]);
+	dev->ean[0] = le32_to_cpu(cmd.card_info.ean[0]);
+	dev->serial_number = le32_to_cpu(cmd.card_info.serial_number);
+	dev->hw_revision = cmd.card_info.hw_revision;
 
 	dev->nchannels = cmd.card_info.nchannels;
 	if (dev->nchannels > KVASER_USB_MAX_NET_DEVICES)
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index b4f5d4fba630..c29828a94ad0 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -138,7 +138,7 @@ struct kvaser_cmd_cardinfo {
 	__le32 padding0;
 	__le32 clock_resolution;
 	__le32 mfgdate;
-	u8 ean[8];
+	__le32 ean[2];
 	u8 hw_revision;
 	union {
 		struct {
@@ -854,6 +854,10 @@ static int kvaser_usb_leaf_get_card_info(struct kvaser_usb *dev)
 	    (dev->driver_info->family == KVASER_USBCAN &&
 	     dev->nchannels > MAX_USBCAN_NET_DEVICES))
 		return -EINVAL;
+	dev->ean[1] = le32_to_cpu(cmd.u.cardinfo.ean[1]);
+	dev->ean[0] = le32_to_cpu(cmd.u.cardinfo.ean[0]);
+	dev->serial_number = le32_to_cpu(cmd.u.cardinfo.serial_number);
+	dev->hw_revision = cmd.u.cardinfo.hw_revision;
 
 	return 0;
 }
-- 
2.49.0


