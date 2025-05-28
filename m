Return-Path: <linux-can+bounces-3717-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1634CAC654E
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 11:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6DE18970A5
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 09:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185E382899;
	Wed, 28 May 2025 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="dL1hm4/V"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A11627465B;
	Wed, 28 May 2025 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423464; cv=none; b=NrSZk2hILB9j2JLGQ8jF15a2wYO1c3g7Y+Yp8jxFJla/PdTkw3IZBqDD67wWYq4mpBtJfyk7xVod9cOr7RQ12UxGZSpY8XQNkawbXz0L4bQzCZOYfxnE9FyOglCJgYqN1qlKYCf21X/binxLo1aX4UoOQPv2qD7/ALSbd++VdxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423464; c=relaxed/simple;
	bh=E13b92T1iobjwwJFKEcVmyQPEeAWMQYjpYx5L+hZ37I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FDPuxWpcufQxTYZpkPCGUcq0MasjtS8ZLJ5wM5pN1xxDtfOgSFu/YLUhCHv7WqHDvJwP8T4S0gXfDBbdeF+ratuwtMqjI0q7AiEWPQ1eHzwpTHw/8aASbevIDXay/BoXjbe4n/y5kZkwVnaklSrzLGd2mu4gLNGCEn2lq1cstJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=dL1hm4/V; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.. (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id 65FD5552F541;
	Wed, 28 May 2025 09:10:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 65FD5552F541
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1748423457;
	bh=BV+bKfOBlaZWJv7Ls9aF2eYeY1S7uRK0NeDHUw8Em1A=;
	h=From:To:Cc:Subject:Date:From;
	b=dL1hm4/Vmsr4xI5AIjQnxz9JxA+rReEoR/HR6/Vl+L4tcnTfjMN8X4Cib5DCcZefP
	 6QiD/2KKEdZEv4faBXly9GB45iU9H3EbeNvgnVsZx88waV4tVNlLEjW9GZmTI2iGnS
	 QJbNupL6U9Ydcwpp5RCowdw9p0RsdlFdQitD9fnA=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Axel Forsman <axfo@kvaser.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Jimmy Assarsson <extja@kvaser.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] can: kvaser_pciefd: refine error prone echo_skb_max handling logic
Date: Wed, 28 May 2025 12:10:37 +0300
Message-ID: <20250528091038.4264-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

echo_skb_max should define the supported upper limit of echo_skb[]
allocated inside the netdevice's priv. The corresponding size value
provided by this driver to alloc_candev() is KVASER_PCIEFD_CAN_TX_MAX_COUNT
which is 17.

But later echo_skb_max is rounded up to the nearest power of two (for the
max case, that would be 32) and the tx/ack indices calculated further
during tx/rx may exceed the upper array boundary. Kasan reported this for
the ack case inside kvaser_pciefd_handle_ack_packet(), though the xmit
function has actually caught the same thing earlier.

 BUG: KASAN: slab-out-of-bounds in kvaser_pciefd_handle_ack_packet+0x2d7/0x92a drivers/net/can/kvaser_pciefd.c:1528
 Read of size 8 at addr ffff888105e4f078 by task swapper/4/0

 CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Not tainted 6.15.0 #12 PREEMPT(voluntary)
 Call Trace:
  <IRQ>
 dump_stack_lvl lib/dump_stack.c:122
 print_report mm/kasan/report.c:521
 kasan_report mm/kasan/report.c:634
 kvaser_pciefd_handle_ack_packet drivers/net/can/kvaser_pciefd.c:1528
 kvaser_pciefd_read_packet drivers/net/can/kvaser_pciefd.c:1605
 kvaser_pciefd_read_buffer drivers/net/can/kvaser_pciefd.c:1656
 kvaser_pciefd_receive_irq drivers/net/can/kvaser_pciefd.c:1684
 kvaser_pciefd_irq_handler drivers/net/can/kvaser_pciefd.c:1733
 __handle_irq_event_percpu kernel/irq/handle.c:158
 handle_irq_event kernel/irq/handle.c:210
 handle_edge_irq kernel/irq/chip.c:833
 __common_interrupt arch/x86/kernel/irq.c:296
 common_interrupt arch/x86/kernel/irq.c:286
  </IRQ>

Remove echo_skb_max rounding as this may increase it to unexpected values.
In this sense restore echo_skb_max handling logic prior to commit
8256e0ca6010 ("can: kvaser_pciefd: Fix echo_skb race").

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 8256e0ca6010 ("can: kvaser_pciefd: Fix echo_skb race")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

Actually the trick with rounding up allows to calculate seq numbers
efficiently, avoiding a more consuming 'mod' operation used in the
current patch.

I see tx max size definitely matters only for kvaser_pciefd_tx_avail(),
but for seq numbers' generation that's not the case - we're free to
calculate them as would be more convenient, not taking tx max size into
account. The only downside is that the size of echo_skb[] should
correspond to the max seq number (not tx max number), so in some
situations a bit more memory would be consumed than could be.

So another approach to fix the problem would be to precompute the rounded
up value of echo_skb_max and pass it to alloc_candev() making the size of
the underlying echo_skb[] sufficient.

If that looks more acceptable, I'll be glad to rework the patch in that
direction.

 drivers/net/can/kvaser_pciefd.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index f6921368cd14..1ec4ab9510b6 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -411,7 +411,6 @@ struct kvaser_pciefd_can {
 	void __iomem *reg_base;
 	struct can_berr_counter bec;
 	u8 cmd_seq;
-	u8 tx_max_count;
 	u8 tx_idx;
 	u8 ack_idx;
 	int err_rep_cnt;
@@ -760,7 +759,7 @@ static int kvaser_pciefd_stop(struct net_device *netdev)
 
 static unsigned int kvaser_pciefd_tx_avail(const struct kvaser_pciefd_can *can)
 {
-	return can->tx_max_count - (READ_ONCE(can->tx_idx) - READ_ONCE(can->ack_idx));
+	return can->can.echo_skb_max - (READ_ONCE(can->tx_idx) - READ_ONCE(can->ack_idx));
 }
 
 static int kvaser_pciefd_prepare_tx_packet(struct kvaser_pciefd_tx_packet *p,
@@ -810,7 +809,7 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
 {
 	struct kvaser_pciefd_can *can = netdev_priv(netdev);
 	struct kvaser_pciefd_tx_packet packet;
-	unsigned int seq = can->tx_idx & (can->can.echo_skb_max - 1);
+	unsigned int seq = can->tx_idx % can->can.echo_skb_max;
 	unsigned int frame_len;
 	int nr_words;
 
@@ -992,10 +991,9 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		tx_nr_packets_max =
 			FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_MASK,
 				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
-		can->tx_max_count = min(KVASER_PCIEFD_CAN_TX_MAX_COUNT, tx_nr_packets_max - 1);
+		can->can.echo_skb_max = min(KVASER_PCIEFD_CAN_TX_MAX_COUNT, tx_nr_packets_max - 1);
 
 		can->can.clock.freq = pcie->freq;
-		can->can.echo_skb_max = roundup_pow_of_two(can->tx_max_count);
 		spin_lock_init(&can->lock);
 
 		can->can.bittiming_const = &kvaser_pciefd_bittiming_const;
@@ -1523,7 +1521,7 @@ static int kvaser_pciefd_handle_ack_packet(struct kvaser_pciefd *pcie,
 		unsigned int len, frame_len = 0;
 		struct sk_buff *skb;
 
-		if (echo_idx != (can->ack_idx & (can->can.echo_skb_max - 1)))
+		if (echo_idx != can->ack_idx % can->can.echo_skb_max)
 			return 0;
 		skb = can->can.echo_skb[echo_idx];
 		if (!skb)
-- 
2.49.0


