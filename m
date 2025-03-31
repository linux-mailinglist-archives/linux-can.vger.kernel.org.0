Return-Path: <linux-can+bounces-3299-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E224A76001
	for <lists+linux-can@lfdr.de>; Mon, 31 Mar 2025 09:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936A2188A11F
	for <lists+linux-can@lfdr.de>; Mon, 31 Mar 2025 07:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDE11B423C;
	Mon, 31 Mar 2025 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="bSwQimc5"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2131.outbound.protection.outlook.com [40.107.105.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2121A19CC20;
	Mon, 31 Mar 2025 07:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743405955; cv=fail; b=YxkJAImgTWleL1HOX6o5EHB706GAyNHMkjj6zo4KUwE0F0zQDP5Bvo8v7Kq8dT8deS/CgXoytu3ZLlLH3xdFVox25/N7xjahcVtxJfxkEgH4pisZ4lUn0sH5jEg+8hjT9HjqIU+0s1aPfjn/UXxFsgh/k3gnC90RqhHgw3WHOe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743405955; c=relaxed/simple;
	bh=X2Dd6relzpgyjNPLJVwgboHvqOx4Z5D/EQgzYMotwEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j+ClkoJgFsWB6vMU/ASCy+UUDtFtW8878q995HdWP43N5GLzWfvXjUKfiNTpZ5kNwxM+4A57g20q2QZNMF0pQ9xtedFfFM5cQmzpVHor+yNbnlDY3o12TuLVwsqZQjfoQHv0rxiZomQH9THIAsQyLDGFwEoVdphUbJAArnzbS+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=bSwQimc5; arc=fail smtp.client-ip=40.107.105.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEyBIKY81HEQjs0UvuKEQIcbOLfxwWs/EVIWzTQycOx4kA5/pBT7mZbopudCxmOt8IstOUsVYCzziDCHg9tvID8oBgLJn0XkogRHZ2mB+AACXePN/5zOCwlDcVY0HZkExmxeTsT9BU3FTVx1VbPOMyF1/PemFGWnFtiK0wp1JNeK4cYShY6qyFnlXupdgObZ/tK/r1zvKmJnthCAoj4K5uEpm7CrbBjJqa6asm4qMJV9G9ySgdBiv9sm0j96Q+SH1Vxmx4DmPkNeq+BTJaWaPPbjdT/zO8wLjzvBi2+stbGBWhFlWVKozpAbbthsgC6cLFB7CdYZ4aXiDAphbsW0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3MezwnNz9emlUNluEz33sDgsWXA0ko1z3f0ZkPJ9T8=;
 b=Esc6HV1+RRKzEa9f2I28eh7US062HGekf6gaLQGYUAY6YgGWZJ7DoFLtuXg4K5g4dula9lTs/N7cqyY/eGqs4Zb3yHqELUJWumbg2gu1NRcoD9z0zcWPfUn9UP9Ap8F/f6QzxfTK2gQPSNejaSm+j9V6DcCarPp9OYmPK2lsB+emR/nGJvL3xGJVebSm9p/gWG2tfaTDQdjBM3DIVObqx9f/dAoDKP4xVjV9H0GYqMefWclgjtUkb/xEwGGjBAjnptpjkAnvhjxtq/9HRx8v8jKi3UgQ2iqOAERri3jbTwnejNrHDu3DzrcYECK5pZiYRZshaDFeoZ6YAw4G5xY5jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3MezwnNz9emlUNluEz33sDgsWXA0ko1z3f0ZkPJ9T8=;
 b=bSwQimc5jYAdw2mHM+KIkTA3aK+GbqvVtDSElOzkkq5y7RbIqU5FXRlf9e7/lFwO+YZbPYXU08jS5ZpQXRxVx5FivQyewWY6RxKfKHpjsau9A6yvW+hRAHUFkpaOKPKMefBQyZhiQHm1QVHuj46loxpLPThn3YjHzLj7i7fZ8So=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::14)
 by PR3P193MB0556.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.21; Mon, 31 Mar
 2025 07:25:50 +0000
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18]) by AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18%4]) with mapi id 15.20.8606.021; Mon, 31 Mar 2025
 07:25:50 +0000
From: Axel Forsman <axfo@kvaser.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	Axel Forsman <axfo@kvaser.com>,
	stable@vger.kernel.org,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 3/3] can: kvaser_pciefd: Continue parsing DMA buf after dropped RX
Date: Mon, 31 Mar 2025 09:25:28 +0200
Message-ID: <20250331072528.137304-4-axfo@kvaser.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250331072528.137304-1-axfo@kvaser.com>
References: <20250331072528.137304-1-axfo@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00004592.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::42e) To AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:3ed::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1652:EE_|PR3P193MB0556:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b085a01-c0da-4e75-90cb-08dd7025431c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fdpzkG71Y6/x4/fc6m/MmCBBGaMZdgnFywpkTuQnW1+Y9xbkZeuK7HdGMEag?=
 =?us-ascii?Q?rx/unHZCRgpMGzpS+29FaJ1EJ9UFdTluSH48zDQ835fcXGow1gkrObdGVwnA?=
 =?us-ascii?Q?LiG+wMw3DzOwLN7evf/Iksm8KNVxq4k1mfPpahUn/RgGNv9rOWZ2rSwE9zKq?=
 =?us-ascii?Q?N/mA2YDxa3OjLCdduxpkEt6C9tiLCBVOBqixyuX3sDZVL4o5dzY1aN1XhaVH?=
 =?us-ascii?Q?qJv+auaP/5XUhl7h/n/WvqeRlqIEY8djXU9OOkMJCQ8kshJERrDvK58ZkIR0?=
 =?us-ascii?Q?D3Rc9lo2+Z3Ua5zRkK/KQfC3bHZbHeEsAlzWu20Hj6mNGD9Y5DEkOqlkdc0o?=
 =?us-ascii?Q?wEAHcSyJk5hYQq9h16C3bhwTD5HnPpcGxTABxx4deOf4qLIzfAxlMx968b+v?=
 =?us-ascii?Q?PZ7SEnc3oYZOar5rerX4ktSaYUhImPQS6+4+YcD2j7uURm1QZtqCsUk0/G28?=
 =?us-ascii?Q?vbZDU+J+esh1z9BFr9+vR6z4Xhv+dsNKg/FrJKcwyxaYigI9dR1FAYDBGHDe?=
 =?us-ascii?Q?Ii2KtCs4Y8WuNiswjkZR1ADCjld27JK2YAE6Lcvq7ldRrfzNl7e57nbl/t5s?=
 =?us-ascii?Q?X8dDUxmbQgMixSlpZ3DTXZIhk2IyZDXNlGVCvT0n4+CoBb5m6AhOQv/De+fO?=
 =?us-ascii?Q?N6BkQlgS2Cl3Ac7cVllQQNZgK1Q8v8h5BhuhHGf2hFvqdQD07OdIRUo/YrrV?=
 =?us-ascii?Q?SUvdVk9VJlpszIdHoMrCicqcV895qKrYakEzBIU5nQMpGlvfkcsatb518tzo?=
 =?us-ascii?Q?x2ens6OLW45nxOzIzjO/DAtV3ulHMnxjNBU1zlBJfCHlWij+ZpIXLmxRKqsx?=
 =?us-ascii?Q?Rnbmn4TJjjw/uiFxOtXjmX9ZmPUlOUQMUGA7P5xmXzZf3ex/+qdPscWcQOKH?=
 =?us-ascii?Q?no41V1KSgiJX20UrK9djKJ+w+0hPyU8cxELf7tP5AVTrxnYtGS5G24J4tbsi?=
 =?us-ascii?Q?TnVcc3xtnv2zUV9D55YwJXWcSueGRTriWiodoxpUG3qLKmDEiVgSpbqviMlD?=
 =?us-ascii?Q?znwXzcMYfkvc7bNZ8fElMHxxp6tp/gNuXIGkIKwBaNrovh5HAlv933oEuSub?=
 =?us-ascii?Q?PNOaMYtE9P2qEfv6hfu49yLD9j+30exrw4r9Ietu8xuI+vF4hCfPHqpDsCxc?=
 =?us-ascii?Q?i3KNseO97AC/I0DZyv0tpCUnDeM7IGT4Ji4655w/og2kV6qSazNy8zbB+pim?=
 =?us-ascii?Q?qA1h/OrXnI+v/pi3clKQCUz63HLhZJU0McMIsme856aPsWbo+qWJ9k4QdIS3?=
 =?us-ascii?Q?xOcnmsSqV1GfUCceXZV7dKLYoxQVxNSU6Yg2Vi+DGJZyQO/CbIDGtM2EXyrk?=
 =?us-ascii?Q?kkZgw1UBL+g328/aE3vGUB5ZHouNtRkD22pvuULL+u+7ju3WhE0uWM3O2+gy?=
 =?us-ascii?Q?UKItCmPP1+skeMu8jbNSJd5Bpu+k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1652.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d0L1/RyaFC4pXkZkRed8hpGF0BDU7VLtloGTA8wYCE52PSXrgBI6X1vrRaIw?=
 =?us-ascii?Q?Euhs3rTaJYWPmnhQMgvuqVlHynvnZxnQIwLQAhO64ppZ/AJHtA80BeRMZRW3?=
 =?us-ascii?Q?WvyJpE9bzuxCqCw5bNUsixIHVp45eDJ841ZJWOh1h2uQSBe52wdkKP6Fw/DS?=
 =?us-ascii?Q?wjvpWUuRo+x6BX0ygGjNPd/dsSNvHH117hzmX4AucYM7/VPSYBTAJl9BukzC?=
 =?us-ascii?Q?XMdbjHorS2JG3v7QWQLg1vBnfOoe/AytSabhrVjDruTV4o8pzlgnLlVQ5B3N?=
 =?us-ascii?Q?LAw+icnJTS00S/DyB6eTpZsZfklvJLh+mV2tr6YDtl0qga9xRdngDMX8qmoM?=
 =?us-ascii?Q?yKHXeV/Ol/DobranVfR/za5xRz9Io4VG8OyoEdO7q2izIHmcnyQsCHkc6vLV?=
 =?us-ascii?Q?F8rDryabdT654/x3VdmvgVNtFgCoZUBQWSqz2ilPbwx2DzBKmy5EK48N1UkS?=
 =?us-ascii?Q?Sq4uUfWn7Bxw9BtwMaEfWQEOR7Xf2L2ax2YECYVyz4RJgW2M1aGQ1/VOIQAf?=
 =?us-ascii?Q?qeAQsyjtieFrCgIQAPshtENDXnNZzqvTnQFzXg77G0PfcyBpI43H8WdkGC9a?=
 =?us-ascii?Q?DeMPVehiw+sp1bDdVRfvh2wANn/W+qeYfdHrSkM+P+9SyVe9zlv6eMsaFtk8?=
 =?us-ascii?Q?YIUzNDgF+0cni6ZZTlYqH9wHQ9ESOcwF2bpcfpFO82Brs0WZzDDHNb+u8Bsb?=
 =?us-ascii?Q?OFF79zUbCo1yPxCKVbGJ2vnGqKj8JX2s/rGTKT5OJ2FWlnW701UQDJtmg8Nf?=
 =?us-ascii?Q?n2W75xdfbWrXo0GpONJk4pqkDjxuCHd2mIcnwA60LhvLqDeREvMvq4Kxq+Cy?=
 =?us-ascii?Q?zMYXIxPMJbUvt9m1P2GpGg11JeJgwqy7J4BlwWTVV85CMmy2rEZCO851EuaH?=
 =?us-ascii?Q?9Mgr5Yhg9LK5A+1BuPxf0JWPdjBeAFjxb3cGH790NN+J0cdx1MIHoRG2uK6H?=
 =?us-ascii?Q?xbNhqCciwPwPy5nJncbU6RCdSpAUcXEmbR5rCsG7J5LCLAdAY37DlcTdnnto?=
 =?us-ascii?Q?P909Y9+jtLjQuGj8+S5ifkii4dw2R0IG7ADZSuk+GcLlcBf80xGFAwBnVcSk?=
 =?us-ascii?Q?oJPzuBFCAW2vHXyV4qoCkShDp+EWXs2/xTpNeHAt0NujJcRadzfh6laqLGt6?=
 =?us-ascii?Q?BgvUBx5a6pKUfi7rtZqYUtuwyA2fBY0zKUdsHKLxbIAVLCnnDc01FzCz6pIx?=
 =?us-ascii?Q?hEYtZ+TEeTn86gFRi3ko2w2VVy7DxcI+r0wuWg8BwR6fnhRfADLu2aZszMDI?=
 =?us-ascii?Q?xnxyTJ0Y4vALogu3CNxl2rZbFRklZcgRrDlmHrNlUP66+7J9wtq4mgGd9CWp?=
 =?us-ascii?Q?NNnVUP+l5itjFVNR/rhXEB46Vwen0pGzII40YCpaj6yA4hcmBiFgHVmBxg5X?=
 =?us-ascii?Q?IYHsp3jUwWa5IsVzYlmmkDDR/QQTD8uFO7CrhWZZEj28xNLO/OhAaxvM/cSd?=
 =?us-ascii?Q?J7bhMbgj98CZE2xvx3evTlg1gR8uiCu+HoGOJHiMnyjnR6qGfYdAW2hlrsyC?=
 =?us-ascii?Q?OIxoWI2dmiCAaaKWR1tCTu3zB2UppKhvgobD+gTjuRP3pTphs7v3gDVX2ppg?=
 =?us-ascii?Q?NVL2lTRJKVQKNmilDapB+JH6DW/QX+AIz/ng3uqc?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b085a01-c0da-4e75-90cb-08dd7025431c
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 07:25:49.9563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DSrVT560KNOqu4QOkI9A5RfWojRBTvEJ3YxAAvzMVN9vPP5vwcV513WdFBHDHH3FMJipxGK7YFsBZaFw4q2mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0556

Going bus-off on a channel doing RX could result in dropped packets.

As netif_running() gets cleared before the channel abort procedure,
the handling of any last RDATA packets would see netif_rx() return
non-zero to signal a dropped packet. kvaser_pciefd_read_buffer() dealt
with this "error" by breaking out of processing the remaining DMA RX
buffer.

Only return an error from kvaser_pciefd_read_buffer() due to packet
corruption, otherwise handle it internally.

Cc: stable@vger.kernel.org
Signed-off-by: Axel Forsman <axfo@kvaser.com>
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 6251a1ddfa7e..1f4004204fa8 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1216,7 +1216,7 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 		skb = alloc_canfd_skb(priv->dev, &cf);
 		if (!skb) {
 			priv->dev->stats.rx_dropped++;
-			return -ENOMEM;
+			return 0;
 		}
 
 		cf->len = can_fd_dlc2len(dlc);
@@ -1228,7 +1228,7 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 		skb = alloc_can_skb(priv->dev, (struct can_frame **)&cf);
 		if (!skb) {
 			priv->dev->stats.rx_dropped++;
-			return -ENOMEM;
+			return 0;
 		}
 		can_frame_set_cc_len((struct can_frame *)cf, dlc, priv->ctrlmode);
 	}
@@ -1246,7 +1246,9 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 	priv->dev->stats.rx_packets++;
 	kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
 
-	return netif_rx(skb);
+	netif_rx(skb);
+
+	return 0;
 }
 
 static void kvaser_pciefd_change_state(struct kvaser_pciefd_can *can,
-- 
2.47.2


