Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3F035CE2E
	for <lists+linux-can@lfdr.de>; Mon, 12 Apr 2021 18:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbhDLQmk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 12 Apr 2021 12:42:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245004AbhDLQdm (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 12 Apr 2021 12:33:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AE9161289;
        Mon, 12 Apr 2021 16:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618244800;
        bh=XF0W1zw6r+F5IA4XB/x4MfRBToh8z+eAEiLFBa2hqxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SHSMHsNXqTUf4bpkhMkWk4GQS8d41HuptkfnwNTGUij+Ud+twkiVD92Mn6zAif2rE
         7/6DvbFFF7APsXXi3DX8Z+GbL4Fs9r0jNptdKYFLFOAQg/SuM7DBG2p30Ytr/vq2Ml
         uwvUudPLTjgKuBXl901zPHGchS5zTCkwZtv2wA3mI2n/3Y9uB+ZOW9qaeEL28B9BvC
         di16aeoMlS0m5lhufX43fXsno/+DzS2+c0T0hxqx1hOfKF/DV2T0Bi5hm4/7n4/hv1
         0/waz143M89DzzMTrz7UHUAx4U7gvSTvkLEMQJFaki5qyWhaJRzLyIiW7XxbdoZ2vt
         l6uYjJa/aDM3A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+91adee8d9ebb9193d22d@syzkaller.appspotmail.com,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/25] drivers: net: fix memory leak in peak_usb_create_dev
Date:   Mon, 12 Apr 2021 12:26:12 -0400
Message-Id: <20210412162630.315526-7-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412162630.315526-1-sashal@kernel.org>
References: <20210412162630.315526-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

[ Upstream commit a0b96b4a62745397aee662670cfc2157bac03f55 ]

syzbot reported memory leak in peak_usb.
The problem was in case of failure after calling
->dev_init()[2] in peak_usb_create_dev()[1]. The data
allocated int dev_init() wasn't freed, so simple
->dev_free() call fix this problem.

backtrace:
    [<0000000079d6542a>] kmalloc include/linux/slab.h:552 [inline]
    [<0000000079d6542a>] kzalloc include/linux/slab.h:682 [inline]
    [<0000000079d6542a>] pcan_usb_fd_init+0x156/0x210 drivers/net/can/usb/peak_usb/pcan_usb_fd.c:868   [2]
    [<00000000c09f9057>] peak_usb_create_dev drivers/net/can/usb/peak_usb/pcan_usb_core.c:851 [inline] [1]
    [<00000000c09f9057>] peak_usb_probe+0x389/0x490 drivers/net/can/usb/peak_usb/pcan_usb_core.c:949

Reported-by: syzbot+91adee8d9ebb9193d22d@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index c9d86d50bf88..3c73eaae5388 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -882,7 +882,7 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	if (dev->adapter->dev_set_bus) {
 		err = dev->adapter->dev_set_bus(dev, 0);
 		if (err)
-			goto lbl_unregister_candev;
+			goto adap_dev_free;
 	}
 
 	/* get device number early */
@@ -894,6 +894,10 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 
 	return 0;
 
+adap_dev_free:
+	if (dev->adapter->dev_free)
+		dev->adapter->dev_free(dev);
+
 lbl_unregister_candev:
 	unregister_candev(netdev);
 
-- 
2.30.2

