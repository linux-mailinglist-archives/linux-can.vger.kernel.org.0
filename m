Return-Path: <linux-can+bounces-4072-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FE5B100BB
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 08:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001D33AF296
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 06:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D13221F11;
	Thu, 24 Jul 2025 06:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="RL9pyPrx"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2139.outbound.protection.outlook.com [40.107.22.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8BD21CA1F;
	Thu, 24 Jul 2025 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339045; cv=fail; b=okZKEhO2yjwZD/KknBOzo6TG+7oHZTzEFJfpQBrws/uN8vy/R3Y561DHn64rgw9umoMVBKRA0+QagAQXx4f5rAGZqZy4GafdH3PXycEN5oVCPze42U4icca4YF+Ix05NUhM8bEPgQKlUtiZ+gU1nt4WS/PrTcboDhJBhUgbHF1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339045; c=relaxed/simple;
	bh=GEHBmSjwPqixuKQ9S7VWjwGnF6ms+93XIXTGa64t7+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=joC78mjqoBTY+9xW4LQqsYwgrt9y0s58Wg2SRL02wcSHurUUCeZ+mgnbL3jEBtGsESkQ2CfP1KIkE38lWKHSmyyc3nRN45+wxUxnvS/ikIQaDX7W+PhPQR0wKTjAQkSVBjV0DDPTzVrwo9Eto+UiS/X5xiAyyRqJR7vkfuQLOr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=RL9pyPrx; arc=fail smtp.client-ip=40.107.22.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYa2qqB2tHt1NBOwPvDntTDEl2As7Joqwznpy03axVrUfiGor/LFxGvoYU69z7rOCqhoLqFa1hU7I8UHwfqlOoePigCybXUJhE22AdXTupg5JRZtPajn0xaGJMsqZIjOrUmDg1e3ZpuN9Ju57A7IsvRF2mZzaf6LuAIh34XVeE+IEPHgcpn08UtmxLQp0mHEyO3fN30KULka2pNp/QNEMIHXZwLOWrvpIaDABR5zLG1ilfwE9OOe8aJPY1kVG6gv4mctz/Q7nBiKPOaQQhFTd82+EH5ICXQrenGOGJudRp5YKCadWThmyr9HpW6wwE+4hwD9F9nFGg1eduMZW5ytOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jz8x7dpsCnG9ZV3mnXyrtN68xp503CzdeXhTU3smtTg=;
 b=QuORYAUUBa4uA2I6cYBCusXNTNoZHqWWNRVyaNClh5/B+N0qGI6yln8EFV9yc0jUcoX6AVI3oyv/xO/r08vU8+Gy9ZmsXbhDSJJE0Dg736GPbvVP+vEf1YJ7Px1f/VSbLv+jVq8PKmwsaOzX48HMwDH/wGJvFHtjrzf1Fd4KvdqWBQmKMX3a8GuMinVdYjzDykdiZRC/bbID8I7sUuhrqL9Mgkts3qWY9GAVzB8vpCH5qN+aWeyHfM8nrWDLEq1F60Um2hVywuUJlilIJ7poJyQVIz3QHXtzLkFW+RGViaXYuCTiXf2vZ+twt9UjZZuY4Zylhy/yTKermfdeLmlw2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jz8x7dpsCnG9ZV3mnXyrtN68xp503CzdeXhTU3smtTg=;
 b=RL9pyPrxceYF5igISUDf3kz5hCWPdHpQlnk+tIhhLVY1TdodeASM+x+/EPID3T3HlxKI8K+/2wh7nCT1QpRgZTk6Dvl6dpXIyvFdjObztCImmGvHGJsaNSwYm6I+QBccUR5RnKi8uOaEMQh7UBgevTjeh8IameKa0cJvPNW1Szw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM0P193MB0562.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:163::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 06:37:17 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 06:37:17 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 03/10] can: kvaser_pciefd: Add intermediate variable for device struct in probe()
Date: Thu, 24 Jul 2025 08:36:44 +0200
Message-ID: <20250724063651.8-4-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: c4d291ef-dd0a-4c9f-25b0-08ddca7c8870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0S6dOBmyxTWJm0KoHu0Tzh3SkMSnVeBASMJ/YUfvXf4aVzaHNGwoHjEl7yD/?=
 =?us-ascii?Q?2wO8M5M04bsP5VPvoM5MYMAx4ZxTsVxFEPml1fIRRzGZFEXtQ0gySzzUkzH7?=
 =?us-ascii?Q?xReTZpsSpdhiicAKp3y/ZBTBO3kAWWBp2aXp/Ev4uLEafL4EFHKc6k8P8th1?=
 =?us-ascii?Q?Bd3hAilBTdyprDbUWRvbXBEL+WgSatwR3udGiz9VuLz1o3iPSi8NqbX7VEP8?=
 =?us-ascii?Q?mRgKedkPXVEUAVYc7DKXxJHmLLo/RuuhUZeI8CpJuyuE5dyFdNGUllYnia+r?=
 =?us-ascii?Q?G3z6HdBciYpKg/Ljin3EWIT+xoyvWxgwulUgRFXahU5ijNxBpvIIY5i+HOJf?=
 =?us-ascii?Q?pKc6qEWmsTow1W3Ug7jl7B8uhVDmVSFgSvvhd55K8ri9UcZClxvoRPq2jxPF?=
 =?us-ascii?Q?dNUBlEY7Ga/N8p+JqYbexRd2QeaGBdaG3TWuKzKgr6HAm0w06KMEU3e7p58v?=
 =?us-ascii?Q?6325G/226V/McDQ3clSOz3hHdnjMYu/5+lM2gA47dmfHkJVbIj6NcVFPt3j1?=
 =?us-ascii?Q?KPGHycMv0BRBFOaRkJ99Q7a8q8lYZ3CL1LHn144ldFLfvtVdz++esLSZ6GP0?=
 =?us-ascii?Q?U9krmgk9smwI3DaxN6R3S1g9FSuMuYqIBFVbQ2aPaoC9CeXw3WVQE+WdjyTY?=
 =?us-ascii?Q?nVp1Pp/kDOpms74aql3imwrL6azkd6j5Ehd9Dj1xlQJCUKXdDOEqxY4xNgct?=
 =?us-ascii?Q?OI3Or1vFC/88cmyAeDkbkqaDPMG+ImNS/7jlI8QQi8loGsQVfTl/thqm2FoY?=
 =?us-ascii?Q?VR4xzFTz0TRDzow5Rbr4Zn9QcEnG2aTWu+Dm0OQlRLI1tEcord6zvs+71WaJ?=
 =?us-ascii?Q?rZaimTHjvo+07EZgeBoZqhXMJWCWHKNIVMuu8bVQtov8DQtsP2Lze8yPM/er?=
 =?us-ascii?Q?xfsG8fdn94D6kWJIarr76ScHXIWyHG8rwOrLPeSSJgO+eBXCo50aaC1P8VFr?=
 =?us-ascii?Q?U9kVU/9D6ru1w7MlzER1pRqNVsNkoiwexfLc1aRRkoThUStbmojDT+lX8o6q?=
 =?us-ascii?Q?tT/VR06c6F6B7t/lGQmiYETrWfl7aWfYPUUA0v/6zCH5v1pAQ8EfOc6ORVZF?=
 =?us-ascii?Q?DA+i3cSYszSotki73KXamQz1+OTMrxETnX+dslQWUXgm2wRssj926up+Ad3s?=
 =?us-ascii?Q?PJUvriGG+G6b1yD2l/bT1kw4vq0tA5dCIwGor1rves0/jIYmjx2TkL905I4Z?=
 =?us-ascii?Q?5WLhBGzfdn2pfNsYSaHh24YWi+07wee4KhIgD2eCtbtWDibQryI3Hu1I2cgf?=
 =?us-ascii?Q?X4XLEnJD6H64b0/DCPzFTYc8gtTldkNGweTS6Zmh5uKImblfCoG6XpauWKox?=
 =?us-ascii?Q?lVAyHKzf79T/oq/x7ns1KWSXbGtjDkeBvH44vs6pxo4X+gMtPE6V4hZCtd9B?=
 =?us-ascii?Q?Bz7/RYys/Tcma1vyzEdcvephLLpCRXcNog4V3horScxxYbKeVDKkPar8BsqK?=
 =?us-ascii?Q?djWiwRh7DCI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G08xsVtYlDgzz84EHavXhP7RNezSlZgV2Y6JywAKZhWZR7MRMrVZtGClPESa?=
 =?us-ascii?Q?Av5Ae1PIVOUxkHRqBaDUfOvd3xOCnDGDnzz3Qh8OL23Aw1TqPORo5kQGEz3E?=
 =?us-ascii?Q?DEPQW/50aIzO0xHNevbP+lOv/zE0CSBZ31XznrFnmtRBlmujaRk4eYSq61J7?=
 =?us-ascii?Q?SCGh3O8Lybw35OHgZjGybjcoLx/JgUV49a3q400pSr86DTKR84+vwlFIHwgT?=
 =?us-ascii?Q?lxdpuki8ZWTNzsbXujQfBX4SKyiowKXLJ+PyR9IM+qOZDYiVeGuaNHHgAlfP?=
 =?us-ascii?Q?SnZoZ+Tgmx8TtviGcK+dBJ4YuOcXyzDN/astPI66BMNzFM85SDuHwnwc9hEY?=
 =?us-ascii?Q?M/oDfHF0pR4yoiCBCVQNGphNIh1l4PTZQ69TxNRcfyDs8lo8nthavzSVxxkZ?=
 =?us-ascii?Q?a2zYT0/Z+bqP9Ym5sawol2rpXHPFtmj3V/bJsjd1cesDFKMRrrUCjm/9n6oO?=
 =?us-ascii?Q?hhfvv0GhhSFHvffYFgejjrX/9a4I7yrIpUHpTefh7Z4eTSmLdWFsaZa/ObsH?=
 =?us-ascii?Q?H2iRC7JqVgWrGkjWM5zYDbp3Yzcjwy/ms/dJYjVPv2niFMnoUAuqPaJzvMZL?=
 =?us-ascii?Q?YsudRa9dZRvlQTpgbZ9A7NTvyZ6Lp+xiQK1kvzba0szIHnVpP6n2IeFKtscU?=
 =?us-ascii?Q?7LcAm80iU9LC4Fp486kY9uEGRUdXTCsDx8E1mP4gDD4oMKMiNdSuSuyjmlLd?=
 =?us-ascii?Q?z9+wMbJKu3kWHutyhItMvAI1YVD0kDsxQD+xEdTB7pabPZoIzVs+QpBTp3lt?=
 =?us-ascii?Q?UEDX2UtDmf5cGSEx8ZSbYop9nfJX65zCJUBHDBcIY7VC4yk0SkyGIFn2fGRB?=
 =?us-ascii?Q?yTIcljPm3i9l5v8j01gu+04q0/qwfSPvJ2P8SlPZQbpin+kaECoj5+HY27Ao?=
 =?us-ascii?Q?yMd7e5hCxhaw2+/07EHCW4u6MtfVJ57VP+5XBq3OFGkksnMM2pdmZdScPk2S?=
 =?us-ascii?Q?8rZvJtzeCJDvllRGoAxvTxIPfKonTRRp02GGLBvnROWXl1gmDPDyVdUC2cyc?=
 =?us-ascii?Q?W6bVHDT3uJgVrlULurtrqCADTVMBnyFaa+b6LWHVe06G9rGYThrjtpRu9sCi?=
 =?us-ascii?Q?j3m+a9mtJOO7zND/FgsIKyfOMaH8EhTWbZWXLfANE07YpG2U+wbMivfLVety?=
 =?us-ascii?Q?Xa5P7BSi15kaRGMqKRHEBvyS/JhLwDFdhqLYR4skwhJczjsOoYttYwHn/j8O?=
 =?us-ascii?Q?054SHocwXkZP5spG7/FQXy0244Moj8KxQGzcDFW6LhQTvPgj+checgqI+Qj3?=
 =?us-ascii?Q?B2wXpm0FSqTQPcNcCpG4x8fajeEyBwrNppLlrwxwBzNtrpwiaKG6PYSY/Yws?=
 =?us-ascii?Q?36C30hzmaxF+GiJ2WzLoMxLvIdttaEZVhmjRN1fc1Pyj+R4z6emXhvlN1E1E?=
 =?us-ascii?Q?vjfIgewRTSI8NXkGlToLQZxe2KGld5F0BGSHpMPGbeUlyIwgTJ/eUhR+Cw+o?=
 =?us-ascii?Q?4aI7Tvi+3TwS152I49dRYU2TYv9vk98a08KacMxM0f9xgdJf4HjE81gCVMjT?=
 =?us-ascii?Q?jqqD4PQU2igw5kKx7KMk2j7ESiihC34ji5lIqXbcAWDAIoR7sKot+ZzYgDCS?=
 =?us-ascii?Q?G/rHEAMVkIiFY+Nto9h7HveJzW8LYaExNCFqY4cZZd3lWWy04FNTwgT7/eAW?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d291ef-dd0a-4c9f-25b0-08ddca7c8870
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 06:37:17.2746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Be9R3oBv30yeXnFtGenmodZyiUkcgSZtqhGBZf8yQeBjEi8UCcXL402CACk6TJfXwA/chjNGviE3JH7kemZi95hYEKxwmXSZtNhkAPxy8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0562

Add intermediate variable, for readability and to simplify future patches.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
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


