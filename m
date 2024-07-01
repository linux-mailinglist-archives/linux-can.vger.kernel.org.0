Return-Path: <linux-can+bounces-924-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6552691E498
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 17:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8EE1F221E3
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6EF16D4C0;
	Mon,  1 Jul 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="c0X+5Gn1"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2130.outbound.protection.outlook.com [40.107.22.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7B816D327
	for <linux-can@vger.kernel.org>; Mon,  1 Jul 2024 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849012; cv=fail; b=CwH/wRR89ZbHIDKDSGFJxGIZrpXmC03qDiZ6ZiqOyihQ/aro49/Q+gcIjcukVKiZOXYaUhO/zipPkZ/BO1Anrmp+i1Egpjz4GvDbadcd4/liszy+DvboOHaaxCtgjxFhvwt+L6oKVB/jX7HkkQEe+ShAuIsRLxk687SE3xScD/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849012; c=relaxed/simple;
	bh=iuh+/c4s6RLKQJB0j1B1lO362hcZBMrgTnlII4QWhKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qqbqyNaSQ1Q1Oj9xIDKlu8n4HnbAmK5MlrJna5f/PaT4SxENOejICluYS6lNg+FCbiQ0TdvO2iKEGj/y3y4Gkuq/MQpq0gOHJJdDSJdeAnjRjXIPwx6HyRhJ0jIFD2T6I+YkOZ01mfs0EL4HSzI2n+5kxdI8mx3h8JcXZbUCdmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=c0X+5Gn1; arc=fail smtp.client-ip=40.107.22.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tfo00OMErhpWyMPFPuS1O5de9t33SxvSGszuhIVxNzXYHZ6ATTAxizGy8dI7tz7QmmobvnZZZrDI9UCX+L72h63wkYE7ObVJi1sqGBW6W1XC1esd8e+T0SfGatAkv1T44AWR5Pna9ofdYchGPjGWrNdSQQ2N08jxMzN+AUz09LYscl5yM3wUbZOJX9Mv3L2mCGXNoA45oyo/dvNNABA3ifKAGQKjls8S7JDxmW4Pe8oNPb54Tpj5QWJjq1L5I5GjNhUAl0T99bzDU1K/apXayZ8E51pQJbxgu+SSryCGJhYoMXoYnWxYRMDWySTCc07GrTgvleSuR2siV9cb2jEQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaGOgiOPTBeK6ADV9hOvbNjdg1Y0PY+LEsiwZYWelIE=;
 b=lcFU4KR0vPPFFPLLZ8R1j5T7rjEdRlw3MimzyMi3SgypIsJg+L7OqQkWDUxxXiXxy3HNFy8vuXPoO3wUOK2wseCKMb3vT/Bw0wq4hXEyCBNflRSWDDFLVIpUN1splej3ircZgLJqgT303jvxsQtYKAaSCG12CW3d1OSZaOKuauhUPmw3WbqUbdakExcce/CcalpWeKUiAKb/stjQUI1U6GQ00EyQvQ33fhAvDXipfoMdMS2To3LsoHb7JwiIE4t6jJpnKCi3UVWyRhGe318ZjlK7e45hcQQA17bk/XjjL3pLCIpmyOJu1zoqFQio8PM3Ai08jXPTMpZY/8Tg5bC+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaGOgiOPTBeK6ADV9hOvbNjdg1Y0PY+LEsiwZYWelIE=;
 b=c0X+5Gn12I9Ook85gI7nxTJuvawTpCMZI9h650xw1pu3GvDz8+TRQhkqXLFhC7g9k5M/wOUJi/QpgvjNJB6xND92uKEGoGWCnqiiiCxFlGuv6gz2XTcEB1CVkatden/btB+OCSzYcziCxB8ihKtLqrQZBk7MbDbgaHSSmfvUGmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DU4P193MB2498.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:566::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Mon, 1 Jul
 2024 15:50:07 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 15:50:07 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v2 15/15] can: kvaser_usb: Rename kvaser_usb_{ethtool,netdev}_ops_hwts to kvaser_usb_{ethtool,netdev}_ops
Date: Mon,  1 Jul 2024 17:49:36 +0200
Message-ID: <20240701154936.92633-16-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701154936.92633-1-extja@kvaser.com>
References: <20240701154936.92633-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0112.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::20) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DU4P193MB2498:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b1536eb-9b11-4551-d80d-08dc99e57add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?41olIoBH3mkaxTc4E5dQ3L5DwwMktCwkAeGVICVwBOEs+RqqBIGc1WtfSO14?=
 =?us-ascii?Q?gfCzCm2+HyLPZM2BW8h9PTxEtYpIVSUAWgwaINu5G/g6cdgTS5PowLWuPXXT?=
 =?us-ascii?Q?DZtFeZN28uf1Ok5iacS7SbMDNSNlKvVJlajASd4XvlxSc3rCNhzyQEkRIyeS?=
 =?us-ascii?Q?tLsVhk3ZwmJ+y3f9uN1OzbNw+2FybklZxk3oxEdF2rBl/pN6fyx+zTX0Ol3/?=
 =?us-ascii?Q?KekluyDa4eJkFcF/PlEFxapNkxxz8K+lyqEpQB3FOqoBKsnW2zKYg1S6PgHH?=
 =?us-ascii?Q?MCnV8LRrWCEptrX+flMvwTvgPDnz9FsvRxG4ftWy723HDwF99GYs8UF4uoqM?=
 =?us-ascii?Q?140DKS2LN5KA9uc9gwbLjX2UyiFi2NGzNoO38nBopgFbz/y1WLsSQgh4NMAY?=
 =?us-ascii?Q?0YSfdYGkhhCHNtWK9ZJusb96Q69Ypcza4IdlmvhC1qfVeGrIHN8PA3sQ2HpR?=
 =?us-ascii?Q?zwU7TT/ueObbFtidwVb3L8CsrY0Q5X6H1CQB7sM25v0ySlq4O7vWTwCqKCZV?=
 =?us-ascii?Q?TNDqM4x0ZPoNW92BgzRnLCF8EUyyPdq5jqa2Bf+LVGbztvqGKgeE57YlsNNI?=
 =?us-ascii?Q?aFLdYXJLP0mRJbIbHovVMzG4+S57Mc81nDlHsZdFCxADS6Te32MMkJ/zfrPg?=
 =?us-ascii?Q?hrW8m3KWThwOZmXZzzvmVTM1lGgSuvt3nQrYKMqtXu6ijXcrPmnxDOdHNk3G?=
 =?us-ascii?Q?pa6BQ55oWpQroWeFaT++jy8VSETJR8ydfW7Ls4QiAUlaz0CpMlUBAJmPA6/T?=
 =?us-ascii?Q?wH8rPeLi3sXd1ylBCnA61C0fi2I/e8IZX2SJ4fT8rzjI/cciic4aulJ9u/bO?=
 =?us-ascii?Q?rV33OqqVG5idAnDY+QrRb7a/nM90wFZtoZeRo6jzC6P4AD+b8aoNAfGj1EUa?=
 =?us-ascii?Q?fPw2QQjzmsmB6amVk+kEY8nePbxCU2uH9oY0GvPpNPDlo6yqtWpTZRILEbBd?=
 =?us-ascii?Q?uSk3YPwdnvi5XUajoBZjzgwJA4XY1yPdEnTagBh9VJIP7uDcAHqwZPb8yptk?=
 =?us-ascii?Q?U67Hk4wSz5zih4Z+1SSigVRCpc/hP9g4nLye+Oh4pkNPH7ntoeXQdJp7SynW?=
 =?us-ascii?Q?yDIgZu2fuIY7ybTnwSDiQp5ku6pCEO9FF8Rad2gsjn71S3hIEWsCPAxTAdj8?=
 =?us-ascii?Q?6SNZ6H6yWVDfk9XxuP0oWaOFhSoEY/1OCGxiVTgXSMNOBPnhTheO5VfP9/ar?=
 =?us-ascii?Q?Qluqo9yg1fK4jECdyN8FEOP5iuvJMPJ+Uf8bI3pqxp48Dj8KqyumBPTF5/6Q?=
 =?us-ascii?Q?/6AjvDwKJgAl8KIzLEwCqbQ6oK3LOutfi46KZH67D9mgDrpbujZxgBH7PhHk?=
 =?us-ascii?Q?o7WuQw8eTaQG0CUFcopLUJMswuGoVVFdKW6bGcl8nfQBlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FLCoWvM7IIW22pnirdF0V1YJ4Ds0sFW8U+8bR+L7Ya/NnfvwlgKQ7gOvRh36?=
 =?us-ascii?Q?5SlT+mBAErVDveg98mK5LX0tj0YkNDDAOhnwUxVw4e2vSW3gv04bN40gemP/?=
 =?us-ascii?Q?EiUv2ts4vqs7GX7uT+iwIVbxcXSr5F7Eofs6MDALZJvKXLSWJDZ8OEuNvrNi?=
 =?us-ascii?Q?TxlTLoXBgN/ggS0ctGE6Ke1/geUtZiP9VANIMs2jR9tJjL6+PibD4a/DFV5m?=
 =?us-ascii?Q?3ePr1f97H053UcNDa+NQcFxxyFilPmkeNwKCXkXGrENIFX502RIvDO7DAhfc?=
 =?us-ascii?Q?Yb/v5OG8nETIPKQDtcgxxodZPrtrJilzf7QfW036bLyNCmMHxTyRkzBLBm+Q?=
 =?us-ascii?Q?7CMouacQ7fT1JSZdk6ceJ00gBlhd2HIEf+VJQadOGszKYXw3bavZsItGLMZH?=
 =?us-ascii?Q?4p5vDy4Q6jWuB6HyhdfQB23SS332N4x39e9fKWHFpyP3CA3Qfwkr5rQeM4a7?=
 =?us-ascii?Q?/KIMQ/DwRuNG/SmJLinRtUc3zRwGRGWvuHi7npG9dCF8V7RtI3bLUew3h2Fq?=
 =?us-ascii?Q?JVBqdQvbfeZMDFxM/asCbwbDDcM0K7d232UCokuVsp+WRWAANojp9KV1B4lw?=
 =?us-ascii?Q?981Wzb3mjUZY3X4lA1tzHDXis/GDwny4nMtG6e067AxrANuVrMnS2xAyrIxO?=
 =?us-ascii?Q?Mw9DI01cmv3Rm7POMKDP7BZ6EixG998dwQ3biq7NDtSBmvC1ET7KzRxPKOas?=
 =?us-ascii?Q?3PFtWrJr3BC3knSXlDnNziGioH6hKRvxSeW0nU3RzUU66O64uC7MwAKm2gHU?=
 =?us-ascii?Q?VUCCkg3Q4ra6ZwBo0/NbQpozdZ4WeNgjekEhoJ6ruT+kAJ1qa0/j0oVvoZzo?=
 =?us-ascii?Q?PIozsEV+5mny+v2HHIDIHVgRY5kZPYtnpT2SHdLAhWnYTrpqRCcTNd210P9u?=
 =?us-ascii?Q?yPlhw1dm4jDCHYuMT4sQfW4Z3/ypcsSWBPH8HFSjw1bpsFfBHjbC4MPPMs/P?=
 =?us-ascii?Q?/CwAr+lM0j9i3YiYvJRFq44kfcMRq/0pPL8HV47g0etpqIIwhTVZfr9qG5DG?=
 =?us-ascii?Q?5tw82wCbVP6cEGW5Daeu4t9ocakWwsSw4hV1OPEdy/BGECJcb654gS45GfXm?=
 =?us-ascii?Q?jwgcuWiw+3tTb7Rm4FtkNi+EKRdoybJUbV4NsGfTN+jaRCiDkfXbPW+1eBo2?=
 =?us-ascii?Q?Iqski83VAibk4Xxv5MLP0HdFCx52O8+6NnwDkk0z3A/OhLJpNTWZQTMzSWC4?=
 =?us-ascii?Q?+pyiEgys++og6PlHEfska00mEpCw5H4B9cgePXS9Z4+facZBwRWzUvCE+g42?=
 =?us-ascii?Q?rAl56iULeIVEbW6JdX17SKyCiGnGOBMeuZ6ABbW5d4XO9ye7tsiB8jrirNlN?=
 =?us-ascii?Q?r3wu0zQ8W6lMlOuhPnsjuhcqNgXJLjysWSOVqVK1jTIWhRZ9UCD+ATQecpXi?=
 =?us-ascii?Q?aHlnnL7Bba3hErBtXZm3LgepShidUX0KUZd7n7C6RzIVrq4AvnL3GXBajkoc?=
 =?us-ascii?Q?pWiYbU7iX3dhRTOpRBC0bHOiOhyzInlwnTXhc0CRgKsuqL3nxRD5hFl2+nRJ?=
 =?us-ascii?Q?7L0LUSJEdDVKhCK6ZPPvUJvMFom2pivYoPGsKRcSHz9X8QBMq3yKvG9zIUVT?=
 =?us-ascii?Q?lXCONnSnJG91nwDaj/cQrGulNF6G0dE/IacQtMPw?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1536eb-9b11-4551-d80d-08dc99e57add
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:50:06.9309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KenN5WpQankyE34ph2kGnyPSIPD1ve3/75g+amcFQB/D3MxpfgmP5b/aWIpSuRWAgKO5Sgh1RUNsGq6M2mOA8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P193MB2498

Now when we only got one set of ethtool_ops and netdev_ops, remove the
"hwts" suffix from the struct variables
kvaser_usb_{ethtool,netdev}_ops_hwts.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - No changes

 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 4b6c23121b5d..35b4132b0639 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -753,7 +753,7 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 	return ret;
 }
 
-static const struct net_device_ops kvaser_usb_netdev_ops_hwts = {
+static const struct net_device_ops kvaser_usb_netdev_ops = {
 	.ndo_open = kvaser_usb_open,
 	.ndo_stop = kvaser_usb_close,
 	.ndo_eth_ioctl = can_eth_ioctl_hwts,
@@ -761,7 +761,7 @@ static const struct net_device_ops kvaser_usb_netdev_ops_hwts = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
-static const struct ethtool_ops kvaser_usb_ethtool_ops_hwts = {
+static const struct ethtool_ops kvaser_usb_ethtool_ops = {
 	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
 
@@ -847,8 +847,8 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 
 	netdev->flags |= IFF_ECHO;
 
-	netdev->netdev_ops = &kvaser_usb_netdev_ops_hwts;
-	netdev->ethtool_ops = &kvaser_usb_ethtool_ops_hwts;
+	netdev->netdev_ops = &kvaser_usb_netdev_ops;
+	netdev->ethtool_ops = &kvaser_usb_ethtool_ops;
 	SET_NETDEV_DEV(netdev, &dev->intf->dev);
 	netdev->dev_id = channel;
 
-- 
2.45.2


