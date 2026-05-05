Return-Path: <linux-can+bounces-7519-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OtqDQjJ+WmFEAMAu9opvQ
	(envelope-from <linux-can+bounces-7519-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:40:08 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CD64CBA1F
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27E5A3192393
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B44A47F2D0;
	Tue,  5 May 2026 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mXAXBv/p"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E49E47ECD2;
	Tue,  5 May 2026 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975625; cv=fail; b=kuTtasv3VetwCaO2J6Y5WSF9HcGFul3DIQ0wbsUokdi7rD4fjQwp1fLhMqRcfu3pZR0dHVaEOY4TqlUga+SidGNv+UCOulmYC15A+J/qa7pm0klMPirptwsTDRPcJYxYv8JxnU66VNNyCi0SLMMYV9KavaB8oiZSlN7rJK0G3Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975625; c=relaxed/simple;
	bh=jq0QfPkpcUWFX13J1T+S3n/LE6oD7r6KwvKVGUTuzCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rqjppQOvPwmJPnwZSrb7OOJfPxEUPdyLKnGDnSm3aPY61/F+fmdnZZAEkjWBnJXoTARIb2cjI5fFdJvyV7pJBuumzO8HzHaLtOD6BhfJ3xCa5GiQs7NHsWGItc/hlJbElxidmCpnFE1RnqVSRBO75jxZyRywIrK0OVF9I93aXAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mXAXBv/p; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCB39w2PjkpZXPvz1OidQY00H5eh4yCVPTDCSdZdZJRbmqkpRw2e2y2ih3IZEyzf9rdxnVZCJ55P573eLbozWKufJ0zy59NgbHPBLcPZOyVj6JX+i0KXf0wTF5EhrU1ERFQO4AIWlNVcrei98dqN6MZVYeR4iu1bza7g+7McYgvEESlIfiKQcMhLG9Z/zJEasJAqoIJNL/F+iczWQNcgeAeeZCvNZgAJqY2Adh+/DlErHdLhm45KlpOf2EVBobrgEzvwjUpL0q9qn+RhUBQe5SH1jp4DpPnh9yDtQ9P2Z5/gdQDK4aMvU6XyPTd1XVS6GL3IDn0aHORNCiCWLW0PyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKTVOqUBH8QtKpRjECrCqFpDhqx+n7aHbc5h/JJ9rB4=;
 b=mWAc7B4Zlamimps4WDTsVUXPt5/YtZCuAI+E327iUPHTkb8zMOM+qOhulFbzVUgdn+Z0vAHwVrIMbrkWhEe91/6iW1nWoZ7mPHej81QUMtn2oJrLbMNlE6LFKwO4zpr7EJCyekL8UKNlDUCm24CRIaseQdqxzrX+N3HpzNtlMXIhj1bGGJyjWtlg3esfPnfFqqmpW817N3b3uTLs0guTbD6oIemLCXpjJcHWfEFwEwUEy8DGU7C1FdBY4FP2/+aC6NXJ36Wx3UrOam6JIhcZoAvOd+HPQruN0idxDiiO/WBjAOKtXqWreUamke49VgDwcq0Rnwz+Ba0bGr6vmbJ5qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKTVOqUBH8QtKpRjECrCqFpDhqx+n7aHbc5h/JJ9rB4=;
 b=mXAXBv/pYjGaJtVDFf/lSlLQ+8/R2urc5eFkOeK6CcyC5JOiNQBuUzneIeVi1n0PchXVJb4/YXPp0T3QlUe/JTN5lfqy7PEwzTUnVWClfQsqao6B/CwW66LJ1VbPoiWl6evLUBvFpx7EaiN2ZW8snNVvqgg74rVMhWEEvYBs63uIorGZ+0vmudJvLM5KJVFQVIuxOrxzQHSg5QMHzv2PX4MpDizNqKZm/+NhTIDVkrUlVuJSJ+NoLjVoQhXSDu8DngMmUdw506xmOc+FCI7/+idntMjaSGigoMstNqkW8jama8KyBSMb4UK+O5UMMZfwaSqThNOjNwLBjR/WGZdSjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB8308.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 10:06:51 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:06:51 +0000
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
	Joe Perches <joe@perches.com>
Subject: [PATCH v8 phy-next 31/31] MAINTAINERS: add regexes for linux-phy
Date: Tue,  5 May 2026 13:05:23 +0300
Message-Id: <20260505100523.1922388-32-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::9) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 81316246-3822-4ff9-6cee-08deaa8e072f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Tr6N73yKU4jVUqrCYRzWyGNUzDQedFywIG6xvx9rVYrCdzkOobUHMNJfo8Zzn3LHzPj+Q4VgJ95G3BwQA5X02WwAfaTZEqclrqUXWb/Nu6RiC1VgM6ioXXv2RieyTAkmMkYvLuBuquKJPci4B2vnQDEfvsUbFuWJ7i/CyJmjC63horv9X0btXTgjleFivSrx1bKUWkyMUVoH95DdjejzP1B5pttWc580luVW3Hg8nAGucZI6QpgRGCE/w+A9V9DL1c7Bb3lKw8VEX8a0AIG36GRlJw6tiEuQlI+W+46jskZGeWL7BjTV41GSyVh2VuESVa8kmgBlml67Saw9DLhIvfYD3C02oGQ+NcI4+REzjGnGkUkwv2i/XPmPQgPcrB+JhQ4dQ5/TZSivuZUk8bal9zXhQY5RuZ89RmBJlxqXlCqYFFcHQyVRehXg9dj+pj47Q95Idc6AMoE1qEYrFZFtHGm8DtaB4rpUqEsYq1X1yVqjHv+QEosm+FIq0nDZBPmmzg+KKqmVf7ddimU08WKLX1G+D73ndSy32GP3S5TouZKnK6fZNp7D0l6qfAFk5nV4Md7p7wvtIaKJYB1hqALPRZpv9i8CGy7l/AD3Jltrp9DC79YXkKF/j0dZrv9c3GaaP+Spa4vNPzmE/zSECN/M5Kn+B3qRJ0Cg6mYeCCtFZjDlEt4VDeUwm3KiwrH3/RxiHVHhQ8nJXw6/ohUsnzgMHQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7jl2Efzb+BdIM5dq6qSAbxw+LHeU/+tFx1FO29asejOC9G6o/g17ovNuI/tW?=
 =?us-ascii?Q?MSi+7PxhVbRz5R6U8nMHE1VZQeVmzRZdOa7VwFbsDdL09WxIkffFepSgVGnJ?=
 =?us-ascii?Q?M1fAWIYDad+J79eBEN4YreyUhHWW+L4/9lES0+lGhThCygZzHOKoz3Y+G11P?=
 =?us-ascii?Q?CxB9hiEtQI3NsI2m7ptj1A6JUw6LO+luswJ6HO1looHdekmzbt5JzZ1fE/g2?=
 =?us-ascii?Q?ftGw4OEJg/5jC1ig438MAbYiJWXCkAajraEVk8nij4yQzhgdMo6L2Fa2NXYn?=
 =?us-ascii?Q?5qHPtm6N2//T6Nn8okYQun6FktC5BM7BHp0nCkXiMrEkKJQxtXw6jED5i6Cl?=
 =?us-ascii?Q?DcblCu12kl2PUHTAhzVvTAu7PduMlCBazHrCpEga3RGnsBgHR5AQYF3nvCjc?=
 =?us-ascii?Q?DhjNqTAnQZg9XK52allR9O2tfoCNIc5Qvb6QOEj/nFTMCXoKzToM27a7F5hJ?=
 =?us-ascii?Q?tbosn4MNsWXlOF0fn6XP8nId4xvah74xvRr9d10f//RdOnxjJvcCCZINUnG4?=
 =?us-ascii?Q?pdVYi9YGQzNQXiyuUN6nFYsyWwpIfGgmn0Thlszqnorj3Fhc+MGgcGTQY0Kc?=
 =?us-ascii?Q?o1d39vmSBYjje62QIOi1Qas00Fa5az/a38m9SgY3dCh5ajHBw4DpXOq+Wy+E?=
 =?us-ascii?Q?UWYOyFjUQPW3w/W3wL5+Wdscl46o7Zyeg/ebhyJ3Ms1FYSktQclPYjqno9dO?=
 =?us-ascii?Q?8qBrQJFVAGY+tmpJITwCfxdQQ36J1oaRzsDtmTSCbzCs+psXvggry8Hksmwp?=
 =?us-ascii?Q?gaPWxzSl10LNtC9T/kaIRKT/ot0BiKr9i3FFCJKBJdMIAg/8c7FwCTUa6u5A?=
 =?us-ascii?Q?kUe6AZCL8NnN5PcDkqcRwuMqqDUL/aCMEE/yAXhk3AhGqkyqQb/HS+dFDoYE?=
 =?us-ascii?Q?69eLWF9JWR5A2EmkHuXABzKg5l6AaOX7244/cCPR2sIdmn4Wnzuk/gmwREPb?=
 =?us-ascii?Q?QO4aME1IOA3bS+/BK6yb4ZvVT9ru3tgOjdHYjehVSTfiISqA8Too+6LqwM4t?=
 =?us-ascii?Q?g6qDpGPOyawDf9Jv4bdNJ7Pgcg9THoyhQ6g7bXvrSt3XFHs56YKi9mShgh42?=
 =?us-ascii?Q?JSUXmD/8dQUxJOtgt0MsotDW8CsqmntrSAZNpbuafhN08an2PGlUOkpPxcOT?=
 =?us-ascii?Q?+WtFSdOFJJ1gjU/RKm7I4PcXrqLsnEA4oJOYKs7SG/Sou1pTdaHEZfyIeIiQ?=
 =?us-ascii?Q?WTvouOS4lzZQbb4aSrE/+VAd5xwvs5Dqq75Nfk8xjnqj0wf6rrtOlJaGhHxg?=
 =?us-ascii?Q?DkabHNmmRiHUV/ElwfE/Dxf7Mfwo0l5QvYxEH/7GyQqej4IzTGLe/nwWbPs2?=
 =?us-ascii?Q?mPGdudQGVrjdFefCNpT9/RE4G0joddfXhqVXMb5eKlOTEiHBkJfekjbvLUVf?=
 =?us-ascii?Q?vpKoH3YN2/mgRGIcrUVZ5EaksKEJ4TtfCEovoTLgkOLk5dpSDcQP/mt5rTYc?=
 =?us-ascii?Q?hjavf5WS2YQ/9x1Do+PEAIAmN4Wrvg15Cay8nm/2lTwMIVZwzCdnIGNT9rJc?=
 =?us-ascii?Q?a0sgBw4o7/xvr4m59eLwMikJfJqKTLBSE2hPGov3Kj97zn20gs+mBnthrDok?=
 =?us-ascii?Q?C4T/FQIQFpEhC1exOOxrMEduUixoe1GEUNiK6hfTNeLeagcSp5s2Q8YccGk+?=
 =?us-ascii?Q?IGiGiXD4tLaspIQBm4sqFGWmk7t2H6bErBDIVqnLeX1xddgVez+nfXCDaKvg?=
 =?us-ascii?Q?KdyVFBKwBfkgPDFeLm4obFb4V1csxINd5uMPXt76s2+h6xieUQ5KCDKFP0nl?=
 =?us-ascii?Q?BbZphSmVbw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81316246-3822-4ff9-6cee-08deaa8e072f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:06:51.8300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DzyuBiofOXIqhCsNWrUzQMXKLrJkczddBNGfmLDb8aKoRyh+ga884gTROknFOHU6LFBDwTkJSmnorVViPPRQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8308
X-Rspamd-Queue-Id: C8CD64CBA1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7519-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sang-engineering.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,perches.com:email]

Some pragmatic shortcuts are being taken by PHY consumer driver authors,
which put a burden on the framework. A lot of these can be caught during
review.

Make sure the linux-phy list is copied on as many keywords that regexes
can reasonably catch.

Some considerations that led to this solution and not a simpler one:
- Consumers may be located anywhere, and their file naming provides no
  indication whatsoever that they are PHY API consumers.
- The network PHY API has similarly sounding API: phy_start(),
  phy_connect(), etc. Similarly, matching on "phy" would hit
  phys_addr_t, "cryptography", etc.
- The header files themselves need attention to avoid matching on
  include/linux/phy.h (network PHY), include/linux/usb/phy.h,
  drivers/net/vendor/device/phy.h, etc.
- At least for a transitional period, I suppose developers will still
  try to add PHY providers outside the subsystem (which is discouraged).

So I used \b to try to match on actual word boundaries and I went for
listing all markers of PHY API use as they may appear in patch contexts.

Bit rot is a valid concern. I will add a test to the build automation
that newly introduced struct and function names in include/linux/phy.h,
include/linux/phy-props.h and drivers/phy/phy-provider.h are matched by
the MAINTAINERS entry K: patterns.

The keyword patterns were written with great help from Joe Perches
<joe@perches.com>.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Joe Perches <joe@perches.com>

v7->v8: match phy_request_bus_width()
v3->v7: none
v2->v3:
- escape forward slash in linux/phy/phy.h in regex pattern:
  https://lore.kernel.org/linux-phy/9fd14d166e860f26febfbc9061a6dcae6a166961.camel@perches.com/
v1->v2:
- split into multiple regex patterns
- use matching-only (insted of capturing) regex patterns
- adjust commit message to reflect the Q&A from v1
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..67318abfd91c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10799,6 +10799,18 @@ F:	Documentation/devicetree/bindings/phy/
 F:	drivers/phy/
 F:	include/dt-bindings/phy/
 F:	include/linux/phy/
+K:	(?:linux\/phy\/phy\.h|phy-props\.h|phy-provider\.h)
+K:	\b(?:__)?(?:devm_)?(?:of_)?phy_(?:create|destroy|provider_(?:un)?register)\b
+K:	\bphy_(?:create|remove)_lookup\b
+K:	\bphy_(?:get|set)_drvdata\b
+K:	\b(?:devm_)?(?:of_)?phy_(?:optional_)?(?:get|put)(?:_by_index)?\b
+K:	\bphy_pm_runtime_(?:get|put)(?:_sync)?\b
+K:	\bphy_(?:init|exit|power_(?:on|off))\b
+K:	\bphy_(?:get|set)_(?:mode(?:_ext)?|media|speed|max_link_rate)\b
+K:	\bphy_(?:get|set|request)_bus_width\b
+K:	\bphy_(?:reset|configure|validate|calibrate)\b
+K:	\bphy_notify_(?:connect|disconnect|state)\b
+K:	\bstruct\s+phy(?:_ops|_attrs|_lookup|_provider)?\b
 
 GENERIC PINCTRL I2C DEMULTIPLEXER DRIVER
 M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
-- 
2.34.1


