Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFFB53D2C3
	for <lists+linux-can@lfdr.de>; Fri,  3 Jun 2022 22:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiFCUWn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 3 Jun 2022 16:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240755AbiFCUWm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Jun 2022 16:22:42 -0400
X-Greylist: delayed 1835 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Jun 2022 13:22:40 PDT
Received: from mx0b-0054a801.pphosted.com (mx0b-0054a801.pphosted.com [205.220.172.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1233B43AE4
        for <linux-can@vger.kernel.org>; Fri,  3 Jun 2022 13:22:39 -0700 (PDT)
Received: from pps.filterd (m0208805.ppops.net [127.0.0.1])
        by mx0b-0054a801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253DojMl032694
        for <linux-can@vger.kernel.org>; Fri, 3 Jun 2022 19:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsara.com; h=from : date : to :
 subject : message-id : mime-version : content-type; s=samsaracom06092020;
 bh=LL9fkQpI40X3OTes3/bIW6kgnypzGQWobsFxI/Xm/a8=;
 b=gI4BpbhKgLO5X+5Dt1cAdarfN1/mszZQRzMlGX7lyTfG85D/Kwxu0+d2QPBLmi5HT7N4
 Ddh402VQNLcmNgyPvW9OQNfflVfm5xszWJLlqryQ/30Xq8J88j/Qm9kEP9ZnLF9zIdib
 Bi00xIltWlkuBrvZm14jgjwfxvJjqxUeidX6DcrgGJglwZUVdr7LlHsW/k3P7wq/JPox
 MxbLcnfrjZhwOIpSRb9/tEF4uoEAvNn6RK1fnj6c2M3TTrBMvpX9GUyr9l8aDVfajqkl
 YhpC89d8pW6pbvWK7E+XA3onsdhg+hWR+zkdjJHzEJ0zLNS/XwhiBDOM1X1NOeSTI4xu Rw== 
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
        by mx0b-0054a801.pphosted.com (PPS) with ESMTPS id 3ge6nptkjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-can@vger.kernel.org>; Fri, 03 Jun 2022 19:52:03 +0000
Received: by mail-qv1-f71.google.com with SMTP id kj4-20020a056214528400b0044399a9bb4cso5841518qvb.15
        for <linux-can@vger.kernel.org>; Fri, 03 Jun 2022 12:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google;
        h=from:date:to:subject:message-id:user-agent:mime-version;
        bh=LL9fkQpI40X3OTes3/bIW6kgnypzGQWobsFxI/Xm/a8=;
        b=S2Yg+a5Uw89pxDVq6EppYXpx+22rvLO1ck0BV0F452DNao9cDeTfIrZ904giswxfgi
         vZVrjIr1BE7arjzqNgLRtVKVOfvEO1jDbX/B8TUR/PHh8GVWsH0OQfxfw4VvLKaURn/n
         iN6yux5DDetyxGtBi3z13UzlSj3/Le922xR1m0Kk4jtHeEokJ7CSawKuaOH+1Vr3plxp
         k5RyyjnpAdeT+uJ5k821WsWVvetG1kZmgx22y+Eh32yPGGpYrg4XxUsLXYLPGWQidSkF
         6kpaM/sE+l26svuh3nt6YjRo1bMBhzgtrtx2zGit34rLi/R/Wq5X0DKWJvUcSGSB5D7X
         galA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:subject:message-id:user-agent
         :mime-version;
        bh=LL9fkQpI40X3OTes3/bIW6kgnypzGQWobsFxI/Xm/a8=;
        b=5aJIBn3jPoYikFAJFyOAWc8aZUdhaMvPVFZ8TZDNWssFpw23hNwUOsND81K7wf1jQP
         /zQj551c2wAiEoWRrE0pgMsxIoHqrp9Ib6Rlhltxzvxbk0iMXaI5OWnPROd3JL+J0R5q
         3B3YQ08ydXOt26LgPhON+kqZ+iNLmi3nTKeBNzjndB9NnGJbjstya+Mt1PtVBC29B5SP
         nQEkDefTSpE5Lzkut1IiIS//pFRNz9N6gFFsuJNfLvGasqi1xfYVW5HfS3hloB1XQg0W
         tJnRXPBscPU9PRczy4f60JQbCNA7D3tmC2nyq7qcjh7nbfMaihskOdz8EJSzix8fL+m6
         +cmg==
X-Gm-Message-State: AOAM530NSRPDWPOdPacMNQpgzqPJw6dta/XbmODSHv4d225ZJCgWQ2BI
        fZPftpvMEbhtpaeDD40zPUKO+BCXl8PxISyFrv8JPzRyVpzrrbQ086kaIOFkMYiQnsd0iviwnoT
        sRBnnlRIu/mi9aHLj5qVK
X-Received: by 2002:a05:620a:3729:b0:6a6:73f4:f3ba with SMTP id de41-20020a05620a372900b006a673f4f3bamr7181057qkb.644.1654285922423;
        Fri, 03 Jun 2022 12:52:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFYSYkB71UtSHh7EnM/oAQSOntUTKExBsr/kU+NJ7ju0STyZKF4USflFv+V1LvY0BzGcN79Q==
X-Received: by 2002:a05:620a:3729:b0:6a6:73f4:f3ba with SMTP id de41-20020a05620a372900b006a673f4f3bamr7181045qkb.644.1654285922115;
        Fri, 03 Jun 2022 12:52:02 -0700 (PDT)
Received: from [192.168.1.10] ([162.250.128.47])
        by smtp.gmail.com with ESMTPSA id bi37-20020a05620a31a500b006a6a550d371sm895006qkb.121.2022.06.03.12.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 12:52:01 -0700 (PDT)
From:   Rhett Aultman <rhett.aultman@samsara.com>
X-Google-Original-From: Rhett Aultman <rhett@samsara.com>
Date:   Fri, 3 Jun 2022 15:52:00 -0400 (EDT)
X-X-Sender: rhett@thelappy
To:     wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Subject: [PATCH 001/001] can: gs_usb: gs_usb_open/close( ) fix memory leak
Message-ID: <alpine.DEB.2.22.394.2206031547001.1630869@thelappy>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-GUID: OZC5HsAmPxiW7dfuKoH-GlYcSYdO4dmT
X-Proofpoint-ORIG-GUID: OZC5HsAmPxiW7dfuKoH-GlYcSYdO4dmT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_06,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=796 clxscore=1011 mlxscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206030077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From 25f7bada85d9977daf63f95065f5bc57d3bc37de Mon Sep 17 00:00:00 2001
From: Rhett Aultman <rhett.aultman@samsara.com>
Date: Mon, 2 May 2022 13:04:26 -0400
Subject: [PATCH] can: gs_usb: gs_usb_open/close( ) fix memory leak

The gs_usb driver appears to suffer from a malady common to many USB CAN
adapter drivers in that it performs usb_alloc_coherent( ) to allocate a
number of USB request blocks (URBs) for RX, and then later relies on
usb_kill_anchored_urbs( ) to free them, but this doesn't actually free
them.  As a result, this may be leaking DMA memory that's been used by the
driver.

This commit is an adaptation of the techniques found in the esd_usb2 driver
where a similar design pattern led to a memory leak.  It explicitly frees
the RX URBs and their DMA memory via a call to usb_free_coherent( ).  Since
the RX URBs were allocated in the gs_can_open( ), we remove them in
gs_can_close( ) rather than in the disconnect function as was done in
esd_usb2.

For more information, see the following:
* https://www.spinics.net/lists/linux-can/msg08203.html
* https://github.com/torvalds/linux
    928150fad41 (can: esd_usb2: fix memory leak)

From: Rhett Aultman <rhett.aultman@samsara.com>
Signed-off-by: Rhett Aultman <rhett.aultman@samsara.com>
---
 drivers/net/can/usb/gs_usb.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index b29ba9138866..d3a658b444b5 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -268,6 +268,8 @@ struct gs_can {

 	struct usb_anchor tx_submitted;
 	atomic_t active_tx_urbs;
+	void *rxbuf[GS_MAX_RX_URBS];
+	dma_addr_t rxbuf_dma[GS_MAX_RX_URBS];
 };

 /* usb interface struct */
@@ -742,6 +744,7 @@ static int gs_can_open(struct net_device *netdev)
 		for (i = 0; i < GS_MAX_RX_URBS; i++) {
 			struct urb *urb;
 			u8 *buf;
+			dma_addr_t buf_dma;

 			/* alloc rx urb */
 			urb = usb_alloc_urb(0, GFP_KERNEL);
@@ -752,7 +755,7 @@ static int gs_can_open(struct net_device *netdev)
 			buf = usb_alloc_coherent(dev->udev,
 						 dev->parent->hf_size_rx,
 						 GFP_KERNEL,
-						 &urb->transfer_dma);
+						 &buf_dma);
 			if (!buf) {
 				netdev_err(netdev,
 					   "No memory left for USB buffer\n");
@@ -760,6 +763,8 @@ static int gs_can_open(struct net_device *netdev)
 				return -ENOMEM;
 			}

+			urb->transfer_dma = buf_dma;
+
 			/* fill, anchor, and submit rx urb */
 			usb_fill_bulk_urb(urb,
 					  dev->udev,
@@ -781,10 +786,17 @@ static int gs_can_open(struct net_device *netdev)
 					   "usb_submit failed (err=%d)\n", rc);

 				usb_unanchor_urb(urb);
+				usb_free_coherent(dev->udev,
+						  sizeof(struct gs_host_frame),
+						  buf,
+						  buf_dma);
 				usb_free_urb(urb);
 				break;
 			}

+			dev->rxbuf[i] = buf;
+			dev->rxbuf_dma[i] = buf_dma;
+
 			/* Drop reference,
 			 * USB core will take care of freeing it
 			 */
@@ -842,13 +854,20 @@ static int gs_can_close(struct net_device *netdev)
 	int rc;
 	struct gs_can *dev = netdev_priv(netdev);
 	struct gs_usb *parent = dev->parent;
+	unsigned int i;

 	netif_stop_queue(netdev);

 	/* Stop polling */
 	parent->active_channels--;
-	if (!parent->active_channels)
+	if (!parent->active_channels) {
 		usb_kill_anchored_urbs(&parent->rx_submitted);
+		for (i = 0; i < GS_MAX_RX_URBS; i++)
+			usb_free_coherent(dev->udev,
+					  sizeof(struct gs_host_frame),
+					  dev->rxbuf[i],
+					  dev->rxbuf_dma[i]);
+	}

 	/* Stop sending URBs */
 	usb_kill_anchored_urbs(&dev->tx_submitted);
-- 
2.30.2

