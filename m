Return-Path: <linux-can+bounces-4047-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0CEB0ED59
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E145A188C8C7
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3789B27603B;
	Wed, 23 Jul 2025 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="OQ02jWOb"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2132.outbound.protection.outlook.com [40.107.22.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A562E3713
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259741; cv=fail; b=I/PAxCyCWCFbYgTMh5nE3eo9WLwEKqM3+YX+uMSkjYH01kfmkPUT1Oo3Jz/0pO81b92IUBMQ4GZFraxwQSEZFfiAObeqbTxbtj6VRlkp5DnrrBjBvKduCNc5T9pLSVOFyJYBBh09HNUA3DEEte5EWsU4r8RsbbVDY49mUQ17eD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259741; c=relaxed/simple;
	bh=TGERLdifMAQyhssYzWthvStkBpfRoSLNnL9LpFffQac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aUGgmEkVQRYuO2Ue6zJcZKom6v2usfHvdE8dPzPKo9zQ91u+JvoUihO3sR1Gk8wXnxjhh90/Yq0a0dE0zCbP1LMelCk8HrmYbnXAHH3dhpkeWcJ/FspEzqKb56opkrwTLKwVWGHFQRelglw3U4qFRPrEznkBAGAyy1tUhaFvoUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=OQ02jWOb; arc=fail smtp.client-ip=40.107.22.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZG81vxdksh643DvCijYRzZxel5WENnraU3a+zletfqlrD+X6EmaIMLzjidifTKPOLsU5VS5hJ5BsMr/dMVSQkn07XxmPDicoz3XFP+ClLg0BzqrF7pdl+4zch014v6FXMCUoI0XGgHkyFZvbIjBpDeZOoA5zqc3yUaogUFwTwp70lFOOc4UsjCsbSmMz+hTbYv5rW5RBAgVAzgJNTPo8HRcZk3VMkaP/Z0Mq+nExn8bMmKmOHTy4Ua/oFEgpGVxiqloJax3S7/yuP/56NW0rfeIRwkmHmXlHLGT+jPdR2CIkAPZGl21zl3q9iDFWbXbXKWc1zJvaLcHwP+mpKoM0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jW4hzKxYSbpqgOw2ui9UYBVMu+mRiRTVeqlMS2TXMqQ=;
 b=gatDhJ9Txnabd14SNFAa9uXPqUFrc7P3RRXLC/zvhyXs1gYawV5PSoHQxhV9CtMKrpsKeGaIyNpl4iPJc3N/jme+67Zlb0A19URjOcLqoco/e4gOwhYwtakzfifU5qI+ohWiS8+e7ZN0TiJO0mzoc9nXNFG9K8xhSlttaBpQa/ouT9TKzi/hlZt4AsSOp/E61FEvnYuHT20RbMe/rWOCDNDTJ4SsquG3iLCz3zChH0UD3oHPWqfQWKVP2oOso/buTmrs8lbk9uh703tIJpIZczmhnN9s4BvrTtI8Oqp2rMBBkPbwB7zRLciUNRPvc4CHTQaFntOVjzPxyPpHxdRojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jW4hzKxYSbpqgOw2ui9UYBVMu+mRiRTVeqlMS2TXMqQ=;
 b=OQ02jWObpDRE46rraQMMwRwp25SonyvnmoDKelD7xjDuBsjrm4Qgtju6Uxr92zpu61Jt4lSyGb33QeIKEy9GaFGPe0IzGVtvfsv0fZJCpLSvLaOYglEJwd3lVloURHwp33eC5444Zpva/qDqqwstMMAUNBGD3Bo+owvcM+VcelE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DU2P193MB2018.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:35:31 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:35:31 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 2/9] can: kvaser_usb: Add support for ethtool set_phys_id()
Date: Wed, 23 Jul 2025 10:35:01 +0200
Message-ID: <20250723083508.40-3-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250723083508.40-1-extja@kvaser.com>
References: <20250723083508.40-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0064.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::26) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DU2P193MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: 2817713a-0794-4f66-2615-08ddc9c3e264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l2CfcHvs1ILGsuCekrNSphYBDEMln7wU92rZsFSUx5+0XnkiiP48U1BcvFgV?=
 =?us-ascii?Q?WJyTPARsg857DeoCz9oVX28pORl68MnjKROhSJKWxx0OMqSyNZEC+wM6S95K?=
 =?us-ascii?Q?7CnQlR1o8Dgi4Ai/JvIuFV2eFuWE4LbZnW2YttYlZ1JeHVxjuGEU27YDKf/u?=
 =?us-ascii?Q?4Eo8+txCzViY5aZtvUVw8xW99gd15kp+F7CF0y7ZnhsM8NcrMNRI64G/b/sl?=
 =?us-ascii?Q?geJu/Hp0dNBwtyG9bqxY6xftH5iAbIaywqsF+FnAV/hcHwGu6ET79CClV8XU?=
 =?us-ascii?Q?AlBAmBTUl0uCimV1iRMClHuoWqnt04fmaGnLC/XU9ca+Z3KLtoTEpfjHG00h?=
 =?us-ascii?Q?2TSbMz+rrqyn8qX1crTiQG9iEpbLsKFFyCosfMvcFOF65fUmlMYmNCQTNu/s?=
 =?us-ascii?Q?xWaMdsFveYcnyDwUenCAh3yVCIP2i3Rvjyq4gidPLqjKYFy12V4lFvnkjV8m?=
 =?us-ascii?Q?II8TecZwNSsAL/LiL3cO9SKXG1hPaLvyD9XuiVP11m/y6YJbfFMpKqFceY7p?=
 =?us-ascii?Q?P0HQaqFxkh4pdRh89q8M53JaHbug/CThkC86NlOe7Z9wMLs+iJKZPZRHe73T?=
 =?us-ascii?Q?vNm0iI3Jx0qdQ5ctHSQgeLS/K5yMnf3ZjjAFg+yXmgHdJRhTqt3J/EcMinhT?=
 =?us-ascii?Q?WjtH15+1YVAQA1Z80Ld6GbYQEbAthFSDhPpJtASeyD+m1wKkScyp/ZSAyR7d?=
 =?us-ascii?Q?pxTeEIhBP40y8CpWxuJ/z9X7qJP7wlkvFHqixyuRf118NAjbnCYEwkYsL19S?=
 =?us-ascii?Q?3ZdiXcme5y3UGBmwbCMmrVsRwdmFzg6UoQMspKDu3BZ6RspS1iiH5gQ39yrg?=
 =?us-ascii?Q?stqSL6/mEZEYqyB1nvwjjNO/IdtCpdcG68zZvyD3cdFxioT2ksfQIpCtCseo?=
 =?us-ascii?Q?8iqIrlYu9ucvD6fxdzGwxGIIU+HDK9ixwSQwAw/mqWFHZD+x62ccof6jyxcb?=
 =?us-ascii?Q?BMw8lTSjmdxDhY9LGIAS9GAudZ+8N/DnfL5th5/+LHNWxfmZGcgv/2G98PY/?=
 =?us-ascii?Q?2zT4sl+vGFfcdV/PYgDA7kpTC8lZ/yCZwOVVwCJPVL3jN8X+wxcrv0GUj9eF?=
 =?us-ascii?Q?SZttGL1+1NVttyolKHWuh2R4oMK0KAM0qL21sEFphZkPFzfMFjJ6KxiJrWXZ?=
 =?us-ascii?Q?sO8pkXL9HqR91KkbPWhSI1FA7QC9jdXFybXmh+Czvhl81b1/mE8mns94Ml13?=
 =?us-ascii?Q?fcQ/eliZo4tXKnpUKrYyB4PXqlSU091JIOBffJFaiE7iFtNfHpeY7Qbm5bua?=
 =?us-ascii?Q?OaUHNqgDR0PkfuJP5+flNny0RYtGD5CxlaoHPQwP5RmzH+eV6PXzxb4rKjDc?=
 =?us-ascii?Q?MaDZTeXVCWfl13FilAO3dBCWkEYlsHw0o8N437WbLQJELI5za9DSZ7x1bit5?=
 =?us-ascii?Q?pTm6psQ9fs7Q/gIHIXPVo42Dzm9WsHNhwDeHtpYDnlLLMPGN1pAx7DNQ9RVO?=
 =?us-ascii?Q?WqNXValvrgU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RjVQYuSbV38Bbe49GR5fXcvI9jyQ/XrlM57RXrjAeX4ei2PmZ52hoSX5bG5I?=
 =?us-ascii?Q?zpzuoZhvlpbBrixthZPWa4obPUYIPwk5Wn5Keln3JnS/HhM2j8KMElpLeRKW?=
 =?us-ascii?Q?ypElXa1Q9I6QaxCHsqamEef/GzKImxCi6QJxbpit1UITP0U59/faynT1ouoB?=
 =?us-ascii?Q?v5m5dwpiMV5QdgFjrjE5xwxcWW3+D3Sy3udzxPEG/1srSRZ7om84vQm/d5qV?=
 =?us-ascii?Q?J1mUDzEYqGt1b8QFfo72dU/swTnGwxlSmA7OcEPO0Iw2nRb6iBuyqXTiHAvD?=
 =?us-ascii?Q?ODHmioiP5p+YvsQOugjP/t6DQlByLOnXFf8F4XiJwgot2u1r1aP18x3YXHPE?=
 =?us-ascii?Q?0fIiMnTZSY/3A8gPwE4YNpYJ9XqiK3Bi8BCiP39oxvD1KoeqQlw3dYvF+4mR?=
 =?us-ascii?Q?evJZpmfuoVwLJIVjsBzjI+mwy6J1EdctH7qCDo55WAMcElxZTmssRXp33FAt?=
 =?us-ascii?Q?lyODiLT0/RKSMRt8hM9bvLzNUJwJOxwci2ulONfy4K/BbCaLKDYiSXBYRzwA?=
 =?us-ascii?Q?e3HMXp90xl7ArAFt0fwsSSoRyQqMiX7Gi4MA09ahR3CVZE9Pzrc4Jy+XPNEi?=
 =?us-ascii?Q?Kya9I9PsAJvZ7ADaXMSIBY+0gyI4nMSn0dNiVYspxXMiTUfaEEshdP+k92Nn?=
 =?us-ascii?Q?XptRFtBJ5LQAoQl6BGDtT/KlWrjSi7kOEUTiUgaflg/7Iuu8m/d8SPRAdBx1?=
 =?us-ascii?Q?5kKQ18x/reh/Mw850PaRwaQHruzwLgdnugvrWFo5n3E+LEm3fwNrNFqwBQ6M?=
 =?us-ascii?Q?+T1oPIPOUW70+4xVOtnAXKGp+6o4goVjPRqnDqCG6iJj+CWbAx2On5abncGS?=
 =?us-ascii?Q?WfadCJ83frZpcLUK8BIx5iM7QM5Qp4TShHtxyc2qJUxXM7CZk8Fwf+1BEJ8W?=
 =?us-ascii?Q?i/stSvDU3F78Ht+qcmq64Q8ODuu90fDh6yF+C65xsp+UuM8G+vCpyUIF7dgp?=
 =?us-ascii?Q?CiP+Tz9NOFhHxG0rNoako8ZBi7x0AkoFDUOJ2J/lTjljdHbiLb9rHVw1kwTC?=
 =?us-ascii?Q?Di7gAvzIvlHf55UKMBMmGkyDZZRE611Zoi6nRKkGCm0Bp5eYy+RW8ugBUtCz?=
 =?us-ascii?Q?4pl5X/iNNLSk6u33E+OeP9UtCQWo//ub/f6LgublaR50mHswQX20a9KPBJ6Z?=
 =?us-ascii?Q?yprE94kj9QbsRmAUQCwg8VrGvTfWbglO+oBWUib+1mg8rYlE8rY8AOHCC6fB?=
 =?us-ascii?Q?hSef2KnfimZRxQs3Yl+Hc0t8fyB9MVgxuo/FNMMzyFnMfLJ7j6ws2JgEnhR+?=
 =?us-ascii?Q?eN6KZni8iRDnEpbVbEVATdgOsc3LrznMqpOglUz0qXNdSitnBXpygVOcmFfz?=
 =?us-ascii?Q?cx9xIYoK+u5plxpu59fPMQgIYjuYnwtG9BQsNnUY3qrqcDHbEfLK2j/M3Lr3?=
 =?us-ascii?Q?Mpms2gF5J+JTX4VBemsTp6cIEiFzrgomnmi9BIKKVWKKdInbNREYjX+/X9fI?=
 =?us-ascii?Q?L3nDqZHKzX0h19wcu8Nnz9ZBoT1sgbC2z7rs+vyMggmvwZw0JWMp9NAG8jdp?=
 =?us-ascii?Q?H5fNuP9rc0VD9lXc4oURtscRauRaRVHEKaVwPSh/6hH+oA/VZbGCXuRMS59m?=
 =?us-ascii?Q?K5iMhEUkbslpLN3aBVJtGlbgpICGsxHQ2GJ5ZATChDjTHCG541OiiVyIUYCn?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2817713a-0794-4f66-2615-08ddc9c3e264
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:35:31.2775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTEeMi85rQOBnrMZT2I1SE3L2LHYh/vV6vhImYtkivz5mVua/cTxT702sHy0NFdtxbd24/slf0VscltsHwaiACEo8cNQeIWuMlIqFsktg5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2018

Add support for ethtool set_phys_id(), to physically locate devices by
flashing a LED on the device.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index daf42080f942..8003c3662247 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -753,6 +753,34 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 	return ret;
 }
 
+static int kvaser_usb_set_phys_id(struct net_device *netdev,
+				  enum ethtool_phys_id_state state)
+{
+	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
+	const struct kvaser_usb_dev_ops *ops = priv->dev->driver_info->ops;
+	int ret = 0;
+
+	switch (state) {
+	case ETHTOOL_ID_ACTIVE:
+		return 3; /* 3 On/Off cycles per second */
+	case ETHTOOL_ID_ON:
+		ret = ops->dev_set_led(priv, KVASER_USB_LED_ON, 1000);
+		break;
+	case ETHTOOL_ID_OFF:
+		ret = ops->dev_set_led(priv, KVASER_USB_LED_OFF, 1000);
+		break;
+	case ETHTOOL_ID_INACTIVE:
+		/* Turn LED off and restore standard function after 1ms */
+		ret = ops->dev_set_led(priv, KVASER_USB_LED_OFF, 1);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
 static const struct net_device_ops kvaser_usb_netdev_ops = {
 	.ndo_open = kvaser_usb_open,
 	.ndo_stop = kvaser_usb_close,
@@ -763,6 +791,7 @@ static const struct net_device_ops kvaser_usb_netdev_ops = {
 
 static const struct ethtool_ops kvaser_usb_ethtool_ops = {
 	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
+	.set_phys_id = kvaser_usb_set_phys_id,
 };
 
 static void kvaser_usb_remove_interfaces(struct kvaser_usb *dev)
-- 
2.49.0


