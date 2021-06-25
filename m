Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9BF3B441E
	for <lists+linux-can@lfdr.de>; Fri, 25 Jun 2021 15:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhFYNMv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Jun 2021 09:12:51 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:29756 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231501AbhFYNMv (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 25 Jun 2021 09:12:51 -0400
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 287F35FFA2;
        Fri, 25 Jun 2021 15:10:25 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 1/5] can: peak_usb: pcan_usb_get_device_id(): read value only in case of success
Date:   Fri, 25 Jun 2021 15:09:27 +0200
Message-Id: <20210625130931.27438-2-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210625130931.27438-1-s.grosjean@peak-system.com>
References: <20210625130931.27438-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In case of error, reading value from response argument is useless.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 1d6f77252f01..9f3e16684e28 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -384,7 +384,8 @@ static int pcan_usb_get_device_id(struct peak_usb_device *dev, u32 *device_id)
 	if (err)
 		netdev_err(dev->netdev, "getting device id failure: %d\n", err);
 
-	*device_id = args[0];
+	else
+		*device_id = args[0];
 
 	return err;
 }
-- 
2.25.1

