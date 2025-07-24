Return-Path: <linux-can+bounces-4090-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BA2B101D3
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D56E581C81
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 07:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DC226D4D9;
	Thu, 24 Jul 2025 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="YVJO9DrC"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2100.outbound.protection.outlook.com [40.107.21.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C205025C6F1;
	Thu, 24 Jul 2025 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342249; cv=fail; b=i3zd0ScIe6LFVEYcPvfimZMGcIOlDZ/SieHr40gZ87Zf+A0Rl901jWvlj3MAD7gZACyhrEtbxWe3d6KceoW0m+A5irPRJQsF8RrcZMsnz0fR5oNSPeWBFpW/11EHt3MHqrz3rYH5VOvB383LjSylE+IDJ2+Mp25EPxxdPwLhG40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342249; c=relaxed/simple;
	bh=a038doCfzkGLsxfsFMJbM/pzZ6xe62A8F9qSK842sz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g9aF/p8YZlgwbMbcg0PVuli4BimwG83PCQNsAU1o9uWz9AsUfUC1/ch6sxprYI6qUOR7a2/oGw03Ly+3r6ek15a2v0pA0mDJtKWAIvSZ7/idDsL+1kQooXQifCohlP+3ZGVYa/imFSdhjMt3Hnn9KThajP8Y2O3gTVfkkYLBqeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=YVJO9DrC; arc=fail smtp.client-ip=40.107.21.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qfw0m4wk9iVDGAZYG5GiFDKID/ZwEEBtvn+H/bN1Chq/dxo5XP5qy8oZqOGUrqVe0vQBUPATbL/TDWEDHE43ElsqXKWsOTvKwfsJg2kEaR0puGa52mWcNiRSUc6yEo3Sfys5QrjPBeRBPL+v4qdV3qdFJklBFgBOjQ7p1hG3Ve7/sV12nTA5pQWc2Q1hQ0dPHUGpQJLZ578n9zQPSxW+ySds8pCw7sjj8GOR3wALXDzKbQjdBJgNpbLqcGsaDtux/ipACJxQEcZfVUZS/6NuWkJQ2+EpfUAdBMka9y31NRAUJo5stEmIAaj2R4+X1ZNG5/WPbCwixOJnCysZ24Aulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3YUByUcz6uR4BT8awM6reP2nwhFn3fYXi6Q4gC+Qj4=;
 b=TAk/VIj6piS+wS0eKMz92hjPfz19+m7+Lu11oqylwMuYtRjinF/MgOLsvobSHSibJJv2f8kReqGfrfiEKNB9pxcVlSoW1KCSNifEEPJ3G4f9cMa8y1T02eQoV0HWy/kWyJtxZtH34Q1TdyOL0nC8YWDh1FY+meS6fmaspOqQOJgoJ3CfGQq3Hvky625Gla1n9e6Zz6RBwfBZisXoqEt84cQcavVU4wqYvUy01bqLbip/VYPJCd3mwT4OaznHhdtBKWk1yrahZ4ws8JJye95sA1jGbYnzllm9seJzcaloLEMXPGEyNUsdM6eAXQH4L7uXae73rZjSBEOsHJaWX7k7Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3YUByUcz6uR4BT8awM6reP2nwhFn3fYXi6Q4gC+Qj4=;
 b=YVJO9DrCr0unpi3QKX+mzFVSUtSqtu6FClH4vicLQrOCuxd/yixWB06fwkcZRK3mt2h5Z9x8hsgXqp80hpfoyFoSLw4GKt3T8nq1mI/YzwGYqXHqY+5jXbYHagjw99mv5jIaM3AvMXSooZ7HaL/UZQXyXgWKWhphQzlc1AV04PQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB2657.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:32d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 07:30:35 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 07:30:35 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v3 02/10] can: kvaser_pciefd: Add support for ethtool set_phys_id()
Date: Thu, 24 Jul 2025 09:30:13 +0200
Message-ID: <20250724073021.8-3-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724073021.8-1-extja@kvaser.com>
References: <20250724073021.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0090.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::8)
 To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM8P193MB2657:EE_
X-MS-Office365-Filtering-Correlation-Id: ede76bc5-cb36-4e4c-dd5a-08ddca83faa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xZA8zK1O5GZn/1hyPGqj660rPIhBXjbmJHcVM7QWYUh6xa5iMbo+IM+wX600?=
 =?us-ascii?Q?e0kLGlygNLeoBZBvIjDFpi4zMLHHeuwAyeEETWuDrXOWtZog2YqoRt1qjlFe?=
 =?us-ascii?Q?bad1t9HDKNJ4xUYxiG4Bys5KxTE8ifDQMQP4Y6UtUKqk3WVbWxJRGIm0zaid?=
 =?us-ascii?Q?4L+saEjSJR5r/e1R6tPAd3dk11yAbU9sfZtVypPL3tOvBQocyQtBVc+84znR?=
 =?us-ascii?Q?aXBxM2NLUM5aCztJ1bkDUIcRoi6lAUVOvN5yk2CgfhDEA94EJ8xZ2Ck4CKuL?=
 =?us-ascii?Q?s2cl86IVCCcwCcJqg/dkoHq9hVzvCz0L3xvP6dqQUf2ytjCTwWRhCmkIs7E+?=
 =?us-ascii?Q?9QNDnDI+KCdKIo+ji9N7Gh7hfyIGw7sczvSW5B1MBLnYI2K6pYjj0hLZhJCF?=
 =?us-ascii?Q?0NOfKf6sT8Rp8IfsALEa/X4YdWAQamB9fKf06CCNbnLvd6IUszZEq/5Qcjs8?=
 =?us-ascii?Q?n3hy7N40fQFLF+O7ZDg05iirOTGNZObsoSPnTqK/hEsWHpHj+kUwaEKg4U1X?=
 =?us-ascii?Q?hFko2eDU2KrlWS0FwM06c057LfcKYy9gzmJoeW83VZKvPTwURfQzqc4f1++s?=
 =?us-ascii?Q?NrBkxTwiLy9MfLN2fPQUS9/I3I/r1ar2L3vj9yp2sDidOX+H5/vBPfm5O9IH?=
 =?us-ascii?Q?bmO+nRrur3L7UJX2EhfJOl7G/O7Bky7dnNRkhGwVZo6un+f93GcM6GYNJ+7E?=
 =?us-ascii?Q?jENWCpG04Gw9Hqdka5l1KP3PHjJ3sWOQfXuEufFsX6e4kCLP0tZmTwh10/ez?=
 =?us-ascii?Q?a5XYZlOp9ukExOHk6II3/YR4SD2bE7x/HGgojAV5nYtPrzJKKQQXVuFt7ZvW?=
 =?us-ascii?Q?S4oBRTTZDcM48iNJk4J2MT7kyqnMm+AN11yAF6R6oTr/LWTvS22ALMTSAnEx?=
 =?us-ascii?Q?LtdW6/Asxx9vpekhlkI0dpFfpK8JsdRwHiwlyZvMm2aBawAeZK0AVIKoez6/?=
 =?us-ascii?Q?rmzwIghOLdcHXLnGEcI3MvAGwcgq7z3Rc+L8vk+tWZ4MhOnM0p4fcUrLrG+T?=
 =?us-ascii?Q?CfK1nWD9lUJi2Zmmj4SyBVbimvPh6ujrUJgnC3LcyTTcTKNq68lwH+cQZJJB?=
 =?us-ascii?Q?Q+CfolW30gnLIgYRrZ41wxwnagIIaOTUb258nNm+HgeBb1CAWgCaYbi3MK7+?=
 =?us-ascii?Q?Dh/09eoDD6qzPJrucxLJOYQmJ646QfyLUsU20Lbo0+BzA9ID5JKvWSJwG6X3?=
 =?us-ascii?Q?k3DaYW/x3flrRk0TXA4rkxZ8OICdO+YK9+MqlY2Z/F26NzY5+qjHCIdzWfnE?=
 =?us-ascii?Q?uDjCOWT1xJqYU3I9aEHS802Fz50HIU+ZQV7s4uYjjcQ0JUapT4jzAUUonfnR?=
 =?us-ascii?Q?1FefAYD/cNy1p0+gOltVaqn2hflVZqmIDZWt/hn4U9WTMZQN7Ne9VVzNq6RU?=
 =?us-ascii?Q?x+s2k9M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dFove9tzF5DUMdyDyZ+N0tTa4qKV50Nbktn1CTrHAKmCgf/y0A2Z8YCO5NwB?=
 =?us-ascii?Q?BjJykkzFuKtZIeNKD4R+riZQlMC4Rm8p84X3YAF0ApwLvV99JgviV5GQf4AJ?=
 =?us-ascii?Q?9LZA5JXcbyXeLCSFdJv/xP7LxCRO2UjuLIT551fJ0EHHDyaquCdR5Y1yAvRO?=
 =?us-ascii?Q?U0X8emauYfx4bX6Ctkyreqb2gZ4PVZGQnpStNRnNAe3qkFIk8aulBKA+Glli?=
 =?us-ascii?Q?sibl/JRbCG5OamlcGW/oA1oo7o1X1hdQP/m5BzxoZUvVqMQpWIGREjVqM2h1?=
 =?us-ascii?Q?fxPNxJOsGzZSbVr6MVwukmkx1A8sqjFv2lyGc0eliVvhqk1C2+oguTipS7fa?=
 =?us-ascii?Q?VEH2kEgS1UnsDn3JI+uppGTs5yji1zO85WopRKisaSlKpmzO7rNA5k4uqAZO?=
 =?us-ascii?Q?H5SLiWoiZWhvPX/HhE1CzqM0mXOPaqPoZWPY4KFul3pqhdX3bWA43d/p8CHD?=
 =?us-ascii?Q?xO9wfPJB+nBg/CtNuiuamlnaIP+ptbgm+bBN9kvsnJ54bnUxRhbDE3+PGnCl?=
 =?us-ascii?Q?j/3PcmCHWF99c6bFRO8g2HymX1hlDSKMUSjxIW4hfEhuvpk8xlpgsSEa1SSx?=
 =?us-ascii?Q?+2E4OOuH92M6hyhvVPSK2uAkALZSdXtdWP4YvRowB+vQvgs0yFX+MppKIvcJ?=
 =?us-ascii?Q?30oTKI4uea9V2TqvptXWj80fa7ZJOxdp062Cq7t8zecXcfDQZeVjxN4Hj0h3?=
 =?us-ascii?Q?CrALk1/BKq5ezt9dG8ETxNpf/+q/sZH1sbt2svR+4DNVQQxcHEnB6szRRFT6?=
 =?us-ascii?Q?M/x/Cf0bUAeG5zK5miyF8UcSZwA+dU0BJdoZ9N8jCSgzktbQF6+XdPAMzLr0?=
 =?us-ascii?Q?9PmqT1zPEWfBYfxj14+zTh3Sgf5J/O8ZyPYxE7c+u7BFk2Yr0yOw1GarhJv3?=
 =?us-ascii?Q?5YC3gf2FO81xTj//KuN8pdLGkQ45FgA1YvxEOUaf4+mh1EhP67mmOv/dr0SF?=
 =?us-ascii?Q?mLlMxl6RzMkZcRNmlNovm89weEUMg9oB/DtHO08GG7bZvDS29gVzWuKvIgHN?=
 =?us-ascii?Q?5ilsLSPj66JJBcZfjk0Q+TOaTs9YQOhHPXcrr41vWfwUFc6rDvpBlh92I1QC?=
 =?us-ascii?Q?CyZPXe1QH7K48zcDlWoQmzfDHWZiPFHfT6tYvgxvtjkJmq7H0RrR2m38V1lM?=
 =?us-ascii?Q?l5Ww28GhP7yzj0eC4AYTaH0B8fy9ZIavLVEcTFMVIjyrg/iUWEUFWidR1jx5?=
 =?us-ascii?Q?aypiCK9mRf7rcYwXXYr0rNS72ROzw0Howi0Q081+WCp1b/uLb/H1r+/7OgDU?=
 =?us-ascii?Q?fPkQog5q0dtrYjlzDAx1J5L2JTeuaVaOeQB1atwjTDmJSejiPXzcM80JVHhD?=
 =?us-ascii?Q?qwb5bIlyqvNGRio8N8gXOoIOR8aBZXDTvS1bIOw4vPATktoNftFAGXRRmGrn?=
 =?us-ascii?Q?RxlCzXlr5hNPIBG8joBl9g85Z1UEYMQmry7z6vsjWt45SwUw/ay2chfMzb7O?=
 =?us-ascii?Q?5c0N40pigLDY7QGm8kly1Egu9+cK81k5tK/pu4Kt44y28sQpG8wqPuaEHABC?=
 =?us-ascii?Q?EgEZXFt6izDD5+kcO06ZUgPf8bPPQBN+5g+kjHEsLZqyOco78MMXanWCy9ki?=
 =?us-ascii?Q?UxlBUcx3HiRQHpOgNzOtKqtcqCR2Wnsh6gjBB4ZXBBUU/2RfpjcNTYMtLZGj?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede76bc5-cb36-4e4c-dd5a-08ddca83faa0
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:30:35.3382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/xJx52FTzIq8yMeQz2ACJX13qTf1+8HssaIJUWsMIqra3NBqIEnRqBRGLDn1Fn6wxHEPpMX+sNnOG6aQC0Olupj3Wh3dIjQ9Ey5Dos2tsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB2657

Add support for ethtool set_phys_id(), to physically locate devices by
flashing a LED on the device.

Reviewed-by: Axel Forsman <axfo@kvaser.com>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - Return inside the switch-case. Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#md10566c624e75c59ec735fed16d5ec4cbdb38430

 drivers/net/can/kvaser_pciefd.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index c8f530ef416e..ed1ea8a9a6d2 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -968,8 +968,32 @@ static const struct net_device_ops kvaser_pciefd_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static int kvaser_pciefd_set_phys_id(struct net_device *netdev,
+				     enum ethtool_phys_id_state state)
+{
+	struct kvaser_pciefd_can *can = netdev_priv(netdev);
+
+	switch (state) {
+	case ETHTOOL_ID_ACTIVE:
+		return 3; /* 3 On/Off cycles per second */
+
+	case ETHTOOL_ID_ON:
+		kvaser_pciefd_set_led(can, true);
+		return 0;
+
+	case ETHTOOL_ID_OFF:
+	case ETHTOOL_ID_INACTIVE:
+		kvaser_pciefd_set_led(can, false);
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct ethtool_ops kvaser_pciefd_ethtool_ops = {
 	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
+	.set_phys_id = kvaser_pciefd_set_phys_id,
 };
 
 static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
-- 
2.49.0


