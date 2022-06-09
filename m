Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F4C5455F0
	for <lists+linux-can@lfdr.de>; Thu,  9 Jun 2022 22:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344304AbiFIUsM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 9 Jun 2022 16:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiFIUsL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Jun 2022 16:48:11 -0400
Received: from mx0a-0054a801.pphosted.com (mx0a-0054a801.pphosted.com [205.220.160.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995F8BE143
        for <linux-can@vger.kernel.org>; Thu,  9 Jun 2022 13:48:09 -0700 (PDT)
Received: from pps.filterd (m0208802.ppops.net [127.0.0.1])
        by mx0b-0054a801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 259C1DL6018675
        for <linux-can@vger.kernel.org>; Thu, 9 Jun 2022 13:48:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsara.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=samsaracom06092020;
 bh=oOBUUa5Xferxj7ROAF97BuBNgotz6S04JATthgo88jY=;
 b=rsFKGpvF+xtXJ3FRTNf1t5dGRUP67yfKqyUNsIFRTqYqwxq34dTHXJY82nV+i9kG+kky
 zURDXBKOF7HBFWXOXwLbkoeF5BwqZOarDWdbqe3g9JpnKAsdh6FIQ2bBdkMaBUwjyuu1
 1l9F+GqEQCPUGdIERTl26aMvJ3LIidPAQGh3QOxISkaoMEtbSBwiywbEGfdt3OO+sgrG
 R+s9tud186Tfscarc8prZ9jvs6+krWnO/Nys/XIPWfQcPhv214wjlMtZ+eqpK9Ip5Xpz
 vklNHftfhpiCN8mnhqxfQnW1Q2Z0gEMmkuqnQIqVCJoTWs9xEShNCUJXChw6VllM/Vff ag== 
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
        by mx0b-0054a801.pphosted.com (PPS) with ESMTPS id 3gg5324hgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-can@vger.kernel.org>; Thu, 09 Jun 2022 13:48:09 -0700
Received: by mail-qv1-f70.google.com with SMTP id i15-20020ad45c6f000000b0046462f670d2so15784433qvh.18
        for <linux-can@vger.kernel.org>; Thu, 09 Jun 2022 13:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oOBUUa5Xferxj7ROAF97BuBNgotz6S04JATthgo88jY=;
        b=IaFHFyWGrl8Uw8RXWCb2AjJygHC9jjDYejHyJnYSRNoxxWaq8qPLhEFICkpfTb0adt
         HG2Zv99zapxlfqFgxdOGuSlQ425ISWN+cM3NxsQPJNWwm9wLNoawKKnczUZEhuUHFXRm
         d9h/6XKKyXg4Pdy0hOr1PeDFz+xZfLcTw1g8KIKrjL2lP62RvOc14rUfORn/KrLzZat6
         ZlBKmNuJBc13jwBcVi9LujXGu72n1lefYnc8f08sWMJ3YHl22BDCErTZu/s4Zx0qplX3
         Ds4Bz9IbbKNIKkhP3TekpH1qF+PRn3+fqjhyV70k4TF6ex1cVew68ppzFUU+F1WRXG4c
         T1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOBUUa5Xferxj7ROAF97BuBNgotz6S04JATthgo88jY=;
        b=kTzJUA6BbVuzx2Hb0N1nw0ltaHHhNhq3QlQHYU6ZeAuBqvf28T46RiuTVRD6Gwp7Oy
         3Z/1kA/9EUBwyrMGU22ibhhDPIUwnmoFs2AdPipnLDxIdBX16PvTlAvnhgYvvXpunlhF
         gBgefVncl18+KHLg4ofa+vO2ikzv7vts6sgHXSRbfUbgpkCjQxa4gs5VRC2gW3Lstfk+
         aZ5E6Lbd82vNJA/xqrxlK1B4Rfv9VibIXWdSDD5zb5/GiVstv3BONe0xpvTlTsEUl6DZ
         NgUOrm3LVuoFvytABsLFM+FdyUQO+rJZxuUVHdYWTzNaM8Xy7UXtojBeCnTlQOnwXTsG
         Ps/w==
X-Gm-Message-State: AOAM533in0vFASwYWPAkCWvsZU8Er6c8+OemZlxL81Yydi/+Efp28Dxr
        0hSNWhyyGf0o8maMdlH7QiI/mt+fpquqs2pA9tAX+czpjCA5HG0K01hXs8k47wRsHjWwY9hmYxK
        9xWPRzTOZrrjSa6/yZARi
X-Received: by 2002:a05:622a:1004:b0:304:eb0c:19d1 with SMTP id d4-20020a05622a100400b00304eb0c19d1mr20270162qte.674.1654807688330;
        Thu, 09 Jun 2022 13:48:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBtjBBGe3lkd6vgYMI93ll0Q+0vJlLGRW/mRDn3XEgNK1nfOuWcGLKrF3Rwyz0/m587HwXOA==
X-Received: by 2002:a05:622a:1004:b0:304:eb0c:19d1 with SMTP id d4-20020a05622a100400b00304eb0c19d1mr20270139qte.674.1654807688032;
        Thu, 09 Jun 2022 13:48:08 -0700 (PDT)
Received: from downhome.. (ec2-3-215-55-7.compute-1.amazonaws.com. [3.215.55.7])
        by smtp.gmail.com with ESMTPSA id d5-20020a05620a240500b006a6b1630e95sm5428568qkn.45.2022.06.09.13.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:48:07 -0700 (PDT)
From:   Rhett Aultman <rhett.aultman@samsara.com>
To:     linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc:     Oliver Neukum <oneukum@suse.org>,
        Alan Stern <stern@roland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rhett Aultman <rhett.aultman@samsara.com>
Subject: [PATCH v2 3/3] can: gs_usb: fix DMA memory leak on close
Date:   Thu,  9 Jun 2022 16:47:14 -0400
Message-Id: <20220609204714.2715188-4-rhett.aultman@samsara.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220609204714.2715188-1-rhett.aultman@samsara.com>
References: <alpine.DEB.2.22.394.2206031547001.1630869@thelappy>
 <20220609204714.2715188-1-rhett.aultman@samsara.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8sKuodRQjPuogyMUYQnuCAsFJLFNmmBs
X-Proofpoint-ORIG-GUID: 8sKuodRQjPuogyMUYQnuCAsFJLFNmmBs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-09_15,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 adultscore=0 mlxlogscore=576 suspectscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206090077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The gs_usb driver allocates DMA memory with usb_alloc_coherent() in
gs_can_open() and then keeps this memory in an URB, with the expectation
that the memory will be freed when the URB is killed in gs_can_close().
Memory allocated with usb_alloc_coherent() cannot be freed in this way
and much be freed using usb_free_coherent() instead.  This means that
repeated cycles of calling gs_can_open() and gs_can_close() will lead to
a memory leak.

Historically, drivers have handled this by keeping an array of pointers
to their DMA rx buffers and explicitly freeing them.  For an example of
this technique used in the esd_usb2 driver, see here:
https://www.spinics.net/lists/linux-can/msg08203.html

While the above method works, the conditions that cause this leak are
not apparent to driver writers and the method for solving it at the
driver level has been piecemeal.  This patch makes use of a new
URB_FREE_COHERENT flag on the URB, reducing the solution of this memory
leak down to a single line of code.

Signed-off-by: Rhett Aultman <rhett.aultman@samsara.com>
---
 drivers/net/can/usb/gs_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index b29ba9138866..3ded3e14c830 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -768,7 +768,7 @@ static int gs_can_open(struct net_device *netdev)
 					  buf,
 					  dev->parent->hf_size_rx,
 					  gs_usb_receive_bulk_callback, parent);
-			urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+			urb->transfer_flags |= (URB_NO_TRANSFER_DMA_MAP | URB_FREE_COHERENT);
 
 			usb_anchor_urb(urb, &parent->rx_submitted);
 
-- 
2.30.2

