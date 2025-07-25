Return-Path: <linux-can+bounces-4135-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EC9B11EB0
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5614C1C26715
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA312EBBA2;
	Fri, 25 Jul 2025 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="eX1iZO4X"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2109.outbound.protection.outlook.com [40.107.20.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FFA1A38F9;
	Fri, 25 Jul 2025 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446906; cv=fail; b=rDBWyCvWHxfawMg0bli0RAv8wUobIwRLwOIwfjUXURqETAmBtejxZD//ppobNibqUYsVrWbpkdcSBWzrn4inFxSBLw8hXSeaZUUD79wYqMW/c4zIOanfN89lXsdW2T9nHSq1QSD/2o/cAYDGNzjEOlyW05nLrLRGd9P64zzF/wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446906; c=relaxed/simple;
	bh=83WjNu7bt6YxBM4S3pKvsWabPIYdmftjJs67iKHFUPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dr/K/7vSaykXJ5MxHmZ13eTkU8OGXofdMgJoRkNcBbMUcDIKeEFLbyZ7yhMwdMJdYRAaudFpLZCeyn7y4J7mqO/Tku0izPu5cWthoGHjQmBv0Hk7Q50LBiwng3CxV2ykqcl+Y06P058zPD2jwxIr6eaf6gavKhAwxChC8aszBBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=eX1iZO4X; arc=fail smtp.client-ip=40.107.20.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWQHOtGcgI/0TH9SaEKhwOQm7jxHWPfeoPyY16eG8nRuJhela0Ec8FDy8EiyTDlqtyDeUcv5t0GBYTtbYdQZm/bQ96Nh4h/A6oLPg/ls80UhsrqaoGxW2QqnNo2/SaX/UUN2bhJRqD/aEI3k9BwOFQWsw5Q4sFO8d4FlLwQatl4zNTf25q1XDeKp4/2UaD7b5ZnthhqdME7JDgNyRyRqenQ7C7+ATCt8ojs1uPspUEgaFP5UdgGVLT+6uiPltRbnxw24FY6VFLBl4mVsdNiS5AGsKKmlkIbHltjMBm6pynQ/e+c3VxbZLDcDRDNk4ZeMQEZddh+suTd0ugDXUNqCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQiCSfPG/qOdSoN+5xCOjVn56YhW237gjMF6lM2D5Sw=;
 b=OyoFlGY8Kkv/83uRZZdaELgvA8MqWIkt/m5PbK7LS7TJv5vRs8nLyI2iMTp9Kk3sAkPW8RUN6hm5Sz2V126kbAkDu3pj5KIaXRfzXssrKDXbkpqpoAnKwIadSA4FjuiQmIAVhEWKYtpBpYgo/rs8vdvhXAK8vke+v11E3Lg9IMhnGRKBbDYp/jTreS3ZIxJRk6qEr3urhYo+sMCOl1pgEoZqUmDkhpNfz9IsqQej3qBQ+NXsBL4crkLnOd63uCijETiVTC6ZfvsL5fYIWV2uYYK7uaCu9NqyMEYmA4Vnq7YYiFqi+PWGcZuR4mZ3dMMg6EAokbZ/ICoU97fNVI4sCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQiCSfPG/qOdSoN+5xCOjVn56YhW237gjMF6lM2D5Sw=;
 b=eX1iZO4X0Awr5jc8uuYo6Evh+hGpO0mfQhRfQdQPUmJUfIFAqArxzQNhBWXIspSAhXS9gooFkQj7oGlFkR7T2WM1HLvZp84N+5dsG+S/U+PPn91fCfQGU5Yc2WVE6O+cFNb1nA6K10Uhf9wLuS8xCtCrb3yu1c31kTCz9NgjLwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB1219.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:36a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 12:35:02 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:35:02 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v3 02/11] can: kvaser_usb: Add support for ethtool set_phys_id()
Date: Fri, 25 Jul 2025 14:34:43 +0200
Message-ID: <20250725123452.41-3-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725123452.41-1-extja@kvaser.com>
References: <20250725123452.41-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::33) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM8P193MB1219:EE_
X-MS-Office365-Filtering-Correlation-Id: 7132db1e-41ac-4e02-eb8f-08ddcb77ad02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2mEXFuQuLJUbDStiiJ35kJ2d54FTT5Q6eb6rAta3E0q3H3fQFIkZW5obo+pc?=
 =?us-ascii?Q?l1BLw0EMIxld3HEZD4DH4RbOcPKt1yQdXFzCx9BnwI4n8MbY2p5oeAQYYRAa?=
 =?us-ascii?Q?UqK3vSTeAl4sC/ALTyJr6DR1L7yShF0HrZ2aJ3Igb4Q8KSj/HYIfa+ecLQPe?=
 =?us-ascii?Q?aLiTOOD2C89i44c7b+woohpM01LvJ/h3Jkk7U4lxiXDlnkGgqv0H22juHoF5?=
 =?us-ascii?Q?66585w1AJ4TdBzEOltX38MUYyDbVDb4NM0gxsluQTo75fMEH8FnsEAQoUQgE?=
 =?us-ascii?Q?I9lYzaonp0chdAz4izdvI+14WgXvy7BG136FskQtON1Tf8s+OKZvdkkqelRs?=
 =?us-ascii?Q?rJQSy1T2zxUx+HkrHMY7BiN56XZZUcnT3wBAOxL7SSh+8f95GxLsmnAuVRIh?=
 =?us-ascii?Q?p95zmpSUR0DaaoJCTKH5NtW2J/ygJQjyFG1YBd2Ezxd+kynpybfT95lore6h?=
 =?us-ascii?Q?NhvXf5mPbmgUXLqt+Gz0J9gDNMyBZYwrjr24h+8fP/e8h6F0oV4fDIQ+2TyW?=
 =?us-ascii?Q?iYrU75gsDaHVenJ2rI34qAHSf2fvOVHcT5UcEDibtiTfTtXRd7qlkHfbvR8p?=
 =?us-ascii?Q?HN29/TiBc/kZxyeXgWgonzd2y8w/lnnuw79YvvlI6q0Io0KgfvhP6Cjjn53Z?=
 =?us-ascii?Q?AOdCJWLFB3FBCb9znF6dfW6XDXAm7XsMj4dl0O7SNwmqd9Jzp2fvF/WJ3tqX?=
 =?us-ascii?Q?CHGHmhTbVI6TuwDf0wDHbO9BvTbQpjd/gr3X+3S5NXXICKJGZ9q50cB1O2FV?=
 =?us-ascii?Q?aQJAPR1d608XECEOgPwK2dU2IhDUA3HnNz9SLnzb8RKOIxDnslat/NXcLxj2?=
 =?us-ascii?Q?isy7WExNyGR0RYl98h3QQlnOJbX082sk+R6jbSTk/6aWciZMAh14jXaTzlIx?=
 =?us-ascii?Q?InAgqqbp/MYoSaBFAjnFEABG4xGTSCda2SoUKpETuQg47I4wYncYmmRIcGGw?=
 =?us-ascii?Q?Xasae9UR2rqzuvuQ0H44Ktyad1cgvTbZBzP6099lRZlgMqXz02+f1lpZBsX0?=
 =?us-ascii?Q?ZGSJKVw+UjcDlrAqntbXImn4F8td29Q104XDfWoTL8+PZ/al3Fcyi+L2uaGp?=
 =?us-ascii?Q?i1keMIJlMyiAMgxYjYNlQ49G4CHYPJmUh+WWy/gCFCNUAlN7t3bAqUuv6S1O?=
 =?us-ascii?Q?aw4me9sUOWe3m1BD9bBvBYBEXrjhrY4YLy7xohxzfDNjvcV5/eCx468Xt6wj?=
 =?us-ascii?Q?HQOMJhVM+8ftdmjb/IN/Ox0dT+E10RKve0AM6OmxC1oc0vwVtpKNAWJGq7vk?=
 =?us-ascii?Q?irF6FXm6SICifcZ/Fg5iEeUlJuBFuFXp47c0V5n9e1iaDds5erUhaElgsa9g?=
 =?us-ascii?Q?Ba/NfOYZ5kiIjxmBLhRvU84ahkwii/H982Rg8VtIsRwrJCbwL1jqw4ZnDQE7?=
 =?us-ascii?Q?3R5XX9g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ZQXdz4vdb9ITWW9F3iKkT8HmLvpD2ewIkh8VTz3wNwMCIvBZ2CRotesZnHl?=
 =?us-ascii?Q?F7PxTzxw4E4EIEUStk4EAGvpQu7rODyiUfalqHHDzh1KJE0yXEv0ghj6LQEo?=
 =?us-ascii?Q?/IYsqiRXK89m7kG3y1rpefsJq9usf5oL+1EO1EMpM0cz69idS+4UdeF94P2O?=
 =?us-ascii?Q?48FL67QAK0L2xx8eGP72K9KPD+92LeiX8HlojcE/mCtvEi+mNiOEN6PyiwYH?=
 =?us-ascii?Q?cfa3enmNiJwzlDlwFDSOh+Q0KLA7sqTxAmHDPwvFRoPvzcb1Mz58Uoqp0gMX?=
 =?us-ascii?Q?veVnzvEuVWCYzaiuC6uzBp2xfFcGB7S6dUS0EeKmQ2LJvW6UPUsZ8J48hXme?=
 =?us-ascii?Q?xWi4SN7cHVAFCpcQihX8ow3XeNavcIyLAAWC8wDyc0eX8MOqqh32ZPwlJlQk?=
 =?us-ascii?Q?ZUxVZIYy6rOGrjpYgygtcrr81XFn0h1IPpnTNjsxztcunS0EYZR8W4/cuM1a?=
 =?us-ascii?Q?g5ugSeYXtklZLMaJVi1CAERlxG0C1B9O/zUwjX42Pr5uJ6IW/0V1LjcC3nt0?=
 =?us-ascii?Q?oEcb+tDEmgjxfOXQfTtr/lkaW0NFp/cVu8q7Pnho+J1Q44VwmGjQ5crkyiyW?=
 =?us-ascii?Q?TyWQoEw3QLjirT/5og8feAkUAt9XAOZKJNLb9CvM+5Y1QsSNa+4YO6P1NneP?=
 =?us-ascii?Q?3drPZLHeqOQaWhSYqUZJjHV2daTcTzH4dsl/Um54BfWetqV4qEWrdq+BBPKA?=
 =?us-ascii?Q?jK4GxlX+PopwvTUg03U61tHnfNAhGvi8czzgClCuvRyBS/X+O5Sj/cj7Mexs?=
 =?us-ascii?Q?ICDV1mXhx2pm+kewmIw/nPSObQLJKk+FKb2zI7qefcMouc91oKMWIwb0wM3N?=
 =?us-ascii?Q?zJIgZCUiZfFzReTPAsL6dxAwkYW010EF4xylkkQ9jOqbALzLil/R7p7Cp6se?=
 =?us-ascii?Q?F9UOB946Hx7A+CBiSRcw919+jpYNabdTypKbruA4EOtz0JtVv72Uszgh0E3H?=
 =?us-ascii?Q?E6aMeCErGohNwPvsL8xwl+m25Nuva2UUWra4QxnEq/y4kxl8gQC7xD4CEo1g?=
 =?us-ascii?Q?fmSKyg5UxgDaTmLARAsHu6BWX3gFVbsaZi2MMSCvH1aHhgmnffeVrlx0qWI1?=
 =?us-ascii?Q?o2l/avbU0QEA7Qe4/d3XFf7CK1YUalzJfltRIk+XnLTlhPdbJYe8xlcvMhLd?=
 =?us-ascii?Q?F1oFnkcZ8eD8ZCFtKuPBoqviNAh+EWGzWT06ovLbHxctTfyAwPpnlMtGZ6O9?=
 =?us-ascii?Q?gplT4B0B6FSmOIaaQqvk3Nv1EgUoDg4CdKB9A5YgtvAEcTuE2HU2z3vATg5y?=
 =?us-ascii?Q?Pw58OyvfxbhSeITL21t88mcPp5jZzUO9gNPeO7RK5wESOp4dHqpFomr46OpO?=
 =?us-ascii?Q?aaNk/pjK7SQrcl2Mie0DdtunlPzgBwGdPaQ8L4cmudGsSKaeNtE0Gxv/BUlB?=
 =?us-ascii?Q?J+WFdguS9XTO1LBbZOKodB12D6YXe9A6vIQ8b8bPehaZIR/c+gg1Qv+jndDd?=
 =?us-ascii?Q?zGCys7lFgl0m5qUGGalrDme6JFcoarxUe6WAs9bQdHp0Phg0G2iOHvGv4KzT?=
 =?us-ascii?Q?62vu8Y7mwlSdOKYB+hn8IsrBhu0wC+0Kb64pqvB7J7yaSp3PmD7+ZJ8eLtKS?=
 =?us-ascii?Q?+WUkItNL8XzTsB8qx2L9Q+PVwiFfAfj5JPKOL/6Ujff77aUHm42mgW6nduNy?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7132db1e-41ac-4e02-eb8f-08ddcb77ad02
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:35:02.3076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJIilBRgIieN5c9NXgxViAo1MrX2Wt/f/7nHKQRHnzTFdDlZQS1Z5czTyUxFNXileKdpc8UW0gQQV1wC5zuPnyaF0G+qRqXKUhs+5KPHbRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1219

Add support for ethtool set_phys_id(), to physically locate devices by
flashing a LED on the device.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v3:
  - Add tag Reviewed-by Vincent Mailhol

Changes in v2:
  - Return inside the switch-case. Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#md10566c624e75c59ec735fed16d5ec4cbdb38430

 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index daf42080f942..c74875f978c4 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -753,6 +753,31 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 	return ret;
 }
 
+static int kvaser_usb_set_phys_id(struct net_device *netdev,
+				  enum ethtool_phys_id_state state)
+{
+	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
+	const struct kvaser_usb_dev_ops *ops = priv->dev->driver_info->ops;
+
+	switch (state) {
+	case ETHTOOL_ID_ACTIVE:
+		return 3; /* 3 On/Off cycles per second */
+
+	case ETHTOOL_ID_ON:
+		return ops->dev_set_led(priv, KVASER_USB_LED_ON, 1000);
+
+	case ETHTOOL_ID_OFF:
+		return ops->dev_set_led(priv, KVASER_USB_LED_OFF, 1000);
+
+	case ETHTOOL_ID_INACTIVE:
+		/* Turn LED off and restore standard function after 1ms */
+		return ops->dev_set_led(priv, KVASER_USB_LED_OFF, 1);
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct net_device_ops kvaser_usb_netdev_ops = {
 	.ndo_open = kvaser_usb_open,
 	.ndo_stop = kvaser_usb_close,
@@ -763,6 +788,7 @@ static const struct net_device_ops kvaser_usb_netdev_ops = {
 
 static const struct ethtool_ops kvaser_usb_ethtool_ops = {
 	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
+	.set_phys_id = kvaser_usb_set_phys_id,
 };
 
 static void kvaser_usb_remove_interfaces(struct kvaser_usb *dev)
-- 
2.49.0


