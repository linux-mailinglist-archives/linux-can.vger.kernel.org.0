Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B7D6285A2
	for <lists+linux-can@lfdr.de>; Mon, 14 Nov 2022 17:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbiKNQku (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Nov 2022 11:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbiKNQkZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Nov 2022 11:40:25 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A165FB2
        for <linux-can@vger.kernel.org>; Mon, 14 Nov 2022 08:39:10 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso14348026pjc.0
        for <linux-can@vger.kernel.org>; Mon, 14 Nov 2022 08:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkuPAV1UB1U/MvmBtX93a5iPMOSJ2DeNWlfT+Z1J6CU=;
        b=IGSYiCLzn/q3ivWQDh9avQyHayYUOY98aPSyXWm5AGi8dh9uCcW7gp5H9SztqsdHTi
         +oxN9vDqdmyFj0XOaYPBnMTqmOq4+2rJ3FFhIXhVKtyrkno4EF759qntvSGUIFBIsMzM
         0VOM9WHxRNgob1WAaKOaHRNm0WvAZHjA9JditobdCxvt08/8MIVNLXULaJZbDh9wf/a8
         BtWElr8CAaiUcQN1hfEOHkDPht3UB5P6XY0F3dxrblR5zpH5S4pnZXnVbjh0TOnmnS+E
         aHRTvpHIdVm3fYYkIeeBkSBWdIR8MQaoISpW39kwJiKEqb/m131tqxJqY+iFr6zAfMMc
         CfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lkuPAV1UB1U/MvmBtX93a5iPMOSJ2DeNWlfT+Z1J6CU=;
        b=FZ+M9YeJOP8qoypx2Kh854SkmW/P2HWeRcaoefjI8WqVlQbdN/COPDKpl0H4iouCgO
         OUYXGWH31mzbk8qQ0eoa1Ts44q96FF4bak5Wn6VW0oaSzC3EjwAgn4my7zf9hiKoa3FK
         0T5SkN5KuAq2h+qzKEBrVkwzYP21eCAy9oPNxKAohflrfLtRiWfZNy2wjsqTninHWhsB
         XUhgPB4HoOuEDyVNq8q5UmKd7/OtD8TKHa4iNzvkkvnGVcDMbUJBJX2pLSidGdu0wr4U
         OxPW31aWf6KjqCCwOAjnZ6O3lk38xdxDP+esSV1ARnSN3qpkR9dHcTbwoyJohhApxMck
         olMw==
X-Gm-Message-State: ANoB5pnK4YdnQNn8LvNWb+adP7DXsqo8czKl9JyHShuy4p8aj5HF1jKQ
        CEHzBuZY0krHWnPXNGIRQvwKbDJhzVuYhA==
X-Google-Smtp-Source: AA0mqf4GqNltul6JwURBpAdQtpG/i3zWpVVp6YYMBM1uXsRSQ+mbeqnFuaP98biKtn8Bg0p7X+GqhA==
X-Received: by 2002:a17:90b:3682:b0:1fd:5b5d:f09d with SMTP id mj2-20020a17090b368200b001fd5b5df09dmr14743368pjb.69.1668443949799;
        Mon, 14 Nov 2022 08:39:09 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id g190-20020a6252c7000000b0057255b82bd1sm807183pfb.217.2022.11.14.08.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:39:09 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH can-utils-dev v3 2/6] include: update linux/can/error.h
Date:   Tue, 15 Nov 2022 01:38:44 +0900
Message-Id: <20221114163848.3398-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221114163848.3398-1-mailhol.vincent@wanadoo.fr>
References: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
 <20221114163848.3398-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Update the linux/can/error.h hearder to incorporate the changes made
in Linux 6.0.0. Namely:

  - commit 3e5c291c7942 ("can: add CAN_ERR_CNT flag to notify
    availability of error counter")
    Link: https://git.kernel.org/torvalds/linux/c/3e5c291c7942

  - commit 3f9c26210cf8 ("can: error: add definitions for the
    different CAN error thresholds")
    Link: https://git.kernel.org/torvalds/linux/c/3f9c26210cf8

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/linux/can/error.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/can/error.h b/include/linux/can/error.h
index 3463328..acc1ac3 100644
--- a/include/linux/can/error.h
+++ b/include/linux/can/error.h
@@ -57,6 +57,8 @@
 #define CAN_ERR_BUSOFF       0x00000040U /* bus off */
 #define CAN_ERR_BUSERROR     0x00000080U /* bus error (may flood!) */
 #define CAN_ERR_RESTARTED    0x00000100U /* controller restarted */
+#define CAN_ERR_CNT          0x00000200U /* TX error counter / data[6] */
+					 /* RX error counter / data[7] */
 
 /* arbitration lost in bit ... / data[0] */
 #define CAN_ERR_LOSTARB_UNSPEC   0x00 /* unspecified */
@@ -120,6 +122,22 @@
 #define CAN_ERR_TRX_CANL_SHORT_TO_GND  0x70 /* 0111 0000 */
 #define CAN_ERR_TRX_CANL_SHORT_TO_CANH 0x80 /* 1000 0000 */
 
-/* controller specific additional information / data[5..7] */
+/* data[5] is reserved (do not use) */
+
+/* TX error counter / data[6] */
+/* RX error counter / data[7] */
+
+/* CAN state thresholds
+ *
+ * Error counter	Error state
+ * -----------------------------------
+ * 0 -  95		Error-active
+ * 96 - 127		Error-warning
+ * 128 - 255		Error-passive
+ * 256 and greater	Bus-off
+ */
+#define CAN_ERROR_WARNING_THRESHOLD 96
+#define CAN_ERROR_PASSIVE_THRESHOLD 128
+#define CAN_BUS_OFF_THRESHOLD 256
 
 #endif /* _UAPI_CAN_ERROR_H */
-- 
2.37.4

