Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EA56BAE86
	for <lists+linux-can@lfdr.de>; Wed, 15 Mar 2023 12:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjCOLGu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 15 Mar 2023 07:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjCOLGj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 15 Mar 2023 07:06:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39088536A
        for <linux-can@vger.kernel.org>; Wed, 15 Mar 2023 04:06:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j42-20020a05600c1c2a00b003ed363619ddso362486wms.1
        for <linux-can@vger.kernel.org>; Wed, 15 Mar 2023 04:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678878390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWzMTugaKEGU24JeDUKp4PyFtC2GqEFZd+tmG3zdkvs=;
        b=cUaxpLaDj2CX/ggiG1GSwL+CdNwizAvaSK9qroa7Rui1suiWOwy0JnQ16qOH5qW/2X
         5+nTb0rFL5sRjbhFIWk9txmE2FoED82X81p9HVzAo7h7MRdKGOhX2Gh6Gv3f+JyAy0io
         RQCH7nskO1uSPK4Ff54wAoZ9EXIC1/7W8CQfJyxMYA1Z0DDCdsEFP767DLYDaKjq/Wj1
         Zwl96VzTrPMpg8E/eH8FqIYwSMbBgFaaRTtAGvBdBleIB8b/uqd7X69RKNJ3T5lLIpG9
         HgsYsojP9loQANiJAwTYfww9BNaAiol1NKXTb3PeXTGoa+uO9yFAUHWpYUPCf0zVzAef
         1KOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678878390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWzMTugaKEGU24JeDUKp4PyFtC2GqEFZd+tmG3zdkvs=;
        b=L8OW+DHitHmLxypQfC9EmO+5yi5VFenoPwnQ2rNjN2Yoe8ImMiEN1895TMH42VAwvi
         oyWdX/7y27nuIlrkL1099fvleMLOre66llXG28BY+dNopBHsIQx99u/mATIzkr89r6R7
         XW20C7vKEW8UPojWjobrXeWnrqdQpvrarH8DE2RAk1CsRMvCSll4YpZeZsIJAwoLeELa
         4pb4ChH+BcMI4j11S8SifcEjmMObKmWYD188sXyRJfE/kMeYkCivUYlFOScgjhhqaGCn
         mhJFBBfw6vH4fDDT2UVO0/m3aQ5o/1TIjfVkTWvODNyAxATit0ptcZE8sy9J+l2PrPhM
         sUaA==
X-Gm-Message-State: AO0yUKU9wZeRJ7POOi/T8pYkNhLj04eua1Og6R3lr3O6nJo0TyWNLvRO
        VrbJpEAfT7M8857BO7T7pstmcg==
X-Google-Smtp-Source: AK7set8cLBeMEmlEfHAXg0VlgTMKVWqQqJnOjUPiAhem4kqECFu1DQ+vvaYBDeL6ouby3I//LA2gBw==
X-Received: by 2002:a05:600c:470a:b0:3e1:bfc:d16e with SMTP id v10-20020a05600c470a00b003e10bfcd16emr17411428wmo.39.1678878390167;
        Wed, 15 Mar 2023 04:06:30 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a247:8056:be7d:83e:a6a5:4659])
        by smtp.gmail.com with ESMTPSA id l4-20020a7bc444000000b003eafc47eb09sm1460563wmi.43.2023.03.15.04.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:06:29 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v3 06/16] can: m_can: Write transmit header and data in one transaction
Date:   Wed, 15 Mar 2023 12:05:36 +0100
Message-Id: <20230315110546.2518305-7-msp@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315110546.2518305-1-msp@baylibre.com>
References: <20230315110546.2518305-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Combine header and data before writing to the transmit fifo to reduce
the overhead for peripheral chips.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a5003435802b..35a2332464e5 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1681,6 +1681,8 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		m_can_write(cdev, M_CAN_TXBAR, 0x1);
 		/* End of xmit function for version 3.0.x */
 	} else {
+		char buf[TXB_ELEMENT_SIZE];
+		u8 len_padded = DIV_ROUND_UP(cf->len, 4);
 		/* Transmit routine for version >= v3.1.x */
 
 		txfqs = m_can_read(cdev, M_CAN_TXFQS);
@@ -1720,12 +1722,11 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		fifo_header.dlc = FIELD_PREP(TX_BUF_MM_MASK, putidx) |
 			FIELD_PREP(TX_BUF_DLC_MASK, can_fd_len2dlc(cf->len)) |
 			fdflags | TX_BUF_EFC;
-		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID, &fifo_header, 2);
-		if (err)
-			goto out_fail;
+		memcpy(buf, &fifo_header, 8);
+		memcpy_and_pad(&buf[8], len_padded, &cf->data, cf->len, 0);
 
-		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DATA,
-				       cf->data, DIV_ROUND_UP(cf->len, 4));
+		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID,
+				       buf, 2 + len_padded);
 		if (err)
 			goto out_fail;
 
-- 
2.39.2

