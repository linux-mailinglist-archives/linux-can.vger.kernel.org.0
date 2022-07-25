Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E28580242
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiGYPyR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiGYPyR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:54:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3A3DF66
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y24so10779484plh.7
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mUfBhfopMVBb3MFwSEXJ1qSIyFCctmXAqcvt99jbLEk=;
        b=anibu+7vHNYNwaVw061PiYGvMk+a6ULEvGlHZOC5WXw1+njTqAwylBtUXR/da7irmD
         f/kzBMak7FuqjO2D4RzY2I65INwuN94eMfkcXgJPmAH9FHWnRhQtWlgVzkclt8eDnQZa
         1gOCNffqj6huZpHCfWF02E2hqb0oLG2Be8a4OPfev956jmiaH2IqkQDvWl296HRHRhqW
         Xk/r4k8LQVfz+ubomMnoJV4kyMVUkhfqkV+6gyvm+LcKIF2V2Iq1vaZH/jWHxpy/HPRr
         tL39Z4MOPXEESewTQY9brv/eISWdWkfv8jylYKxXUrP+zTPb+1khlu0xAhpRRB149jJY
         3fvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mUfBhfopMVBb3MFwSEXJ1qSIyFCctmXAqcvt99jbLEk=;
        b=R0ZJJGquwqoB/BFdFWUze+3mYcy+6OIzH7iQHVzvl3Y0UG/R8AKhQpZXgsy0X07i90
         fFTnv7xOiKXQIrkPcyVKAEg569Ri6yelT8Wo8r7VXVRbzm2qtUwauuMHqQm+cUwoOZLO
         GmyGsLmqtVvKiJsdVRraAe+DQepKcSmsBXUOU3d6wZPO63ECbC9nOuWJln9wAlc6B7xb
         +eb88Ut4Pc23TxHqUVXpD2td6sV7GNrYzFufEC+WzzewQdcCkG5ujSuZq12aJ0yPlYnT
         /kjckKf+k/ds/4syDK9niO3kImG9qpeQ7VORsuNYAgHguSbtMwF12KhpMBZdY5Nu1JvG
         BE5A==
X-Gm-Message-State: AJIora/ibqSvw5yfpzsiwdxoZnkeAhYRj04Yfaa+EqTe4HjFXAH0BG/5
        mAGl2mMBNRYxMNDBJzzChbTp+0F7HWKAVA==
X-Google-Smtp-Source: AGRyM1tq2TYOO2gJJ/qzD/5E5f4GgvWl84Oj0MmRRBlRXe0cscdRBGzFNP08eIKsN4Ww8aDWgzFM/w==
X-Received: by 2002:a17:902:ecc2:b0:16d:6146:3337 with SMTP id a2-20020a170902ecc200b0016d61463337mr9452435plh.139.1658764455076;
        Mon, 25 Jul 2022 08:54:15 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b0016d692ff95esm3511296plr.133.2022.07.25.08.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:54:14 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 03/14] can: slcan: add software tx timestamps
Date:   Tue, 26 Jul 2022 00:53:43 +0900
Message-Id: <20220725155354.482986-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725155354.482986-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220725155354.482986-1-mailhol.vincent@wanadoo.fr>
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

TX timestamps were added to the can_put_echo_skb() function of can_dev
modules in [1]. However, slcan does not rely on that function and as
such does not offer TX timestamping.

Add a call to skb_tx_timestamp() in the slc_xmit() function so that
the module now supports TX software timestamps.

[1] commit 741b91f1b0ea ("can: dev: can_put_echo_skb(): add software
tx timestamps")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=741b91f1b0ea34f00f6a7d4539b767c409291fcf

CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/slcan/slcan-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index dc28e715bbe1..d4dbeb849432 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -626,6 +626,8 @@ static netdev_tx_t slc_xmit(struct sk_buff *skb, struct net_device *dev)
 	slc_encaps(sl, (struct can_frame *)skb->data); /* encaps & send */
 	spin_unlock(&sl->lock);
 
+	skb_tx_timestamp(skb);
+
 out:
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
-- 
2.35.1

