Return-Path: <linux-can+bounces-4080-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D07AEB100D2
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 08:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C619638A6
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 06:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034ED23278D;
	Thu, 24 Jul 2025 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="kYTblNso"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2139.outbound.protection.outlook.com [40.107.22.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5823026B;
	Thu, 24 Jul 2025 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339054; cv=fail; b=t3QRRY7+yZE/zkvMloWYlCO05jvXSdE/F2x+XjIxj2HWkQKVomT9sqyxekT6QxsKgRGnDwrlj/u8DcgQadw/lZ4DI+oaPfG180W+lfqN0IkCj4QEGoqv8egoDi/EEbY7Ta37TGdE/gwWfJm9gYo4RRvOj6p6ysoHew8GcnHhCQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339054; c=relaxed/simple;
	bh=npvWIsp1AfwxLiboKKgtkOgX/VYkOC0Wpz04wQxMdLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QqJU5Ve+DXBt+4rKD71ImSuojOANOqdSKu52+KFoZjETJPu6mHz8ixswPjDKuwL3bDC8+NGIN802LMvdJyvfe9ugVBHsEm2X/u6nAJHAIaVjKA1LNrkM+OKFm/vAd5rmA6v6DPUWcNIo4whD18esWjSI7A19FGiTx8sdMf5ZzKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=kYTblNso; arc=fail smtp.client-ip=40.107.22.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDcLD8cHWYQDRAK4c8OcBar1uZpbRLv6mYmCGlIPfsIXTTae1cp2aj5Po1B5hzYkK6aJVsG9ySjFFxDoVBpNHBkwh8yAsmKotaKSFqxSIXW7VDb77RMvUFcB1Ccu9HC2i4F57vyAhSzydZ7Un1uwWMDDVifBqDrnGS8BTm2FazrTmSkfG3k90skGff/8lkP9+KClveAVowkOjZENKt3yCd5fUXHqfOEVcqFxG3ozunsTwkLaqyHiOg5HN7JlwQZT6W9MTnZW2F5N225qLO0WFZXugMo9ygxAMtcaa+H7r56EogWC7uPPH8ddUWyi7Tyb2/jCR7EfWwOGZo33tXDg8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XF8yfHKG4CPbv2ZFUwwtnhDaOP/Otys8Hzt6fevSm0=;
 b=NpOjy+ajiN1Kyf/1EvrCrh1v32PVOXNJDuTfJnkvbsqxP4gFUNcnRmPgsvADJW1raeJW6gQWhMan1wRtGbNIvqk6ryBQI+jbX6O6IAyVgoZKo7/lSDPK2E6xm3QbLDGKFUCgJKG9M1co9cAegLpNHXwD4miWc13e2tHMsKczFCRLBIoWREgQBLAxWBx6VVjoZYHsMhr5ZkTn+QLat0kiZCfVb27KwalEbuFsTtiMtUJ8WRXEA7oKl6NVTPUbZA/CH/pkeKbm76ovCepJoVt9cXO2EurJ3z9iGR1f5f2vqamZvBh24iZHsHtQauq0wu1Db6jxELVWv4DIOsUB7MiNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XF8yfHKG4CPbv2ZFUwwtnhDaOP/Otys8Hzt6fevSm0=;
 b=kYTblNsobfvND6MQW0LbrIcIeWi3g3NEqk4xLPBzROnrif+SAhF5l0x11fvETdBePSsT9+K9aoUdIIRmg268YoQNOS4tWX1iVGQsgTh20cFwMaQ1sBLuF0zouR9EaJxNYtS7tNkxUBqh51cYtH2f/cDkIyQQxev8hsDxzmo643o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM0P193MB0562.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:163::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 06:37:21 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 06:37:21 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 10/10] Documentation: devlink: add devlink documentation for the kvaser_pciefd driver
Date: Thu, 24 Jul 2025 08:36:51 +0200
Message-ID: <20250724063651.8-11-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724063651.8-1-extja@kvaser.com>
References: <20250724063651.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0034.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::15) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM0P193MB0562:EE_
X-MS-Office365-Filtering-Correlation-Id: c39a9859-4604-4007-ec2d-08ddca7c8ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?30/RiP9naRv748tNfNJKumxqjpHwRHehbPxrKgyOWcRkW72Rgk2pl0/PnOwq?=
 =?us-ascii?Q?pL8RTKDRAodrG1bQKjPBq9DJTN83OS8S3D4syImG5t5QtzT2nkYD/wa+d/PO?=
 =?us-ascii?Q?iPXOc3nTDUKcKG9RdYoKg3929b2zmQYgSPqm5o41PFx6qy1QqOepf5JU/GUX?=
 =?us-ascii?Q?x43JjEfJ+5/t4gsBMUVHpLsjxEaYt+EbYXdp+laOu1j0uCvTcdMHgwhFf/+F?=
 =?us-ascii?Q?qnQLUL8JdGaaXzKEKYpjiWwfF1EbTuu+ra9JJDpyqfjokqyZU1VIKr92jmDZ?=
 =?us-ascii?Q?EFaO7YuBXWyJmyzD1/1un486M1VkLesnMzmMxX/iP56ueyDcYywbY3LBqzh+?=
 =?us-ascii?Q?X/jTPeRPgBBX4NaAE2TvTWwV1Zm8b+ppkYj1geo82JK71pp1bggGbADpwdEn?=
 =?us-ascii?Q?nBVDCHzKOXC7ULs2x8CBAPB9YXRf0/tnnMh1Ruwg/z1Kph7rvS5dCbV32Ddo?=
 =?us-ascii?Q?y3Ci6Qc6TuLs+FcXPyV+nSD2py7GR5DNFdm/n4TY5cGx9RkYdyCExqKp8qkI?=
 =?us-ascii?Q?taNANfnH1l0/xdPLWvu5KnG9f08L0us5ZI6enBTbriVI+BDXGSSG75c957rd?=
 =?us-ascii?Q?eMhClqHRsBivwxUexTy69Q1ijwsmCCZofZFsxwMKpAGrqJYduaTQnmv27ht+?=
 =?us-ascii?Q?tQx9xcC5vexZUiz4nVCfwOyj9qruAnuibvw66cyOh8u4Xj0LM7nzArYHznQG?=
 =?us-ascii?Q?1sxcPFevqjqxM9TfFACH07gJ8lxkk3wi4awm4QJekfkOjcH372Ihj16oyXvj?=
 =?us-ascii?Q?58KTOrafVNyhCzMM//tm+id2X03W706kJ+B3+H6R/IOuZqbqYTJ3eE49hmsJ?=
 =?us-ascii?Q?2OaQaq5hCGjWpSomFy8ka6tNWS78SMCp8MuL0bWW5Kkithw9X334hSEOHBGc?=
 =?us-ascii?Q?KTY826Xv/g8HE371T8zoYtGQnWuW2VHRcBwHx9/ICeZfkfk+bi4m6VwBht4X?=
 =?us-ascii?Q?cmtiN8NhEiHYL4YL0KkcnpCi9z/hxlKlnisLIEka7KE5pUtZbC+wAKZQ1XAw?=
 =?us-ascii?Q?bKqyR3zhH6gw+xxlGPeAoSnO5qxhqRHM+BxQvVZSfEIxA5F7CKConWt53xPY?=
 =?us-ascii?Q?xqQ5bX3hJ08bPG7Bsec4ZvL8yzEFSpjoWluDRylrbMB5WOkFTxzW1LKHfpzU?=
 =?us-ascii?Q?0zNpfSXjruJ5KstdV4dAZ9Y+R6b32oC4RpkREQTyg/d/jWI1VF97ZEUuqeyE?=
 =?us-ascii?Q?mkKrvxhJlb77oLgcvg/SWzDAjDIkOmWmI0qa+dVnUMDnCHtNQXF3LVxpFIg8?=
 =?us-ascii?Q?C1/dSpRrjI4vUO1kRVMe8ZZP0kQ94eOgDEcBkwKbTWl/wl3sdAbwM9TJbChO?=
 =?us-ascii?Q?rJxWPI3AyU42bbKsVlHaOp2JCwE94J1MHgSOX+w2ZV5ZGas8QOfsxYXgoL+p?=
 =?us-ascii?Q?VqD7y3v2dS1MA/bYfHabdlncAc3joVb1p1WS6JUWLE4t+3COSF4XCp3pXG2E?=
 =?us-ascii?Q?ypaiyTYhELU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g2iilb5niQ4pexettUL7H+f7N7yjBswAlSDubAEjJhEMZ+l3qyJmcU67uK+J?=
 =?us-ascii?Q?zAvcd5TRxktMLFQcMKC5z1W3aNc3/iVC+Lbu/aqB/y+y9xEkaQ/TnW2LfM36?=
 =?us-ascii?Q?U+fwLQHjBhTCmAOKMmGp+doKmXKtQKwLTFgwJJbiRPX4UpDgKIxSksaCpLPC?=
 =?us-ascii?Q?XjP7s1yjrAjqoW9JHO3TEKLT3MxuvBBDQV/QIuHfHLGHuWSh1WIIRVWn5YPo?=
 =?us-ascii?Q?swGTwy0RmPNSyEkb6nILX0PGn2mCzQ58FiM7XVd6Ge38NmWjZjZAOHr2Ekn4?=
 =?us-ascii?Q?Yuev5Mi9u0fmTlvPOqpirrA6djdn6O7X8ezVZULb0bpsJVYmrc0wG556Cxie?=
 =?us-ascii?Q?CmaCxG194Zps1qUhEfVnM/Bm4eEWwqPzDwIoYEbON754gBgjU+2qtSN1V3qt?=
 =?us-ascii?Q?MGWFX9Tb5esRYLGswWusi3hSaZyWVT860d5VDlhA9zD+SdNUfKLrq881/iMx?=
 =?us-ascii?Q?3i953Fmk/vo8PadfjAlPh9CwFF69MRy9cyCsb4fxNjhgFZmZjZAMfw4JdXas?=
 =?us-ascii?Q?xzWfZ16pZsPKPtrLprGyMMFYjz8zDsE0fcdH8ZgMkBTzSAB/2rhH5AjK0zJy?=
 =?us-ascii?Q?vAwhdLLSxTnJ/8OzNCqFqssy2B3ftgnYTpZvlVW0aEYt3bUVBJOKpzX4tNmR?=
 =?us-ascii?Q?tbCJCt1m01Ii5l3BZJE/N4aqQT8SktB7F7+K4achEErdr+cG32e1EYnptLrd?=
 =?us-ascii?Q?2awftO9dE+K0tx8A3ZA/h46qdDywZ10smnb9XYucCoZiOtxXx5qvSyNBuri6?=
 =?us-ascii?Q?/B7g4fzAw82WajNjt//lCsY2ypG6guGr5tk0cgrjEbHRr1EB6r5xjb1QmMue?=
 =?us-ascii?Q?A1rBerWirAQYmwoSZ/AH244pORcrs8bFuPUm+7JD5PRZ1FB0A/inrkmq8OAQ?=
 =?us-ascii?Q?gepoop++ELGUt8U7Wsl4RcCj86J63EP0Z2dc8a4w1dIogG0RnPcCLcWOka8l?=
 =?us-ascii?Q?awiMFcW7dT+wyyZrkV6tvue+ByA2+UE3947bTUFxdrlzzJu0li/nxVoeDeR0?=
 =?us-ascii?Q?rykAncK03XOxe3tihduo/br5H4PISPGzyDQi7MXeRJ1pPNsfqzY1w+Ww4F9z?=
 =?us-ascii?Q?Wm0FKbV+04qrkTTeQCjf+ISAEm8adVhlnKBd/Ce/Z0bV3ulLIwKaPAxuqdPO?=
 =?us-ascii?Q?KX9Ybz3IR4iOKPHd2UFGJAhCniLKOMJoqYEQFh5Oe1hEssEx9+5PtzvA9T9Q?=
 =?us-ascii?Q?M7GohiHg2VpMmqb3AIr31/zry7RbK5omfpkuNm+/m6zMgYOdP+aqQhOWvaoe?=
 =?us-ascii?Q?U0ukvvdRnVw3tR+leVK/tfD2pux98IDgOlEs6KxCiauD1YzdkYnEmK5XK77W?=
 =?us-ascii?Q?GDZA8id0n515GkGpNJnY9T9Xt9pbH6DMKo/ozfDzjnp4G/0Iej3OEkbnxn3c?=
 =?us-ascii?Q?TTzXNtqzcX9eVgbwODop6qnd1ZJiXPxYyRUnmkOVb0HhoP622C+JTiSUpZMc?=
 =?us-ascii?Q?WNWquMnC8Ly7Zse3SgcOOl26IiFC8o0n1lPUwK+ETj9GyhJuy8fbbqKZk0mU?=
 =?us-ascii?Q?jZvUsPCKyufVgxqzXwslEuiPMX2Eb6xwQvgzP9lI/piGD6XG1Y53cvRkRlFb?=
 =?us-ascii?Q?C7c72VNDxTx2Lx0n8bgmYs+74fK7pT8rTu8RMNr+1x5/eL3p6YAvuJ1HXbZx?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39a9859-4604-4007-ec2d-08ddca7c8ace
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 06:37:21.1662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znY6rd4Qns0JKWfcuJpw9ainSe5RpXQBomNI6Y7spyA6XpV1Hv+oBPF5IWt0/mSkssoojwEOE7P14316sZWP22VQ83tUpTjY+FDnqFUDpvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0562

List the version information reported by the kvaser_pciefd driver
through devlink.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - New in v2. Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/5cdca1d7-c875-40ee-b44d-51a161f42761@wanadoo.fr/T/#mb9ede2edcf5f7adcb76bc6331f5f27bafb79294f

 Documentation/networking/devlink/index.rst    |  1 +
 .../networking/devlink/kvaser_pciefd.rst      | 24 +++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 Documentation/networking/devlink/kvaser_pciefd.rst

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 8319f43b5933..ef3dd3c2a724 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -85,6 +85,7 @@ parameters, info versions, and other features it supports.
    ionic
    ice
    ixgbe
+   kvaser_pciefd
    mlx4
    mlx5
    mlxsw
diff --git a/Documentation/networking/devlink/kvaser_pciefd.rst b/Documentation/networking/devlink/kvaser_pciefd.rst
new file mode 100644
index 000000000000..96e42dae4911
--- /dev/null
+++ b/Documentation/networking/devlink/kvaser_pciefd.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+kvaser_pcied devlink support
+============================
+
+This document describes the devlink features implemented by the
+``kvaser_pcied`` device driver.
+
+Info versions
+=============
+
+The ``kvaser_pcied`` driver reports the following versions
+
+.. list-table:: devlink info versions implemented
+   :widths: 5 5 90
+
+   * - Name
+     - Type
+     - Description
+   * - ``fw``
+     - running
+     - Version of the firmware running on the device. Also available
+       through ``ethtool -i`` as ``firmware-version``.
-- 
2.49.0


