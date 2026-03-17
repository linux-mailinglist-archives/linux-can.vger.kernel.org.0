Return-Path: <linux-can+bounces-7114-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHjcAdTeuWnNOwIAu9opvQ
	(envelope-from <linux-can+bounces-7114-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:08:04 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F482B3A5A
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4167A3042002
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39B33FCB10;
	Tue, 17 Mar 2026 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I7VyyXJ1"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB333F9F45;
	Tue, 17 Mar 2026 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788757; cv=fail; b=sSpbPC4hw4rIf3y72DwGg/DXyaTyrUfsK0x0rDTN+F5Y2fHfTG6QrD2blbDyf6VNT/fst3EEM3gsKaSq++A5d5h9W01MwZHiUJIjmTVJS4yUtCA4wvdv9jJAAXkkEgF5aOEXGtWag4qhs4u3oMEisfDmpwENsCkYWCqoBkRXB/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788757; c=relaxed/simple;
	bh=CLJLtkTalOdcuLibmzwItOwKYYnUF0iPRqsXR36jW3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BJ7y6udxMirI73lP3yWsLGpm+wFEzmUxv7QRKAh3w1qZpSs8UQ7TX64mB9ih6a9GO88LULhjldHpljAf226iGzQX6D7YV2Eui2100YDGCjJ29imJk+yHVEpNEKkpuC/ycegPtENs5L97KQ+pr/1YfTtcNJHUROKvBN3GAjxR2ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I7VyyXJ1; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5BOd33wTqQNeofsgXhwoYjSXs4YkLHM+k5ClPT+6qcTdHk0/3Z5/aLhNZ4IXl+RzeaRAtx2LhYTH0Gv7VnKPdh8Jpg1ZW4RqkjXMcnjbfAotZP45tqbgzf90zatI3u0D1Ij08eZZoxi6ITMe12WvfCWJ8DhlGYokq0LCWZk0ybGnd1s8MbWMQV+MgTYpg2QScNFKORDougrIKbOCl+emsNm8RJecF3DzehB5tQOEHHaGlTTbA/m4rpipQYnTDwztTU1Ge0cz/cGA2cuZkyYEDSJ8j7HnBoO7hP7FJMlhP8KRzirN51cIpk155yZmRnoELyxVGYUABjqBEXcPV35ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdhwfomDBbpBbvkKgtO4/5g64xUTsiQlbUxGKnHftRw=;
 b=VviO1ojtH0572Nm5nN85XqyK3q832YIT6xmPoizh2BouLa4L321wytwFUGN/QOtQDOcV/2mCCI2Z8doZa2R8nOfnUfmJvnw+HCkG5bkVnjboyRG6xtlTqwmhpY2a0J/HCnroXjsGvPrSPGiG75AUtCMFpR50kvX7ph0fVloSj3vY02iBVC/q7zX+gozQTbU/DfemsH8CKVZoWm21UfhqDnBrxNIdRI/hOaSyG96yp/I1ThE+gOO9itTuhStuRR8+ZN7DOJhjcNssfu8fpS9ulkhXgwHMen+Q26jOP//JGDyHOi8w937PmrPJ1rUOQ/ALk8ipicj7CHijLmRx1McUOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdhwfomDBbpBbvkKgtO4/5g64xUTsiQlbUxGKnHftRw=;
 b=I7VyyXJ1iA8elW5oF5qYPTX7qYC8kLQMJeVNSk236VA4JDJHW9roVEhgjOyPQGp+qv+G7VVYNjHnoNdInPeATquib1iRS8Wz/Gv2JPH3QdE6TpRiqIXOb6FFfC9Jxd15cGYp3uJRPDoxJZR469KJtTDKIQZZaf+sKwfnK6BDFUJJMBXOVaOJUOfYO4bPA8bPG4rd3HEFQv/uv3155mQoDhq6nk2D2nSYzKNFDbzaD/K2kdOh6fZuKClJ+3BwENvjGDlD5P6fxbdYpoLy1ITEEKUALAs3NstF/QJ2nqAOctsRSF9x6AqIcaxfEaxmniINiW2erD1YVIc4wLUP3rYFeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBBPR04MB7643.eurprd04.prod.outlook.com (2603:10a6:10:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 23:05:37 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:37 +0000
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
	UNGLinuxDriver@microchip.com
Subject: [PATCH v4 phy-next 13/24] phy: make phy_get_mode(), phy_(get|set)_bus_width() NULL tolerant
Date: Wed, 18 Mar 2026 01:04:49 +0200
Message-ID: <20260317230500.2056077-14-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P194CA0034.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::23) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBBPR04MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: d08dc1bf-cac0-4c47-0ecb-08de8479b3b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	upbXYqqEfma0IjAxk6w51ig2lVnn5d+enJM5zuw+fzhTb2/TmbJ4z13UoPUfbqaqHGyVYARP4ICH7gRvLOH9WyrgOaom7pnnrjo4F5c9NMuDyeq0fnz0RDzxKvxBuNY6HO9JqedxBhzU3VXva/kDxFmqJ2F2YhqsZ5R0m9GiB7c+ZWdy9WmWdSVvWwTzQc5QC1Uk4h6FKorjSaKbHxkrbmwtUwruQG042hYGgZIAhNox+E/JgM/uHJJp38aFbhg3aWFmTNCY047hSS6wEk9Rv4Ih68jnv3bu9onFbiJZfPyhomJXhd45h4dJCw6sEMOiJoNFypQ+wz8FZ6osIRlkNhw+6chsdmKRGMg1oZjHvHzUSR7hlxb079bpQgRnj1Exb80z9tYAwknY7HHPaxENrknxTi6yLUf4o/FoR6IKRjThTtlS4icodUjOoVhAWiP+rQ2CybCnyN2unur2Xt0JMlFOum7T9HAIo8vdx8KOAPtSnI7xCr8yeQj0CzNLZJk26oCDfiBJNCvu3a8Ht/xpJsp5OwzUmCYZ0mFkts52ykXAK1Kqgyd0OMvO9isBptGknLfdg6Ai9RUbGkneZy3Y7zpMhddEGTUENmiKWLh3t31KhYJlN+ArGma6sc0438Ui6s7IUl5fe4jpyEMRrHeRBAdVvm2R5K4kQjY8od/OIyIXO7eDHWcW4rNp1C0N5GKj0UeKqEdJd7G6xyiwJ89am0NPlvtxrkR0cPeI4ra0F1Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qds+YB1bAXGSYk3oqt1+lglp7WUktARP7482ZWhljyB9zxHb+Y25vbRyuqGM?=
 =?us-ascii?Q?noUteJxw0KDwdZq+v+xmH0jul2AD08lU669pPb3smt8uxvw4v8mQosXSNE+t?=
 =?us-ascii?Q?i3L+2UMouItdaBOyhX+wM1XsTiEPR3gF6C1FrzTg6yEbPXmY7dER4y6juIXF?=
 =?us-ascii?Q?aITXoH2OoYf/79wlgPEQLAWoRcnfObgDQ2lP7OCLnV+0hjesVdN4CNTegRUL?=
 =?us-ascii?Q?QRLIpiU04L0xYWyi5pFruifRY4OJ/R1VA0waZX3xMD1toRzlwrxUWgRJM81p?=
 =?us-ascii?Q?Ux9VKwrUwbPC5vV7qDs9z+qAmnTE/yI012u/5p1yT07SzRPr2uesCJVsUdnY?=
 =?us-ascii?Q?GBSawSHIKNJKTIuQ6NK41F2BE4nManX4ctRP3HSuzr90GvUo3hXk1Lbye85N?=
 =?us-ascii?Q?M/QVzzjyWCSCmGOu8AjakHAiIql1+En+echo+ov52kggIg6J2msPwDHc4fLB?=
 =?us-ascii?Q?bodcwkgE0DmGgwfoqO0udtBnTzuUf1jdYs2eF7iqZLNxNOdVss7GRdBtn59f?=
 =?us-ascii?Q?DrJEs45XAocoU5RtRUj1orKopvk1dcX/9nBObCHB05Hz+gypB4991eA9fw5q?=
 =?us-ascii?Q?27w0IP86UtgIdR5OkMEjNYuXCYHN1Sd14Pfdw7HrxSsDgzK+NkekakjzKFaL?=
 =?us-ascii?Q?pbTox1f009t9vAyirLKZC02cD2o9ztbuXPuEsEJjWSnsoRP/IXiCPXpIqlwP?=
 =?us-ascii?Q?td0ocoMSl6pcK5izyAspoK4367aUU1MT8Az+dIR7sqVj5hgOcksNpeDsJEUb?=
 =?us-ascii?Q?uaRDm/ymkaU1qJM8gKfKu3B2Be0Mx1SZJdzLjMt7tSlRFz64F/Af9UscvqPy?=
 =?us-ascii?Q?xnDjsU4rCHIpuXYiy2MPBQu/9IRmNzwsyVTmpC11ilMe/PhomXoxp6aIykqs?=
 =?us-ascii?Q?N/cHveQezQF8yzGx+26zY0MhagjTHRCGZexZIoX+7urSsB4azcKtmHLHmoYy?=
 =?us-ascii?Q?cq3wvYlGyxTUmktSG9kJKu3esVt9LAiRORKER1oxljSfh09KVBwxPhuew/hf?=
 =?us-ascii?Q?bHDlO6nJ0nFUSW4AyXSRTCYHzmPUS63QQBB8r+NsOMr6jHCMm4U/igeeNKmz?=
 =?us-ascii?Q?yctsR7k9ztjHM5xcsplS9IIBCIvh6PRKk/4cQteBWYm6RK8JwSSGytKR3Anw?=
 =?us-ascii?Q?OeRlHy8Z8RTZkA2CdnbWujeyUpn5XFxNkPDZ0YPmIgXu19djA3So1iNq0qQp?=
 =?us-ascii?Q?qOhnAWkTpj8n7LsbI2jwdCuy1iI1vqLgtPqJdGPVbzbweCMukeK8l7YvLPoC?=
 =?us-ascii?Q?faHusAk3IRwajkZqm/0BrzwEjoegLi0TiJXeewRj/IDDKFoj+mJ1H0o3X9w8?=
 =?us-ascii?Q?qZsmDAxTpFGjJ5YmwWD98HhlwVMcGhMzLut1po160xvLCZYlHycSYrlyPfnn?=
 =?us-ascii?Q?R8qrq7N9ten8k5Ur/h9swrl1xYAM1qJu8Bg8OK/u7KWyJcQaZ/lXhtLP1BUq?=
 =?us-ascii?Q?ZZP8NsOfaftvPCqIkQNlMZN5DAQCM3BhHulToF5m7306mtuMUud6CQHNIpoD?=
 =?us-ascii?Q?CnrLGzgOuPH8/G4B9GZSwbqwBpvL7EFh4dKOk+YhIQJt4bmT1BE0FFtPAwJM?=
 =?us-ascii?Q?4att9JHFHyh2lryl0g4uDBvDfxf8w2o/4qRqVz/eql2f5In60/jS1d2M18Nm?=
 =?us-ascii?Q?/DUsqgFPvLvsipTFeqpMpwa9u2Q2TQl41MfD7UspMxryBwFhqcNdRTr4sPxd?=
 =?us-ascii?Q?1rxyTc3LVoe0oK0pYyrLraUiizKMBiq6UhBgpY+1yDlBtg8Y3G9Oja/2V6z/?=
 =?us-ascii?Q?cZjNTkVpY8DBG/x+Ia52y4FuElEaKuxnY+p9q/qrZhuwGboTG9p5iUnZTSZE?=
X-MS-Exchange-AntiSpam-MessageData-1: vTjlYohPXxrIEgrLkC2c+lWnIUsWoeozNrg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08dc1bf-cac0-4c47-0ecb-08de8479b3b3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:37.5394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YG1EH+JxCWVdsAcCoB454yF6o8FQi436yt7mN4d2vgid4Rht7jRA/CTFsf2vx7w5RkKDmmKtczzrQPNV4i+auQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7643
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
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7114-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: A8F482B3A5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PHY API has an optional "get" which returns NULL, so it needs to
accept that NULL coming back in.

Most PHY functions do this, only the formerly static inline attribute
dereferences did not.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v4: none
v1->v2: patch is new
---
 drivers/phy/phy-core.c  | 9 ++++++++-
 include/linux/phy/phy.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index a1aff00fba7c..0d0be494cfd7 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -624,19 +624,26 @@ EXPORT_SYMBOL_GPL(phy_validate);
 
 enum phy_mode phy_get_mode(struct phy *phy)
 {
+	if (!phy)
+		return PHY_MODE_INVALID;
+
 	return phy->attrs.mode;
 }
 EXPORT_SYMBOL_GPL(phy_get_mode);
 
 int phy_get_bus_width(struct phy *phy)
 {
+	if (!phy)
+		return 0;
+
 	return phy->attrs.bus_width;
 }
 EXPORT_SYMBOL_GPL(phy_get_bus_width);
 
 void phy_set_bus_width(struct phy *phy, int bus_width)
 {
-	phy->attrs.bus_width = bus_width;
+	if (phy)
+		phy->attrs.bus_width = bus_width;
 }
 EXPORT_SYMBOL_GPL(phy_set_bus_width);
 
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index f208edd25afe..a7e2432ca1ae 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -248,6 +248,8 @@ static inline int phy_notify_state(struct phy *phy, union phy_notify state)
 
 static inline int phy_get_bus_width(struct phy *phy)
 {
+	if (!phy)
+		return 0;
 	return -ENOSYS;
 }
 
-- 
2.43.0


