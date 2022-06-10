Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB503546F49
	for <lists+linux-can@lfdr.de>; Fri, 10 Jun 2022 23:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349154AbiFJVed (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 10 Jun 2022 17:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347711AbiFJVeb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Jun 2022 17:34:31 -0400
Received: from mx0a-0054a801.pphosted.com (mx0a-0054a801.pphosted.com [205.220.160.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2BF25C5A
        for <linux-can@vger.kernel.org>; Fri, 10 Jun 2022 14:34:25 -0700 (PDT)
Received: from pps.filterd (m0208802.ppops.net [127.0.0.1])
        by mx0b-0054a801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25AKIxPA013294
        for <linux-can@vger.kernel.org>; Fri, 10 Jun 2022 14:34:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsara.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=samsaracom06092020;
 bh=x8x63OJhZyCZbSn0Jz5vU7r9Aa7mCIxoTFUmyCSQ324=;
 b=KpYbRdcDfOJQ7Ab7wnhvveLYHgLrjXNOLEPUwQl4dUjyD4F5TvI26bPE6GO8Y9OiMyyP
 uh4p6gutN3sIzzTDR80qdWwpamtrK1EM2yVkWZzRaEQvrvUvDEjRxZAp+q/zrdkryqCp
 Lr6BshXU7CnNFCjmt2i8obisYzFRIQVEuVnL3C5/DmiWq8PTTXRxuVltIZ6dtQO4C9hO
 SRuYzYORaKdESzkARE5Ae2WEgmB0aaZQ6FjfKNcF/ekYJFasX4RI+kd4M3sJD/z5iE2O
 90Tr3DDGUUpiy9JpwVPF5yn7AVwGhH9LPYvsBNuWGmB7Rke2BDhSvsv+LXC33Ovq4izm Iw== 
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mx0b-0054a801.pphosted.com (PPS) with ESMTPS id 3gkuuf8sq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-can@vger.kernel.org>; Fri, 10 Jun 2022 14:34:25 -0700
Received: by mail-qk1-f197.google.com with SMTP id az18-20020a05620a171200b006a708307e94so123415qkb.14
        for <linux-can@vger.kernel.org>; Fri, 10 Jun 2022 14:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x8x63OJhZyCZbSn0Jz5vU7r9Aa7mCIxoTFUmyCSQ324=;
        b=gjeGVJYiSv4lmZNR/C+w8yq5mPwTe6cerg8k+nE48hgMJh2cM0KByfD7Pemwf0gFp/
         D35JMXsIGwzEUtbxGgj3Fovf39Ak/y6aCAQBLvFz2HtoANIoV6n8flN9t39UtganH5At
         sjjH/Yko0Y+7jqoJFiHkDogb8ElPm88kfTHFVpK7QC8wvtbrKwEoqr1fi0jhmUA5+kc4
         Ed0n2c4C+Cyitw3nU6fd6ABETPxqoCYKQbyObNaYlndT1E+4cvdfGuq+D0inN1ibPAH8
         bTOmKEF+pmT3OsSCIBUNHzQzBW0JMiwBf7oQOEWkt1EUOERaxvNzbxoa/wUw5MGzqRa2
         QN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x8x63OJhZyCZbSn0Jz5vU7r9Aa7mCIxoTFUmyCSQ324=;
        b=pGq46q8//XxMKP/RKlYD0ZdnMv2OJ5C3tV0USwkRiw/bsgeRGTOjeUA22i9kC8A4Kx
         TpXrSHM+5xBXkYeX0Nq8okQlesx0nofwVjp0jZYd7Fl6D6VFZYXiZpLIWxWCvpz9FUcQ
         HaW6hZQAuof6cilMU+SuY6oaQJCcofsmSjclyH+DL3jHTxwAFJKLxj+d9pVMYC/OlFG/
         Cv6cnPXJH3X+dwohfGYa/Sco3RorUPbi0BXWORLBN0/vNzRnEbnGrVcErUA4yTEgGSkv
         XORGfg2GtDveoNgMeH9NY0YhHTbdsHsgS4D+sE3uVBT+NA8bP57LgV/CwZGwIOxwzWof
         +7Ug==
X-Gm-Message-State: AOAM531Donau5L+ZKswU6MaPQJgfD4abf+BiFiMSR3KBUsCRH/S8NT8d
        M3T2Kkym/4vCGrAyZYrTtFa0BpJPff5UNUFS0nxl/E9yWd+6dvDeQxO7KHsQoMxSyK5MdHfFiJY
        K26METPRJTWyscpS+O4st
X-Received: by 2002:ac8:5c84:0:b0:305:2252:9b6c with SMTP id r4-20020ac85c84000000b0030522529b6cmr1116109qta.514.1654896864125;
        Fri, 10 Jun 2022 14:34:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYAPXKMbfluXKA8DZhPVjAiyN3e/LCdNWUbbXgogEk+0VHVz1wAT24f+UhC86EcCI/gtaDfA==
X-Received: by 2002:ac8:5c84:0:b0:305:2252:9b6c with SMTP id r4-20020ac85c84000000b0030522529b6cmr1116095qta.514.1654896863835;
        Fri, 10 Jun 2022 14:34:23 -0700 (PDT)
Received: from downhome.. (ec2-3-215-55-7.compute-1.amazonaws.com. [3.215.55.7])
        by smtp.gmail.com with ESMTPSA id b11-20020a05622a020b00b00304d8cdddfesm139742qtx.86.2022.06.10.14.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 14:34:23 -0700 (PDT)
From:   Rhett Aultman <rhett.aultman@samsara.com>
To:     linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc:     --cc=Oliver Neukum <oneukum@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Rhett Aultman <rhett.aultman@samsara.com>
Subject: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
Date:   Fri, 10 Jun 2022 17:33:35 -0400
Message-Id: <20220610213335.3077375-2-rhett.aultman@samsara.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220610213335.3077375-1-rhett.aultman@samsara.com>
References: <20220609204714.2715188-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-1-rhett.aultman@samsara.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ECaD-V6vjcst9wQLIXkKs7fBzUwO6v_0
X-Proofpoint-GUID: ECaD-V6vjcst9wQLIXkKs7fBzUwO6v_0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_09,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=834 mlxscore=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206100082
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

When allocating URB memory with kmalloc(), drivers can simply set the
URB_FREE_BUFFER flag in urb::transfer_flags and that way, the memory
will be freed in the background when killing the URB (for example with
usb_kill_anchored_urbs()).

However, there are no equivalent mechanism when allocating DMA memory
(with usb_alloc_coherent()).

This patch adds a new flag: URB_FREE_COHERENT. Setting this flag will
cause the kernel to automatically call usb_free_coherent() on the
transfer buffer when the URB is killed, similarly to how
URB_FREE_BUFFER triggers a call to kfree().

In order to have all the flags in numerical order, URB_DIR_IN is
renumbered from 0x0200 to 0x0400 so that URB_FREE_COHERENT can reuse
value 0x0200.

Co-developed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Co-developed-by: Rhett Aultman <rhett.aultman@samsara.com>
Signed-off-by: Rhett Aultman <rhett.aultman@samsara.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/usb/core/urb.c | 5 ++++-
 include/linux/usb.h    | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index 33d62d7e3929..36c48fb196e0 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -22,6 +22,9 @@ static void urb_destroy(struct kref *kref)
 
 	if (urb->transfer_flags & URB_FREE_BUFFER)
 		kfree(urb->transfer_buffer);
+	else if (urb->transfer_flags & URB_FREE_COHERENT)
+		usb_free_coherent(urb->dev, urb->transfer_buffer_length,
+				  urb->transfer_buffer, urb->transfer_dma);
 
 	kfree(urb);
 }
@@ -504,7 +507,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
 
 	/* Check against a simple/standard policy */
 	allowed = (URB_NO_TRANSFER_DMA_MAP | URB_NO_INTERRUPT | URB_DIR_MASK |
-			URB_FREE_BUFFER);
+			URB_FREE_BUFFER | URB_FREE_COHERENT);
 	switch (xfertype) {
 	case USB_ENDPOINT_XFER_BULK:
 	case USB_ENDPOINT_XFER_INT:
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 60bee864d897..945d68ea1d76 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1328,9 +1328,10 @@ extern int usb_disabled(void);
 #define URB_NO_INTERRUPT	0x0080	/* HINT: no non-error interrupt
 					 * needed */
 #define URB_FREE_BUFFER		0x0100	/* Free transfer buffer with the URB */
+#define URB_FREE_COHERENT	0x0200  /* Free DMA memory of transfer buffer */
 
 /* The following flags are used internally by usbcore and HCDs */
-#define URB_DIR_IN		0x0200	/* Transfer from device to host */
+#define URB_DIR_IN		0x0400	/* Transfer from device to host */
 #define URB_DIR_OUT		0
 #define URB_DIR_MASK		URB_DIR_IN
 
-- 
2.30.2

