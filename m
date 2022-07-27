Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4BB5824CA
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 12:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiG0Kt6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 06:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiG0Kt6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 06:49:58 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58174240B3
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:49:57 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s206so15605289pgs.3
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UfosPrKXfcM2/IXIziYY5z/satrsG79d8cyjsBFHFuw=;
        b=c3SnZHpeOotzylNdy0DH/DLDZKSodYiEG3SCJPE7JbTN/geVWvZEeq9gp2NGuXwrWV
         LP7ZoIK0ZMWTxLHEbnLvaNXHV3Te0CLdVUxvsN+qdS+Q6TfvJJKK0aPwklXP1n6HOEV5
         K1FgfIZhrsnXsQMsHAVrfD/noAqq5z8HkxgRALmqfkpfeH8J40oAGrm/Vn/EPKy735Av
         PuZaAT3gYOukqsKjIbejJzywcSUbxZR+2+GOx7fRmjsIyS/n2KTjzdAo98hJq4s7Dw6u
         E0mTNkNEcKrRN22v92KoT28VAzCbRPR3NzxPDEe9zbJWikH1E5LZfAi8F9katK22ZfZ1
         2AOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UfosPrKXfcM2/IXIziYY5z/satrsG79d8cyjsBFHFuw=;
        b=wTtsmvQNY78TA12xSngSu2Cqx721ZyRpPKMumXcg63HirbfQULprTV/UD5tc4A+5T2
         tw7QiTxRx9ltUKUK2zXRsr9wOithQdqIwmiR30CGEtZyWVPrPS9AyCmUhoJgR2i7hnnL
         o/IyWATJecJgTKU0+Ozt9hEGCybnRGaYRDV9901219IoV+7n/WeSgzvwW/HVCPGtnM3y
         8pUCTTmn5dM88bBk7n076rB8VTrO+MZP//Kh89X/QzGtwzLm3p9he4U/SDvph/IuUR8i
         TwexAf5YB0XsqiYn16Nz4psjQh68RsInNX/5rmLTBju2P7NUjajhGX16oANQ5rSvVUDS
         Uung==
X-Gm-Message-State: AJIora/7XUNMCx5qPzjLjRaRSQN3oQL7p71V7/Nj2/bcikTX2iNw/3Mk
        /Hwp3pj7tCt7DcTKP4l0QyddZPsLbR0=
X-Google-Smtp-Source: AGRyM1unUt86JpFD4l+sKKnD5s1X/V0uxRFS4HmGB1T6zowLj5Tk/3GJ7Rvk56+0PBOu1shRUJnhzA==
X-Received: by 2002:a63:1220:0:b0:411:f661:f819 with SMTP id h32-20020a631220000000b00411f661f819mr18828935pgl.250.1658918996621;
        Wed, 27 Jul 2022 03:49:56 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id o19-20020aa79793000000b00525343b5047sm13526114pfp.76.2022.07.27.03.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:49:56 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 2/3] can: c_can: export c_can_ethtool_ops and remove c_can_set_ethtool_ops()
Date:   Wed, 27 Jul 2022 19:49:38 +0900
Message-Id: <20220727104939.279022-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220727104939.279022-1-mailhol.vincent@wanadoo.fr>
References: <20220727104939.279022-1-mailhol.vincent@wanadoo.fr>
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

The function c_can_set_ethtool_ops() does one thing: populate
net_device::ethtool_ops. Instead, it is possible to directly assign
this field and remove one function call and slightly reduce the object
size. To do so, export c_can_ethtool_ops so it becomes visible to
c_can_main.c.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/c_can/c_can.h         | 2 +-
 drivers/net/can/c_can/c_can_ethtool.c | 7 +------
 drivers/net/can/c_can/c_can_main.c    | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index bd2f6dc01194..f23a03300a81 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -223,7 +223,7 @@ int c_can_power_up(struct net_device *dev);
 int c_can_power_down(struct net_device *dev);
 #endif
 
-void c_can_set_ethtool_ops(struct net_device *dev);
+extern const struct ethtool_ops c_can_ethtool_ops;
 
 static inline u8 c_can_get_tx_head(const struct c_can_tx_ring *ring)
 {
diff --git a/drivers/net/can/c_can/c_can_ethtool.c b/drivers/net/can/c_can/c_can_ethtool.c
index 8a826a6813bd..36db2d9391d4 100644
--- a/drivers/net/can/c_can/c_can_ethtool.c
+++ b/drivers/net/can/c_can/c_can_ethtool.c
@@ -24,11 +24,6 @@ static void c_can_get_ringparam(struct net_device *netdev,
 	ring->tx_pending = priv->msg_obj_tx_num;
 }
 
-static const struct ethtool_ops c_can_ethtool_ops = {
+const struct ethtool_ops c_can_ethtool_ops = {
 	.get_ringparam = c_can_get_ringparam,
 };
-
-void c_can_set_ethtool_ops(struct net_device *netdev)
-{
-	netdev->ethtool_ops = &c_can_ethtool_ops;
-}
diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
index de38d8f7b5f7..dc8132862f33 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -1364,7 +1364,7 @@ int register_c_can_dev(struct net_device *dev)
 
 	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &c_can_netdev_ops;
-	c_can_set_ethtool_ops(dev);
+	dev->ethtool_ops = &c_can_ethtool_ops;
 
 	return register_candev(dev);
 }
-- 
2.35.1

