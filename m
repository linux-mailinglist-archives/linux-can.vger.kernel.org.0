Return-Path: <linux-can+bounces-16-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B573C7E9D9C
	for <lists+linux-can@lfdr.de>; Mon, 13 Nov 2023 14:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB961F212BD
	for <lists+linux-can@lfdr.de>; Mon, 13 Nov 2023 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A38B1DDDC;
	Mon, 13 Nov 2023 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="k8vmV1jq"
X-Original-To: linux-can@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5F4200AB
	for <linux-can@vger.kernel.org>; Mon, 13 Nov 2023 13:47:41 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2081.outbound.protection.outlook.com [40.107.13.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3C7D51
	for <linux-can@vger.kernel.org>; Mon, 13 Nov 2023 05:47:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UF9fXwXatUR1OlBTGBr+LxE7JCa9zYAatzZi+bW3sHCxUyQ/xztlsgHxb8iFgVLzcgy6PFHnjPZ5PCbfgJPMuZJ5WPYlmALxgjnn48q19CnX63qtILhC9kJsVrn1wnA+lZdjYWnrQC+nFVDv5CqUeVHG+BO6eJiFH6R0wGvIyWboec+5Of32H1bOt9xgTS/2oK/3zgz0PbjSdLQOX4NODvIdIxvC4PQ6KZqRzkyz/uMd29mWgNImnirP9UgAwGkMuNskYt+eJ3FpNAbFNWuaqDB5gm06zjUwE6JMioFlR6muHaUmrD9TK1oib/gveozAf5JPXE8bU/Kk3AqSJIusbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuQqJ29XCsD2COif+Tsfa9Oc1xEsYzxbuUOAsnOCd84=;
 b=c29TgixtA8h2KNtgyLo3K5zpY9e/pCMW7jdm5Id+AzqtcIQHwvn9ByEcdWatNbjb65lhrZNwoV+tO+8dqHuoOXPbWrJjdfpAjCHLqhngQh4XHwVGqlMu2yoz8iMxH5IOo2EKplSJ92UWMhh0MmyAajSiWTxvJD9EdutlWstlZRKpXOKXDxllkWCn6NQal0zwbG55kwjeS6ly19ONtd5W/cBOdwV19QqnJ1Ge8iVMNb7jQziViygde5O3mTeI5u95ulgxSgLUAtU+YrdqZn6acK8yZ2MbYYYrAGSEWx6toV0lA03pL0ZiA9kL8gTFnfCp6FTfGktuF1EMZHgQgzkn8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuQqJ29XCsD2COif+Tsfa9Oc1xEsYzxbuUOAsnOCd84=;
 b=k8vmV1jqCyf23uOhHmy+onGixQes38e7+NITdAvG9zr9QRx6KuAqV3Tu6GNYEodcNrvjrdzWLl5lHxLTadp+NYAMSOK9qW93Voszcy/0EoQgnm0I4DVm1FShMAGRffIGEa3wGaKKgw2xikxsFoeX2hzqe/PYwZp21ZSKqkp+r2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0695.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:147::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 13:47:33 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::cb92:bdae:9647:57a]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::cb92:bdae:9647:57a%5]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 13:47:33 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH] can: kvaser_pciefd: Add support for Kvaser M.2 PCIe 4xCAN
Date: Mon, 13 Nov 2023 14:47:17 +0100
Message-Id: <20231113134717.515037-1-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0032.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:b::6)
 To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB8P193MB0695:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c6b67a-3eb4-4791-6353-08dbe44f16aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yqr1VvbGzqZvkop+p4bKDSySpaHOPHzDMggPpHdeGj+QnSbtLN3Bp4akmjLJyNppDfZm6afGY9sbfmagG3tSRdHaZN3y9zc4H4FzzDDpaJW4t1bG8EVfaQjWmGpQZNytcY8VwEZ/pU/QIAn2dbljGLOpjJEAb6maxtMctIv84JoP1OYDjIDAq7G09vRJAUYILZHLdDbciY76ctdBjmf1eOJZvMXxntuh+mfHfTyIEd8wREOCcprSrzmjhbl2rl9yFzHkKxorCwzO9SpDAsVWMyF1j1DWjcoCu3MWLAzfUPHB4HsLPtF/luMBs71zGlXG5BtXYElHCJLw51wqe53KeYjdppoGwApZpYP5nR32zzbDNADN8pOo4QQbfq1Y84+G4sE2XugAljO7xMjePMNs5uM67iBqhjj4SWJ4M6MACM51w2eAXcYZs2g8qOAGjEpsR/tzapWGRpCgq5Wfl3X9ugmz5U777AJ1vUL3pZ5kskboTwa2wE6yM+bYPEr50978/uTNa8lpm1iO9HmCU/8Pe+MkDH7eBxjd/s4KgADZEPz5S+cD8iBu6Vw/biILTq8Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39840400004)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(4326008)(8676002)(8936002)(38100700002)(66946007)(6666004)(6506007)(66556008)(66476007)(54906003)(478600001)(6486002)(26005)(6512007)(316002)(6916009)(107886003)(1076003)(2616005)(36756003)(5660300002)(86362001)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oApLFUDcLxlSO+HfbHAxnkJW9JFnKLpTZCY+2OyJ+qWxVXsPeqY0PnWF7wYJ?=
 =?us-ascii?Q?AI52KN75h4JVr6YatI8Xpt7fcHs+7FQj4rMPaLOMnh3r2hRyFQxXo5qoNKvq?=
 =?us-ascii?Q?DNJguJcou7MEHbxcWmFdiUic7Tv2qjcDTHgRBA9VL6ohtG12Uo0fL2GCW2Pb?=
 =?us-ascii?Q?I2DxyQwbWSLqtwTHNUoHvtO4VVKuV0JELeCjzBmqBSt4aF97BbzXruun8lUI?=
 =?us-ascii?Q?biSF4lTvUv6WSSiKRuXVu4FY1a75NdoO38fXxtOJcBzUvX6lqiYQwQuMIwmV?=
 =?us-ascii?Q?JMBqLHKOhs6C/mkUgBOmK3KgvWSZdPsN0vKG0SW8YfzZiCxp4zSi5Rv/HI9O?=
 =?us-ascii?Q?MKNKh84u/N1o/tzzgs1uEsZKwmgEm2poi6JHOBndV1REkkYWEW30mgAQd3W9?=
 =?us-ascii?Q?pq4xR8ze21NxmBwKrqW9WVuBCPQ8eeU9Vh653CcztMZWPpKNUS0Jcy45mmCh?=
 =?us-ascii?Q?+o7+AOPhseH56bd2LVdvdTy6YPmpjmkvbELNSqt8DyoyHvclP22ItImJAR3c?=
 =?us-ascii?Q?FLAd9V8inEAG5Jn+TBycHd3CYKlLIBMuHQA088zeAeIESrS3BlvdUpOMKY/w?=
 =?us-ascii?Q?pg2qYCFBYX85NAMlc6LNFLDyyPLhUA4IPtC2B+sl6ItMYO6bgKKIiBESGwh2?=
 =?us-ascii?Q?/m+BIT55mZ+Kvajxma65Wpn0G3g4dU0uk0So0kskLHbPDRF/Bjpm3O5+EQn5?=
 =?us-ascii?Q?b5O4xoVGkD29aMSrXI7AzsHll/p+g24Lbm1b5KsOsdEy3vYdNmdnSpMK06EM?=
 =?us-ascii?Q?vv9vGGSYB3piG2oby4bDBUFXNSyproDdcE5/9V0+PyI+VW9I1SplNb1bY+UE?=
 =?us-ascii?Q?k6x74tQWLWviual4geNlUwlPgWbGRn/maUDgJbAsUhKwV3K5/o/AviTcYUuh?=
 =?us-ascii?Q?efsYB9hraMssC1SLABokAVrdLKYjpYVyqt82CphGp9goclO1KZNIbL9CJW20?=
 =?us-ascii?Q?3jPPz0SxLk2TRfFRshVcr3wb3HR9lZ4e9mlL4YxIjL2MQgMUfMWCBHuMpi1z?=
 =?us-ascii?Q?VLZ6WGeG+b/A0SH+jVK+hO0YDEIAWg5mMbrjXUmjbqsTy8GAXggt8HDVjhOF?=
 =?us-ascii?Q?eOb6vOS+RFTPMlP8PuIne6nIIDUfP9vQWrW+KBv4XqUuTNhPuAzCuqWwcQj2?=
 =?us-ascii?Q?v+uEucZQGBFgOlIOmN6McouMvXUUSKvH9YZnN4/fsaJoKWlAjLDMPVKzMgNB?=
 =?us-ascii?Q?z6IRdnS/ySQNI/MbcVS7s3qtLbwP4v/mqGIK9SAzqPYJYS6arA3O3DJegJKM?=
 =?us-ascii?Q?l9BWKNxyQprXVg0DK5ldc38mmNZqv1dF3HuDe4D5UFC81jaHP3EwiEbr7zM6?=
 =?us-ascii?Q?6E1AYoFxQ9WKZQQ2ZwEM1zqD/52T6D97DMsKm7W0QsdBNWgZVFw0QeGwu5eZ?=
 =?us-ascii?Q?mCklUbyo8lz0IRL8pGE02Bwam1acx+LC5nxsRbz46/zr/BLzHoeoW3UFI8VH?=
 =?us-ascii?Q?58qbjIc5ODsOtaWt2W+x6foRDEOOsXeHVR59ZDaJQ/gRKcXt/g8BWPVIfwSH?=
 =?us-ascii?Q?fYYOcodLEvUIbx4Wis2jkl0bmH4CdsaI/XIm9/at95+nF8+02d50Nx3oqHVh?=
 =?us-ascii?Q?SuzgPtQg4HZoYtOtTbFcO0ved8wsAz0l1FgQdSQ+?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c6b67a-3eb4-4791-6353-08dbe44f16aa
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 13:47:33.7885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /88+E8OEc/tUl/qJ/SIOCbWq55BTNDbskY4zvWavn5YwYZ9VZ/EKrL/KRJ88JgpArcZS2BJyN2M3HcTxkprm3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0695

Add support for new Kvaser pciefd device, M.2 PCIe 4xCAN, based on
Xilinx FPGA.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/Kconfig         |  1 +
 drivers/net/can/kvaser_pciefd.c | 55 +++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index eb410714afc2..e18263bf3e0a 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -168,6 +168,7 @@ config CAN_KVASER_PCIEFD
 	    Kvaser Mini PCI Express 2xHS v2
 	    Kvaser Mini PCI Express 1xCAN v3
 	    Kvaser Mini PCI Express 2xCAN v3
+	    Kvaser M.2 PCIe 4xCAN
 
 config CAN_SLCAN
 	tristate "Serial / USB serial CAN Adaptors (slcan)"
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index a57005faa04f..416f10480b40 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -47,12 +47,18 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_MINIPCIE_2CAN_V3_DEVICE_ID 0x0015
 #define KVASER_PCIEFD_MINIPCIE_1CAN_V3_DEVICE_ID 0x0016
 
+/* Xilinx based devices */
+#define KVASER_PCIEFD_M2_4CAN_DEVICE_ID 0x0017
+
 /* Altera SerDes Enable 64-bit DMA address translation */
 #define KVASER_PCIEFD_ALTERA_DMA_64BIT BIT(0)
 
 /* SmartFusion2 SerDes LSB address translation mask */
 #define KVASER_PCIEFD_SF2_DMA_LSB_MASK GENMASK(31, 12)
 
+/* Xilinx SerDes LSB address translation mask */
+#define KVASER_PCIEFD_XILINX_DMA_LSB_MASK GENMASK(31, 12)
+
 /* Kvaser KCAN CAN controller registers */
 #define KVASER_PCIEFD_KCAN_FIFO_REG 0x100
 #define KVASER_PCIEFD_KCAN_FIFO_LAST_REG 0x180
@@ -281,6 +287,8 @@ static void kvaser_pciefd_write_dma_map_altera(struct kvaser_pciefd *pcie,
 					       dma_addr_t addr, int index);
 static void kvaser_pciefd_write_dma_map_sf2(struct kvaser_pciefd *pcie,
 					    dma_addr_t addr, int index);
+static void kvaser_pciefd_write_dma_map_xilinx(struct kvaser_pciefd *pcie,
+					       dma_addr_t addr, int index);
 
 struct kvaser_pciefd_address_offset {
 	u32 serdes;
@@ -335,6 +343,18 @@ static const struct kvaser_pciefd_address_offset kvaser_pciefd_sf2_address_offse
 	.kcan_ch1 = 0x142000,
 };
 
+static const struct kvaser_pciefd_address_offset kvaser_pciefd_xilinx_address_offset = {
+	.serdes = 0x00208,
+	.pci_ien = 0x102004,
+	.pci_irq = 0x102008,
+	.sysid = 0x100000,
+	.loopback = 0x103000,
+	.kcan_srb_fifo = 0x120000,
+	.kcan_srb = 0x121000,
+	.kcan_ch0 = 0x140000,
+	.kcan_ch1 = 0x142000,
+};
+
 static const struct kvaser_pciefd_irq_mask kvaser_pciefd_altera_irq_mask = {
 	.kcan_rx0 = BIT(4),
 	.kcan_tx = { BIT(0), BIT(1), BIT(2), BIT(3) },
@@ -347,6 +367,12 @@ static const struct kvaser_pciefd_irq_mask kvaser_pciefd_sf2_irq_mask = {
 	.all = GENMASK(19, 16) | BIT(4),
 };
 
+static const struct kvaser_pciefd_irq_mask kvaser_pciefd_xilinx_irq_mask = {
+	.kcan_rx0 = BIT(4),
+	.kcan_tx = { BIT(16), BIT(17), BIT(18), BIT(19) },
+	.all = GENMASK(19, 16) | BIT(4),
+};
+
 static const struct kvaser_pciefd_dev_ops kvaser_pciefd_altera_dev_ops = {
 	.kvaser_pciefd_write_dma_map = kvaser_pciefd_write_dma_map_altera,
 };
@@ -355,6 +381,10 @@ static const struct kvaser_pciefd_dev_ops kvaser_pciefd_sf2_dev_ops = {
 	.kvaser_pciefd_write_dma_map = kvaser_pciefd_write_dma_map_sf2,
 };
 
+static const struct kvaser_pciefd_dev_ops kvaser_pciefd_xilinx_dev_ops = {
+	.kvaser_pciefd_write_dma_map = kvaser_pciefd_write_dma_map_xilinx,
+};
+
 static const struct kvaser_pciefd_driver_data kvaser_pciefd_altera_driver_data = {
 	.address_offset = &kvaser_pciefd_altera_address_offset,
 	.irq_mask = &kvaser_pciefd_altera_irq_mask,
@@ -367,6 +397,12 @@ static const struct kvaser_pciefd_driver_data kvaser_pciefd_sf2_driver_data = {
 	.ops = &kvaser_pciefd_sf2_dev_ops,
 };
 
+static const struct kvaser_pciefd_driver_data kvaser_pciefd_xilinx_driver_data = {
+	.address_offset = &kvaser_pciefd_xilinx_address_offset,
+	.irq_mask = &kvaser_pciefd_xilinx_irq_mask,
+	.ops = &kvaser_pciefd_xilinx_dev_ops,
+};
+
 struct kvaser_pciefd_can {
 	struct can_priv can;
 	struct kvaser_pciefd *kv_pcie;
@@ -456,6 +492,10 @@ static struct pci_device_id kvaser_pciefd_id_table[] = {
 		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_MINIPCIE_1CAN_V3_DEVICE_ID),
 		.driver_data = (kernel_ulong_t)&kvaser_pciefd_sf2_driver_data,
 	},
+	{
+		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_M2_4CAN_DEVICE_ID),
+		.driver_data = (kernel_ulong_t)&kvaser_pciefd_xilinx_driver_data,
+	},
 	{
 		0,
 	},
@@ -1035,6 +1075,21 @@ static void kvaser_pciefd_write_dma_map_sf2(struct kvaser_pciefd *pcie,
 	iowrite32(msb, serdes_base + 0x4);
 }
 
+static void kvaser_pciefd_write_dma_map_xilinx(struct kvaser_pciefd *pcie,
+					       dma_addr_t addr, int index)
+{
+	void __iomem *serdes_base;
+	u32 lsb = addr & KVASER_PCIEFD_XILINX_DMA_LSB_MASK;
+	u32 msb = 0x0;
+
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	msb = addr >> 32;
+#endif
+	serdes_base = KVASER_PCIEFD_SERDES_ADDR(pcie) + 0x8 * index;
+	iowrite32(msb, serdes_base);
+	iowrite32(lsb, serdes_base + 0x4);
+}
+
 static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 {
 	int i;
-- 
2.40.0


