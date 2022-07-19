Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B927757A1E6
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 16:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbiGSOk3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 10:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239427AbiGSOkG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 10:40:06 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B7A20BF3
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k19so12129124pll.5
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u47Yt4MvSw7OclyY24oeeZEoWwdnnVTmsdJ/OU6GR8w=;
        b=FQdHCXBSpxz5eCGf4nqCI6aMdM8VcDma6EP+faTncOmVSwhaIoJY1PSz6iKQjyDUBw
         0poA62g+Q1a4FuRKT4jjsmxRACGn/KfSgRFc83U4gIgGKIIguvI8g2FY9k8WzCOgulyH
         VO4xnRE1VUHqN1QQ09cqmLGLxPnQ5VQwm+XCNB2rlcDaOKZ6bBvCxTm6CDH0RB2hBaes
         YRxKUiBSv9nmLO1hp89FNA/nALeQ/DFIGYrfpNjxKfZYEGQLQSJSEVmEpk+nODzJ2TSK
         /PZTZOWzlqcuz07wVznr61AyHsF6B/FYs2xxtZF+S9AsUEK261Pdp+CAswGrMvFOdl2a
         1rYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=u47Yt4MvSw7OclyY24oeeZEoWwdnnVTmsdJ/OU6GR8w=;
        b=ntQ9F5txnoML2xRcJhwhJSFL3gbmgLE9aoRaNTF1jloNXFwFsPhc9V8fuIJEqMhxRV
         pKcdMS4gEaejqmxie8FyoqngXqEm/aoSTVK3TOxmDVTpMoqW4OrWTdCMuPncj9IMMYw7
         vgp1FBkBnzDaM+3ptGuiOkvB7LW87a0JJtP0/b05VG0vUHLefeCO1kx3J2k2vQksBjdp
         ODS8FdY5WGiFQckxUupEdphNDTFNPIi9k9fD7yQ4GNnjKYYALyOwIeuUYptrBysoau3s
         IRakRraG6N4XQ1+q9fok7SjuRmFMm7F2baBqytnbXJYXI4Xyh3mPxh+G9JatYCIULs9/
         uWMw==
X-Gm-Message-State: AJIora+aj95uWDkWRqb2SIXcIXorDwcAlBq0sJ3x+fWAW0GQRiXQg71j
        XhJ5+PK+ud7L2KCINmjzOKxF9Tpjov4=
X-Google-Smtp-Source: AGRyM1uxwC+kkMKkYOQ4nCXWlFTzUBInuTS+Wb7l13Wr0oLRatKQTjKPcEPgIwpwMSUtrevJutkSig==
X-Received: by 2002:a17:90a:d506:b0:1f0:74ba:9775 with SMTP id t6-20020a17090ad50600b001f074ba9775mr39350218pju.151.1658241366734;
        Tue, 19 Jul 2022 07:36:06 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d75-20020a621d4e000000b0052896629f66sm11562516pfd.208.2022.07.19.07.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:36:06 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 02/12] can: rcar_can: do not report txerr and rxerr during bus-off
Date:   Tue, 19 Jul 2022 23:35:40 +0900
Message-Id: <20220719143550.3681-3-mailhol.vincent@wanadoo.fr>
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

