Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357075455F3
	for <lists+linux-can@lfdr.de>; Thu,  9 Jun 2022 22:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbiFIUsA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 9 Jun 2022 16:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345254AbiFIUr4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Jun 2022 16:47:56 -0400
Received: from mx0b-0054a801.pphosted.com (mx0b-0054a801.pphosted.com [205.220.172.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2E5563A7
        for <linux-can@vger.kernel.org>; Thu,  9 Jun 2022 13:47:55 -0700 (PDT)
Received: from pps.filterd (m0208806.ppops.net [127.0.0.1])
        by mx0b-0054a801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 259DlsST028297
        for <linux-can@vger.kernel.org>; Thu, 9 Jun 2022 20:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsara.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=samsaracom06092020;
 bh=mj2hkIW09jwJqJWJfmer2pDeLN4yDLA8jWIhlIEjSDI=;
 b=JLGky5crQYBVa86DxRvp1R6A8zpHV/YX5DLlL8Pim4X38oer0TsS6FSWORxP92/LRP2w
 KK4dw8+azjDbuUs9C1BYwuu2vLUhrcL/5+cg4bdAj8UM+KOB4jmU0lexgRST4sdXHETo
 jADR+JhYkxXenP4PzV+QUJoSzt11HIEI6Roh4WCFAFiA+AKAt51qSL+xxLhfUbq2TQTx
 gd1dcKX1M9ieFfkLRWwL4o0lZpFkAr6miy09r48SbFqDlVqWp2SVwfQcr4YhoBvatXNw
 /306HS+Pmoc/qrzlQ4pxSTCJ9hZpicVltbsRUn6FbpbEXmH+QaqUeEz7azvvAvluZGkQ gA== 
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mx0b-0054a801.pphosted.com (PPS) with ESMTPS id 3gfy7hvkv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-can@vger.kernel.org>; Thu, 09 Jun 2022 20:47:54 +0000
Received: by mail-qk1-f197.google.com with SMTP id i5-20020a05620a404500b006a6d7a765d9so7156302qko.7
        for <linux-can@vger.kernel.org>; Thu, 09 Jun 2022 13:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mj2hkIW09jwJqJWJfmer2pDeLN4yDLA8jWIhlIEjSDI=;
        b=NHjyBaTTUg507tR6XfCJdh17a1tcWIKL8h70vvjhANdFCpKSJApscm67SQ4zDllUkK
         YW08julLAUbGJXCfOMeUORGP3De43M4PU3r5RsM1pGwhRO6CXul799NUf4zx0Rc/D2l9
         8X3g0eQZkkVfCZWdX7IjXM2GmhRkn5PWhwW5GwGg35IImMHehzdysl/9wkUJbizWfh3m
         LNgg0CfLbkCwsSdm25n1oBRTB0H1n/x/bGZkkSQuRLZsnqpFGmMKfTFGE6BkrFUl+3Gd
         LM8SCWCitWlsC+2jbIyDIULgzVAimF2OVBWvg72HOENxsT3X6sQR+Wc1etcC+XQujzHk
         Ki6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mj2hkIW09jwJqJWJfmer2pDeLN4yDLA8jWIhlIEjSDI=;
        b=1Bv67J7Bvor8DGKbOkN8FQTGHAvDvVlwwTnPcdtnSnrFoepa+KEKd/FJYaammNMOpl
         uhdsxPCdbGH5mn/4hYbX20p/3dRH7tuYSqwVM0ujQEG22aXmGyf88kJyaORLSNmtlfAj
         QcuSBDqrYDUFyMD+pkVnb8Aqk5F8h9HmN4iXKsUpwjYK7+j+cSny2tcrUUZj6qnzUySm
         82nBrg1xVWcfjRkcGlc4o8GvkRDAKkVyabknmHFS0VoXP3lmAwCbIlXDTcHPqrKVYXQy
         CUGbkNWJ+9hATKJw6AvGLmTAxXwBP2cxEruR9vHfmFe9+5+mWey+EuqNyrkfHccI6W22
         nwyw==
X-Gm-Message-State: AOAM5334+cuzE/QYdr1KJIgbS7eQNlv9Jr2FR7Qo2nfWi5DhjE8yHC+n
        VEmasj/h2nqchj4hxzL2HC2Gan2au8t8s/W6nKZxIshdcwFTAW3wTxdZJUlSKqpZiIr/G0csP9T
        xijcSqTO+kup4BBcWt45U
X-Received: by 2002:a05:622a:15c7:b0:304:ec84:7718 with SMTP id d7-20020a05622a15c700b00304ec847718mr19464686qty.585.1654807673744;
        Thu, 09 Jun 2022 13:47:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLFMQSDU/UmbhQvQneb/4hszTQeS7e4wh9XttOkJ3dySL256BHi4OFlgXNNFe5HhCzp3TBGg==
X-Received: by 2002:a05:622a:15c7:b0:304:ec84:7718 with SMTP id d7-20020a05622a15c700b00304ec847718mr19464659qty.585.1654807673455;
        Thu, 09 Jun 2022 13:47:53 -0700 (PDT)
Received: from downhome.. (ec2-3-215-55-7.compute-1.amazonaws.com. [3.215.55.7])
        by smtp.gmail.com with ESMTPSA id d5-20020a05620a240500b006a6b1630e95sm5428568qkn.45.2022.06.09.13.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:47:52 -0700 (PDT)
From:   Rhett Aultman <rhett.aultman@samsara.com>
To:     linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc:     Oliver Neukum <oneukum@suse.org>,
        Alan Stern <stern@roland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 1/3] drivers: usb/core/urb: Add URB_FREE_COHERENT
Date:   Thu,  9 Jun 2022 16:47:12 -0400
Message-Id: <20220609204714.2715188-2-rhett.aultman@samsara.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220609204714.2715188-1-rhett.aultman@samsara.com>
References: <alpine.DEB.2.22.394.2206031547001.1630869@thelappy>
 <20220609204714.2715188-1-rhett.aultman@samsara.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jmfisiPzoYjEMa9ox6-i2J5upL16UD6Z
X-Proofpoint-ORIG-GUID: jmfisiPzoYjEMa9ox6-i2J5upL16UD6Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-09_15,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=711
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206090077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

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

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/usb/core/urb.c | 3 +++
 include/linux/usb.h    | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index 33d62d7e3929..1460fdac0b18 100644
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

