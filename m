Return-Path: <linux-can+bounces-3724-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C72AC7182
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 21:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EAE51BC536C
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 19:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97AA21D3D0;
	Wed, 28 May 2025 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="IvBe73y3"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D55721CC47;
	Wed, 28 May 2025 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748460452; cv=none; b=bjT907LDwnvjcpPUp9/sEx85vFyTkdS0EcQOrOFoYd4DuAb0Z1HZFNcuqFBh5A7BiSnG+Fub2ZAmOLeMqkLFfr5u2M2WWTxgZal9uHF3cbEkUPnXXpDJYc+07FdQqL/rAmZ+bfyEbs6YYQ6C/SFuZflHmz2t1Nw1W5NTXj82n5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748460452; c=relaxed/simple;
	bh=a961YRNnSO8xEEQjmE/kukEuP4H3dhHAVCGU7GMX4s0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7gerlO/3UH57A+arjmMZODcNg1gnhpz3DewNCA0N+kNnr04RTpFzNYa3ea6hDz4IS9garbz6/EvzGLgDLJajTITRT8yR4Hrne2UjoMf7sdeiJiaIhrxLyB99sBuEksyEC7Q1NR6YHA3I/csY14tyKGyRdCIu36ZWrzgGsomssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=IvBe73y3; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.4])
	by mail.ispras.ru (Postfix) with ESMTPSA id BB05D552F529;
	Wed, 28 May 2025 19:27:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BB05D552F529
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1748460441;
	bh=BEK94JMRaUzZgTwrnHfaduJF4K/hbb6wOIgbXm6+ms0=;
	h=From:To:Cc:Subject:Date:From;
	b=IvBe73y3OdsWLVmYMMLB8hzBGkZ4LCVKHc0IWk7qsVTmAwxuNf4+n5jM4YoJ0zWcb
	 TBUu+6OZUU2zAKNvyAKjErW01UiaVEYEmi3ndw3PB8uupl4Ps3wVttqCCetkgcNZwl
	 VD+TsqGBP44NvXJi/lo9lcoTcRoaLeLXMo7g0vwA=
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
Subject: [PATCH v2] can: kvaser_pciefd: refine error prone echo_skb_max handling logic
Date: Wed, 28 May 2025 22:27:12 +0300
Message-ID: <20250528192713.63894-1-pchelkin@ispras.ru>
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

Tx max count definitely matters for kvaser_pciefd_tx_avail(), but for seq
numbers' generation that's not the case - we're free to calculate them as
would be more convenient, not taking tx max count into account. The only
downside is that the size of echo_skb[] should correspond to the max seq
number (not tx max count), so in some situations a bit more memory would
be consumed than could be.

Thus make the size of the underlying echo_skb[] sufficient for the rounded
max tx value.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 8256e0ca6010 ("can: kvaser_pciefd: Fix echo_skb race")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

v2: fix the problem by rounding up the KVASER_PCIEFD_CAN_TX_MAX_COUNT
    constant when allocating candev (Axel Forsman)

 drivers/net/can/kvaser_pciefd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index f6921368cd14..0071a51ce2c1 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -966,7 +966,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		u32 status, tx_nr_packets_max;
 
 		netdev = alloc_candev(sizeof(struct kvaser_pciefd_can),
-				      KVASER_PCIEFD_CAN_TX_MAX_COUNT);
+				      roundup_pow_of_two(KVASER_PCIEFD_CAN_TX_MAX_COUNT));
 		if (!netdev)
 			return -ENOMEM;
 
@@ -995,7 +995,6 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can->tx_max_count = min(KVASER_PCIEFD_CAN_TX_MAX_COUNT, tx_nr_packets_max - 1);
 
 		can->can.clock.freq = pcie->freq;
-		can->can.echo_skb_max = roundup_pow_of_two(can->tx_max_count);
 		spin_lock_init(&can->lock);
 
 		can->can.bittiming_const = &kvaser_pciefd_bittiming_const;
-- 
2.49.0


