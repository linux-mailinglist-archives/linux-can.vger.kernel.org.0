Return-Path: <linux-can+bounces-6903-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOhFAtF0qGm5ugAAu9opvQ
	(envelope-from <linux-can+bounces-6903-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 04 Mar 2026 19:07:13 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D25205C69
	for <lists+linux-can@lfdr.de>; Wed, 04 Mar 2026 19:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CD1C3084D4A
	for <lists+linux-can@lfdr.de>; Wed,  4 Mar 2026 18:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8073EB7E5;
	Wed,  4 Mar 2026 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nrchjY3u"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011068.outbound.protection.outlook.com [52.101.65.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00763E5598;
	Wed,  4 Mar 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647245; cv=fail; b=PFDPbd1CzBKh04GirUs1/FV04nerIZBaMAcZl/3Ez1auXsLVOiloEzgoDeyzb6k+/yUl4JMp6EAlrEg9280A6uAesjCf1ZduB02Ix6QfGNg9AJUbtKlFoktTZ3yJfFV54k4DfrDCA5ut3XtG0yNJ7d5ByZ5yDweVHwBc39SVHSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647245; c=relaxed/simple;
	bh=0ONnWnJIxHgCj465IIwUJn/EJAL0bH9obUpGo9U97fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=syz1yG+tkXf8FRAPZLcKx0s0ihD3TIZzNGmxc1l5+FKCVIemNSFr1EGckeYIuB7KLxlHa+yQtkhgtGm4tBMwXE1VDU6dNQn3kU5buYgki6/o0RRED4pnUbSeZEL1wPi7fYg08/siwVP5sknbbhQEcSiLZKmIUdspfCvba8ZeCJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nrchjY3u; arc=fail smtp.client-ip=52.101.65.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlhztOeDfq3WkQ0JSAhIr/Xetv15UCl8iu6HlHqpEJ+KOwjIPrrEqag8ORrN8bncGkbZ+N4UtnWkfpih+ghgUMERRgrzTClIn/ZiQFbO65fKMOufBGQFnh7pnccndhx6P252EsF7tCPcIdse+q3Fv4mKVJ3NdlNC+WRRLDII43Xnxn7iFAZqOfI/FKTAzyyX3QqnLAmg5BEY3VAzoDEhYsNbRp1MFaMZHzFrbvZSG+mlzr2tzfyO9lIWkzxG520+rEEVMZ9tIHOYeSVlgdHiDa/EAAGj7952GgYrN2yoZfRMm22r1iUmmefX7X2oaEA4CnqcX2vE72w2ep4irWG75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvseH+DchCJA4/m0bWxRM8AHmxdvz7JFBnrXAdx8kWM=;
 b=nYEuf6BZiLG9nPZK8WMydmnjv5dKqG1CposkeYbvVkCw+21k8dly5TqrcGRBYw31jMA9CWJr0u7Kx/QBb+8ds1pqYSYv9bXYFXkMOrI+Nt2JjLJeEC0Vk3IMQGu3t042lXvk1JO6uoC/fZoa3Naju4vLpC3vLdRbEK/rdcUCUCsZNNg8UuM9RJ4gUGDoFT7kUpJqp5SjkZbQxnQ7JF4OoyjeNbu1xmmVeqnZpNZ5krbO58vmrVYcGuQgmJVoIeQYLDkoE6CIajk9rp/FW3q+nGLzSfTZApdX0Zx4BmJHx5SPkKIRSDVilWFxFRL3yjl9ocsO0V4/nDG/a4m8UJGdXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvseH+DchCJA4/m0bWxRM8AHmxdvz7JFBnrXAdx8kWM=;
 b=nrchjY3uirrTY/O8vC1inRRanMVGY+3B+HfOZWpcz6Op6NSXWGDetPfc715o0xsIFMSdF4Pbrz40qlkztgKQZsvV+C2v80t14dllfuaNrkPe4IS4uGV9W+lSK9OzE85GM6Ahc5Z1yf6DpHk8hQXZcd9kqRart1j2mF6TDi35EN3cl5OFsg7mpWlUs7cjW0AUpqnRv85S/CKuySVfEQNoohHfebdW7MrtUOAj0HiCAQTzllxeuEOtb7X67ISA1PWB3rR3eXIM0W+3u+If6UJ37rIx2gDR1zUdSrC3OgNIzwZH4+QqmteNKMntoMAJoaDtSxhzpcsRtUvaJ5ZtHixegQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV1PR04MB10275.eurprd04.prod.outlook.com (2603:10a6:150:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Wed, 4 Mar
 2026 18:00:29 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 18:00:29 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH phy-next 16/22] media: sunxi: a83-mips-csi2: include PHY provider header
Date: Wed,  4 Mar 2026 19:57:29 +0200
Message-ID: <20260304175735.2660419-17-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0030.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::19) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV1PR04MB10275:EE_
X-MS-Office365-Filtering-Correlation-Id: 59663b04-c951-4a91-1294-08de7a17ebea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|10070799003|19092799006|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	TETR5I5tsoux9hBPCux5AR2+M0BKyxAdsseevqd97xflGQ4Y2Trb1eCNzjZcTOj92HLUtpcPDEx9J8sselZc5FHznCAK05MBpawu8Oznh+MapK7J4nA4yuNzdTCDIipMJVm028MioWZ3vG0s/EgBbXVBAPWRpIdp31eMBz88V7lIvbAzOIzMaR53NSino2X4WvyoOOer7a7A2D47Sj/Lckes35DszDqo9IoMa0+4iV6HcYXBp8J54kvHV2NW9LYoOd6bm+liNnfKUKJDNfkHiuIk0+lexoezblLhp0J9/t3NSqcZzvuw0BPEvK30iKyoEs+PfMWC8I/Jh1ZOsU0c013mlR5cwKdOwtrlOQ+2xuQR1CSqCou8pZK5/CKVeRK1hA4vo5UuSx24WGoQ9uZ2XiqY+wKncwdLFfrKY7/DFDRgjMWyIeFZAzdf6qqshGvF3qVdfpO3arFXy7/sLOTs/bSoKlO3vdGWV4lC3wAmI5y6obJiXFRrz8UrxvtLBOpYi8fHbJhe2N6QjvYKWuE+iskGlqVlVuKrB7kicteMCXO2hm4EQh3aioEK6TV/LrfGZez6peDfXv83n9hovv+IQg1nAIStB3/Tgd7Mx1mLiX8YUdL1MfzMh0DgmHArcY/TiNNWJIwD/1zBwl/ANxUsndwrwmtrdIx4OWW4TMwQxcmGkUA2G3yvGncMUEZb5RwvOPPoBXhclB5CXlJzXZgW0NuZHp5HwM4TYD/z/7LUl6Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(10070799003)(19092799006)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K0WiLWHy70nFhr7rLxL6/qa0kEdljM+MO7T2TEKt3Hkmhr28ylIl9M5GuHFS?=
 =?us-ascii?Q?Gu4oVTFF63qCzsbfPcmu/e3gCP4bhibUA8n0rivVGfTMCUya/U4Amk3LRsjw?=
 =?us-ascii?Q?c0S9Iyt3Wd6uoxatB+RA2KjiJmP2vdqSa/+bWYkI/T4IFIFVpeOBuOcRifig?=
 =?us-ascii?Q?5sE3QwxgnEj0GN2m7VXfKcPP39V5J7EnzLKlB0qAD76wS0i43RAo5ecV85eR?=
 =?us-ascii?Q?pK6qTzhSqfKt4Sjo1yu/1zhsEkW6wvgaGZ2nGkK+ximqQ8VRCLmOe7yaJ6Qi?=
 =?us-ascii?Q?YgbOD/jBAoyLIrTJAd3mUbgeMtYjhOxnG1l6pFcsgvQgePlOm2uSsai8NFN+?=
 =?us-ascii?Q?NMFVs3fR0Ql8PAP68oGLeItUg9dUsKzr+hZY93A+VYmYcg76QhQrZTReh7uV?=
 =?us-ascii?Q?uoz4tD12cgWinu+XygNdMqGb2SpVzBoj8mYO70v2k5FEhzpt9xwV+cmh36YE?=
 =?us-ascii?Q?Sf5wBatzoQFWZmdtgS6ZXgez1wL6g29kLvn/DxwIXEQJHm7xjYqNm6OVLiPv?=
 =?us-ascii?Q?82GH6pFHIG7lvbIbdiR8QxC0RUycPO2d75sdkRQqJoxJkPunaOBXOFUcRcvr?=
 =?us-ascii?Q?YzZGmi05NkHTJxj9BJpfRcaeQb+eKoTIT7ud93g8DD4LOXGl7k2PrLHyUCsM?=
 =?us-ascii?Q?kRZrODP1o1OQWDcPgk4aCCU74RL5+zlfQX30u3e+a8L4TV0GqaS/9paerI50?=
 =?us-ascii?Q?4CrL/JN1LsPB3B2IEw3Gew9Z8OkFRWvFyfcY0MkK16b7DBQtFztxEiDCrJwZ?=
 =?us-ascii?Q?cbnQEOULXGWHNQAbHyhWO5r/y4FsjD2ivq3VnMQ8T0FjHqI72x3ERJ53+aCG?=
 =?us-ascii?Q?l7/HN4pOjwr2Fnixn34X6bEzG58ACdnxjTmiGlHPVw9HlQ7Mpt/k66mbmrjV?=
 =?us-ascii?Q?XRx5EqjOVgOxkbweDOCUlQV9AHbg3N3GIKxhcv/ePnRnBnPfNTlHEF2JVJBr?=
 =?us-ascii?Q?PyV+GaXNi0OhkjQEODrJhWuGSpAua0kxx7xbJb1JXAfoEZXNBGVFviHBOgUq?=
 =?us-ascii?Q?kfHpkwwW+z3gE+pD+u5jEaBuMAxqFuzjykucvGRgl9UCUxLejtNSwcoCGES7?=
 =?us-ascii?Q?kEOGn1lI7+z/BOS7ahYPx2uGH9CJ+13KiIfYaaaHtDfiNFVWjiHgpw8G8VI0?=
 =?us-ascii?Q?DFeVKcQWmEWu01Ij1qrVQCT4pAt1CvrZheffEn7thPQL1lTpUVhLToO2NFDu?=
 =?us-ascii?Q?tCqFl6ExWoA/SwkBYy0YHUPgUMUyz2gc4kSkvDYF7YTwuNUHl99yjvc0baTe?=
 =?us-ascii?Q?K0BOM0GUFSwtn1lQenEWznLmsMtZSVwz0czdVh2Of+EomZFKhTj4k1ZP1vCV?=
 =?us-ascii?Q?3KH8ZoFAeSArwoQwtdIg5c4fhd1C+z4w5E+FREF2A9tKr0dHtwAFpAs2YCmX?=
 =?us-ascii?Q?kDyQi/GkCGuVo9l3uZRJn3IfcABlYR6UFaB31kVMPKo1tEsxIzm3gmDHr2vj?=
 =?us-ascii?Q?0OfWak3zMHKz1CSzCDNb8gZ32Z7QDLG/ytrMyEndjYqzRBpnPOAjBRkTPzFD?=
 =?us-ascii?Q?5LHamROuLCjfJHm30VvNZN9hYYfqXatf7UrlaRb51evU4Pw/EsKFtKAinAe8?=
 =?us-ascii?Q?I71qUgPj7n6SqFAOP4Q4RTEmwmE0waTw5hjbYVWa0haZJjAamxINgFavwixq?=
 =?us-ascii?Q?I8pYXFh6hZUFZToqrSZCN7PMTmI2fiBDEPuxxLkuGC5+KMlTX0rs/fR57Qn9?=
 =?us-ascii?Q?p6ENQAUY6K6Od6ruxhcZpqxSkGsPDUAoFstrFz6TNdeKkc8i2M3AZCyKTvZB?=
 =?us-ascii?Q?KzVb2kLkhFp9bIVwJjMa/LD16Ey586PNnwVlmH27FKsU87n81lo+5VxWx3mV?=
X-MS-Exchange-AntiSpam-MessageData-1: M5ma7y0YFofEAkZzlsA6A3doN7c+T3jXMmk=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59663b04-c951-4a91-1294-08de7a17ebea
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 18:00:29.6481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyfHu0pDak9Rknd5aS+QhA3JdxmKtfEhA7rHUdrqyJ0PkCVuDHctCEOVdVzLhzDhNUzoilOG2GWBP+yS7BU65w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10275
X-Rspamd-Queue-Id: E3D25205C69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,gmail.com,sholland.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6903-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

The introduction commit 576d196c522b ("media: sunxi: Add support for the
A83T MIPI CSI-2 controller") says:

    This implementation splits the protocol and D-PHY registers and
    uses the PHY framework internally. The D-PHY is not registered as a
    standalone PHY driver since it cannot be used with any other
    controller.

However, this does not matter, and is not the only instance of tight PHY
provider <-> consumer pairing. According to Vinod Koul, having PHY
provider drivers outside of drivers/phy/ is discouraged, although it
would be difficult for me to address a proper movement here.

So just include the private provider API header from drivers/phy/ and
leave a FIXME in place.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
---
 .../media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
index 24bbcc85013d..1143feeb4fcb 100644
--- a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
+++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
@@ -4,9 +4,9 @@
  * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
  */
 
-#include <linux/phy/phy.h>
 #include <linux/regmap.h>
 
+#include "../../../../phy/phy-provider.h" /* FIXME */
 #include "sun8i_a83t_dphy.h"
 #include "sun8i_a83t_mipi_csi2.h"
 
-- 
2.43.0


