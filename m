Return-Path: <linux-can+bounces-4093-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1AFB101DF
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4A83A1AE4
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 07:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C235326F44D;
	Thu, 24 Jul 2025 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="dehTJsZq"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2100.outbound.protection.outlook.com [40.107.21.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2C226E146;
	Thu, 24 Jul 2025 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342251; cv=fail; b=OWwyutUN07SEbdocpW61LUTnwBM21IXOrgzg846LhiwKwpnnOPpyF9FLQEamyLeRT2MjBKhYrNx2q1MrKOpOyZtyLck8g0u9/A/WjLgeOeGl1un3sfTXrIT9DGWDnLJjtU+sj97MpcOpd5G+lseGaNgfeIKGAutErW2dXAuSojY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342251; c=relaxed/simple;
	bh=QS1XJI4KuQe3GV7B/ivovKsHrwDvmvnHpjxWQuu8dJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IoreGxwTBAMudbSiJm9P6fa3SOdr/7fQ0KKVpZhHA2Nkxz23L55PQCq0fgSL8eKr+u8GzD54Ic5IiYIZSsYq/B+WCSIJRgI/6UhQJPSjlLnFoMaSbNcmESOJpWhuhrcNfyOsG0vN9idQ+0hm0niY/XTWDIJoXBDLzzsmFAIKYcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=dehTJsZq; arc=fail smtp.client-ip=40.107.21.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWfS+G5DLhZwBPXY9cVRxbtCUkGaTnZtCiPtX6Ttnyo6XXgx342NkWbNBJ68mLEVYOltw6he4RvE/Aah2KfI2tisfIXFauXaSE7rRzKtHwmINbjEaYvNOX4Yqzyg24fztEm1OYW+bbBxDoa8vaSwB6EhxEZ/Ewxql/vTR1eyGKi750YE1c+7B1qt8YZRd35BV7qbX1f6syK9a76Wglxnd5v56NrBMisabd0c92QiB4Yd2QJBv0hTpFkoIc53p095/Oj8yM9YlAv9cZP23053x/OW0yXi1FocnKbSocPlnpoJTUqFAMvQyo55DFZ3ubgLP6mmDtsAM+GxJABZ0He7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ0/05NvSNfOrPhaF307RVF5gDPje2JCma+0fMRViI0=;
 b=PZxlkTHZUZ0pH+HwHmO4dR3jlejWHtZ/RsEFanBDGnYOGi0P9+uQYLV0GSCIPUUdxTWDW2uQ5dtY7sZKF/2KApqlUl2esx4BEI3ST8NzNaE5QEqAs0Q9a3SKSb2Tiq6Ftadsfuaap7zvrLflBUFT/QoPfjxwLXTSe7yQfiEpyV3nklvEr4Dqwtbkwp/qNUhwOHZSXTQ5NPp9FXlsd3+7h0x2r8x+PLjC7gAriuJvhVGYtCSQW6mGb59WDHLt2JrUnOHmh7xgRnYBKp6HllzBI0AMd6M6OMcYXJzJJy+parrDjf7OKczairFlfRmKUb3nzsqgvg+8vn2uA9xk0nWdtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJ0/05NvSNfOrPhaF307RVF5gDPje2JCma+0fMRViI0=;
 b=dehTJsZqjB8PhXJr79/ZTiutR6bO6RCA1IcF6fuioCClMTuC09x0oPErwNmfrFnsUeD8PcOLaUqN+qon8WYEfduv1QKmojvb1uEmuiTxwf31tK5AvrOhQ6tEfiEWNwUtteTTZlMcCNiP6CgnnetdFxGE1svybmQ5V/6NbK9nxaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB2657.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:32d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 07:30:37 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 07:30:37 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v3 05/10] can: kvaser_pciefd: Store device channel index
Date: Thu, 24 Jul 2025 09:30:16 +0200
Message-ID: <20250724073021.8-6-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: d29c752c-5da9-4608-8a0b-08ddca83fbc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8cCkUeQx2x4mJNlJe0Pw7MNUXCufMow6PtIktbWhElceiY69DZDFFATJA3dP?=
 =?us-ascii?Q?UOZ2zfDz3a24rqnPEkfb7L+r+k26faJx1E1lpv0/qe3X20wYO1Ten5d57LwE?=
 =?us-ascii?Q?X8VcpVGsw0T8ey38e/APdA8YGfKXUFFdr6dUirLO32FydBBBUgWo/R78/D85?=
 =?us-ascii?Q?QMfGxe8JUm0g5PEwlGem609gDIsGv9NV9xPo70Qp+XlolS6ekYWNxRx9EFEj?=
 =?us-ascii?Q?/PLx3wspRUknWPRWGbk/9iMW8mtHHmo0F/0zwdwi1PnXKUGyfheuVtm/BQQd?=
 =?us-ascii?Q?Kejw1wfpQdgwKiXBZOIdkduLTwxno03oHe0vGoblsKCNKMiJZTCvDcZc67un?=
 =?us-ascii?Q?nggyU4H238My/mRkh9pH491r+zOAbfGtsb6CuG4G7Ea0qVLApMbulEBUOHTf?=
 =?us-ascii?Q?jf3+ltaB+wHNTpUSW7nKl6m9/qO6AMItrwf4TmogfSfSzg+WkgXvIp7ctRQC?=
 =?us-ascii?Q?7M4nbGUM2WaLmNvH4MTib2vUUVTrqhnl43FWHom6lri1wn0B4uuQw6Xts5NN?=
 =?us-ascii?Q?LGkmyq3Fl1IqyUw+btIr+SkCJ2tLD5CimOIVmxZkLxhSZXu6U2sdFH6hv9oi?=
 =?us-ascii?Q?aY8bZ7U3tTXi4Gb6fktO3J/Q+mm9vgF8PJeazQmZCfqkPIfwQ4aZGQPVoPsN?=
 =?us-ascii?Q?BpHOIo6/kfelR1S7/WioENDqPNHewxZgBeNvLiJiM8p8d7Mot1diEsicdd+M?=
 =?us-ascii?Q?O819v4zZm2lQNFCjuLeiW+KgBgtQUA7sq09F5gkJnEKDMaiAb2m7+LuCsPi0?=
 =?us-ascii?Q?9NSlC44+HG/hhL9rSzl5OqtTSXUfG5VPce1nOYfNq+e+JFLQmT7RlEX/TDy5?=
 =?us-ascii?Q?kpX0Ewp/xeWxsKzjZzCr1eiAipvm31hAJ6YsgLXPTsSQydYl19c4WKaJ6mmo?=
 =?us-ascii?Q?Ase9C6GjeiA3i5dLAsPjC346RksRKAvp2SCDPCYDjUZVGPxcuFF7UFcgJvE6?=
 =?us-ascii?Q?Jlbc7TcYH50UXYfl5OGAWWnlsE6Wn6PbrflTBbba6XF6kdGPHhOWQmxP1OoO?=
 =?us-ascii?Q?N6dhVQST2IUyp6d6l8OrfPG5MdBylwij5KlYMbWIxxf/FJ5MxlEKPI+Gqo/3?=
 =?us-ascii?Q?WYXki+Kv6SMi/IHeQLHL0L3Uq3gsD8TYJgh4WhRbhM+BxXNgxPd5Cpg6ArIL?=
 =?us-ascii?Q?gZHFz+4eBbwM/KkcRyaGonEaSScx9olSGxKR+AbYdofMSTCVqiyCVuDx0TPF?=
 =?us-ascii?Q?ZStPibEXQrrVn7LtjA7Rtjippf7uFM7QnIqsK5XYgiWGuz65urhC6guRqtYy?=
 =?us-ascii?Q?9+JfmihX7c3/aFanZMVAHDqqcqLosXz/mYwEBUUGpEMAuJDkrE73GnJiX8xL?=
 =?us-ascii?Q?ObuawLlTkK3D9sA1dx1pQ5P5VIvY7ClB59hobuNpzp0o+DQ8laQkde5QrSas?=
 =?us-ascii?Q?2aJ8/VtCwwhA6tiLIEtyNoQu9Q5/35NjDSeC9GsrHxVVcwnhhiRNzd2lRo2s?=
 =?us-ascii?Q?6liJj9FQFC4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CCyB+u/EaVLXBjGI1N14+ys8gKF6lDUxHBf+JZVLKDkB+IvQOgg9W9KIFfr8?=
 =?us-ascii?Q?FEsqHaNrQgYu70AelZ1zVH8g6U2gDfkzX2dmQXhcagQLUKz3dfGXIz8uf5ei?=
 =?us-ascii?Q?YwSFYwoOh5dHLDeExc+cVMWQHmoUgT5W44Fx4VGo2WlaiMj0HO/VyZZ1IQtT?=
 =?us-ascii?Q?PWD7B60eE1BGh7fbUtwMgVf3hRNJHodbm6EEmlv3UCwhCsgbt3+vuVAFT2Ee?=
 =?us-ascii?Q?ptgdKV/WAj+DD0RedWMEqKmxZOSp9n7AR2yQkel5NaOOozCkyVpSHNk/kUeA?=
 =?us-ascii?Q?Civp+ICCgihmetz50V4xPl7ALmkK/f+aJ2vun0+H/T8Xdheqjnhd0w843ECr?=
 =?us-ascii?Q?LaMUqbO/1JFMNa7yM4WJqnMwOqx/sgYkCuoCb+OuJyQBUoeguZq49iXW0ozv?=
 =?us-ascii?Q?NwWGv/Y0EUFf1of5i3yihdBA7BKOpCGPkAcUX7oaUIYqD2/igRUXm6/dS0SV?=
 =?us-ascii?Q?alcVRBi3cd8s/NoQ7G2r6MqgSj5QkQHb4BODG49SEBmsmzRCbEamjZO3oVrM?=
 =?us-ascii?Q?wuOJTXUt9ny4wlWynsdBH8gc41cg/rS/tUn/MZKyk13+QPxrAQjmW5g3n9j6?=
 =?us-ascii?Q?i7L45GlcldNQDVzVilWCCGaQgw6pd1QMUpJOKC0iKLGVWMqjUyNsYXG0K3J9?=
 =?us-ascii?Q?YrP55hnGIEbc52t9r3Tu+JY1BYA3NPGrQfADz3YE6MGnolLx1myCPQ/jDFxB?=
 =?us-ascii?Q?g+tyThVZ9Ff6FdUi7zriiZLulsdkWuqaW+OXMry8BhyC+rF42hpj4E0jQlpt?=
 =?us-ascii?Q?VGq3JbWn/6XU4iSC8VjSJl5qW8UuYgkEGflk5SSfen+hSYYsBxAVSV2caugQ?=
 =?us-ascii?Q?wTXBg8wrFOj/dgte4QiS/eq0WvyyQGfiOizl7joOsgP7Zlty/BV1HLub42o+?=
 =?us-ascii?Q?9LXwRHycdMNDRbLHbHEvUkHxQx+fOm6VJkvwHER8Y9k6dXPHpQMmGfKarJEw?=
 =?us-ascii?Q?nwIro2CL8rYB0D4mlMUkp6kUY5oi1uhUjn/QQ9YUKTpbpfXbjFYUw6O84EC3?=
 =?us-ascii?Q?DXIt6ZpenPdkqLLehLTmh9RrgYp6DZdmG1ZKV9yTtpSo1CpwdnWGkN/o0KAI?=
 =?us-ascii?Q?j5mfnllwVaQBJrNm6e3q1g5li8OKPqSBmnnasVMPII10ib6EghfHXW0G5HQY?=
 =?us-ascii?Q?ySPQSKHxHjw6q40rlx+gf+dANuVNehJmCXtuZXpUJdMmP+EIUqgzxb6VCOO4?=
 =?us-ascii?Q?huqMnBMxO12fXUPbUZJJD0l2Ak1uQMuRQOGEeM/72GR4xUqAk2QiDNbMwFRg?=
 =?us-ascii?Q?bAduHZMB+g18QwtSUdE/asiLjQsCFgNeas3Hi0odz30zlLKWQynBSyKpRTHu?=
 =?us-ascii?Q?/cOb0mjcvAPy4rvq9qZYaf+aDOYR7V7eptoufvVzr8+6duuA4JyQTst88Utp?=
 =?us-ascii?Q?z1iPcpzl9LC5ETCEgeAPL2MbhFehYfpBraRBHjvI7hVHOHYvS3P9zxnt1kYS?=
 =?us-ascii?Q?ijFSzS4g8mSpAgFVJLQL5D5x8h52okF9veT2mPwi6ujpzDz5zLdaQzPlghiy?=
 =?us-ascii?Q?mfEZlyS3cpXiErxXu3amBH6eKJpdJe5x8/QbUP77qwrsgQH8OdEgl4JdhMlz?=
 =?us-ascii?Q?5Q36tlBgyRwqOul418MZdf2i29zBbGyzCNUVjZsgm4TnJPi4m9Ywwr2KEwge?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d29c752c-5da9-4608-8a0b-08ddca83fbc7
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:30:37.2489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFTnbzkIwJAjmfaivlFChEW/niqBgmFXaShNvcwO3uKqZvrJNNowf6yR32p1f/BcuM+2auOg+LqKo39abTn8OEOEjgQuMWS3gpv5UHqR7Uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB2657

Store device channel index in netdev.dev_port.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - Add Fixes tag.

 drivers/net/can/kvaser_pciefd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 7153b9ea0d3d..8dcb1d1c67e4 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1028,6 +1028,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can->completed_tx_bytes = 0;
 		can->bec.txerr = 0;
 		can->bec.rxerr = 0;
+		can->can.dev->dev_port = i;
 
 		init_completion(&can->start_comp);
 		init_completion(&can->flush_comp);
-- 
2.49.0


