Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B5862CB96
	for <lists+linux-can@lfdr.de>; Wed, 16 Nov 2022 21:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbiKPUyL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Nov 2022 15:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbiKPUxt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Nov 2022 15:53:49 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260C2FCF
        for <linux-can@vger.kernel.org>; Wed, 16 Nov 2022 12:53:29 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u24so28409269edd.13
        for <linux-can@vger.kernel.org>; Wed, 16 Nov 2022 12:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQXrupsqnXF1GGI8XYdR6EHbywjzNEqXAWKw2mVWyKY=;
        b=q6Ppqc7SSiseRXuaUY5yOxkTlGSSXo+V1jekORDzSlvpc7FVSJiS4J/298QhA6gdjz
         vllNwMANVlC7mUEyI6DwHdG1EIQcbLUHu8+sCxeBC88/elFeyA3RCS5myrLVCzYGEHZH
         Tm51noOoIWVfOpl6H2VJVvINlzEJym4Ylb6cGFyjNQTWH0LG/UZ1ekr0gvJSEBocVGh9
         HVA54xdOtt3L38zbcxMcKE5GmXopQXvkuNnNbmo5qezOs9EL8tfBMo0rAZZTlPDMp8ki
         aajesdEQKHBEdXLWnFidRTIhS4+QWm/ROAS/g9dp9zJSKjRuJqBCOOXEdTW+08lGpVy4
         gA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQXrupsqnXF1GGI8XYdR6EHbywjzNEqXAWKw2mVWyKY=;
        b=dVcya/mb3w6Znju4of9mtxjmrBQefs0KABDBMk7877xLXY10LIrxMJ5pDUVbCFCzm6
         0B7OORofB/rvLEVDJdBeW8U0wnXfSUZoufNueABlNfLRDiQDaluC0HyuPKql6v6Ua8kM
         Ws5keyTwJ5F0ul+6PRm5uuEueint0gLuy/zMNz3FlEE/N0/Md+19eDZEGQ3H0onWiC6P
         nAYOkCHlVoNuPsL0PkOFUteq+Plxg3E0pOFUW6kcqmz62ohWmqAxKam0guy92cC2aVjx
         jsHICQCUkyd16TVniFP8mrisHiqVgRDEWevV9APf3Hc4BoYkbzGWeTdL2/voibFBVDUT
         Yq9g==
X-Gm-Message-State: ANoB5pne9QeLNSvpcfWMHeJ6JAljnL7XHlM7s9dB2wZs3gqK/WWsoUwS
        fE8OewralJJdUSaX3lRliZrNLw==
X-Google-Smtp-Source: AA0mqf6onr0UJGwx/YN3BsxIeBRS/DJyIIPckZ+9rcobZ6j1RQ51NtbUtHMVONk4UJxXyJVSzFjlow==
X-Received: by 2002:a05:6402:2906:b0:461:c7bd:7da3 with SMTP id ee6-20020a056402290600b00461c7bd7da3mr21102534edb.218.1668632008075;
        Wed, 16 Nov 2022 12:53:28 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4090:a244:804b:353b:565:addf:3aa7])
        by smtp.gmail.com with ESMTPSA id kv17-20020a17090778d100b007aece68483csm6782828ejc.193.2022.11.16.12.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:53:27 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 05/15] can: m_can: Disable unused interrupts
Date:   Wed, 16 Nov 2022 21:52:58 +0100
Message-Id: <20221116205308.2996556-6-msp@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116205308.2996556-1-msp@baylibre.com>
References: <20221116205308.2996556-1-msp@baylibre.com>
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

There are a number of interrupts that are not used by the driver at the
moment. Disable all of these.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 4a6972c8bacd..5c00c6162058 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1245,6 +1245,11 @@ static void m_can_chip_config(struct net_device *dev)
 	u32 cccr, test;
 	u32 interrupts = IR_ALL_INT;
 
+	/* Disable unused interrupts */
+	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TFE | IR_TCF |
+			IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N | IR_RF0F |
+			IR_RF0W);
+
 	m_can_config_endisable(cdev, true);
 
 	/* RX Buffer/FIFO Element Size 64 bytes data field */
-- 
2.38.1

