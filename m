Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD69704F9C
	for <lists+linux-can@lfdr.de>; Tue, 16 May 2023 15:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjEPNnc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 May 2023 09:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjEPNnb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 May 2023 09:43:31 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DC659FA
        for <linux-can@vger.kernel.org>; Tue, 16 May 2023 06:43:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f27b65bbf9so5534001e87.0
        for <linux-can@vger.kernel.org>; Tue, 16 May 2023 06:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684244608; x=1686836608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NVzQFwvew968h4U+Y1dDfo1zepT864PRVELa6Ou4Mw=;
        b=avDzM8EBD2cvW0UiagGCPoS423E/8SMyRBPrBqlkWiGCtqOljFedOd9/O5uDjTANJA
         GK443og3wkyKqJvTD6DVbjtj7WgIRL7NjnKPHfLZ2hOyr/K7VywYX0xgrgVrbZ3oICAZ
         OmVJlKvT4jUzMr7cgNzQtcBcA3wB8hRsuPV2iRBec2999QYxxDVWL3M+ka0uOgXisneO
         DEMq6O8tMSa6Lmt4tKNao8SOATzagKtURgDBRSgfuxYoZAxIaMMU0Ws0KSrgsEC/1wFB
         HsWSxb/KI+oMLHmqeztpYD0/msiEQ7EnzP7o5v6oY7ic+LWDbgoOGFTEEIVKpNyXGqrH
         Ignw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684244608; x=1686836608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NVzQFwvew968h4U+Y1dDfo1zepT864PRVELa6Ou4Mw=;
        b=Jry8m7UzQRRiOtxiN5ftfDRn527TrE99sv1jxuYktDpCUiolx1bLgAH59HKRsTc7H8
         LpSg9jPCNADpbwe8y26UuUH2zgwQQpMhebwzJZWKZ8xjzF8DW5ZQDR44zgSk0jj2DW9K
         fgWX30dVArLHQtYyMRjZrVXl0N2Rqq7B25PfesLitmL2+esai9aR+hli92PW1UVmv4m0
         zvRr6JNv8tWz4CrxTwyPYWpYhFfBTTCFo3YSf0s7StvTvUnrDpzJnFxIHREL8/jj7XSV
         TQ3ZKaHcYjky3Ovv/Ne2PuY32h+dSamjD4TzQax1HMo8jnO2IkJEyMhq8uVSAGl9JpsE
         R2sA==
X-Gm-Message-State: AC+VfDxFxQ+K+cWEF8qoT93VSH7f5YlsHIYwdhLxVLSyTqhzmDJOJsa6
        Zf67XpvxH7OPci47QCnw76BY0IyNrrkFJby86JVBTQ==
X-Google-Smtp-Source: ACHHUZ63viSkfFOt5QEIR7bOdK9/c1iR/5FAEmZeGIQPTEI7+BvjZRsFa+uLHi5F7LuX5IvH7QQBrA==
X-Received: by 2002:a19:ac01:0:b0:4eb:3fb2:c56d with SMTP id g1-20020a19ac01000000b004eb3fb2c56dmr7517169lfc.12.1684244608623;
        Tue, 16 May 2023 06:43:28 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id l26-20020ac24a9a000000b004f13b59307asm2962558lfp.232.2023.05.16.06.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 06:43:28 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>, stable@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 1/6] can: kvaser_pciefd: Set CAN_STATE_STOPPED in kvaser_pciefd_stop()
Date:   Tue, 16 May 2023 15:43:13 +0200
Message-Id: <20230516134318.104279-2-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230516134318.104279-1-extja@kvaser.com>
References: <20230516134318.104279-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Set can.state to CAN_STATE_STOPPED in kvaser_pciefd_stop().
Without this fix, wrong CAN state was repported after the interface was
brought down.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 53e8a914c88b..867b421b9506 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -719,6 +719,7 @@ static int kvaser_pciefd_stop(struct net_device *netdev)
 		iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 		del_timer(&can->bec_poll_timer);
 	}
+	can->can.state = CAN_STATE_STOPPED;
 	close_candev(netdev);
 
 	return ret;
-- 
2.40.0

