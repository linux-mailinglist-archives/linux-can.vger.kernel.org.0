Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE1757A1F4
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 16:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239459AbiGSOkh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 10:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239443AbiGSOkH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 10:40:07 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A51BD
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:12 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g4so13678997pgc.1
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vamJgnrfzwT8m7GZ7hiPkkIVWa36uk6MV/+2rVsaG+Q=;
        b=RzVOr5BvnLO2OLniW8Di2YPAh3+f685+Q2oQrThSlbIO1u7S30AaOu1IVwT6T7Hmxy
         /9GtYMvppDTb4pCrUpKN7nyBExvJgXGk/7JxikVnFIdrV8pIvCko6Mri1ZR6bo+GBRuY
         D4wWjiQNsobq28Jy17N8m5HpNfLOGCBGhPz7d1P9zEYXu/OlCWJagG8A/c9yML1Lu5QJ
         /WBk2p6BXNohE3q9Y7Ntdtkqb2qeSjJgumvS2+aB1DMxdbt3QNe+qqkekjrVh3mEnHSF
         3MXA9nkhRxxY71VLJq3fPtNgRpfNrmF1R+2JfNtfVCtYw9UHHp5nDloPIgpSJkPFWxd3
         wcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vamJgnrfzwT8m7GZ7hiPkkIVWa36uk6MV/+2rVsaG+Q=;
        b=nPumdVx8Leg1f9v+zR8fzXmBOvtejkTP5YutaxxccvQ17A3/ZU3w+nzukWCKKvuwmi
         pNGJFrt8C5g1jeZ1JWVfWli3+eFQVBwgfsR6O6U/xS11BWUedzQ4wKzLh8P4Uhy/7VMJ
         30DEQRegy/NSR+2J6NvH1ZQ7QN0v7f5d1q6J3w/V3rS0VR7uPtNoZEVfBnDiXwIN8Odp
         i6S3uN4CBWs8y07NXte5W/E3Yt2EUXry7+rL4u3LSdNRgAJgTG/AAc0HZOM7UIMWrqVw
         a8MXIv3lkkc0zQliUhvT2aWOMqLnMLg4k00ZExlfO1fFTfco6ofUn0rielcVPNnFcsH5
         Oqsw==
X-Gm-Message-State: AJIora+VMKWYCdacAGgMTvpfgr56qtkd3j14zIDlAUM3u5uBRCC5DFgA
        TE6z014dPTPVlifuIF6AWzdGWXWu48o=
X-Google-Smtp-Source: AGRyM1srGiYIXtk3Z1C1zLvuGVTXlUs6PTVCXBGXkImoUgH+OvidB36HQwYMtpxts1qWeJQHGL/1SQ==
X-Received: by 2002:a62:14cc:0:b0:52b:9043:4615 with SMTP id 195-20020a6214cc000000b0052b90434615mr1973110pfu.35.1658241371998;
        Tue, 19 Jul 2022 07:36:11 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d75-20020a621d4e000000b0052896629f66sm11562516pfd.208.2022.07.19.07.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:36:11 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 05/12] can: hi311x: do not report txerr and rxerr during bus-off
Date:   Tue, 19 Jul 2022 23:35:43 +0900
Message-Id: <20220719143550.3681-6-mailhol.vincent@wanadoo.fr>
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

Fixes: 57e83fb9b746 ("can: hi311x: Add Holt HI-311x CAN driver")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/spi/hi311x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index ebc4ebb44c98..bfb7c4bb5bc3 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -667,8 +667,6 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 
 			txerr = hi3110_read(spi, HI3110_READ_TEC);
 			rxerr = hi3110_read(spi, HI3110_READ_REC);
-			cf->data[6] = txerr;
-			cf->data[7] = rxerr;
 			tx_state = txerr >= rxerr ? new_state : 0;
 			rx_state = txerr <= rxerr ? new_state : 0;
 			can_change_state(net, cf, tx_state, rx_state);
@@ -681,6 +679,9 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 					hi3110_hw_sleep(spi);
 					break;
 				}
+			} else {
+				cf->data[6] = txerr;
+				cf->data[7] = rxerr;
 			}
 		}
 
-- 
2.35.1

