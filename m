Return-Path: <linux-can+bounces-4036-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F09EB0ED48
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DC49619CF
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78F725A631;
	Wed, 23 Jul 2025 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="j2E+WLuG"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2127.outbound.protection.outlook.com [40.107.20.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CA7279DB2
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259593; cv=fail; b=XKveLrcZQsmCpeN9FcL1aBMeurJnc1n60JDV7CZsiNUPKq+cN1vnvyhMbacfdn1kckXopqDC1uB3DtjS28xCJh8nR0NhOUpkaZeRfgMpfVJC2WIPkbEevh62V/ZhU+MXq5s7wk8XUZojutVbInH1iLUFvHcRhQW8uOwJxBI9eYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259593; c=relaxed/simple;
	bh=T/gFUfs5FQZmyGzxf2eai1qV+g4bTlKwnWe/OKLS4Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dtm+Th94pPCYg8ywwG5Yb+naqCsa/ewOIItEEF7571i9NWtg2wXl+u5/FZjPyZUCWDqgv8XNeurEIsPRcT4Z2kSbtyvlL6f+kY+Y+ng26GmXEwtQAlzggGyF++aCsIDoksarcqDTFufqOZXrVfq6rJvJk8OAbYWya4YcEgiOK3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=j2E+WLuG; arc=fail smtp.client-ip=40.107.20.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gtm8vj/Hbl3IVXzMYPxaRL6sdEk82hlMSxCcJJdCPDD82AfQHgrqIzn9ta6R67M4O3i374vP34Mbm5STZp7P83MEcdCXippDf2E5YZmCebfHWMUqgE2PbkIJwaSSLzJEBRtWvkXukv3YlOfPCM4N1r/zM6rVu97/si0FSLt0rZqd69gOG5OfVBjS3iWtMjhOnXTAVFS39AYyA5nW3Lim3Cj9C+wrf+ZO5p7BHAStKc3byrQqYpZOU5qpgS4uneNWKdPjzBKuajmllCAfHrren4p4Mrp2N1K/kcTMDY+BAEc+G99dQOeMB+1DsL4LFJRxYO2U059RaBIt034oJof7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViaWm8i0Pgd7/dVORIv5bk1AtkxGclq60jw3d0FUomw=;
 b=Ro4ElC8O6r7LJlp1vQXSbpIWrLcn9KxFm1Q+hyTMm31LNLTIsffcRajZJM4e8Z99EhaH58Ahm+LXGVInROyAOIF/Zi0agISo0BeWQxYib7W6zD6IxgTCQjDYgqiwxiUa5mnUjdh6ZzN/Z1rNlkDmQ7ScXk70mFIPW/6Ik8IWnIRdZnMO09wIMlWCE5HlrzDt5Dw7F2bo1i1NXxX7fK3/6hMCERxrIr2KV5o4VilKkTF/35oy5fRSRtBjP5dtrOZHweS7XWKCd69ji7540hCp9ffzXP5hAsZ7wr2oOIanpwmblg32zAGmypBd8eIPBlz1UFT7IsCqh5TcSGEMz1SCrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViaWm8i0Pgd7/dVORIv5bk1AtkxGclq60jw3d0FUomw=;
 b=j2E+WLuGmadrtUIP9xFZ7D0jV2Asb0F0xnzQw5WlVfBTr6NeFy0oaqLazk7Cf8vth3cF5omh/DhT/GyyJKVuiBfJCaN/zdMDg1h8r9o+JneZ23ZRwgHmQ+r5AQaMP2QKloOMBxe7F0o11o8dB4390w5Jxo/8jxiyAlY3AXlwHu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0773.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:33:06 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:33:06 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>,
	Axel Forsman <axfo@kvaser.com>
Subject: [PATCH 1/9] can: kvaser_pciefd: Add support to control CAN LEDs on device
Date: Wed, 23 Jul 2025 10:32:28 +0200
Message-ID: <20250723083236.9-2-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250723083236.9-1-extja@kvaser.com>
References: <20250723083236.9-1-extja@kvaser.com>
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
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB8P193MB0773:EE_
X-MS-Office365-Filtering-Correlation-Id: d08f7181-c844-41db-55b1-08ddc9c38c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8L27AVKpcNRlsYd5D8pQeRUq0cH1uQiJJnV/gtkeeBAUsPCuw+mV1ZddMqkN?=
 =?us-ascii?Q?dGV9VKl55iNfQMS17a6ZPZz32W0IWeW6Emyd1hbOqTY6rMXon0686Xp2BPP0?=
 =?us-ascii?Q?Atab2LCS1PPTYxUwSiwuoIakQaDSIu8WcbSNHCUAjRdaF+XgN63zVTQM/gsB?=
 =?us-ascii?Q?87bVYlue4iZgo7VHg45Z0Y6hNuRVhEYzIuHieNaUregRtaWMhH/SRLwxegMl?=
 =?us-ascii?Q?ANxFZdISobD9PtR7y5zzr/IsCqAUetMk07YjRSaWTJP11BTEbtheG7fVio9f?=
 =?us-ascii?Q?PSohT8t4RsGHpvzA1zznXCHbdIL3QPF2DT340FIidouJk1NovTzoYtE5Dv7T?=
 =?us-ascii?Q?4vD2v3B6SwgJws8v4VHbQA5HdtFXdBaElXZDBCcpcdGyt3Uu3BrP1EpPDiQx?=
 =?us-ascii?Q?XT34CvQxkUVbRZMXlic4RLJiva/3A51y3l3KvNXc1OrINvThf38rLe5VqR4n?=
 =?us-ascii?Q?SKW/LOALHkRdjmEBh3xVJ2X3vU57CqnsgllbdelVFuu7CugntR1biBIAcYbk?=
 =?us-ascii?Q?UqBRAGoEjwd6Q++fSQi9AdmT+sJpWHCk2w9qP2qQDG1KzsW81A4K3qsxIUzZ?=
 =?us-ascii?Q?o1vKmETexAFOt63HJtMklUB9MW4CIip1obA+w52NVTMWu9ZRLoDcgpkYv5ld?=
 =?us-ascii?Q?MYCKDLoAPgop4zSS7dpQAGCsmeSxCdVxaAEUvBq4Hp70YxH6rP9Y4LJMQPme?=
 =?us-ascii?Q?RUwE+ZwGV2sfLUJB5Q9agvnz+ZzckM6mlKiray7CQkaab7hn2udId8swWimA?=
 =?us-ascii?Q?9xrCI5wrlX6SzfvPieyXEFslTnY4uJYD2ImMGN1pKr5duZqN/kMvVN7fL8oS?=
 =?us-ascii?Q?jjCacGp1WuRfemVOSuDbrpNp8FtQ8pRx2GAEYi923pdsSfQbV9cmO/+DCFE+?=
 =?us-ascii?Q?OjBBiDnFjsXVId6oppgwxO5uauFcnGoAL7cSGV7j8tAuj5MZKFwKcTuJBKzr?=
 =?us-ascii?Q?Tmso224+PLPIWBtjEP/750X7dK2jTAO5hmMJWoOBTzL/r+srUS8Fz2K96vRm?=
 =?us-ascii?Q?QPgqStiUNpAioWwQcrrSYgtEpgZLYbntGKx8IONenw3ZmQa5dKhx5AbDIzLT?=
 =?us-ascii?Q?WI/AuDgJBZT01orpkZNdfLiJ+3hEPvDwdu2OydqVUYZLT64bFa1RBG/yCk3K?=
 =?us-ascii?Q?k9aRgGElu5wwTiBsiTbOOKLZdnye0bBZ6qbJRlpd+wYoqbRtb0e9nXf0kTdo?=
 =?us-ascii?Q?UhRusHZC9cGVRIMTQodKYnbCNYzt0xT/KFixlJwV3KzcO9Ci7WMUG+rjEjSe?=
 =?us-ascii?Q?vMenAuk9euA4KIVfmQkrp/msYz2EZwGFVMoVnnLvbVV4t3WwJ/apTirZdFO/?=
 =?us-ascii?Q?uxKYpwKqDhys9LO45ad8joH+dXuN52LX8xicKam1OLj94PDL6pHQaJR6LpAv?=
 =?us-ascii?Q?zIMNxi+u8tJJrffNm6HL7VpeC2l89UpooguPlUpTI31Gqyu/V1ZrciGhx7h3?=
 =?us-ascii?Q?oIEhLtaEcE4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FAeVnEUsc8gQ+/i4hiqFV0xxjbbHVRM3xZ665c9w9w/w3R7D5fS9LjRP3Bqf?=
 =?us-ascii?Q?bNhxBV9glKTipm94PNKznAp/GSSOGPzEnf0pGbQRE1IYHz7719o27paC1NBJ?=
 =?us-ascii?Q?tJw09/Zizmm9IuNnY0Eyyyhiq7djqhF9V3RRvuEbLjHjzSfKZX7zRC/RBRIy?=
 =?us-ascii?Q?CWnt9Ckg8RdYzqk8bsyEDqEMYuoDG0LwPd54gLwj9xj2c+xYEe42uGdE8yvs?=
 =?us-ascii?Q?3wEmhYOAT6KSo19Y6iyYgQ5JDBbX7CtVenuqqjxG8w4peFe5f5qNvz75S9KE?=
 =?us-ascii?Q?Cmjs2mUm5mh30Tbfmn9cHqr56M9G9lKEDxr/6b7a3WoI6jG48J5uOYR0J4YI?=
 =?us-ascii?Q?GfgLSpA1ITJLf7ntpZKOS2lKgkA3BFL5XhePxmJSfEsOs2GR8BtfGsFoGlOQ?=
 =?us-ascii?Q?0zmHwuVQhPUmZsEZuA58FV7oW17qVxb7nM3fmBEBtfB0Z/k9FrvXJp3OgxFq?=
 =?us-ascii?Q?GqvxSfE2OfGDlYmgibMQ7/u4rujGOJ2I4L/kaHy3PohTrooDx7NWNH92IitV?=
 =?us-ascii?Q?y12uqNCsadpL7UPLd08vNsLuB77wewd93YsD54avNZzOQIMD/CXhUbl9FXac?=
 =?us-ascii?Q?QbRDw5NiZst+Jb0sNHhYtAbvyff0QJyJqszvWl1Cu5aHursxrrtzajlz5i7Q?=
 =?us-ascii?Q?AgtJOTJ81luNTY9qqt/FbjedknHEazOuk/TszOaQcqebqE30H7RLsUUEVCib?=
 =?us-ascii?Q?SjGCTtLlEYWBhSLPYRizAM0EkBoKUonFyeMLRGcasAgtJBgdaGgEyloJgBwc?=
 =?us-ascii?Q?6FRs1gcVVEtb8N9SeSQ7egh3ZsRr63zU4WuA4gNcSQuiII0USbxh4ITD5P2j?=
 =?us-ascii?Q?XtyS2nEU4wOKFgTYOwS9qes24pfcpl1otkvbEON8uPeX/bg/Wqkqu3B9ED0M?=
 =?us-ascii?Q?DiVxB23LepKUHnl39Ek+u2VImc/caufLi70h0svBjd8G6zIbErVmr9QUiXuF?=
 =?us-ascii?Q?QckohXszwhCHLYf3TSLn5OHQVBKONjULlsLwJpBpPs+LaCmCmxuSDYTMy6OU?=
 =?us-ascii?Q?8wnjQ+k0IF2PhcM0oezDZflU5nQGIGXNwTcJAljSimuKVFJsXJeFTL0GClV0?=
 =?us-ascii?Q?y6ddbG7RMJseHOzPg/yAepe9wvBquUAWMSpQFSMySq9zAuUMT2wPAptks09p?=
 =?us-ascii?Q?3g/tysFNLyYrrO3X3iDtUPrZ8rB0gtlGMo+6yVAjL0ftoBfxUKviYnH+7w6P?=
 =?us-ascii?Q?mobSDiX/HfRULoh6fpIs2qd8plUDGJ51Wj9oo9YwWbQLMoWmXOo6cZ4qlnFm?=
 =?us-ascii?Q?WBXi4n4jdk4Qp98MD5zZMhoXkBs/VG5xsdPlvZKQDhNfYNC3VZoN/vp9E/mE?=
 =?us-ascii?Q?MCc8IZR7AJPrSTKeSFBS6c8wBpzUMm4hDB7SQvTOfOyVoCn1mEm/FhFkhSkj?=
 =?us-ascii?Q?3ZsUHjwXnoSN8V7nzOHHWSDYnidyMeXYVV1XinZr2KFJEzHI5p/7/6WNPtel?=
 =?us-ascii?Q?W90GwjovnbcPyonsLd4uKsOfKEHcoj0hEirI/GLPuuqC06FGPe8MFOmOpVQe?=
 =?us-ascii?Q?+Thqk9ORw3cNigbUAX7VR9pVlgQq/yDNmamV2t0DjXKNw9vaDsNEu4QmNQry?=
 =?us-ascii?Q?EIFOxmLzw1D9oto5qtL2VLScM8Ehh7MWiN1BVWNIUkmy7134mzaViUDqX8yx?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08f7181-c844-41db-55b1-08ddc9c38c48
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:33:06.8108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWfNxaMuFsahKR50WJeJlYiB3Fibcjf9MM2eUvRnoxwlgunH6LdBw7mysr/DeJJxBczy+ch/pKPIiCjdBdXc5yNTakvNxzfDpzX3Ftc+r4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0773

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


