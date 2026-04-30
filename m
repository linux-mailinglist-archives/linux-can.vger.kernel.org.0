Return-Path: <linux-can+bounces-7435-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL9UN3E482mFygEAu9opvQ
	(envelope-from <linux-can+bounces-7435-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:09:37 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7314A170A
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D8C330211A8
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB5C40757F;
	Thu, 30 Apr 2026 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eKiRE8hE"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030D1402BAF;
	Thu, 30 Apr 2026 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547236; cv=fail; b=Se3ojkt8/aTTTVOUzQOhfY2wlYUDjdWIIjGNH7j3S5NpceJtAp5sFt5zhPZSjTssgW46A3ekBBkbT0srxi9PwizgoNscUNrJYW9pU6ZC7RVrSQAbxlORPQzQkxzh1eds/MJ08MewMbgi3G350v7rFR+oEJaCSfQcLEu6L6XZAkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547236; c=relaxed/simple;
	bh=FZvynza4RsIPtSI2fyUleikFke7B3G2XSJ5kxN8OevQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qy2r8FtAc8+KUfDJJSIfK3HLTjsHcQvU6VJmH47TO+TplwVuFdEwcE1I24PGM4sy0AWOjsB0KlUEecL1phu7ZYLGRXmcNOhmiDzbEG4cObjiOB69bPFTxwCcq4LH5KxK0movHNsUvgpk+dsQIQbqS2G4UJPx4R/52vt50IZLpAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eKiRE8hE; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ae0AvnqPK/cxEzQDutuCqmAskx30zBdZV9anfKc8nx1OYGS5txP8MnIx8t+yUv3h/4YDjdV7pGym4LeVVABsWSu88v8gOhzAT5hQz42/d2YKojfsE2gHK2vt327pflM+hpRUetnmVq+AjOTuLFkCuDV3SLgKi7WKeOZYIUBDSWE4yasuMTzLPYcqjVHlqIC24CabtK5Kc3fCY/qTL7yuVkkXlTfc7OmF8M7CnPVgRpFJX7c78hOaxRSQOrrTjEqWeAAXPfjA220Vz04A23GalXJlJNG30uCfh7kPFr8IrTPBdRRFSnD+23TULmtMgkT1UF9Xt145YoIBah2l7j5Zkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuzS3cWBcZDJyyX1IdzXLiRcPkGKQahds1YiLJOuacg=;
 b=JkOHToOC8a6PTugwoJHmw6JaLTpe2b/hYQgsBq3ugSgA3siB35s6ruxjIxTjYQb/9udrWlHIZYVD+ce7iJDwFCScuDbWZgLHNLytK5eJyueUyuyQVrCbdY00O4YG4oJYoS7GQAgLMT7YrM259hghXTvGBOr8CDQPrym9a/6nA4RfDTLO4RBUZm4+ftUml0LY5pyrf3jLd6b7rb8fT2MHUZ8GMxtAJxr9s1OCQMzhZbu70EUG5CRdx1hilAFo+QFtiD8NLeuHefFf2MYBab3IoZPQPXCGotHp60Uv3hRLtdQmbWvc83ugi9RJtl7L70fcw+OC5SCArsndiZFKHv7oMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuzS3cWBcZDJyyX1IdzXLiRcPkGKQahds1YiLJOuacg=;
 b=eKiRE8hE/SUE2uW0AwEILC5bFU4QpNgoKS3bgbngwoFejp25ljiBFrpeTv74U6bdFR83UVIE4Je2D8oToEryQQHMNYemF/g7d969cEK4xQfo/W4nHp1u+JUDnzKFCSRMAIhUkTqGQ197wDuqkKFd3c86/lP5WtCHHZqaLNoeNn/LkyLTLS6AmIa9jiGzZXKvWwm54rIh0jRP8HHV7mMr4vhbX0oqlkiRLtxMLaFxvAF9Gq4SGSi5ThiqL8vBdmssMEEsWOE3aF2eOPwxuQDnoGMiuub7Fnjtf4MmcSya7lJQSK4NS27ZBRiZrc3xy2YjBKLwWaVxi8GgfQ3/ehCQdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:07:09 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:08 +0000
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
Subject: [PATCH v7 phy-next 07/27] net: lan969x: include missing <linux/of.h>
Date: Thu, 30 Apr 2026 14:06:32 +0300
Message-Id: <20260430110652.558622-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0004.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::12) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ef6903-0787-4152-4e4a-08dea6a89ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|19092799006|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cMEpcIfL+9wNZVliASezmS2h+5FohiiohSIFpM/n47osDig91ZGvaLwAHMTfXyKD5ZKhuK5T+dz7Wj46f+dVfH1/VJXmg1rhX4Xo0zhGyQGXzDNe81xpbJsbcazcKWdjZ3gTHSJvojNmd/AKwm+ZK7IIDj6OUxmKBkB0AIdEMAtC4owMuQvJGZa9PX1jVmC5pW8+fs+GeuZfuaUF9yve9JMzEbbck4cOsavae1vM8U3ZNXqgfOrly6jgG7z5N2iGrIdiTIQEbibBtTV1CaHtvZK3FVp9nfT0i7e7LWMLEexlUQhHDmMWfgpzdcImOoKmMHWTKmTdXWkKVXscMmf4SSD4NxC4UThruWHGbJ4WUgUOCHw+4jXMoLbG3Em3h+JtX6jIocjpctu4sfZPTBCEDp6G/E2Bn94Ozrnzi7ixwE4z2/kCdjv7jZKl58ncJCm87OUApj6jUJDQ/irO6kb1t9YSQltc2/rFitcAFaLx6SAKZtfakBzl3mGv9c6gLSYxDZDkgTlgyKStaqu4bKUNgpC/hFOZNzqTiDLTb4LjPahk56Br546H64jpIQuqfaPbHa6d4pIF4D11lS1v8bk3sd48spdDNrPp2sm+FQwLlLa0Mnd5lw1edbZOR6jpcwYhhOFzDHVDTgiB5XFMhLulKY94PqNw75izljXTnDwLfI8bfuAtlKRV8MWulNe5Qbshuhd80DZkL2NEbDsS1mRluA+Men856le1Sn6n79JGKbM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(19092799006)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bdbcDA33p1C/J3gDi5eHqcPBW6qdvRYBiDCs5rxp/cqz8FiY6eXywfT+WgPk?=
 =?us-ascii?Q?IKl4So8k+7ihBz+xWRqnJYi1ivKs0duMXrQ0dKfmtPxBYD4uFKFFTnU3eOQA?=
 =?us-ascii?Q?rGSDeykE+Hvq1P6kAHxkdn3EaRL5BGe9sPFEFBPct0xZXOeFXjvaYLlmfhBs?=
 =?us-ascii?Q?EOGUd16ysfT5fpLmZQsSbEhwKRqj9jH3YqV6SN6Y/AyMVCXRECeV0aFNY4Qe?=
 =?us-ascii?Q?6RHJdj9Ofg2req2uF/3czkPl0CdDCaMxd5FET9O1IT6yJkfxuE9lhxOKL9rb?=
 =?us-ascii?Q?q2p0SlY7/OZsDtuh7Kd9F+8m5VMaXv1pf90Jd4YPeex6POdfY4YgwELrmKfF?=
 =?us-ascii?Q?HvcI7inD1t9x5kKfNrjvWRarZBKiHZL17QKFne/HJcT1pkADXnnw/M/MdWu/?=
 =?us-ascii?Q?RWavcOZdYI9ydm+ROsWxMlyQyV83J/iOKJqd6CkCteTRlo8JWnrPdMC4fmIo?=
 =?us-ascii?Q?fgYBkldRt41mxU640k79IVzQkRKiltmYg3WHf34czQ8lNlDOzwUiA/uMgnG3?=
 =?us-ascii?Q?l7q4YDFDsmawiAUITsGiB9X57PaJCTkKjW+erp/eNY2jQF8AK45g1dhH4a+P?=
 =?us-ascii?Q?ZL9c8LsVrliWP2mW9BbXsdVa7fM0geKTj1RDcjaAV7LkYbPMOslISm25Hv6n?=
 =?us-ascii?Q?O4h4qZrN7WL0VX+YpV9ECopbFgtecvX0lBprytBIyCxwYVX5PyIxmSzm+w84?=
 =?us-ascii?Q?nHkr91kx35k+PQrJ065ltuAIinhe0G8ayfHoIgkFwMXt2W2npdrcuSkeOA6D?=
 =?us-ascii?Q?oGIvkY4+1kqaTISEsnSQsPmYBNl6K+X076fM5iBbA82NNzh25butRHGhcQjZ?=
 =?us-ascii?Q?FiNfoiRSJa/sK7ZMrGDeaBsajJvs6YmShJBwALhud+ga5q5y9pGkcKqY8mm2?=
 =?us-ascii?Q?9tqla8dZ9jOgwW18sSEHnmfRTjOAqmwWcZjbXjOPG5LRW24/pN/Zt1WzpEXR?=
 =?us-ascii?Q?VRWtJnbkKnP2e8QF7mUgWmOeEZv32wrUycw1gBfoR7F7xyyo22Zqdcr7/+bM?=
 =?us-ascii?Q?h84g8n3ABMBjYGKJyXVVpeUWIiVcGszo+lgk9WXvUnuZ64uQKFzO5+aiWFKs?=
 =?us-ascii?Q?U6yyQJY5yaq/20ZN3DiHRIXV4xsnm+ymPK2ltt2viQT7IcCW9oD9Wu5kMtOd?=
 =?us-ascii?Q?V7pE5DQJ7VjO5YsSOvJdUAATExchqYYb7QKXet2wMW2TJlMrmy4MdHFuX1Ps?=
 =?us-ascii?Q?LfufcCvK+P6ngLb5Rq2eB60AWju5M/v58QN6m26r1X6jw8MYyVgYY6SOiMCt?=
 =?us-ascii?Q?dC+st7km+2guapq9CiHDHIsCaJWy3knZ+RfDuS6JIMMrE02Llt+oGzm01g8l?=
 =?us-ascii?Q?jPlkHSVqyFn87lIZpQNeji9rFrIllDWLLD0A/uctklHjeOhxyTDni44cOidm?=
 =?us-ascii?Q?dcmarbuMwcMZb0oyjhFH8P/npQSsRdGCe8PB5fvGVDGJYiehJT+1TVfY7SyM?=
 =?us-ascii?Q?eak2Ntl0VPJHjqGD8UeJiMs8NicacLUZpEIHIR9L1XbfQZLxsEd8pIz64fYs?=
 =?us-ascii?Q?n+vccUdP9wUaCbRsvH6pTIi8ROwyPPVazihgTK0Y8B67T76bnX9CfYQQRzgJ?=
 =?us-ascii?Q?VtJuimOYwx5cXB6yOWdNcJV0U8ra9+wCHs+DCId+Hr4I1oEjy1FG7/HMu5sJ?=
 =?us-ascii?Q?vfJSNpd/dTCXCjdDthqUf4k4bEdpORoseNvsCukMCWIi+v/eFOheluGo083n?=
 =?us-ascii?Q?PAdryhRoPu2515VEGygy7LN9eG7C5UjqmOV/R22y61IsqmogHEgyOVOa6WYd?=
 =?us-ascii?Q?shTkoqDD93f2dfHEnR33CnJ4y6Dyhn6mz4uiduOKkBmw6kJWaQjP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ef6903-0787-4152-4e4a-08dea6a89ee1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:08.4787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlYB1lSxNPTfyXYoVIn/W7GkPQ/NHcEgw+TphwfjueoSE75PbKvW0r1uoQUQoTlScE8spbLFW7TavBLW+fCwlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
X-Rspamd-Queue-Id: BE7314A170A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7435-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]

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

v2->v7: none
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
2.34.1


