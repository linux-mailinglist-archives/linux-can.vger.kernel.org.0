Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A52B4F7669
	for <lists+linux-can@lfdr.de>; Thu,  7 Apr 2022 08:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241330AbiDGGlA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 7 Apr 2022 02:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241391AbiDGGkD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 7 Apr 2022 02:40:03 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C97D1F630;
        Wed,  6 Apr 2022 23:37:31 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.15.192.164])
        by mail-app4 (Coremail) with SMTP id cS_KCgC3LqaYhk5i1Z7iAA--.43371S2;
        Thu, 07 Apr 2022 14:37:16 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-kernel@vger.kernel.org
Cc:     chris@zankel.net, jcmvbkbc@gmail.com, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, jgg@ziepe.ca, wg@grandegger.com,
        mkl@pengutronix.de, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, jes@trained-monkey.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        alexander.deucher@amd.com, linux-xtensa@linux-xtensa.org,
        linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-hippi@sunsite.dk,
        linux-staging@lists.linux.dev, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH 09/11] drivers: infiniband: hw: Fix deadlock in irdma_cleanup_cm_core()
Date:   Thu,  7 Apr 2022 14:37:12 +0800
Message-Id: <4069b99042d28c8e51b941d9e698b99d1656ed33.1649310812.git.duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1649310812.git.duoming@zju.edu.cn>
References: <cover.1649310812.git.duoming@zju.edu.cn>
X-CM-TRANSID: cS_KCgC3LqaYhk5i1Z7iAA--.43371S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw13Ar15Xw1rZry3Gry7trb_yoW8Wr4fpr
        WDWryS9ryq9F42ka18Ww1DZFZrXw4kWFsFvryj9395ZF1rXFyUJF1fAr9IqFWDJF9Fgrs3
        uF1YvryrCFZayr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
        twAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
        0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa
        73UjIFyTuYvjfU5JPEDUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAggNAVZdtZEcMgAJsO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

There is a deadlock in irdma_cleanup_cm_core(), which is shown
below:

   (Thread 1)              |      (Thread 2)
                           | irdma_schedule_cm_timer()
irdma_cleanup_cm_core()    |  add_timer()
 spin_lock_irqsave() //(1) |  (wait a time)
 ...                       | irdma_cm_timer_tick()
 del_timer_sync()          |  spin_lock_irqsave() //(2)
 (wait timer to stop)      |  ...

We hold cm_core->ht_lock in position (1) of thread 1 and
use del_timer_sync() to wait timer to stop, but timer handler
also need cm_core->ht_lock in position (2) of thread 2.
As a result, irdma_cleanup_cm_core() will block forever.

This patch extracts del_timer_sync() from the protection of
spin_lock_irqsave(), which could let timer handler to obtain
the needed lock.

Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/infiniband/hw/irdma/cm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index dedb3b7edd8..019dd8bfe08 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -3252,8 +3252,11 @@ void irdma_cleanup_cm_core(struct irdma_cm_core *cm_core)
 		return;
 
 	spin_lock_irqsave(&cm_core->ht_lock, flags);
-	if (timer_pending(&cm_core->tcp_timer))
+	if (timer_pending(&cm_core->tcp_timer)) {
+		spin_unlock_irqrestore(&cm_core->ht_lock, flags);
 		del_timer_sync(&cm_core->tcp_timer);
+		spin_lock_irqsave(&cm_core->ht_lock, flags);
+	}
 	spin_unlock_irqrestore(&cm_core->ht_lock, flags);
 
 	destroy_workqueue(cm_core->event_wq);
-- 
2.17.1

