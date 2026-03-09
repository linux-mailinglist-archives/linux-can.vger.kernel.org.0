Return-Path: <linux-can+bounces-7035-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANxvGIoer2neOAIAu9opvQ
	(envelope-from <linux-can+bounces-7035-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:24:58 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3D423FC94
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C292304EA91
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242FD3EDAB5;
	Mon,  9 Mar 2026 19:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="neNqdrD7"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F02D3603EE;
	Mon,  9 Mar 2026 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083379; cv=fail; b=cbDFxa6XtWaiM9o02Ev5rlypaBsPbMhvkrfnHtXkVmPlRqWHhEbrkzEfsFc2Gn7WeEbOQ0pJbnNwrzxvtAgRztEsCdHj3F0/PQgYB7EZF+6lRDXEPNZn8O7MEh9odnMt3k0fF97iQ2dL/JcxzgifWzE1HcVlNUyj5RgysI+oevQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083379; c=relaxed/simple;
	bh=HUOxpXUYHBoY3zqCR+4n+nyJLsWSEDDuQobXQDlg6zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O49gjs4JrzOrHAdhzCBUV6+rsZhKzNXw1xWH5yPpMPzV0M7NRgf3DpRhnaAg7HDApjd1o6T1F9SeAQw2J6SXkIpRIL7xP9/s+3rySmix0JIOTIq8NJKL3v/lGv6jFgO3R8hWptf4JeWN/VP2hpCBsWHkFBrLVWv0gNg9EAq/Bgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=neNqdrD7; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlJFq9CJ4euujbotGUYiT9ZQ5pgAsmh8Do6eFSsURj78/nzBsyyrJnBzWK1kBlUFUyslTK5fIBVN4AmkTXx7fef5gA7j2CWCV/jRxS69e9wDXXKinO8UcmAoWewiTUM1fmcVlnljmJehdFzyIrNRm6/uUS5cVscCl2JhO1G+n8bwIhzVE2MAxtfLTav5Rh27OnXbX4Xszps5Vc9q9jsDszTzVM/ZYkbYFHh8TuKyEa+ha1rp/dLGEpEhu+H72vHkEuaFlSyoXd8Vk9Akamo/3RxOsOMCR6CzIMOXDHybe8yBAPmEyJszBTja2FfSiBsh1ypDHC63FpmTAvTY0qZhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLMKWtlO+o52+8+3AeWX65NAUQl/4o8WNwLxrZn3ZCY=;
 b=b3xioPCBBfpXDmaJj5lwO1m0rkCibqlij/wqwmaFUd4Lwh7/fsqCdP2TuBrHqQJoXydtHcw3XRQNCmOVn3UIIB7ZpyAGtnUGI+rU18MeoUFfd2/NrsdC6C5giYO+MT9xfXcgd9TbInzpXpjit5vDBaBv0aMI22W3s0Uhzln5b42UVIZ11mIcWdYv/RRj9aK8oFPUHjcDNgm3Y9I+/wmvUZ66Opz662h1wnwpsaEVAMlcGj1Oxr15IDsnm/ylrtW3vRLfK7yP7aIcfx0sN74YVxA5jU4kONCaWNi/B6QQgN+IMEICcVz4z6UFxc6KL7YQ0DPHba/x9AcoFKC+EtPmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLMKWtlO+o52+8+3AeWX65NAUQl/4o8WNwLxrZn3ZCY=;
 b=neNqdrD72ZKIIiGkS5jIcpFPCbLXsX56hb3zveVrb98qkRIInsDlz5GLls/I13+/AsnySNHkeOMNc3dxLfkhqGLbXU/3kuL/uuMg3ZUxykTRkWXd2tF9xvXz2W3v/Ya/yc/YM6gV/9+PwCwGi3ii/PNPSw4BeNudnT1wMzIfGDuzvTau3IjiuuFvZo3FYxceDJL1UD1lo3GBOAWGyWHSFYSfvtuwLTYLchA73RTFsqckERMl9/30XwfzH750Sq2GFuDz24axQMJQVj9Bnpaf9xLX92RhfXiMptHm8PbefdCfeZfXSnup72MOtdRrIyzYOioLGpYkjm9wdJBld8htWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB7540.eurprd04.prod.outlook.com (2603:10a6:20b:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:09:20 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:09:20 +0000
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
	Yixun Lan <dlan@kernel.org>
Subject: [PATCH v3 phy-next 06/24] phy: spacemit: include missing <linux/phy/phy.h>
Date: Mon,  9 Mar 2026 21:08:24 +0200
Message-ID: <20260309190842.927634-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309190842.927634-1-vladimir.oltean@nxp.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0032.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::21) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e63c5d4-c051-4bf0-53ab-08de7e0f5e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	8T7Lmjb5q5xr54TGjV2JFXm59BfOS1pleHnXsTl8qvfgELLwLY9tga4INLq7YwD+dcuhjs3gVhykYwU+thcwBD3+AK2CgZw9O/p3sBlrnHhtS3IZY8K9ccRl4DI8sIfIJqrRoPHxzl9SzTZyhqk8GGwiBMXw0zLqwCxVDvZxYWyNCkC/TxGp10nAtW158WWawfSko2BEoi6PXR2FfWlKZSaOUTKAX1lP334WIgayo6inbeGLnm1w93nRAc96lfHyEcC3CjnzRdAVbO1PLN49fwtyTv1XwjbNbwnb5lGUVHZde/R61/2maiDeaO4kDXuNscsZIo6HmfyiHY128n74C++LRQWSvDtt+ACImtT6fZvewXBuEbSRQQbBCBBnEaGHqr/MytMNOhRsUR2ZoUWhUUyqmKd0U9qFtPVs77rpLvrlptojTGYLPRxW39mRDECMKkZTWQT3u78eSe1YniG4a+AyLASlHZtuXauN4vluBrD9wHGQojxkKS12FKn2ceW5OVJk8Q2TmlVBf7Hk/BErHBLiAxIDexpj9sF5itPKMGR/+CBzpF4toenr7g+aoHz+KgE7Abybqkfmx0hUmzGmqaa+mZW+cLfqN9RtzUeVVa1IcSiFncCFfjZQWoiGULckY8iwhkDx9wxcQaIqF35cAPiOCuHtXv4cwuvd9OUxKqk3Tl8usFfTOZl0O26IOSxZsS6i5Hghk5XnZtjJCZa7v/GizHYJYR4AEQMVatL0U6A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xtvEgFMHmvrOx+IKm7BxWTEls8ovNJT6nnC8v5xTYTbgHKvSpBg1VHe/74gF?=
 =?us-ascii?Q?ULqWwhtcq/BZv+S9hk0EZKvY0kJyNRABtNRZ8FmePPgWd4ApraMLcZKlLYCk?=
 =?us-ascii?Q?Ff6yA1VhQDEhFczx25g0HakA1zesMKj07bEguuf8+u4I4ATdROeu2I7qDJqW?=
 =?us-ascii?Q?Nzr84LZd3ZW5yepc2IyjvT9MoJVcF5qZEitwd59gYlSnaaB2CDz5b6gzIiqI?=
 =?us-ascii?Q?PypI89UaR9PzE6J8ja1TqKQ2JwiBIku1P5AZQSqkrzq6fXDPF4iMhb75gcl3?=
 =?us-ascii?Q?ofVMcj1ujgUHywWoAwe7AglXZOmhsSuei7b8sPYOii7qaAs2yo1P6pwXTBGR?=
 =?us-ascii?Q?qzF/DsuP+oxmQD5FAF6V1szGzufVq/EK3hP5o3AmQhpBz2umtDJxMZaCoJHL?=
 =?us-ascii?Q?iZqLfek/N8nPWj4XzyaGXhX80sTiJ6hf5rG3lAyFPICXBSdrp1lUjZJWYQTh?=
 =?us-ascii?Q?3FimbyzcwKlAyTLJrUmXt5CdvHysX9qvoNSW9S/VNnhARWQBuKpq1tOykJZT?=
 =?us-ascii?Q?JIsvcMQJ9ucuOLJM0ALR6F2I3hng43tPdchD7J5xjqSs18dyQMd4CeZUrr00?=
 =?us-ascii?Q?2v44oKzWOOL5U3M0KkTTvpa39jJU+L+undoNSDBNAAxV+nJzWoW70iaE6h7t?=
 =?us-ascii?Q?IpyL0zfXo7SzL7PmzaPm/mvo2bhIXqpGOnKG87BSKYTuOzS5J45oCUGl5ih2?=
 =?us-ascii?Q?wViqj+nIoXcxmI2Yn3UUq5625v8a9jYSEXfJUyo5TNcvNOMvcEljWOmC0PwT?=
 =?us-ascii?Q?ghkNBSuCjjjIj9Ld3eXeCul6mGWV+URplyrhQdZ5zJS9snRpys+9jo0izD7f?=
 =?us-ascii?Q?DM6Wdz3BLIbqIMdH0fURMldM/gGlpnkm8KpdTonJA1SodmAdq/f3zCQXepiw?=
 =?us-ascii?Q?S1wTG1q3sJLCSfiV9qUOECo41hL/GV+jzfsMaaVnLbfo5CxjcBUmsl0ndxwb?=
 =?us-ascii?Q?NJjOzRwAboKk6sD8r2bwimcbAcr0dI7DQcmJFP0J35H9nK6QV8Da+NK8aldT?=
 =?us-ascii?Q?+EbjGUnsc02x9X4WV14IiZd6E33q05tAnMOIK1hZypW6JTASKpAm3ZDhj1tZ?=
 =?us-ascii?Q?zHQZIxnOWcgiLs2DqwfVJRc7hbKoyDiDaodngHbpbbhnSYyDLLo6OrcoPA6i?=
 =?us-ascii?Q?nfIRcLJWFivc1QI65KXdBtbzZQMUahnYF3gKn18QcgI61zdBIfz6l22jdz0S?=
 =?us-ascii?Q?rQ/eodkGjvU/ZQT7I4Wv6FelBFiOH9F85XC2PMozFaTlhAurg0BUi/J5QwST?=
 =?us-ascii?Q?nvZriHN25Vk6zrAKUi3AF6OlHQgLrO+oasyHTo88h7ZrmWS2mDXNO1z6HBmd?=
 =?us-ascii?Q?IdoTlHMfUsV6KXPPWX1KcbMgL1+7kMuXhDQpUzU64DJ0czPJpijNWEMCp5aA?=
 =?us-ascii?Q?84xFdFhML8KO1g9rJxzPjKTovJzTavFFCeritkw+rzIQV0vAq1m5Z2Ul55RQ?=
 =?us-ascii?Q?SADAqttRfJs1DrdjkemitEdH7lU85pTypn8nKAvyJRr5ZnGNyFq28OuTn5cV?=
 =?us-ascii?Q?rdWCLIU5gPfacSuOg12nOl2WsOVqSktTC2N4HRsTcT5uOvyY04wLGqfHEM+2?=
 =?us-ascii?Q?SnDHXfoCTOGEM+hEVECZmnRPa3wrcqWNS9ncN4QPtfxyzyJPtbY4Z2cbEXWH?=
 =?us-ascii?Q?qnnwqn5KWzXjyOaFiY0FFQyonrmd+dD0TPnOybS2gSCQ9bqtGdUBNhPdV8Rp?=
 =?us-ascii?Q?BgmobhqN6kzkwgwFM+xaKgK9uC2wHrTPnNvN+spgJlSgSvYJ6pBDn2dWfvVn?=
 =?us-ascii?Q?9tcf7oFcesut/CPN4CLhLaFQVBfiu1BRg6Q+s8ic/Uvpfzu5Lo4UvWBp5bd+?=
X-MS-Exchange-AntiSpam-MessageData-1: 5bHn25PCXjfjkw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e63c5d4-c051-4bf0-53ab-08de7e0f5e5a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:09:20.7758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGZjmnZksfxj8wl8qqWzr+9v68B0pbI1VfYmnF3Jq6LJSDNH3XFvFv7lFda6KKm4QPqlR2N8uYQa9fbyCuZALA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7540
X-Rspamd-Queue-Id: AF3D423FC94
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-7035-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Action: no action

This driver relies on a transitive inclusion of the PHY API header
through the USB headers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Yixun Lan <dlan@kernel.org>

v1->v3: none
---
 drivers/phy/spacemit/phy-k1-usb2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/spacemit/phy-k1-usb2.c b/drivers/phy/spacemit/phy-k1-usb2.c
index 342061380012..14a02f554810 100644
--- a/drivers/phy/spacemit/phy-k1-usb2.c
+++ b/drivers/phy/spacemit/phy-k1-usb2.c
@@ -9,6 +9,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/iopoll.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/usb/of.h>
-- 
2.43.0


