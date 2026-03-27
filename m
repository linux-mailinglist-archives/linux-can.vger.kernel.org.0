Return-Path: <linux-can+bounces-7289-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMnhFgrWxmmtPAUAu9opvQ
	(envelope-from <linux-can+bounces-7289-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 20:10:02 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DBA349E34
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 20:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91BB631551F3
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28F04219F9;
	Fri, 27 Mar 2026 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YHel0CW7"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73661421885;
	Fri, 27 Mar 2026 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637370; cv=fail; b=e6sAmGiXMciOsqBjngLUQkl9U19y4IYW8jTpjv05eFHg+oh4H683U7jTv9B5kWSSifjJP3uLSz/2x00a+IdP2DhVv9ZTgzmgTyIo4cWu2AA6cWA+kB372kya/K8tVk/lbAat2FrolH0H+wXWjQCozmXvJTMWF5ssIxYjmM6sAlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637370; c=relaxed/simple;
	bh=rP4dieBrl39fLRkbsK7KQ2T8sU3Dy0adDRks3IqetG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ejmmzQiTDw7y5WY3syGsUIDsYO3a//m4oNRvmiZMici0U43A8RyrnLMLf45KayuMjx1RaKzfFH/fNRi4QYvJIt74bS7qUHl54uWAOumrxneUoNCSPa954fjgtwGIa+KRZmShP32S7kG4X6o98xO+slMu+CTEq+muOr0kia8RlW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YHel0CW7; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8RqafUT0C0JmGwOiL6Zwrum7uQW7TeIaNAXFNq1dUgtf+cXWJFbv8c52ftksm1fFykhYIPkRzs3CGUeSjQPdWOahuzms2aEWpEPEc+89vojmkqDN2gRLIEuUmjaO47ZHfIdYIovKKQHD6stQYrpIpTibsFTVJOxW6BTkh9zFuvwIZUodkMBQg3x2SvRuFtTZKHrb8xr/0lW28E/LLeDy50ZN8TkZTklcY4P64NQ5HWbEkhwz5aPNBl0acJunXn6u+ZZPaqGBXUc5iJQlNLQr3Ms4jGZeM1Rg5Y3RIsEad8G0exJuxGUd7a3CDYASL5CQadynKJPpGdaqGZnd8jsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf0DJVzB5AqYsMlYayKJE6s+65uFtlVtnQdPks+qta4=;
 b=W92DX1DzlGyLzx/0aXlOk311434ZjzTqqGXMyRA7luRGOKetWy+daRW8x9qOEGko7s8OWhUaeEK1azSIytXsQg1KQkSHsfQg2ORus6EztGXQGwPd3mwqAYKry7Um3bSLEFzqYHGrJmYt+K1Dv7GKZIeo5rEdIYsG2696kOAHaKiKUx/O7qEMiQ/TnOzyt+d3zQR1+lTh4gXfzUv4xbbETBlENxylxWmlLfij0evBrC4dSiIHOYnIVZVcE+wVapcgNcs1qM9nvxl0Pgt33Fn4TC/a5Dyi4JQSfGBQHYASNKIApy0HYKlgv58321QhFclZkVDSiBcNPxbvN1bnnQvdQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf0DJVzB5AqYsMlYayKJE6s+65uFtlVtnQdPks+qta4=;
 b=YHel0CW7f+rmFu7bVdfnMbhBPftoArNUK/E55KP9uCn3f/0sHTnyZzFhhqE1Los/g9x8opwnMRcUztcVfY8wsOZ9GK7iSlLkUtT11DLPVmqtDbxUmL7gGFLqxifIJbNaDrOBsrjQ3WwsKs0gmdU+R/4CFbNhLYkw77VQivf6jxqyFA6xmkvhiNYxRWpk9o9qNOSVO6Ig7UbTmu6Hrjhfb/y/5BabqdQr/p/I6iE5y2it8d7e4HxlOlvwqoYynXXgLp4K0Hg1EeDmPHdVUlcC/Sn/KP7fqKkxYmaOUoYCbhmu2hRln6jBaQ+SZaaalrTuwvJbcPXZY/C+u4bs/CAsXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by GV1PR04MB9515.eurprd04.prod.outlook.com (2603:10a6:150:24::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 18:49:26 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:49:26 +0000
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
Subject: [PATCH v6 phy-next 24/28] power: supply: cpcap-charger: include missing <linux/property.h>
Date: Fri, 27 Mar 2026 20:47:02 +0200
Message-ID: <20260327184706.1600329-25-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::18) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|GV1PR04MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f860c3-1e8a-48b7-ec3a-08de8c3191d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|19092799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1tW1SKne4tWgFLbWCBwDl1EfQsja0/Zx72v3gzih1d8t1J2VGp+PgAbEkNO5+seSp/qQr4tU/fvGCva4XXs53VwCMowqddJsyubxgzG50oaqpGHGbAaRv3KJYGcHuDPSiHxQm/NfRRhgKIvtyc1UZtniunJlGEu5G4D9qKavpEJ72vq+Hs1yjZZm9hay/xKdE21mANlE63YYfXDePxneB26Rhp3r7TwoRbccb51pVfHHyMsIcCL0H4L1v64NLDkvtUyySt7xDUo8POSqvpp92e8bsX3mb6FMovXT4LOViD5+vKsZaTOfx5s+R9JSW4CvSzS+lXjeUNGB7lEJJsdiFNYYMdfbtkwKdHeSMJd7qZuD00QJrcWQHv82Vl4dDBcGbUAJD06KV2tKf+WW/iEIudzLA4t+EUMmo0MvGtIbgNE3YwRR0LOK569yW+vTk7RmgH69tUGvmoA5PSmxT1PIdDdR631wQ2ITU70csUxbwDnyvXGNCGsRjF50h1exg4n9v83N0si4SpY6Y+WVNJeq0pC6cT/FRkOOzqZlfFAfSfSWdEgPwt/SGJnRqH9U5xh/hcL03Sm2VvGKCk7uykNtalvoUmfkVBrTajW5RDdGIQ8ttFEz3UrmOQ7Ul4n6sJaEPDrB0ZNIc/B6oeOFQxuaogTkubAhFLExWlU9xCrLL5CRI3K9A5J5fdMdEbVzWdrkfVe1vODAzLnvT/ohHnimJdFhykZr+v6P5Wta3VAi7lc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?csAeiB7QUx867hy5Ma+4Mgnt7JCaSNSQb2UlSLvDhA/hHtx1JVoz4sf9v51a?=
 =?us-ascii?Q?tMKYyINSKdtJ7b+4wHYaS1nhO2zRHgZaCQsiEW/NyKy1Ad/W4nCq7hHUhflP?=
 =?us-ascii?Q?hHc+RB11S4KkZc5NCdPFM3Ig2tEV4oXgCmsE4ghiFbqkxHbexHtsCyw0bCks?=
 =?us-ascii?Q?L+flodOUpjiV21SYalVtKQbpPUuA4d1+D8cMK2UFsm9yeYK1l1aDqbmGxaAR?=
 =?us-ascii?Q?qVY5YYAhoCbEemzs73dFZ9C1Gcc7v/N9jS+CO89QsU1PCGD12v1Cn9hgdgwc?=
 =?us-ascii?Q?1QA4/lN465jh9pj3TipJfaC0KN4NbbOZn5JGQKHEHtFNFs5ZrZRim6jlvat7?=
 =?us-ascii?Q?xylSNZfl3xLkQAk714qakXnhPPsugtF8Mz6wn113knHHUu6IW9rCeGZbVD3I?=
 =?us-ascii?Q?NiBY3jFH2z+KvkSrJclPhuUJ+Z/TbvMpanl6OgKd3EbNN94ESJLMNDfFwg9P?=
 =?us-ascii?Q?TjMXBs1uOEW47rcYzjw5oHgUqhlMHAgYr6EArdnFqYOKbsWRlzAyBOZXv9rh?=
 =?us-ascii?Q?tnxKlwj9JbT+2fDee89rpR5wXice9ZhrQ2cubmnOZHzLp+gIFRrEhzKBTq3X?=
 =?us-ascii?Q?oiOE1+jIalMuYfh68KCfeWY1nSc6/VlIP1CTlwbKSK+nl0xX5HKRbIzch3el?=
 =?us-ascii?Q?jzJr4Zo04Ju6zKFI7spIdPgXLs7CEwEdVXNJuuX/eQajRP6Vku2Olqmge9Q0?=
 =?us-ascii?Q?NlLt7o3Me2X/qZo9WZqS0ibzJzfIHoxrD4LtNhHEOMqvCGH55PJ/LYQCoxWl?=
 =?us-ascii?Q?RxArvTnXTC8R0P/j88JrCeMn5BdA2UeAPJz4bvb0HQtAXWsnS9/XLIiZwTgL?=
 =?us-ascii?Q?nzxMzuSfL+w9wivpQVAGlBLW3R9foz/4JtiwGFLB0hTotrq9B0Pr2UtWFrjc?=
 =?us-ascii?Q?yIfa1L+wXQrAYVeiE+Ptjex2pXGHFlxcpznppUBFvpODMHpnzsOPdU3LutdJ?=
 =?us-ascii?Q?o8KwUz8/PnEiFZ854mcGJ2bNc0zSXJSCayjAb+Ag7VhADKqR09yGHsqk6Dvr?=
 =?us-ascii?Q?2GagBpE5wS+kDjdw5wHFWrmE0fpJ+p9SJuCVJ7XNISgnnn2Hux2JHPwbEqvP?=
 =?us-ascii?Q?A1WM0u2MAKMbvhJOS8Agkl3tdJ7MwA2HgM3Yll4KmfTFt8Ix9qWJIvgkM0NC?=
 =?us-ascii?Q?eWfNbUOmM7YZXM95nvbtnTQhcjVAKTXExmI/mm+2Gt3aDvcC943w+AYBzzLh?=
 =?us-ascii?Q?Vj4YZbJ6gPChvF/MeNBuM1GFRH1snluaOGimj3rnBXQGSEa7LxOny98jr5Dn?=
 =?us-ascii?Q?E/wjRNt6t5NYCgDjHmcRTA61tVwTiMAk3eD9ZIqlfza70ayMaJB2LfwEGYIt?=
 =?us-ascii?Q?0rJ7RnuTxYv4YXAieoqTTap1j8RN+eJQuLaelgJ6ts69ubvW2MKCnPP1Ihin?=
 =?us-ascii?Q?HUG3MFolxp+MSvt7EwW1y2eJKVLLjgwTy5yrzEbulyUKqMaOrqYBIfZxuqYF?=
 =?us-ascii?Q?wD8JGUC4wqdtt8NPEIMNsgoVnx3fQl5UGhw8YThndGrD/VAJdH2HFhOSM6Xe?=
 =?us-ascii?Q?+L3Yd4RtUHp0Wl74MuhcSxp5kaZVaZIqabq7jFdfCIHrwlErhOjvBtl88XCh?=
 =?us-ascii?Q?C3rnflmTFAIzMYps2CXgup26T50PIbsiRjSWCTPrZl64yEvWUKJoewZ2uvCg?=
 =?us-ascii?Q?UL/dbvQfHY85yxlJjGc0RIB0pj1OWEifsiPD0fmFK15MUxVsOXHDZvKrgeHt?=
 =?us-ascii?Q?TO5A0PXAAVdGNyHWDN4XtAb87j/VfCaDCAKqiQQhtO+lracgS/T+SZApk+ce?=
 =?us-ascii?Q?pyAyI+JP/5KFhYuMHrodfbnrLZwboVPduHWymSofQ9KdXH9fb9+F4iPF6AEi?=
X-MS-Exchange-AntiSpam-MessageData-1: VIWeHHeyi0mEJLf2s/o30HaveDg6Zcz3HCc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f860c3-1e8a-48b7-ec3a-08de8c3191d1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:49:26.2135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQwGI8FWQAJaegOWbbKBqvAn3XMLIFBQfneY2SqeoruZQwsdhXJMbrj3lKf8+84CC+uzlDyVG4w/7iDn8AP9Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9515
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7289-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,collabora.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09DBA349E34
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

v2->v6: none
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


