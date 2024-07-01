Return-Path: <linux-can+bounces-926-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C9691E49A
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 17:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B8A1C21D43
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 15:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694CF16D32E;
	Mon,  1 Jul 2024 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="ONiH9yc+"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2097.outbound.protection.outlook.com [40.107.20.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615AD2C6A3
	for <linux-can@vger.kernel.org>; Mon,  1 Jul 2024 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849013; cv=fail; b=XFMi43RcBt6pNAGrCaSR2Bo6hhxjzdoEPUfTSOQceOz18L5w0FJIeuASZ/irj7Xi3ANEjnkmQRI314GaGBU7JnxH3MpS+2OZoD5kQlwVEbmZE0uDPs1euYZBZ3rnANLHQi8VyzpLpOUGKJIFA2cth/b3HTWUkAdNnDd4KVy4Ohc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849013; c=relaxed/simple;
	bh=uDec/tLd0ynK0DCk6kYvnTfaYWOifdit1ntEl6tijyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SknqXgm/0H+5E29wvJt6PsGDNKbKmTfWDmxPmU/yygSPOwkkvuUbYorSCwE9nYGPlODjK9pprnX2tjGO0l0SrV0KMKTpG+AlolZWOSdxq0esjFiEJ/wRktkJMN4IAD+lRIuj/55qAIHTDYD5yUc8Semqut/XZsfr8CXlmI8t6kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=ONiH9yc+; arc=fail smtp.client-ip=40.107.20.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGgmov0jm4JZ9cnQj3NaqEbNTDGYZ65SU3s+hRl3fM7rjGPHUlII2O4eQWZ15wb40CP9tj7+tNM/wE2HK/M5eH7dSEr8M2leorMbYujZAKg7R7rIzyLuhbzYxXDZr9AWXeMFocbU0dMhw+3t4le1YmRVF8BFTUvCBQtgdUJ2L8OPtC6nG+KnccNjDs3zum2dAfX/EfIxniE+Bw5dx0bC82LXU7rQSo0o9TaooGiimIFWah4kfvYulqpFMzY02KAyMokosJBTv26tS3GnJqurnEZy9MHGJ1yD7VZjcGwphSwhQHcdGP8LUSm2oB1lOEY8yENnIDdtyKj+FBFlp5ZKNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuuDp/d3k2IYaO156QFV5Lt4rM645//DTYtH1YVIPxo=;
 b=Udgs4aISOX41u/AydZzRW4+gMjQFKp+WBElVpI4Gd+y8ympSP8RN3YLkAhn9kPCv2U9fAc1n7V8S+YD1P9Z1p294ByiYCU8v6rF7ooeB/nj051T+Z6/yGPx2iZi+9TwLzS3rI8SodVlSOurv+a/gH3zxNzUcaSIrZk6ECiUDT+PSbLE+8Gu8v4wGpXbCEzGceiPj3gMp0whfZT1zdhhXdYaBZV0hxxHmawSFR0gMXJO/Tu6ZeX0gelBvDLyjCVTiv4nT2d9luevHOUvINjNCS7e27ZaZrmjJApKe/WZfoTvrVxh52fEiDKaaJM3YQT5qs0FBxngJkQVEoSruVecWHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuuDp/d3k2IYaO156QFV5Lt4rM645//DTYtH1YVIPxo=;
 b=ONiH9yc+3nmsjIqL55SITozKiJk0doZRUsr1ZcokkC2jsg5ZnVCDr6AWIUvnjsXMG0ur79nS0JiJLnfsnDwzXnQ8nuozILOqtBtVmH1XE6pylfGD8q18+GQjjHhMx6uOpgmH+umV4ijwAJyliGdW0Cgiy+HoVekbJ4x8IjV+xT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0519.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:50:00 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 15:50:00 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v2 04/15] can: kvaser_usb: hydra: Set hardware timestamp on transmitted packets
Date: Mon,  1 Jul 2024 17:49:25 +0200
Message-ID: <20240701154936.92633-5-extja@kvaser.com>
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
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB8P193MB0519:EE_
X-MS-Office365-Filtering-Correlation-Id: 6387b7aa-5fb8-401a-1329-08dc99e57705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xYyGQ1icYcWCACIjMW1kcpP9F7QJK6LquP9+Alun4G4bZFHdfazvuOLgYXtt?=
 =?us-ascii?Q?RWWXIJ5PKwvT7P8Aj0zqFQYARwIV0Uiy5G3Zn8SF33nNnpofLVRCyqPHzLVe?=
 =?us-ascii?Q?URzeGrsjubBdbmlCaRN+fqXL/vfIIo9FWClMl7mmZHmlbaBNbZLDS6/9tJSX?=
 =?us-ascii?Q?zC6J9mBclOBE2sCU6vI2gfW8B/08r66+qeM871op5gWhcZ6d3iydm9LDmI3E?=
 =?us-ascii?Q?WIATKNm2Bf76NZOH7gIiAMRNUpEGQzaXDG5Qju/p9/ngz27gabjubGiMqmh6?=
 =?us-ascii?Q?k+j52LTrQtlJE5KQx6xEjxeaFjaH7hr3g7MxKR783V/GKOnTaXHQCsC/uGwk?=
 =?us-ascii?Q?03JawYlMHBjEtRb6TbaNf+vAJeCYDxFTOyWWKji6EQVn2D2CpQpYRxc4au8v?=
 =?us-ascii?Q?2AQwsHLgQYdMdkPFduj0DzwaxDBpvIJgAVZKe1N2t9HqMFYMeVY1kZIeySGf?=
 =?us-ascii?Q?HupezvtHpfW/8yRjOUpZOItRd8I+jT6rSRVZexIFgyqMxSzkf1SlfURxmX3n?=
 =?us-ascii?Q?fk5hNscO+P7/WqQ1pC8syAiqyEvNTLKEL/qM5STYN1oiWwQWpGb9h6TR0Uc7?=
 =?us-ascii?Q?3uAfwFtY53IvklJFcn8OTbFGT+2ejrzx6qoqRb287SubCzSWlqNKPZltgtw+?=
 =?us-ascii?Q?WZjrZA9lqmZvqZ6kxFx886MAjzYD6YC6ogdQo4pcTffMeVIVeT2DnxtAPP9f?=
 =?us-ascii?Q?r/J6JNRG3sY3/TYjorP0V6jBaE8CowzU5IVWrismBu/CzkkIjBDXGq9MTGHu?=
 =?us-ascii?Q?ZztW3D3DjJ3dnGG++CuxIhnRmSYU72j6xYBOihdu4xU9EQPp1t27bg8mCcuv?=
 =?us-ascii?Q?cDTguGyjkAYhnU0wKsIvzXpP44XHUNWcW3GAGza/Mu0M/0b72lL+xUPgLT/5?=
 =?us-ascii?Q?WTRC4Ruk7ntT1bSYKu25+UH5mNEBugxvUGu9ktHVA/dmmd8oAUi5zuNg1kko?=
 =?us-ascii?Q?eEjI1mQPYGvFyQE1J4B+6RWwyEtoTaStKBWuMuyICuH6+O9Ih1+uW3mwEYKA?=
 =?us-ascii?Q?PCVcPHRh8hWh7G0s2s7Vjt6s90s38YOt6/M6d74CijvYEFrijbPLRH3It7Fw?=
 =?us-ascii?Q?PbVRvbVzbd+LoNwt6o/CdICZy+xPJJ+9qxV4KvAOw8uhQ5CL8HWcGS9M+GI/?=
 =?us-ascii?Q?dwsLjuw5QQRRMwW4B7Nxn6J2mYODQQC8SdNnpTAccT1dZtH9Jv6YDcnaMM/8?=
 =?us-ascii?Q?wxJCBSeJv5rt9NjanioGG+sAvJHchaIRFlEGuNSW13B8S0MGg2smS6PFCWCQ?=
 =?us-ascii?Q?9c5yWEhkFodTvOpkmFihtgPNHq+WTjAFPxBc6Orkagu/+DlACpscwPkLjDRU?=
 =?us-ascii?Q?2B5zPPSwv2bROKem8fJfwl4YEUYKnOTddlOJVXEHGTO+dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yF+62r2iv0k26SftKEutTcKAnrRScbi3nO8GbMnioMgEa1ogHokb6IMXK0IY?=
 =?us-ascii?Q?lHUayf65bowzwb91QoJ83AQjrhA5//EXZvUFfDAK7NDhvcfwH4LOIfCWYVfW?=
 =?us-ascii?Q?+j3Ak557mD/D1hlI8GD7lhkes4G/pzYKF1g9SEJxI5Q5AUoLJFHZtea193EO?=
 =?us-ascii?Q?dlpigp2oDgb7Ge76vDkKDtAMmnLliLZRLuQ4DvqzFkkGTEysS3tmIwbwsK54?=
 =?us-ascii?Q?E4g1cxawLUfm80g5IvvK+Dz5UEXFrX3hwS6Fq4mwiXhIyOrOqaTQ3AgaLDap?=
 =?us-ascii?Q?AByoKS0IQb5GUom5jEiB01Ojw64a1pE56Ixt0VdfQLvqgCw21S8zfoqya6Zw?=
 =?us-ascii?Q?pEATMIP+Yfyv+Soz+rCX17zTelV8vwLJR4Ea0dfJixfvBUjCO4a2/Vbxzx5Y?=
 =?us-ascii?Q?TuJy5mBrtPhktCVD0r/Otos2soxowSh/e7XIlf8fEcQOch40Dol38nEBn89F?=
 =?us-ascii?Q?3AVk10TX7zb06SFYxBOmWe+WmEjIcKj53a/HXGPUA2lw/zcO5+6/XdtFXzlB?=
 =?us-ascii?Q?eZGtJxt8soG91pDT6OFsVOmqHO2VS9yZVeV5msqHtQkH8vKCFqgVbUHYO5zf?=
 =?us-ascii?Q?kv60Y2VPhyl9bmwwZ9o2BKDMPnTJ8lK0MlKMFdpooKH4ICK9q03P5kfpc16K?=
 =?us-ascii?Q?4McHpJ7fgQixJsatnK/So8jRsABJSz26aED4cjYOjeKPjZN80HjSpdZUUvN1?=
 =?us-ascii?Q?vtAJh0VtUuX+szgUamd8sYkQvGyqiUcA0C8CqpeWQVTb4ZqL732RXtA8wvnw?=
 =?us-ascii?Q?DzMPG+Llk2/Z7aJDQZaOHcytrhdCevNmJ8k2hdsgRv8duB8FCsZkY9tjerjr?=
 =?us-ascii?Q?hS3aC9v021vkeaUXHHJhoj0KdPdPgwuhyv1BQ1j3/1WPjqWPrvV0G71n9v1M?=
 =?us-ascii?Q?zLOCwxR5q1Ceih97GFqBnV49xs7bNW3JH948dya+TYyTGePoxtemFha81BSi?=
 =?us-ascii?Q?pqAfXxskjmzwPwoZfbdY6nGz7O6Dkyt4kcVwuBxtYtqNfl2iyQ7BEjmoAyxJ?=
 =?us-ascii?Q?a3GqiMcxCWcKdamURN9GGulhTO3J8Q4Pl/Q39Z3g8z1eymMXWLgq8RRTJH4z?=
 =?us-ascii?Q?81XEcyhJo2M/O8i5Jp8xDG2F1RyzNb2+xYnQhwIGGYw0J+WZUeV2R2eqxPfl?=
 =?us-ascii?Q?s8aZA0jiQufeJSADInTqDUpeH5ToYNFE/yWGjxALELBMdQ3TwUQBdQ4Owuny?=
 =?us-ascii?Q?C7x0sTc+H3TaNs/QZazhy9URgEmmK+kbEkPEpv76p0vK2WDjpEE3ENtqbLse?=
 =?us-ascii?Q?59KDHMOXaViuUDBoYPGnRR4jSTfBv7aEXLPQGEGp0RplUZUpnHVd4cSB1oIH?=
 =?us-ascii?Q?aYJW5jz6QcdMPEZ7NoKSpzSUCUP8TNz4tzyTj+rQ1oL3HKKFDsHi7MbpHJnP?=
 =?us-ascii?Q?Jelbnvi/JMxSyTW0Zr7zFNLhkWwKY3/SpwwjoOfOEozurrhF1FW0KwP7gPB4?=
 =?us-ascii?Q?SecBuzw/pnttoJ+E1wBa0ryEMqIO4eFeWM4dGzxtjaX919PVwQef3yAArYtg?=
 =?us-ascii?Q?dlgXSW76DbHt2xWbfEQ2WIsojaB9+MtOG3MNcM6Mjqb7ivwnItaJix6dGelU?=
 =?us-ascii?Q?/O63bFvuEMBT13ETrSGwN+wOcL0fEAD8M4FOiAAj?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6387b7aa-5fb8-401a-1329-08dc99e57705
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:50:00.5030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wAPwQ+eBDOlXxSgaaryfC93hTT6aArcIKMyc34m95OxbEDTMcQoPblzafalu0Fa07EI1ah4L89xBvUEP6ouGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0519

Set hardware timestamp on transmitted packets.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - No changes

 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index f102f9de7d16..3764b263add3 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -10,7 +10,6 @@
  *  - Transition from CAN_STATE_ERROR_WARNING to CAN_STATE_ERROR_ACTIVE is only
  *    reported after a call to do_get_berr_counter(), since firmware does not
  *    distinguish between ERROR_WARNING and ERROR_ACTIVE.
- *  - Hardware timestamps are not set for CAN Tx frames.
  */
 
 #include <linux/completion.h>
@@ -1187,6 +1186,7 @@ static void kvaser_usb_hydra_tx_acknowledge(const struct kvaser_usb *dev,
 	bool one_shot_fail = false;
 	bool is_err_frame = false;
 	u16 transid = kvaser_usb_hydra_get_cmd_transid(cmd);
+	struct sk_buff *skb;
 
 	priv = kvaser_usb_hydra_net_priv_from_cmd(dev, cmd);
 	if (!priv)
@@ -1213,6 +1213,9 @@ static void kvaser_usb_hydra_tx_acknowledge(const struct kvaser_usb *dev,
 
 	spin_lock_irqsave(&priv->tx_contexts_lock, irq_flags);
 
+	skb = priv->can.echo_skb[context->echo_index];
+	if (skb)
+		skb_hwtstamps(skb)->hwtstamp = kvaser_usb_hydra_ktime_from_cmd(dev->cfg, cmd);
 	len = can_get_echo_skb(priv->netdev, context->echo_index, NULL);
 	context->echo_index = dev->max_tx_urbs;
 	--priv->active_tx_contexts;
-- 
2.45.2


