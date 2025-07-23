Return-Path: <linux-can+bounces-4037-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308FFB0ED4A
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804FC961A94
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1B027A914;
	Wed, 23 Jul 2025 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="deeuCgNR"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2137.outbound.protection.outlook.com [40.107.20.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9A279DDB
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259595; cv=fail; b=qtgCYum+34ESTESXNjqorxH+nynfeL46/yD0qjNCePLPQkh7/WGJGRwP1SITdUKUEGl2VwTpZc/GxqceNDxEq+kjC9iaJQyD5kxOUBNnUq97EWKklj7iuzzoR4IvwVZwEoHfSzhfnY3vfHmsXsd4UmPyYUs1NZVrx4E/Sop6BSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259595; c=relaxed/simple;
	bh=arTe47iCmk3diAMJCdtt6a5JXvNVc4NNegXmwnlETvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZiHPcI+Dgos3WRZuyfpAXzOK7yVhFvvVTyIJhCRX+MNiJEXiwHQ6fSADZvGJvWlrVkn6RTEjLE6cBCukVR2ByF84xeBO32pIL+x/XjdJfFuFQLrDH18Vdv7Pag/yBsoCU0mu5lwM8VqzfLriqA/tGeWrO9OTkOgPELE6zlING3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=deeuCgNR; arc=fail smtp.client-ip=40.107.20.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqdCaGem+GSa/cDDBgt3jAA6uu4UmtojP1FHJGVGL5qI5GYwPRq7Rj6cEttG5n5AQycIIID/a9b+Q3Vq7AC02R4jYZPA8oVi8l4Cm4emUKd+jEf9MiylS9J9XDyNh5/YPZMhfwICjoD3LjvEIdls7TJoWGX5TA+XYCZe7efUdjk4xePaq7iO5+/lVNuVNxhU6FeIT5yB8yZb4pe41YrKaEvKXOsvawzndkyQkaZXA+3ZPyDSBBtLJgWFzL5KflTNYzMCO4mf2o0rkrhOGmw5S14Q067VsdY0wLn0GC5UihT11sNbVpnI+yWSosK7u3F/1YmjzCUg30E63DaMoQUzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+QTCKf+B/smmSUN33OUtyFaihLBxfraR8uzZM1+Pgc=;
 b=BD+OC7WNjGHQlYdXoVC63PbSNCbPx9suNJpej8eHj6Mtjp2D226mbpprjcByMpmSpQfKrM3lEe9IYxkLnmofc24klYrVWbH//CIgBAptGOqAJagtyzpl8bB0fTujisVHWe02y6eC4QgzRw5yZVZcn5CTMRqoUaXRkPaKaoukehJtLL9197xcKoeZFmSUJxOtiuM7acHvi3JiqmEnZPHtno7fwz0ZaO3+0RhsY04H2VRT/yr1pTuAXkIhPlmdovE5APwtyk13+vThOt+B75Agv5nfqxJ53HhzOgTWKmQINCxJ3rhbS5Z78noJej66kRr7MVvAqX7r8jIYZb6Buo7/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+QTCKf+B/smmSUN33OUtyFaihLBxfraR8uzZM1+Pgc=;
 b=deeuCgNRU0C9denPBQHLAWJM6qG2QTXKZ1BIVjoZxgWivz41l8iJzWvDEwRdFBX29DHmLaoQIhtDTQqe4d72ZIagOJncJrwjo35ULroVBEiZwfUXoku2wMWK8l6aFMj4oABBsOzOniyUdruCdoIhOHxOyo11d39a0p6gc4WwF0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0773.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:33:07 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:33:07 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>,
	Axel Forsman <axfo@kvaser.com>
Subject: [PATCH 2/9] can: kvaser_pciefd: Add support for ethtool set_phys_id()
Date: Wed, 23 Jul 2025 10:32:29 +0200
Message-ID: <20250723083236.9-3-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250723083236.9-1-extja@kvaser.com>
References: <20250723083236.9-1-extja@kvaser.com>
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
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB8P193MB0773:EE_
X-MS-Office365-Filtering-Correlation-Id: d9cf3826-455f-4b06-6059-08ddc9c38ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jtpszgNAn4dx0UGS4fjA/Q025ooOKPGJkFV4XxY7kv2abuff+GPPqqAGcWHt?=
 =?us-ascii?Q?HfABKgHdA1Qti4YaxDI50z47LiHXW/esL13tVK54NwNrQ6yKCZAdlwhFyv1l?=
 =?us-ascii?Q?bRMMpOBKQwFIqbevFR9depPo7m+ZDMu3JyaHAyHacsdvZBKUKI9SAqjZkHsd?=
 =?us-ascii?Q?YDDtUfo+pJKt0MNBhAhY3mzl48OHj8IVHSPbrggLNood3+AmDiNhaDitMNZi?=
 =?us-ascii?Q?+8CglPDdonitkph7ngK7bEYVXuNroKZzy9FAgtmXI19IBr5rHZb4UXBD6YEA?=
 =?us-ascii?Q?BAyrf14oN3v3zlauh036TY0VAWgmh0jj+cOaVq/eqgp//xkMl28Ft7c4BODo?=
 =?us-ascii?Q?6lQXmLWy2LIFa0xQ7C6bCP726vA5DftroKJ8IPK5NU5oUK/K0VGaHgAKqBC0?=
 =?us-ascii?Q?DXSi5gvQH42SfQVb9yzSzkIX22Y3cdaz8N+g3IQNKaOufPQwjIUMNrQtcUH2?=
 =?us-ascii?Q?DK+XmO2n4ELmH9nGzCgSo65QZrFaJ+rOSks+F8O5Hrf7wmAVo/4lGbdiAIhy?=
 =?us-ascii?Q?Db1jFKNQ9wKxaY0SL2EXy3Ct1EshqMrvzxW5P832q1yv2qwFK3kPNVdhDVXi?=
 =?us-ascii?Q?SiQEXTWIila5JDFvAWdyAjJrJmNgTygi9jzk5z5ygJ13vZqGAl20vSpd1YVb?=
 =?us-ascii?Q?WDeNFejXBoYKVrw5BxqTf7AkV7m+Z2c8bCRJeUKYPgfW0NgDBzws5dPb0it1?=
 =?us-ascii?Q?UC/6NqyAGkjh4bS/CSPTsvw23Tn6UE0JYpMIfq8sr8N9u2N/YHCR2php91uG?=
 =?us-ascii?Q?5ervSR2T1CgNL+GDJQvl/Y3eCB4+Jj3A66y8XcxRkkG95s+TT2oHym6Vlz03?=
 =?us-ascii?Q?5LHKJIxpMTliN5mTK9aJ3iA/7QMmK2ZZJH9/tSpVURs0l6BocMRqx4OGwwBK?=
 =?us-ascii?Q?gagN30cDBVUTgD0q66GKhiCfMVaLkmzyJ335uqxz6H7TfjD5sG+nPF5neMrh?=
 =?us-ascii?Q?itMkJWQegwTfu2HGsVR80EBWNNJtzYiRCfpe95dInTcsQ4mdrogLs55KOieO?=
 =?us-ascii?Q?dwaa5thbKv54T4zB0rr5aJ+t3lWY/bp4RnQE1UKrN3TDWsPOU/l57pERKQZ3?=
 =?us-ascii?Q?cV1QRZafVurABSiOvn6vP5bfcm/Aak11DAMWBz44mQwzAu7K8E7PpYJjAeSo?=
 =?us-ascii?Q?nrHkr6ORxIOa23Qj6MeRPynTySWioT7HY6oYUvFcRIGXZWxrsfn/oz18Bf3E?=
 =?us-ascii?Q?c5WEnGfwPMwO3IToktHCYZPDmmK/XcljkpUKruzHmlBEhq22zVWcRhQab39i?=
 =?us-ascii?Q?moNTHrjZtCil5U2KWm0q8fTAih/7MXg/vP4lR2C/4R/oeDUb075kPuUQq66c?=
 =?us-ascii?Q?pe+QoVQGKCMMemMMeVC2rYlbG4W4gN5jLFnN5orSVEjBlGMkN7Q1NrqtmFqj?=
 =?us-ascii?Q?i+c3DvSSPNCpNzmqiHByFCOx0mfMC6XzLqEWk7YsCGUBOaUJBdpt5aS39ro1?=
 =?us-ascii?Q?mNpGTSdyFO4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tvyeDC6q0ee+8Nl1CXN7UYY+2FJlVYa6oAr72nQuTdXuRBF9NppIy2kN33fs?=
 =?us-ascii?Q?IWJ5MkPUcWIIYywd5dnQsTeHQvOOdHaUjFTHVtkTzGuBbkSgGzjfTL1JFVWb?=
 =?us-ascii?Q?GYC5rfTzaxzRTePAusenV8ikCMCEsR+78ATnmFA0YQXtna3hLANBz+LF7kJ6?=
 =?us-ascii?Q?mfejvbkUmW0OoESm91Exyvp7lfBek4b572mlIaVwqMo9wWVx/uMChe/ZUUUM?=
 =?us-ascii?Q?PgzObResTa4eqy3rxr9ZE6CgopeJ82SBcqpG2HTZuYVSb4qrP7K8MRSZMj30?=
 =?us-ascii?Q?+OCeREZlHvb5oZUb9zGUhtGzGpCGxfqec08oW52l4NsLGE1jyD1HMKt0bd5w?=
 =?us-ascii?Q?VQIjlzB37Yd4vQRS4FyYv8FRjm6sn7hxg/mqiL/owLGWhUwqcTV5B1exZgUb?=
 =?us-ascii?Q?6tnNraMzDCUiavZFLxGIycyfLaQeDOxpfh1bPrPXsqd0+NePwlOA78XhFfHn?=
 =?us-ascii?Q?6rw0FUCWEodniHPzKvBBouBUoXn/ulJOUZr7MMtEWGXNOGJlM79Pxppxz5ZR?=
 =?us-ascii?Q?nGGC2kOHfLrrZMy+LmtKU3Z/jrRaeYdjkVIQWKRH+MsEtVUXjwRSb41EU4G7?=
 =?us-ascii?Q?S8hARtPhb27TS6jeuASXitmxp3B+6uWEae+qlSeqihb01s6HpRPn0Uamg+R1?=
 =?us-ascii?Q?nfXKKN3doWPl1nl3BORPHFiOyA/4W6vziydE1ZjzyO7row77QnrBPlQ5xoU1?=
 =?us-ascii?Q?xZi8Jyof667JFZ+bSit1kFgtEPYgopLjVnRCLCA6kqTa2Smm2hSh3m+OOxZP?=
 =?us-ascii?Q?x71jIBmP3EqrkbH3U98ylGnwX6ENa9TKLTEyEmrpjq3Gt14QWERuI1hgLzfv?=
 =?us-ascii?Q?QRScFS+5e9FYAYDyMSquEcXd6f7ZnOn4rVjGF+NvjaSIGCqX1xNeXkoipQWT?=
 =?us-ascii?Q?TSrqz1390Pgy+h37i32/pIbtEaKjcYUpkUUMF+jsPMVA4R4sMVBWfNlQSddy?=
 =?us-ascii?Q?eiCT+h+pyl1wy1QiauR4AQSgw/bpaw7i1GZRdHIS3lMFU2zbT61fWhAYHlgz?=
 =?us-ascii?Q?agXxcvVk2QYLx5bKkRx7s/s7jknRI9RfKT2ynDSvIADZtjjhO0E8yEDqUCZr?=
 =?us-ascii?Q?ciYnXPTW/y1RCXS4oiRjRJYJ8WD284r7TkPGjnF9YNtHO/BWxbROXJhvXyPa?=
 =?us-ascii?Q?PhLkAxyB3pPApF2XH3z8dQfvFO27k2uLzFb4wxdFIOMahnzf4GpWsfJDEJK6?=
 =?us-ascii?Q?/kRxfAOKNvOw/hAf/SXBk1p68RZhrmaIMgu7tNTSZ0fHoQAUKUziOdzKYlv/?=
 =?us-ascii?Q?1qL+JuONlybYWp9sLizewf0rtlJuKTuJpGUJQuJCNtbkhVOVLvbVcjfiFbBV?=
 =?us-ascii?Q?JuGV91jLMYpLUGaU2AF01kjhB3fEb1aiOaANaXIqJK7DH41XN7xzBtKTkBDV?=
 =?us-ascii?Q?oW3ipeeqYaTSfgns8bbSZaC300P14ipqS3Ji3+eJiubv8X4rOCMFedYwLp0P?=
 =?us-ascii?Q?poG2kITtWGBAsXyAxVWfTLahs+7CadF2pLtV4VDiaEF4fuUvyK9KaqZVIoBL?=
 =?us-ascii?Q?hC8204kfyO2GiCJ1bS+Hddgvqh8PTG/Z+WMvcls2zoCFY+0prG/Q48yIOphC?=
 =?us-ascii?Q?HDjJdehGyh9cgFnqg4zH/u51Sthtb2mADNEzfxFskqTPA96i6l8v4WGbd1oi?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cf3826-455f-4b06-6059-08ddc9c38ca9
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:33:07.4168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6Y6mNGRgzX8lLKmshVA1XOSBiiD/zm7TuuuNwIpvuwF1CJ2flpoXDm65zMXeBxfxPKx/cIxh+X8fw5KECBGNu2Aw13H15mlFxlcsjDYaVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0773

Add support for ethtool set_phys_id(), to physically locate devices by
flashing a LED on the device.

Reviewed-by: Axel Forsman <axfo@kvaser.com>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index c8f530ef416e..c0bfeafb31f5 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -968,8 +968,34 @@ static const struct net_device_ops kvaser_pciefd_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static int kvaser_pciefd_set_phys_id(struct net_device *netdev,
+				     enum ethtool_phys_id_state state)
+{
+	struct kvaser_pciefd_can *can = netdev_priv(netdev);
+	int ret = 0;
+
+	switch (state) {
+	case ETHTOOL_ID_ACTIVE:
+		ret = 3; /* 3 On/Off cycles per second */
+		break;
+	case ETHTOOL_ID_ON:
+		kvaser_pciefd_set_led(can, true);
+		break;
+	case ETHTOOL_ID_OFF:
+	case ETHTOOL_ID_INACTIVE:
+		kvaser_pciefd_set_led(can, false);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
 static const struct ethtool_ops kvaser_pciefd_ethtool_ops = {
 	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
+	.set_phys_id = kvaser_pciefd_set_phys_id,
 };
 
 static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
-- 
2.49.0


