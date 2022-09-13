Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17655B7C4F
	for <lists+linux-can@lfdr.de>; Tue, 13 Sep 2022 22:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiIMUvq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 13 Sep 2022 16:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIMUvo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Sep 2022 16:51:44 -0400
X-Greylist: delayed 591 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Sep 2022 13:51:43 PDT
Received: from mx0a-0054a801.pphosted.com (mx0a-0054a801.pphosted.com [205.220.160.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF6A726A9
        for <linux-can@vger.kernel.org>; Tue, 13 Sep 2022 13:51:43 -0700 (PDT)
Received: from pps.filterd (m0208803.ppops.net [127.0.0.1])
        by mx0b-0054a801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DIFkbr016210
        for <linux-can@vger.kernel.org>; Tue, 13 Sep 2022 13:41:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsara.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=samsaracom06092020;
 bh=EFPBhk+SCQxDJXmQo7DXJCthPXBU2EeA1DXwZj6FiGI=;
 b=LluQIsN1huzZtiBHUofSjktEBQhyZIgzxSDa6HqJfxzpDaiiTCb9Mx/Ps3a42IjiE/wg
 mYypNp6x3g1xfUQI+ZYe+Pgp6zwof3FQqpDVhj6VPzQt7t4WWQW58OwZF+LhFVnEv8/t
 OA4TWLHuSKKJnPbnd4Ex/i1wMiTMn93dUQmQGRS+3y1srNAwDKv85Qfs3O0zwKbs5ItQ
 Af/oJbdKo51ubVhJ1OOEhOrPU+wQhpX+YHZnxqrW9pov8bdl+/Ty/WB/r0aIhZupIXZ6
 xk6BdLpEf46spn+jOJZH/f6QTrQ7g95kHJ7wSEe8edcES8UZrGj6jF2UPIzRouO901SH EA== 
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mx0b-0054a801.pphosted.com (PPS) with ESMTPS id 3jjy00g6dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-can@vger.kernel.org>; Tue, 13 Sep 2022 13:41:52 -0700
Received: by mail-qk1-f198.google.com with SMTP id m19-20020a05620a24d300b006bb85a44e96so11325811qkn.23
        for <linux-can@vger.kernel.org>; Tue, 13 Sep 2022 13:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EFPBhk+SCQxDJXmQo7DXJCthPXBU2EeA1DXwZj6FiGI=;
        b=Yy2twMmvJTxw33VE+J+U7Bo2jFqPkcZ5ikejcZg5hGmDJFBuw8c+3jCj95V9QnSi4Y
         YwXRa401BJwH1GWLjgTlqSx7URSb7gch7RcJe/GXD4QbNJHDtD4+8loTgvDAs/Ce6KtQ
         cGI8RWkZne1IISZHtjUfwAyHFRrO8JtLWoDCZZHuz7POSWLiLcl8wIfvvOLUXpVD93/u
         4473hq/cHVCwZgbtnAH9t4UnXZ1NNOFykjcm5+SCO8zRKGsrmufyYGk6PrAcVyK9sXxX
         aSe12AC7BxnL/SG5r3Fo6nf2HUq1dReMWLuR1rmhU9pCp88ZuJ77xnJXyffkHmkc8QkL
         e9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EFPBhk+SCQxDJXmQo7DXJCthPXBU2EeA1DXwZj6FiGI=;
        b=1F1IacGZGYqFr/8n8FDHh36DvQFjAPNJncWqtAf1e8V1wS0CazgMxSMDatTJd7H9g3
         v6ReH+os/0WnwKZNegj9NUs6FZdINA/K1cVedJazdl751wDArbCoaNPqxn2k+kC0Jf6I
         kdEJgqXMz0BfftNMEsG/67eY35FFrbBzlDLWcdWUmjDtF8YpRU2T9lEtp2n4u/kYxkLK
         049M/aq58tZwY1MQ7K4qzp13EU2nlWthv0wDM9cMAVzbbqTJG2VUt+hQSu4uQxmD9fJK
         GysklGLHlqs+8qzWeXPiB/KRBJgYM3p6TT7RiUxIJMsDvkbfHUx/sHTp0gnS/90A3Ge+
         euUA==
X-Gm-Message-State: ACgBeo0U2pEXMVtiACkPFEYMkkPp5CzkZWtCdWJNmYS+UuwL2NrYAjVn
        2/xm8lNM54Jo1rgdj6LMvsrzp2xKRHwHWS02H8eXCKtxCt1O7mkBymFD5CMf4+LILpwtvW7+tIg
        rorhjSManmijJMMSceSNV
X-Received: by 2002:a0c:9062:0:b0:498:fc0e:1fc9 with SMTP id o89-20020a0c9062000000b00498fc0e1fc9mr29506912qvo.10.1663101710773;
        Tue, 13 Sep 2022 13:41:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR72GqZC3vvq9ppVfLK03M9aXWchOJol6Wrm++20mzYJv3C3QpvzsqOqDaK/lQdRyd9FTCLRLg==
X-Received: by 2002:a0c:9062:0:b0:498:fc0e:1fc9 with SMTP id o89-20020a0c9062000000b00498fc0e1fc9mr29506899qvo.10.1663101710490;
        Tue, 13 Sep 2022 13:41:50 -0700 (PDT)
Received: from downhome.. (ec2-184-72-5-93.us-west-1.compute.amazonaws.com. [184.72.5.93])
        by smtp.gmail.com with ESMTPSA id x5-20020ac81205000000b00344f7cf05b4sm249236qti.14.2022.09.13.13.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 13:41:47 -0700 (PDT)
From:   Rhett Aultman <rhett.aultman@samsara.com>
To:     linux-can@vger.kernel.org
Cc:     Rhett Aultman <rhett.aultman@samsara.com>,
        Vasanth Sadhasivan <vasanth.sadhasivan@samsara.com>
Subject: [PATCH 1/1] can: gs_usb: remove dma allocations
Date:   Tue, 13 Sep 2022 16:41:10 -0400
Message-Id: <20220913204110.89730-2-rhett.aultman@samsara.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220913204110.89730-1-rhett.aultman@samsara.com>
References: <20220913204110.89730-1-rhett.aultman@samsara.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BteUgMe4-kGW9L9h7RFoOB1JphHn5yJ0
X-Proofpoint-ORIG-GUID: BteUgMe4-kGW9L9h7RFoOB1JphHn5yJ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_10,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=724 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209130095
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Vasanth Sadhasivan <vasanth.sadhasivan@samsara.com>

DMA allocated buffers are a precious resource. If there is no need for DMA
allocations, then it might be worth to use non-dma allocated buffers.
After testing the gs_usb driver with and without DMA allocation, there
does not seem to be a significant change in latency or cpu utilization
either way. Therefore, DMA allocation is not necessary and removed.

Co-developed-by: Rhett Aultman <rhett.aultman@samsara.com>
Signed-off-by: Rhett Aultman <rhett.aultman@samsara.com>
Signed-off-by: Vasanth Sadhasivan <vasanth.sadhasivan@samsara.com>
---
 drivers/net/can/usb/gs_usb.c | 38 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index baf749c8cda3..1bfc775c62c5 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -269,7 +269,6 @@ struct gs_can {
 	struct usb_anchor tx_submitted;
 	atomic_t active_tx_urbs;
 	void *rxbuf[GS_MAX_RX_URBS];
-	dma_addr_t rxbuf_dma[GS_MAX_RX_URBS];
 };
 
 /* usb interface struct */
@@ -587,9 +586,7 @@ static void gs_usb_xmit_callback(struct urb *urb)
 
 	if (urb->status)
 		netdev_info(netdev, "usb xmit fail %u\n", txc->echo_id);
-
-	usb_free_coherent(urb->dev, urb->transfer_buffer_length,
-			  urb->transfer_buffer, urb->transfer_dma);
+	devm_kfree(&urb->dev->dev, urb->transfer_buffer);
 }
 
 static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
@@ -618,8 +615,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 	if (!urb)
 		goto nomem_urb;
 
-	hf = usb_alloc_coherent(dev->udev, dev->hf_size_tx, GFP_ATOMIC,
-				&urb->transfer_dma);
+	hf = devm_kmalloc(&dev->udev->dev, dev->hf_size_tx, GFP_ATOMIC);
 	if (!hf) {
 		netdev_err(netdev, "No memory left for USB buffer\n");
 		goto nomem_hf;
@@ -663,7 +659,6 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 			  hf, dev->hf_size_tx,
 			  gs_usb_xmit_callback, txc);
 
-	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 	usb_anchor_urb(urb, &dev->tx_submitted);
 
 	can_put_echo_skb(skb, netdev, idx, 0);
@@ -678,8 +673,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 		gs_free_tx_context(txc);
 
 		usb_unanchor_urb(urb);
-		usb_free_coherent(dev->udev, urb->transfer_buffer_length,
-				  urb->transfer_buffer, urb->transfer_dma);
+		devm_kfree(&dev->udev->dev, hf);
 
 		if (rc == -ENODEV) {
 			netif_device_detach(netdev);
@@ -699,8 +693,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 
  badidx:
-	usb_free_coherent(dev->udev, urb->transfer_buffer_length,
-			  urb->transfer_buffer, urb->transfer_dma);
+	devm_kfree(&dev->udev->dev, hf);
  nomem_hf:
 	usb_free_urb(urb);
 
@@ -744,7 +737,6 @@ static int gs_can_open(struct net_device *netdev)
 		for (i = 0; i < GS_MAX_RX_URBS; i++) {
 			struct urb *urb;
 			u8 *buf;
-			dma_addr_t buf_dma;
 
 			/* alloc rx urb */
 			urb = usb_alloc_urb(0, GFP_KERNEL);
@@ -752,10 +744,9 @@ static int gs_can_open(struct net_device *netdev)
 				return -ENOMEM;
 
 			/* alloc rx buffer */
-			buf = usb_alloc_coherent(dev->udev,
-						 dev->parent->hf_size_rx,
-						 GFP_KERNEL,
-						 &buf_dma);
+			buf = devm_kmalloc(&dev->udev->dev,
+					   dev->parent->hf_size_rx,
+					   GFP_KERNEL);
 			if (!buf) {
 				netdev_err(netdev,
 					   "No memory left for USB buffer\n");
@@ -763,8 +754,6 @@ static int gs_can_open(struct net_device *netdev)
 				return -ENOMEM;
 			}
 
-			urb->transfer_dma = buf_dma;
-
 			/* fill, anchor, and submit rx urb */
 			usb_fill_bulk_urb(urb,
 					  dev->udev,
@@ -773,7 +762,6 @@ static int gs_can_open(struct net_device *netdev)
 					  buf,
 					  dev->parent->hf_size_rx,
 					  gs_usb_receive_bulk_callback, parent);
-			urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
 			usb_anchor_urb(urb, &parent->rx_submitted);
 
@@ -786,16 +774,12 @@ static int gs_can_open(struct net_device *netdev)
 					   "usb_submit failed (err=%d)\n", rc);
 
 				usb_unanchor_urb(urb);
-				usb_free_coherent(dev->udev,
-						  sizeof(struct gs_host_frame),
-						  buf,
-						  buf_dma);
+				devm_kfree(&dev->udev->dev, buf);
 				usb_free_urb(urb);
 				break;
 			}
 
 			dev->rxbuf[i] = buf;
-			dev->rxbuf_dma[i] = buf_dma;
 
 			/* Drop reference,
 			 * USB core will take care of freeing it
@@ -863,10 +847,8 @@ static int gs_can_close(struct net_device *netdev)
 	if (!parent->active_channels) {
 		usb_kill_anchored_urbs(&parent->rx_submitted);
 		for (i = 0; i < GS_MAX_RX_URBS; i++)
-			usb_free_coherent(dev->udev,
-					  sizeof(struct gs_host_frame),
-					  dev->rxbuf[i],
-					  dev->rxbuf_dma[i]);
+			devm_kfree(&dev->udev->dev,
+				   dev->rxbuf[i]);
 	}
 
 	/* Stop sending URBs */
-- 
2.25.1

