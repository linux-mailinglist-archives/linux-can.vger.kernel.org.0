Return-Path: <linux-can+bounces-7195-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHzaJoF+vGnfzQIAu9opvQ
	(envelope-from <linux-can+bounces-7195-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:53:53 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 463EB2D3D9D
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1973E32FCE49
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7D943D503;
	Thu, 19 Mar 2026 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XR37Amug"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7339E43C059;
	Thu, 19 Mar 2026 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959630; cv=fail; b=ZkONCv9vqbSxUDeNulARTDXr/u/QElUl++BAhN6nWbO9zxubyW+IkMejNHUA3evAjExQLP2X/T6ii1wUySW/VhQUfXjsBVg5XmHAQ3yV+rL8MFVMzQgrGz5riUe6uNNxvV9eXe5OPMRT2NL5v8e3vA7Sp+Hjbl6iRg7yGmJ7S7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959630; c=relaxed/simple;
	bh=HTyUfTulqVq0RDztEicQ2jQX626WgoFiGnMbc1Rx85Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bNqun2yifAzi2pXj5lOTavsM9Uc8TiF9E9cl+xMvsg4H/LbTO/7tyP+tFZmrdQky4wZtMDihAff2byQ9+bCTljbSUd7IUY7W+jqHA0IuO+17hZkUHE6SbGzVAbgqc0UxvJJ5aTwKC822Ifv9u/fg5w6RhbfxxUVVNLludNiyipE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XR37Amug; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIdjFHDsL/47QAmjqErULxqRFrl1iUTpaJKDoor8L8OFSLN3Bn1+WgCtSX+VP2ZzIwk1KnwrpoLxzrQtVcR4lqZaerFesihKrOQVVlSHs7Sjz0/mGuy1EbsZ/ru7nzYKHH/US2fh7vXp5LyYHRbJMCwBGMRjFwzgsOJyXlExZl3tg7xZl++5yt/GCxB/8gb+bwfqDpIrmxVgYnn2Y818v2R4e9MlhLPfHdzQJyHDFy9iaj3+fD4DfFZqtPYBndK7EwadGa7btJ0tKKMlyL6Sbsz36AugI8lnI3QXo16k4yvAkDEMLeEl36XCUy7t77djORloZLTjBJpjEvHtKLhslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpcMpOj7EkX9LGxVXmbfajSEtxU0/+RWcEpKRZTsXRM=;
 b=v3mTn7XrNbHbVWFn7HQyZCPKiIGC+BYCoOx6zsZYiqr6pZTiH0YGF/VjIEACwkg8nENRAdsVRUf7gnQxU/bagK/HEmxOdv5hAYrxW8elH/SgDGU2uYCbtLo0qp1cIDY7kNxcuCkc7zJZRGVOhiXGfaBVRkpSHQjTUc41FYfhEy7QE0OtqfLW7jbN/jsHKAIKRLT1OfLV+YqigyqILhzE8D5bEKdSsk+yMIZvhiZQ4tdcQjKkC4i+drgF4ARDq4508LU4MMC74BMI9vN8en7flM0m92oXhCUeDgWin0o81wXcM6kmxkv6UHY6cZ7tGkgiKInsAGVuU3tLuARNATGv4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpcMpOj7EkX9LGxVXmbfajSEtxU0/+RWcEpKRZTsXRM=;
 b=XR37Amug1oBl7LRouxRGD4KTPSHo9KXfZShSAtusBNIPsCz2u2Lfw4QqSsumqP8kSGIJC0+9aJDZmMtKFS2hJE34FSmdyWWM5pKT4GX/AmwvWTPYNrypnAmsWv0v78T4Aej6dmcWmPVS02IVUYCjho4/7ugzqaA/D+auuIjSQnQcj8UzYPeM00PpaSPdW0wY7tylJBaEnwWeBEKrkq2R6vWW/sJlfp8XFTHnZly1OrPVljQfCrOSPoaKVIIKCxMCyRoBLusQJHa7g292NWDN2BQ0d+QB8dY6mziXt15D9G+IRJuGY+tAigJUj3JEViaZMNAdohPIarNcdkZpVkl+ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8079.eurprd04.prod.outlook.com (2603:10a6:102:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:33:40 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:33:35 +0000
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
Subject: [PATCH v5 phy-next 27/27] MAINTAINERS: add regexes for linux-phy
Date: Fri, 20 Mar 2026 00:32:41 +0200
Message-ID: <20260319223241.1351137-28-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0015.eurprd05.prod.outlook.com
 (2603:10a6:803:1::28) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f155316-cf66-48a7-2bfe-08de86078eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|19092799006|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+upsZRuFux+K3Za4MDzyFPN1x5rH+PJrh420M2R5VGJDNHHr/TdCnsGLKHLyEtWu85S6TIRNB6dP965mPlJti5Ot5gC0tUieELO7VcwWoono3n4M8gWs71YxBwrPDyyocXXoL5B4CzkjwD8aqFeE/BCda42h3uu6Zfi1YKiomCMG2pC9t8gsPj3y4obYVXTbCUaybzIgsfQrwTrH3qk6hRcW+TRFxHRY9Jy/IAoVFjbAC5m9hBe2o33XVCvwiz+bxZk0wEq1rNl5b8UQfytQKsUKfXoy8ym0WeTvskCooZCjmpNEWG8P/mdEVNec+rmUN1i8RK79yU8nbWhNrnWk2aeCHyCq/g6W+Vxqqua7W2IZo56ybJTlEaoch1M4g11WEJVMcbunuDQnGU+FMvq30q8ZyQ5YP7/+HoNSIQkdU9W7HVJLMY/RLfOmVQ2upoYN5v/hmXpKszgaOlc/9m6FRNOY1xLLnBuwyuV0SVcuXlDiFv8Mqi9QxeRQUbIyoKhV6YZSziEwXwS602yoFLjhBRzrzm6pGV+sqp9rSApQ3VlAGgCqSoNnhwZjlkoZCJqv0JIEbxxmoX/f7FCtR9vxL7MLMC6wVqsEfTX1Sd3Y1Eo0/5Up2e7LFTwHSt5HlkmnIOqM3sObvp4e3lQmpcI0+pkTRcuSZ1BAnumXwDD47bA/Efxp5YR+vToivywgPPVyGqJh6bXNVXBtjaQw9xkYgCkq38t+bd5wIK0e9ZI/O6c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BUVxklfbXaPgcEUOwJHmNzwgNVpQMJ3Tqzg/1ywEUGc3bclL5aimK7VkU3g3?=
 =?us-ascii?Q?4QPDOoFP9yx+GXcqI+fOLgWazng47f3Q0TDxNltke0/a0Pf8ACsrLfjxI3p0?=
 =?us-ascii?Q?4aCY9QVWpaH5dpUpBms6GwLQ/cktcQwnsMJKnN140zviitd+axivyual8q0a?=
 =?us-ascii?Q?iHUT2sk7+t9429mwAnx12CSzhnS2fIVnYJ5G+ixY/AuRSFoL8wyBuFTjiEkP?=
 =?us-ascii?Q?nwcY11OxLEjLgmMi811PZRc0ZKQFUVfVpJ5h8E0jCPCmQ8JsVoxXyHo7scI1?=
 =?us-ascii?Q?w/qJUq1FIxBuUva6riTzu77upXzaX4cOUWF+iHdasK+kpaULK55rguJTx7xC?=
 =?us-ascii?Q?6D7HKw3slmoABvFXg24+4QCOFMhMFwzSADBvDmTHpKuq15MPaJ5XFCWO+vNk?=
 =?us-ascii?Q?o8Wlnqv9xC893TsXZgYq5iqIRWwQWAUmxiZs0XACRL6AN2I9dJpMObF7vqTh?=
 =?us-ascii?Q?FMqPvBXse6L8uSncgjcEHaw8cq0aoWWA/gdkfYhvSGWEVnozF/vswl/Jt/7t?=
 =?us-ascii?Q?cn1BVIDhyitpYxxaRP162DYBPBrf5h1EtR+tkcaNxPpDkDMtJSj1cUDCOATL?=
 =?us-ascii?Q?GT4mWUpVygfPxCNncu6uhglg0LeQ0w4FxLNShUUThiqFn4fuSSM66VVztDtD?=
 =?us-ascii?Q?lOFKCurqZjx6wkfVF2VvAQ7YJ64QJ/wXmcF2h7xESFf/Zzhv/DdYgAqWwgiF?=
 =?us-ascii?Q?w+0K5E7LhEvmhc59XDMZboa1PvADHW+Dg4u+O1U1d5qRzlNmj7fOlyC4YNA0?=
 =?us-ascii?Q?vydq0OV/a4wZsdbrpmPpdNfeXxASJqnYHs7vX9yrE5AXcty8zOYTQ7qVyccN?=
 =?us-ascii?Q?yQCa7SBCdbrUr4NGsIoHlD7Db/u4jOunyxOVh/cWSojmp677WoLb6f+0nRiO?=
 =?us-ascii?Q?i4mnSI+vTABesd562KICBi7Jzm7ruwpWF/0NVZCFcg1dha4yVHkbMcdggYOj?=
 =?us-ascii?Q?Eh9NoiE0t0GYazL39Uw/Pz/ovZOAipQTRwZoeMPHhsAopVbSqTL1NVbZk1Q/?=
 =?us-ascii?Q?U99tBcj33n54ILo19pHdguESni1xCugMi7Eo5PW0rIyG4B/GIdwPzop+m6T3?=
 =?us-ascii?Q?ZT2gtILwCBbgKxHXS+RrhHtiwGUHFfj49FesomuEOC4d0jNFEwlgy1xZ9Dut?=
 =?us-ascii?Q?iT7mPlkNuyQh2dJ7pNDt3b2qXs3tkA5ESIjXxMq0ZC2HHCr6LIe7/soUnp/i?=
 =?us-ascii?Q?ZDFvaDxDbB5pgKyavHq+RL59moCp5Deb3L2iKUJdx8phW/4I4f1k29v4mAYN?=
 =?us-ascii?Q?ipE6bL2DlT4YoneKFLwJVohBEPZQTIgW+pQnb6fKUvI71eseCzKzbx4HsB74?=
 =?us-ascii?Q?9JfiKeRhxfr3tQrlHqhysihL3x0tAC3GEjnHWBzcEshfugwj1LiFqEkF9Yxn?=
 =?us-ascii?Q?sqnASDUel/SaL1rhVpdeyja0kuODHZKDIUPBThNrYwVfww7I47n7ff/mZr+o?=
 =?us-ascii?Q?wZI7EliTSWTGVcmAQIVCunkD4gNkqK4I2w6cURu1bH820QjeOU+fjDMaefnM?=
 =?us-ascii?Q?M4HdmGKkvcrDOUXRInNmeurSmTyUvKbVUoMSyYrC3MwEL72YW2LCfmoRQVu9?=
 =?us-ascii?Q?H0uxt9DxQ/2OAKqZwO0bRwY7FsIi85avDAMuU1QI2nBMEssW98iM2k68J4lS?=
 =?us-ascii?Q?qJUlkJwceOYz74dpNHV8HUELMT0dO1R9Z4urfPkOcLNxQ3vyL7PbcwP4jwPO?=
 =?us-ascii?Q?zD94jdZwFxDyzHuji38Dh/ojguNjTzRDpGB6n9cW7yfkC6IFChJy1dgGPLRc?=
 =?us-ascii?Q?OyIrsYaSTtWQ9sU24iD7QqwkVmDpwiVX6M3HEt1fCwoy/yNNJYdrWkC9dvDk?=
X-MS-Exchange-AntiSpam-MessageData-1: wMK5jLXYNFIEB3Caef+8LcEsblTw55zklXQ=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f155316-cf66-48a7-2bfe-08de86078eb6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:33:35.1356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ya2j59DNYhEX2w7Y1AEtqKr/jDEBKWp8+4i4QMDCW8wm9ElNvrA4nVUDpopY9cW1EJhnjWjZAYNw+lsw2zAEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8079
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7195-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sang-engineering.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,perches.com:email]
X-Rspamd-Queue-Id: 463EB2D3D9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

v3->v5: none
v2->v3:
- escape forward slash in linux/phy/phy.h in regex pattern:
  https://lore.kernel.org/linux-phy/9fd14d166e860f26febfbc9061a6dcae6a166961.camel@perches.com/
v1->v2:
- split into multiple regex patterns
- use matching-only (insted of capturing) regex patterns
- adjust commit message to reflect the Q&A from v1
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55af015174a5..cd920f14abde 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10713,6 +10713,17 @@ F:	Documentation/devicetree/bindings/phy/
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
+K:	\bphy_(?:get|set)_(?:mode(?:_ext)?|media|speed|bus_width|max_link_rate)\b
+K:	\bphy_(?:reset|configure|validate|calibrate)\b
+K:	\bphy_notify_(?:connect|disconnect|state)\b
+K:	\bstruct\s+phy(?:_ops|_attrs|_lookup|_provider)?\b
 
 GENERIC PINCTRL I2C DEMULTIPLEXER DRIVER
 M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
-- 
2.43.0


