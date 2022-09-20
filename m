Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53935BEA7E
	for <lists+linux-can@lfdr.de>; Tue, 20 Sep 2022 17:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiITPrl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Sep 2022 11:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiITPri (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Sep 2022 11:47:38 -0400
Received: from mx0a-0054a801.pphosted.com (mx0a-0054a801.pphosted.com [205.220.160.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE29366120
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 08:47:36 -0700 (PDT)
Received: from pps.filterd (m0208803.ppops.net [127.0.0.1])
        by mx0b-0054a801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KDvZjM008331
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 08:47:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsara.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=samsaracom06092020;
 bh=iQazDIb7aAzT9F6S3nXhO79Qjjva7IdGdJ9JIH5xJ+M=;
 b=KQuMbX9iStgmJUHoKjo8U248sV195sbO2mx8Y/tsToNtQcDi1spFk1qIXGLTstzsOj2w
 kQsMsihdNIG+Adg96YUkIN4nqaXNZNEM17tyDCCsowtTw9PGFYTp+knueFnKdmAFoRXn
 hkm4f9JWjSyODGAeio0o358KNmUTDxYfcysqak5igV2c+oBFMUVOZ5ulpmc+3/soCRkn
 3QNxTrTnwnV5J/XeT2NdQ8T7N8LuE4utCCs1YTkIMADDTuvN4sUshL6WZYTyTuLfaSMv
 noGgjuteiOvl05LS8ZKsYV4Bf/pQqh0lKHtLJFbTTmeX6R6zA4GfEJQnpKj5UUo6UmZS Ag== 
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mx0b-0054a801.pphosted.com (PPS) with ESMTPS id 3jnc0djead-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 08:47:36 -0700
Received: by mail-qk1-f199.google.com with SMTP id i7-20020a05620a404700b006ced0d02b68so2252339qko.10
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 08:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=iQazDIb7aAzT9F6S3nXhO79Qjjva7IdGdJ9JIH5xJ+M=;
        b=hNWD1aM8usTh21H6dZbVB6UkBlMdra7IQRRjfEa6D6CW9Hh7Q3NzubM36daCsHwP+k
         Flr0g+YdIJRZYvIgz3Npx/b3vod5qMfEOy8ZnNmOHVVnxCW/HiewmDLzTJeCKkhmMNA8
         MYaMPenSv7du2s7ViEtDb2qZLo2xDus/ldS1qWk9b0Gmh/VM8aJwq0KH6p+51ia+o9vy
         KeeSrjkGrvLc6PEgyAZMwI1s+pmzxQHQEc1FwNc2VlTLOiH0OaZdM7tpFPOf3wMuflam
         27J9egorHbdzzpuWY0y4bmO1ZhY/Pfae6ykYG0VelzmOev1MhkEPEQSvHybMVIsa1pfW
         y1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iQazDIb7aAzT9F6S3nXhO79Qjjva7IdGdJ9JIH5xJ+M=;
        b=BY7Kp0gTN17pImGvj8ySQsVXSv6Snadq2QZbdf4ztb48yCBJkPByJj10zhq2D4Pi5q
         VWWYE+/KKkqkWOA3msepQsXGFxuliAtbTGH5s0+MPd5yVAzaWpO6jW7ZMwc+TwVotCDq
         pMPd9BRqF2FEhTDCIpZnxdLtjfWDiBolW7SSAoVo0khtS2bztleX8DOLwXSPilYKIijD
         vrvcYkwclLQBd+krfIpTlrzKrUdwMwXrTJ87N19ooE41mATdTAxu6abMbD9k+eXfJBO+
         G/V23eWtsGSAcqeeWzs5ZeWjJXVDuV3K7CfZfIplQ9Q0mYYbMWv2hqw59kgL87yYhJXw
         Bl0w==
X-Gm-Message-State: ACrzQf3kl4/F4tIA6+zyHmxorbEFqyButKrlr4ZR3KdD7Cl/hxVVUnz8
        9H+BGJQlekom/ntxEU6aRibdlqG82v7sUJYo632/AkB2b6YZxeyHyQfJexbipP6Kwk2W59rpc1Z
        jwaE0wXKAn+ElBEmLpsbC
X-Received: by 2002:a05:6214:5086:b0:4ac:81af:9ca3 with SMTP id kk6-20020a056214508600b004ac81af9ca3mr19896069qvb.88.1663688854539;
        Tue, 20 Sep 2022 08:47:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7/a1zJQjrZiI62u57bgMpatVxH1YK+8qSK1uGpN79k5gE2r/AobIKHh9EJiXyIn1zWA2SILA==
X-Received: by 2002:a05:6214:5086:b0:4ac:81af:9ca3 with SMTP id kk6-20020a056214508600b004ac81af9ca3mr19896053qvb.88.1663688854221;
        Tue, 20 Sep 2022 08:47:34 -0700 (PDT)
Received: from downhome.. (ec2-184-72-5-93.us-west-1.compute.amazonaws.com. [184.72.5.93])
        by smtp.gmail.com with ESMTPSA id w17-20020ac86b11000000b0035cd6a4ba3csm60615qts.39.2022.09.20.08.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 08:47:34 -0700 (PDT)
From:   Rhett Aultman <rhett.aultman@samsara.com>
To:     linux-can@vger.kernel.org
Cc:     Rhett Aultman <rhett.aultman@samsara.com>,
        Vasanth Sadhasivan <vasanth.sadhasivan@samsara.com>
Subject: [PATCH v2] can: gs_usb: remove dma allocations
Date:   Tue, 20 Sep 2022 11:47:24 -0400
Message-Id: <20220920154724.861093-2-rhett.aultman@samsara.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220920154724.861093-1-rhett.aultman@samsara.com>
References: <20220913204110.89730-1-rhett.aultman@samsara.com>
 <20220920154724.861093-1-rhett.aultman@samsara.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lQO5d-gSJQ8SEMb9iB12IGng_5qkdeZB
X-Proofpoint-ORIG-GUID: lQO5d-gSJQ8SEMb9iB12IGng_5qkdeZB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_06,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 mlxlogscore=970
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200093
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Internal buffers used within urbs were managed and freed manually. These 
buffers are no longer needed to be managed by the driver. The 
URB_FREE_BUFFER flag, allows for the buffers in question to 
be automatically freed.

Co-developed-by: Rhett Aultman <rhett.aultman@samsara.com>
Signed-off-by: Rhett Aultman <rhett.aultman@samsara.com>
Signed-off-by: Vasanth Sadhasivan <vasanth.sadhasivan@samsara.com>
---
 drivers/net/can/usb/gs_usb.c | 39 ++++++------------------------------
 1 file changed, 6 insertions(+), 33 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index baf749c8cda3..8562553ea6d0 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -268,8 +268,6 @@ struct gs_can {
 
 	struct usb_anchor tx_submitted;
 	atomic_t active_tx_urbs;
-	void *rxbuf[GS_MAX_RX_URBS];
-	dma_addr_t rxbuf_dma[GS_MAX_RX_URBS];
 };
 
 /* usb interface struct */
@@ -587,9 +585,6 @@ static void gs_usb_xmit_callback(struct urb *urb)
 
 	if (urb->status)
 		netdev_info(netdev, "usb xmit fail %u\n", txc->echo_id);
-
-	usb_free_coherent(urb->dev, urb->transfer_buffer_length,
-			  urb->transfer_buffer, urb->transfer_dma);
 }
 
 static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
@@ -618,8 +613,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 	if (!urb)
 		goto nomem_urb;
 
-	hf = usb_alloc_coherent(dev->udev, dev->hf_size_tx, GFP_ATOMIC,
-				&urb->transfer_dma);
+	hf = kmalloc(dev->hf_size_tx, GFP_ATOMIC);
 	if (!hf) {
 		netdev_err(netdev, "No memory left for USB buffer\n");
 		goto nomem_hf;
@@ -663,7 +657,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 			  hf, dev->hf_size_tx,
 			  gs_usb_xmit_callback, txc);
 
-	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+	urb->transfer_flags |= URB_FREE_BUFFER;
 	usb_anchor_urb(urb, &dev->tx_submitted);
 
 	can_put_echo_skb(skb, netdev, idx, 0);
@@ -678,8 +672,6 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 		gs_free_tx_context(txc);
 
 		usb_unanchor_urb(urb);
-		usb_free_coherent(dev->udev, urb->transfer_buffer_length,
-				  urb->transfer_buffer, urb->transfer_dma);
 
 		if (rc == -ENODEV) {
 			netif_device_detach(netdev);
@@ -699,8 +691,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 
  badidx:
-	usb_free_coherent(dev->udev, urb->transfer_buffer_length,
-			  urb->transfer_buffer, urb->transfer_dma);
+	kfree(hf);
  nomem_hf:
 	usb_free_urb(urb);
 
@@ -744,7 +735,6 @@ static int gs_can_open(struct net_device *netdev)
 		for (i = 0; i < GS_MAX_RX_URBS; i++) {
 			struct urb *urb;
 			u8 *buf;
-			dma_addr_t buf_dma;
 
 			/* alloc rx urb */
 			urb = usb_alloc_urb(0, GFP_KERNEL);
@@ -752,10 +742,8 @@ static int gs_can_open(struct net_device *netdev)
 				return -ENOMEM;
 
 			/* alloc rx buffer */
-			buf = usb_alloc_coherent(dev->udev,
-						 dev->parent->hf_size_rx,
-						 GFP_KERNEL,
-						 &buf_dma);
+			buf = kmalloc(dev->parent->hf_size_rx,
+				      GFP_KERNEL);
 			if (!buf) {
 				netdev_err(netdev,
 					   "No memory left for USB buffer\n");
@@ -763,8 +751,6 @@ static int gs_can_open(struct net_device *netdev)
 				return -ENOMEM;
 			}
 
-			urb->transfer_dma = buf_dma;
-
 			/* fill, anchor, and submit rx urb */
 			usb_fill_bulk_urb(urb,
 					  dev->udev,
@@ -773,7 +759,7 @@ static int gs_can_open(struct net_device *netdev)
 					  buf,
 					  dev->parent->hf_size_rx,
 					  gs_usb_receive_bulk_callback, parent);
-			urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+			urb->transfer_flags |= URB_FREE_BUFFER;
 
 			usb_anchor_urb(urb, &parent->rx_submitted);
 
@@ -786,17 +772,10 @@ static int gs_can_open(struct net_device *netdev)
 					   "usb_submit failed (err=%d)\n", rc);
 
 				usb_unanchor_urb(urb);
-				usb_free_coherent(dev->udev,
-						  sizeof(struct gs_host_frame),
-						  buf,
-						  buf_dma);
 				usb_free_urb(urb);
 				break;
 			}
 
-			dev->rxbuf[i] = buf;
-			dev->rxbuf_dma[i] = buf_dma;
-
 			/* Drop reference,
 			 * USB core will take care of freeing it
 			 */
@@ -854,7 +833,6 @@ static int gs_can_close(struct net_device *netdev)
 	int rc;
 	struct gs_can *dev = netdev_priv(netdev);
 	struct gs_usb *parent = dev->parent;
-	unsigned int i;
 
 	netif_stop_queue(netdev);
 
@@ -862,11 +840,6 @@ static int gs_can_close(struct net_device *netdev)
 	parent->active_channels--;
 	if (!parent->active_channels) {
 		usb_kill_anchored_urbs(&parent->rx_submitted);
-		for (i = 0; i < GS_MAX_RX_URBS; i++)
-			usb_free_coherent(dev->udev,
-					  sizeof(struct gs_host_frame),
-					  dev->rxbuf[i],
-					  dev->rxbuf_dma[i]);
 	}
 
 	/* Stop sending URBs */
-- 
2.25.1

