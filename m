Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F481571F51
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 17:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiGLPcz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 11:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiGLPcp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 11:32:45 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7744A238C
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so11783207pjl.5
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C7zTWBwZDdKmlAo6fiKt0hrUk5sp3FSMNgJXmhSYlvE=;
        b=iV+zLmDItjE/kOqRcDz/vFsNtct8zHEP7NbMOnmOpiY7J6O/GDXd0tFsCyO/cm1GTa
         l1+hrstMJELaaYt8uh9y25eWPnkSYS3xkmBlHwGuMaeth3I2oByIk4ETNNMTKoxntjfK
         FyxxMZG67wIg/5R8CuH8WiqTqVwJB0KsVrtzdPTfk7J5Cr4OMlcS1UMl3NyI9GxBpVIF
         4RMZUW0GN8E54jCG/eEssRx/5cDaHaZSylj1D7zjbveXA+EdVc4R4IVZRo5VBow+4YfN
         T0TZl5vg9cLq4zuFGTrKwp41oXfBkCQ60IVjTsGU6n2xBHqrDxHcvvVVCG4do0a2KOcO
         4xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=C7zTWBwZDdKmlAo6fiKt0hrUk5sp3FSMNgJXmhSYlvE=;
        b=BXVcSqjcvdeYvrmTpuiOD+gPLQa3l6RY08LxQJ1u5iRFHDOUW5B8pHwhf4TBXGCfCz
         bBA56aDInWMQ4scC2CTB9iD1Eb0SRBds7zzdisZtBD0pFabpW17pHg0GED91leVliNON
         jmywwMg4zAXAKQHAUw0BwT3NCk2I5DAEXtGgagIiAuMn8PMeRm1e5kU7n14Av2Ln/0GC
         h4j0dW37ZZ74KqOvn8NQw7Lmdy7SkCNXjvQfBE9exj/gqxnwAG8grXLeWsRicz4zjnuY
         gbIIFWKEv2sd8F4bsXoJzZpvu7DMIWzOEHAhLgA4JzgpEVW2xgVJkEQkBtW/GhaDhkjB
         FXkg==
X-Gm-Message-State: AJIora/gKPPkc7NrpYwUYZ0u6FT2PW2EDfWujL8YIFhHKTfENeufO8VR
        +Hx3KXjvtv4gIYrTf8xT42B54GUedzl0Hw==
X-Google-Smtp-Source: AGRyM1v+HWfWXiaD2C5In5oSnrbeWclQHuxz++HG8uU1mAmY54ZGrhsJFFlpzh939T8nN7MgM01AAw==
X-Received: by 2002:a17:902:eb89:b0:16c:6337:b9b4 with SMTP id q9-20020a170902eb8900b0016c6337b9b4mr2702840plg.27.1657639963017;
        Tue, 12 Jul 2022 08:32:43 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id c131-20020a621c89000000b005252defb016sm6891483pfc.122.2022.07.12.08.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:32:42 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 12/12] can: error: add definitions for the different CAN error thresholds
Date:   Wed, 13 Jul 2022 00:31:57 +0900
Message-Id: <20220712153157.83847-13-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
References: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
index a17ad25a01f9..5c0639134f96 100644
--- a/include/uapi/linux/can/error.h
+++ b/include/uapi/linux/can/error.h
@@ -127,4 +127,17 @@
 /* TX error counter / data[6] */
 /* TX error counter / data[7] */
 
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

