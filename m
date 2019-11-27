Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7029010AAB1
	for <lists+linux-can@lfdr.de>; Wed, 27 Nov 2019 07:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbfK0Gki (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Nov 2019 01:40:38 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36303 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfK0Gkh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Nov 2019 01:40:37 -0500
Received: by mail-lj1-f195.google.com with SMTP id k15so23121765lja.3
        for <linux-can@vger.kernel.org>; Tue, 26 Nov 2019 22:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7Hx7Vhduz/UsYHX/DRmequlgtaFr1wLpbrhQYEY2PXQ=;
        b=dkF4NKS/XwR5YnKo2hoYVsKy+ghhxT6VFw7zLw8YuUBffZmzTnz20W2yP+kqa2sXN4
         /VlG5EG+XBRumr2GZXvPa5rUeSH8Igxkn0Gg68V3nCxS2OMBvZnTcijLhn8rkghqccNO
         /6zkAIjCm1D3VyaODjxNkOXy09IVNZl/XWmIkpxIy7HMZM4XadJ9WhxwqgPv4bZrGOJ6
         hQiJxL3TKt1CpqXymXe72KHvxs1er9qT8ZdBEkZa6vlsGp7EtF6Uwa6QK3ZSxhjBf3IQ
         GWEPmuCEncey2MyET5T58NVPokiU+11znY8mUpu/An1XUH+yk7/EiULorxv82zgYVVVn
         h0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7Hx7Vhduz/UsYHX/DRmequlgtaFr1wLpbrhQYEY2PXQ=;
        b=stqBzVb9bpIfGAo8UoZrDI6PTZEsPGd7Hr3lY/7R8ZWiSlqL7d85hGOMmbxd1gyFl+
         MAU2zM/81v1jWyCkrW3noRE9K3XMP/T4iJRsKjQBVd76pWvZIZFCqd39eA9hCZIrywcw
         /B2TKTy6OdWq5jaxKynhceTmRZb+f/mKXAiawh+6SzdbyfQTNEmSmKee0lR++nNzPr9h
         t+H8Jyk1wXFz9vJfIOerq9+fjCJIQAey8TzpU5zcD1RgQ6Mc+A2M6FXXDqt4tXsiri5U
         BABgf3fR4LCHSGbSWCajTlWS1y3nTd2Q/X0IFzTDinx44iyt//bdlA74s/rfynfwq3f9
         5LXw==
X-Gm-Message-State: APjAAAXS3hBGc5kPaWbbwidIwWuRjyq+GuIXxpiE82ihsOmc+qhT1+pt
        RlmESI+GkfrTMIgB4hrb8GxkmkMo3yQ=
X-Google-Smtp-Source: APXvYqxvJeZ7Ku7p64HoP7/trDPLjIGxALKBrnZu1RfMLVt1DRwMQyZ10eUs6ekdgN0IY2xgfcfXWg==
X-Received: by 2002:a2e:89c2:: with SMTP id c2mr29531947ljk.161.1574836833843;
        Tue, 26 Nov 2019 22:40:33 -0800 (PST)
Received: from localhost.localdomain ([109.204.235.119])
        by smtp.gmail.com with ESMTPSA id i8sm6319437lfl.80.2019.11.26.22.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 22:40:33 -0800 (PST)
From:   jouni.hogander@unikie.com
To:     linux-can@vger.kernel.org
Cc:     Jouni Hogander <jouni.hogander@unikie.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        David Miller <davem@davemloft.net>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] slcan: Fix use-after-free Read in slcan_open
Date:   Wed, 27 Nov 2019 08:40:26 +0200
Message-Id: <20191127064026.14138-1-jouni.hogander@unikie.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Jouni Hogander <jouni.hogander@unikie.com>

Slcan_open doesn't clean-up device which registration failed from the
slcan_devs device list. On next open this list is iterated and freed
device is accessed. Fix this by calling slc_free_netdev in error path.

Driver/net/can/slcan.c is derived from slip.c. Use-after-free error was
identified in slip_open by syzboz. Same bug is in slcan.c. Here is the
trace from the Syzbot slip report:

__dump_stack lib/dump_stack.c:77 [inline]
dump_stack+0x197/0x210 lib/dump_stack.c:118
print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
__kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
kasan_report+0x12/0x20 mm/kasan/common.c:634
__asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
sl_sync drivers/net/slip/slip.c:725 [inline]
slip_open+0xecd/0x11b7 drivers/net/slip/slip.c:801
tty_ldisc_open.isra.0+0xa3/0x110 drivers/tty/tty_ldisc.c:469
tty_set_ldisc+0x30e/0x6b0 drivers/tty/tty_ldisc.c:596
tiocsetd drivers/tty/tty_io.c:2334 [inline]
tty_ioctl+0xe8d/0x14f0 drivers/tty/tty_io.c:2594
vfs_ioctl fs/ioctl.c:46 [inline]
file_ioctl fs/ioctl.c:509 [inline]
do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:696
ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
__do_sys_ioctl fs/ioctl.c:720 [inline]
__se_sys_ioctl fs/ioctl.c:718 [inline]
__x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: ed50e1600b44 ("slcan: Fix memory leak in error path")
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David Miller <davem@davemloft.net>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Jouni Hogander <jouni.hogander@unikie.com>
---
 drivers/net/can/slcan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 0a9f42e5fedf..2e57122f02fb 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -617,6 +617,7 @@ static int slcan_open(struct tty_struct *tty)
 	sl->tty = NULL;
 	tty->disc_data = NULL;
 	clear_bit(SLF_INUSE, &sl->flags);
+	slc_free_netdev(sl->dev);
 	free_netdev(sl->dev);
 
 err_exit:
-- 
2.17.1

