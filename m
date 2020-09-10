Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA37926472F
	for <lists+linux-can@lfdr.de>; Thu, 10 Sep 2020 15:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbgIJNm2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Sep 2020 09:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730930AbgIJNjG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Sep 2020 09:39:06 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA66C0613ED
        for <linux-can@vger.kernel.org>; Thu, 10 Sep 2020 06:38:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bd2so930472plb.7
        for <linux-can@vger.kernel.org>; Thu, 10 Sep 2020 06:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N3mgJASizexPLNkdFt4Wcjn+xRiScZKeT3febPP2GBs=;
        b=jm0FeBubSLNdmOw7edyREhQe0fHd7uC1w3dnmUfrc1pPQA9LjHaAGbmQmlzdWirFNI
         zATrB/jWrCY/mvh5sRgI21Jdv6tCgd4nwF67n6J0i3+akIH16jJe1P8fn5kuNIRFBBJy
         AjVBalKDmuD35a49JkSS04+cwj4A3cjMwkzu/lrltDB2LXekFJBua8k6M3VCGUDoEmif
         tzJICDtdTfeg2enYNGt9lQw4mewr7jRWXqMoVXMM7ehzyjjJlj4OqNeKQAk4/sxMDe0/
         IaMfUp1ctePiLCggBZ+SFFrEL2W7R8iVMoze9fLs9WEt41HK2TMNntRYjuU6WgjbMLtT
         c1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N3mgJASizexPLNkdFt4Wcjn+xRiScZKeT3febPP2GBs=;
        b=bhXu8EbFQgYfmc0PAI0Pqf97vjUTCOFpIeWuOOgCHPd2YIzNARFnWhCPfcubaf1bsz
         4ORZvZ+LgMNCRmniY/m3deVYLE7ToZfWe0jTHZeASX5rh2xGsFb2g982RKOqjbX62bsA
         r7UKgGGE6v0/pCFyLGy4kh5kGbwdZvUFMHWpd7sYuBCiNyJ8afsVg91NrnQazZ+9Cp3n
         pZWfOetIwgw4KV1aeXCYifmqKuxqheqe8wnkRa9pRpBUx8mXyQozNt65JYgXnEDz8L3D
         MTSFVc8Nyt3c/O+vW1OuJnYT4Wz9bSCCnXVThH9ncx+BAp+V7ayasQlN0JXw4ps1Op30
         N88Q==
X-Gm-Message-State: AOAM531Oih+Nfy3Cjajej1ghBYSwQM0lAZqtNjBHvLD02qitzNKqdDa9
        ig1W7oaWieG62DkE/HwVBLwHMVzE/xzvd/k=
X-Google-Smtp-Source: ABdhPJxRELGnMm3DJ89Rir5TtGhJ47XLeP1KTjwsnp7EbUrctdExJ5hMzEP2U6K/qP0+ei6wNUSEag==
X-Received: by 2002:a17:902:8f98:b029:d1:870b:469e with SMTP id z24-20020a1709028f98b02900d1870b469emr5877515plo.3.1599745102152;
        Thu, 10 Sep 2020 06:38:22 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id o30sm5603801pgc.45.2020.09.10.06.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:38:21 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org
Cc:     linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev.kurt@vandijck-laurijssen.be,
        o.rempel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/6] can: rx-offload: can_rx_offload_add_manual(): add new initialization function
Date:   Thu, 10 Sep 2020 19:08:01 +0530
Message-Id: <20200910133806.25077-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910133806.25077-1-manivannan.sadhasivam@linaro.org>
References: <20200910133806.25077-1-manivannan.sadhasivam@linaro.org>
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds a new initialization function:
can_rx_offload_add_manual()

It should be used to add support rx-offload to a driver, if the callback
mechanism should not be used. Use e.g. can_rx_offload_queue_sorted() to queue
skbs into rx-offload.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/net/can/rx-offload.c   | 11 +++++++++++
 include/linux/can/rx-offload.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index e8328910a234..3b180269a92d 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -351,6 +351,17 @@ int can_rx_offload_add_fifo(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_add_fifo);
 
+int can_rx_offload_add_manual(struct net_device *dev,
+			      struct can_rx_offload *offload,
+			      unsigned int weight)
+{
+	if (offload->mailbox_read)
+		return -EINVAL;
+
+	return can_rx_offload_init_queue(dev, offload, weight);
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_add_manual);
+
 void can_rx_offload_enable(struct can_rx_offload *offload)
 {
 	napi_enable(&offload->napi);
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
index 1b78a0cfb615..f1b38088b765 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -35,6 +35,9 @@ int can_rx_offload_add_timestamp(struct net_device *dev,
 int can_rx_offload_add_fifo(struct net_device *dev,
 			    struct can_rx_offload *offload,
 			    unsigned int weight);
+int can_rx_offload_add_manual(struct net_device *dev,
+			      struct can_rx_offload *offload,
+			      unsigned int weight);
 int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
 					 u64 reg);
 int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload);
-- 
2.17.1

