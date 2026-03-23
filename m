Return-Path: <linux-can+bounces-7220-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG3UJ4MswWmbRAQAu9opvQ
	(envelope-from <linux-can+bounces-7220-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 13:05:23 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B762F19DB
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 13:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD5B4302DA1F
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 11:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FC339A075;
	Mon, 23 Mar 2026 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MJu7oyJi"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011071.outbound.protection.outlook.com [40.107.130.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AE33C07A;
	Mon, 23 Mar 2026 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774267137; cv=fail; b=EHawtDxPSEQ2sCvTUg/CI1rfDX/jTOYplILK8fe/I2PMlVI0B4AMJdcHQywjZbtBIYBZXYaE3+62qPuBADVsjsMnMh9bi/JTVHddpqwVvotK6Pdw9mzSU6POlOKQvYrvH2OPar3ofSQsPVmt7P3Czq88eZ0uBbDdZCzLua0IcNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774267137; c=relaxed/simple;
	bh=59X89SUeO3cXarYKV/6BeiJZfI3rebbvlj43WvsMPVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ScouwT71ZqgCBhcZCwjIndVAJYvw8kfPzKREmesHZdiidZ4uqUj/qqvYq0ROyqjop3mLb8m94N8icaUQ3rWy3k94o7zrr4ZxAu5r72ZI5xQI4Tb3v2riDQQzn3NG+H0KirIkATOOPzibcq9TThqCh9a1p5LWVA/z6464gF5ibBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MJu7oyJi; arc=fail smtp.client-ip=40.107.130.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aR1RO4HsjQG4+a8vamCRqGf9+rEfgZkVRcmN7xwYmGgK4rJAqgyW1V0jlVbk7RX+Q/PKO7oZ4mBn5KOX2ZTIADI71V/F5WcdzoCnBtka1gQRg7gqvdCuo8T+yNi516f98b0LcrTwUXBy94Z4HY3yez97vibJyBARrYQJOWFZIoMA5VywD8Iif27Vi3QdXTCoI/Ay6upWrxlmuvWjLO/y24UGkhPDkDNyuFXxQ59GREBC2GWL6oC5cVqqr4rFxK4HS9/uTzNh7dQhyeS9sNptx1EFvnFAURKWsCjDU/YzvJWlBh1SOxIx9X7mZVy3z030Ai3u9OnR2HLJ3vGXg5xYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRDqCzBWKZu/pSYAJ+4z/KhySU144gnClSmKTAXyezQ=;
 b=B7yhdigFP/TBGZCtn6KMjcd4f1UG5OWmKVv/8lRG0LERd4ED0enecOLktcQKdyPyoLu/LreRZ63+Dh02mhDeF2d7xj0G5cO2FqKpblslbBihhfz5j4JNQfbwdK1GsJL3Pv5lQW4dGjciH4/gJhZZwB3WHPnj/YISJ//Dgrl03pWn6nUOkK7YLjtMGLNTYG/w8z898SNX91MJlAGA3JOTgM9Sj/jlnRBsdLJQDjyp7Mqe1LvEmwIseIHOL5E+Uhu7YNuSpehwSzaG5lzvt4NJK75IUNWFdg8gljsL8/rgDCTUh19CYmU3Z5HENeoiZaUH/htUxx2imuxwIBSsxNG9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRDqCzBWKZu/pSYAJ+4z/KhySU144gnClSmKTAXyezQ=;
 b=MJu7oyJirtGK5m7SLhE2vk1VD+d8O4VqQKAdkifjoAC+vnkiJ72/FYbmCwjr9QBSlVbMNHTVupZGE4KCzCpX1IfCp0iqEuvMOnwBQx+CDrNHFlex0tQfnT5ZMzQW6avs5GtFnrMpVuhU6+3rfJ813DJ9YrAkL/DW59fVLvZ7SE9MjuUmKmVXyb8cqdp2CnUvFQrfj5ow1je+wIFmiFToEyhSsKL9gR4WgRSrBdWHwjFjlnzu/TGcl/zXkADiO9ucIO5IBFbHXezAACAyGpKyG8rKO71IxBeMsaLVNAdHTlNvbU+OD6eb+PtmgQH4AB7Pnns/PjpJzG9SBbIZjhoEgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8896.eurprd04.prod.outlook.com (2603:10a6:102:20f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 11:58:47 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 11:58:30 +0000
Date: Mon, 23 Mar 2026 13:58:48 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com,
	Bart Van Assche <bvanassche@acm.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH v5 phy-next 09/27] scsi: ufs: exynos: stop poking into
 struct phy guts
Message-ID: <20260323115848.ghdu4sbk75tvggfb@skbuf>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
 <20260319223241.1351137-10-vladimir.oltean@nxp.com>
 <yq1a4w3l04g.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1a4w3l04g.fsf@ca-mkp.ca.oracle.com>
X-ClientProxiedBy: VI1PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:803:14::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e00254-ce51-4a51-e32c-08de88d37fd9
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|366016|19092799006|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 ibev+wxV7Lp30CAuNLc6Kwv6sSnq9sX5WJG+fcheJBiWIhplW/we2ZeUa+3INHI4nuXIwLObPkaLEJTr9WhvYkuHCDJl/Q7Tb3u+r5uOnLJAdwnQQGIG5xzwjf6JsBW3+Ipa1YxN+VP8hP89dEMkFdQhsh6Ca8udnsnDrrcbZJaGrvM5Y7umeb4OqmCkbjzloQQGS+eMHj+0kqf15alIGL9TPnpjRfo4xR3c7ZmXBb5vGcIYHAtNPj9UapIFvaSAXpdSHPJLQ7y45Wf/X/Ws3cHKmMdibAt4m8g6q3nytW+rQ5SMxEEZruq9pqVFxojc7cvlpZJCVdFFkmpbSTY7Z/9OjTWZG0LGKaY9JvgiIKzw0GoxkWtpB+GlG8oxG86g1FhJFyyUjYtFEmmrTgIkCO+jyVtIz7HCUF4UcGqy0ov/JATmyVZXe+vkulwHxj9C/sRw4tWBO4Br2H5vYobcMPAnxCyUM4Oee2eHbN5o8b9/i3+MCPWhgkiA0oa/geDNAMsHgIFExFw1XMZVCLPMqFijgrkZkcznV44isd8SDWoNC7Ya18YjbShZRdF590g2jBsWTpEzrPASuV9ALJOMlo08HyW8LQ0w6mU2keVAzOkGVHgh9X+umzmwCR8iWuy1p3QRt21oazZxNiBWkwFe0elgdh2EsA8cdH/tdby13RNOVAR9Io+GYjfy0qnZP6WKFW3UMbD6P3kBjNaovf8FNNr47kRhzhb2tb72ZbNXe18=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(19092799006)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?k+bXGAQMn/+T5BzTPRgo4YbQuMqlAQp0BRgzXcqFJspqNkTtqqZaF7QtKGyb?=
 =?us-ascii?Q?alu13naFb79eKsdgud/EGhasmtHf0ImzoZ0xaFyFVYv5EWs8e4wmsbxDF8YR?=
 =?us-ascii?Q?LMP1sDNGMYhGGlpTS2rmyvf1lRB7nWIUJP2fCfzURPyHHzjqPSWgsMH6A53Y?=
 =?us-ascii?Q?U+sNsE5gClx71LX/EyO8BeSWI61Ho2dVd1L9SgjNMMALeHxax2KlKHk/lHLn?=
 =?us-ascii?Q?7fQjcSlOqSTH/uuMibTj5wnmNlq7qWrTDr8nUr0LobAwgUlupVNgfUfLxlda?=
 =?us-ascii?Q?99rHcoTQvoYG2JgivjzhYHTNCGDFMfN6SVvygQ650Y5XVraQ+aOAumUUttSr?=
 =?us-ascii?Q?h6+8Xxc0Bf3vxzHL79vrSKB/LEQIL8Vli8pdbLPe+RiKtI29ejL9w6xjL+Th?=
 =?us-ascii?Q?dEn1ALw5t7fqRMUkMClarvf3QzpToOPwLHmxYjq4Bvsxxm8mi4eBHwEDYfbh?=
 =?us-ascii?Q?Mph4Bv2zjSqwlaWF9+adbM1lFacnbYBqgAIbGEdrKFj4NMDga9llW5eNCQvX?=
 =?us-ascii?Q?Lp2y8EryStYpbEN4inRcv5JBOoC76IUlI5faAXPdwOmVGXTyL45cpT9CO9Ow?=
 =?us-ascii?Q?GS2aDMGgitzIvPFRaK/ttzQ2wKflBSXHK/bj5V4zt74uDCVLq9S+BlGPw4Bg?=
 =?us-ascii?Q?5yBD0jH1IMSicDjZQiRk9GqcpI2ozwRKI+iP7IGSQgs/hQn4l3fOi+2jd/IW?=
 =?us-ascii?Q?HBIGL3RGxMJeVASofSRMad150veEXGHU7nJcTruFw8eLAA4ZRqfzaww/KvCG?=
 =?us-ascii?Q?EeQK5mSgGvrh90N3dIKCiAOf0URQz6FUQY3RZdTR682CcKI2zMig1Yd7/BGa?=
 =?us-ascii?Q?+Vv5Z6EHE4589J7jeXlRYKJOFZvSy5L2kxXDoVstvbp/XGt5GxIYeATXVDZm?=
 =?us-ascii?Q?0BCiivVuqqJ0jnJoVE96uDxqGsXOYMhuWTsBoD+/wnmy93sxggO1io4IMh5F?=
 =?us-ascii?Q?khGdj7Fyhupitk2laNmRfY3kLBrT+1I7JguCemkDbw4GrDlWOhiEVabcMgY9?=
 =?us-ascii?Q?cHcRU3GmXuSYF8zx3EplI1a8FYrT+lOiHW1TQP9Nkj6xobwD5YSJxpXFJQ4U?=
 =?us-ascii?Q?sKoh0QkdxAjk+ZQIUfHnzn2NOVGZtXlU/utaKqxFLiWhz365rMZzgbacB6wQ?=
 =?us-ascii?Q?1YgAAwwcYbz2abgx79M2FQ27D4BIYGTJ5abT5kn6tnEserjl2S+JUoMatdlE?=
 =?us-ascii?Q?yyYPiphjM0Fn/ekcZG8euRt67J31PKYL+R4m9ZHywarMxyDzKa43LTuZLk+X?=
 =?us-ascii?Q?rzKPgol3M+eheCDM7vngN61bT1p4D+QVwo/0GMrnlxHVJPPXk0ISjtlIApd5?=
 =?us-ascii?Q?iaTkmF3kveH7GZqIeLHhaX3k8eacY7nhLVxpsp7jJH8oX03V2V7BFmA0fbOa?=
 =?us-ascii?Q?U/0yR1V3GsmdL1tjJwYM+aBo9J0a9VFQWYv7ejw+e/E1QYNSuBtELMxjFgjA?=
 =?us-ascii?Q?SIV0cyNkb1PffMKP2Sl1jJhGGvip3SwkbPNX2PwYVFN2O5pT/q4HUW75XUvS?=
 =?us-ascii?Q?enrBLKtb63BjGjzFO7kP3A6uCEj7n2Ojg81I/rgyqEH+nei1id2xpM4pAi2Y?=
 =?us-ascii?Q?irq6ucPw349PPy5KqZ3dz2TzQ1yCUHou0ToH55PdKMMjzfbuXcgcyy8lkOv3?=
 =?us-ascii?Q?1F2zSvYsJtVRntdJq/g/CdrVDbJQjrnx/FScl8m4Irola94ilIKiZmiyegdz?=
 =?us-ascii?Q?teAEFy4GvrAen5y5MOvAn/LwPuMITzZFIH+x1vdOczCcw2DBcsxTLafNRghf?=
 =?us-ascii?Q?ezkxof+WcGLc53vplrQiNuQWe6T7fb4nKMeRp3MgXVs/hye1h8lD/znGT6u6?=
X-MS-Exchange-AntiSpam-MessageData-1: tg6yYir79KgHW9ol5gpDimY5tP51Db2l5Ms=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e00254-ce51-4a51-e32c-08de88d37fd9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:58:30.0929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4YXNktBLb9Z3mPajRXq7dEVs0GmQiiLBVZusQx/pod62mJZQ9fIW7ruTw7lzF+vkJUeFhf5gUzVhJRIVIIt8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8896
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
	TAGGED_FROM(0.00)[bounces-7220-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41B762F19DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 10:15:17PM -0400, Martin K. Petersen wrote:
> Vladimir,
> 
> > The Exynos host controller driver is clearly a PHY consumer (gets the
> > ufs->phy using devm_phy_get()), but pokes into the guts of struct phy
> > to get the generic_phy->power_count.
> 
> Ah, newer version. Would still like an ack from Samsung.
> 
> And I hit the wrong key, I did not actually apply this...

I will have to resend v6 because of an armv7 build error I've caused for
ufs-qcom.c (which doesn't #include <linux/interrupt.h>, and relies on a
transitive inclusion from <linux/phy/phy.h>). It would be nice to get
the ack from Samsung, but I'll send the next version in the upcoming
hours regardless.

