Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C697D6BAE85
	for <lists+linux-can@lfdr.de>; Wed, 15 Mar 2023 12:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjCOLGs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 15 Mar 2023 07:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjCOLGi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 15 Mar 2023 07:06:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2334684F73
        for <linux-can@vger.kernel.org>; Wed, 15 Mar 2023 04:06:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so907520wmq.1
        for <linux-can@vger.kernel.org>; Wed, 15 Mar 2023 04:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678878387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFEvCUdnRPRdEAvOdxaVu4SNhrWUtZmDw6TEQufRunU=;
        b=KS43ZTNYzVEwCNAosKlEcPLE7wlEorxUCPylz22zHpjrLp2O32kxKqoGop9phNxZhx
         H7kEJk8Oud8dLYHl8cmHdBD8cahGDK4igm0HgpjevqcdWrJ3HwLCG4YFvpOSzQtn9oTA
         YzJUxM4Xz3vbBzwqs7rset/Xb7HCPzvjPy6p0uKGvOStRzh1jxJN/hO6mj9sM39FzOj3
         XhbGN0NZd8xzZpD1W+wmS9PZplcjZyZGqorTuTyQP//waoX53JVOfPuWp7lkMzgqr5SL
         qVSRXIchxT/l9e/aNeJ/S1K/UTr9gARXQ1r1spczeP6JHW8HAnY/BOFDOy+TUb4H3G3W
         UZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678878387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFEvCUdnRPRdEAvOdxaVu4SNhrWUtZmDw6TEQufRunU=;
        b=BtBXEOdwg2cW7Z3FFrt5vzc2Rd5mBbq81FXncZ0duK5wwpEaibnZvs+6CL11BBo6iD
         KhisXP5gIMOwtlT1V+b8bG81I6V/+opX4kryOW5m4V6bAra39RpY3qMUvuw99hDfz2sg
         cMyhOELR/Forr843h6EO5RyEmfyBtOzppvOjzrUN1q+BdWoidphvbXvKBS1YbZrD+IUj
         Fgv1zNgw/14Ays5SilcHvKN8xoMy8eEJoKTmyDZuBSqdOQWVMDRtkaupHJmr7OZ6SIpw
         z3xIMtotxd64YleaXvsTLjbgB2iiblmntTCJ/o/2zhr4s9WgL/gjU0XOiNe6yOXHOML0
         OtpA==
X-Gm-Message-State: AO0yUKWYF0tlDQ6RuBOpPJ1L+41fClpeZa0KCzVBM7hkW7KTxQxpD7VM
        fQ2RWzMamWhz5NJhY2uAmpNQPA==
X-Google-Smtp-Source: AK7set/ll9xYlulvlQn3zoOMj/iB3nItXl26a0W0rqBqfwysSjDKqZ4TXo2TG4X9i5+ZRc89+6ogoQ==
X-Received: by 2002:a05:600c:1c0a:b0:3ed:22b3:6263 with SMTP id j10-20020a05600c1c0a00b003ed22b36263mr11335233wms.12.1678878387621;
        Wed, 15 Mar 2023 04:06:27 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a247:8056:be7d:83e:a6a5:4659])
        by smtp.gmail.com with ESMTPSA id l4-20020a7bc444000000b003eafc47eb09sm1460563wmi.43.2023.03.15.04.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:06:27 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v3 03/16] can: m_can: Remove double interrupt enable
Date:   Wed, 15 Mar 2023 12:05:33 +0100
Message-Id: <20230315110546.2518305-4-msp@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315110546.2518305-1-msp@baylibre.com>
References: <20230315110546.2518305-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Interrupts are enabled a few lines further down as well. Remove this
second call to enable all interrupts.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 8eb327ae3bdf..5274d9642566 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1364,7 +1364,6 @@ static int m_can_chip_config(struct net_device *dev)
 	m_can_write(cdev, M_CAN_TEST, test);
 
 	/* Enable interrupts */
-	m_can_write(cdev, M_CAN_IR, IR_ALL_INT);
 	if (!(cdev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
 		if (cdev->version == 30)
 			m_can_write(cdev, M_CAN_IE, IR_ALL_INT &
-- 
2.39.2

