Return-Path: <linux-can+bounces-7449-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGp3Lpw682m8ygEAu9opvQ
	(envelope-from <linux-can+bounces-7449-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:18:52 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A68224A1CB3
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 567CA303FA6F
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123FC43C05D;
	Thu, 30 Apr 2026 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nTDb1lpF"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547FF438FE1;
	Thu, 30 Apr 2026 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547265; cv=fail; b=iN1eBpa7oYeGB3YQYc5m6qHjz2Iz08XLzih6UbdR0F2OGjy3yvyJ/yzNSaq2Hu5ZtAPeIgFQHfHSB696NhI+bixWQ8svzNfhoDQKZgB8jKuWgOen52+cak2bdG5hFXZcrldUUj0ABKjzwppZBtag71bXrX/RKVCm0TnNTY8+lqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547265; c=relaxed/simple;
	bh=ITEJha9zJ8KukBeXC4o20HODay/7WlFi/tU3pC3JzDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UfD+KpClOhIKVM7csT9T/dpbNPOl8KOq8VMyw7BBVEG+oQB28qyGXQLkt/Yc0wSh8aGwtBVtjaLDgbribAFyS48tb0kFH9iaGjXmnY45mdwlrS66+kL07hOcyMO31xs7q7dMQT7TEHXFjFJrvzg2DwZ6mo1in6y7EOL/tERLpB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nTDb1lpF; arc=fail smtp.client-ip=40.107.162.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9Wt+sgOcCMKqxZYUeOV3Xz+rb6TNFPKff32yjtncZbEydBG3HyYx+EKob2aYoREThXWAjz1DTcIwigRzHZjzqv1Fb5Sdapa84nHXuJqsd+sEdhSszhSXFCK1xCyGJZutODUJQl+XdLclWKewopePSg4ENvbuM8nexhgJGXtcsGIZ18MCOY8V9bH+1lANjU/2UD1fibsJoQDN2pKVxg8ZNmcMbsJz0dijHxHPRwciZNnYHA2ayQOOuwDjsJdce+4Kc36+cr0x82eoCYRbDQpm1Md3eenPAOx7DBtVjKebSNC57n7jAd7s7P+Jp4/wgF5VtHqM2znFkHtSFH1oC0FUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYoAO0Xo6F3IEHdR5a+M66oRDmH9iXSBJk5KxBuqk8E=;
 b=IIyP7QantjZ1enfZ4hjqbClSHlYlU9W1GHycbSXkomPcd6QboLwxt988BhfuxPyQzgyQyPXQXui41ssTiDgtVrSAASYk2M8ObQj+1i+i5Cqf0GV75zv4qkGy7+/AcCDs+4Pof3iB/oIp3DyiklQi7G3OqhP05b7k/H0URJA8guBFebNK/U7KKzXnx2K1wEkevh69fWVh38hR8y7Q669Hn/03wZoXRnNim5YvxF8nakhYbQLqClKJ2jFJ7Hnl2Xa+LrNOuPG6X1KrMVt6zbgIkfEJN6x3SkFB7KAzQ3l2bK5BB/8gfk8ujOPRoghlV8EOasJr0JaqBotyQkk6VzJvcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYoAO0Xo6F3IEHdR5a+M66oRDmH9iXSBJk5KxBuqk8E=;
 b=nTDb1lpF0ixYY1bY1VYKhV+y8paujEP36dO1zGWldaFKKs4ACgWuwc0MpgY7Xt4miFtDRK46ywgNeGarKrgXMXKdDiMmKyT6CkeHUmgUNnd3B+1RvuChq1gq5orN+CCJfPMDXNEYrg64XFfvyI7HYG4FdeZ//RMSBkZ6CMUcUV69D36QOKe3mF54C7C/MvThyics2CYBQnUvoNBlx9eU2wZoBRUdWIdfgZrj0dcGntcRosIqIqtvUCPWZ8Kg8gS+EEiP3Rn7fdXHN8t64xxM3bv08j9JY6l9RS3v1bFNSh3813po92miLxsXjYiLuxd83G+Mlh91rd7AIMwuf0oXrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV1PR04MB10583.eurprd04.prod.outlook.com (2603:10a6:150:203::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:07:37 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:37 +0000
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
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v7 phy-next 23/27] power: supply: cpcap-charger: include missing <linux/property.h>
Date: Thu, 30 Apr 2026 14:06:48 +0300
Message-Id: <20260430110652.558622-24-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::19) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV1PR04MB10583:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f85700-710a-4050-9753-08dea6a8b019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|10070799003|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6ZPAkq80cN1vzhq3p1T5YtHUW/QhUfx08KbVLr4uC0hupgSWwphINffwaDNwxssLxYJamXZed4XzcOJP4CU5TFxC4OTSQdn3ggngg5J0OHAXsGBu3daupOc2b8c/7PV9W5OW4TLA/D/Bf2CQkDaNuCGfEfDsGXcrdUZR7v31iTvGSJ20P94TUE02NDvQFFTiKgZamZjFRDeUcXsbj9y1oxv++MHfRqczg9Fs2iImfXu+FfudO+Pq4OznJKckjGTFzQo17575mDFwooqf9KnFm92aK4Fa39oz3u/W/Yxg9HE890O/VJvxzO7iIuqkY4BdYPbRkZjvBgw97E3QCa3ptoJg1kHJkCpXYbqcvu6ueI8zWGxBdJojKhG3BlUl527cytkHa9lbS1GfrwSh7fXcpmmnpFHHXDcoulmU02QdeAB7AGGe3xx0osECjsuhg6sXkrBDQ1cme0R8GKhs9wy6Z6MprMAOQXsmzMj7GcOIe6mmKFFhuhNDa/8JFXxjAfMDCXFgkexGVCocib+6iZDWzyNfoxIKalia5uEj8WBKAa4TFfY2SkqZ5A//SlVBcDuh+4bvQBO4OUbMmx43D5Oe3a0x+2irUKBUpo9Q+b8UA3+4DJmnenuOCOkomMb8jsJART9prTwfT6yvrE15uOSxOaDM8il4utKMwimzN6ad8EvSLK4PUVd81VFFPpfG79vHrl4VPStxTTWi7QSqJSFdh7pXws/dMKF3JbBg0FwNBZk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(10070799003)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UcbtH1V6qak90plvja/ckAEr3G4WNmdfzRfPoaUEHqDs9Z3F4B+w1SuwBedT?=
 =?us-ascii?Q?r93gtYj4cOxbnr1v/MfK7R/wPu8QPp8+hFX3VIyWLhI6KklD7X091Rtz85JQ?=
 =?us-ascii?Q?wijo0HShnonoJQ8OUifvI5gocipigUS+xJqIEVLjVB5V9XBoHWIcTGWXNsPf?=
 =?us-ascii?Q?F1shZYfxEzkLradm7bu5nx+C1scCildXlvTfchU1/6t5tVNFeQ73tJwZuand?=
 =?us-ascii?Q?qPjOhp8ya7hFxj8S71C12cihX5mtum0F/Z2xoaxZ1QyQ5quw9MDf+n+no4WX?=
 =?us-ascii?Q?zqbSUnVBE0PxxpiUuY/+pCeCMNUDtW0ZfJmuEyVoz6vGnlv0Fv/SKn+GOfox?=
 =?us-ascii?Q?Ye0ciJ59cBnItpdy7Hw6TUhxPd4Kqxa9RqUcXUDq8PvmysDVJjhME6rx7rnm?=
 =?us-ascii?Q?oi3ZNuq+hnGhKYwEfYaIY5lC39GyI6k9GmThBPJf3si83pBvW0hI4vdKJD9H?=
 =?us-ascii?Q?GY34U94RB3UEsP/5FXHzsLt132yleleafZzyKPEGEhHbCHAmcGvsw1B0fALF?=
 =?us-ascii?Q?O8rP11GQeFVezEp2+PXOu3brdvPlXFtn6M9CxLgoJhk1TBM6Dwo+3dNOpId1?=
 =?us-ascii?Q?VQ+0bb+LetpBroopOGEmkRwFOwAuIz8SzPirhkPb6SpbVKQSJnVh/QmN2W+6?=
 =?us-ascii?Q?3qC7Xi8XORK8U75DEyiwZs9HoVNDSogXpC2ULujzUVywFngDj76hbboGKu8I?=
 =?us-ascii?Q?CqdDzXUoqXxlOVwz/XsKkDzG7nPJEu95/Kb8xAcN1jPDecvsn3TCOcpQNOOD?=
 =?us-ascii?Q?gb3iTGKBfrOGFquJyPKhgLRC2iKOoshs/9569WlFRcjWicZFp0FmvBs2pESE?=
 =?us-ascii?Q?blQGz50UrUmEaE76FxWR5GUOkGje5j+iu1Ay41V7yPLmK8+MwdEfYLqdXVmc?=
 =?us-ascii?Q?KByMEd5TS96uS9C+VXB97oESmJOtlcj3tS7lK0muESQ67EN1Tf3xOYvrXoIw?=
 =?us-ascii?Q?Cj0yntH2bjTqIV9u1lvAH+EB6puRICtFXD5cykXz80lzhoS+tlzwWQUzcteo?=
 =?us-ascii?Q?nQBYOieqttO2LySZSivXN4FRUV06m0HDs7j6xUB9lbz78jOX/MdhjKvm3wNL?=
 =?us-ascii?Q?zbmNdGXb9r5BIya+V0CvZtgdKsV1aWA4asG45mmSVM4zsMAVDBphQ3RACXjp?=
 =?us-ascii?Q?LJikXWlSuJGWiHJlQbOTev2C0ev7VEv0VK3N9FtPq1yFwackdITr857/6BKG?=
 =?us-ascii?Q?DPNGt/eSL0kp/4OzWu7T4YX16X/sSBH2aSxBDOUJIDb46K9mWbDY20M8wJJQ?=
 =?us-ascii?Q?gqF5CSGpnl9Hm9VsANV2BZGcj+ojF1LMKEb+TKKgP9t0yGOleRp/+XNbVIbl?=
 =?us-ascii?Q?CuS0erJ3jwc1Fb97K468KGOGLLPiT2fKxM70xaGTJkQMJfidURC0JdCQJYB8?=
 =?us-ascii?Q?rQXDiUw+D70xKQwFsaD4BinxFOttEw3YjDwZ1hO5McU6uEpTvWLQjqgIPsJ1?=
 =?us-ascii?Q?zWgxhEwvRgsQ7iRamoaqENqLacQLhymJVl3molv7N1v0OFLnYILh9StlH9od?=
 =?us-ascii?Q?552K/55rpO2TdO3E0eEALaGugIMikA9bUjRiJt1VV1hGO2BXBpKCj9zAf4q2?=
 =?us-ascii?Q?JfPma2vD0QxYNhOisFt5TtBBOq20FeFd/0O5LrnnkXIfdZjHR/CKOmVOeCK3?=
 =?us-ascii?Q?E86+O18v5FGVqqCT9FzdULFjHKTa/Ye/ot7mGCZE0WB/DGvPi+Ed/9Xxup98?=
 =?us-ascii?Q?qJrAxNle0Aec7wf6RAm3JD8+tfpsSrj4GuWcDC1+GN7SJiI5Pn59FtyX1WGZ?=
 =?us-ascii?Q?w2gRXyA9MhPEsMLi5bts8jl8R0xk/J/wjFE9Uaq65bsMZ+vLInvI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f85700-710a-4050-9753-08dea6a8b019
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:37.3213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByjJ3dPsSFvgX2VcZQQWh6RfjFxgnNe5+niI30WqhEGSCQ8CcO6olw6Onkw8Mlzn3g96H2ekW2NGNPtJYO1Ceg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10583
X-Rspamd-Queue-Id: A68224A1CB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7449-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

This file uses dev_fwnode() without including the proper header for it,
relying on transitive header inclusion from:

drivers/power/supply/cpcap-charger.c
- include/linux/phy/omap_usb.h
  - include/linux/usb/phy_companion.h
    - include/linux/usb/otg.h
      - include/linux/phy/phy.h
        - drivers/phy/phy-provider.h
          - include/linux/of.h
            - include/linux/property.h

With the future removal of drivers/phy/phy-provider.h from
include/linux/phy/phy.h, this transitive inclusion would break.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Cc: Sebastian Reichel <sre@kernel.org>

v2->v7: none
v1->v2: collect tag
---
 drivers/power/supply/cpcap-charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index d0c3008db534..24221244b45b 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -21,6 +21,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #include <linux/gpio/consumer.h>
-- 
2.34.1


