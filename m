Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097887AC7A9
	for <lists+linux-can@lfdr.de>; Sun, 24 Sep 2023 13:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjIXLJe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 24 Sep 2023 07:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjIXLJd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 24 Sep 2023 07:09:33 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7898100
        for <linux-can@vger.kernel.org>; Sun, 24 Sep 2023 04:09:24 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3ab7fb1172cso2471708b6e.3
        for <linux-can@vger.kernel.org>; Sun, 24 Sep 2023 04:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695553764; x=1696158564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XykT7Pvm3/qXSVCzfm1G/LVdKX7vGju1jlwfidwvoqQ=;
        b=Hs/cIIQa/+iIw7cXfSFLNWJnqy0Z3OoDU2g2eU9Hvj3KMzNh8yJlkAGRvGS9V+Ov5Y
         TN0S/n9J2jfi0/IkXJuiZRRCXwbRy30Ao74lLURsMeHOmCK6o6upQC0fdkcu8N/az1dO
         SLu475jLVIL2eNwM0J2sJziBFTKJJiYzGD5Ue4kecrAId8FkkWYtmqwih5JJnwYvj6lo
         E6jwjhpqd3J8lKofYmBmTT6z2YDXzda3DeMbj1lMiwYWJ0mEPuC6xVCOXiIhFrSqyvMW
         gwXKxP66rfPZQrhxIouTsqbry6fzen9+WYUeig5ed9BNHZVsGygquTICg2FXNNNNd3B/
         MV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695553764; x=1696158564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XykT7Pvm3/qXSVCzfm1G/LVdKX7vGju1jlwfidwvoqQ=;
        b=dcirvkPPWInwIdOMJfbXddF//LJRIpkkTndXkNdWKQ1zcCGdPDWhZSc7Zm/WLMM4Cy
         fqgZtsFFpOIWAaKzzxOnY0vRL3WSx/AeB+NyI6H54bPu6vB4VXi6cTUOaRzJMnRP0OXH
         PAGh8ylsrZZwRMxkE8RWvddX44BSUK8laqxO9CNq2mH1opuj/o4Zg1CBogP4/aVjvvGX
         8iYZTanCjpn5HGdC2Lmn3txn69mXbo630WTfPKDoxoubpSotEgMOxrU/96L3/TDsvzzS
         A9TT74Hd+AbHkqI6GtX/zk+SMGxBXkP6N/HJy4ZtaYmjSMoJfwkr6l1cvTAueRPQ2DV8
         XmFg==
X-Gm-Message-State: AOJu0Yx6gyl5yuXqVMnNh/MPa8Il1aLWWUlIvnyiiO3EsysFiiOkbS3i
        KtQR+fGWxwl2E2j7B144zpqrNL48jEk=
X-Google-Smtp-Source: AGHT+IHEAZ9e8bsxK8fXMJqHdQKvC5bW82IGFLLAVLmultS18Ht8jLHJcJmwJlFC4+RfQDOo1qEjhg==
X-Received: by 2002:a05:6808:1147:b0:3a1:df63:60cc with SMTP id u7-20020a056808114700b003a1df6360ccmr4926664oiu.59.1695553764011;
        Sun, 24 Sep 2023 04:09:24 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id a13-20020a63704d000000b00578f1a71a91sm6074905pgn.79.2023.09.24.04.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 04:09:23 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 2/2] can: etas_es58x: add missing a blank line after declaration
Date:   Sun, 24 Sep 2023 20:06:48 +0900
Message-ID: <20230924110914.183898-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230924110914.183898-1-mailhol.vincent@wanadoo.fr>
References: <20230914112954.3067242-1-mailhol.vincent@wanadoo.fr>
 <20230924110914.183898-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Fix below checkpatch warning:

  WARNING: Missing a blank line after declarations
  #2233: FILE: drivers/net/can/usb/etas_es58x/es58x_core.c:2233:
  +		int ret = es58x_init_netdev(es58x_dev, ch_idx);
  +		if (ret) {

Fixes: d8f26fd689dd ("can: etas_es58x: remove es58x_get_product_info()")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 0c7f7505632c..5e3a72b7c469 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -2230,6 +2230,7 @@ static int es58x_probe(struct usb_interface *intf,
 
 	for (ch_idx = 0; ch_idx < es58x_dev->num_can_ch; ch_idx++) {
 		int ret = es58x_init_netdev(es58x_dev, ch_idx);
+
 		if (ret) {
 			es58x_free_netdevs(es58x_dev);
 			return ret;
-- 
2.41.0

