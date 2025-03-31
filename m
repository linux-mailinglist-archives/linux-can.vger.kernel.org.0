Return-Path: <linux-can+bounces-3297-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E43DA75FFE
	for <lists+linux-can@lfdr.de>; Mon, 31 Mar 2025 09:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BE1188A419
	for <lists+linux-can@lfdr.de>; Mon, 31 Mar 2025 07:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFB81B0F1E;
	Mon, 31 Mar 2025 07:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="Y0Sx02lL"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2138.outbound.protection.outlook.com [40.107.247.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA82F1B4138;
	Mon, 31 Mar 2025 07:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743405950; cv=fail; b=KEybaPv8JHUvga1eqLUcXDTFGUXkKTOnHb+wY4n0CwfJWPL0GsN0GpLXJvz5VKDdQyZ3thoo7H0JSNlq6cdTGGZ6u7CmbpXWgwlcVqMDOV4dtGGJ3HmkXo6YbHHcsByfvZbP1yC1IohEKOMfmivkEUgDfVPSKG9Oo7J96ut+gDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743405950; c=relaxed/simple;
	bh=+QcD5zUzBP0rGqUxYIEbfrqmzzAPnW8cRn2Lo5qxrL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qvwUEl+x2DED5AcuHfzMu1v18LV67Yzzt7akoUHLLFw4aLjMTPOundaF+5ahcoVlR05V1kVDhYgDmYm+58nYIZfigSS8WansMwgHZKjLACY8/7acHxW4TwwQwfRMqpiiTmHWBatDWEptzeOgXUXsI8Kboz/0PZzSC5xPiNEXsRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=Y0Sx02lL; arc=fail smtp.client-ip=40.107.247.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJqSdie+Ym+vJqp9xwLvqii4UvUnBvXKTv758jBh9jDNeyqrOjTglla4I/b+w11M8tivbaN3cxqA777kOB41PsVxNmz4pKQU/zWh0T1w6uW4apoYRi3SSuCwTsnaGbf2TL/CuFMmDwv7ITWbRma8KHpBXfB0sKOqw4pqI2k0S6/HLcgqjunTaEFbEaj2my/TJCaf1G/XacwnSLVleHe1H7XZjNlKcj5Q8HG21KxO8/2CwY7dtKAeJNxE6d7CQbopwV9hqnQO7sOd8ARjnaI3m1ABNawtvrfWIUfzmCGYZdQMbAA7wCIKY80gLon4x9depdB2+elhuL0KFvQv+TNwYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbdQ5g8F9f3YktDY6MEljvOviBKVKZn/H8RuA3KV+dA=;
 b=UEb186CTGZM3fuwd3ZpO84zj4wPiTA8CzVYW8mcAOnvDvmrjVv4Mqu/De+/GSa9zSDaSgGcID9398ByjEs+V/uvsbr/clapfdXw9NpOf8WmEDzLOJQjiQuMf3T9g+e38yCEV248FmOWqzbeml9bT/bFuFZNHifDP/AkllQG2DAyKE0C6XhgFzEVIZd+NIno0aDewqUw6hta7mKu0ofXriOroFt0RUVdPaoc2plMYP2DFpfW23H1NrdB+j5jRJXz/dpJdZPzht2Cta4vGMkTVW42c14icUQq+ZuYLp3cWrRi/BVoIlrZc4H3s0nj1uLs4K+Y/96Kpda/CzlyeBr4MEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbdQ5g8F9f3YktDY6MEljvOviBKVKZn/H8RuA3KV+dA=;
 b=Y0Sx02lLWt/TPzRuhq7OjM8SJkiNpVUwnFuImo8REWGzr4qdccAzoRBMjvluuzwpQE+r3XoHZKgvT3pFSBUNhBTB18RlgqeL5eVRuBXiKyaKP4ugac1wWpQ5dep5Cs0lD3rzUzhqsk/BPiC3EaJTxwXo6i9tezyhF7dNdCFmNSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::14)
 by PAXP193MB2428.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:22e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.19; Mon, 31 Mar
 2025 07:25:43 +0000
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18]) by AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18%4]) with mapi id 15.20.8606.021; Mon, 31 Mar 2025
 07:25:43 +0000
From: Axel Forsman <axfo@kvaser.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	Axel Forsman <axfo@kvaser.com>,
	stable@vger.kernel.org,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 1/3] can: kvaser_pciefd: Force IRQ edge in case of nested IRQ
Date: Mon, 31 Mar 2025 09:25:26 +0200
Message-ID: <20250331072528.137304-2-axfo@kvaser.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250331072528.137304-1-axfo@kvaser.com>
References: <20250331072528.137304-1-axfo@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0114.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::11) To AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:3ed::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1652:EE_|PAXP193MB2428:EE_
X-MS-Office365-Filtering-Correlation-Id: 9052841e-cb79-4322-ee62-08dd70253f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0FsJCCYG8gDPVkGBMxQukfMYWxpGGBlhMIzXn4FI8fLTMhyl2aj6yIGHQFQY?=
 =?us-ascii?Q?QyRaf0zXZ166sz/V6mTZB2WFuR9+/SQRlVX2XGMBB79BBUPTgvtlACYtQmY6?=
 =?us-ascii?Q?MxRal0dffDlOlXTHpywaG9LYtOl8b+8pnhq+lH5qFb44btELSHOhfvheADtd?=
 =?us-ascii?Q?diOMCClrvQtcxeG9e46Cny7YjnlyJoYsMfwZavMt4rcT7HOpnkWa5JHFCibk?=
 =?us-ascii?Q?1Q27noF4CaJG763ddWCyVAmVWZbgWJY3prBlDwR0Oer+s7YKw9BhxH60Ak2w?=
 =?us-ascii?Q?1JVbXVRxFvq4xtm6D1dO10huaREu/WNi19fREIhYzfMeu8GllfdupS+RN/vc?=
 =?us-ascii?Q?SsQQXsToerSKIo97r4uXTinisj+C9W4GDMYqbugATWUgTh8MaObJDtpSx2GZ?=
 =?us-ascii?Q?Oxly75My2LLSzzHAGPcyOtCXFe4Rbn8fce45Me4f2jXRpCzucv7jax+X11a9?=
 =?us-ascii?Q?geoTQXPJtH7/fIQICw36lcu7J0JMJhdDfUs+VrAzT4w6cyB9D+DMJFjxufah?=
 =?us-ascii?Q?dCljvjKba4tnhjXWFlc4/UtHuNG6PLKomG8lePIoffMttXaJmIvsFderxSm2?=
 =?us-ascii?Q?8yrA6jZO0fkdlR7aLmeyLyT8MGSwtAnC8E+mG0HTuAufMjUZ8zUt1C2iMRj6?=
 =?us-ascii?Q?wN1g58MuhXQqFXBFROZyITvUevczIq0UnimLwW+HEKFSeG3LDPwfzrJ61Jzv?=
 =?us-ascii?Q?1K8KabjoKT+V7tEGCoR1PEjAsoEn/JC4GAJWTd5SRoV1OTN+nKOPAkpJemCD?=
 =?us-ascii?Q?dKJJDz9UjfsPpkaMbZlV5yoKcKC/6h5MrXPu1tdYPQLR5z+0ka0Bt5GDJSNf?=
 =?us-ascii?Q?zFT0I1hKr+XWyfe/Tq5ICXopVMTTQswmR9Lz8H2YNUkKP3fJw1ewnm5Ed0PG?=
 =?us-ascii?Q?mhlUD/kVZFfanOH54OtE8ZXLuyZmbZVp3Y8ItIXsOvBGwWZMvIy0AQ1c8Lgk?=
 =?us-ascii?Q?0sFEd0b6JpW52XtOwnRuB4gNPgaoRw5YbHeS5CjHAJTCJs27ZtlSJ6Ogs7ap?=
 =?us-ascii?Q?fswkWERjAuCPTfCF/GiCGuZQnVY+HukIHGBkrI8+D/nTTFoPYBraUN5RjpH9?=
 =?us-ascii?Q?PcLGU1AQqd7jp6sjmlnulHvjU+YfKQX0rzrMPj/4cNkiJK9OIrxT4yQlds2n?=
 =?us-ascii?Q?k+976R5o3sAMKnD1lvFFUE9lAs5OldubJ2DC5OCY5kZT/vRjuz1g/jZbmF2u?=
 =?us-ascii?Q?FzB32ZbcKjuMPllxXEhmo7klPDYtFGfTcQNFzNDCItDUYCSilLklPX1MDQEw?=
 =?us-ascii?Q?7cQz353MvkWEBKbFsiW7OcuGq6/rEUNMP1cXVx1AKYiB+oDgKMhTdIbTVm0e?=
 =?us-ascii?Q?oXCbUF0H6jyo6I5XGNXy8zVoHpzG3MTG8CTnCsSS1XOs1+aNRd9FCvo7ysye?=
 =?us-ascii?Q?xIt72mONEOeQbiqRK7Nqn3I1pjNA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1652.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bstMGC965ev8um0Bfu0VuVjy9FYkYCY2akl2WPWtd3naGAEh/k5ycWd2iBII?=
 =?us-ascii?Q?uOUPO/TgawV6zj0H+Nu9vnn5AtslI9dCJyvu2lUTGyiR4HG8uePRelKoqyN0?=
 =?us-ascii?Q?Sr7APEa/l3Atip8zj4xnEh2RkNU2d1A3w5G56SspQvoqvcqHiOSxF1z3af1K?=
 =?us-ascii?Q?8QTMZAKpM2z77UbSyORNYrkVPgaPt4+Hpl6j+sbhNAPrrETEysYqjQZu7a+L?=
 =?us-ascii?Q?2uCyBjale0IOapBxkeFV6QKkkMnScaZE+XygcY1MtLYF6sAr0Mu/d81OLWpK?=
 =?us-ascii?Q?VsM1sAq8IWJxDWHa1etYc928qLaTKMuQJek9P2zl8qwWi/S0JRcGFpF5MwjT?=
 =?us-ascii?Q?e2dNeYvEl/qbcMYbenyLbCMXvUib08SsP/MNuNHpXSOL67DwGHCw6xKU3k2O?=
 =?us-ascii?Q?skLHaAS2oBU4HlbvJG+TJg/J+skJDzddYOhOail34GkHSlTxo7BsXy5GEQSB?=
 =?us-ascii?Q?iDnCrdtzB5rNHbMAGhKsJnpF56CE5W7pjHu4LyILr9g15yDMK8d6j5kWtW8g?=
 =?us-ascii?Q?qz/jazflSghQNgHBhgm9DSDmr+3R8ueWdCW5Zs7uxFyllCK5t1Gf2jQ92TnS?=
 =?us-ascii?Q?7KImkR+pRaV986vydmBl2nDdNOFAy0zrt+63YoiVY4eUJVCEij8MADZHfzRj?=
 =?us-ascii?Q?dRG8AenmFFnW5x6KxdQ6TL4CtOU7eGwuRJ4kiLZlsManWdkx38kW65QBIyze?=
 =?us-ascii?Q?ouG0+wsbxqtBK96z4Z/ShlAnLBt7kZOf0FFtrEO2ePiyWxz7xLUP1k46W0rI?=
 =?us-ascii?Q?4OFBx1gXeeubAMtx0tlnvzQWsKiiQuCNwnIjWIuD7eDG7VOmm1sG1jnPcoME?=
 =?us-ascii?Q?up/8kh2GkDnnqa5EhdNwc8qawHJ0nz6IbRQ975bIYaYqDENwMypd78SYDQPO?=
 =?us-ascii?Q?wiFtyHWNoNLKVh/7FZyY+5gohKxo9PJ/8h4YNy480z/JmK0jUWAESfP+bwMX?=
 =?us-ascii?Q?ghJVkQncXJmIG1aUTR5lJjk+zxn+eSl2lfAnJ7+os3mkCAEwhERgVpINxE5V?=
 =?us-ascii?Q?eAZzPt/DeuIUwQY0uBfmmC7my9W1XnTTcssUwZhshJJTMpbmMHjBLW+ktuqX?=
 =?us-ascii?Q?TLxlbz3mRb0Kr5ixEAvEBl6/94bNlIingXaYch04gkhweve1+zcyzlqdQgE2?=
 =?us-ascii?Q?4w2mAc8jXF/ONTrk0r9BBROca2qqstUL8sW+ig2Zuukyonrox+sOsRqMa1fg?=
 =?us-ascii?Q?LOdt5Srn+uhNnmQcovgqOLjhZsJihIPFxEtRgwwj88HaUNwX6hcE/lqC9VyJ?=
 =?us-ascii?Q?WTsfPbE0tYQP3LAOdMJGA8yOpZgsCryohG/xxpA0lOj9Qo6TsIOn9/mH+ZZe?=
 =?us-ascii?Q?9c+I90eD+xruQiuO0ZkNc7sV7XXbtm7xNRRKnbLzDLneo90Pcxb2lOyPgjCj?=
 =?us-ascii?Q?cMj2K5iGYSO8MS149KsbuSUxvdczBydvAvNK+iAIKoF2lpePNTah1gRXOU7r?=
 =?us-ascii?Q?dYk7E93WVmifDtZ1CM9VixdY/RB0WN71y0XvaszwtwZ0TJC+R6cAMzbqeIs4?=
 =?us-ascii?Q?HpGcuEFt142Gg9Sth+8wJ5wch755BLDS231vXBrVt5WYe1efZzGgYIiPAmIP?=
 =?us-ascii?Q?k7wWlTVs4ADNa0UMl7CWHIjB2wkiu5NLKZg6Zp6Y?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9052841e-cb79-4322-ee62-08dd70253f0c
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 07:25:43.1666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVISeCltvg5Y2teRATBR/ykJQ2CXztof5w1AdVKdbrnaTyTevw7UEsYMuZcc9X2QPskEpbiQB/riwpJ23EkWSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB2428

Avoid the driver missing IRQs by temporarily masking IRQs in the ISR
to enforce an edge even if a different IRQ is signalled before handled
IRQs are cleared.

Fixes: 48f827d4f48f ("can: kvaser_pciefd: Move reset of DMA RX buffers to the end of the ISR")
Cc: stable@vger.kernel.org
Signed-off-by: Axel Forsman <axfo@kvaser.com>
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 83 ++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 44 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index fa04a7ced02b..0d1b895509c3 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1646,24 +1646,28 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
 	return res;
 }
 
-static u32 kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
+static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 {
+	__le32 __iomem *srb_cmd_reg = KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG;
 	u32 irq = ioread32(KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
 
-	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD0)
-		kvaser_pciefd_read_buffer(pcie, 0);
+	iowrite32(irq, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
 
-	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD1)
+	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD0) {
+		kvaser_pciefd_read_buffer(pcie, 0);
+		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0, srb_cmd_reg); /* Rearm buffer */
+	}
+
+	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD1) {
 		kvaser_pciefd_read_buffer(pcie, 1);
+		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1, srb_cmd_reg); /* Rearm buffer */
+	}
 
 	if (unlikely(irq & KVASER_PCIEFD_SRB_IRQ_DOF0 ||
 		     irq & KVASER_PCIEFD_SRB_IRQ_DOF1 ||
 		     irq & KVASER_PCIEFD_SRB_IRQ_DUF0 ||
 		     irq & KVASER_PCIEFD_SRB_IRQ_DUF1))
 		dev_err(&pcie->pci->dev, "DMA IRQ error 0x%08X\n", irq);
-
-	iowrite32(irq, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
-	return irq;
 }
 
 static void kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
@@ -1691,29 +1695,22 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 	struct kvaser_pciefd *pcie = (struct kvaser_pciefd *)dev;
 	const struct kvaser_pciefd_irq_mask *irq_mask = pcie->driver_data->irq_mask;
 	u32 pci_irq = ioread32(KVASER_PCIEFD_PCI_IRQ_ADDR(pcie));
-	u32 srb_irq = 0;
-	u32 srb_release = 0;
 	int i;
 
 	if (!(pci_irq & irq_mask->all))
 		return IRQ_NONE;
 
+	iowrite32(0, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
+
 	if (pci_irq & irq_mask->kcan_rx0)
-		srb_irq = kvaser_pciefd_receive_irq(pcie);
+		kvaser_pciefd_receive_irq(pcie);
 
 	for (i = 0; i < pcie->nr_channels; i++) {
 		if (pci_irq & irq_mask->kcan_tx[i])
 			kvaser_pciefd_transmit_irq(pcie->can[i]);
 	}
 
-	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD0)
-		srb_release |= KVASER_PCIEFD_SRB_CMD_RDB0;
-
-	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD1)
-		srb_release |= KVASER_PCIEFD_SRB_CMD_RDB1;
-
-	if (srb_release)
-		iowrite32(srb_release, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
+	iowrite32(irq_mask->all, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
 
 	return IRQ_HANDLED;
 }
@@ -1733,13 +1730,22 @@ static void kvaser_pciefd_teardown_can_ctrls(struct kvaser_pciefd *pcie)
 	}
 }
 
+static void kvaser_pciefd_disable_irq_srcs(struct kvaser_pciefd *pcie)
+{
+	unsigned int i;
+
+	/* Masking PCI_IRQ is insufficient as running ISR will unmask it */
+	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IEN_REG);
+	for (i = 0; i < pcie->nr_channels; ++i)
+		iowrite32(0, pcie->can[i]->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
+}
+
 static int kvaser_pciefd_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
 	int ret;
 	struct kvaser_pciefd *pcie;
 	const struct kvaser_pciefd_irq_mask *irq_mask;
-	void __iomem *irq_en_base;
 
 	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
@@ -1805,8 +1811,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IEN_REG);
 
 	/* Enable PCI interrupts */
-	irq_en_base = KVASER_PCIEFD_PCI_IEN_ADDR(pcie);
-	iowrite32(irq_mask->all, irq_en_base);
+	iowrite32(irq_mask->all, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
 	/* Ready the DMA buffers */
 	iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0,
 		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
@@ -1820,8 +1825,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	return 0;
 
 err_free_irq:
-	/* Disable PCI interrupts */
-	iowrite32(0, irq_en_base);
+	kvaser_pciefd_disable_irq_srcs(pcie);
 	free_irq(pcie->pci->irq, pcie);
 
 err_pci_free_irq_vectors:
@@ -1844,35 +1848,26 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	return ret;
 }
 
-static void kvaser_pciefd_remove_all_ctrls(struct kvaser_pciefd *pcie)
-{
-	int i;
-
-	for (i = 0; i < pcie->nr_channels; i++) {
-		struct kvaser_pciefd_can *can = pcie->can[i];
-
-		if (can) {
-			iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
-			unregister_candev(can->can.dev);
-			del_timer(&can->bec_poll_timer);
-			kvaser_pciefd_pwm_stop(can);
-			free_candev(can->can.dev);
-		}
-	}
-}
-
 static void kvaser_pciefd_remove(struct pci_dev *pdev)
 {
 	struct kvaser_pciefd *pcie = pci_get_drvdata(pdev);
+	unsigned int i;
 
-	kvaser_pciefd_remove_all_ctrls(pcie);
+	for (i = 0; i < pcie->nr_channels; ++i) {
+		struct kvaser_pciefd_can *can = pcie->can[i];
 
-	/* Disable interrupts */
-	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CTRL_REG);
-	iowrite32(0, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
+		unregister_candev(can->can.dev);
+		del_timer(&can->bec_poll_timer);
+		kvaser_pciefd_pwm_stop(can);
+	}
 
+	kvaser_pciefd_disable_irq_srcs(pcie);
 	free_irq(pcie->pci->irq, pcie);
 	pci_free_irq_vectors(pcie->pci);
+
+	for (i = 0; i < pcie->nr_channels; ++i)
+		free_candev(pcie->can[i]->can.dev);
+
 	pci_iounmap(pdev, pcie->reg_base);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-- 
2.47.2


