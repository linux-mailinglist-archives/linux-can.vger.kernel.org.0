Return-Path: <linux-can+bounces-7186-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOJOOZZ9vGk1zQIAu9opvQ
	(envelope-from <linux-can+bounces-7186-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:49:58 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E62042D3C83
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF7873026046
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55891426D24;
	Thu, 19 Mar 2026 22:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kha5zYL4"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5788E425CDF;
	Thu, 19 Mar 2026 22:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959617; cv=fail; b=uIiE6giBs28l6Z592uM5j/5CLvIojgvyXn3Ayk3zT6oXOWFSEcuWZ8U18cnvwFOAGkv8/R2M6/deyI+ooD0LW1j+nreOwwPbMnP27khqsUZGgcoKQ2RpOD5jD/GcPLROLvNJFiTda5dozIAREFaAmJg3coHvoLXIKX7S3y471E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959617; c=relaxed/simple;
	bh=O7oUrQwvEo7l+Rs2Z6PtPSVdeBHXS1r9p859dnWSCAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MonXTPyebYe7ufaV71yhH5cuZBTqzktq8pQUtInCZwpl4kCH/wKQeBgyzbsOrZqpHsZaoQa1cdLmfc8cRMZ7w1DeWP3aBWHID6SksdIDVEA3tSOyInvnx+A/BrhclVaBKwCo5esku1o4x3/Yq37TQvKoxcXpY5nr0nhVsHXTisk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kha5zYL4; arc=fail smtp.client-ip=52.101.84.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKoM23zCmrtFtau4MSs/WjbSt0rVP5rqT5ovuLU1aYpHlfJ+KzmN8FSKZ+VbYiun1/rvv2NRPmqSNyO5iYuwcym1ZwKfbB6OdLBg49pgmSPcRN5g+QlAQaeV+R8frTRc7Z0DmXAtMh3yTIpgJr1K//W2o0tUHM3dsg21YeYTiNBlTBE3X2JFCU84wckbv/dLTHMiuHpA2VjtO1fC0TK588L9WpDjptoSSLP/2h06edxgbAWA2wMa3xAiNA65f6meVfUQ167A19Db+dEoAxnTHUFVLiiponuIqCRBdi8gr0UzgF5r5OkfdRmah9QYbeQGc7G16d0R8BxA8vrc9roUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sy82VhUoq13FdbDtYr0eA5FVh1m2RaymBKUx1DMhROY=;
 b=gTLnFOQPoN4P1n9egIkMGYcsQM4ymeht2BYqux5pPTIww/tKel4a9APvRAQSLO3Wz+OM0rED8Yo569hCn3qxXHFgdmU3mtiidZscmZfj2/vEUNVX2uEugZ0mHX0zX/JB+xRbh3mnM/CMpujhnkFWJplBsshWblX6CHjRs9XwQNYmaMd3D4ZeeIUklk8/+ww5J+u8d45D8Mf1LiGc6Q7tSuQsNbnjjWMYMcyoHNG5q2Ict0rhQSf2AY54Ppnrk07QHLXuhIHPxtsApSwFB0Id4SIY703jr6fXglmApjZlJpRwLsruaQxXfRbFV2P9oyzH/AYEAackarwGGqj0wwiE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sy82VhUoq13FdbDtYr0eA5FVh1m2RaymBKUx1DMhROY=;
 b=Kha5zYL4FfQJj1UUcwJgipg35v+USrpcDDR4naAUAu0ZsGjSVrBzT8BpofW+nkUpDWxEHlgh7I+mpAk0Z29FRZy1+tWyFPRSqS24Xhf7r7a+o+VTTN8h9+DJmTdVg/VrvQkvdgMYuWpzPrnpGVjdOHo5c+FyZ7LO1DuZOPrefLAEN3E11GrRMqea6EdEmvR7ktVU29/G9rHWUoOdlf6TdUHQ3Xiu/AFy0PZ6ajsJDmE3xQVHcNFPNCKB+BJhSlA50olLINaY2JKykdgMo9v9u0yZ2hvxQQfxDt+xauNnU5SMD3mn2v/OAiDfc7j3lKuvBXNTQ4u2iFhnY47zilQTHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8079.eurprd04.prod.outlook.com (2603:10a6:102:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:33:23 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:33:18 +0000
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
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v5 phy-next 19/27] drm: bridge: cdns-mhdp8546: use consumer API for getting PHY bus width
Date: Fri, 20 Mar 2026 00:32:33 +0200
Message-ID: <20260319223241.1351137-20-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0229.eurprd08.prod.outlook.com
 (2603:10a6:802:15::38) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d268e4-8ff5-45f5-c599-08de860784a1
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|19092799006|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 DiHn7ZAwT+5GZp6BO60cA0UtOBLvRStZzp1RhH/I1/GXmPI7RbPqP0MwcMj6jDd+0Tt+GU2qoVSU9KsnAkzfZN/52O2cZ1RlnAUmvstXYGtu9FeQ3iI8e2hlLaqub5cuPyqWxCxwHh46SkiqGZQaVAsOoaGZZFwqoc5w7KLE3M6S167otVZNUZbk2Q32iQ54/d91w6T395QuwDKEvHHR/bhArbxI/2AAEcAzGmACDOryRlXLwxgAUDiQKOngwe4xXTqSWQi/u7nHY+s9sUTR/CdSYVF0S9nXWy/wweCqPiL8lrUhVn2CwbUe11j8iLDRHnrjzfbryfCFij3Gf8a6WhCz6VyJPmVWy4AzXwRfm3KeEVxeriFS5p1guHJpUmY+Adi8fYOwAqXS3tO2pI0gkt6TPZxS9kJfm/l4dHs7p/GTB/mzuaLVB0uPBw/OB7y2znrn91Rio1kv5/bzH/ghvn8xGHzMb2weK+zr1qaKWSO4Hf/4vMzMieLwVQRXjj6cK21AI4fewRWnU0wG+iwmFT4Tnv5Y37X5uCEBh2OYJjlMao9o0TTDxGPuHgN9hjT835JJb9LlwKhBzZ5odmni9M1EJRo5wOLqRwBN98chDIZQsHna730VxjKYbx39IB6uOTGloFg5RELCiYc2win4ZBYQ5uEdU5P6T9LLLSPeC3Ww41QBgQMZsCWJkKUlCsYlTPc9t2/v4L0YHaEz2AAO5+dJeBIZWoKoj0MW4wUk66Y=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?skuzuudSmjrwxLVw4j7HkivDLh4gT13jJ7iP/BC940tLNCmVPr9kNcVP4LIm?=
 =?us-ascii?Q?EmyA9ba+itWCOV8LF62j/FnGtujb4TJfexUWm7As7IQxicwy7NmymouSe/06?=
 =?us-ascii?Q?j6eEbFWrED3HMJGpBYi3RadK53VSuPixFdthT6vgL9xXOGscFZoz1Dggo/9A?=
 =?us-ascii?Q?535xp9uCNqmSV6QAjx4atsbD/febi09eY1A6h49HbQSfkEaUSUBKbU8RM+GD?=
 =?us-ascii?Q?PF65kSF/Su7tS4hO0EFIOu3gvXhTcbH52jCaOi7V2UpNtfQDm94iaejC3vJs?=
 =?us-ascii?Q?3dhGRuIECJNca+Jd4ZMtm0GwgmQE+lJ7jxzSGeiKEDXNLO/CLARXR1ycIwhh?=
 =?us-ascii?Q?HYnSwzDhOOrn6YQDoZMsyDC4xynSmvYQVVqa70Hp22uGOx7HboPk7yhU+bCT?=
 =?us-ascii?Q?VL23QX/xljky+vNVcnuoAm3Ln/4vfa/h2iSt3T42Llo3kUB14nBDLmz5TzML?=
 =?us-ascii?Q?xREqPOWoLM3TXZl6t8JZsAV4AL/Njha9WpKM8Jz2q3L/TfA5h3K0qf0Kb2mc?=
 =?us-ascii?Q?20tt0dWr0h38eHp4kmR02X2Z7QOWMxRbgTrV0c+OdNVAVq5nNGTBKQaYIAD6?=
 =?us-ascii?Q?M7sTh5hyizb8GLsuH8tktzqLathlAWbPvKZGH+MJg3fdJ+6Q8rXp5C//+gv5?=
 =?us-ascii?Q?hu8fMNFZ2Xt8DtYJdyqR+zOBrFQ4mY+UBcbZhM8yzpKtaJxMYQ1GsALj//Lb?=
 =?us-ascii?Q?g5h8kz/CqhbNSgsS9CwHAnze1J/sxdlOscgunb6zunJnriwgNewaMB37DuI8?=
 =?us-ascii?Q?o+Ed1QgBVFdLY80OGOdgeLsAPxtulDMW1R4X7yl/Ht7HXCo9eHqE3TqI4PEC?=
 =?us-ascii?Q?nO34tpAOQphVVGmyN5k1sc6jfoKHm+ciYcKuyiBU5KK11qBbOfU4pzsS5oBD?=
 =?us-ascii?Q?W6YPUU/rLXvJSC80GK7au/3mxsRI5qv/CJ7WGFlQTqc+aYNaQui/aRleJjqw?=
 =?us-ascii?Q?pTTbqaL59gc+2/QQQ1TEmsiciNdO1EbnHs0ntzrsJ6Tj2Xd16tntQyBTqgEV?=
 =?us-ascii?Q?ottRfl9rbuPsKWPypkt2PKEPrtoTboJX60eCheRajhPyrScFTbi/3ctgPGIt?=
 =?us-ascii?Q?ITIunTQNKYRvHN/6Ep/NQ8StRVYl/SdbvNjCoWaTaIxw/XZUwReEW4RAT7P+?=
 =?us-ascii?Q?ckx79wcF80+41JccAFzH/F5pj8z93eYFHRs2ZwmsvMEz0xfDTROvywp0Cmkm?=
 =?us-ascii?Q?jiYiC87sCkkG6bzLuJ2XzZzilvQixjNN37vjxepNykXtu0iJbnt9iy3D7/X6?=
 =?us-ascii?Q?J44/Qj+SLVmC75pWSo+ttnI0yWXUZfhLr8Q+uW9BRoQYXe6hCwxUI78h5g7i?=
 =?us-ascii?Q?ErQtD1J9iSBmZ4iKH5EVktAFzS9zAXB3ULH6bQH11feWdhv3iNgmCpEhxdBM?=
 =?us-ascii?Q?p+lp6TZKE82TxyoRF8VNmqH7ZdjFAHNjKVyUJKwBOjWPZ+nae6i1axk/I1sl?=
 =?us-ascii?Q?f/mYxDgm+aoaPEVN8TX1bZWC5iCkUv15mSwyXtBQWjSm9U9+0BCD4bIr5b8y?=
 =?us-ascii?Q?AZXDauyGOUVxqQFj4H6HLibAk4wF1vPG4LLgFiEg8mWLx0McrGFrthVncmea?=
 =?us-ascii?Q?+ukXUnk+0r/7m6Ba4vi03X0IEyI2EO1gjiHECMpd6C5minseuRuQsuaiib1i?=
 =?us-ascii?Q?hu9BuL6KcftfYKzK4cKzpdqLwOYWcy6UcgI8dKsTvienhyTbqPfBI86ieubw?=
 =?us-ascii?Q?l2pwah/xvLqGrECzmZ6wsOogClFl6BApU4DFn9THmhDv34i8Ftx+RVikqBtO?=
 =?us-ascii?Q?U3u5veu72RXOqeSsD7SSYGMj3494dyGj2LEe9JSIrBaL6rVyVcWkw/lmJvcc?=
X-MS-Exchange-AntiSpam-MessageData-1: /npWLeOQijf79IzHh+q+OlZczneAnpnKjH0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d268e4-8ff5-45f5-c599-08de860784a1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:33:18.2352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbSp9IBv09q010CPeX+ytz0GeOcBfYAod7gp6B2hJV9G+4ThhpO89HXqh1tLb50l2mWwOH60Jq6csAqlmYFruQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8079
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,intel.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7186-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.948];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linaro.org:email,kwiboo.se:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ffwll.ch:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,suse.de:email,ideasonboard.com:email]
X-Rspamd-Queue-Id: E62042D3C83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Cadence MHDP8546 DP bridge driver gets the PHY bus_width attribute
(holding number of lanes) directly, but doing this will no longer be
possible after the definition of struct phy is hidden from consumers.

Use the phy_get_bus_width() API function designed specifically for
consumers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>

v1->v5: none
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index ed7ed82ddb64..e3f8a281f147 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1304,7 +1304,7 @@ static void cdns_mhdp_fill_host_caps(struct cdns_mhdp_device *mhdp)
 
 	/* Get source capabilities based on PHY attributes */
 
-	mhdp->host.lanes_cnt = mhdp->phy->attrs.bus_width;
+	mhdp->host.lanes_cnt = phy_get_bus_width(mhdp->phy);
 	if (!mhdp->host.lanes_cnt)
 		mhdp->host.lanes_cnt = 4;
 
-- 
2.43.0


