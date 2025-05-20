Return-Path: <linux-can+bounces-3597-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06EEABD721
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 13:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B928C02A6
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C064266EEA;
	Tue, 20 May 2025 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="auIK8Tbj"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2102.outbound.protection.outlook.com [40.107.249.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F85327C864;
	Tue, 20 May 2025 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741432; cv=fail; b=Jl3Ds8Bq/w7zRx4fc/NbwBZfjfM2elf4eoBwBqqTuhTj7dMA3PPI4W/7+pfdY5cew5O/TTcrH6xW8k8dqkMMHy4DDxiBXO0yIeO86SZfqSyMQHlvB2Ynd+WqcmVZFrWs79dTYVRYrkdziSWl2r9mkNXcQLCigbz1ujZVXAtUjx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741432; c=relaxed/simple;
	bh=UoTYVpxTkC/FijXffNV6ReF3IziKc6ltQrA4MFi0SfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e79ANStNNfXYoxGQdtUWo0koVJkdK1KezXL3yFxRQtDORzNLhTODnw2IF2nMh1iGBMb+UfBHTQoRswSvGDoJa4NkSstETR33Qwbeqw0nbagNrBn6dfd2IJ3W34hhpmpON9aCjqThxN111vunCUM3UxisiN6xsLvmbUYa1gpSzGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=auIK8Tbj; arc=fail smtp.client-ip=40.107.249.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxSk+JXhBrZ3tL89lG53/PSDnbZwyQReDSu2KdxwWfI3fPFJhry5nYWWBy1q7Gn5FycgyZQkKyj6dNDCAAe8GCYTx74u7lHRkvDhn41zIYRfw8fpW2sjgMbaHBlFjNZM4p57t8W0Uw3paeJ1Hj1Pdug/pVfzJ9kV5rVEKM5oQ329nvEgtILMrEworKXt4rILQXqyCy2HwroCVqn0UmXYR/hudvehQacOVT7KCjvTFGEiBWxy56FBa04ND2gXdDb4lKV06cxPoWFiMwHnUVOGzsFlrHSM7m6oI+FdFWAJQW5LeM5wfY9fDugtmaN4HqKj0Hh6VD5XWkU+xzJ7tmqb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yyNI+/iKwW04Q/OccgFqXsy8rzCOd/q4k0YQ0wpjxo=;
 b=wDojAa4uTSrgNQ9ZQFBQFlIqFqvkxJcxBFUnjd4zQAG7DfZRm30FULZW4HelvkrFZ22q2RB1eQ2IH6wJHP/exEjNjOitEYtJwyk8h6zRSWDmnWbSf7Mx/OxdqG4mU18zyCGSArsRIsJE6ftGZob2s6MR9NUlJ32eiTLD9jOPetlcZzNElSfco7JV2LnlMdpJ9+loxputRYO1lZUdjSyTbTFHI1fp7Re4lwYiXfZ4imSMecH03eWGYb6v2a9DEvDvJKntrB38yp5b4S1X2BMaiA2J3povSbQTBCAgCsZXfD0+ux9eVlHZ3CcKk9LJr+VrJVXWTcWeIzS0zVVbO003gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yyNI+/iKwW04Q/OccgFqXsy8rzCOd/q4k0YQ0wpjxo=;
 b=auIK8TbjUdEpkgHFi0LLYAOmx4bhdRV70NfnJ7SudgsQWbbXnRceDu5ONBhjUFcbW8C+EjH1bF9TPNrL8+d7aO4gA+xmbdKywClNlPb0YwOfEaOTCgF3lOim+qqx/vwKQJ8nZvw0WcQBl0s0jn9oRpUkwZfzJ/9RoKScqR6Mu2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::14)
 by DU2P193MB2226.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Tue, 20 May
 2025 11:43:43 +0000
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18]) by AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18%7]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 11:43:43 +0000
From: Axel Forsman <axfo@kvaser.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	Axel Forsman <axfo@kvaser.com>,
	stable@vger.kernel.org,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v3 1/3] can: kvaser_pciefd: Force IRQ edge in case of nested IRQ
Date: Tue, 20 May 2025 13:43:30 +0200
Message-ID: <20250520114332.8961-2-axfo@kvaser.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250520114332.8961-1-axfo@kvaser.com>
References: <20250520114332.8961-1-axfo@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::34) To AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:3ed::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1652:EE_|DU2P193MB2226:EE_
X-MS-Office365-Filtering-Correlation-Id: 620e0d9c-c803-4e4a-cf95-08dd979392c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IH9j8RuGSNbkYHeFD9ofVpox6Lp/U9MMeklmjItf0wrK3U2Fu6CFlEqMKNq3?=
 =?us-ascii?Q?VIDu5yfpjm/rI2Tlg/QJf73K86G5y77zXhjtYkK75OvC+0/gFMwzf8zDZzf4?=
 =?us-ascii?Q?I0a9M8lvlL1vQhjhXVXWCWjPlKT5CPArsUU7mb00v6xYbhhmNQlrR8iW0tjC?=
 =?us-ascii?Q?oymBXAi3CyeWqyDBddh0Knl3rArehDQYTxm5DQeZuxJXgTEfd43+PDwQIADt?=
 =?us-ascii?Q?uhWP3qu7tBMF2qP69qbAmMy9RdNkz/BphRRinVE87R3H7MNwftZXAXO1KIbm?=
 =?us-ascii?Q?lfA8jZ5qv3YnhAT0rzyT0Ak4DBEdvhg+Wt0eZgJHk7I1W8Xd0NeODOvvN+j2?=
 =?us-ascii?Q?jbUvpfcgFbIHcZd0qQKlgZALlRGrdp5mMcA0Amj4oZmdzPrKyDZIoDHeOOjv?=
 =?us-ascii?Q?Th89uwjYg+WKouGpBrncsEdcBTLtySUhKTM7B2AUtdv89uLuLlLJN3kVkqtl?=
 =?us-ascii?Q?iXkr4lO2jJsdYtOs2OxchEgJj/Q7MfdwUiG3bRObsdGRKEM7X70SR92e9J1L?=
 =?us-ascii?Q?BzFEegV5si+d1C9oNZfZ83raIiS3748DjSt2FasbCr9Xi8GNHGKmFwW+DBaX?=
 =?us-ascii?Q?F1lsvWMksdNf5MQVA8YJbB/N39ENES5Bxi4+J/KmHRvnNK7n5nWDjDEqXU7N?=
 =?us-ascii?Q?f1WC+7+g4ngyq/cTXngM6UpX2uCH5pOYq0MG5JRkiG5hdXtntSdV7NcRQq+H?=
 =?us-ascii?Q?g26GvVoEfysXFV+kgZR0xo102XzoQNZI6AATBBdu2lN21/R14IfnJkzo4Nln?=
 =?us-ascii?Q?dk4Ut+Cn8tzsbic3RLvGlrO6RcVxtmI8UqGVmkYlH6SwEQyn5iwTyA0Df7P7?=
 =?us-ascii?Q?owM+aUlhdqQtzcMhhHODyOam7SIww7XKOW2EMPEmQp4pKgIC97GBSxtckbgp?=
 =?us-ascii?Q?m4sclkVQYGM7EYxYzNLHBQ4Av6Q+lOlEmbXmg4/OxNzNIATwLORD1Gmve9Mu?=
 =?us-ascii?Q?0xglZYFk7t1h+aVMIFok6kTjXi6lACNaTpCLRUjXYkwmoHN/If636mDTlS9u?=
 =?us-ascii?Q?8cwTCbR8pAXq2lHmTSFm5GHZcB3E70tWS5T0v/lSFrsPgz25rRVpYErhFegX?=
 =?us-ascii?Q?9ikaQrYZBCaf5Lr6KiPyGf4L7pye7X5z4Wec0X50UcIv/KZxXokthCADsTX8?=
 =?us-ascii?Q?BrwXHAYvhBASHUx0n/9IQYJYUWXPkbXBHus75tkwnwXj1pecFkZH2iA4GNFD?=
 =?us-ascii?Q?er/sMKPbE8oeZBolMHVqdQvfGJfkm6qlCkvsqEFTFGL79bYcX0Q64qF3k/NV?=
 =?us-ascii?Q?r6iP+/ghQ1W1HleaZpT8W8o8UFV8MPrMjZaiRo5822fWM3BbwmvC40pRvMjl?=
 =?us-ascii?Q?7Ru91zkOCHZ0ABYePS5EXV7bi4k5SxtvrgtFYY1/wI5HC6Zz3vYjLHXMo0Js?=
 =?us-ascii?Q?8OTveQlOIIsBocaFaU7cLlD2Mpdwq0JiBMZu39tnSHyRjcZXokDxvmBhzenZ?=
 =?us-ascii?Q?vvrtgMK8oZ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1652.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YmLvJAflA3zLV/tOZHUiICDXLVKZMtkRShXDxgVGI9MVhGkcoAUrZjtducR3?=
 =?us-ascii?Q?K/oruaImnAzDCA1Zlfh+1AevKsfSgXeG5UBefgFAZ0TkMO+v18O0NiyWSX9+?=
 =?us-ascii?Q?WFIThgtJTpOLTonXuzwzB5yqAtO+35DYqF19zSuORLvkO29BOFnh+erXvZCL?=
 =?us-ascii?Q?aDHDDuJb5q7e8NFnzhWNQXvWvo68WT5ck0TCcZXPEUazrLmb0/MTQ8WG+PSQ?=
 =?us-ascii?Q?0KjVhX2NgDejGyDQA5ri6Dcbsm2xi29TR2iG5sGfN90cuDwpOVoRg+8WEfSJ?=
 =?us-ascii?Q?AxDqDzQ0yi51ErigeLXGVVFghpSoU3zGvfnNJ/gofNXXJCiiuRR8ZXDeHDco?=
 =?us-ascii?Q?ke9BMRcYLkyEVYwP798rQg1Zee9eQ9dvNPdsqd+0OqEpW/lnYFoCEhHCqqKH?=
 =?us-ascii?Q?Ad8BK+Fi1PXRmafBUqhuV3APJhy2y1GVhELSIpNTfuZ4AuUaQyOWTuKs9vhV?=
 =?us-ascii?Q?U3dje4dT6B19D39ux4gIsHGMV+p0oiNWy+aQPwqSsV4T04TF/FLuuymrOhkW?=
 =?us-ascii?Q?gk+/WYdziPuzp8TNjdT8kxm6safLLdol8WsGEZBSam7j2IGhZhBZLDXn9FT7?=
 =?us-ascii?Q?l7o58pJ2G/61aWQXQyTEPfS+4Bley4huOjtrGpJ3QBpZKsQJ7UI2x60hqDy3?=
 =?us-ascii?Q?PGnxNkjrwkg6zMDDVeikT2DTg0akJYvfA0WT0SntjbToFswayT9sO0BOHARE?=
 =?us-ascii?Q?NyEYaAbG0moWEl/VfFT9fJi2z4tYkguJ9uy9qm3Q1y5tG9y+X/iWLhrcwouI?=
 =?us-ascii?Q?BXgy4JK7wkfFEh/SiOYLHr5bBi3VH7F9MnzPbjCl6gs6LWhzOP264HwSDuPD?=
 =?us-ascii?Q?VlMTpa3wGxyyqu2K74GwpjPzhuerYOwJIn5qH9mwvfaLHuwqTxMZ4iCR4QuZ?=
 =?us-ascii?Q?dxZy4Mv1k3kALK7QeZfL1XLXmDh6njP1ADMmUhIIIIA1Udugvf15zg8oKm1h?=
 =?us-ascii?Q?DeERbeEsJTcryqKfSrZ2YewziSPoJqLthtIUoeTbCqwKsVPnr12GvVk4DMc3?=
 =?us-ascii?Q?7iYmHqnXgfgkeFrfSnhjA0pjOz8X7PGg2e+8UyDlfPUQ1aCGfV3GPtVGeT7B?=
 =?us-ascii?Q?bOR9AMZRAdxARosW+6o8Jur66sG/kCWGDPFCkBwWLmvdjimN+0D9QnMMB6Pn?=
 =?us-ascii?Q?rakUXmoRtPaHWuI5zvyi0L+qCB1XXERGyt504hhjWnEh4fUsiYZ15ickxXtB?=
 =?us-ascii?Q?WIlvCz41wFQlNfQG+InG2wxbxSbzQ2GuNO82EYWQ30+KngFDNHivg+s1BjEU?=
 =?us-ascii?Q?TY5mhm8TVK59/tNcAFWR/Tz0BpMRElAxX7n796FoTRYgiJmUpCsEpGUYUTYq?=
 =?us-ascii?Q?fPTai6vf9ZN/QUUvn4hV9eoG6lP5DslOsiPN2MWbs9lFCcO5m7Hb55ajbMZy?=
 =?us-ascii?Q?gqsopBm3P2ZX9s/GMYyG85ewzhylprS4181Rnh25c09rGWhyIJ8vCj+eyqkb?=
 =?us-ascii?Q?Cj3x3LHaqJDESFbug0XBMmBXrw4ZX2Dj+q3poAVHGVOLBxV+ETnplsRt4Kq8?=
 =?us-ascii?Q?Zl6UUrB3aLiyY2juMtUMUnxb8JD4zSSVsTyYfpdqFX9ZsrQfrwIvScSgpGBd?=
 =?us-ascii?Q?VHn9Ilr9WOJQY4vMkRcD8M4pUClReEucKqB9Rgt/?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620e0d9c-c803-4e4a-cf95-08dd979392c6
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 11:43:43.6759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1DSV1KqNA1xNS2ZCEzCzhHBxlWc7z/r/k8fsWhIOS6HrP72xfy/p3dtvbkSUOXCueiLfeSEwRTTqeGJfqZbPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2226

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
index cf0d51805272..9cc9176c2058 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1646,24 +1646,28 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
 	return res;
 }
 
-static u32 kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
+static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 {
+	void __iomem *srb_cmd_reg = KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG;
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
-			timer_delete(&can->bec_poll_timer);
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
+		timer_delete(&can->bec_poll_timer);
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


