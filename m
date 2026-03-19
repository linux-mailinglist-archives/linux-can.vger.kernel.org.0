Return-Path: <linux-can+bounces-7176-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ix7Dut7vGk1zQIAu9opvQ
	(envelope-from <linux-can+bounces-7176-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:42:51 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BBF2D37F6
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 688E23087EE4
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAECD407566;
	Thu, 19 Mar 2026 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M9AIGNi1"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDF140B6E0;
	Thu, 19 Mar 2026 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959607; cv=fail; b=QxcEz4j0x0hMsva5b/0ekjzFLm8kaGQXske+UVWuImPeEbM6qQYcMBFtRcyvpuNlU+K2WsXXMfLFiy5cisVZjLmLkyM3OM51Ki7iysnlBv6LkYgRFrevTciHIbmbw8hd1B0zg6H3CQMGmdTWcGbm/fRLgT13saTrIEfCx6cwtN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959607; c=relaxed/simple;
	bh=nLS19NPVJolEc4jTi89X+Zak7A5+5q5Xjis0jYAvNCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SOhKl+iMHUQJgX7P7yPzNh3JtujYlwDkC4EvhmEjOqa7U87P6+mYmEDq+/WkawsQspgRYn5znMwjZpK+bM60tvIWb//vpHXvW+ucv5aPKYEazGY1uBkIMpmSV+cbtnkTgssBu5qR4zfwMo3hjGh4hbbuH6iWX/c2yOcpKfSG8Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M9AIGNi1; arc=fail smtp.client-ip=52.101.72.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeS6rvYkZmF8A1kFI8e5vX0276nsLcVH2I0kvr2Xg2NkMJcYp4kaVJVdloWW1G0JS37WNZ44IBYvAWKgcrRw9SMZOQeF+E2SEby2Rgu9bv8scf4stWJcuyZSiPTztxLUoEaOEvXkirvh2DwN4EFRwE7IzJjK4vcBX30pkMQD2Uao6eHNZNgAkyk/3f89ocHMZH6I3si51iveNDq9soA0lltatEcVcTXwM0U4eOAZ4eaccjJ9f7uNQMGNrEQQnkb+/ME7zMPJZ9IC0WKJGupZFr2L5Zz5jMOzIEfFfyY+ATYkHoJVaGWtybRktOUdhGhZyTsH1YxcAvU9zebDIZBHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZjOOJiqObyq3DvUEmq0B5UD9PsY6LZiqALWpBi5Nes=;
 b=pzqBos5UNZSBxStOh0WJmjIn9h435EOH1aJ/IcyG7g3jgg96UD1KHOHTNwwl2drNkNTs9Z7g9GVBMpMqAIw+EbWfAg5hQVuAtUVEFq1aRkyzp9ljNRljAOwUeT1S8QJZjUEpbS8BmgaKGsSXvi3IIGaWFk4TAsSojHDlE7dZsPRaZfT5vhhTnvzk+2xtfIMt5Kv6k2lggCeQgUFLvkU8AbupbPSFhbR1kMvaI5QHl4EWQ8i87fur4OjjSaGjo5iIRP2DpL2nso3pgDY7u8TNsdT/1GpXu4HvIQyoFTZgzzX8paGROn2dDGCDh+6MXYPp9obN6ka/hboI8p4lW1wYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZjOOJiqObyq3DvUEmq0B5UD9PsY6LZiqALWpBi5Nes=;
 b=M9AIGNi1sMFzYdVdR17KVFTtr84qPxWn6mmND4UFiyAXeDQqmkDVzPQA1a94z9IMMtsBhUO5SeZcHSJxkFarJsBrZfPeG/A4R8wtymUbek6TkNle/ZNbg2kcK67hBcsmPgdcpXxQ//CFhCPwBJqLc1fcUpp0Sg54eKbmOcrcnY+64M2VLdpTf7jvJVQL6vaqwIvCX4v95J/dxXeFq6VqlS4o+r4QsReRVF/o+vmeqjKpKsKwngI5tFMaCtiXrNOlZz+Axv1PyUrG8o1ORUplMQgzpEgdzO0HAAtA15bFYqUC+PRKMWlZvIFvVsAsrygs8lvxBNNdXe3LNAyLPD9kiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV4PR04MB11355.eurprd04.prod.outlook.com (2603:10a6:150:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:32:55 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:32:52 +0000
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
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Daniel Machon <daniel.machon@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>
Subject: [PATCH v5 phy-next 07/27] net: lan969x: include missing <linux/of.h>
Date: Fri, 20 Mar 2026 00:32:21 +0200
Message-ID: <20260319223241.1351137-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0146.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::30) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV4PR04MB11355:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a612f5-3671-4ad6-b716-08de86077584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|10070799003|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RYo3OrFNBw9q0ylsQ129zCDDExoznykqVhurxee1Z1vWcxJmIokT3m9W2/SjUjcb3HiixKOIFYjzDK3bbJByLMAvDn5xU5ac41+VstjdT1XxqKnmCrFO87qIQAXLpxeNdMGHXrogkoBM5HfvzRLklRhU2SGWsYMdSnK12JWBB3PmklVgl17pFF19LHil1HSKut7Xk79ILGhzgnKjArKOEOGGMia/dI1n+H2r+VMSynB0hIO+KMUTSGp5wJxlkXGwPgDkspoV4/3c6pfbiQb+WDMF7Ub6UockWtMiiucXgzriG8JVHvVKLLkKHSaWsQyVwzpH7GZcJWwxGxced92TGNH47AH5A8qWEEmpczg+ZdtVBS6UVp9nvXsZV7lMNNOItBtgcgTWsZE7vhsaLszPQ0vRljSkuJdYaWWae/b0P3MOtQazvdLXG1FBFqSJNOeqja2LENOKggTaLni7OV2RPkyHMQbfdlbc9/3hpx9w+xBfb90c/f81ktlosYdfQEVKcwGdSeOIaZ6aqsXWcFldgoMa7yFa43+ZkiuBvpVDbJMasNnKX0BVnAlFzf/EzCyiWGnQkZV6E1b3W1rRSwjruyTxnnnLxXlZHv2HlP6s82IGIlmEe8QUiL8HG1Zac2uiERdEFOjYIZ7U0fXArws+tEkh9c6tH8s9dVwVHkYjEXfP2ZbHz+41ORhfkGOITy1Dcis21mVMCmPHG4apQqU+IjyVN02FcoGuvo5DzlQhtvA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(10070799003)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JQ7IRMraNssEh2wLGCvmwALJCCJ91KAi74jVvP7aBgSh46xdMLZhsQ4uxeTQ?=
 =?us-ascii?Q?60kI7S+OJAqacakJg+iTdrCS8eVcxE5w4H5GTzCo+oqGLN5qsF3droCAc/pb?=
 =?us-ascii?Q?rKfM4U1XfLAFVA9iiL2NS6QJXzb+QvPOku+hjD2t6zjmOVvy3X0veiC/0oQq?=
 =?us-ascii?Q?9DbNA6UU4HtceTHSnRbT3+3OvDrJR+/ZJP5N/uBhibPb3L40SwPSh+g3LN9j?=
 =?us-ascii?Q?73UI3Ad6itmnDeTpkPffnw9QCeZmtyLxgzHU9eUvmeTOsuuEXdUrIVqD83J3?=
 =?us-ascii?Q?EpSv3LKXgsTxfUAb4XcA53blPa7hfeX7OGBx0sBR1BIbhPlyJ7rlAcKIeKB7?=
 =?us-ascii?Q?X34YngdsEZN8l7shANIVLuwuM1E7XxBbA1djh3td01QDVFRUAe76oju8iSli?=
 =?us-ascii?Q?v5lzD/2TxrA1Lxuuu6PrQmudRqQWAIhUQFwKDYthVAVyM2s6JJVB+xfGwFEx?=
 =?us-ascii?Q?UWQAkHhi5YV7q8TovnFt0G41Yv/i5AeROnnalS7xCvZYvQozC8AbvpW45lpW?=
 =?us-ascii?Q?sEBDgO/vtyVL0JbY+yBU/KxW/wBkCUKKkdVQY0GJJ0SdnO3nhYWXVe/v2SWZ?=
 =?us-ascii?Q?Z2/5sJGItLfp+uiqs/rEgMolG5BpK7Bn/v3IC8z3akM3Bx8j2VXxVAtijfL0?=
 =?us-ascii?Q?/DNxp4nFh54zQVK4HxIruLMNE9UgeHi2BDle+ZbUPS8qbjJWmskVcezGpbb0?=
 =?us-ascii?Q?RKGx0539tLM7l+ZOeNl3qnM+rXwnyY3iUH50hiF4Q3n9W7KpgQGciaETdXCR?=
 =?us-ascii?Q?PNv5uKR7v01d5rPvnUZKV0EChMDuSfSh9NItQLSXGaElm8uhPSBQAX0+hRuk?=
 =?us-ascii?Q?l1DQqxgEMRzMATHFBCeFM0+YM2k1ek2izPJeSUBWM8rdBfu1aJNtUgZaCYKR?=
 =?us-ascii?Q?3gX11nwJvkWDjjPIr1JR2Pg7r+8SG3ym1YVs0Syc04Kz8TvGcw2Mlo1PzSVq?=
 =?us-ascii?Q?QtO3CA24y9X6NUqYORXfzXDNBXCJhSfYhuAgSF0LlrSymHEVPQeztQduKaHU?=
 =?us-ascii?Q?8vnwH8OCfu+rP0N5HgXEJ7o8tTl1dVE50ZHbt65h7DbMjXqnSFhxqe7vVMn7?=
 =?us-ascii?Q?QOjiicHr59gKG0tCp8Oc2bl7tIfcWAPlLH9zOpScbjd9Bsj9FAc6sVfzesCA?=
 =?us-ascii?Q?YM1vWRn9BocgVUQ6QnTIY+nhykFNlkuWz3GqvnnCEho6ba277hP3iX1XHypQ?=
 =?us-ascii?Q?Bo+Dbu4PQLfR3HvPqTHY41v/KR+cdHeionHNa2WIINgPZ1v1TffY2p+zTnQ0?=
 =?us-ascii?Q?gTXjuRd5OdQlKDKeSq76rDtKsuJczxALmKB5Saql3SG2pLNEuOelInfbouLP?=
 =?us-ascii?Q?mXjTwuapMMQW0rAD8jscr3g0e7IGEGI3qYUY9VXBycO/W4l3Y9hYE0QlR2CY?=
 =?us-ascii?Q?8JAWK49GSF543jEek2s/5RwD7yjrl7lKiSjE53CBV2YCAn83TLA3Xeg/8+A7?=
 =?us-ascii?Q?IDwtSsQrHpjlMY0wR0yZCPwgqRp2pfXgte527sgB4gx+396kOEy2PHKgnJM+?=
 =?us-ascii?Q?3r4DBCMl9PI4iEfF1GBVkahg70lGbykm81HG7YCEIrSGPxY0JcvIDV9fmjBL?=
 =?us-ascii?Q?a/LYnPIN8Bx8n0ye81OKRL9Qo9xd0EDmvsVt4Ba9teQ6zaTWbT/V9pimm9Ml?=
 =?us-ascii?Q?/pD+cO0u5EvYgUPu5y362U1zLz6x387EdxlE7u16HcAaBCCJCMHjTZUL/18g?=
 =?us-ascii?Q?KIoc4aUVecktDtAHQoxziwzhL3A31Rp3eE2vKrMMwPMZVUBtSHojJpIDyvzT?=
 =?us-ascii?Q?Fev/02f4T79Z31TGfI11OhIYlS/Jz6vrvFTHQuvX4bEwDVlVs07d+wm+TzQm?=
X-MS-Exchange-AntiSpam-MessageData-1: HAgY1kbmFLSOJT4IYkGnwsfhlZD1kwJktpg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a612f5-3671-4ad6-b716-08de86077584
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:32:52.8794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apu2j92ecDY7w8vfQ5MvM3Ko+3AbskDxKMP8Ffqs1bBL2D4dkb6Y+WsK3DhYrkJzK9TBb++8YLuVejwaepB3kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11355
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7176-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	NEURAL_HAM(-0.00)[-0.973];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,davemloft.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:email,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 36BBF2D37F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This file is calling of_property_read_u32() without including the proper
header for it. It is provided by <linux/phy/phy.h>, which wants to get
rid of it.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Daniel Machon <daniel.machon@microchip.com>
---
Cc: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Steen Hegelund <Steen.Hegelund@microchip.com>

v2->v5: none
v1->v2: collect tag
---
 drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
index 4e422ca50828..249114b40c42 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2024 Microchip Technology Inc. and its subsidiaries.
  */
 
+#include <linux/of.h>
 #include "lan969x.h"
 
 /* Tx clock selectors */
-- 
2.43.0


