Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7C97A02A6
	for <lists+linux-can@lfdr.de>; Thu, 14 Sep 2023 13:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjINLaR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Sep 2023 07:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbjINLaQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Sep 2023 07:30:16 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62E1A8
        for <linux-can@vger.kernel.org>; Thu, 14 Sep 2023 04:30:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c06f6f98c0so6962515ad.3
        for <linux-can@vger.kernel.org>; Thu, 14 Sep 2023 04:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694691012; x=1695295812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wvuYGMb69gw0ryjEx45T+Ib9bEdJbUfO1MAucMghFI=;
        b=VNVkgdIC4G8xFH1BDC4jHxH/ZbmitQjmwUv0IKjoFJjQfWDjIihp8jqAafHmwPRN8U
         0/eEFowdwobH/JXsJS8QcYDwCRz26gdelxJUnVzPTH3B13KbrA8YOcnTwquin8aR1ZNQ
         duwc9r/Pf6GfuvjMwKPK7A0PfXNeoHl6hWWJUt23kJxU8WWpdeOUuyiE+esPjp/EpOyW
         V6lqcOCYFIQw33b6Y8FyPylg+Yl56JuizcogIQuDxmMZtyooow0MDaFSEYoHDLpl4Y0P
         NlGVTNbL6sL9/71oYEbb8ljIuLDiuI53sWIVCT0QtUJjj86CGfGLNeLv4q/UK4PyYtyZ
         HBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691012; x=1695295812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5wvuYGMb69gw0ryjEx45T+Ib9bEdJbUfO1MAucMghFI=;
        b=InNGh5nHEchL1zwOFDNIedkqK0dvvYYydh9XVYkyCthwGgScBQ35k8W3UDPNYR8qLC
         XpHxiPDKdQob6wyH41kMkgjjDETOyQ8puWtFEuvh4pflU0mPzW8mV2nQ1u/+erg/qN6t
         G0sOwgRSEUcANznu3OPXmxHeFKHuriUDAEeRprsoZdVkzGDa/B6bsISvlN0ZLbs00Nmo
         4IxRJqa03Fi/1qz9LOT98hHKCNO9fZB6+1xPJnRknMfba4skjZyPBB83woxckq9I51WZ
         UXjOQyXcO9KRM7qeliYm2CI6IU36svw8TeA06s6/NCwF28cPGrl710IgJ6zDNhPsCTIv
         KgXA==
X-Gm-Message-State: AOJu0YzDalZ6Xd0EAjlFV/iz2Ocout3/ISh0yISeNSZ1ZfTPInnY5DXv
        c8AoORL1Nl+WhfX7MJSxKRUodRYHmWk=
X-Google-Smtp-Source: AGHT+IGgmgMh008C+8NKvcKRdHd3OxvAesUTkEYeRG/hrmzivSXIqeHzOyEBJItEnW4KrA+073Zk9w==
X-Received: by 2002:a17:902:b618:b0:1b8:954c:1f6 with SMTP id b24-20020a170902b61800b001b8954c01f6mr4485582pls.36.1694691012185;
        Thu, 14 Sep 2023 04:30:12 -0700 (PDT)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b001b87d3e845bsm1350765pll.149.2023.09.14.04.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:30:11 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 2/2] can: etas_es58x: add missing a blank line after declaration
Date:   Thu, 14 Sep 2023 20:29:54 +0900
Message-Id: <20230914112954.3067242-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230914112954.3067242-1-mailhol.vincent@wanadoo.fr>
References: <20230914112954.3067242-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

