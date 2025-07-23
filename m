Return-Path: <linux-can+bounces-4038-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B873B0ED49
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B50B17604A
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151F3279DDF;
	Wed, 23 Jul 2025 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="BZsjWLN8"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2127.outbound.protection.outlook.com [40.107.20.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E641327A477
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259596; cv=fail; b=cQ2RkAkGd0wV1yhMpf8KQvE174b+ry8zdBrD/kIQRzbhGDlJNTwV/l6rWZ5Rl1ZRYa40noUs7CeZ+umqI4W0ZyF0UR9C0mq2ruSpDOEnCd+u3CuUNMED2ZR9kAeZwq8UhctcVWkyDOLOKKXxMjYSgTaXef1jk3Q/6RwFmBpL4fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259596; c=relaxed/simple;
	bh=5/xa4uxnGTt9Y1gCAU22W8IwA/ip5VburVpj5HH4ZHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eg3nsmEaAltpwrVAlJUHLQKNBigJvi6Gbl8dv74t+uBGoLMb2H3cl+VJWUyMbOUi5gIY3yF3ss7OhwDwFDCry5h+ruYf9N4c05gP2zlTUS+pukECSqk9160Sz4xUzbP1r06HFUcp1rvydZaTy4nZfckR4TwPXksY4irKewwC+Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=BZsjWLN8; arc=fail smtp.client-ip=40.107.20.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RI6wDB8MyDtq/Itfsuqy1RitN3yzfD0kGKjboRzwe8BtOlQSGDRpdv5uYbWABMmGqe7SMq394NkyPM8qgMiWqekc0qPr4ezeJmlgQgTSg+F77Llqa1kQBMQs2yJe47s3EoUlj3h97lqhbvYFxAhqDn4zkQSCGypjswSX4RpADwOAiTRJqQ1kMZQ1jTiM4ohicEcLGNIWQpVfYZ0pYCDzvwZEtDGQCb1L+obHYg6iGdxgVPK8YLVpvOSRDyHiZdANz7aLDYoKWb6qS7GkGNLY9o07nFzXfEU5eAJBJL/OmPsi8OxKcUPMJywiC6V9CI8u3hFjd7sHAVKF+TeTP3eMfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrDt5EYTB4zsuYVxiDfrVOF6Hep15bmf+cvQhl01iu0=;
 b=Zgrq74+UjNAkRIylEsjlvXnxGOaVRvPKKAckozeuo0wvSbrijSHZR8iuEDtLe1KFkiwZa978QoOyFA27N1xhr3EzWNlWCB6jxseZWaC94/MN68dUyE1wOf2MiAlvLYePdvZvOXZxUimXcE4XFFH/p4BzMyw1e7poG5cU0yFAo+Wp8OvvYbjIFdduzKtiI7VkMIoSADqgwn/cAfBdubl37RTCDOePHZUETq2PQ8I3kygKzBrn2Na+00WZjvdfS0U7slGgK6oGCdwSf7uc732b+N3eR2nX6sOCUZwzji36JY7I4nQmPCEBNTZh0IWA2f/zSYx0kwJ56Ni6vmf2SGB/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrDt5EYTB4zsuYVxiDfrVOF6Hep15bmf+cvQhl01iu0=;
 b=BZsjWLN8TGN/9cTBn8Hgurk0qmsXv0fENtZCgoV56MQXx80NEXzzHPVBicYPI2ANj5uqIbbS608QxKFzP1JdgARkIUODOxCdD1FOkDRmgoxjc3I9CyzHLDrn7ysl5dohM4tg0jh8nPmGu9dDsLN3Cdb/HL0CXBtQ7qHgCZL3S+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0773.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:33:08 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:33:07 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 3/9] can: kvaser_pciefd: Add intermediate variable for device struct in probe()
Date: Wed, 23 Jul 2025 10:32:30 +0200
Message-ID: <20250723083236.9-4-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 821c259a-c717-4c6c-3850-08ddc9c38cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6xQgl4yjn+pLA3dT9KBJJelkZ1DJ2W7pHRalWxwiq1Z0zZqUjzM/rqykE5gn?=
 =?us-ascii?Q?nZ0ddFNV3dgQonp0qQlFp0e3sZD5mNoqKk9nr041A93NSoEGdUMugnn+h3Ug?=
 =?us-ascii?Q?gGRyHb1LavTLrCqfcxPldBs/35paN+nUkrfxt3tUoZXrrQHOoVBuV6UuEn8K?=
 =?us-ascii?Q?MjyGcsdYeN9ZKrRwaoOIalEo96GFIuSGiOzw9Man75mdRb8OJdrbCMuICNAO?=
 =?us-ascii?Q?FhUsng8qr10E+dAMq4O5843oc80h4Yb/pCGAX3LuSH8wouAhuDLJPmCJWxBX?=
 =?us-ascii?Q?xzSaV/OtbmcDQSyRnrltPfh++QGzkXzew64O9yQFU21eUynQ0g5dMWx5/Mg2?=
 =?us-ascii?Q?cOzjHx4em0SUQTtZWLWZPzT4k2tvjc0a3axIBZTKti4vann2jBIWmsewGP5T?=
 =?us-ascii?Q?ejimWHLvwYEgg0qnY0w0+fT9wXQKEiZOMWDRr6U3rBtREoWmj76H45imPEMF?=
 =?us-ascii?Q?WPVvE88e37VgdgHWxa/Fad7Khv2ci5IEfA7qcOLSIkJqVIQ1nMq7sLS0uvn3?=
 =?us-ascii?Q?gdPdXKrcOudpdScofkiG7Ntt0gBcr6Okt0D04Q1B1y7S8qyFlmpWMLseMQEm?=
 =?us-ascii?Q?sZdPjkm+Jh4susYqyGOUQXhD5MgpvYUOWRtT9I+m+NwkA6je8+n+kKw097Hr?=
 =?us-ascii?Q?Ny3+9xRM5tC5CvFQ3bBnUdP1BForRDKNiK+vYf+yPoYbTC4aWjnzXGg6lKX0?=
 =?us-ascii?Q?olWMUG18aDs+ywziOhq5uB+IwY/u8WxPVjHGd0kgH7FdAcc31N1Fpq/8RgyM?=
 =?us-ascii?Q?Bdy+D2MrwTIBGAYwpLsYAT6fLE+FFXrmUPSnZrFMFhTI8i0ZPjOSW7MNurer?=
 =?us-ascii?Q?hNlvlPAHv73SVqclL+mCE2MsxLg56LrBHI2gfZIWM5nG56TsqKA3RqdRltpi?=
 =?us-ascii?Q?5Y6YNaokt9xD36rirIoff4WP8j19d387ZWQiNKDZ8Q4kZ34g4ToWSmBfPDOf?=
 =?us-ascii?Q?1cq8qzUiBaSqsfghWAirjqPSIbKcXJERkCi5EWoFC816kWmu7cEhms3i5bKV?=
 =?us-ascii?Q?WFmKtBdcsdFpJgG7wgYJXIk/FX1NWoV9HpYW1OgE0hHewg+mTfC1aVqhu9R1?=
 =?us-ascii?Q?aNW19J9bgpoj1j+LUtIE8KG9pkciKvViFMe43oO+3fmWPYtR0MLh9a6auEQI?=
 =?us-ascii?Q?sn5I86zQcB024A9/GMYWL2civrAX/IUUZviXd/Ub+edbbBUvWnWZWtEBx7xE?=
 =?us-ascii?Q?166Odio89GQj0KP2c4T8RkiBrK8MEsNOBYEw27NwPqCXdSKZ2xd1DkprUNfH?=
 =?us-ascii?Q?AgEQJLKMnO+pTw3S+H3LWLoEx97w7aIn0rIMesd5uHAjZQ4OlXFD1wkDKKqL?=
 =?us-ascii?Q?DPDZIi5eRnKm7T7olPbQsepdZTUP5WoKA+TfkEI6NK9yQKzMEzHRJbsspboR?=
 =?us-ascii?Q?UMKEjQw3upCTPZ9gQiBpuV1wunP+fNmfBy15XknVpuo3amGswEhWRzju0YZC?=
 =?us-ascii?Q?4/rHGq+cd5o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vdU0IbZx0Hom9sQ4DkFOCEoZCjsFnRSQDfwxsUgUJpqPwwBH6ARr63jWdWkj?=
 =?us-ascii?Q?kvtNI9ckkFjMgTGqpYm2RFHyeWWEhSpldZtbSU5m7EvsTB/f+yv5wr8kNaC0?=
 =?us-ascii?Q?UI0JCI2nDL70Je0Yq7g6G4vwpDrawiHcLF8g063e4UtwQ4B7XPmzD29fe1tY?=
 =?us-ascii?Q?GBqxlkJOTCmmxP7xPyAy9mVmdPuWXP97O2LV9qC6c59/zuefKfRe2hZQisrk?=
 =?us-ascii?Q?4auc5YF1zcd0dShuhC2QAotIi3wyLeKMdBD0RTBIqphZIzpmT5mXQgr7jxwT?=
 =?us-ascii?Q?Fbf6ZdlynXoINoz4DGfqjKws8wSXuW7b8m6Qw/grXV+b6Sx6ANMGsIYGuZiP?=
 =?us-ascii?Q?fd5/NN4OBJpxsT4LPU8FRNjDHdnsW0Qkl5+0ORxS/DkiGHIq0DK04J9A/BqD?=
 =?us-ascii?Q?HZt3Tsvz8OHMjpX0O1o33uL2LEHo90CkI0YjaRAvLtL0MyL574gmbddhiRzx?=
 =?us-ascii?Q?W5eOEtLcmQTIQuWf9HRP1T1zqSI19NW+5mku+aciJxkifjlx0dspbNus6KZA?=
 =?us-ascii?Q?6bk/h0doGqWBSc0OfBtizWh2MdCvllwh2rM4lg9TF7f7PivBt668GJ4iQqmj?=
 =?us-ascii?Q?rM3tWsoitN7yNrTjtOwmILlCjtFNNMjCnOO7c6wh/xZOgy4Hv4ipETvXycYI?=
 =?us-ascii?Q?4Q5fMsjko1luhQbencwVb5zRCfzyiwlQcLefllrNavyapxk3OhhJxAC/GKJT?=
 =?us-ascii?Q?Tez6q01vFJEEMJU/RBuVzpchyO3lrJejdNAiTTfRm4WQF/O3hR768L7n/ydL?=
 =?us-ascii?Q?4Kqq6hvxqMwBVRzWqPtoTaqbnG/2RpQNBfnMjot12Sz0gEzKUb7I4ShptzzG?=
 =?us-ascii?Q?2KHBsIWGdcehuM1+cDlTYhBmeiviAzKnELQTWzMdIuB7nFr7MtAGVD0vS8bT?=
 =?us-ascii?Q?k2MY34FpG6Y3lNex+QTkBl/U3k0g/uPeDJzyLhLV+joDP8VzrcrOGS4W7YR3?=
 =?us-ascii?Q?mGXvth6uHW2K3yLCjbaS62eN4iMcxD2WUkLTrZfmZFGtk/1VhhFXWJG3QAq/?=
 =?us-ascii?Q?C8DjzUv0hC/fjJkHs38wBf5cDYhhlEF+/klaiVL+iO6fdJDaj3kB6qiShE6u?=
 =?us-ascii?Q?qk4vstcgL2ciHN9NdXZY2i0cMxPZTqhRmFPeqxjIavHIKgEP4Ai3ZQs28QHK?=
 =?us-ascii?Q?4/xrT1eWqXywFWdTytFda5PumH/VQSy6Iwp27gHj0CDcytNyJXzCXZSrBHB1?=
 =?us-ascii?Q?kCdVr1o1kg2UC/tSQn/2PraZmcXSWwtqmwwr9cI+bJvgkisCvqdYHtmb/6fA?=
 =?us-ascii?Q?On76uhnc/DLhrg3RjAiro6+3dhcp/EPqumnHFO9ZH5/IO2wH9P3Zyyb2Eb/6?=
 =?us-ascii?Q?ezvrX3bEJA/MLqJFMvMrVDuMMNgzEEMNLp7jA+pacd+HLqii15v0IlmttuH0?=
 =?us-ascii?Q?E+nf2F7eSQp0H06wSZKvwgwz950CvtKGWMdhTFa6z/kJ9CNS3MgxzohI2Jyx?=
 =?us-ascii?Q?Ynm+Ta1aX6i3NdOrRdoGhIhy8sZTV4p9NP3G2TJUyLfH0yInpY5Hea2XZxau?=
 =?us-ascii?Q?jEDJ7RymUIDVWdNOz8pGrQJYZI2asQd5Msnsi+6TFyDZjOCPaQV6lX9osnAU?=
 =?us-ascii?Q?hIhg9nDsIFP1bHmRYk7LLJFs55GQq62h3NczL/eAGqZ0Q1chIeVujeZnxUZX?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821c259a-c717-4c6c-3850-08ddc9c38cf7
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:33:07.9336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sn+WjDtuV9hNQxBZdzlEGC9okgKHSKWxRxNjHysnVbmsarm3HhjoM7ij5AhVpi0XuXuKVO2+dXm9rznLz1EA4SrWuvIphAN5a926UrRjnKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0773

Add intermediate variable, for readability and to simplify future patches.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index c0bfeafb31f5..f2722473b865 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1815,10 +1815,11 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
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
 
@@ -1857,7 +1858,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 
 	ret = pci_alloc_irq_vectors(pcie->pci, 1, 1, PCI_IRQ_INTX | PCI_IRQ_MSI);
 	if (ret < 0) {
-		dev_err(&pcie->pci->dev, "Failed to allocate IRQ vectors.\n");
+		dev_err(dev, "Failed to allocate IRQ vectors.\n");
 		goto err_teardown_can_ctrls;
 	}
 
@@ -1870,7 +1871,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
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


