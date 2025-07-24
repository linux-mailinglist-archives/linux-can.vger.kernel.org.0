Return-Path: <linux-can+bounces-4070-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C206B100B4
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 08:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C0587B0593
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 06:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241231F5828;
	Thu, 24 Jul 2025 06:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="QlAAziTs"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2139.outbound.protection.outlook.com [40.107.22.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAFF2747B;
	Thu, 24 Jul 2025 06:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339041; cv=fail; b=M3TbTbKew1HXNcoqdWEnNXEP7VmQehdWb3MfXyMxr6g0/PIeF6Xb01wOb4iJ0L8neCwG30wqUsiHJ5/84DEm2ePMx1sHeE1jBPt/DYRSDLkHlfiuAIhaw305PZEaSrsYC4DDQkNNYYrD0mCZ2ifprVcphe9m+8zq3XsbNWE3EoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339041; c=relaxed/simple;
	bh=T/gFUfs5FQZmyGzxf2eai1qV+g4bTlKwnWe/OKLS4Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TJ7rPxtFQkt3YEIRmf/UlWXZ2VwEWctgj6Nhelu2gYQmkp9WiegmCZBU46o8DiEPv5RznW+4kse/NoY5SKegFHFzpxhS82mt3jpxNC3rmzMg3JgZkC3a8RkA6ig5+EzMTFyXZR9D8EvMzQ9JgN89nFsZ17sMrejENHCAZNTfoeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=QlAAziTs; arc=fail smtp.client-ip=40.107.22.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnZjK88zFMhQxohbdAYVCTVp4gdOPM02oYkVXd4vO2NQ3rWtahk4b8FGqgnXafHhdvtlbHk+deg/jWfe7JOAyLXkihboO+VeX5YWzNDKGaguIyuL8vqaFwGaf/jxdJRTBk+q8vMgT4mQTlYYWSPpqTeDZI92q5f1LCe8m69HNxSkrowwXO4YuLvORqpRWzWOI3LaxR3OQWoKHu3Hl4Rxua9pTP6r6V+4m7aKdEGF+6PrcO2IdKWVOew50c5G5ifxx63gVcRyBM+6iAgHXXvZpdhjn379q//XUVKEwb0coBlSM0VHo7RyRsS52xXsrt6H8/qUJcFR1sfPv3baO5Mz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViaWm8i0Pgd7/dVORIv5bk1AtkxGclq60jw3d0FUomw=;
 b=DKrFyRZy1OOMFgW+dfWXDbLqqcMjZbDMSlQv+o7vqGOa/IwCXm5wYi5pYsI+oKcTli9i7Bf5yXnGWTkNmlW0oV3rKiw2fBe5eqBjyhU/Bkudbs9wIdGEkF6tnCV989oC/QQV7MiIGGygDEOQeB6dt6W0nCszJB8IVO1f9WWY+/guUF2NWAuVX5MzcU58Lvrth9R4Lm8+x6GD9wDyHC8D0KQktsrZix/z6tlqyRCCcAQLk0T9McYCXMem4lOTNQqXBvRQedKLA6gEs5/AL/qNaTg/7L2aY1cN2S8jvzQgZmqCNfh4lc1sDzl0c4igrk9wlh1fMPxeDlYkmcvb+On3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViaWm8i0Pgd7/dVORIv5bk1AtkxGclq60jw3d0FUomw=;
 b=QlAAziTs84ufRFx2duRKwII5oaFTZ0ua5sSLDPJ+1jbiWiOMkC5P+WBn/R1RLi5ybb8jAqFBLVqGl8grvJGtwsgRExd8Pyt9ug4T7K4YWiv2huEbUztbLXJrSqSeOGLXkpByUrO1QMzEAST3xH9KXizPaG0dwDRuKdY/e+V+Gyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM0P193MB0562.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:163::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 06:37:16 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 06:37:15 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 01/10] can: kvaser_pciefd: Add support to control CAN LEDs on device
Date: Thu, 24 Jul 2025 08:36:42 +0200
Message-ID: <20250724063651.8-2-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724063651.8-1-extja@kvaser.com>
References: <20250724063651.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0034.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::15) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM0P193MB0562:EE_
X-MS-Office365-Filtering-Correlation-Id: db6997f9-a4c1-400c-c700-08ddca7c8797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BQ5HruP1iygRLi8YUrLyTLTgmU81LYDcDN+oubs91YWBpQAm/LaI0/YmAXuQ?=
 =?us-ascii?Q?CyKpjDcGWw8O0i1S+FQD+dd71bHR+RfD/iryCoLqkt5QaAzVUvd9/6/hLmKF?=
 =?us-ascii?Q?6VudRzRwF0a1zHxyB/n3Q0KefBl3C+7O2sI2q8DV03lMMQzCs4ILwbetnV5f?=
 =?us-ascii?Q?mrZNusv5rNVJe29emp7SmlrRVzrLnq71JIj8U8Xd4zwK9Ae/NGNk9BEISmu5?=
 =?us-ascii?Q?qhvwNErUS4EtpS7ADMbqZQMs5xkKFD5MZuBH1d1ZBW1jeiZdPmfenAJWJsQb?=
 =?us-ascii?Q?y566UqECUEQ87UcCxIkhe2MSs+5Q+lFlJFmuWsOVsJST5DtaZpWqXrqey6Ms?=
 =?us-ascii?Q?5+2EvhXI26ckELEvrp+dWGZZop43GmhkS6rZ9VJi+knzwXpu5MEaurcQxdXL?=
 =?us-ascii?Q?bcGnv5AJiKw/NdaWm1A84/qCIRnWkB37OZHC2S0udEySvv9hVHVmZtU3rEuG?=
 =?us-ascii?Q?jazEI3jIiRximY9dzslEcaFapsi1/8gAxWNZYQn8Symn3/k7UJmmNNdNf/Kt?=
 =?us-ascii?Q?pqDcgVMnRe2y784C+a9eaV7EdxQW4+iCPf8QGNQqa3ksRoIrA8mkIQQN504g?=
 =?us-ascii?Q?+Aqeumpo5QULPIPT9HEmeCqdzBKiv08bEz5u0rz/mi1U5GgR8iyr6qOEqLfY?=
 =?us-ascii?Q?QL60QppVD+dFs6yuJqyGCms756Q/6EU7jlk1qRx54EvrQUuY6jdL9dDt9TkR?=
 =?us-ascii?Q?+JSb7uJh9zTg9G86zBIrRjQKZzaWh6VGwi89kwpBes0rDd9hOLF5VXtuQP+O?=
 =?us-ascii?Q?I/Wi8jw09Pm3fP9qx4ILk2j39qWnUYY/6gpXU9F+kgSK7ouW8hClFiiID9vQ?=
 =?us-ascii?Q?RZwcf+nWUhqGlTvBWxDy8mM6iROE8QIVs120HJgnDcAH1gRkZCqxzE8ECo3D?=
 =?us-ascii?Q?KIE7WLYNHzLsspzZexzIn8hHZJEjg9P3RYoBOQZPa7BXXQc1P/ur57EMsNp9?=
 =?us-ascii?Q?CNX2/xwhbhP6BDp7u9EGlzp3L9nL5NTbzb//mLwwuya1ildMAhzqHLFbUuQr?=
 =?us-ascii?Q?ImyCbjPqwKB59r+t+jgxYMgQzhhL5PEC7qKBQo73zehBLePQB6Qny/LGviSr?=
 =?us-ascii?Q?/1oQXFhsHAGlg/SzJx/oDdUNBSBdQ713Qmeckoj2QuA4cobPIAzbB5h5d1FK?=
 =?us-ascii?Q?rCDcNr3liFUX+yrw84vadynIZ0wV8XtJTCYv/kR3fVkTQnpps1Ok/nTTLbuf?=
 =?us-ascii?Q?FvlFdsp3H/3AlhkX47NDv8356K6Ebyu9SHSWLda9JFurddxUFYjK7UK9IYcy?=
 =?us-ascii?Q?bsuRhq3rzRBsHqVxeQ7/jcKZF3fuEuJEUa+UTIkijEkMw1fj6xjsUaVGxY24?=
 =?us-ascii?Q?8hwQHFOQrqfWTcRzvFLDDX3+9yXuI7U22JBvwHXzQkRD2utBlTZROcpAV/B2?=
 =?us-ascii?Q?OCcf3IUZxg8aAumx2VCt3vFcD3iKxiINSd+nemGvX4MPB31rlUW+506+32sn?=
 =?us-ascii?Q?iy3skWgJOBQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7oZPEataiGnkrjqqm8vFuD/iYMYmHUpKIcGABvgpXGkOSiQPjTRIvQoTyGpU?=
 =?us-ascii?Q?BOVM33cUZp6CgRzRKFe5CbRZ20PrTVgDrWzvDjw5YUltYARXQhJit+MjAn6P?=
 =?us-ascii?Q?7gRwmhcD1I6t/YVqTIofRB/SfUcfpDSm00gixdcL2Yg+KC49bVD7tIOuU9us?=
 =?us-ascii?Q?jsXBWB2Byi0DTVpkoNnwlOOhTHxbi3gMUbl0bq0zC/0s8/2LffGjLVEPD+PR?=
 =?us-ascii?Q?aJnCoaAx3A+QvV2W2IzjTkXTBSeYO7ApIzqLYc2yQfNzNjSubR+JPNgQ4KP8?=
 =?us-ascii?Q?FsiNvPTvn2+Y+8+ylNUTFBsM0BX0rSRxG7P80phmrTGCDRfl3RFG6vKcH4NN?=
 =?us-ascii?Q?gTYNke7ga95SJUlB/r3/+aFHKcoordbxsP99TE3BizNpOEw20yankJzxBkk+?=
 =?us-ascii?Q?c6qRwsk3xSaEmZMgXDYnl5sZG4zQWvJPIFQ9D+EVBcfEO8dRRrlf151+eueu?=
 =?us-ascii?Q?e3jocDpOSY3ldLEfTGmaXT2X6euIVNzDYrBLo8BG46Rc1VcR2b9Pa39OqUt7?=
 =?us-ascii?Q?Y8fxi3PfjaEugJ9A7U4Ms3DRAKZERNGRoH4OehFY1kFp76/UzibmAXRnkprc?=
 =?us-ascii?Q?SxON/ynqFKgUb1fVveFWsTXIhCbAx7AE7pU5fxekEAH/joZ5EkMydJLaQL5c?=
 =?us-ascii?Q?svgKCHWUJglqCFL+qYkCiPSu9Dkhcg42wWPKF38ZgeJ6F666p2MSkfn2DysU?=
 =?us-ascii?Q?wz+OytfmagTxvdflQZfmZCb63UDvSxPe19icbdk2crXJTyS6CoGUUYVl4Pje?=
 =?us-ascii?Q?Nk+JkcP/rh9nqyLmIELceyFOWSN6uCYWt2IJqBgdWX3Kai/ds0sxi3XYaLg8?=
 =?us-ascii?Q?FGNpLD3PKrO3DWQ7a9fjOa1BKLZY1wSrpPGigIs5Ho7R0FqhTUeLyXYgvnsW?=
 =?us-ascii?Q?we6ka/3RRdN5whSX0jXUB/Aj0HKAPzDOZWs4GsZ/aFOSnExKFeLDHxmiOslP?=
 =?us-ascii?Q?SkHIqRRugXY5JCaoXB74UuykikgbuHSz7K4CA5QMHb9mNI8FUDMR42DLHxgN?=
 =?us-ascii?Q?B+NfWVtgwiEqMysKsEDIYMbqnk/SXfsihNEAqsRvC7xYJKNzNqnffGqZ2UQ5?=
 =?us-ascii?Q?HzZK4dgMNtyeeOz3rdEoFtmjt0ksb2awWn0Pozm1cEhpd2H3oFGjJEo8KciG?=
 =?us-ascii?Q?m8ZfBuUYlfEoXPnwCLGi9gdwdwr4A1GsvCtMs4GhmiOi216t6mei3b53bzEd?=
 =?us-ascii?Q?sv+Vf6FBtS3LO/1oMYZR7bILay4a+FWzBz1emaS7Zn2+wqMV+ozJIsbq0vRU?=
 =?us-ascii?Q?35dFaCZqUf4AKN8/OdmD8LTYBEMFPI+RQvUSrFvbLXLJl4iL5otjC1FFkxQm?=
 =?us-ascii?Q?GRwsgjK9WaKpsKi5LHVDbAEoFaQ8Trxpidg2rGdgtfcpUdmMNlFN4qkzxlnr?=
 =?us-ascii?Q?uzMYAJnhfDD3UirmzTZtxNAWIVAHYt0j4/zgDv9VS2xc+RYOmG0sQ/Gwq1D4?=
 =?us-ascii?Q?T6qnyrtxCRhdX9+a8PRBJ0VVuC/rEyGHn8Pu5kiK6t2proEPcwI6Bw3iYMs1?=
 =?us-ascii?Q?krfNnmBY/NccG3VD9TukV6jv5JD0mj1UeCeIf8j5nJlqy/Sqv9Wt5pfXX3LE?=
 =?us-ascii?Q?92xyx/K4UktsWd9i343vzI2PM/8U6poLylfj0BOlTQBqLBIF/xUatXttFHS+?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6997f9-a4c1-400c-c700-08ddca7c8797
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 06:37:15.8714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uN34PWsSso/5rKmH1pXakWD9Ndc25qzUPfWZZFMjIFJcBpsZYv9L+YgERW8pGwN1Zjzs3oKF9FUB8odndVIluuO40L/8sECsMQlNh6iZIrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0562

Add support to turn on/off CAN LEDs on device.
Turn off all CAN LEDs in probe, since they are default on after a reset or
power on.

Reviewed-by: Axel Forsman <axfo@kvaser.com>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 09510663988c..c8f530ef416e 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -66,6 +66,7 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_KCAN_FIFO_LAST_REG 0x180
 #define KVASER_PCIEFD_KCAN_CTRL_REG 0x2c0
 #define KVASER_PCIEFD_KCAN_CMD_REG 0x400
+#define KVASER_PCIEFD_KCAN_IOC_REG 0x404
 #define KVASER_PCIEFD_KCAN_IEN_REG 0x408
 #define KVASER_PCIEFD_KCAN_IRQ_REG 0x410
 #define KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG 0x414
@@ -136,6 +137,9 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 /* Request status packet */
 #define KVASER_PCIEFD_KCAN_CMD_SRQ BIT(0)
 
+/* Control CAN LED, active low */
+#define KVASER_PCIEFD_KCAN_IOC_LED BIT(0)
+
 /* Transmitter unaligned */
 #define KVASER_PCIEFD_KCAN_IRQ_TAL BIT(17)
 /* Tx FIFO empty */
@@ -410,6 +414,7 @@ struct kvaser_pciefd_can {
 	struct kvaser_pciefd *kv_pcie;
 	void __iomem *reg_base;
 	struct can_berr_counter bec;
+	u32 ioc;
 	u8 cmd_seq;
 	u8 tx_max_count;
 	u8 tx_idx;
@@ -528,6 +533,16 @@ static inline void kvaser_pciefd_abort_flush_reset(struct kvaser_pciefd_can *can
 	kvaser_pciefd_send_kcan_cmd(can, KVASER_PCIEFD_KCAN_CMD_AT);
 }
 
+static inline void kvaser_pciefd_set_led(struct kvaser_pciefd_can *can, bool on)
+{
+	if (on)
+		can->ioc &= ~KVASER_PCIEFD_KCAN_IOC_LED;
+	else
+		can->ioc |= KVASER_PCIEFD_KCAN_IOC_LED;
+
+	iowrite32(can->ioc, can->reg_base + KVASER_PCIEFD_KCAN_IOC_REG);
+}
+
 static void kvaser_pciefd_enable_err_gen(struct kvaser_pciefd_can *can)
 {
 	u32 mode;
@@ -990,6 +1005,9 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		/* Disable Bus load reporting */
 		iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_BUS_LOAD_REG);
 
+		can->ioc = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_IOC_REG);
+		kvaser_pciefd_set_led(can, false);
+
 		tx_nr_packets_max =
 			FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_MASK,
 				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
-- 
2.49.0


