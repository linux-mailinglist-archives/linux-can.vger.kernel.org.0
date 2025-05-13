Return-Path: <linux-can+bounces-3569-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8D5AB581D
	for <lists+linux-can@lfdr.de>; Tue, 13 May 2025 17:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6433A9746
	for <lists+linux-can@lfdr.de>; Tue, 13 May 2025 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE12124EA90;
	Tue, 13 May 2025 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="LWmunzuD"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2091.outbound.protection.outlook.com [40.107.249.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7F228E5EC;
	Tue, 13 May 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149018; cv=fail; b=AXi2ri30s4TvbXwDgyMbLk0j2NezAAEJI+pgAkfRBLr7rYOUHHtqkXh/jPrwCJYesOX3ByZx3iCkPXKvUWNtKMQKj6AsVxVz0JOT9viZqK0oixrkzDcxdK9nBQQNos1Ci++vw6n4Ojb7xYUKTms2gR7MjceANg9n0Ls7omMojCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149018; c=relaxed/simple;
	bh=DbnMh69Ip0atyRoylMKCduqA0kg0hEJvwIX3UJmpa5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l8J9xGAWVpQVgpUCslcfx93tAZaE6cD2F8EnxQ1iu4fDKExQs4WEI5gL9PVP1o/Z+pKWGje9NrL0XlGnaCPrXZWXHLNpw1th9NTDv/D6zz3jwHkhbVZe1mWLReS0eQBWF9GJb+gmKm0H8gjjlKQmR9ZUVbnAFnnUvqu8zykYcJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=LWmunzuD; arc=fail smtp.client-ip=40.107.249.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcCCN8ra/4MQOy+UC8H/wdfwLXuJC0/Ai2xfzExykBfc7Ybjpb7U40um7epjzrsW7z8exiNcJHaDoCpsFsUCfXR0JBBVZ8QekAgoKsTb4Hdlrg5uG4WRWZqSS+z/F1mV/2cS7gO+JVl3JhBVr7Nripole723HvWp6ZBSJ2m1QPMvTrpREbHSDVu9ObGzfLBm7OajC9UjhUhAiCnlzeTOStvMGa5db7lgLPXJri06r7jQD7AL/Cah3T2xOUfzmfagDIsJ0bjqceaVSyyiSw4abrXENd71hp9M/T4unLpvGBdL5uAHzXyCBINKZJ6tNqjDnYpiCKnLWIjLpBT4h8H4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhczBX84YsEIAH99O22RvQWBw+5AVxksnsR43N3rf34=;
 b=eXf5tBwwzTRi/XZy1ul3bahuSfSVdmx9GPp9E5YHo+IrL90tlFv66m2CdzHrFCvzwhah9ifceL7kHqrnrzB9sUEfLXVskwXq/9ILPWRQmEwbAfqfMTppBMVuouzlSlMWjyd8krvmSDaxLXbgQgbz9Al4s4q3inLSYkN6H6vux1yk/fXFoL9YThXzo3KjL73gklhbLv/w6SE8hw9evwJD+2MICD40kG/Z12IK87NyS/SJQx1ecK3PxdwahVrQWSeL3vJ2bEZTMFOJM64zMwAWoWnhrxy38TMyv2h+KFrdSK5NNplUur+ogH38WQWZ1CLJvgrlJFM8Yl03f3cri4vRKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhczBX84YsEIAH99O22RvQWBw+5AVxksnsR43N3rf34=;
 b=LWmunzuDBC2kWNrkx5T+4lfCb6L+HstWLvQkTRKQZJd1ZHPak7MGFMW0zzZOpiAmtXVe6BUbRJmDT9XfkJW2ervY7YDvBTNFw4k2I5zFLA1jalUQx2jVHkU/LNTaIzEBd1xamq694WzdaJvykEVnJ6d3kQF3dJeN1B/VFRZCaYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::14)
 by AM9P193MB1096.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 15:10:12 +0000
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18]) by AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 15:10:12 +0000
From: Axel Forsman <axfo@kvaser.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	Axel Forsman <axfo@kvaser.com>,
	stable@vger.kernel.org,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 2/3] can: kvaser_pciefd: Fix echo_skb race conditions
Date: Tue, 13 May 2025 17:09:38 +0200
Message-ID: <20250513150939.61319-3-axfo@kvaser.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513150939.61319-1-axfo@kvaser.com>
References: <20250513150939.61319-1-axfo@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0065.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::19) To AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:3ed::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1652:EE_|AM9P193MB1096:EE_
X-MS-Office365-Filtering-Correlation-Id: 834bdb81-756a-4bdf-6bf5-08dd92304231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o+04cpkdMlDjwzDzhuaZNsVZkmv5cGa534gF4R3KGi8vak4iliRzCcV+lwPX?=
 =?us-ascii?Q?AWI3Ibs8KPM557lC9xEK9WxCLOfI2CrVIWQqiPJaiHWASctsB60YNfW0xnka?=
 =?us-ascii?Q?c+bt3895qM650FTkWvgCX+I/DUpbUzH+7Aat9/FdRdfLxrDkDG06/VIaddbA?=
 =?us-ascii?Q?GZcWPeKVn9MIymittqtSjFH9qo61p+4m2kxFuhY3dg9v3SbcWFnDBhQhHOgk?=
 =?us-ascii?Q?70Qsgq6FNtwsYsJ7Wt0b9M7NmNetAeDSrnWHz5gqRy101LjmkMEHp8enMCCa?=
 =?us-ascii?Q?n+4exkGTdr8SOavlqu1emUu77eutAZ2RzA4HxGPycffFTcOrRnC1Hkttuecf?=
 =?us-ascii?Q?8sUUPgQrp3os8d3LmbjBI9nZYOQpuOZDgauoKujdXRQmKNpup97qtB81vBdz?=
 =?us-ascii?Q?PsNfmnRjty0T72JzwzVfWfm5HiJR/Pjqm5568pgeNoQ9AbK6sZHkqcVSCilP?=
 =?us-ascii?Q?5vqH5brRAFeg+iTyXJuTvsLSaQa51laNw+R5hC7/aOeF0sZP7mZD1zoLKVOT?=
 =?us-ascii?Q?u1nVzZvFLejmUhpR6IFCEdgwQsvjRGmt/we7H3AOEV7IXU85dnG5TVZGs5P4?=
 =?us-ascii?Q?wMfafzpWNJHtAbevW9RJ4LRWg7Wc9tqIHiUGW13s0Sgnfr40xe05Rv6UOjyM?=
 =?us-ascii?Q?+typZ2gEESea6QJJ+VGmxoerp0eYJBnJU/aMe7XczbaLV6zDGdazn5LLzB/+?=
 =?us-ascii?Q?Kqxke4AkCekxkMA8SzDX4xlJ4w4OW4cjudpVn03YnsnUvogLDjsSiTiqc60x?=
 =?us-ascii?Q?3jtpq+VxAs0ufWvpg/adzx4xJ30NWZ7y9tQ+QcRdCjoh9SjK+luFnWCbLf69?=
 =?us-ascii?Q?/7qvgOxKIhC7qoLJ6jLS5CsQTvc+kqOWIeV3Wzc2JRu3SHyq9exZJutmGtM4?=
 =?us-ascii?Q?+pXGobLmHpBLplJDE77HMM9LU3M7pI/o6fvzxTvMMRhR2nHcyO84kgSOruhp?=
 =?us-ascii?Q?aSWqPt5D1mSMrep7YkgACtDo/TZxakW4xlkMjQpMNvZUFye4qqhD6CiJ9Mkd?=
 =?us-ascii?Q?A50mipDp2SFhsx1CJfA3PCSaNqMDIgcD9m8mljvWuGzjIlrVPAgIcfxqmBoh?=
 =?us-ascii?Q?+h1kR0t8tdTgJaKMb6YGXWK+gNXlxMxhx+/JiCgxZ59LXaxcDQgHypN50Crh?=
 =?us-ascii?Q?GmONl8zkG33MH2QjIGmbuAdwGg1M6e1e/GBYF7yl78tTDMKYFVO+3ULmCR65?=
 =?us-ascii?Q?zm/zjbRUaz4MCmkHwD8ebKY2gCAbCZ6to5GIqdTBiDPQtTbXexz91imx46sP?=
 =?us-ascii?Q?KN9nHJEePBrW+LTui1PKF5qntAO4/0z0kRkP8RjmflOygKchG4TwQAdCBDXX?=
 =?us-ascii?Q?7nMFyPFMndjSaR2Yf5fAvJ8kk1cWiEZgrgk4xjsMp/PQuD53lXvJvK26m4Pf?=
 =?us-ascii?Q?ToL+YvT042hQGExrvvHxUidl407pnBL42JQtsRgRTGjqoDtfWhvt6afjVFbl?=
 =?us-ascii?Q?TvJ7GRFxnYw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1652.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MBCU6DyU8JrJJc5EHE4ZxwklFD0AOmSRiDLUHxcBcGE/TkHcHslu0ghVWJj5?=
 =?us-ascii?Q?okm74bIv6+yphKwvOW4uIrwE0brp9oHuFmV/rYJi8fxgraq7dnNyUYxZ5pOx?=
 =?us-ascii?Q?YZT6VsFlI2Q/Ng0GBR2ZvHE2KKjxGJuJvMZogV7LFULa1Fj+LDnkk/ZNkvLq?=
 =?us-ascii?Q?RClmdm/FEFpO8Y97BnsLXuT287TTGIHPd+EXDmB+aXKq06nzF5zPZv41Ksp6?=
 =?us-ascii?Q?6qysHD3Ah+XAbKP/uLBB6r+5Lbcr8q8u9Rv/MmMK1GUg2QdDDjKf3oqyUtNr?=
 =?us-ascii?Q?DSlghvq162jSc4sm+8Ac8PJTAxcfLbm0zq9RUZvK0FHGSaNehIGVZ5xHNslv?=
 =?us-ascii?Q?xTbefIFqMUMQBhz3Xrvxxlm1TDOAP+OREbv6eRyoiHiyvjaLSj0LCOs96nmZ?=
 =?us-ascii?Q?WgYQ79++gFHwX5Lk2H621L8qpduWue+PTbZWh4qhNFYqLG13oP60ssThIjbO?=
 =?us-ascii?Q?wZyETonIVsgZZmPMIEjYAD+RB0i3/UrrjY8v5Sm2EstUKIXQggcQDQ1CkMDb?=
 =?us-ascii?Q?iz1cklz4VVv2gXzeRRQTUJcEk1ZgxliubFF2JfNQ6uOCg7WERoDbBQotgNKc?=
 =?us-ascii?Q?OIEYcMxht4lsq76gFdImLy0nlJ/eUgWtVYq6Dec6zMpUu2F23vXpEUHswPXb?=
 =?us-ascii?Q?YU+YFSb/2TIdM1N8sID41oQE0z37hA+BN7pH4dNeCWGOiySg8JctM+1pTRyf?=
 =?us-ascii?Q?YNGJUffYuxEkhv+L5rfAJ4EfZ58K60xFJ2sDmco13fKBFt/R04EvJlCzri8I?=
 =?us-ascii?Q?vlJcEI1LcsyQEtmEl8uVjvbwJOkfgpTrBJ0iLgI6yNaFB/LeaFH+B5b26OX9?=
 =?us-ascii?Q?gUHorggSaQmK0N58cVx1ENHyn1oFME43vO8xq/EvsOCnMNZCJx+wcCoq+2G9?=
 =?us-ascii?Q?PPqhDYdSkX6tpKwP/7PgBZ0cZwxC34DPyPJEUpn8ts8VnzueE/AzdiDOkzt+?=
 =?us-ascii?Q?g6T2/0cTo068Jd56evs7zGMuLUsurjLMgT0ko8nHuJuckh/PhKISMJ+agHoL?=
 =?us-ascii?Q?o6Z5qyqvcQnQZi8BG1Nc/cWAErVP5H6Dcs6qqJKFD4KrP63CP/szN2VYKWRN?=
 =?us-ascii?Q?I1KNXiakawexJ7lQlXYpfdaQiAmLYIOmwzkCikzmSy5X3xndvsjOuwrBM1sC?=
 =?us-ascii?Q?Jzmr7ZPXlHlAhY17ZZsvVuz+/G8E+cK7cJuD4dL4NOgx4HezcBlWnDNCAuEa?=
 =?us-ascii?Q?FZ/U7Uha3Dh5pztg6WWvmI+Kl+yYqH1EMwZU9itOzUusXhI3fq8O0i0CtAqB?=
 =?us-ascii?Q?bPREagXdRf0arZT2MeicNjI4qLueLPgv2pOciORk90VAY0a7ygEZcPWTRma1?=
 =?us-ascii?Q?B7SzopdbuVzcoe+jxWn1oWhK5stfW6yJO8B119n4Y49KifiNXUZ3G0dGWhJ/?=
 =?us-ascii?Q?ZtXgkyHuwEstVzSD1MPvZgZjGbWz4zA3Vte/yDz5v7xL9XlJ2kqQ2i9h4ctF?=
 =?us-ascii?Q?J1uQtZb741Nl6uNvXVwBWsVOZPAyHcjdnf3WRemmUyefscV9/H6dFsNOJbW5?=
 =?us-ascii?Q?g644AAUWQqVM4o7PulY9tAiBeCsybSD8OUU41RHMckT/TMXDhe+9cbxYpVhd?=
 =?us-ascii?Q?aVZhF4sT0VdBTaNz9shvjSAhls8VTxIpewLK0DcT?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834bdb81-756a-4bdf-6bf5-08dd92304231
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 15:10:12.4169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/0+yDKSdwIeOf/f6AKXZh6bFIjYvr9orPLZMXilBncoJ8X9hoWvFev7Mnl5ZTOQjgOCGFt5buprPnER8ykwvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1096

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
 drivers/net/can/kvaser_pciefd.c | 91 +++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 34 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 4d84f7d13c6f..6cb657018cdf 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -16,6 +16,7 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/timer.h>
+#include <net/netdev_queues.h>
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Kvaser AB <support@kvaser.com>");
@@ -410,10 +411,13 @@ struct kvaser_pciefd_can {
 	void __iomem *reg_base;
 	struct can_berr_counter bec;
 	u8 cmd_seq;
+	u8 tx_max_count;
+	u8 tx_idx;
+	u8 ack_idx;
 	int err_rep_cnt;
-	int echo_idx;
+	unsigned int completed_tx_pkts;
+	unsigned int completed_tx_bytes;
 	spinlock_t lock; /* Locks sensitive registers (e.g. MODE) */
-	spinlock_t echo_lock; /* Locks the message echo buffer */
 	struct timer_list bec_poll_timer;
 	struct completion start_comp, flush_comp;
 };
@@ -714,6 +718,9 @@ static int kvaser_pciefd_open(struct net_device *netdev)
 	int ret;
 	struct kvaser_pciefd_can *can = netdev_priv(netdev);
 
+	can->tx_idx = 0;
+	can->ack_idx = 0;
+
 	ret = open_candev(netdev);
 	if (ret)
 		return ret;
@@ -745,21 +752,26 @@ static int kvaser_pciefd_stop(struct net_device *netdev)
 		del_timer(&can->bec_poll_timer);
 	}
 	can->can.state = CAN_STATE_STOPPED;
+	netdev_reset_queue(netdev);
 	close_candev(netdev);
 
 	return ret;
 }
 
+static unsigned int kvaser_pciefd_tx_avail(const struct kvaser_pciefd_can *can)
+{
+	return can->tx_max_count - (READ_ONCE(can->tx_idx) - READ_ONCE(can->ack_idx));
+}
+
 static int kvaser_pciefd_prepare_tx_packet(struct kvaser_pciefd_tx_packet *p,
-					   struct kvaser_pciefd_can *can,
+					   struct can_priv *can, u8 seq,
 					   struct sk_buff *skb)
 {
 	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 	int packet_size;
-	int seq = can->echo_idx;
 
 	memset(p, 0, sizeof(*p));
-	if (can->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+	if (can->ctrlmode & CAN_CTRLMODE_ONE_SHOT)
 		p->header[1] |= KVASER_PCIEFD_TPACKET_SMS;
 
 	if (cf->can_id & CAN_RTR_FLAG)
@@ -782,7 +794,7 @@ static int kvaser_pciefd_prepare_tx_packet(struct kvaser_pciefd_tx_packet *p,
 	} else {
 		p->header[1] |=
 			FIELD_PREP(KVASER_PCIEFD_RPACKET_DLC_MASK,
-				   can_get_cc_dlc((struct can_frame *)cf, can->can.ctrlmode));
+				   can_get_cc_dlc((struct can_frame *)cf, can->ctrlmode));
 	}
 
 	p->header[1] |= FIELD_PREP(KVASER_PCIEFD_PACKET_SEQ_MASK, seq);
@@ -797,22 +809,24 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
 					    struct net_device *netdev)
 {
 	struct kvaser_pciefd_can *can = netdev_priv(netdev);
-	unsigned long irq_flags;
 	struct kvaser_pciefd_tx_packet packet;
+	unsigned int seq = can->tx_idx & (can->can.echo_skb_max - 1);
+	unsigned int frame_len;
 	int nr_words;
-	u8 count;
 
 	if (can_dev_dropped_skb(netdev, skb))
 		return NETDEV_TX_OK;
+	if (!netif_subqueue_maybe_stop(netdev, 0, kvaser_pciefd_tx_avail(can), 1, 1))
+		return NETDEV_TX_BUSY;
 
-	nr_words = kvaser_pciefd_prepare_tx_packet(&packet, can, skb);
+	nr_words = kvaser_pciefd_prepare_tx_packet(&packet, &can->can, seq, skb);
 
-	spin_lock_irqsave(&can->echo_lock, irq_flags);
 	/* Prepare and save echo skb in internal slot */
-	can_put_echo_skb(skb, netdev, can->echo_idx, 0);
-
-	/* Move echo index to the next slot */
-	can->echo_idx = (can->echo_idx + 1) % can->can.echo_skb_max;
+	WRITE_ONCE(can->can.echo_skb[seq], NULL);
+	frame_len = can_skb_get_frame_len(skb);
+	can_put_echo_skb(skb, netdev, seq, frame_len);
+	netdev_sent_queue(netdev, frame_len);
+	WRITE_ONCE(can->tx_idx, can->tx_idx + 1);
 
 	/* Write header to fifo */
 	iowrite32(packet.header[0],
@@ -836,14 +850,7 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
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
+	netif_subqueue_maybe_stop(netdev, 0, kvaser_pciefd_tx_avail(can), 1, 1);
 
 	return NETDEV_TX_OK;
 }
@@ -970,6 +977,8 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can->kv_pcie = pcie;
 		can->cmd_seq = 0;
 		can->err_rep_cnt = 0;
+		can->completed_tx_pkts = 0;
+		can->completed_tx_bytes = 0;
 		can->bec.txerr = 0;
 		can->bec.rxerr = 0;
 
@@ -983,11 +992,10 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		tx_nr_packets_max =
 			FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_MASK,
 				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
+		can->tx_max_count = min(KVASER_PCIEFD_CAN_TX_MAX_COUNT, tx_nr_packets_max - 1);
 
 		can->can.clock.freq = pcie->freq;
-		can->can.echo_skb_max = min(KVASER_PCIEFD_CAN_TX_MAX_COUNT, tx_nr_packets_max - 1);
-		can->echo_idx = 0;
-		spin_lock_init(&can->echo_lock);
+		can->can.echo_skb_max = roundup_pow_of_two(can->tx_max_count);
 		spin_lock_init(&can->lock);
 
 		can->can.bittiming_const = &kvaser_pciefd_bittiming_const;
@@ -1510,19 +1518,21 @@ static int kvaser_pciefd_handle_ack_packet(struct kvaser_pciefd *pcie,
 		netdev_dbg(can->can.dev, "Packet was flushed\n");
 	} else {
 		int echo_idx = FIELD_GET(KVASER_PCIEFD_PACKET_SEQ_MASK, p->header[0]);
-		int len;
-		u8 count;
+		unsigned int len, frame_len = 0;
 		struct sk_buff *skb;
 
+		if (echo_idx != (can->ack_idx & (can->can.echo_skb_max - 1)))
+			return 0;
 		skb = can->can.echo_skb[echo_idx];
-		if (skb)
-			kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
-		len = can_get_echo_skb(can->can.dev, echo_idx, NULL);
-		count = FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
-				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
+		if (!skb)
+			return 0;
+		kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
+		len = can_get_echo_skb(can->can.dev, echo_idx, &frame_len);
 
-		if (count < can->can.echo_skb_max && netif_queue_stopped(can->can.dev))
-			netif_wake_queue(can->can.dev);
+		/* Pairs with barrier in kvaser_pciefd_start_xmit() */
+		smp_store_release(&can->ack_idx, can->ack_idx + 1);
+		can->completed_tx_pkts++;
+		can->completed_tx_bytes += frame_len;
 
 		if (!one_shot_fail) {
 			can->can.dev->stats.tx_bytes += len;
@@ -1638,11 +1646,26 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
 {
 	int pos = 0;
 	int res = 0;
+	unsigned int i;
 
 	do {
 		res = kvaser_pciefd_read_packet(pcie, &pos, dma_buf);
 	} while (!res && pos > 0 && pos < KVASER_PCIEFD_DMA_SIZE);
 
+	/* Report ACKs in this buffer to BQL en masse for correct periods */
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


