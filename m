Return-Path: <linux-can+bounces-3298-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA24BA75FFF
	for <lists+linux-can@lfdr.de>; Mon, 31 Mar 2025 09:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180401682E1
	for <lists+linux-can@lfdr.de>; Mon, 31 Mar 2025 07:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA1F1B4138;
	Mon, 31 Mar 2025 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="Feh1NaWM"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2112.outbound.protection.outlook.com [40.107.104.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6E62033A;
	Mon, 31 Mar 2025 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743405951; cv=fail; b=sk+x8P/tPYnu/vbAMTv2hFPO1wMr3XYfcdRrBGgGAOfPNW7R2cJh/d637ekOAOOFm5WPzIb02VBMPnsFkPZ2OSpWxoNPGkir/l7sPC9fz5PreIT2bUxZhUTV6s75z/9UyLcWlPjVshb2JuiDseQ3feIyEf5bxhRCCf2kr/cUheM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743405951; c=relaxed/simple;
	bh=qO7Ja9hK8DF5YRM6p/y+AF+qNtE8d2CE6Ik+P3bARGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D9PDUzQJK4lBfP/9gEKG4CwMjmfVbuudb/kDSd2ZcTb5TGU5j0bzGUmG+iJ+1LZ2fPlxfu0H1NxIjRWjEccEflkTaExdYpGCvvKQ2xrXwgk9YSn6tS4Gd93vOvvRqmDR41r5Q/IgGaeXFW6VJEQSRTYLsyzv1uWYzsnjoykEdyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=Feh1NaWM; arc=fail smtp.client-ip=40.107.104.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcJ+pne861yjgmADGe+rYa47ShD8bfHIe/n4A+ShLgS2rICu4MKZe01WEMBZvI/7YH5rSkotGWLDk9z6UlVbI3S1fPuuSWGIhsl/nk/wx37cdpvPVYgAEEXIDxts/66Cpc6xMAXJYw+fdjv9FK39UEr4kwZFtzdR7SC673WaVbaeUzZ1DAOuQvLLcWbLeYgHhV0v5Lmybir3W+CxrGMP27oo4uapliGs8UgDNP26CLp4sr5U30Apm+tXXJb3R2rHDIIg0tWeN8tlfKRaT1JXIUVt4uLKVvXTOD9snEY+NuFHtEEu2qf+NH9po/9PsILgexAxE5DUcFBWKUgYq/MCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1DECM8Fzk9YucwCpE6zfNpxfMtGvy6dmIHfHw4nTXs=;
 b=DjSb/bckQqDV1X/nJDWy5tHpzN2YPnldmWxZj6J4gypcvqcLSfMQ/m4rSxc1OKI6BMML9eS0cJvuYJO6b4r69NqWcVkP9G2mH8L2EwSvixVMdyyFngXLu7Umd5J9yuAVTpYQtd+HlwBog1vr9wGxW1rSHQ4SL174rc9kmMayOtE4JGeZUHLBLZy3nLf5fSuXtI0ESEX7N065oQxencIcFnkh2uoF4w9wnDjmH5G3fVlArVMaZ5YgSaP7sbb6iGhUO2l6pqSExnKpJ8yEHvpiECRcIMyrAEv9hCfmmHlkj0X7EzHzXz30gTky3JhN4vgQSAJUGVW3d04DpPHTelJ4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1DECM8Fzk9YucwCpE6zfNpxfMtGvy6dmIHfHw4nTXs=;
 b=Feh1NaWMB91uMe52XazPDhBbacTRjp0RN9ZcMuqdRMmNOgSGt/ennMMQi3ouuZLySWNSneRNlTrr0hb1+679m+gofuALhVUgly+xFlk09x/1jc4qK1r7wftobcAF+f481BJfea7SeEzyXlzcjJ9lrbWpUGtsLai/pVaeAB3GG0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::14)
 by PR3P193MB0556.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.21; Mon, 31 Mar
 2025 07:25:46 +0000
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18]) by AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18%4]) with mapi id 15.20.8606.021; Mon, 31 Mar 2025
 07:25:46 +0000
From: Axel Forsman <axfo@kvaser.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	Axel Forsman <axfo@kvaser.com>,
	stable@vger.kernel.org,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 2/3] can: kvaser_pciefd: Fix echo_skb race conditions
Date: Mon, 31 Mar 2025 09:25:27 +0200
Message-ID: <20250331072528.137304-3-axfo@kvaser.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250331072528.137304-1-axfo@kvaser.com>
References: <20250331072528.137304-1-axfo@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007573.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3ec) To AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:3ed::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1652:EE_|PR3P193MB0556:EE_
X-MS-Office365-Filtering-Correlation-Id: 80741e30-fccf-401e-c807-08dd7025410b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?psfyswIPo8vP66SN06PCm3C8FKSyOmNLS5IxCifJLfVLu92/WNCU4KPBo1lc?=
 =?us-ascii?Q?5e7OUTKwORaZEh2N/CiZ9mblofoxFE0/ZjnIc1m3lKkx4zCjXyU7X9F/Ac2B?=
 =?us-ascii?Q?fgGp/pkXXsEy/P770LB89D9jsLiFwjc5X66MW/LzaGcu4xmUEmS+/+b+iQcX?=
 =?us-ascii?Q?XCcKvwqJ7Mn4c5g79LgR6EllHew5Gr3aKQH4TNIU8iv606zL/WbEUZHyjPWt?=
 =?us-ascii?Q?S1/cbucp6Mq31B6l7uGIkS8RGDAQDgQPveJP84KsaEiNVnFP4gU2VzrD2TS4?=
 =?us-ascii?Q?wfXEfaAmJaFrdzSTdNK8us15PR/2mk1gveJvREhuQcFudQ/jxP32WRSrfSUx?=
 =?us-ascii?Q?eGyp/06V/HmUQtuOoHJ7yad1/z4OM3fpQEXiveBfduTH9NFm8X+J7VxuccNT?=
 =?us-ascii?Q?r/z/Kx4wQVoyY/3xObGpq14Y3b/Uw1X1xjhfxUETbJgBnWqRB2PjMLN9eNLu?=
 =?us-ascii?Q?Fq8SVcYCketKtU9JKa1LyNHhcNWbaAoiSO9YZvCalI4WuqakMiv19sz7irUd?=
 =?us-ascii?Q?jd54UdrdtSjZlvRHMnHllRP/NlyhLXukqLyjgNFGcicuo4+izMyEzac1hvpQ?=
 =?us-ascii?Q?VZgG+qce80kzW6mgh2B7cQ8/8Bwc12Vc8M/nxhjadY94mLsP1/s/ixfO/Yme?=
 =?us-ascii?Q?TYdgm8Zg8FjXlhqwwhJXKAsE7fwa3XyRwoEYeZfWQZtKjOAGeCqdVG70zeL6?=
 =?us-ascii?Q?+RcycMlYGHha7kYx4r71M4jqVhTgg3FzUF60WHhVV87npd1dM+Nq7c9FPttZ?=
 =?us-ascii?Q?8C3qWohxpIyqIJejakfgkVS/sM1WWothYXz4V5+J77kyZcRokCkFqqhXO1Z2?=
 =?us-ascii?Q?MkezKPuCwe1MfhxdLUR37gf+vsZCKOlEP7rar0Rh26lZqgaOZOZNHHUKktxw?=
 =?us-ascii?Q?weR1/kzw5vUhEXBZbAYK4GFwYZMxq0f3pqO5kWVGDfAD/eNH1VB7PL26LP2d?=
 =?us-ascii?Q?X1n7zC9Zt72EXnFEH7hyP0Fg+vn0DOWGpPsHxBsdsW/lGu5ryrT6NQFyL+y7?=
 =?us-ascii?Q?aLAR/XykSUwXrhMl5cE7dlNIUf4+BLR8u5EXN7NG+vufAWtfj2eDL4eak5OO?=
 =?us-ascii?Q?qG8vzJJqwIJ+36F1GD9SyskXtaLlK/7dWiXNm2Ie6bVp7EOfgV3mHQRpw3GH?=
 =?us-ascii?Q?fxDx5QLj4ReAh2OHw7sBpVH2stp1LDUhAXY4TM3d70B4S0rQqwAAjWTFXGc2?=
 =?us-ascii?Q?FfY13pfv/3mUGTTzsnNuy7UZ9h4fIofn9zvEXvq6ue4XZeXQX9Yt/4NbzDNw?=
 =?us-ascii?Q?jIHXlzIY2Jt/GFdWkEb2scTa43TikgizHTVfhOp3VgW8sBpcGgIUA6EgB98v?=
 =?us-ascii?Q?z4DM7c3U3XBu1uhsm2o/31SjsNqqJ9P5VuV76qpT9SVxLmfPS2UoHduf9xLa?=
 =?us-ascii?Q?O+HJvQXamSok5eBfDIR4CnMHhB7L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1652.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QImOpkH2M1s+YaBizH+sSXu+lDzNueSVuhYoZaVHuVoue1WaJygnS0+4e0gb?=
 =?us-ascii?Q?LovOIoJzj4Wt4pB+5W7j1NqrrujrR+D5LTRgS4FOWRNZjVPwffWiSYJob7F9?=
 =?us-ascii?Q?oAjfQnOBHuRpl0GHehz2t8+1I09OyFYcyRx8t0H/OJgeS+NSS7I0LHp3vMwv?=
 =?us-ascii?Q?+36K6Ur9MfqHJMYeFf+geLteKkN5/9ynGiTrih6nWgb7vEZFd2FzGIripU87?=
 =?us-ascii?Q?mrpYP/etUihTepGMFJa0aLeEJf2KPjK8p4WP1PnW0mV7FQD4rZPDsu2pTJHA?=
 =?us-ascii?Q?1SaPkvdMsHsLTjwOLxVabqUy5w1Kyl6Sh7RQ1PTxP+bQ8f70ueYqx8pvNytT?=
 =?us-ascii?Q?LX0o/lF0AhBWxyRlptFxqwrk1N4FyheP5cHzs8EORmIsxHUWDPrIgFIm84QX?=
 =?us-ascii?Q?eMgZWoMXIqZNGeuKrM4p2LNAIYJ5FEGxJxT+Ib+xzGGttmERpvnIrSkpD+ke?=
 =?us-ascii?Q?/imXjTfNOqxVyKJ9VvnRFD2pFQz8FAhiIx3dPM/DBHT3PqkoJ/4zgE2Vmw2B?=
 =?us-ascii?Q?0dwB7jHqC8YwwIhylX/a2LTwhEQ+9+1Wy5nN+mBSxMDLT8ZzWbwDrwT7sBcw?=
 =?us-ascii?Q?RvTQb947Ht3EQXgQ37RlXQsKn+HkZL2VMtW4LVT6ZHXCFylPY6wToUjVpE87?=
 =?us-ascii?Q?WSHR8kJH/jXUieXe97tF8GhvRhypgdGt70zoeMa8+Pa2mg/jYUhCDJ690CF0?=
 =?us-ascii?Q?v0A8/TPyz3rWXzpmkhC12dF8c7zr5kxGDBZp7NbzubBw14e46n57obIdl2P4?=
 =?us-ascii?Q?RBnyDonCWD3EFEs4buOp/tUlwaE3GTNYyjl0MiM3fSqPEULG/cXn3RzqvrJC?=
 =?us-ascii?Q?nRNkaabgDrr3lm+wHk4elW7xqLMpTmI3XYjGtjT6dw7H2x9SZ8Mot1vCrJ4i?=
 =?us-ascii?Q?amGoXjrgJOpdnArd+Cc5IamGf+Wongt6z8Z0J3EgxhMZ50BKMvS6TTEK6KBH?=
 =?us-ascii?Q?C0O19kEmwcz7RfpY5eNWBWKWPPJof8wVpfBFlmzbTVc/83OyabMu2giLSaCo?=
 =?us-ascii?Q?YHGtWeJ6PqfnFXRWBFSqQnvDgZk9WNGFEn0uhlxopMxSdok9fKihDQOx+/zg?=
 =?us-ascii?Q?F9PBbP0Gf3rt3mxLiWQLL2szjZ+7u2QJEQoYqlLFoiDbYPpPcaps24JDO6r/?=
 =?us-ascii?Q?xo5CSxFciHA0/HJpT/d7PKhEAUX/OUzzTboqHqbAF6vCN6e6CkQnDtm0s6Lf?=
 =?us-ascii?Q?fynJLEGZsJxgY0OljlCH3L8VGViiTMGb3mqcX5m/VqdaL9Hm9XCJYyzrldO2?=
 =?us-ascii?Q?ZDYntSL/R+iFLpZkK7p3worgsmG5NyR6UyT4XhxNu2YFKG/vlnFynY7YOJMG?=
 =?us-ascii?Q?IaMNhaCGEOWyEe5nYiyF780GjEQWfj5WahyKIfHYyOz2g2td2HX2piUBYwbD?=
 =?us-ascii?Q?2vBcFSh+6MfvKQ591+j4nnWUYl1X2UGoU2W9NfP3EjA+sCEBQ0Pq8ALVp9mX?=
 =?us-ascii?Q?p96HlHsOKSXsbk/Z7AFk3S6BXnaN19qjScoKR9uPzLlQmliUzt/HoGfvjq1v?=
 =?us-ascii?Q?OHY/F1OpDuwjZhhOGVAnHEqVRKQtLKneFtbp6Ky8XOxCo3V7y5ggcFaUQ7Yn?=
 =?us-ascii?Q?FNCuDDyQa7Rlaeib9NNG7dgDPq0KRrLsJlb+Huvr?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80741e30-fccf-401e-c807-08dd7025410b
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 07:25:46.5740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWsC4FJKqwoHFk2sTXT8+uC1k1pv8bzJq3TtTxJvgQ0GaAcUwdn8hwt9KjMPf3zgzwF9BcxSZNrxL2xdTLoqUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0556

The functions kvaser_pciefd_start_xmit() and
kvaser_pciefd_handle_ack_packet() raced to stop/wake TX queues and
get/put echo skbs, as kvaser_pciefd_can->echo_lock was only ever taken
when transmitting. E.g., this caused the following error:

    can_put_echo_skb: BUG! echo_skb 5 is occupied!

Instead, use the synchronization helpers in netdev_queues.h. As those
piggyback on BQL barriers, start updating in-flight packets and bytes
counts as well.

Cc: stable@vger.kernel.org
Signed-off-by: Axel Forsman <axfo@kvaser.com>
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 70 ++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 0d1b895509c3..6251a1ddfa7e 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -16,6 +16,7 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/timer.h>
+#include <net/netdev_queues.h>
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Kvaser AB <support@kvaser.com>");
@@ -412,8 +413,9 @@ struct kvaser_pciefd_can {
 	u8 cmd_seq;
 	int err_rep_cnt;
 	int echo_idx;
+	unsigned int completed_tx_pkts;
+	unsigned int completed_tx_bytes;
 	spinlock_t lock; /* Locks sensitive registers (e.g. MODE) */
-	spinlock_t echo_lock; /* Locks the message echo buffer */
 	struct timer_list bec_poll_timer;
 	struct completion start_comp, flush_comp;
 };
@@ -745,11 +747,24 @@ static int kvaser_pciefd_stop(struct net_device *netdev)
 		del_timer(&can->bec_poll_timer);
 	}
 	can->can.state = CAN_STATE_STOPPED;
+	netdev_reset_queue(netdev);
 	close_candev(netdev);
 
 	return ret;
 }
 
+static unsigned int kvaser_pciefd_tx_avail(struct kvaser_pciefd_can *can)
+{
+	u8 count = FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
+		ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
+
+	if (count < can->can.echo_skb_max) /* Free TX FIFO slot? */
+		/* Avoid reusing unacked seqno */
+		return !can->can.echo_skb[can->echo_idx];
+	else
+		return 0;
+}
+
 static int kvaser_pciefd_prepare_tx_packet(struct kvaser_pciefd_tx_packet *p,
 					   struct kvaser_pciefd_can *can,
 					   struct sk_buff *skb)
@@ -797,23 +812,31 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
 					    struct net_device *netdev)
 {
 	struct kvaser_pciefd_can *can = netdev_priv(netdev);
-	unsigned long irq_flags;
 	struct kvaser_pciefd_tx_packet packet;
+	unsigned int frame_len = 0;
 	int nr_words;
-	u8 count;
 
 	if (can_dev_dropped_skb(netdev, skb))
 		return NETDEV_TX_OK;
 
+	/*
+	 * Without room for a new message, stop the queue until at least
+	 * one successful transmit.
+	 */
+	if (!netif_subqueue_maybe_stop(netdev, 0, kvaser_pciefd_tx_avail(can), 1, 1))
+		return NETDEV_TX_BUSY;
+
 	nr_words = kvaser_pciefd_prepare_tx_packet(&packet, can, skb);
 
-	spin_lock_irqsave(&can->echo_lock, irq_flags);
 	/* Prepare and save echo skb in internal slot */
-	can_put_echo_skb(skb, netdev, can->echo_idx, 0);
+	frame_len = can_skb_get_frame_len(skb);
+	can_put_echo_skb(skb, netdev, can->echo_idx, frame_len);
 
 	/* Move echo index to the next slot */
 	can->echo_idx = (can->echo_idx + 1) % can->can.echo_skb_max;
 
+	netdev_sent_queue(netdev, frame_len);
+
 	/* Write header to fifo */
 	iowrite32(packet.header[0],
 		  can->reg_base + KVASER_PCIEFD_KCAN_FIFO_REG);
@@ -836,15 +859,6 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
 			     KVASER_PCIEFD_KCAN_FIFO_LAST_REG);
 	}
 
-	count = FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
-			  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
-	/* No room for a new message, stop the queue until at least one
-	 * successful transmit
-	 */
-	if (count >= can->can.echo_skb_max || can->can.echo_skb[can->echo_idx])
-		netif_stop_queue(netdev);
-	spin_unlock_irqrestore(&can->echo_lock, irq_flags);
-
 	return NETDEV_TX_OK;
 }
 
@@ -970,6 +984,8 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can->kv_pcie = pcie;
 		can->cmd_seq = 0;
 		can->err_rep_cnt = 0;
+		can->completed_tx_pkts = 0;
+		can->completed_tx_bytes = 0;
 		can->bec.txerr = 0;
 		can->bec.rxerr = 0;
 
@@ -987,7 +1003,6 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can->can.clock.freq = pcie->freq;
 		can->can.echo_skb_max = min(KVASER_PCIEFD_CAN_TX_MAX_COUNT, tx_nr_packets_max - 1);
 		can->echo_idx = 0;
-		spin_lock_init(&can->echo_lock);
 		spin_lock_init(&can->lock);
 
 		can->can.bittiming_const = &kvaser_pciefd_bittiming_const;
@@ -1510,19 +1525,16 @@ static int kvaser_pciefd_handle_ack_packet(struct kvaser_pciefd *pcie,
 		netdev_dbg(can->can.dev, "Packet was flushed\n");
 	} else {
 		int echo_idx = FIELD_GET(KVASER_PCIEFD_PACKET_SEQ_MASK, p->header[0]);
-		int len;
-		u8 count;
+		unsigned int len, frame_len = 0;
 		struct sk_buff *skb;
 
 		skb = can->can.echo_skb[echo_idx];
 		if (skb)
 			kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
-		len = can_get_echo_skb(can->can.dev, echo_idx, NULL);
-		count = FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
-				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
+		len = can_get_echo_skb(can->can.dev, echo_idx, &frame_len);
 
-		if (count < can->can.echo_skb_max && netif_queue_stopped(can->can.dev))
-			netif_wake_queue(can->can.dev);
+		can->completed_tx_pkts++;
+		can->completed_tx_bytes += frame_len;
 
 		if (!one_shot_fail) {
 			can->can.dev->stats.tx_bytes += len;
@@ -1638,11 +1650,25 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
 {
 	int pos = 0;
 	int res = 0;
+	unsigned int i;
 
 	do {
 		res = kvaser_pciefd_read_packet(pcie, &pos, dma_buf);
 	} while (!res && pos > 0 && pos < KVASER_PCIEFD_DMA_SIZE);
 
+	for (i = 0; i < pcie->nr_channels; ++i) {
+		struct kvaser_pciefd_can *can = pcie->can[i];
+
+		if (!can->completed_tx_pkts)
+			continue;
+		netif_subqueue_completed_wake(can->can.dev, 0,
+					      can->completed_tx_pkts,
+					      can->completed_tx_bytes,
+					      kvaser_pciefd_tx_avail(can), 1);
+		can->completed_tx_pkts = 0;
+		can->completed_tx_bytes = 0;
+	}
+
 	return res;
 }
 
-- 
2.47.2


