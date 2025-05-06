Return-Path: <linux-can+bounces-3547-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC1DAAC736
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 16:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B423BA50E
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 13:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44902820B4;
	Tue,  6 May 2025 13:59:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC231281355
	for <linux-can@vger.kernel.org>; Tue,  6 May 2025 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539988; cv=none; b=bENJ/Q+kk89WZ2GfWimukBWQqGz7GJtMCYWag+sjc0fU+HcUBxqw+6HFpQeIwX8GRE22qepHnmCFeMUW/c6nR4qaO8q1Ymvk+vOziIF+GR8ury0u8ey3dC3YZLvwIQ1GCd+xpIEhX0s0rknshxJlGMIU8QWDszCsUcg4UDjirq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539988; c=relaxed/simple;
	bh=ZcBkrScOOWoftsG0e6ti3c6tLR9Su//vowZDZIAZxZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXl7FAUkhU6tv1Frf+8xhcMtMoPE9xOw753QS/WYorPzCIB7UcCbzAfgGvJSDlvdfx9nmF/g9xvUGiTdSM97lDIjlUu3I6bFrIBA6nuYiHydDuo31dpk33SoCa8UNthCQS+SUm1IH2f+Nu6ddlx8MPE+GYK8FGO5gzO3+Wow6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uCIpk-0007q7-Sw
	for linux-can@vger.kernel.org; Tue, 06 May 2025 15:59:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uCIpk-001P8k-0J
	for linux-can@vger.kernel.org;
	Tue, 06 May 2025 15:59:44 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id ABDDA408F5B
	for <linux-can@vger.kernel.org>; Tue, 06 May 2025 13:59:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id D554A408F34;
	Tue, 06 May 2025 13:59:41 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f1b1daa5;
	Tue, 6 May 2025 13:59:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Antonios Salios <antonios@mwa.re>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 1/6] can: m_can: m_can_class_allocate_dev(): initialize spin lock on device probe
Date: Tue,  6 May 2025 15:56:17 +0200
Message-ID: <20250506135939.652543-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250506135939.652543-1-mkl@pengutronix.de>
References: <20250506135939.652543-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Antonios Salios <antonios@mwa.re>

The spin lock tx_handling_spinlock in struct m_can_classdev is not
being initialized. This leads the following spinlock bad magic
complaint from the kernel, eg. when trying to send CAN frames with
cansend from can-utils:

| BUG: spinlock bad magic on CPU#0, cansend/95
|  lock: 0xff60000002ec1010, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
| CPU: 0 UID: 0 PID: 95 Comm: cansend Not tainted 6.15.0-rc3-00032-ga79be02bba5c #5 NONE
| Hardware name: MachineWare SIM-V (DT)
| Call Trace:
| [<ffffffff800133e0>] dump_backtrace+0x1c/0x24
| [<ffffffff800022f2>] show_stack+0x28/0x34
| [<ffffffff8000de3e>] dump_stack_lvl+0x4a/0x68
| [<ffffffff8000de70>] dump_stack+0x14/0x1c
| [<ffffffff80003134>] spin_dump+0x62/0x6e
| [<ffffffff800883ba>] do_raw_spin_lock+0xd0/0x142
| [<ffffffff807a6fcc>] _raw_spin_lock_irqsave+0x20/0x2c
| [<ffffffff80536dba>] m_can_start_xmit+0x90/0x34a
| [<ffffffff806148b0>] dev_hard_start_xmit+0xa6/0xee
| [<ffffffff8065b730>] sch_direct_xmit+0x114/0x292
| [<ffffffff80614e2a>] __dev_queue_xmit+0x3b0/0xaa8
| [<ffffffff8073b8fa>] can_send+0xc6/0x242
| [<ffffffff8073d1c0>] raw_sendmsg+0x1a8/0x36c
| [<ffffffff805ebf06>] sock_write_iter+0x9a/0xee
| [<ffffffff801d06ea>] vfs_write+0x184/0x3a6
| [<ffffffff801d0a88>] ksys_write+0xa0/0xc0
| [<ffffffff801d0abc>] __riscv_sys_write+0x14/0x1c
| [<ffffffff8079ebf8>] do_trap_ecall_u+0x168/0x212
| [<ffffffff807a830a>] handle_exception+0x146/0x152

Initializing the spin lock in m_can_class_allocate_dev solves that
problem.

Fixes: 1fa80e23c150 ("can: m_can: Introduce a tx_fifo_in_flight counter")
Signed-off-by: Antonios Salios <antonios@mwa.re>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20250425111744.37604-2-antonios@mwa.re
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 884a6352c42b..326ede9d400f 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2379,6 +2379,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	SET_NETDEV_DEV(net_dev, dev);
 
 	m_can_of_parse_mram(class_dev, mram_config_vals);
+	spin_lock_init(&class_dev->tx_handling_spinlock);
 out:
 	return class_dev;
 }

base-commit: ebd297a2affadb6f6f4d2e5d975c1eda18ac762d
-- 
2.47.2



