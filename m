Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A1957FFE6
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbiGYNcs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiGYNcq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:32:46 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D7D12AB0
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:44 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 6so10353438pgb.13
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KFb+Lxn2QAveZvycS7BVRM08wBe518/EAzYNsl0q83M=;
        b=X49O3tCU7rBQogrGxC56jdjscfUyJUvG/0kkWjUx4z0pDUPDsW3DhYF2dnDVaE0ACG
         CT+FOux2++lmz9RWDYBNDH+znA9pV44iYGCJYrbwuNJrAq4f7oMGlNkL0xzclBkfactl
         rG2h2EMmdd8kgHvUCHM0adWU0cGVrZa8oq45gysZAaOh7dnPAHNjexPVyZ7PIPOsg9ue
         j+RBO/MG1EDMsnV2gejJt/A6egvh/O1dqIvB+uKFvlwEVYW/EV8D9pnnswoH5DuQgHGv
         KqYVFWfG4B2dW2Jf0my+vSMHkGFaB8gvruk2feqxm60Oj0uOL6OMzKDwcy3+oKHKFRbD
         V6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KFb+Lxn2QAveZvycS7BVRM08wBe518/EAzYNsl0q83M=;
        b=CXDvyMYa3kFA8zzZKtwoTj9ABWtxMX/CqRTZtymuYydCEnBfQ3ENdIP/UEICeFX0lN
         oid9qQxJnzQ9iQnkMQLdgQknUS9u1GOs6sLmd16fp5rdJ4W4pKC1AaXn+p7aQGyI/e+m
         PoIRlIwOZpWv/QeQ1oP79RHkRy67PsOHo3VoL3V4RFlMDmpN7VFyXRzB7IoL48XwhPTH
         yVl2jRIn2c5fUrIUKXLzYlWZfV/8Vm+YQqffxejFg5JnxfDAN7ip3g0xi0GZHn9pgDsc
         CoQAUf1M1FtD5rOkSUt/tTmDTMxmpln5UgBmxdV6719TV46u9b2NgfnjAehEDGXyHugo
         TAug==
X-Gm-Message-State: AJIora99Srf3mLMukNrWE7Wu+WfjZTUC0uVR3IKzxRYoPqqslZWN6+1E
        hpt5bpVodIzifZ6rp0jbQNS+tdjmHwedtA==
X-Google-Smtp-Source: AGRyM1sY379y+LVc2bZbKRZS+gLbZFxDS5fRiSo9V2SqjdQ/jfViUYDcqpNPvUocLnefgWDZ2dLRLQ==
X-Received: by 2002:a05:6a00:815:b0:52b:295a:fad with SMTP id m21-20020a056a00081500b0052b295a0fadmr13023784pfk.62.1658755963797;
        Mon, 25 Jul 2022 06:32:43 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:43 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 07/24] can: softing: add DRV_NAME to replace hardcoded names
Date:   Mon, 25 Jul 2022 22:31:51 +0900
Message-Id: <20220725133208.432176-8-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
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

The driver uses the string "kvaser_usb" to populate
usb_driver::name. Add a new macro DRV_NAME which evaluates to
"ems_ubs" and then use DRV_NAME and to get rid on the hardcoded string
names.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index f211bfcb1d97..a6cff8da5a41 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -29,6 +29,8 @@
 
 #include "kvaser_usb.h"
 
+#define DRV_NAME "kvaser_usb"
+
 /* Kvaser USB vendor id. */
 #define KVASER_VENDOR_ID			0x0bfd
 
@@ -869,7 +871,7 @@ static void kvaser_usb_disconnect(struct usb_interface *intf)
 }
 
 static struct usb_driver kvaser_usb_driver = {
-	.name = "kvaser_usb",
+	.name = DRV_NAME,
 	.probe = kvaser_usb_probe,
 	.disconnect = kvaser_usb_disconnect,
 	.id_table = kvaser_usb_table,
-- 
2.35.1

