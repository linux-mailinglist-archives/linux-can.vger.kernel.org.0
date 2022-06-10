Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144AC546F4A
	for <lists+linux-can@lfdr.de>; Fri, 10 Jun 2022 23:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349266AbiFJVem (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 10 Jun 2022 17:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347711AbiFJVek (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Jun 2022 17:34:40 -0400
Received: from mx0a-0054a801.pphosted.com (mx0a-0054a801.pphosted.com [205.220.160.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817BE18B11
        for <linux-can@vger.kernel.org>; Fri, 10 Jun 2022 14:34:35 -0700 (PDT)
Received: from pps.filterd (m0208803.ppops.net [127.0.0.1])
        by mx0b-0054a801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ADFKOc008354
        for <linux-can@vger.kernel.org>; Fri, 10 Jun 2022 14:34:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsara.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=samsaracom06092020;
 bh=fVl0ZKee2vfFzhBKf4HZ3Mkp/PMJaRz+ojYbgSnU3Ps=;
 b=cnbQBbm+ZQYJprIF1CvpuvTE9HAQENNX2Sa1qPwXIl4myh9SUnlMN+/l9Z3jrvoMF9Ru
 sNxqk4b5M2Uu/o8gSx+Z9iNOVX9It9pXF74/l8mXpZ/orZU3Gk43mimuG/j+jewQlPO6
 hMg41h1Mec83PcQN+kl8I+4Z5XVElNN2sUnv9FoIMvxVoweYTCQ3ACLpNbQ8DEtYoHnq
 GVYSWUqfMeHjavudM52r7vhKsHb8dy8FH4R+B3PLvt3bFCsve1JrBu0zJJ2sY0VjNInz
 TVYHSawzjLw5PIOS1qvVrcMtY65EwFB1qGcaZ+583Iy24dlsIh7Oqbx156q8tXzuZX6V NA== 
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mx0b-0054a801.pphosted.com (PPS) with ESMTPS id 3gkut90swk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-can@vger.kernel.org>; Fri, 10 Jun 2022 14:34:35 -0700
Received: by mail-qt1-f197.google.com with SMTP id f20-20020a05622a1a1400b00304eb093686so266209qtb.5
        for <linux-can@vger.kernel.org>; Fri, 10 Jun 2022 14:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fVl0ZKee2vfFzhBKf4HZ3Mkp/PMJaRz+ojYbgSnU3Ps=;
        b=MuB6LMebqQtVf3BsrAVlMLpHFcDJSLPHhRP2znNjP9ToiCy/m8WUdr95JkUQZRE4nL
         6yoVWQzDeiGHqJ5F9VEMAJQQqp6qxOsep8XqLUEcG422wpJcA5+3nwOH+X/9+a6t71QW
         E8/YcPMCxarSSj2uviDhG7i1mZlXc0d1NDZYsBB2nEE2/RlprrPQ1ouj9DsEurKy3j0T
         7Tf6qA8hvkAq//7nxTr1IimhmRiuyQ4Uee6gxR8UIqT0OgzRN97FUx/vwoeeHMpYL+Vw
         1WL3aiSNpF34LzCPkuu2mhFKGd+wFln3kdLYtAbxloDEfu3veOLIq+Oj63m0pfMBH88h
         uUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fVl0ZKee2vfFzhBKf4HZ3Mkp/PMJaRz+ojYbgSnU3Ps=;
        b=LksUsZ7zAKHBc9eg/aNweuTyE0e17dN/vkwca+XQKFUg6VlhwuIStal7dYedVzWGCk
         DQrK6bY+OoTJjjUb3Aup3J2+FYjQecmnCe1IWyc58GUwCD8tS0l8fWycNm17t348r+jV
         txP4wgUrcQ2DGOVk74uJ04y1XNyf/N7jw8ABjdMMOFVeE0NxwEhXKLRtRqFLOcYQKweq
         /2w8b1DhAF4oChJDlOfui5d+rj9KJ5JT4K0jLBOEB11yvgpsNg4p2obdA4Wlxdllngkh
         qSHuNN6jyK7M1ePNHRyZynD70uI2ExO8Qmp6v28FRf6XtQUGl1H5R/61eqUI4OZS1wDQ
         LPfA==
X-Gm-Message-State: AOAM532RinIMZjxnauvmQqPJC0FZlJ2aiEnd/SLq6FOnuXpso9bMZIVt
        dLVvBVDgEbJ2e/CYP1PVURVFTp93BrtZnzv5eKGmNglSD18a5rVlR+F4q0habMOua1OlA3G6uNg
        SqCeetYg31jXQBGfwPiQO
X-Received: by 2002:a05:622a:185:b0:305:962:1a2d with SMTP id s5-20020a05622a018500b0030509621a2dmr11134041qtw.368.1654896874133;
        Fri, 10 Jun 2022 14:34:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeD1I1YSxnfEnj2tibCp63A0+RAQCG/rNjhcsEX/n3qOmDmpLb8muSvMebXj3O+tRyQGMROQ==
X-Received: by 2002:a05:622a:185:b0:305:962:1a2d with SMTP id s5-20020a05622a018500b0030509621a2dmr11134027qtw.368.1654896873830;
        Fri, 10 Jun 2022 14:34:33 -0700 (PDT)
Received: from downhome.. (ec2-3-215-55-7.compute-1.amazonaws.com. [3.215.55.7])
        by smtp.gmail.com with ESMTPSA id b11-20020a05622a020b00b00304d8cdddfesm139742qtx.86.2022.06.10.14.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 14:34:33 -0700 (PDT)
From:   Rhett Aultman <rhett.aultman@samsara.com>
To:     linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc:     --cc=Oliver Neukum <oneukum@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 2/2] can: gs_usb: fix DMA memory leak on close
Date:   Fri, 10 Jun 2022 17:33:37 -0400
Message-Id: <20220610213335.3077375-3-rhett.aultman@samsara.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220610213335.3077375-1-rhett.aultman@samsara.com>
References: <20220609204714.2715188-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-1-rhett.aultman@samsara.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HMpBiDg4xov2lImfoMyAzzMdcF9knb96
X-Proofpoint-ORIG-GUID: HMpBiDg4xov2lImfoMyAzzMdcF9knb96
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_09,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=634 adultscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The gs_usb driver allocates DMA memory with usb_alloc_coherent() in
gs_can_open() and then keeps this memory in an URB, with the expectation
that the memory will be freed when the URB is killed in gs_can_close().
Memory allocated with usb_alloc_coherent() cannot be freed in this way
and must be freed using usb_free_coherent() instead.  This means that
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
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/gs_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index b29ba9138866..4e7e6a7b961a 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -768,7 +768,7 @@ static int gs_can_open(struct net_device *netdev)
 					  buf,
 					  dev->parent->hf_size_rx,
 					  gs_usb_receive_bulk_callback, parent);
-			urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+			urb->transfer_flags = URB_NO_TRANSFER_DMA_MAP | URB_FREE_COHERENT;
 
 			usb_anchor_urb(urb, &parent->rx_submitted);
 
-- 
2.30.2

