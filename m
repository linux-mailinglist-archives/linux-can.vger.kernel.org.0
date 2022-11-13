Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3A862706B
	for <lists+linux-can@lfdr.de>; Sun, 13 Nov 2022 17:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbiKMQTE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Nov 2022 11:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiKMQTE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Nov 2022 11:19:04 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FFEE005
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 08:19:03 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d20so8044245plr.10
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 08:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItXyjG77WAyaCmpRvDWlbmh/7CicYqejXh9n/rv0NoI=;
        b=QSH9cbswwLU6uOd/cfN4exVRrXCU1ALDvu0BjjI9WDYYJ+yMBJXXDIsF9XvHpTXHb5
         bIYgoojU5pFfrtJcLnnWwKazIrQJB0jObIcAj43mdu6RXMCGaR9s6I6DpKuw5imkInkz
         XA99PWF14YuCCxEwCq80jj7jS8BafONf5MX9y8nuD4OsGHLrri2psvuJi7laLXk0Uhm0
         A/vwvBFd5R0TfovkqgiyZGeCzUL2x5MD7eb2j2oeLxgURqzw1yglZ0rQbeUBzpTaVteG
         Rf1XOY9gKwynobHK8ER0beAHc+EwvZcARl5X1UagbU/2x1eTBUS+1HVWtqRuNlv3T8PO
         oBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ItXyjG77WAyaCmpRvDWlbmh/7CicYqejXh9n/rv0NoI=;
        b=Ipy/WW3qPJHRNo1HJac6aLp9VYoKgu4/COJmb3VHdOtKeEpLQM3VcpC5BPC5TEaRv6
         CH4vzLaMryIWMQBLHZTdXLZ9i/q9kWvxO62kJR7dS+N8iHnu49NauY6UdyeX22LSJvob
         0UDHeoCitTiqoCyxktvlQGjcRV84fihpeZqQpPH4AgdYg/7hIAhBFYrnrz2n3mR2ckiV
         rvCoE4/nnXi6vwUqcRoWqpR+VDY9EGmm2UqzFO/xJvLm/FdTqFOU5wrZmSfrXE+C4Sv2
         ZF0UONHkIItW+jYaNgaQsbmqHhTRuSYxVS5iHFfRR0utXSR69cjtVJYE9481zoWDycs8
         jp4w==
X-Gm-Message-State: ANoB5plm/3Hv9lpwgvZrdYSXCy9Z2F/2JfNRj2vwuAIMOqNJJYVFz4DZ
        5Iiz37P+nFBIODCm5hFGWtL0fGDDIKnvGg==
X-Google-Smtp-Source: AA0mqf7/8hVrtgbXky6DnGcsu5CuLWjAUrzWxSf9KqX+3gzW1qpTrl6pGgITdQtgWvmzD3xtXK8EsA==
X-Received: by 2002:a17:90a:fc7:b0:214:160a:7993 with SMTP id 65-20020a17090a0fc700b00214160a7993mr10816495pjz.32.1668356342741;
        Sun, 13 Nov 2022 08:19:02 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id 192-20020a6217c9000000b0056c04dee930sm4863558pfx.120.2022.11.13.08.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 08:19:02 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH can-utils-dev v2 3/5] lib: snprintf_can_error_frame: print counter errors if CAN_ERR_CNT is set
Date:   Mon, 14 Nov 2022 01:18:29 +0900
Message-Id: <20221113161831.16388-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221113161831.16388-1-mailhol.vincent@wanadoo.fr>
References: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
 <20221113161831.16388-1-mailhol.vincent@wanadoo.fr>
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

Since [1], the kernel has a new flag: CAN_ERR_CNT to notify whether or
not the error counter is set. Use this to decide whether on not the
error-counter-tx-rx should be printed.

For interoperability reasons, use an #ifdef so that the code still
work if built on older kernels.

[1] commit 3e5c291c7942 ("can: add CAN_ERR_CNT flag to notify
    availability of error counter")
Link: https://git.kernel.org/torvalds/linux/c/3e5c291c7942

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 lib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib.c b/lib.c
index 3c1a0d9..fb08c0b 100644
--- a/lib.c
+++ b/lib.c
@@ -679,7 +679,11 @@ void snprintf_can_error_frame(char *buf, size_t len, const struct canfd_frame *c
 		}
 	}
 
+#ifdef CAN_ERR_CNT
+	if (cf->can_id & CAN_ERR_CNT) {
+#else
 	if (cf->data[6] || cf->data[7]) {
+#endif
 		n += snprintf(buf + n, len - n, "%s", sep);
 		n += snprintf(buf + n, len - n, "error-counter-tx-rx{{%d}{%d}}",
 			      cf->data[6], cf->data[7]);
-- 
2.37.4

