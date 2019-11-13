Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF98FAE17
	for <lists+linux-can@lfdr.de>; Wed, 13 Nov 2019 11:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKMKIX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Nov 2019 05:08:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35646 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfKMKIW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Nov 2019 05:08:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id r7so1898463ljg.2
        for <linux-can@vger.kernel.org>; Wed, 13 Nov 2019 02:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=EoMSp1mYqZ8LUQhVwh4PTdehoxKWDg2dwek1BhAipMs=;
        b=ZehxglsskyahGn0x2688KWyq+t8ujRBKEawnCJutvT5CDy/zV3BDaJ/QCzv9TJZ+jg
         SKhZpDS+gVi8491sPScyLKvz2QC1jjo6kkSPSOLDMiVCf5KKBeGZoemPOXdjWjakN/Mv
         o/uRaYFQyTFVIQSrHk6OWe0jfmb8LDLh9xBgVSpPWwZEfQcby9YKPPkzjA9FvwMrourg
         FxBrhRz+0r7VXtxsTz6yDwBfVh0WjbCEcveKlzGJg84NC/6U10A6jR/xATXhrnaRW9KK
         MKmR8GC7KrGTGrFquqjwcrJWEXFMTL4nf/vITYBdD8SXb+Eiaz8or7MUuEe890Hqcfmf
         YBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EoMSp1mYqZ8LUQhVwh4PTdehoxKWDg2dwek1BhAipMs=;
        b=mDUR9uFoU2j//JjBLzxv5pKzErza6p7w5KfPcwWSVcYreSTEoWx2bTr6Nf/dvzN4/R
         tTj0SV6itRPhL8MbHXfwj54CYttrx7DQaZiMMHc0HWEQyPaYMvZyQTQL6FdTq5x/iM85
         1MO83I+a+6vNxn6xEKGrU6mLUKJ+nrff07dWtxkuo2inyh+JY/xMh4cVpoTNTC3lugFN
         AN2YhrL1L+DrAiW2pazJaVRqs7zc2pn5pJA2MbOgwJ5xkr2S9eQgLLR7B1p5lcMLQkKo
         B+2cZxkje/4QvU/Ma9iJZbzlysS83hoNErBAuu5uH+LBebRz2M0MFwvTtTbk2brty28T
         JU9w==
X-Gm-Message-State: APjAAAVaAcWI869Yc8CUJhxjFFWEVWv8umzkB8nbSsdtE/XgvDf+Dm1J
        7Q3g+eloV5s7PtyrEabDDqe0cIQNF7F/vw==
X-Google-Smtp-Source: APXvYqw9OtnXRQZUqYl21euszIJzrt4dZISO7XXiNQ3/PDMpw0AWnFXjHywn/+R72SXXa1uYQDSNVw==
X-Received: by 2002:a2e:81c1:: with SMTP id s1mr1956588ljg.83.1573639700323;
        Wed, 13 Nov 2019 02:08:20 -0800 (PST)
Received: from localhost.localdomain ([109.204.235.119])
        by smtp.gmail.com with ESMTPSA id k6sm944949lfc.72.2019.11.13.02.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 02:08:19 -0800 (PST)
From:   jouni.hogander@unikie.com
To:     linux-can@vger.kernel.org
Cc:     Jouni Hogander <jouni.hogander@unikie.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] slcan: Fix memory leak in error path
Date:   Wed, 13 Nov 2019 12:08:01 +0200
Message-Id: <20191113100801.19803-1-jouni.hogander@unikie.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Jouni Hogander <jouni.hogander@unikie.com>

This patch is fixing memory leak reported by Syzkaller:

BUG: memory leak unreferenced object 0xffff888067f65500 (size 4096):
  comm "syz-executor043", pid 454, jiffies 4294759719 (age 11.930s)
  hex dump (first 32 bytes):
    73 6c 63 61 6e 30 00 00 00 00 00 00 00 00 00 00 slcan0..........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
  backtrace:
    [<00000000a06eec0d>] __kmalloc+0x18b/0x2c0
    [<0000000083306e66>] kvmalloc_node+0x3a/0xc0
    [<000000006ac27f87>] alloc_netdev_mqs+0x17a/0x1080
    [<0000000061a996c9>] slcan_open+0x3ae/0x9a0
    [<000000001226f0f9>] tty_ldisc_open.isra.1+0x76/0xc0
    [<0000000019289631>] tty_set_ldisc+0x28c/0x5f0
    [<000000004de5a617>] tty_ioctl+0x48d/0x1590
    [<00000000daef496f>] do_vfs_ioctl+0x1c7/0x1510
    [<0000000059068dbc>] ksys_ioctl+0x99/0xb0
    [<000000009a6eb334>] __x64_sys_ioctl+0x78/0xb0
    [<0000000053d0332e>] do_syscall_64+0x16f/0x580
    [<0000000021b83b99>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
    [<000000008ea75434>] 0xffffffffffffffff

Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Jouni Hogander <jouni.hogander@unikie.com>
---
 drivers/net/can/slcan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index bb6032211043..0a9f42e5fedf 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -617,6 +617,7 @@ static int slcan_open(struct tty_struct *tty)
 	sl->tty = NULL;
 	tty->disc_data = NULL;
 	clear_bit(SLF_INUSE, &sl->flags);
+	free_netdev(sl->dev);
 
 err_exit:
 	rtnl_unlock();
-- 
2.17.1

