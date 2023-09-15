Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B36B7A15B7
	for <lists+linux-can@lfdr.de>; Fri, 15 Sep 2023 07:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjIOFsj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 15 Sep 2023 01:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjIOFsj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Sep 2023 01:48:39 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ADF2716
        for <linux-can@vger.kernel.org>; Thu, 14 Sep 2023 22:48:24 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68fc292de9dso1332320b3a.0
        for <linux-can@vger.kernel.org>; Thu, 14 Sep 2023 22:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694756904; x=1695361704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wvuYGMb69gw0ryjEx45T+Ib9bEdJbUfO1MAucMghFI=;
        b=cI9zg0WDHM4EoOc19Z/5L8O+ynkUb4sISfW1MaOKj5ByPuneomZqJYdfI3AtI9FxOf
         qG52IYbkDId1Ei90doFDuuqKmvaq9sChMoiq+6UnPLxA7bRMSzhHf9fx2Q7jYFATFNtA
         EjPaCxoyXmKQx5rT095JTZJ1SgRjJiOsKFozzjqMUH+/qUyQCRj8pLLXCfiewoUtY65B
         OTGkltfiDbUxRZGREfsrSvTUoAj9pWCHclPCqFky+gm+t09PPqBOmQ/1VsrCOcBFbDaZ
         pNOvA37XohTlNLKT3KdSuozDtbeASrjK47WCsKBS33p++rqjaDVM7ATgImJcC6IcsbeO
         zfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694756904; x=1695361704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5wvuYGMb69gw0ryjEx45T+Ib9bEdJbUfO1MAucMghFI=;
        b=mCJlGI5PHh0p5aHmwPLmAitaTxNh8CGK99EZJnh1/EPsXjx2+0K4bHRjYkZhjvbft6
         u9Pd978j1bgSswHePlrNvA6BkfoXPo0IzHEzTy2EAlAPnN8JUbSqz2eyrRU3TRHifqmy
         EnrcV1uwY3EfuA0D1j2k18rec8osGaMgqyQjJwecmDramVYUC+3OCcx2dMZ1fAXlYSPd
         yFb2inLjfxc/kth+hF5uyIHdK0/uQqGC6nePc8rwNYjgA5d+Fq87Fbv+GlfjxpoGJHmf
         4cWQgzcOHZbN2zqsZk3EMVwuioQJqViiFeNmiGmzfYaXVSiN7XfdIls7Qo8+o3pMi+Zn
         10Ww==
X-Gm-Message-State: AOJu0YzBrNrTzEsX9JhV17KoMeeH9o9iNtPQrdtYRscXciZ01CDviAj3
        u/d5LclBWLTobaLireMOjbo=
X-Google-Smtp-Source: AGHT+IEH1SbgLgbAe8PjKBkF2+EEKFERWQH+zw357MFjxj5hfoG5GqjNC1feQhg0N1H6fHJuDMtXNA==
X-Received: by 2002:a05:6a00:b91:b0:68f:b769:9182 with SMTP id g17-20020a056a000b9100b0068fb7699182mr6657155pfj.9.1694756903883;
        Thu, 14 Sep 2023 22:48:23 -0700 (PDT)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id s3-20020aa78d43000000b0068c62a45be6sm2268742pfe.179.2023.09.14.22.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 22:48:23 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 2/2] can: etas_es58x: add missing a blank line after declaration
Date:   Fri, 15 Sep 2023 14:48:15 +0900
Message-Id: <20230915054815.3130251-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915054815.3130251-1-mailhol.vincent@wanadoo.fr>
References: <20230914112954.3067242-1-mailhol.vincent@wanadoo.fr>
 <20230915054815.3130251-1-mailhol.vincent@wanadoo.fr>
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
2.25.1

