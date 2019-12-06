Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F83115440
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 16:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfLFP3a (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 10:29:30 -0500
Received: from first.geanix.com ([116.203.34.67]:39562 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfLFP3a (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 6 Dec 2019 10:29:30 -0500
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id BB7C238C;
        Fri,  6 Dec 2019 15:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575646161; bh=ejGfGihfUphVPcy6zWEDcOLewkPn1AjQMYxSDLokwxo=;
        h=From:To:Cc:Subject:Date;
        b=IlR/k7d4nifkLbWZd2jcCFrdJgbCMyYI7/OIPqSyxIZ5Fbr6XXRhZQ7byoyV8Wdca
         9mz6Krzu/YXYyIAGI0axQ4bjC1nAiiTQP6taYi86d7wtUuA9XAZo3rxg42ctfJZjws
         3OyPDTk6yOB54IsOrkzAZPgj2CujGODiBAEcBZ3KATz96lCQY/p2DiApvmWGGYHPbo
         txEHLiM79VfUpvEm2KvfSrzaOixCLrOSxLFRU2nEbZatLhCdJlD8KwiPisaxdGuvhh
         CL277PyUTMFiDjZAuKrJ6yZ5JSY9hKOBC/Gx0N4r9D1q1IskB/lXxNsuSUF8D4rSen
         OWCpyh5U0Wt2w==
From:   Sean Nyekjaer <sean@geanix.com>
To:     mkl@pengutronix.de, dmurphy@ti.com, linux-can@vger.kernel.org,
        robh+dt@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, devicetree@vger.kernel.org,
        martin@geanix.com
Subject: [PATCH 1/2] net: m_can: tcan4x5x: add required delay after reset
Date:   Fri,  6 Dec 2019 16:29:22 +0100
Message-Id: <20191206152923.470980-1-sean@geanix.com>
X-Mailer: git-send-email 2.24.0
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

According to section "8.3.8 RST Pin" in the datasheet we are required to
wait >700us after the device is reset.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/m_can/tcan4x5x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 6e37c3fd87af..cb5fdb695ec9 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -367,6 +367,8 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 	if (IS_ERR(tcan4x5x->reset_gpio))
 		tcan4x5x->reset_gpio = NULL;
 
+	usleep_range(700, 1000);
+
 	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
 							      "device-state",
 							      GPIOD_IN);
-- 
2.24.0

