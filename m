Return-Path: <linux-can+bounces-4101-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5C2B10627
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 11:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A95F5A2A70
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1AA285CA6;
	Thu, 24 Jul 2025 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="RP5wf3AE"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2132.outbound.protection.outlook.com [40.107.103.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD31425A2A1;
	Thu, 24 Jul 2025 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349134; cv=fail; b=AZLECrhCaQl3ybTEXFiX44cciuJ1shSIZCBj0DULqkapllRqJ17onlhy1KRaj+Qc82at+EBqRXt0Xbq5NDpA5eoCSNANwox4DafRN1jh+EmuCnLLlSagSsEz9Jh6xVN5SuiMl3OAwTPUqKPUyxcCIK+0WIB9ybHNctfGTj2w0VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349134; c=relaxed/simple;
	bh=5p2OmlpXFfJqv8FzyebZkNS0ZuaIl5p1VQ5EgVfFVhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ENjKYaxYfhpq810/QTOEVfm43LN148pL2v2ATIus979kd53Cv3fTn2A7vw6+CnqCNqrog+urhw8/PwP67gi0Cf5MIdrNjvlk26U+gNNITaTwgWlf0kzO+yBTd/3CYEnTBzOrDnI0FnA2yXYjT3pFH5TF118OBy97+Iy+gJFLKvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=RP5wf3AE; arc=fail smtp.client-ip=40.107.103.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdzlPSVEgt0MFey0yIfwNnVRKAYzAQ2vdclHKG7L5ZQl1+lmJzSxISAj0qM/ZnQhxJt1LOx09sCaVbfMXTpogDjWGa52fKhqU3x+x2khCAyJWAXQ+o8mL8Je8DLm6TstqAFejz0FPwnDHm7YLbgbupprHRok/3R+YQXp8S5TbxZaV5E6WQLYCTbnYonPMguF4JnJV+SbVRjI3mTkFaOAh1ljOktpWh5cLQX6IRk9xjeil8i1tmhOJynWmfxQNCpZX2T5DhSzR+RAgkUw72uwdauMjb9fUxoE8WNnwtHYCc4HYT4+7fIs5XCM5AXgPtn4RvJLvkYIcIckGJKgPg4J9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mqbuPlNqJsiVHrTDOy1yKaj60YsDB2TK5ugJGqwROM=;
 b=EA2ew+hpu1skriEI6GbKxFdR95PGtDoPrfPRqP/ucmbpSHqBLebV2LDgheTTL2smJQKCf3/IMWyMbpS6sETCtLrfAfXY0t/ukT8VsFE01P9ePNRe5o8A6lGAnuh5jrHgdcrHrOhGMIdGisEdkV6GTeIbpdHBcd5sQXXWTHGHainVKUwSQlJtftgEAnqPLI7GcVghBE4UFVW3de98A94OzHTHErBzP59UPp30XNtka4poviLMkoO3T+rVuF7+o15Jfmka+vxQG4yIZFXhfrFp+mpHE8s4zV1Td+qM1VKcZ7SOaGnqH+bFYiIHncW7+te/1iF6WUVwQfAA+qkEb0uMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mqbuPlNqJsiVHrTDOy1yKaj60YsDB2TK5ugJGqwROM=;
 b=RP5wf3AEFubTGlzNaPXA6RmT2RCGKt6m9ouTrqXagn0W/mR1qQIACGwGo3NNhprUrpY6N4VPHnG9RhJwO1RaeY0RzFBuJD7p/qZgbhHMbp2WX754ACodRAVnMqtZTeUPsiqO/NqiG536GpBFje7X3gzP7HkX6MnrsKpmvgQujVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB9P193MB1433.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 09:25:23 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 09:25:23 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 02/11] can: kvaser_usb: Add support for ethtool set_phys_id()
Date: Thu, 24 Jul 2025 11:24:56 +0200
Message-ID: <20250724092505.8-3-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724092505.8-1-extja@kvaser.com>
References: <20250724092505.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0060.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::21) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB9P193MB1433:EE_
X-MS-Office365-Filtering-Correlation-Id: e92c3ec3-0057-40aa-a5ea-08ddca94047e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kMz18q86YO7esVKNS98reoh0pfYF9Se6jlfAzLFFd5YSYjWZyJWlgDPOAFNh?=
 =?us-ascii?Q?VtFDSVO1LBFxai985wFALuflqlYRZzPtUSPNRuM13NzAbQ4o+PXaqayKoxQk?=
 =?us-ascii?Q?CN27KGM6jHwjASjyowFpH+fvoZIJ7WitjJfUpEudLwqLiD8v8WSDY1A5pTXy?=
 =?us-ascii?Q?cXyDzA2QpodhT+Soy4mRTfZ3TLVn45mtPJ5xf/O5zDTHY2MC5Ey1hloTbA3C?=
 =?us-ascii?Q?th+aiNCnazjWUN6ZH9dvUmyU+r5CD2QlVOfmSZwp8bPXQaluviepfHFwR7e1?=
 =?us-ascii?Q?v6qJ+LmxR7dBiFiRK6e0NN7PqYMBAerEnNf/9+/s32YgG+GS0cIvTgqGmy1v?=
 =?us-ascii?Q?kxIfdekEEy7BnaEWLb4H5FNZtsFSpjuRnStXDSB6Xd5Of7JlX9LFTIuLTIA1?=
 =?us-ascii?Q?mnGIcX1W4uujphacOc+kGZpvs5OK/iWU2UC76JaVQbd+1b3SORx23xW6IdFs?=
 =?us-ascii?Q?8e3gJmOIH41wJzYEgYeovQub+NSXjhjYcAvCVwbs4gxnFV44LawLpsyAWWIL?=
 =?us-ascii?Q?mJLD6h2Z/rpXyYDnzoLX9BH1ZC6g4bCtBOp5l06NC0FniePGJaFBIUPPElzc?=
 =?us-ascii?Q?jYPtnnwi/DGqGgI3m42bZ+W48CocG7s9AH+Mr3yu09obQdqcwBsKzVArylRo?=
 =?us-ascii?Q?G51VFjnId2Hhp0rPfJYDCMnkJBEL6WEvQz/3e8c+WD2AGFGPhBMxSFku8X58?=
 =?us-ascii?Q?yakYuLJHaV8af9JhaCg7dq6+puqeRpiNIuxlgokTQqv/8OEo40oGc61i96vp?=
 =?us-ascii?Q?6qReLa1XtU9k8E2yhzxyxIS2ERcIpF2N16bPiNTg3TDiOrrxoRon5zfZPlW4?=
 =?us-ascii?Q?BdpVnrQPnVCdOpVNKc+l1QL5EFej89YPAh2pK5iYJPjldOPsOszKEqP0s2TA?=
 =?us-ascii?Q?OfAgX36M3FwkvGYjJhUPAHbioBWf6zI53L4Wu2R7U4zVcnU+T+o5/lQIyyKa?=
 =?us-ascii?Q?lsK0PRwDApD4cXSTgqgG/snKV30LontQxIoCH3uPhPII3xYQzxmqoLgStyV6?=
 =?us-ascii?Q?V5kflZLDrfivXqYREX8ZamotRiLHrrlcO6GrBzmAlViELRu++uiQ+oHlFSnl?=
 =?us-ascii?Q?jr0wFnVQS6eoRwiUzKVtnMn1rfzbnbq7GQA28x/lLTpGuqnz/k7tShPhO2U4?=
 =?us-ascii?Q?/UH9d1imFAOljYP+NkJnaz0Vhh8lqfirtEhhYKUi8jzuhHmWuskBzQO0d/JS?=
 =?us-ascii?Q?aNyqbCcMOix79q0rzDvPsOnsNBthK+LPE7PbQRIdQhfu63xvZoHJzEiVy2fZ?=
 =?us-ascii?Q?dmhvBJCBHuDgvOhQPm3Sc5/NMKBTF/PX1h4lW4SNHDqnwMwcftTJh8m2mDEV?=
 =?us-ascii?Q?ZvrmvGsRo7AmzEpVNcGAqM9trjIcUwNEkIH3y44ujcPhWj++YAtXit2Qqv5E?=
 =?us-ascii?Q?lzs3e4o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bkOwQ9hn08YLNXh3qJQielmBfJ8KrjMESa3U8EUgZdrH044F7JaS4e2j8FxT?=
 =?us-ascii?Q?AVUenb/q4cJOwoYpilyCmaNNht3rvZsMuzB536AKrFwJ/gxS6kKR6GJGkk05?=
 =?us-ascii?Q?uiXlO9GMSvTk91TMsXrPR7CjaanpAOxcenHSfr0nS0pU+nbLXXHUtu4bp++V?=
 =?us-ascii?Q?05n1tCZ4hVwYzsa1VnPGVTkmoMQCNH8D5KXMO0TqhUEETgFh/JPMLMuzXdyI?=
 =?us-ascii?Q?lLVQLifO44HP90ffmnE2VUbTWqYE2VcemO0QYWm44CmCvLzRE3+OxTHHCVVX?=
 =?us-ascii?Q?bVcUOMiiQjAX4slZEr9HJV9pMikwH0tHZJI2s5eTdqJV9u23qXoDNxepqBJF?=
 =?us-ascii?Q?GD/NbHe1q5rcoG5tiN88l/DNL0kuXUW4NoSENi8/P4MykOIL4MQSgwuholS8?=
 =?us-ascii?Q?bTn1UjVrdPDxDmpVcI8UadXPTjbxywQz7sGzc9nMO4U3p+bTiwdg55LKjVLQ?=
 =?us-ascii?Q?FY5cVGAlCQbqIPFt/ERd9BQ4iZAZ1j1bzNXjZuWyrezLfjvF6WHYiuFHcB7Q?=
 =?us-ascii?Q?KbdcJYITjHBSASJYasqPnia4isrCxNb6rd27KXRTQZ6EaRapx4rG8Icl+gxg?=
 =?us-ascii?Q?Abjz+eipk3Z87zPt9s1DGaNYRKugNpCvCV9I8c2xe0UJ+tWxsFZBn+ivRdKi?=
 =?us-ascii?Q?yeGpwmSlX60SNfekmGRykJTuLWQTK8uH0VLKkD8HCHpIbzJyMO1v+ukRunTz?=
 =?us-ascii?Q?rJCR+UWvjgeEsIS/B/eFMWKtSfyxfCrt7/VU1ak2To51hatvPYKzC2PNn6O5?=
 =?us-ascii?Q?FaLRCiyyqW42X2Uz7VMHTbq/MeOr6XuCekj7S1IU8yCrwn/9yMK4zBNd34kd?=
 =?us-ascii?Q?0z5CGXNDYkn6svO4ywuGP4+NibDmKiqpLYgvZoYgTmxgcLIJxi+ZyVXkrc/1?=
 =?us-ascii?Q?5xJGlgBSgKx03qGoKeOVwbDVOZEjd8KWoZF+/FUCr7HNJqisflSCpdWnlxpV?=
 =?us-ascii?Q?sp3k8Ue5XE3Q85pV5n7l+6nrJ5J9jX9If/WyXmcNSlQVwQM+X3lUXVyOmGLD?=
 =?us-ascii?Q?NILjNP9ETMh5waZG6L2RXthAP+EebWrwnJZeSpoieyQxelzUfPh8li52BL4Q?=
 =?us-ascii?Q?o6Z6QEEvVlLAKgIp55XHHEzf9B8zlhpAhFMQ23YI25W71c3kvoW01hE50cH3?=
 =?us-ascii?Q?AhA9x8B2lHUB6qj0vLHcd60U2/0+TVi0v5m21wh+QZBzy61XGy7DsWN8jiN0?=
 =?us-ascii?Q?Hn+OxNiP9V/j0MkznPKwjOJysHOPOBn3glcR7x3awwHVd3YiOjqzaVbyONlG?=
 =?us-ascii?Q?vIuIlV07NSlQ0fLg5JKkkxhC14wDDuM5Y5a4MkgDRv7Rltbu55M4zscimuLE?=
 =?us-ascii?Q?h/tmZRxzXI78L2Sd1XoUwwk+30E4fhKw/t0xja9WC6O8Z6xbj7LFGKRYZtHp?=
 =?us-ascii?Q?HrzhHzbpBXKYKOTVCPg0r1pydl526RXsZmuJA9ZVb6FbsX6fux5whM1Trl4w?=
 =?us-ascii?Q?ovEXjAGMkDQhKqj4ifDXCcUh5ZUSN4F0IUM2ka3gm6W8rPUiN+TyExqg53re?=
 =?us-ascii?Q?AtN/Gx4A9isKWqx2XvTvClyaiKOdCioR3+qEzQrMOYuy3werYtfwjSh5HDq9?=
 =?us-ascii?Q?Ef1jZEJLcBIYBy83isNyCaWPWeALqab8CLw87ciAEOFXYJoBeN9eq+MdOiJX?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92c3ec3-0057-40aa-a5ea-08ddca94047e
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 09:25:23.8764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqXfJD3Gnp5TXT5txTIukG3yfTf1GHSRYvX/jW8mEBsf9NXMXEliynmGHkqo3gPMUmxikpmqUmPAFWVceu+xMxAO2K/abJ/AeGxv/MP5pUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1433

Add support for ethtool set_phys_id(), to physically locate devices by
flashing a LED on the device.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
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


