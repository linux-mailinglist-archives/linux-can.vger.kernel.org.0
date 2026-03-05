Return-Path: <linux-can+bounces-6956-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DObGnilqWl5BQEAu9opvQ
	(envelope-from <linux-can+bounces-6956-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 16:47:04 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E01C9214CC1
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 16:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7360F31FEF7F
	for <lists+linux-can@lfdr.de>; Thu,  5 Mar 2026 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C0A3CB2FD;
	Thu,  5 Mar 2026 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CtQ1dr6G"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C5837A48B;
	Thu,  5 Mar 2026 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725151; cv=fail; b=CuYRus3e8yrUoMi40xNQRbyV7NywzN7Iar7KXnI0SQ7QER52LowbFDZagqkpe+zizqdOtnRDt0i6MyMWnjxbhvNScgEUWv3dcxIJzmTN7WOw5KiXXEtRpR4/JvCUIwgM6v0At5b1N9SMmpq6YJvjQgiLs0P/s0U13vGWQNY6b+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725151; c=relaxed/simple;
	bh=q47v9BbGQq/sj7zMg/MHx/gEdHsEN7c2D4LLcu3Co98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F4Bl0DNuSKQfL/DBYSxbFNEXO0XpvYE3I5GvyCzx3JdgKAu5Be+S/Hf9Bzfo7VoJIJeUrkWxJWz1iiPuU0bB8q5ZbNwTPhkG47b51Cw9OIshx8aG9rC6rcwjs5+sS456SlCJSVj91hFbYVweCM7kuKTp61OJmygzmVZ1lTzlh+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CtQ1dr6G; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5Qe0XYvuKejclY5c1ac+RsV1LOU/59br7thbS3kOpXUv1w/9zS9yCkC3IFPbI9SgJHeD67ONHqwGbUwDR4cG5OxFjr8YOFDMgbEVZ1Gz3ASzfhOOx/6zU/tDXZgxBeX+bEnHz30lUkOAZXO5vRL6gD7DYMJ3DBAIhAeA74iGJyW83db/oBzCbVmwfQjDDmw+qiJBw81sfGDx+dtAnQ9kJm9Y754v0h7NP9N7ru/ZYnEQUuxU6np3f8V+nqzAiToG4XGAANFR3UA4bmHSlf+cOclSuDtFDd0ApbNLYnj7oDK5GiVF6IM1v+Anbr43iS0LvsV80JwdR0Fh/5cxfv/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VxRin8KysyhCj02YvmusAAvE6mSgs4Oip/SOYxQ0OE=;
 b=PF34aEwM5bomFdJQn0UBl3NmHxZh3OvN+rSfhmyFUZN3py+PEu6hgGxwOoSSR3WloKKzcUWN8NkwoZxjsAb5txrS7xeFxNTiIWAxYJTzkOZLNKRnYkG61R8ybp7Q9SkPRcLvz1g/sTBqIqgSiBtIZM55+qa1/moRGZV30b6XvscnXXbc7WZHwBRZgUjX69Km7gnKEiOJsC9lQRfIphdx2/uTqnBe1Vi7APqE1V6a8OKCeWt3Uvv2WAD/iQzgt1u+mcXUE09SrIWR1x6qj+CCYMlGF8rSNLehko5NYqgCD7KWOf8bBq3e5tw+Cb+3v3/T/KnSr69v/SyorBMFZedObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VxRin8KysyhCj02YvmusAAvE6mSgs4Oip/SOYxQ0OE=;
 b=CtQ1dr6G+1B+9JaFSczGV3pSFQJDk7i6UeTlyZ0CDD0T+kVfE6vTeB3L9lIyjsVs1yLoXRWByvI7NU7ioyQKacpOTYabKQhrfvEWt+XwaSzpYjbH5RGxgXz9UTNUhuNqeJl5Nxa2JzE5G6o+M+UG//OkeBHd+YJOoc3jU3XRiUWH1MmMhrml43oFB+zXgx3xx4qi7WFPlXsz6jvvT/X7m1vudklv5EymLOi0C4NmWNfJK8CsTfsyXr2uoqreWqucz0P05rAJ2XvSTg/2QbeaUcxc4WOnw24nAONJQcBqAlVWCUhQqtCU2jCNaLZJ+uQ+G+ZXhI/3BqP1ewbmdZ7O3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB10921.eurprd04.prod.outlook.com (2603:10a6:150:227::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 15:39:05 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 15:39:05 +0000
Date: Thu, 5 Mar 2026 17:39:00 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Joe Perches <joe@perches.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH phy-next 22/22] MAINTAINERS: add regex for linux-phy
Message-ID: <20260305153900.uyqqux2t42xr3n7y@skbuf>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
 <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
 <20260305085148.7cwo3yflp7vcfldf@skbuf>
 <f3a5aa3df78553ffc0fd0024f5fd36a4e2158c88.camel@perches.com>
 <20260305114352.2f7btqixg4tu5bzl@skbuf>
 <21e84301a7c37f9d5ce6f0ddcaed7846174d2a4d.camel@perches.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21e84301a7c37f9d5ce6f0ddcaed7846174d2a4d.camel@perches.com>
X-ClientProxiedBy: BE1P281CA0483.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7e::25) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB10921:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff15b9e-df10-4470-ef76-08de7acd5591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	FkyR3+2d8pwLLbtASKz2BTgqEsbJZvyd4GL0UGrUhNc0uOLPRsCW+b+q0hrHr4epSD5rTHOz6p4UhHgsqoe3CTRO7Ofb04Awpv5qUmutwDpw+aujIj3iNFNuIN9mv6Nhza7vgdGf6jg44RU06GEzs2MjSYblRu2/q9QCG0slYBkjtPJ06a27WmveKJ38GUILSJEbBPilYAcLmmWT32gx1xujFsbNANqCkXck6zUFVT+FX081wROqyA28XrSr6V6Ms+1gFX3cZbhKAfo45px6isfWMw2U+U3IRbk6wkmygice5DZQurzgA3OfMXx5H7sMUEapFvSbJbC1CDBYCV9UbKiL1SGP1NN3Dz4++aO/ooKk/tKdjmjV04FhJ1R26zW2keEwrgJitR558It6j30sb+W7yUilcgr4kjI5twd9iwCr0vSnzqDJCQWYjuLHg6nVe5Ha3IIyyiTd0SvIKM+kh7uofQJkbqteZYYoW5teSlb0Pfs0vSMvZb9nFCInxiGYgluOhPlZ+3y1mCuqD6NlTrrgU/Ruv5rq2XqjmBRasOOwCBx1jYxEw8WAT9MFzTCzkR21QFR7VMZ9ZFf7gy3e6qcmXIc7e0ILc9tCkf39aEJ4GMHkWb+Th+yaFyz1rGM/vhgM1pWRslseBeYBnEPYwsQH2erWvGm12+lJTjV29uecJ4nBrXERjZoI6cmeD+TeQlnOUwL2BrxXFTQJCbB1DV4QarOrS8En2uR1L0hwmzU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iV0lPw0y46EBJuYnuG2g8xGBML+rAX4quNQ1LeoxLBVd5d4+dkFezDUjMy6v?=
 =?us-ascii?Q?q6eE6JSimNM2h1PhpYS7V4MdA6cimUjcV7PuUoRfr8+HuZSx2bwrUixEjDXv?=
 =?us-ascii?Q?U2uoz1AlanH3dbKDQO55Rg1QbNv/NNoMEXqWKJNGtP4zmmcCUMoGnXptHEEt?=
 =?us-ascii?Q?+7HelXIleaW7iP3S4oyZmKxZKansAdagtb5EAE2dHMUiPj2gwzDVt4wL2Wdd?=
 =?us-ascii?Q?7ovQX8qOKqG9YV/m10UtzzHBr6U6cqFTm7sSmsYHZQQergp5b3tH1XtjpInk?=
 =?us-ascii?Q?gcTILtAESx+UcStHv7II6vjAnrlNecFZDjdcEjebyl+eFelz08QgbJFfOlTG?=
 =?us-ascii?Q?Mcy9k4yoWkI8R8jeJHnSXP/BDMQGSpAIfs9c5z3ugHl62lwfq5Vju+vp965R?=
 =?us-ascii?Q?tcQnJ9PgSMbRxb4O3mATrf5+YaAVl84Nsj7r/Ft8o+lj9tCyWEdBqI+Ym2Mi?=
 =?us-ascii?Q?vWC81HLz1JeA/hG2Ipz02GVftqAbC/JrAQiV3RenDAiZqFxfp7oU5H9F2YTh?=
 =?us-ascii?Q?sFf3x6u/lN6LD6lPadZ6MgefdNABC60OfjWoEkHd78KKVQVHcfvafVYCdQAt?=
 =?us-ascii?Q?HNWLzzK3lor09ZnTGYK//ojg/+Rh0L7dYQKM+BXtlXxHy+m9v/s7/vjDr2iD?=
 =?us-ascii?Q?BIv90byvKLhaoMUB8VjU722mNjoUJP6LwHM6f0xKqWzmJ6P+fVGXjs/G4Miy?=
 =?us-ascii?Q?wE100jUSpIbV5Fdw7oZRW4bk7xgbdbAPdcJavJ0X40CtuAr3m8C1GSr4gm3b?=
 =?us-ascii?Q?yo9AIfK61JyUBdpmSOJVs+a/yXz6ygGxTV3WqNTWR0zSpELG1tHxsnX40Caj?=
 =?us-ascii?Q?rgbLz4JVvhBUJk6RN8C2oSMoXCFHMyyeSFcGKw01U/8X6ePWNZZ5Qui5p4mZ?=
 =?us-ascii?Q?EV929FRG1565Qm++3OEUR8GUBVESbdRi+LspUdV6uawV7TeS2EYfMtVlunHl?=
 =?us-ascii?Q?UD5dKrSpZfh68n2q6/EpCi4499FzICqumeuoePQIWnFgEWb1ZF4OTJb2cmKt?=
 =?us-ascii?Q?PpE/qpdbt4lwvCCRmuPxRETgZL4CFdc/UKDIIsE+zuj3CQ8X64hu5qEJigGI?=
 =?us-ascii?Q?fS3OZ5x/8bcXubjRqCL0ibYcR8PGUqesezdF0bZtPDpl3ld3pP77151FwWVV?=
 =?us-ascii?Q?RfzP8lSpfQxyqwk1h+xz08dFfWkEbk4sqIxkP/DKbvLYdZDaTTUsj+daglIv?=
 =?us-ascii?Q?Y6jKjBXWCBvlr0nw3gWZXy9HRtU7dpAZDI2AjIayJf6YBVtck9pkl9MLPgQ3?=
 =?us-ascii?Q?P0CAxTixPEoroxpcmX6VOziXPwKKQGEMA3CT8LVdpNJsX8oTEiAkTGf9ncwg?=
 =?us-ascii?Q?d5j/YVmEDPvFTVtc7fQz97pfRrX3BCNvyHSq+rAamhE5q5g3YnZLc1MyZqLY?=
 =?us-ascii?Q?thckLqDOt9+0dHivIMm7jRkilWQh4PXybPbiPVg1qonghlWfu7kKlBO1aFdN?=
 =?us-ascii?Q?Yvh+2Ayl8UBzScFUs/PLW7klA4ojHnoNuUr67ESXughzM0aI7AE6UP2nZAJ9?=
 =?us-ascii?Q?YM1VVmFwe4RFOUpxRqXJtn0HKYF4T6MwQhEIrNq6Y/vEm9zXF5hZoIPigxPK?=
 =?us-ascii?Q?txotDVaGinvPHGMW7vAFfrcSi0ApGdA3K9Abl0Ur6hYJE9xwjypUPDOhwLua?=
 =?us-ascii?Q?lcTQYplKK3p0Z520OWGgoO3j4TMi9ESaA+oTdrucEil3/hwPp0QTw2FJATcw?=
 =?us-ascii?Q?38DB+I+lN60zFVfNV9mBC3MMxVnPfAIrv22TxV2Ix8EwPI1exGBuUkbDZ/hA?=
 =?us-ascii?Q?qppDUW9FGh04jO9HwcRJvk/J6te6dknqGGFEUuuJo/u8D0S4ZOKcOhAinQUc?=
X-MS-Exchange-AntiSpam-MessageData-1: L42KdJAWL42DGwfzmwW450MSH2j1Ny5hY1o=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff15b9e-df10-4470-ef76-08de7acd5591
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 15:39:05.6675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0Yub7kxEcJrbEz1l8Gc6U27EDpqI+zxMjw6lOfytBUufdrLeSxaBwjSX4BXpzXEg0Ibc6hdOLn6hASyKt3c9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10921
X-Rspamd-Queue-Id: E01C9214CC1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6956-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 07:35:54AM -0800, Joe Perches wrote:
> On Thu, 2026-03-05 at 13:43 +0200, Vladimir Oltean wrote:
> 
> > K:	(?:struct\s+)?phy(?:_ops|_attrs|_lookup|_provider)?\b
> 
> You have (?:...)?phy(?:...)?\b
> 
> I rather doubt you want anything that ends in phy
> 
> That matches words like cryptography and way too many dts/yaml files

Yeah, the struct was meant to be non-optional, thanks for pointing it out.

K:	\bstruct\s+phy(?:_ops|_attrs|_lookup|_provider)?\b

