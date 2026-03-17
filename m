Return-Path: <linux-can+bounces-7121-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PMtAnPguWk7PAIAu9opvQ
	(envelope-from <linux-can+bounces-7121-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:14:59 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AFD2B4043
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5807D3134DCC
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40A14070F0;
	Tue, 17 Mar 2026 23:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CrzP98zy"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D02402BB6;
	Tue, 17 Mar 2026 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788775; cv=fail; b=F0iUzCgsPfaPMxevLHJrZmqdk2HiSKg2HWhIYLYmk6vWIsUdyLZGPnP7iIu++MfgoWj3TyrnrmhEW9DEn45BTX5d78BiDKxPqnfqEvxljYViCiWVitpKxo65vQTv4UcpGpA6zBUVFj7JrTkBPCh4DHghrAAN8eNkqY00SwDgptk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788775; c=relaxed/simple;
	bh=g7F7kPc9dQ9DcUUzmsPaUuRnkHuIiOer3wIfG/7ADnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dllOzbxUtP8KO2GayZExTd4xy+wJJMc36DZ80UvHMtwJ1jut3xdn2tg99Gt1l70zGlkG9bvzGnmPXoa/8lmYsK+wmIOZ39k5IT9Ywj+qlVc6HJ2T4MM8VYUKn4fXhLl9ijrBC5tOrByr8SyITvU9oDzAY1RrltsCNOKI/hxlBv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CrzP98zy; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCsgyFiZIToTMBBxiRoSOJNJcUgRp26pSWBlFs4liNUpowtWcrYPLz6rnsYFY2Ys7bHx8dAltZDpKHtPfBNH0JrRIWj/sKQ/EsQcbfBgYPgijV6gN81kw8F03kmaLw/Z5cPXolCkweYN86620p52Ep4MTSDxitD9HpGSv1GMOTkRx6OBiPOKxnydYpH4l7qnWwaULlBQfFXTPv2VZnEIypvDL5m8ZUdv1Fodp50WlyltTkfXXk1Znpf5pPASL41cwttiHYmGeBj8ppMH6IwFUJToL1IIVXNwsONwuBoMuEjIhsy8RttjXsmfMlXnD5DIiooIDwP6dCOQzEVB4XrOEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PNFSwA2HpofViFk3LRph7tcQreLF/feDPJ3qdnXJtk=;
 b=HBoXh1BbRObh4FCYjzwPEq0gj/3oNCwqdkeA4Ugfi2TRKIWYp4M0E/GxociPbirguWjDHnFdHx5iR0QlzdMC9vQCJBlxqy0N71LknqVcO+aEVWPLlh78wuSc6l2FCJXA3a4Q7wgp+cUckL5jPMC5ZuUl6XzeVWbOlgTTVFqwktfA6fFJeurtVN3gpNmY/An5qidhXjZ3IUjguN97pymYa1P0MZ1vhHvUmVE+jUa6JI4PaU0soGkAq0Jn2Go7n94U/StYaZMB3AHR3GfHxSIg2kFFNc2oaJo0OvsXSxd+tl3xQxNNdYnuwmF6OoG5CcB5CIl3YC97U/l1HH8wBWDPuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PNFSwA2HpofViFk3LRph7tcQreLF/feDPJ3qdnXJtk=;
 b=CrzP98zyQ0KM97fkDaqZV/LCmlwOpbdKUlodt3Wk41b+r8A9i6VfA6ySGS8peImDSZPzzu7VjhAVQLLmdYFYvml3p+GnAbKC1PTpGlQ3vnMPHVCvXQqGK8VrC2syzxE5PxvR33upNafrVFkV6KgmIH3ZXpSm/2Mh4v6Nc7v+7vWY/bGY0q/TZUpKLYlgZZ1AGv2qFoLJBnwpVv/BQfznovye9enUNEXUwQ/Jx7VB2tjXo7+PqSXmz6P6EqUGZ/6Lek2nm+rovvGYjfxmxZI+7TbBYerBVrndGSueRGXgaYpS0U4bWgLVEl6SUeKkySpzv/00Spgqwcfbm27ujsZLnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBBPR04MB7643.eurprd04.prod.outlook.com (2603:10a6:10:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 23:05:51 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:51 +0000
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
Subject: [PATCH v4 phy-next 20/24] power: supply: cpcap-charger: include missing <linux/property.h>
Date: Wed, 18 Mar 2026 01:04:56 +0200
Message-ID: <20260317230500.2056077-21-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::9) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBBPR04MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ed852d-391a-4e06-12be-08de8479bc40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	W3kLTDtOGKfDop7ROu+UXPZLpfGqOyj3oHTYBHOIVa8ln5+4i/HSj1SsT1ltmfvzTp/cH1HSBziII4nj0mYwLulwf2ruhlrXPPRhgCU31SnIBSTXtK5I0yL2cd+ZkQbKm9TFIxQ4rWZ3CRjxbOqKdZpAS9P6pMQXux+sG2DIzCXuiMLYZAojAQSDm4eHneWdV+5uwkeDrMthniBJpxNWnkr2w7HaZt2qnXYp/sykqvf1uV/yuRxnrfh4bk38cAZ75569MzDm0+ohn8aT1m5KUWSE5Kzz1IVD6Bjb3FrJZtRb9Z6fhsPdgdQUvpEe1Gg0ftv/cYzb8V1f2D8dinvbKH66UEOGDxpMUqQVyudzQ+oMehxbeREf5nfVxo0lUqvI1Kq/gq+FLvehyO4MUBWwt/czpEBlpkGG86X1VnJ3U8Z8F7WxATRGrWCKIKHljE3hQflo+43DRb7PwI3c6tg31x+8EaRx7eL9oL2QBFfWBYHJhOCQZrig/FWERqBcMMyFB+FeCWCVz7DGIKIQYowRD0bP67MkvrPFgB49USTdqcV8egqG/qwafjM9CNGzQFp88G1+5uCfx0M8IyIqiW5qohp/BfIG0yZcQptT92TirRK7SH312RkAgdt9LP2Gg2hC2Lh3h4Og0AErLDDd2ZuJ2/s55meXCn7rnGboe2I+CzTaWtonl+MLwnvYj6p0zSwVnIoTqq4ya7Y8XJ3JvncKnQSXBLunBOyUKDprF56vjQs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pe2aT+C6QNpeaTde4EWUROgTDZ/90umtxs+CaVwPgXP/+lXKjhNgsDY2H2uU?=
 =?us-ascii?Q?YsF8Z0oqEbOTWSw0LbO7A1UPgn/OWadSu8f09TDoA6IMEVZIadIBxeVvEN86?=
 =?us-ascii?Q?CNy3PMnXiTA+jH3LlMCG1c6DzSs0kBY0JvKcjw7gsT2X7yTWYT4MqHwd7++a?=
 =?us-ascii?Q?FO+kPwd3EUv5SnFWp6K4JofkKIugXSWvWlsfJyT+YN085Q/cEDSMOYAexzGz?=
 =?us-ascii?Q?bdbwU6s88mZg2rD/Il+DZBEzjlwYSaqijeRA7OdvS0RsuF/Ks7ZI9ixwA2GQ?=
 =?us-ascii?Q?J+ktFz1OZyQCRDtfTi4HZDeI95y5xC2Rzgxo1t2k9BFn70p396msyPkcx1Oq?=
 =?us-ascii?Q?i8sJHW26no92wjr38tg96mYSdPqJDbL/cRLLokFq/k56vWl9Oa5qyGOb14lW?=
 =?us-ascii?Q?MLGxaQXmUAJtU2tsLoVT4eBW970vKkaGwP8foxsRkpEU5x6eI4Vyl+hlSVLw?=
 =?us-ascii?Q?VTgXx6sf4mPjypfSNtEvHeso2MaHGcN/NQ5NznQ+DLc1xulrxJUMqC2MXdV2?=
 =?us-ascii?Q?CPkWsgYmp2EWko5jsdUv/+YQBT+1dmrnlxzSA0iENAr8l31tICtgz1hQf0RD?=
 =?us-ascii?Q?B3Nw0pQKgfWIQsytCa1X4zc7+uP+aEoM0dUHv9UH1ed3AIZdR1UxQT/FnMU7?=
 =?us-ascii?Q?Usdt0V3dgDBXfZgq1v4FwTFksT/LGbgl5jgNdT4mN1oEZMBDFcOtxaMqg11G?=
 =?us-ascii?Q?Pf0FSSMk5AlsWzzv/880YhRTaCAxDfk1hp+6WUcPagc8hIc3NwfSNv+Y5VF0?=
 =?us-ascii?Q?KI0E2nk6/xcpC41nLQ3AJNjdjrktzkgsJWJz+dffLW9iIIInK8Wj7NfP/nwV?=
 =?us-ascii?Q?3TO7g0tm487OF2ia5si6Nx8Hp+vzLU4a1bvyyKBeS4YPs/IkHfg55CoDa0s6?=
 =?us-ascii?Q?vOlm/n1ktmg9cRlRX7aO2ty0EDCR0XRr0Bbx+jsJv+I4bXGyekzbkYba94cn?=
 =?us-ascii?Q?30MuYIfur0Rpd2LO+y2oozu4+EW0mdj1fgB3WNiPXAAY8yHe/Cn4FID4tFxP?=
 =?us-ascii?Q?YXNXIOVaR5PGiEY+Qd/x+IdpwBSbSKCblIKWAI3K+BWgkw3iCHekncy38zgt?=
 =?us-ascii?Q?S9robjR7dLhueFOVLbtuAc9eMI/EqL9iiu3tPQblsdEHLWxqsT1xFURw0s5o?=
 =?us-ascii?Q?XByS+8eYszE0u9mOzFGHceG3l5UHUPnZPf5zx/PS+0Rtncsyy3mZLkHLjd14?=
 =?us-ascii?Q?Kzxi+E/ZgHh3v3rN+Atg98+SLo5+pgpz5bcArnfuqbuIt7C7MIq3/A9Kdf+G?=
 =?us-ascii?Q?Vw9Wcgmg+ggykMbF16XtO81KrW3Psmc/lVwptEn/69DmXGk5AIt/eOsa5BQG?=
 =?us-ascii?Q?A3oH3dVHloL1D3H0wdYW+8Karf1h+uxklX/cVEMRmE139JN65E8PDO9M9hTV?=
 =?us-ascii?Q?f1fYXv5lC6Hy0L3HOo0SG9D9ErVEXXAjXXDFywVEA4Gbm1krj7SeGwN4sWIj?=
 =?us-ascii?Q?/GhQTJ2FajP8HbxyjyMed3ETkD0t1BPSwQtNuVR0RISSWkQNXFLV51agJ408?=
 =?us-ascii?Q?TOamzvwz9S3xy3/u/xRkZ9g/bHfBvssKmK4ZeIfJUkh7y6Z2uscF3HKS1J4j?=
 =?us-ascii?Q?0xH/SzGhsAWUdapVz4ATofwq+p/XY/0hvgoxER5s+jJvXhxNkH2VC7StVvyT?=
 =?us-ascii?Q?hxZTlbmZtunGJnSTuwaEPLvpyGa2NTgJ8yGr9PxRbJCACmnmySJxE/yyDOYO?=
 =?us-ascii?Q?YdxOvnDsS51DIi3btefY6E/PLjebFEk3xIaNmxAqyjVW2PTKTAX1HczwNfTr?=
 =?us-ascii?Q?k4MkdljtJmYCWUgfoT+PRpJ2QQRXM7+YW9LcYb9QOaEK89ZTtGSXJ1up7BB6?=
X-MS-Exchange-AntiSpam-MessageData-1: 1n/YKV0lq/MVnPHdSydc5vOjXWrS7Jb/iGI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ed852d-391a-4e06-12be-08de8479bc40
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:51.8563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVLVbrrrdqB/4lNQZDZe3BB7V47q5+QhYd0VvSs8uX2avlO2h6Vm6nlpUXcBO/zo8y0p7pAQO35Na9HgWxQtAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7643
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7121-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 93AFD2B4043
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

v2->v4: none
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
2.43.0


