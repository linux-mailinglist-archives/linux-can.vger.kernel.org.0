Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C6C57A1E7
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 16:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbiGSOkb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 10:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239431AbiGSOkG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 10:40:06 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596DD3AD
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:09 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bh13so13660579pgb.4
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQPY0V/qlPRYSc71/C3QyqsaJHrCXDE5XW8cNsLL7VA=;
        b=kE4uJ2fy1ja6/Q9EbH7IKALQskpp9BDKK7U0IYpyS7mur72VdR1w3YG93wOU4Ut97H
         ugpfYSbM8r2zvbJCDxMg7whPlhR6Sn3qf6TzoSKCetFrSF4Q7ZhewnEYhMF90loANE5i
         PKbLLIbguNpLAFYZY+FU/nglq7CI2n9dbfIjk0OnXlC5zLQtin5t9GBRswTzMXnny6UM
         j7JdJ+uH10pVzwifvP8m4N06A0jrMt23Wqelg4tp0JTRCTp6CkJexjUxi2mwAUmsWYwH
         A2z3uvzxk/Fi1m8XXmz6qVZdrYPazZMz1fv1EBxbSuTC+XXfLEQbrgGDf/O/2jji7Nok
         qI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QQPY0V/qlPRYSc71/C3QyqsaJHrCXDE5XW8cNsLL7VA=;
        b=Ag0HKCBaK8hM8TxWm98cLbKjdQRnpwvbSPCZ4/4ojroPngJxGHm09HtsFtBVoXBmXt
         I0lK+NZZ3+QE/tDwG9E0PCoDKz0PDPMcyU2rX2vhLCNQdnz09NjFSE0T3B6ASwEbJehV
         Qb8o7/QuJvpXt5u6QQlo9dEtdyfuPnIkrZyXO+g1mzXmsnUFkhY4PkaU+4BRpOn8zdKY
         TptJFHqn7lgtO+wVSlQO8k9YCsg6p6DR21XVFAiPmcz7mfBlwdbJsYDQS6iSNy+bh3xf
         +7ov0YE9F7J7XK43NJq/Qa0fFgZ1nlhXtO2ItzDMbwG1OEbZOhc81qUo8HmLN/hct3IA
         Is0w==
X-Gm-Message-State: AJIora/Vuw3rNUMVtUWxL4eNZmTK3xVxe5gWBGfw9vrrYr2ia+pDdogz
        CjW483qqmiIp0ALDnmQygQE2EQQCgho=
X-Google-Smtp-Source: AGRyM1tZyLPwOXbslLyfXyvGd9eyjIUKt4vKT7DFiUmRye7vm/yL+6XjctGgXckvPV+4TkTfBsMgOA==
X-Received: by 2002:a63:6a45:0:b0:419:cb1b:891b with SMTP id f66-20020a636a45000000b00419cb1b891bmr22869281pgc.135.1658241368411;
        Tue, 19 Jul 2022 07:36:08 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d75-20020a621d4e000000b0052896629f66sm11562516pfd.208.2022.07.19.07.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:36:08 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 03/12] can: sja1000: do not report txerr and rxerr during bus-off
Date:   Tue, 19 Jul 2022 23:35:41 +0900
Message-Id: <20220719143550.3681-4-mailhol.vincent@wanadoo.fr>
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

During bus off, the error count is greater than 255 and can not fit in
a u8.

Fixes: 215db1856e83 ("can: sja1000: Consolidate and unify state change handling")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/sja1000/sja1000.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 2e7638f98cf1..84adf8b5945e 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -402,9 +402,6 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	txerr = priv->read_reg(priv, SJA1000_TXERR);
 	rxerr = priv->read_reg(priv, SJA1000_RXERR);
 
-	cf->data[6] = txerr;
-	cf->data[7] = rxerr;
-
 	if (isrc & IRQ_DOI) {
 		/* data overrun interrupt */
 		netdev_dbg(dev, "data overrun interrupt\n");
@@ -426,6 +423,10 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 		else
 			state = CAN_STATE_ERROR_ACTIVE;
 	}
+	if (state != CAN_STATE_BUS_OFF) {
+		cf->data[6] = txerr;
+		cf->data[7] = rxerr;
+	}
 	if (isrc & IRQ_BEI) {
 		/* bus error interrupt */
 		priv->can.can_stats.bus_error++;
-- 
2.35.1

