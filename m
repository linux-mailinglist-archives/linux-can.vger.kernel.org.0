Return-Path: <linux-can+bounces-2512-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 796C79FE70D
	for <lists+linux-can@lfdr.de>; Mon, 30 Dec 2024 15:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C79AA7A00D1
	for <lists+linux-can@lfdr.de>; Mon, 30 Dec 2024 14:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08F12594A6;
	Mon, 30 Dec 2024 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="hYcnAvTe"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2118.outbound.protection.outlook.com [40.107.249.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208F425948F
	for <linux-can@vger.kernel.org>; Mon, 30 Dec 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568868; cv=fail; b=lch0vyVQiWa4KKcplU9q9sDX5F63vXNDjVZcR9q2xzjZcDjROxsNxrJcM5f0m57CjHyTzNQY9o9mQqy+Ueu9dVxLEQ8XQPgJKHDJ0I/45Bmxh8mUkKWrhncdymy+J5l/quZ7S1Efs4UePp43yqQLdt7WWSLelC1qSA4/iXRLf1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568868; c=relaxed/simple;
	bh=lxVCjL4MZ4BeoHizSoR1/wu+DT6Jm4uqQtFzlAtnO10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rj7Zk2IFkAKMHcDogiEUkul/i3pNKgXw6wrQByPcASpwa+Q4nxU0kq5ScLswYw3OGhmDWtFHBlFn1eXCzaK/QrPPuOvHqQ/RwKuxPFHT0TmWckt17NncIHfjyNjOfoQKjU13ZTGYd213OI6/MOoRhPsgw5eAesX/PetfMi0z5kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=hYcnAvTe; arc=fail smtp.client-ip=40.107.249.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSAn+Y4wv4ko+qWqB5tgaYcxap6inMeAJY/CXjb9DTO32wMQe+UiS39ZVDlr42xEecKxRNHtFRUOCovypcL+NIPeCuNu2+EMlx5tpfZOztU92O2J37Yjl9WTguFV00EpDSrOiUieOX/fe5dOAef4GHNrqqtdoH0owIt1Y+SfG6ql9jQ6ShYDiH1UDf11xSZ0eQYP0PTzfrLLhBmDTVLtYdqdaUrsdk5+30cok+6gTQ+8xfXYKfuc3aJ1FJo+X90W4sAppmxO1F+HUQxfcv72xX4AV2cx8SlAzatlAoo+0JnsteK4aC+mWDCW4Q2HTMd4bkdJ4fr7l+hH5UAV5+cn5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjfeFB2EN/YKFLMCHT1pf/ocLf+usqKo76o5obhmGn0=;
 b=apIv11V8ZdvkurAuWllIbizL0JOFpXBpIfjsRtios08bPKkallCx1/iXiiNu/F1epzvmY8S6tO/Z1pJqC7rusm9i3CK7i/daUfh5VPUAcQRVCJCzbIfX6cRHpS59e8IPY0dpPQ/2FjRQ3E/A/RHYjMb+bGbcLbI19cI769Dli3M5cnZNTZyN2pyk5VLAZfP4zrDuqL+x2C3aqTOYcWDr/1CYKhe6q3/ycgbfYbhIJ28FOkxLsS1kBdlGuLwP2p2GjyOtIpEnZOhQ/fAB84imY6ynE9j073L0pOPojmX2rtNa7L+DFzhjbrDaEEb6MTFqcJHuIpDLr86NJ2gPDEimHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjfeFB2EN/YKFLMCHT1pf/ocLf+usqKo76o5obhmGn0=;
 b=hYcnAvTehfqqVtcXrTFQsYAVUeV5syCy+2H8hOldgClLgPT0SwkcCvAz7nKefWa+lU6JQbwpCyQil7kExsnZJwCpnh3v5ggClC3O5+Ixr4dsPsobdv8cDqGjtQbjxOuK1IQCkGxOBLC39imd6RApb6EGRMhu/6D4+0/nDkaSoIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB0820.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Mon, 30 Dec
 2024 14:27:39 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%4]) with mapi id 15.20.8293.000; Mon, 30 Dec 2024
 14:27:39 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 3/4] can: kvaser_pciefd: Update stats and state even if alloc_can_err_skb() fails
Date: Mon, 30 Dec 2024 15:26:44 +0100
Message-ID: <20241230142645.128244-3-extja@kvaser.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241230142645.128244-1-extja@kvaser.com>
References: <20241230142645.128244-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E44.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::51) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM8P193MB0820:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a41eb91-7c7f-47c1-359a-08dd28de1d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XA8tm92Pc5MZniaFTdkORB8vK9ksiLfa5drTZahiYDvGripc99kEjJt/Ps/M?=
 =?us-ascii?Q?zKiSbPD4Saa+e01WVy6y84pQdYY5t8mOM5SOkDJDCnNY0tbJarfm49zpvIFV?=
 =?us-ascii?Q?RjNZjYyYMsb/nUou3H4CgGLUeYSKqpbWCqtQPmA7EM7WNySRWqOH04L98t24?=
 =?us-ascii?Q?N1TvH8/7GHZ1bWdU2fFAWcnHoUX1ebL3ggkhkFV8id0cWlD/kAKZ5H5Hfnbp?=
 =?us-ascii?Q?I3RL/bMRgDAPCDxF1Tna9jNQmdaLhEZyNGNDZWqHNUhk4iiR6nEtmdkquYvs?=
 =?us-ascii?Q?9gCacDvg04APah6PvOvV/G7Aw/dXtzDHGLPXtYvnkAZnHNJPFt0HoKvVPxag?=
 =?us-ascii?Q?cA7oYAVMDk+qAvCtqhZjO/3lgtuD3BByLay3PvNJb8uZPQlv6M7E1+UH4MGN?=
 =?us-ascii?Q?tEpyMDjZUpKX5mxPv6iGKrOtJs41E/lKavIGQSe9vFV5RH0EnCH8hXnn1FtQ?=
 =?us-ascii?Q?QHjdbWuhPVvumcW2NuNx1IRePz+TJxtneQzIQIN9Yk65EuhKsGxefF1OTAva?=
 =?us-ascii?Q?EGTmnPoxIHd8N1WHOtavUja+7F7jqZoq3efapHCUZrEaO//ZyDv62vMpB5hj?=
 =?us-ascii?Q?2OWXOs/g5fOGOx+waxWtrZApzKIm2lfu0sv7cWiRFfeq/awgScFpxXpYiJbO?=
 =?us-ascii?Q?LFvgKAcxUwTUxkh/PlVbdlX8q55DwiUNJeBNVQ4+wepAtj4cNP/R4s74Djto?=
 =?us-ascii?Q?OFrZX31CeWry26jHMS1bd/4mfrJvxtLjbpNxVj4sY2mtmP6jLuG9OHdFUQGa?=
 =?us-ascii?Q?Gvk2G3WKj2KEj8ipD8cCjAx0l3O0p+Y2Ng1IcnSBtR8ACcHrDqP4A4l0i4Q7?=
 =?us-ascii?Q?b5dHIItLc6cQEHgSyEQbUDda05e35X78D3X9v5wWz6z5k+QzzPo1inKZHRM4?=
 =?us-ascii?Q?BBqNHlM7RQiYKM6SMLBo6p81AOcLKLKOPuZBuLDrE/d1kTAyXCIDWxEyiHMF?=
 =?us-ascii?Q?7qd7ahzlhNxmmvgP/CAa+ZECRPjI+IllWZ7Kj58JCU616LhvGfmL2Qe0OqCk?=
 =?us-ascii?Q?Tlnu2MCBwtqPG+lMZTDsJQF4kuZqukxe1M7zWk4HtgZVXJ/iyOQrd9ncwawc?=
 =?us-ascii?Q?E5fKvJ174mBOeHrrP7zN5zUfH1beEZA9w0SeBOS7NrsEkj5toFyIXVwnbDxm?=
 =?us-ascii?Q?sR3gldaGnahUEzZVbw9/TjISz/1AhSkHgSTDR1FW7cFCqLMg9VtSez48Nw9X?=
 =?us-ascii?Q?UKFDN5sqVwmuB1Ra9I0EJrf0jl2PRieoqbVk5TxQsCDXG1q1suZKonIcElLR?=
 =?us-ascii?Q?nDl6YsPGlflwM/RSMPHUv/WAx3pKeSHPuqi3FAoGBiMa3N9KC6Fq4jKz9V3L?=
 =?us-ascii?Q?OhVDZXc7azxvmbG0igFnuiQDvpWyBRun3Cev65TG24ROUusxYiJj1ltlEArY?=
 =?us-ascii?Q?1KsF2lQ9/7+CIxAPMw5akaU1VbXJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bQ5XaXUXsFmhV9W2yi1rzJxoblybevy+mWn6kNBqwovZjPKGKtOewSY7aXTR?=
 =?us-ascii?Q?JJfs/W//+WyI/Nwv3i00bVkiBxsZnznq6nDz0F4BK0Gw6iy7CqkB3JhmUGLs?=
 =?us-ascii?Q?btY4RE9ty6iX4jDNGDMSlcNVfNXjAw1j8rADVJID0SHF+VJa8SHoGOOdP8/O?=
 =?us-ascii?Q?xKhbBBU5Ep+k62eIlwTRH8BurIuFhZKp9lJxMb8UCFgU9XsBIpIgnz9snRf3?=
 =?us-ascii?Q?oQpR2C1DqLcJ6UBZ9NnekN1rYaqYUbi2DMM0+L6EsfWHWmT6r7ro2wMLiM8R?=
 =?us-ascii?Q?fq+aLG5kH3wMcXeRVMKQshqo1a1r7HuYjn3Cq9CdY1Mq4Q45c/QvGg1vIb6y?=
 =?us-ascii?Q?v3Ii5DfSsDzZ3aWMZ6HFCiWlPkgwl1ntfaF7/HUNsStBXxyWD3GP8Q+EJ4Ps?=
 =?us-ascii?Q?iM/jWG5hflxQuAf0VAm8bPrSzg0YcLRJgisL/7VJav6bKucaYcvC0mcLH33X?=
 =?us-ascii?Q?ykD3wOFR/i6JczZD+y0gwGIqKdT/K5Zha7n9FVKQ7Hv5zVB6zngQEOjvEjHS?=
 =?us-ascii?Q?nPwuAWbryk6EtGJUBayucH9PCmfouKkmQNokmw2G/yi1ak3Kg69c2L183ENB?=
 =?us-ascii?Q?7pBZO7EHUd7aXjU2rbK3FqOYhFrKskTNZgjH6zHXkF5FnlAr6uYPtC3kz9EL?=
 =?us-ascii?Q?12MA3L2RYI2v+I3pcHDsuNmVoU/rSG2YytAdJ6XpUqGk/46UaR6rZhcQyvHZ?=
 =?us-ascii?Q?h1SgJPfiO5wcCZpIHdUD34jAmDZ9e93Fhzlwi7Q8hiE7J1GORqRd/a2oGJJH?=
 =?us-ascii?Q?miRMBaHUZ4vYrPZQUANPapHDNIQP2/r2huTOiDusGRTK7x7WLg7wrapFDgmk?=
 =?us-ascii?Q?+VO6gf6xI1cz4GW3AjVVaPPCQHglz9lV53tSNAMYYZO1hTMJBh9Qvy+w4j2s?=
 =?us-ascii?Q?EXV8yH/S1kxcP3mq4m4dlAyWidlJfdLL+c+m9fPPdQ1RtW5lLZO6HRs4icUU?=
 =?us-ascii?Q?Dct5w4NEaCsfNy41PWG0QSTCk1aLqScSghxxIlGdiDKQ6EOGZbBZiH6xaapt?=
 =?us-ascii?Q?f61JwOiNSz6Mw+inaS4i/8fu+VofpWKcVUp4Y/LKq5D3sUqUBSVy5ec+rnFJ?=
 =?us-ascii?Q?suth4BC7jvtxa06fTnvD0Yk/M0WWPtAaWqmjOz7IH8tYIGCXSNLWRhGRTZR8?=
 =?us-ascii?Q?/FkpVmuRGEmCpkmqZqUom2+QqS6Cnu+vAgE1e9tMQBpSRFxNtqk0Nzts4tc1?=
 =?us-ascii?Q?B9KfaOM7SfNypIJFlfvVw0YhkJFRs9LmsTggYCwPjw5GJEi9aOsI+BZdKJjY?=
 =?us-ascii?Q?lBk8FUrKNEFo36rn1rF2knGm/PZVz7VqfbXfed3Eirgdnwz1IWjXnx/1XgEX?=
 =?us-ascii?Q?vTejMljvhmS4aZKVAIjCUZnUCd/URW4xPhxag1TmxORAEOYffXB3iwd/qq56?=
 =?us-ascii?Q?SeMJG01+6pZ5Lvxl8tR5UkVBVwaP5IegrkTMVe9EqsdPhyayADmEz0QeyOUA?=
 =?us-ascii?Q?/UdhjC0w7vTNRqSWzN49IXVNEDsbyOKDpIP3rfLsQFjenc/u/LPBJoFyq9ZE?=
 =?us-ascii?Q?hFg3uZWTxq83gENlz5D0lL0ru2nIB3Vqyf+lkXdKEHu9/iJoI/AVfkr7HApu?=
 =?us-ascii?Q?7QKXA3qrlvAXs2uNSDLnTNxlyMb0AUVZqkD+V0WWBwKUSidINj7fmQUwPV8d?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a41eb91-7c7f-47c1-359a-08dd28de1d21
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 14:27:39.4678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZn0E11ELVU9PTOj4RRqwIpxMy4AL9P8Q/71HDJbZ5QsbzxL4tb7SSLXaM1eeaCE8GQueG/na43kgksgQNycfFXJtRvmmM9J+BjT5XdnNRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB0820

Ensure statistics, error counters, and CAN state are updated consistently,
even when alloc_can_err_skb() fails during state changes or error message
frame reception.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 52 ++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index fee012b57f33..e12ff12c4ba3 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1234,11 +1234,15 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 }
 
 static void kvaser_pciefd_change_state(struct kvaser_pciefd_can *can,
+				       const struct can_berr_counter *bec,
 				       struct can_frame *cf,
 				       enum can_state new_state,
 				       enum can_state tx_state,
 				       enum can_state rx_state)
 {
+	enum can_state old_state;
+
+	old_state = can->can.state;
 	can_change_state(can->can.dev, cf, tx_state, rx_state);
 
 	if (new_state == CAN_STATE_BUS_OFF) {
@@ -1254,6 +1258,18 @@ static void kvaser_pciefd_change_state(struct kvaser_pciefd_can *can,
 			can_bus_off(ndev);
 		}
 	}
+	if (old_state == CAN_STATE_BUS_OFF &&
+	    new_state == CAN_STATE_ERROR_ACTIVE &&
+	    can->can.restart_ms) {
+		can->can.can_stats.restarts++;
+		if (cf)
+			cf->can_id |= CAN_ERR_RESTARTED;
+	}
+	if (cf && new_state != CAN_STATE_BUS_OFF) {
+		cf->can_id |= CAN_ERR_CNT;
+		cf->data[6] = bec->txerr;
+		cf->data[7] = bec->rxerr;
+	}
 }
 
 static void kvaser_pciefd_packet_to_state(struct kvaser_pciefd_rx_packet *p,
@@ -1299,14 +1315,7 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 	kvaser_pciefd_packet_to_state(p, &bec, &new_state, &tx_state, &rx_state);
 	skb = alloc_can_err_skb(ndev, &cf);
 	if (new_state != old_state) {
-		kvaser_pciefd_change_state(can, cf, new_state, tx_state, rx_state);
-		if (old_state == CAN_STATE_BUS_OFF &&
-		    new_state == CAN_STATE_ERROR_ACTIVE &&
-		    can->can.restart_ms) {
-			can->can.can_stats.restarts++;
-			if (skb)
-				cf->can_id |= CAN_ERR_RESTARTED;
-		}
+		kvaser_pciefd_change_state(can, &bec, cf, new_state, tx_state, rx_state);
 	}
 
 	can->err_rep_cnt++;
@@ -1359,6 +1368,7 @@ static int kvaser_pciefd_handle_status_resp(struct kvaser_pciefd_can *can,
 {
 	struct can_berr_counter bec;
 	enum can_state old_state, new_state, tx_state, rx_state;
+	int ret = 0;
 
 	old_state = can->can.state;
 
@@ -1372,25 +1382,15 @@ static int kvaser_pciefd_handle_status_resp(struct kvaser_pciefd_can *can,
 		struct can_frame *cf;
 
 		skb = alloc_can_err_skb(ndev, &cf);
-		if (!skb) {
+		kvaser_pciefd_change_state(can, &bec, cf, new_state, tx_state, rx_state);
+		if (skb) {
+			kvaser_pciefd_set_skb_timestamp(can->kv_pcie, skb, p->timestamp);
+			netif_rx(skb);
+		} else {
 			ndev->stats.rx_dropped++;
-			return -ENOMEM;
+			netdev_warn(ndev, "No memory left for err_skb\n");
+			ret = -ENOMEM;
 		}
-
-		kvaser_pciefd_change_state(can, cf, new_state, tx_state, rx_state);
-		if (old_state == CAN_STATE_BUS_OFF &&
-		    new_state == CAN_STATE_ERROR_ACTIVE &&
-		    can->can.restart_ms) {
-			can->can.can_stats.restarts++;
-			cf->can_id |= CAN_ERR_RESTARTED;
-		}
-
-		kvaser_pciefd_set_skb_timestamp(can->kv_pcie, skb, p->timestamp);
-
-		cf->data[6] = bec.txerr;
-		cf->data[7] = bec.rxerr;
-
-		netif_rx(skb);
 	}
 	can->bec.txerr = bec.txerr;
 	can->bec.rxerr = bec.rxerr;
@@ -1398,7 +1398,7 @@ static int kvaser_pciefd_handle_status_resp(struct kvaser_pciefd_can *can,
 	if (bec.txerr || bec.rxerr)
 		mod_timer(&can->bec_poll_timer, KVASER_PCIEFD_BEC_POLL_FREQ);
 
-	return 0;
+	return ret;
 }
 
 static int kvaser_pciefd_handle_status_packet(struct kvaser_pciefd *pcie,
-- 
2.46.0


