Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD84E756B4A
	for <lists+linux-can@lfdr.de>; Mon, 17 Jul 2023 20:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjGQSJs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jul 2023 14:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGQSJr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jul 2023 14:09:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E2099
        for <linux-can@vger.kernel.org>; Mon, 17 Jul 2023 11:09:46 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLSfI-00087G-MG
        for linux-can@vger.kernel.org; Mon, 17 Jul 2023 20:09:44 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 1E0EE1F3967
        for <linux-can@vger.kernel.org>; Mon, 17 Jul 2023 18:09:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 52DA01F3944;
        Mon, 17 Jul 2023 18:09:41 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b2b03231;
        Mon, 17 Jul 2023 18:09:40 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, YueHaibing <yuehaibing@huawei.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 2/5] can: bcm: Fix UAF in bcm_proc_show()
Date:   Mon, 17 Jul 2023 20:09:35 +0200
Message-Id: <20230717180938.230816-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717180938.230816-1-mkl@pengutronix.de>
References: <20230717180938.230816-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

BUG: KASAN: slab-use-after-free in bcm_proc_show+0x969/0xa80
Read of size 8 at addr ffff888155846230 by task cat/7862

CPU: 1 PID: 7862 Comm: cat Not tainted 6.5.0-rc1-00153-gc8746099c197 #230
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xd5/0x150
 print_report+0xc1/0x5e0
 kasan_report+0xba/0xf0
 bcm_proc_show+0x969/0xa80
 seq_read_iter+0x4f6/0x1260
 seq_read+0x165/0x210
 proc_reg_read+0x227/0x300
 vfs_read+0x1d5/0x8d0
 ksys_read+0x11e/0x240
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Allocated by task 7846:
 kasan_save_stack+0x1e/0x40
 kasan_set_track+0x21/0x30
 __kasan_kmalloc+0x9e/0xa0
 bcm_sendmsg+0x264b/0x44e0
 sock_sendmsg+0xda/0x180
 ____sys_sendmsg+0x735/0x920
 ___sys_sendmsg+0x11d/0x1b0
 __sys_sendmsg+0xfa/0x1d0
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 7846:
 kasan_save_stack+0x1e/0x40
 kasan_set_track+0x21/0x30
 kasan_save_free_info+0x27/0x40
 ____kasan_slab_free+0x161/0x1c0
 slab_free_freelist_hook+0x119/0x220
 __kmem_cache_free+0xb4/0x2e0
 rcu_core+0x809/0x1bd0

bcm_op is freed before procfs entry be removed in bcm_release(),
this lead to bcm_proc_show() may read the freed bcm_op.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://lore.kernel.org/all/20230715092543.15548-1-yuehaibing@huawei.com
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/bcm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 9ba35685b043..9168114fc87f 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1526,6 +1526,12 @@ static int bcm_release(struct socket *sock)
 
 	lock_sock(sk);
 
+#if IS_ENABLED(CONFIG_PROC_FS)
+	/* remove procfs entry */
+	if (net->can.bcmproc_dir && bo->bcm_proc_read)
+		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
+#endif /* CONFIG_PROC_FS */
+
 	list_for_each_entry_safe(op, next, &bo->tx_ops, list)
 		bcm_remove_op(op);
 
@@ -1561,12 +1567,6 @@ static int bcm_release(struct socket *sock)
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list)
 		bcm_remove_op(op);
 
-#if IS_ENABLED(CONFIG_PROC_FS)
-	/* remove procfs entry */
-	if (net->can.bcmproc_dir && bo->bcm_proc_read)
-		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
-#endif /* CONFIG_PROC_FS */
-
 	/* remove device reference */
 	if (bo->bound) {
 		bo->bound   = 0;
-- 
2.40.1


