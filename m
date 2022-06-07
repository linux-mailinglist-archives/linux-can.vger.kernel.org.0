Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3322553FA4D
	for <lists+linux-can@lfdr.de>; Tue,  7 Jun 2022 11:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbiFGJuk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Jun 2022 05:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240177AbiFGJtE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Jun 2022 05:49:04 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E2DD02B8
        for <linux-can@vger.kernel.org>; Tue,  7 Jun 2022 02:48:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id h62-20020a1c2141000000b0039aa4d054e2so11415475wmh.1
        for <linux-can@vger.kernel.org>; Tue, 07 Jun 2022 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2VLfBpv9snTnPtrFeblfPn0318JEYJPp1U8Dhg0IAiM=;
        b=HMeORKBxetV4QI2ugUhV+SAFIaXv8HHxDgkUH6QeuVHCf9v7Ri67vG6l4/TKkI7Bat
         HO0rixGSw1GsvjQisUutl6Qnma4ggDLfNm64iaaHEcfW00w5/9fRFJkRk3C+pezT20W6
         NXeHFtQDrlGzyiLuXu+SAj4JelCzvlNlM/Urc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2VLfBpv9snTnPtrFeblfPn0318JEYJPp1U8Dhg0IAiM=;
        b=UNZTZE0GnWObcOXr0Ix1wEkYBFJ74FWhVEp0ccTbGvHKRmGBYzwjd247NFuWaRMqYE
         yDbDvf/Rf8LE6FZxJoZLi4UfA0vPIHfGr9pK2KapP/b6DPpoPr6w8SnTFh1V1GwQz5h5
         zp34zO7Id5UtSsz+6eH9hUKK6ceRp25xcVZfSIRelotmMJlKOAXRVTXRrE9s5Il88hkQ
         0M1GdSiTjDKgV+Eqa2JhZwBZPYjiVI1vTRxh2ecnMFzhWEhXmNJD3r+mFCSoee4+/VKr
         1Qn+8DtaTRWaasgn2xrddkq+Vs0zsqFJn0WQu6av3mjcqaWGek4oYVGvyTZXQfqzd97Q
         jh5Q==
X-Gm-Message-State: AOAM532IB/BAcOL9ftblgrGGHYiR993iVIwSBxvhMwiqPK1sUXuh20lq
        GbH4WwtMDTqnegVklQcOEQRI8g==
X-Google-Smtp-Source: ABdhPJw9Gl+2q8xHAb7YUzrBZ00lnyxBhgAgeN6N/8Ccau2FIzxCSIV6UAiQXW54fv1weMBh+0U8Gg==
X-Received: by 2002:a05:600c:3d05:b0:398:a78b:6a30 with SMTP id bh5-20020a05600c3d0500b00398a78b6a30mr27816891wmb.175.1654595314137;
        Tue, 07 Jun 2022 02:48:34 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (mob-5-90-137-51.net.vodafone.it. [5.90.137.51])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c510400b0039748be12dbsm23200547wms.47.2022.06.07.02.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:48:33 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC PATCH 12/13] can: slcan: extend the protocol with error info
Date:   Tue,  7 Jun 2022 11:47:51 +0200
Message-Id: <20220607094752.1029295-13-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
References: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

It extends the protocol to receive the adapter CAN communication errors
and forward them to the netdev upper levels.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/slcan/slcan-core.c | 104 ++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index b813a59534a3..02e7c14de45c 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -182,8 +182,92 @@ int slcan_enable_err_rst_on_open(struct net_device *ndev, bool on)
   *			STANDARD SLCAN DECAPSULATION			 *
   ************************************************************************/
 
+static void slc_bump_err(struct slcan *sl)
+{
+	struct net_device *dev = sl->dev;
+	struct sk_buff *skb;
+	struct can_frame *cf;
+	char *cmd = sl->rbuff;
+	bool rx_errors = false, tx_errors = false;
+	int i, len;
+
+	if (*cmd != 'e')
+		return;
+
+	cmd += SLC_CMD_LEN;
+	/* get len from sanitized ASCII value */
+	len = *cmd++;
+	if (len >= '0' && len < '9')
+		len -= '0';
+	else
+		return;
+
+	skb = alloc_can_err_skb(dev, &cf);
+	if (unlikely(!skb))
+		return;
+
+	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+	for (i = 0; i < len; i++, cmd++) {
+		switch (*cmd) {
+		case 'a':
+			netdev_dbg(dev, "ACK error\n");
+			cf->can_id |= CAN_ERR_ACK;
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+			tx_errors = true;
+			break;
+		case 'b':
+			netdev_dbg(dev, "Bit0 error\n");
+			cf->data[2] |= CAN_ERR_PROT_BIT0;
+			tx_errors = true;
+			break;
+		case 'B':
+			netdev_dbg(dev, "Bit1 error\n");
+			cf->data[2] |= CAN_ERR_PROT_BIT1;
+			tx_errors = true;
+			break;
+		case 'c':
+			netdev_dbg(dev, "CRC error\n");
+			cf->data[2] |= CAN_ERR_PROT_BIT;
+			cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+			rx_errors = true;
+			break;
+		case 'f':
+			netdev_dbg(dev, "Form Error\n");
+			cf->data[2] |= CAN_ERR_PROT_FORM;
+			rx_errors = true;
+			break;
+		case 'o':
+			netdev_dbg(dev, "Rx overrun error\n");
+			cf->can_id |= CAN_ERR_CRTL;
+			cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+			dev->stats.rx_over_errors++;
+			dev->stats.rx_errors++;
+			break;
+		case 'O':
+			netdev_dbg(dev, "Tx overrun error\n");
+			cf->can_id |= CAN_ERR_CRTL;
+			cf->data[1] = CAN_ERR_CRTL_TX_OVERFLOW;
+			dev->stats.tx_errors++;
+			break;
+		case 's':
+			netdev_dbg(dev, "Stuff error\n");
+			cf->data[2] |= CAN_ERR_PROT_STUFF;
+			rx_errors = true;
+			break;
+		}
+	}
+
+	if (rx_errors)
+		dev->stats.rx_errors++;
+
+	if (tx_errors)
+		dev->stats.tx_errors++;
+
+	netif_rx(skb);
+}
+
 /* Send one completely decapsulated can_frame to the network layer */
-static void slc_bump(struct slcan *sl)
+static void slc_bump_frame(struct slcan *sl)
 {
 	struct sk_buff *skb;
 	struct can_frame cf, *scf;
@@ -257,6 +341,24 @@ static void slc_bump(struct slcan *sl)
 	netif_rx(skb);
 }
 
+static void slc_bump(struct slcan *sl)
+{
+	switch (sl->rbuff[0]) {
+	case 'r':
+		fallthrough;
+	case 't':
+		fallthrough;
+	case 'R':
+		fallthrough;
+	case 'T':
+		return slc_bump_frame(sl);
+	case 'e':
+		return slc_bump_err(sl);
+	default:
+		return;
+	}
+}
+
 /* parse tty input stream */
 static void slcan_unesc(struct slcan *sl, unsigned char s)
 {
-- 
2.32.0

