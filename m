Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43610626E9B
	for <lists+linux-can@lfdr.de>; Sun, 13 Nov 2022 09:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiKMIxo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Nov 2022 03:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiKMIxn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Nov 2022 03:53:43 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EF19596
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 00:53:41 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 140so7029687pfz.6
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 00:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4XWVzl97xGrN05ee3zdFxyEOfTCn+97qjGfXOEozv0=;
        b=XhpoxwBT3TCSgMua2WkLjTnhcr3mZ5ZIc7xtv//Y0+UUi8mgf9rUeQ+VzcgeeWm6td
         eTdk+PEIM2RJHzuUZaziKdevv9YtoqwrJsqhJ7dZYFSB0rhBcrahdTPHFIH5fx1g9AXj
         MK07WPHzgA1IPjKipOA6oH5F/sRsyymFNKthPo8KkbCD7Z2luShKmKzKukGyQnDM9zzl
         TX/GvyITGDbhw31Ec6EyAuE4kW4VyIJvCtJp2rTTg4SOcFnExrnlRI/K/8fsjtLB7Yal
         TLXw8foF16OD9mrVqor9uSF7y2bgNGDvnO2ja5B2bXtT2ujLLnGHN27wqg51B/Jtz6sd
         xPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t4XWVzl97xGrN05ee3zdFxyEOfTCn+97qjGfXOEozv0=;
        b=v9zO2XXeAaHWYidQIqLe3NyxFdSAY9hXjMGxZGXTD+HRQW64220uvyvZSCsplOj79t
         eQvuPai3pbmj5/5qxEYWgQIlZlnQXjVZ4cAsOlhGGlJXsqWL9pOYwtBJgPv5qP5izLk4
         bxelHyYH9Jk9A5b5NPgNkb/H7DNd6EzR+IyvkWGGXyTt6RXiQVChHyrsB5liWhM/wGC6
         PfaEyn584Q3pqmvlb1+Fuxldu9FhVqk8LiVzvVA1KRCTGI2oSC8TRwTbAJMXRSS8DrEr
         nEzBxgju8tOLqF9B4GY4PQg+FZvoXM1nokjUDENthMyH0kOlRCNbb2SxdYxn+6ysa6UA
         QonQ==
X-Gm-Message-State: ANoB5plr1Zs4B34xrtGh9TZ+khjnhthW9nP+L3LSzq5WGo1+DU4kMlbX
        CWqCiViaecGafW6LFdN8sNpTkPDZM/Mg4w==
X-Google-Smtp-Source: AA0mqf4QzNCQ10mQCEP5QhLu4LksTF0xut1YApp07Vnoo3Z9mqSI8rM1plhKP0bUrAmNJDOt+HHbIw==
X-Received: by 2002:a63:1e05:0:b0:434:911a:301 with SMTP id e5-20020a631e05000000b00434911a0301mr8158786pge.50.1668329620284;
        Sun, 13 Nov 2022 00:53:40 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id y1-20020a626401000000b00528a097aeffsm4372391pfb.118.2022.11.13.00.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 00:53:39 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH can-utils-dev 5/5] lib: snprintf_can_error_frame: print counter errors if CAN_ERR_CNT is set
Date:   Sun, 13 Nov 2022 17:53:21 +0900
Message-Id: <20221113085321.87910-6-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
References: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
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
not the errour counter is set. Use this to decide whether on not the
error-counter-tx-rx should be printed.

For interoperability reasons, use an #ifdef so that the code still
work on older kernels.

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

