Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640EC57A1FD
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 16:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbiGSOlF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 10:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239229AbiGSOkW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 10:40:22 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880A6DF33
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q5so12133777plr.11
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qLHvJCsq8rNhbzCJ6l/OXurNkXodJoG8r1CDJKIYpzA=;
        b=ei0dd5lWwa3dcBaxdbZguuqh7/OGYPXvsxowlTkgp18pT0OJlbcuh42mOCnQsMYDrR
         YZwWn+kcTdVN2SWzFfrwn0VAN5w7yMavzQHORBax8WvVTNn3QuLONtbXuXKGX69/oOzj
         mprQfYu6n2C1B51slKpryCcN2gZBWl7shAvlG2KbWqkm8dgvVwGdTAemml1qB9I9Nk+L
         g2J8JC/fUUpCh9mFlHjd6GS5cg6OsY8POOa/uz+sP5v6UmVo2oWQwNajin61SCUj+u+s
         RpjrqPBBb7x8zIuDWcMtmkSrJav0n1thBZDb0oXuXXJKR/DjX1h8nA3RNOrHjPFACpP8
         FViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qLHvJCsq8rNhbzCJ6l/OXurNkXodJoG8r1CDJKIYpzA=;
        b=6i1MtEMeFgEuZryMHWMvl9bgHTo0rWuJEkEeihEGXKlyHF2ITOoBMY4XCvSQpNIWC7
         bQCYwcv2bBEIzfGG0OS2tMBic1a8gsa2qFyMHbVtGR0cF/vmeC5GRP3FFuC+GGbTeQCd
         dcxK7/BeEbPpqyRIF8bOeSpnZeugVw3dnbWl6KWbgRaP95xhvKhJ5wYuHW7OFfehBQwx
         9Oy0DiyCxo/oq1APJztgDUYhpQS6w0dkAMhCUaNbaGpnFyDvd+BFMdlSR4Q5NC3PDHuw
         7wPMmQuNk0EBPhLarG8Q5/Ik4Mi+YL1V3QjJfzw+bhuQ2xqVUpkxJd3eSmGS2kw8uaPz
         zU0Q==
X-Gm-Message-State: AJIora+ui8ge6sLTQK19/Mro3dteyXr/ErBHYXorfvAH0giZiKbLXITh
        UuGh1PjwCkxQ+re1Dx4nmbzA8r1jIUK6YA==
X-Google-Smtp-Source: AGRyM1sZiPZLHIGEHBqs45vRv0W+SSzQDoGiQT+OXl0vvvGONv+BMgKRuyR5Ar4+KCaM9NCn1KkHeQ==
X-Received: by 2002:a17:902:d651:b0:16b:f55e:c626 with SMTP id y17-20020a170902d65100b0016bf55ec626mr34299424plh.78.1658241384738;
        Tue, 19 Jul 2022 07:36:24 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d75-20020a621d4e000000b0052896629f66sm11562516pfd.208.2022.07.19.07.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:36:24 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 12/12] can: error: add definitions for the different CAN error thresholds
Date:   Tue, 19 Jul 2022 23:35:50 +0900
Message-Id: <20220719143550.3681-13-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220719143550.3681-1-mailhol.vincent@wanadoo.fr>
References: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
 <20220719143550.3681-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Currently, drivers are using magic numbers to derive the CAN error
states from the error counter. Add three macro declarations to
remediate this.

For reference, the error-active, error-passive and bus-off are defined
in ISO 11898, section 12.1.4.2 "Error counting". Although ISO 11898
does not define error-warning state, this extra value is also commonly
used and is thus also added.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---

Strictly speaking, this does not need to be part of the uapi but I
still think it is beneficial to have it here. Thank you for your
comments.

Also, if anyone knows which standard originally defined the
error-warning, let me know.
---
 include/uapi/linux/can/error.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/uapi/linux/can/error.h b/include/uapi/linux/can/error.h
index b7c3efd9ff99..acc1ac393d2a 100644
--- a/include/uapi/linux/can/error.h
+++ b/include/uapi/linux/can/error.h
@@ -127,4 +127,17 @@
 /* TX error counter / data[6] */
 /* RX error counter / data[7] */
 
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
+
 #endif /* _UAPI_CAN_ERROR_H */
-- 
2.35.1

