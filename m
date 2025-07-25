Return-Path: <linux-can+bounces-4126-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D246B11E9D
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F211CC4B79
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BE02EBDF7;
	Fri, 25 Jul 2025 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="fH4gYFx4"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2103.outbound.protection.outlook.com [40.107.247.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00CC2EBDC9;
	Fri, 25 Jul 2025 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446776; cv=fail; b=Jo7tfTeAJAic7RifNFFT8i85WsUQlomR90Kb9YZ2b0JdmOipchIvKpQhGbbN4cd4wiSx+0zN92y0+rJ7EnY4wqvHMnMRW1GXeJcrgnksy+li1oGX4IV3kmMZCnpkr3wkdhzMnY4KdI6pcxZvApmqmzxAqqLsqp9xk7UEjtoINCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446776; c=relaxed/simple;
	bh=+61KpxFUXZfcMrya7dOB/reQzjSBwG0cmBEwtg3n/Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ol1Yo6+FeH+fsRbHLiznVwW9TGAYbMnZnSEK/7ADN1Ovx6yyOnX2bMyfjlwq/g6h05wD9glOUFW8D9US6RX6PVR9AMXRDDFwizpFXIJsTcjIrBhP28cNcEp3kuqpI+MosLcn+GsAtlomXxU1zwh7uNwxV6RJReokj8OmSNTvOIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=fH4gYFx4; arc=fail smtp.client-ip=40.107.247.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKaBCeGEyzZO71JqRbtrqdCzW4TkkhCntbzUxtbFUshw2Em0ko9xo+x6c/RekjRXW59K19NUhXvnVRb1kbjys6C2DYKsZS9wSl59UE8/hm853arevP5HBn876D2QQpjn5wNAsjuXD94Az4jiqCne6eWPuV+G+4meKRfViv6QvWBabzbVeKJ+7ld080M7YD3aFK/EqMrJD+n6N+8bfFFyyy0W1d1NdbtqSVt41yNdYxYhOYSv3JVUa/yMJcakBJeFgspMsuKE5CpyOlNBqyP2Z9EaBBf3UV+N592+znUame2AgAJh3dxtMTrLR3SHaBVblrIKfWutJZDvKGJZvM0lwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8zkObzUimQ4Naeea36f54lCeNMXk8gKSwFRPVnNEtM=;
 b=Gr+cX8k2kb85a31Zc5+yRsCrB7PBTUS6fNopdQhYmisHPfHG+AtvH/3E61FbG1u4Esy9dKOnstSfJ0X8srxx0tbmfKJuudNvn0ETQ3JfrG8S+9BQRuu0d1rp9OR+iJCtGd0+6ij8L7VQSR4VhHEnXlsdx6EDmjBJ0dExVAO3qK49iljMVzryht33Sos+MxSY3QeUelneWrzFfGLOabRMISji1zZ1gFazLLPiYBZW/oUWNPPlBTqnVYsxP5wBaSCuGVnVfrnT+Gi2H7be25BTcR14DI1futPDh4/DJ88GFwb+NkrZVYvLl+qxOlBE1rKmziyA2P+zH1BB/UvzLg0Ldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8zkObzUimQ4Naeea36f54lCeNMXk8gKSwFRPVnNEtM=;
 b=fH4gYFx4dqLVVQhIaKpXXD+gNjljt0f+H2pWy4Jr/axcK1IQ4zqOuy9bF9HwslUi/JtPOrgGijWPEbr7A5TCjYcSyHKIwYRiR8pVxMxzf1/hoScpIbddd0kWoHX2VGqy4WHsnVpSQWMuHtNLk6p2jm3FZm8wzqueTTGc+FjNVz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by PAXP193MB1376.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 12:32:47 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:32:46 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v4 03/10] can: kvaser_pciefd: Add intermediate variable for device struct in probe()
Date: Fri, 25 Jul 2025 14:32:23 +0200
Message-ID: <20250725123230.8-4-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725123230.8-1-extja@kvaser.com>
References: <20250725123230.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0077.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::20) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|PAXP193MB1376:EE_
X-MS-Office365-Filtering-Correlation-Id: 24cd404d-5353-43ab-e99c-08ddcb775c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZO8KJo8rDllPNPB6nQhDYZGZuysgrdOtUkVHqkGdUPJQ5b731RuMzyEjVFPU?=
 =?us-ascii?Q?T1clXecwMSGK4DRly28WbvWQX6BnTsZXF7r1q7DObnaAznGZNw2ORKOQ7o86?=
 =?us-ascii?Q?O2fhTEX9wEPjGGVUanTnlfbTiDrCBC2g5tLdDmY6Gbe+RBmhJkGinEKlVwPz?=
 =?us-ascii?Q?Ok2bUx9lMMpG0CoYXDOQdHF44mEkyK24NDEkxIdpXHMegITywgcIGPt+BclU?=
 =?us-ascii?Q?e5ONfrtrv8tJ1VGln88ji2m33WhPcPa9Wy7jU2fe5lzqGmDiddlRTQy97HBN?=
 =?us-ascii?Q?UvkYJIHclBy7vVY2z24h5FEt95ZOGWim6Li+ca6h1xQopivIi3O95oHCfx4G?=
 =?us-ascii?Q?FhaeLphiPJ5fBRexKnoDrZHvJVdkAaX08WL0XECI3Nmvf/ZZLL27I1/k1+Ku?=
 =?us-ascii?Q?LPEdFKM65Rh/i0jwvbsniSEnVB6d+CupHxxm0jsG6fgwgNyqHzNP1+hX22A7?=
 =?us-ascii?Q?es7vSSZgqR2l89W8J78EWtOCaDAhDzR38Pbto2aCnSu/01C768CRk2fI5LJH?=
 =?us-ascii?Q?oadxnYP/R9eQB8JwjYj5jcFrhYUXgKrTwoKlLTCFLIpA9yCsvqywUP7mhiz7?=
 =?us-ascii?Q?3HE5zWXhpPXbp9X0/Xa4z5D1w4Y8p7/bk8YFlTu2//gd9sj7d7pzDsl+WCba?=
 =?us-ascii?Q?eHl0GG0fdaNyGyzv86siacy7hf4b3xBTg8XZjmja0xhMLNsJvK5F4TX/oy8P?=
 =?us-ascii?Q?LI49mpbt6Cl2g5dJfQ0oEiKqhqyS7ksR+heBkN5zT5sCTUMXU2POdrdoOYGR?=
 =?us-ascii?Q?IiX9lnpcFH3dafd2abFkSCiAM91dHxPQ+l/a2YBeyUG8hdZ8uGohgRhJaSl7?=
 =?us-ascii?Q?GiMBTQwJDLQN/W0UbAfiAoYEqPQIB3F2T6OCeA5Sjp14WQ7ZryUhMn+vsxVp?=
 =?us-ascii?Q?3ODSHswlKi6U46FLtwjyolqmbCYhEC9wwLhmm3REaRs8uQrid5vLMPQTwPvp?=
 =?us-ascii?Q?5P2CwpKi8HMCAKhQs+DugJY8VQYBLsWTs9L4j+cnHYDtX7BCRvhxTrPbmudI?=
 =?us-ascii?Q?xNbrvB9kuG+e6WzdU8qZOnBGvofwMxrY780wJ8VabjWSWSeAv7QydtrVbIB9?=
 =?us-ascii?Q?fxrboRypEiNTQNqJGHDbcctkn3DvbHegOgMKFwnSBOsDKhqVTmY5LYbHtxdS?=
 =?us-ascii?Q?SuLIjCplGu1IAEX3w+x4/JiSq2d8GlLawjP2sLr6PJsJsv8NPv7Kc8Flrzzv?=
 =?us-ascii?Q?OROavfhtgAls5TkEBNexvFXmRCriAktsiFzdDJtA8Um+dKPZnjxsus5N3GLe?=
 =?us-ascii?Q?wgvY21FO+TOMZu/QsJGocGjAn0OJeCd6ofP2s9I5RgTgKHuTs2jaXcSDRn4K?=
 =?us-ascii?Q?D6Niq1PbPkRNPY8YcdfKhrQkXU4e7x6yq5nZ7zWV548qTkSDFuKDIUYCNqoV?=
 =?us-ascii?Q?oQCNmLU+KEu9EcoBYPlQPxGywXnwukMKbCPy9Q5fwMshvuYQ9megIB5aIPH/?=
 =?us-ascii?Q?b/0Sqv2o5Rk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eU8PcsbPLk6Wy0Wr0/r6GoF7T20SbbOT1MTX+LHLE5uy+kZZ5SvNT/b2rOQF?=
 =?us-ascii?Q?Qa6ccHu3ISZUxTlUJDoRMi0cu+1/YYcTF7zUDPOyWmP7yPmVKH79a/kUm8Bw?=
 =?us-ascii?Q?dWgdR3C/50/5rUnH4BmCgntv0a9kuVUWuixzpye7idq3frvattCea/KWThNB?=
 =?us-ascii?Q?wJxvL9bTMqOzjJlu2yRkNgiNANBSTisdHTUkvswf0kla+oGYGXUuvha5WNjM?=
 =?us-ascii?Q?edDZiGCLGSeHmSqc0VGhoJHGftGeAwQkAgxRBmynXGUfk/6FobpyQFIfSah/?=
 =?us-ascii?Q?vO6sbNk5D6k6DiGsSbi5zeGSIABABJpwSkCDRuc0DmCk16Ndl/NNzQD1b8Zi?=
 =?us-ascii?Q?MCLHXJNpoJ8mx3O3raUPGwdwAqEz4NdZQUrmVDxuMZaW2R2HxbcYTLG2PAnr?=
 =?us-ascii?Q?AKyXJ659U9NKKwG37G21ygL8UPO9oxXUxajwiahjYJhurxMCkjD+N1bDo45v?=
 =?us-ascii?Q?fJy/RWGH7Bn4wh4hkZ2fik0hVdJWb5riDpV5nXDO5h4HhUXCfGYT93LuZxtB?=
 =?us-ascii?Q?v1S05wxQeis6dip/ZSo8/ealveUXrmVXLSpTykAYhe1ZINUlQKcaKo+iU+o5?=
 =?us-ascii?Q?mBpQUH2rer6YEmg0Ck/Zc8m3MsaAFoF9+WSCtO9S2ORlz3s/GXPC+uty87iZ?=
 =?us-ascii?Q?Qxc/yWwxXfabtHbLIYexPjX910usP9VWfyjlv/JAtbkAKzqQy+Io4pHlm+30?=
 =?us-ascii?Q?e2wyS1oRTZyWqcOoFgQBXJVCKnMCYDyohncCaVEHRrZEM4megtKoqWQy1QKr?=
 =?us-ascii?Q?CG3Iiw06J92OHpeQSTlE5xpUmgVOt96Uz6EGNq/tCOo41PnyLql8XsC1zGqo?=
 =?us-ascii?Q?rT0RZ43asHsJoHQCKjJjlIgtPN6MPGvJ/sTTkQdauJp2hjzDQNdqXuEL/SqQ?=
 =?us-ascii?Q?5Sy1A12dV9K4aLwlZU60beqoC9eEyetAjxXkzxS7gBUe4QSarGINv679ufk4?=
 =?us-ascii?Q?v0/+Ll84gxYkAq21dn0iOR7fu/4wIM/q44WJt4Mg6zEquYAtG6c2WZYhNQAb?=
 =?us-ascii?Q?ngVELMq9R9P9FbgbO52YLPh+bYT8ycfACXGlddR3E+DQUfWfqxNoM1tuKkSS?=
 =?us-ascii?Q?MFgYVQfUsRzqjYit2CIfeJCiy2rbksaLcR1CHGbm0Tu8NkdrOxwDTOrVclfM?=
 =?us-ascii?Q?UI/PGk/FWvINKzRFJ6KlFl8wL2b0rixbSTGXwriejey/LDdvD7xx9QMM3TwJ?=
 =?us-ascii?Q?awk0XGrzoSpj2ROMkH/5psnZykla8Aet1lHoR1YlXKwCzZnGYynoOX6qi0qu?=
 =?us-ascii?Q?VQwItk+Bl2SPzE3fWIRwB+eqMHhqq5m9wZNjvR1IlI9b2SzBPL3a+YwINq6V?=
 =?us-ascii?Q?xWsDkbzQS6k2q3CRHo7jsh4MAMv9SBdCdVqGJKUiavwRDU77fCCnD12QgjnL?=
 =?us-ascii?Q?kA916sCfij+YSYkJp13uEkGIw7AD37dGWfGz45ACy14G0NnDvD5hN/pJeZjX?=
 =?us-ascii?Q?doKtRnuhfRU+ePeoWILvDf3Jy3H1UM5sHu4XeuTI2r+ex2S48C5EgTRlSGj9?=
 =?us-ascii?Q?SPu3jyTq+wAasRqBoe9+DeQP/m0C1B3gYDNXlTXAFGIj3jf0BkXUFO2INL7W?=
 =?us-ascii?Q?A1RPx5Bf0V57Zr8mD0B5Wx+f4jbpmXp/1IfWL2WKpZipT7MdhnOaG2AlSNHw?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cd404d-5353-43ab-e99c-08ddcb775c4e
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:32:46.8780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQ1uSc4rEBxqHUwZrxOUxptn1aNbqksRIeRwjsiKDM9LGes4BsLvwbZTqZhaq78HkBwrDkI6+RoJrxssvzbDB22HVeg7O5ATzF7CJ91EUdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1376

Add intermediate variable, for readability and to simplify future patches.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v4:
  - Add tag Reviewed-by Vincent Mailhol

 drivers/net/can/kvaser_pciefd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index ed1ea8a9a6d2..4bdb1132ecf9 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1813,10 +1813,11 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
 	int ret;
+	struct device *dev = &pdev->dev;
 	struct kvaser_pciefd *pcie;
 	const struct kvaser_pciefd_irq_mask *irq_mask;
 
-	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
 
@@ -1855,7 +1856,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 
 	ret = pci_alloc_irq_vectors(pcie->pci, 1, 1, PCI_IRQ_INTX | PCI_IRQ_MSI);
 	if (ret < 0) {
-		dev_err(&pcie->pci->dev, "Failed to allocate IRQ vectors.\n");
+		dev_err(dev, "Failed to allocate IRQ vectors.\n");
 		goto err_teardown_can_ctrls;
 	}
 
@@ -1868,7 +1869,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	ret = request_irq(pcie->pci->irq, kvaser_pciefd_irq_handler,
 			  IRQF_SHARED, KVASER_PCIEFD_DRV_NAME, pcie);
 	if (ret) {
-		dev_err(&pcie->pci->dev, "Failed to request IRQ %d\n", pcie->pci->irq);
+		dev_err(dev, "Failed to request IRQ %d\n", pcie->pci->irq);
 		goto err_pci_free_irq_vectors;
 	}
 	iowrite32(KVASER_PCIEFD_SRB_IRQ_DPD0 | KVASER_PCIEFD_SRB_IRQ_DPD1,
-- 
2.49.0


