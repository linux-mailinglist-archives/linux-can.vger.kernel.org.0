Return-Path: <linux-can+bounces-4089-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D33BB101D2
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0421B581CEF
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 07:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1691F26CE27;
	Thu, 24 Jul 2025 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="LfpGUv6P"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2132.outbound.protection.outlook.com [40.107.20.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8126C3A0;
	Thu, 24 Jul 2025 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342248; cv=fail; b=h974nQXpHq/D/xIzrDnRBT6KYDfQ202QLUi31Tdsjg58y5XlOlDiNJDUlxWxF1cO0Yerf+FFUxmfP7XdA5g0kymYS/LvIq9gKFCtG/RhBhL+DecKwReijL44+E982I6YbKYdVPNVLYjzYunJz0Ge2Ua60ApPemhREt62grNHvVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342248; c=relaxed/simple;
	bh=GEHBmSjwPqixuKQ9S7VWjwGnF6ms+93XIXTGa64t7+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tPY0Msou0YL+0M8pzU5Gre+jFuMX3OLwpmA5MyajeAzIj3/g77ODkeAQ3b4qLGJl5CcHpkzlx9Tc/JEJrz5vZ8For8OakpzzxRfZRd6OEeBwYbfqIuXOGqCw0UeWtmF2mOdbN0Mrj/TTD1WIZhpmCKUbcR1DhBdHasdMijNcgm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=LfpGUv6P; arc=fail smtp.client-ip=40.107.20.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyLapV72XBqk0mg4gj9ZBXleXH/Ek0NDtONwi9MEK+qMALr073Ztl//5OjvESyTyubYvU6zFTTN9gQA6qgl7F94papLgbB4q1Au8fpobIsbWtwG1IODVXNVj1IuopMKg9Uc6BZfghdRMP2frtVEeLhaecGcpBj/HCg5b3WVMSHI+utm3ZvlAgQ5tmL4PrtwPnrK1giImf33G1jDy18qZ1DCB5pJbIhSNFRaN2hTY9CSz0V8EXukx2El4v1iD7lX811XIFF3X3pCz65hlY5tJDnSLpOy2PVruZAh5IfDi8bwQmFYyTXN17sKjVoB/8jb9XW/dus5NAJ70G6p5VGSxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jz8x7dpsCnG9ZV3mnXyrtN68xp503CzdeXhTU3smtTg=;
 b=F4BbPKwLVQ61yL8f+X13/prSq1rz4Vnw6PSvEqbtLNevNqpuDeSSUX8pFxv6GrRA/V85y/y10p1cvzjG41xC0PVIRWNHlCfU6eL9vxTUFAcdRiIZ7OkZyFticDc1JgLGF7/f1nnkncVqxfzhVufp50RDGDrUpdsx03CDUsfbamzBKuatM0/kQMkilMYkg6H4sS+tKwO41PUW9MF3ZtbFIph1n+uhqpDvZg+bnrjG/d93kM1No6CDDOqr7fp1iA7ZiIKZS4B4Vglv9F3wSvqCkRmC9624wp0fc+czrnCOG9Dh4AMbsRi0TwL6CfPtvFH68ZRmKSufFVi2D6VHB4R/vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jz8x7dpsCnG9ZV3mnXyrtN68xp503CzdeXhTU3smtTg=;
 b=LfpGUv6P83/+Lt0/Sax6cWipyZNuSxUJ1zqSoKBKVvQx0slR1aZo/4/NdlrDy4ANBJH5gbCsJuioadZgMa7NNMLcwejoborDn+T4xI0Y4mgAOjdJHF9cD/Z5iEnzq8u45FImElub/wD7Ew/Wr27/2NZCcl0N8B9qLJWnH9qqJBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB2657.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:32d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 07:30:36 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 07:30:36 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v3 03/10] can: kvaser_pciefd: Add intermediate variable for device struct in probe()
Date: Thu, 24 Jul 2025 09:30:14 +0200
Message-ID: <20250724073021.8-4-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724073021.8-1-extja@kvaser.com>
References: <20250724073021.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0090.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::8)
 To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM8P193MB2657:EE_
X-MS-Office365-Filtering-Correlation-Id: e78beb23-696c-4b02-82a1-08ddca83fb02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MdG02Frm5+RgpfqVpDyynpQohpwRiFegnNFo2jWCJ3VlB1SPTf/TbR01w1Jx?=
 =?us-ascii?Q?J6MvhfH4uUT7p1POygkox87Z8h3nz5sMLRoNoXM7j3UKvTnQux1OLOury/jF?=
 =?us-ascii?Q?ON4JImyJbLqEns/9xA1uKERaI9Jm6q6nW8PqznwHKwArBVJhIky22e+0D158?=
 =?us-ascii?Q?DFUiNIOfYlIFGdQPRE5ITVOirXLnbYQiu0mhyZRoFdnKwvENA87w9xWF0pp1?=
 =?us-ascii?Q?X9e5PoIeg2S1jWiKWMIe795r1VQaNqRIqmYmPhURdcmUWMzVFO6tKOdHhMMX?=
 =?us-ascii?Q?+AaM3R8IHgcWVRiGXDscu31um7oE4oPJRJjJq5oKDRk+UQUcV0DV2FUxPBYk?=
 =?us-ascii?Q?r6hnM3Jfmo0zW4W0dETliFbuKP/Kw2/+hK01TS65Ta3Sb+ItV1IO52KLaFVE?=
 =?us-ascii?Q?6bPpvbDy1Ly14ysp7mK1IoKqLsdodIdXtZpeaEIwa+/aNpQ58YAffZ0YbLRt?=
 =?us-ascii?Q?rpptxE9T/u6RolvJSwiryfpuZVhf/NELfxq2Jm7JjQ90n/OGTCAlCHv+7WqZ?=
 =?us-ascii?Q?cA4SJMKa4Orvsj78QOD0Xqz+zgluQDciCqiHU71R5njS8SHnRBZp2qX18AIV?=
 =?us-ascii?Q?GQTh5RCP/+YfnzDZ/3RKY41K7Pp+TF5IuIumFlNxwWCNZveLcuNJlQVplc2O?=
 =?us-ascii?Q?k/T2rd42d4pYI4WhvRxZdZbPEsfHfGncK4/M865nEeex6FRGutBPBNqtbDWK?=
 =?us-ascii?Q?4yZerQuXUG3wMeeX6hGFtklULGcYQFmAr4QPutIrnDXNTIrLc13b+CzyaKUu?=
 =?us-ascii?Q?C1wdRjkA13tXEzZOqiLW/QGO50mk4eu1HGTVYx1GqeDJJ3PKNJ6m6o2uu2iI?=
 =?us-ascii?Q?ns1fMrUaXg7tMDZpGqAcE8QSVQhOaDd2/5NykXe0cpzd5HcoHuCOSoQXhxXM?=
 =?us-ascii?Q?kzvzjTcQp81LiiQNihZ8C8N3rioxvLNc4Xso/FdddGq2LSLoEjx0NsXpolVo?=
 =?us-ascii?Q?pmJDvUb9ZI7mQnp35ptKta/QOg/Or0Yg17qsuy6VI6QBtT+hanrQzQ6EgOAS?=
 =?us-ascii?Q?+6NLAPKV3XtP20oTUZAli8asC9TqVc6tND3CEe8sSO2lnHWF1S/vo0CPG9oj?=
 =?us-ascii?Q?IbEAnIBjd6MQfCUHpKgYhp3RQFxpk90RaUgKr3+ePlj0S/HdSs716PIvBnGr?=
 =?us-ascii?Q?EsmU6rohv7k9oHl+mh6RL3s0TYu6asR5I7uLVdEnOjE2BPXdkbeA77vvnWxW?=
 =?us-ascii?Q?sepRIvKi9Y+FpuQhGYVuXWYM6iBPeXvukvvnV5c6ZxUBCIcUmpOMy5bTx+6D?=
 =?us-ascii?Q?U1PMHZHak/1YXwttefoG86LcDNUbv8xJqRKQ4pJRGWM95aiEVkRo0CghB1fJ?=
 =?us-ascii?Q?KlaLYP9SU63uHAQP3BQLAV6oEMRnFD+KFUWD88/YTG5LRNXZN0MEHkC1CTOQ?=
 =?us-ascii?Q?fPDLvwv7QqG71Azx+jCqSLCb1XDnkeJsCVDwNyrtBIr7CgxxY/QkBGU4vMM7?=
 =?us-ascii?Q?6JFaCzUxC4Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ffczrOXCQfh1U3iPeB/aKIoKWrV97Bzm+7p8lOKc7Sjp6YCnpbRh1ziiwt2t?=
 =?us-ascii?Q?SiOEB2mtK9voX7OWdtO1zNhtCxZqU1wELDDbR/VvaGSa1kG1OxyLTHHkk0oB?=
 =?us-ascii?Q?scOuLRrpgTWiuLzjozGw8sGzPOByMAiO91EqWSYPupGAG9GgIJE9bU6bGaVF?=
 =?us-ascii?Q?z++dgEuswR4Moh+mkMlBCBcpcI4yKiTdlPWo8fbimttXLM2w1kuGkEb/vRTA?=
 =?us-ascii?Q?w2GZmx/D6SkHEPI/y6mZ0phqzP9twyzCHGve7CZaeKqZJ1UIcyttMc9IIDJF?=
 =?us-ascii?Q?qGc3a9sRlRwA97vnjRNmamAB4RfRpfUcR6S80fC8+yq4xemuuJheLGNlbscr?=
 =?us-ascii?Q?oNqKe3gdkhKMIxlZLicLdxC9d1jwbjsmzXEO9o37MXRldFZRV2LuRa7+7YJV?=
 =?us-ascii?Q?8ZlUIg1u7F1uANdHtNiIdGO4x+BcgGKX6eY2RAGaFVPKH9jPowJuy/5uFMJ2?=
 =?us-ascii?Q?tbxjCspvj6wX2kwo+qEjlnWmZgKWN5TRGgVdrVW5FraRAyydP5m92Ksa/9jN?=
 =?us-ascii?Q?/mNZGVcs9mw5T3cJxNICtHBZk6MShAPwUNKYiG4xGVosTL231FwbXmK4L9Hf?=
 =?us-ascii?Q?gVLq74O4DQcFXwqdsBA2jkNsVFHUyQHQ5/ZLrGVVIrIpXdjBMhiVXz96urp4?=
 =?us-ascii?Q?NhJ8jEUTTjl8vViKqTfwut2KKeq3ZjNqRNhOlUvvFYHPGtOdFNtogwJXlyXe?=
 =?us-ascii?Q?KRVAoTM+ItsF+SOr2SNauggdG3M7foq4kwAJ/C7+5wKfxUkgeDl8iVUSt+rV?=
 =?us-ascii?Q?3p0DpLJNo/F9ZgQONMyuWEn24WKhnPt9xXTtKrMHoo4euThHtN/YdVuHRb/t?=
 =?us-ascii?Q?7Mey5yb9SjXjbLHtcxhqdTo2uAa1MzZ1J0zUq8463+e5pSI8fUf8Pw9lGFd0?=
 =?us-ascii?Q?crRoO3l+rwjDvpVx43QIslKA+Q+iADIHayWQ5lStYceLReWWnoa4HWaWmhQV?=
 =?us-ascii?Q?eTNhFcaInQt90JzOAeOxZkBo/ODT43OIuN0vDDk3K7LmVgHvOQMYD8dzONjP?=
 =?us-ascii?Q?/0+2ec8maM5B+2aKohQ0eZOIm1Ruhca1SAIV0MJhujcUeYBSyQfqFlRU9xz9?=
 =?us-ascii?Q?Gz/kQw671iLCtJ8NsufELoYGHtufv42KFbEznuT1ToEO1TJeOX/48zw6xhSw?=
 =?us-ascii?Q?n3CLTdOuc+b5wNcnQ1ZfNK7y5c8K3rDl8ul73G2T88z/7eddRIuoH8FnkUnm?=
 =?us-ascii?Q?c2eXomO49JhIrGhDVMS/k1fbHThYhiJvF5LC35vCqq3BoTViH3gQYPME5Fot?=
 =?us-ascii?Q?Fa46kJv93LPwOXRg6F2rfhUvwMbFbzgoq27BvZ1ii2cFS4CrX8gYDCpGxAzP?=
 =?us-ascii?Q?GpwTq79rL7jxOR7ob9IoQMxEbI7Z7IPQC4DhW6BRC0xT3sa8FA+PYOx0fPe/?=
 =?us-ascii?Q?X7GxCEWY9TKSqWY2+TbAFETZZHeCaqSJXEwy934kqIPRptpW+7PTeLd1pPMI?=
 =?us-ascii?Q?Pp1hDflQz9i93hL3n5Bhp6W67nYYlZiN+nE9vwpSi0muOhIyF8t79ys/W6Zy?=
 =?us-ascii?Q?WuyAw8hvZMKjoR0k4ChsHgySkDynLBTbgAqL6td2J4etb+sDwXaMROEOzSmn?=
 =?us-ascii?Q?5mDZVil6/xkXikCVjT65VkHi+KYycz6+sI9hYmEKEjCPHEoLQSTQ4NegNVwN?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78beb23-696c-4b02-82a1-08ddca83fb02
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:30:35.9642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRBbrkSqZJlxcwUiVdjUkfbRa3DnAW0jAGU1GkfsRaFH7usciP5dk7sxAbP6c5xaDpVDtQ7ugiXASZGrqPtNMcn+pnZ4gzh3F41Ow1dQN9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB2657

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


