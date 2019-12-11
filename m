Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4CB411AC2F
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 14:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfLKNjr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 08:39:47 -0500
Received: from first.geanix.com ([116.203.34.67]:59122 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729438AbfLKNjr (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 11 Dec 2019 08:39:47 -0500
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id EC52B492;
        Wed, 11 Dec 2019 13:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1576071557; bh=k7+VnL953BuPTam1Gvl66O35k7Un5e3sIaK+MDU/6uQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=O+avZxUTwgllHyqpBtffKBotjFUmSOQ4VHzSahzyjmu9GeLbVkTl9p8nfnXoMKF9F
         8mssreXjNlSlFyHKGdKrZDnooskSmN74Hkpi4ym47OUDHqlk4dCx7s38xL7gUhEAxw
         daBn4O5AxxJ6sHaHZH7TIOYG0vnquLpzDFXgNV38gI39hyzk4mWKbUgw3f0+3iMlfj
         xDxKDMhF467m07f+YTZZR7vJECWCwIcaxGRUlIcaK8a0SK/3PxSM0yfAmyizqeS10Q
         l/0EKbvEHOur+/XzFRvFiU8BanolkHZkAzl2i90WrAnQOcCBhv5bdHKzQ3GLM0eD/G
         1IGghPH1shmGg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     mkl@pengutronix.de, dmurphy@ti.com, linux-can@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, martin@geanix.com,
        stable@vger.kernel.org
Subject: [PATCH v5 2/2] can: tcan4x5x: put the device out of standby before register access
Date:   Wed, 11 Dec 2019 14:39:26 +0100
Message-Id: <20191211133926.319015-2-sean@geanix.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211133926.319015-1-sean@geanix.com>
References: <20191211133926.319015-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=4.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8b5b6f358cc9
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The m_can tries to detect if Non ISO Operation is available while in
standby, this function results in the following error:

tcan4x5x spi2.0 (unnamed net_device) (uninitialized): Failed to init module
tcan4x5x spi2.0: m_can device registered (irq=84, version=32)
tcan4x5x spi2.0 can2: TCAN4X5X successfully initialized.

When the tcan device comes out of reset it comes out in standby mode.
The m_can driver tries to access the control register but fails due to
the device is in standby mode.

So this patch will put the tcan device in normal mode before the m_can
driver does the initialization.

Fixes: 5443c226ba91 ("can: tcan4x5x: Add tcan4x5x driver to the kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes since v3:
 - Fixed fixes tag

Changes since v4:
 - None

 drivers/net/can/m_can/tcan4x5x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 032d110e0870..3a3359ad3723 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -485,6 +485,10 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	if (ret)
 		goto out_power;
 
+	ret = tcan4x5x_init(mcan_class);
+	if (ret)
+		goto out_power;
+
 	ret = m_can_class_register(mcan_class);
 	if (ret)
 		goto out_power;
-- 
2.24.0

