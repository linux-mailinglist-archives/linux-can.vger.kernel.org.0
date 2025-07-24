Return-Path: <linux-can+bounces-4073-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C05B100B8
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 08:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F047A189A833
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 06:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A270223336;
	Thu, 24 Jul 2025 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="LRmSEFGV"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2109.outbound.protection.outlook.com [40.107.22.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACC4205ABA;
	Thu, 24 Jul 2025 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339047; cv=fail; b=hm6UT1Wnnuywf79KuPhxux1OpMxX3/BRiSBP6TKFkJ/LsMoA8NoOk+mYdpCY62BttJTEkbItzm44J3kaOc/u3xSioRKA9YbhZNUiCz+JdaI/lXNkkatoaGNkzNm1XNp/Y0vedWc/VTvIuscLSsIbdPQlS9Qu9oM4edpvQRTW6JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339047; c=relaxed/simple;
	bh=a038doCfzkGLsxfsFMJbM/pzZ6xe62A8F9qSK842sz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S/e0MoYnr9PeTL1HTOnaPd7W/haVQ0xqwLxhZZYcNt7gMVmVN500scrm0u83qRA2+w9pxmHk6TEwmvSmVMzkHK5yov7ANrg1FMq8Dqb5D+jtpPsgCpaVQ7bColeWZ1BoaSq55JeRp06zBzx1C8O//bOB7I8CjY5DcAvivIDemIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=LRmSEFGV; arc=fail smtp.client-ip=40.107.22.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDX31eYxwL7+ha1sXiJz9zY1GawOzhLwb3Km4tMT7SBR4QNKUozxYSujim4CjiWJ+HwJHjFLtyrK5fuNZjze8I28AWjsD1cZWV4Z41oBq67EVd2bv8sterMJ+w9CKXA8uxZRBVtoUiERmJgdLRM1WWksNropWTOhEHUlaRNcy5YRJJUtiwQu0+U5vFhG1gOErkAvRvKa+ceRloVxDAlT5XsFjKTjfi/ajmCyHqV9Sb036Er+EwfKUBMvO9mlxrua3Pg4jW9PqHuFU0eoXGDXfL77G8599/ngi458GEzdHcCPvZRghJdFLQcM8++kRUxVj5aEbaqd3Ij3hTaDqDQxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3YUByUcz6uR4BT8awM6reP2nwhFn3fYXi6Q4gC+Qj4=;
 b=oGJh6yK66sCZq88uEL9nMORFhqGVTpydAQOQYNapFyE3+ID8RzOz7PO+Y/VLMV4murE7F6VLvfrQvE8827r0sihLRBgjvY2fMEyeE52qe4PGHWBztA2d77ZgI4O8Oc1dWbIwt+rgFZdPjAf8hSC9BFEfjr9ycS9RqPX4NAfQlQYKH2HFplSSxnpbnC/qNZqk5FLx/CZvCugFJwbO+Q73zQFLxGStmM5FfFPmj8L/QVpfU4Bf2DSDL3u6/PsjkOaap2R+FEHQB6BqAkUogKQ08cPkth2vInRX90d0wbPK9Qjx/ioA61ToskVe157d895xksCgkVE6NMu10H9AKTY0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3YUByUcz6uR4BT8awM6reP2nwhFn3fYXi6Q4gC+Qj4=;
 b=LRmSEFGVUIqUiIylbNYhDx5esOCIWvzDDr18gqfeFDmf8kEvfs88jnUiPvXQnG35nKXRXoS2vHZ29CBDwYdstVLAEdQx3RbH9XnAgronrQaQgwgwJFeD6QoeELBwOT58167ojsIGDrPRV7QESycfH485LthfSMrZ9V0eSdF1+DU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM0P193MB0562.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:163::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 06:37:16 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 06:37:16 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 02/10] can: kvaser_pciefd: Add support for ethtool set_phys_id()
Date: Thu, 24 Jul 2025 08:36:43 +0200
Message-ID: <20250724063651.8-3-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 85a26e38-08c1-478e-6fb8-08ddca7c87f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cRc+NNAvYUEgV6cbyp3m0GeaGVh19IPHD+F1pEyVWvTgxgnCuSdVwX65RD8E?=
 =?us-ascii?Q?BAq+ZJJlh8lD7wUoG1LMkXNiJBHOQpY14honwzKjwPFPXV3uv0xr6ymx8sbE?=
 =?us-ascii?Q?kAMoG5u21KgziI8qrIVVwaWnicRb8QRe5ztBbjb9GTZcBe6M0Z6yO5TZeESk?=
 =?us-ascii?Q?W2O8v9ZWxj6HqA6YDrIAInQQHR44isXcXIFHkujyRHfgTHso3T9uVQOLvJhN?=
 =?us-ascii?Q?nH4kYOfuc5WjkX+CKWK886DZN8tWT13H4MflD8MK7m2uArwtBc/Sjt25OEQM?=
 =?us-ascii?Q?JW4d4DKpfcHYtIbiI3f9bQl4geY/Edvoq7he1RfeykJw9XAP0b4E1zZ2jfef?=
 =?us-ascii?Q?f/pHPJhXhwimu73fkDJ5MyofKVdFJHZfLo99pnkBddtkgfPGx74VRj6B3GZw?=
 =?us-ascii?Q?7LnaqcBBPAekpNooLqkiOd1jjnr4rGxnjpkih2CGylFVXgI22Ythm8hBLkYD?=
 =?us-ascii?Q?l5SeVHG70XH+tg3EEv2WU1I6Da6khLxbudFUevwWeB/Ueu9RTRTU3toU4mEH?=
 =?us-ascii?Q?X2Z82GyF4rSKwcaGQ6gAh9jHsVitsphzzNiviNvSOlz3KBzWfGzvrB1wZd07?=
 =?us-ascii?Q?yjP1c14JU3yqfhpmQdpjQCXlPs9PPMq7DU6ltAuA8/CsvXQaQmBR3tpVvkt3?=
 =?us-ascii?Q?bHr7bJvhlaoNR5A99FTaPyIroVLazUnPAHJ/aV3oUKSQ6lgIqLTEEl3TPQ8X?=
 =?us-ascii?Q?ZJwQfF/HwPqtczxYLXGjKjvJR2nXXGn9v7TDbaFeuLKNTGhv65bt4c70VjsM?=
 =?us-ascii?Q?+Ec+BxDvYa+FTABhnHrf6sF2p+m1pdG09ljpFwatWY4tMUIOxM9YX+nEk/3y?=
 =?us-ascii?Q?F5VAgilJPJUZFtXm9YbhLU5pW5QCARA84hdI2FJCHQfd2nfcZjyuAMzMisax?=
 =?us-ascii?Q?v8FullbY/CKq6fBl69MEopypV6sUID0SM3kRGf5cLJe+wJ5ylrGZFd7mpXVw?=
 =?us-ascii?Q?EioJW8AKWOZafM2+7HbLbmKgsU0T/eu0BmJh+y7hsx6AdN6b2HS+MmLYtG2j?=
 =?us-ascii?Q?UVK+c4W0vBeuQZZ3kCr+g0HFRr6lFKywcwcYFFDYvWeN26QvyWqHLPJ1A7Py?=
 =?us-ascii?Q?LrfkQte6FwY/OUbsT0jgd39ICWmpbNNn7OWBqsKdOldxwMpxgYZulHROZlig?=
 =?us-ascii?Q?KcMvjbc40d8n6p25eg5I2SIMysseARqpM7jgPDj6+RPUeinjollVTxRV0WBj?=
 =?us-ascii?Q?pgwwZKAMI5bLE59PbeACFm4/6qYXY2YoYO2/PERlmAbqQRFuXCFxSSB3rlal?=
 =?us-ascii?Q?wgi78VlaIUh46XA9VGICFdrnZ/OW0h2hH/6fhKwV/zB/ct9S3MTySFybkNqf?=
 =?us-ascii?Q?6gS6liEOR37a7QhiUln07vTtYwn+hRej13aORbxpWBS8ud1T4vEHM6tKAQFm?=
 =?us-ascii?Q?IChtHsA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yz5vliM98mDZuDQu+idItoFpU5ko1tJNYA7UCNgyCS/pvZxYXaoPY/D7iseQ?=
 =?us-ascii?Q?Pp+hyd8GVTsfekjNzbk1UwNQi7E81+VL0kH4632kjbqoARMYPc4MK28Vm2lZ?=
 =?us-ascii?Q?1TS/dYQGtQI8Co+vtex6zENw2JTjG8uoSu75e5VR5PNLGfp+LjSIgDJHRu3S?=
 =?us-ascii?Q?dKHif5FAsfNUW8vIK/mTHVZMgQ0R4W4rBhA9017baUR/YkNgIsFhxp8p4U9+?=
 =?us-ascii?Q?WZ2hbZrOpm20HexVkcvmDqGKzXtPJ/qEidETkk03rsmb425zt+JU8LOt7NV+?=
 =?us-ascii?Q?yTYeGgetCvPDDmxVuTy8chUAgzfBWmds8m8uSV7njg15bWL2zRCwEr4DGdBi?=
 =?us-ascii?Q?0vgO2MPhG5X2q3FXJjMe3BiYrTR62ziIB/GDSAvWN5rD11vMhJr2YaR/OxhK?=
 =?us-ascii?Q?wrCPZCbj6j1n1aBwyIcT+YcFMhBpWs5GcekeOuOKYI/DcZTXmmeA9eW9j/fg?=
 =?us-ascii?Q?s4fHF8Dbhm2yvUK7sX89/JCKjUag7N6TDY+eH8ogwRQw+tBFoWmrHpHSP1LP?=
 =?us-ascii?Q?nPTjfQt/Swn+7s/g5HFNNSXvd1gaSExlbGFtTTT0Yi46CJjR1564aFxPsatG?=
 =?us-ascii?Q?R1qK6c9H4si/LWiNCKOSZYjS6cnaMaFbkcETjuev3M7LB8gCWDhcZsReKUYt?=
 =?us-ascii?Q?rWRCvPC4ZJXMwiTIcu+zrFb6MBYq++PjzmzHBH6kEDE6mLZu8qZwafWUwIZk?=
 =?us-ascii?Q?tKCG8i6e42fZxpnvxNcESoraNUVYdQyiFK4YBGJmL4blDQKA1A4ahVanWa8D?=
 =?us-ascii?Q?kZ/A6gcm83Jy3aZtEZJge3RIcMj3VxzBeyy5SR6JjY/d+Q99NQ2oOthPIq9+?=
 =?us-ascii?Q?IdumC0LnHs0d/GblRev/BcCVkOs5mgHTx3ncOLTg+GXpiFKJJiJ7P7STBIH1?=
 =?us-ascii?Q?cAxYc4AhpwlBw4sY/Ae2G+42EKNUdxVIqNX2D/N5a0lSkSGJLlPfQUmbbA7z?=
 =?us-ascii?Q?R1x1vEhIKylvgJaygkKQMsio6BUhmdHs7XqlDGZWTKq/wtbvwtOH/xJG+9wa?=
 =?us-ascii?Q?1l5AINCM0u9M9O/H/2lh9HsZ5LF8p36I0T3xAw32VI+9D9P0cJtLGoLBlwER?=
 =?us-ascii?Q?ryzoAEZnBlsM+QRSEyOxOhybYTVNNK+a2O42/iH8T7/ZXQl801aPbzYCQ1jm?=
 =?us-ascii?Q?sIb5LFFntqc/aXbThmHBFYlV7rYdmTXqjJIRtBQ8uXQuGBFXDxUbdM7MEp/2?=
 =?us-ascii?Q?AE/0/Kz9a2PJ/xpMe/WWN4sr3mtM2UX95H3rCW1uxyA1u6Rt4Fb7xXDYAi2G?=
 =?us-ascii?Q?7KXZEkyTVzbjU+vq0BNC37TY6/ZHeqEXSNpiK0si9niK6E0pJjJETJ+odjz/?=
 =?us-ascii?Q?JEj9VvWscziLaKFmAVP2+GUkzjiEA68bMTZxkFdJSKBCDr74XY+chAaJCb4b?=
 =?us-ascii?Q?tdJJlR8dxhPhQlO/WvWwLtWzDyvMo2zBE6kdTWg7+bcp1DiB/AYmAXnV057S?=
 =?us-ascii?Q?HFaoIuP6yXLFy/cGj764FQgSH2+hvw1jj4tVgyuVV71FDS+A/iZ7SJCwR1Ge?=
 =?us-ascii?Q?RHSoQgnn+g1+Jsd9D1mZXPeSQRnb5Ayy++E3U+dkoTjgp7bk1Hj9iH8o1kRR?=
 =?us-ascii?Q?7eTWoEb+PVs9gPyjHyvlwwEd+32I88QTYnYg+nIG7pECmWP8rJ39IPzoQPNp?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a26e38-08c1-478e-6fb8-08ddca7c87f5
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 06:37:16.6671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPtEAIRlEEbXVtKg8JHxFO7hg5Cdil58LrkqYFGpEKI5xZu5GsyZ8aC0c6oojEwAR4Q4OcltKakeHOGXTqh4EYuRjGXnCEHjMD6Hcf7ior8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0562

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


