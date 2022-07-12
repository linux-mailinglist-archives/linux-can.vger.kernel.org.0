Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205D5571F42
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 17:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiGLPc2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 11:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiGLPc1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 11:32:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C429FE06
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:27 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so11772721pjr.4
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u47Yt4MvSw7OclyY24oeeZEoWwdnnVTmsdJ/OU6GR8w=;
        b=aEkePUvnAHWFcpGIVsfnlgDx6ST4WX0LgP/vTrl/k+PPf93bbFe/l1IQxq8x3nSG16
         t2OTFGLrLJUqEtGB7ldV7VtPln0GB3FXm/5rxb8PIfZqqtoxUELiV1nfHCbyaMi8bhqo
         Ln/2jm2e9wCkW123o5SEbhxRBRjebRuEZDczzo/uj1pqeDNl6EU2ZgKdXtJ4XtBHfwKw
         g9qIoGIFztOyBOhjI6MEJVCnfemaU8tVajHfKAT7g0OCFI9z1K1aznzz/hC9lJMEGBne
         +uK6VvvjBY8MJmEDg7tiGtquz8rwZRZ/BEhfk9my272mrLdnUazfofXEfInIW2+DdNKi
         pXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=u47Yt4MvSw7OclyY24oeeZEoWwdnnVTmsdJ/OU6GR8w=;
        b=wYD/9IT0Fy4NuErZnwSJs9iQpV7fwW4RaRg3C0a8KBo65l9QPA7r4Z8p7yPcY0jn1P
         tEdGrspWsmW9kpG3CJCHROJ0Mf/Amosb0MNtjnIGJQPIyMNeHyXZn2PBQP0uqXLOC1mc
         b9NAkrTa2H9fwmGqM84iShRsTRbm3ACzDkBBTeUggpD/oTgqBN7QGknsuYEENmJwhvNh
         Ztn+bMbYUN02pOeRhOcamFOHqithOjgJqee4eOIKQ7VHXlGtvS8vdVo5x+Bbd2Aqyl1K
         G44lXJb6Ge/rN4C67DuUheMe+Nbl3dqVdo2EJ+A2w/A55mR3aEh+qbX0rkyHxGdLTlAU
         dZnA==
X-Gm-Message-State: AJIora976tr0ezYx8duNObKD/BcK4E3+ACLqL8zzOAcVCIl/GjPDZr2f
        QVE8/e2T0iNHXLaWo3tWbn/iPqvCQnrdig==
X-Google-Smtp-Source: AGRyM1vGIIZjGVIXxEeLfQAK6aEF9ta7ED6bbd2OgpuktRVsksPuw+vqn5vuuVzt//X2fUBR8+1YJQ==
X-Received: by 2002:a17:902:da8e:b0:16c:56d7:e00e with SMTP id j14-20020a170902da8e00b0016c56d7e00emr6342161plx.91.1657639946499;
        Tue, 12 Jul 2022 08:32:26 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id c131-20020a621c89000000b005252defb016sm6891483pfc.122.2022.07.12.08.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:32:26 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 02/12] can: rcar_can: do not report txerr and rxerr during bus-off
Date:   Wed, 13 Jul 2022 00:31:47 +0900
Message-Id: <20220712153157.83847-3-mailhol.vincent@wanadoo.fr>
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

During bus off, the error count is greater than 255 and can not fit in
a u8.

Fixes: fd1159318e55 ("can: add Renesas R-Car CAN driver")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/rcar/rcar_can.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index d45762f1cf6b..24d7a71def6a 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -232,11 +232,8 @@ static void rcar_can_error(struct net_device *ndev)
 	if (eifr & (RCAR_CAN_EIFR_EWIF | RCAR_CAN_EIFR_EPIF)) {
 		txerr = readb(&priv->regs->tecr);
 		rxerr = readb(&priv->regs->recr);
-		if (skb) {
+		if (skb)
 			cf->can_id |= CAN_ERR_CRTL;
-			cf->data[6] = txerr;
-			cf->data[7] = rxerr;
-		}
 	}
 	if (eifr & RCAR_CAN_EIFR_BEIF) {
 		int rx_errors = 0, tx_errors = 0;
@@ -336,6 +333,9 @@ static void rcar_can_error(struct net_device *ndev)
 		can_bus_off(ndev);
 		if (skb)
 			cf->can_id |= CAN_ERR_BUSOFF;
+	} else if (skb) {
+		cf->data[6] = txerr;
+		cf->data[7] = rxerr;
 	}
 	if (eifr & RCAR_CAN_EIFR_ORIF) {
 		netdev_dbg(priv->ndev, "Receive overrun error interrupt\n");
-- 
2.35.1

