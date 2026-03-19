Return-Path: <linux-can+bounces-7174-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKf+CRp7vGk1zQIAu9opvQ
	(envelope-from <linux-can+bounces-7174-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:39:22 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8AC2D3613
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4742A306F1D6
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0FD40759E;
	Thu, 19 Mar 2026 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U/uDoJje"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE35140759B;
	Thu, 19 Mar 2026 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959598; cv=fail; b=pJH75oWzEdR+tymom48tYDZEf9W2Ni3TI4VxiYSUyDVkAkwgzsuyjfhoUrwSOVdqiNE7mVG4WvcMcSQ2NtDKlJshBsJJ7VYDEpN5TLki5Jyt5z89vCBQyg1Cd+1pqQwK4maWwNZD8ZsScLf1KFCFOoUYB1QNYKZ5LCfRvSl/k+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959598; c=relaxed/simple;
	bh=lerhf3q+kSQ/KUPQx6ouczbGqom/YsP9hoF6xjlrv6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ulHZ0bJ0L0BvPF1O3iUyXtIDLokjx8b+rfH3Rt39tW/4Lc3I1EewaIfSvWwwOBzZpJ8Pk0dlaH9/2v1938M1MLGrEe/a64TWRXjlbaewOirj3et0ZdFzmbuhs5kJ+QtkUFT01yce2K83oh8EXf9VKmRu/olwJRuk0dhF0O2eQgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U/uDoJje; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3+iwO/yGS27/f30xbD7CQCxHsUoYEp7UH5PeoZE4NOON1avmmQ5eSm10CKR0I+vKr/iF0nV6pYF9XNOhBNweGEIykc5azOcA14O7zQxFyCHAvOPGeaAf378IbKlwkqwdEBu8wrK5/ab2M69decI+S0mHQL+rzp5a6eRLHeuwbPSjAR4DDPFf4b6CXdbRlzOJ++8Qbf/cCL9j72p3FLaqKaskB3MIut9Ib2IYPuFm0Hj5GyRw5lhrMnOy44x/LPL2htu5yVsIIb/hHnqn9TCrgrbJmetKGHmRdRMbwxHdtCk/cEQnG41gkugS2WcwYABwCCUwKW5pWU1QdNi3U//8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vV9P49SF3DOsSIM1Ik9m4S1m6fjps4CTB6Rt4+FI+zY=;
 b=nS/13S9W1z5Qzdjba6qfULm27y6Q9kmHcU071grsNBPHrVna6RM5eHFw5SAgofDxAK3W9Yh/K04/n9lwaYpywRs2lqopJzDKy7K8UzANM57UyHp5rDHnZc5jfnsVzTRWd6LP461NDjlyAnrjeQY7zjhH2kr7tkToc3Zf91g9gLJOZpgqDnieuevW2GpvyEfesPImqB3KMw0QL4hi8w3n9qXSbyRRO8bAxFNtM0UQbpkdIwTKSqcqmRPSTnmcZudWfgdMYppgFJTCCaaGZuGuxzH0X9JSr4Dm9seJgC4g8kGOHNPaIOZQZK6TYyG3PXBMXzal0ZsVVzqbvKJHYEWhSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vV9P49SF3DOsSIM1Ik9m4S1m6fjps4CTB6Rt4+FI+zY=;
 b=U/uDoJjeaqQn0QkPi6p9WDUrOhgky7CU3aRyXwMkJIfRyQikeRzjq1unmXxEl/khKgV3dod0GljQ91bGfJzq0jUq48pJQUeknD2+ozBHUxsxLoKljnB6qaxT+YQD10PidJmnrv9+CfyZx2sWepYihdQCm/q7QmNtXASNohGp+gr48XbtCZzFkNgsqrniSx0IRpklzOakregjWU3NyA6J20TA+wri/dLWgEtNtitvUiBY6001Uus/ZJdnCcNZlzLUxCJxwiCwhd6ouZ5t+FZmCK9cMFu4OEsQ9Ah1kBFecXfTYu/y1D/7vTouZ7phJPKJvu7w+FoUTdEJTraa3QlHcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV4PR04MB11355.eurprd04.prod.outlook.com (2603:10a6:150:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:32:48 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:32:46 +0000
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
	Simona Vetter <simona@ffwll.ch>,
	Inki Dae <inki.dae@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: [PATCH v5 phy-next 04/27] drm: add <linux/pm_runtime.h> where missing
Date: Fri, 20 Mar 2026 00:32:18 +0200
Message-ID: <20260319223241.1351137-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0044.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV4PR04MB11355:EE_
X-MS-Office365-Filtering-Correlation-Id: f24ccf18-185e-4157-17c8-08de860771b3
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|366016|10070799003|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 45zRCMv6T/jyR2Bkxj95Rz/T+juYtVifai4N/PTQWzJQuGztUBUxbi5sGIqjMohK8lZb28WzNN9ixMKhNZIfEquO2dk7dihj8EVHJpY/cvoJypvJDXKIpc0hcpT0W5efAwLvQxz6FWTy65eI05KpIFCxWEhXOMgCb1BiTMljx4Byr22VruWZu1s6ArOL+922iwVlieNeU3dy24I76rMAljmHEzOMURW2mfjDLD+6g6CaUd+n87cRUg8oyXNnE2bRvVYoTLXXUmjJ+VYQn3EsqdVuBm4nE5WCsxZF4ReKwhTV0TTrEJnomxNXfQQSohe4uh7wq8t9oOwdcKWf4WeQLweCwEgQwEud3MC66Hiy8a+n9o6dlPh217vnnlxAYm//HNK2gDNmsIg3pIoAUctxL8jyN89n7TjZYAHivD/lL/CTw7Bouh0Ui1doBKBD+7aWpbu5YLJ0I/5bINmG1BSKdWVgN/mBy3ZFoGaYuVXVv/RhlG32OInl2P7XWwzIF3uYu/8CCMdAHurzb+QiYiQtpMovSEaHv+lmkxTB7qzzXe+p55GCYFJ1sB8YkBVwq53As2aVa6RmxuKsfBRfnYFjqWCNIID/efE5RPC6FguK7Pq0dYOb+AGokcylS4aKQC32t8LQDjf1qgBpGmVHogB8w5gSmhWnaKPsp90jRdJ/6TAUosz2CXjNVjQT0Hgc0K6UqnMXt8+nHlz5aGV3mjj/te6onAvwuF+qLFtm4zwFseM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(10070799003)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?FQ90dI15u9mkBiGQ56ehwJMNAia1+vRhYR3qHyryoUpNkaDqM7DgqZzgBVND?=
 =?us-ascii?Q?2zJ4Yw+hFNX/DegydQmgHpCEYmoCQszTpIwf48TLoQR2EKgHxnIpx7vOocf6?=
 =?us-ascii?Q?hgeqxa/6mf0ZzS2vq08qil4H0G+3T/mzeij5tNwjDT9NLS+UjRb9gcsRiPWp?=
 =?us-ascii?Q?TVCeDiReBmWpNBzpRDDD+qsDXMP6KfXZ/JXCDYcCR1fGlukgqvHlJ9SZdcse?=
 =?us-ascii?Q?wlJSHCN4E5W+5SLtMlDotEFX04Wr8HO2P6Gxcq7fCFmvCngkgQKZ661iK61k?=
 =?us-ascii?Q?B1Jx4hKlAgy1nUYr6tynPk+4sILp8K65KU0WfMkpV6F8nsT2KVrZ7mvOqKJP?=
 =?us-ascii?Q?HyvOzTdCCjLqA1gKjuuqYb70ii1iq3/nVpBhxMAE+FPq5FyAfBB7uv5aOE1x?=
 =?us-ascii?Q?506yF1jnsZO57nl2pbsHWwT88VctSKQzUDoz8W/j6esEjJ96Lnin+RG2I4F9?=
 =?us-ascii?Q?lj/IaLZ1FXXCPTZRAkofknEuSqd7pclWglj6vxong+41x9dPAUyg1N94ENZ+?=
 =?us-ascii?Q?wNbt4bYpBtvd62NYONvKY9IaVnWbR50sANo2JR+VR8APhKwopkYPBBYL44sZ?=
 =?us-ascii?Q?OzXKpDJ1zqVcc+6l1SsS2PnjwhhLFJAIsBtswJcBMS0dggyEnCVNZn+G2gBm?=
 =?us-ascii?Q?U4Pp+OTOnCyZ1DFUxeaMeuF+G31J78l4o++Txo5AhHJp/w6iALqC4uWOhpzr?=
 =?us-ascii?Q?QL4rWqXt9ddwMOLbNdVoonYQO+4pDsRzhfR4XAQuwV5ITEAGGmQeEC927Z8I?=
 =?us-ascii?Q?Bo7pcOfL3nInJ4BxVAbSQMThVC+WcEB56iScuEFKsmkiduYD1R3gnltC4CTA?=
 =?us-ascii?Q?P0O/YjOAu8HZLnCYXUKcIeG+RJ2TdCYr9QWSe1VNAEaI5m0iOrlGuHNpzL3y?=
 =?us-ascii?Q?Dg5ZxD2ZNdaFT9S1Y9uWOFSEqEjiGuGfCGjGjYHTpODjThzMJIDk3XDmwCvk?=
 =?us-ascii?Q?QtAbx9x5Xbk5MSK5bcHozhsq6DlrHIVrUKtUQnBYioh6N/MdbEJofhX3boW5?=
 =?us-ascii?Q?VoD3wox3DFTg1NlAUEJOHjiejkJEmF6Er+ZAjQFx5VSL3r+Z5i+chAmFoDj7?=
 =?us-ascii?Q?iFxq9fMQhAbUORx4NjarLekSkpv5vgQWdNiVck0yVT89G33rY0Xx19ogMydA?=
 =?us-ascii?Q?k8OVdVwKjUlmcMR+cR+ZcRuXZzAz87MAdDnh269SuLYZ+/bWoB2CzK53Fdhl?=
 =?us-ascii?Q?OSkFwviDzED9qFwzHdIxC+nXsF3Ev4ceOoQ98vURI/5rp6BaoA+hR7R8HsCk?=
 =?us-ascii?Q?j6ooO18ZSBH8DcHeW05TwpcFW4P9NRS7VHcqqsySvPdROXKMeQW1/vJ/K4Go?=
 =?us-ascii?Q?EnxwfRfMzeUV47r199HZT0h7zPZP/mFlZVSpFIRLAJsNEO2K0xTLQFdCBzlB?=
 =?us-ascii?Q?FZp26npKXR97v0oRYVreD8/Dh+uAkTwJ71GR7K1AOvLCe1MzgOmW2zhatttB?=
 =?us-ascii?Q?DZI0xYwbkTNmVwcUVRISj0RYC4j2kNjOuolWQXj7WlDclHZ9hP3RQncSdNjx?=
 =?us-ascii?Q?4ucuw9YAE7wF5EjIU7AygPPYiUANx3/QBK2BmtmBXWqknGmm8W/Rty3BDTNc?=
 =?us-ascii?Q?eI+0eqH9MCWzg6h1rZ8witJ1DRqvB5ZdTbE1xS1X8mWRrykqVm5BaUf+Be6l?=
 =?us-ascii?Q?nv8eGf6ccOFz57l2AvZ8hho11hfsk6ZgQSlbDB/6JUy/5RQwUIkNdckysUx7?=
 =?us-ascii?Q?dDOVcCIdGA3Qod+EteYI0NNmU3DrySGmPr7TGUIpZAcjygqjH6h16E0gXJQO?=
 =?us-ascii?Q?zKR/+nvHef9xNNklIsDnJrccnwtlFQj4Hp1NQOl/nXk3yY0xAADWMHi+QQ2N?=
X-MS-Exchange-AntiSpam-MessageData-1: 1MQOHGc87E1+Oms1QqyH1qg1twNgwsW/SeI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f24ccf18-185e-4157-17c8-08de860771b3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:32:46.4612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cFlOPx5wwKY5qEpUidk+VyM/KWv64UJjDWKOdoxd6XbciL4NsN1I4M2HqdCti3vl7zyTDPdVSEDVVlWYGpVgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11355
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,intel.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,samsung.com,amarulasolutions.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7174-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.945];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A8AC2D3613
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Multiple DRM bridge drivers use runtime PM operations without
including the proper header, instead relying on transitive inclusion
by <linux/phy/phy.h>.

The PHY subsystem wants to get rid of headers it provides for no reason,
so modify these drivers to include what they need directly.

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
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>

v1->v5: none
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c  | 1 +
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 1 +
 drivers/gpu/drm/bridge/nwl-dsi.c                    | 1 +
 drivers/gpu/drm/bridge/samsung-dsim.c               | 1 +
 drivers/gpu/drm/msm/dp/dp_aux.c                     | 1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c              | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index efe534977d12..9dfe790e6c14 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/bridge/analogix_dp.h>
 #include <drm/drm_atomic.h>
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 9392c226ff5b..a8b6ae58cb0a 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -32,6 +32,7 @@
 #include <linux/phy/phy.h>
 #include <linux/phy/phy-dp.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 
diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 2f7429b24fc2..9ac8796ae91e 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/sys_soc.h>
diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 930aaa659c97..54bc148fc29d 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/units.h>
 
 #include <video/mipi_display.h>
diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index 3825a2fb48e2..5ee22f88bd28 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include <linux/phy/phy.h>
+#include <linux/pm_runtime.h>
 #include <drm/drm_print.h>
 
 #include "dp_reg.h"
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 177e30445ee8..68556daa54ae 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -10,6 +10,7 @@
 #include <linux/firmware.h>
 #include <linux/mfd/syscon.h>
 #include <linux/phy/phy.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
-- 
2.43.0


