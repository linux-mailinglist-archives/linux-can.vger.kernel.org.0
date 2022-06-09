Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D7A5455EC
	for <lists+linux-can@lfdr.de>; Thu,  9 Jun 2022 22:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbiFIUri (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 9 Jun 2022 16:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344334AbiFIUrg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Jun 2022 16:47:36 -0400
Received: from mx0b-0054a801.pphosted.com (mx0b-0054a801.pphosted.com [205.220.172.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDBE49928
        for <linux-can@vger.kernel.org>; Thu,  9 Jun 2022 13:47:35 -0700 (PDT)
Received: from pps.filterd (m0208804.ppops.net [127.0.0.1])
        by mx0b-0054a801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 259CmnVx003529
        for <linux-can@vger.kernel.org>; Thu, 9 Jun 2022 20:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsara.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=samsaracom06092020;
 bh=DFhFlz6g4nhDs9WGkOFPJq46h0QfVBTAzuMAxMa537Q=;
 b=CxdKn6K4mkWNXrOVoI5+ltmjsoLzeoyta0/ehe5u9hFOd5YWx7JKnGxM54p4bC3a0JYl
 XI52ha1sTuJCdaQpTFY1il+MCZiNp7zUM9QmXuBTN4YlmGU2o1KZ9hn22+3zA2asC1QQ
 UUI4RA1TzZz+Fv+S5dTu3KQEpOrPj9G686xspQ0oC8S69RdqDghr+gwKTd1TC//LCZR8
 8MsAqqImS0wcAIN452A07M/PsnehJlBRtpJVN6dNUOMw1d+lpEHNcWe+m4KNjEWnMlSH
 1NjyP85Eim6UtTOkQQER+gSmaKr8FK8VH825njuufDhYKTNnKodpLdvEHgSl0EQeKRt9 RQ== 
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mx0b-0054a801.pphosted.com (PPS) with ESMTPS id 3gfx06cmqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-can@vger.kernel.org>; Thu, 09 Jun 2022 20:47:34 +0000
Received: by mail-qt1-f198.google.com with SMTP id a6-20020ac81086000000b002f65fd83048so19576620qtj.6
        for <linux-can@vger.kernel.org>; Thu, 09 Jun 2022 13:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFhFlz6g4nhDs9WGkOFPJq46h0QfVBTAzuMAxMa537Q=;
        b=Mf2xeq/QokxYayb4lJnAX/lw1nbNEItrPC0TNhKI2tx1oW1E88UZS/I3Kh4/YijNvb
         iTVU539UUfzfjMwGhIlIp27/vy62AsKGWafxqQNjP9GjRy70gk0uvWmhthI/Z9J8+H2c
         YaloE+/5p/PiqFttAl1NXDRXPU1MAhRHm9wqolg8XmXR9IzEfdKsltOOt4/TR3ukS8gx
         YOmcMJ13ChJVnZVF2uSYmT8f6Wt7Dqn1INVRuy73DmRFzSViRAcKeQV+7+F30OS9Ryq1
         qxQ31gFEW5XQLqS/hvOH0D8O1XzUnbsjkz5VSCr8iblMtIVtpMfaUBMpNMYHdQLtN3j0
         l3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFhFlz6g4nhDs9WGkOFPJq46h0QfVBTAzuMAxMa537Q=;
        b=zQ481afu+YUTXYm8jnzQ+MT/u/jLjMAurYdQv2jd1lcRVPg4yQNfLffXVl+2MBcb6a
         RbFdgxFVfFnnTs5DVxEeC/bD6dEhFVtk85Lt1TtIqbBdC+9aJB9qLpQywM+5Fi4bGMXP
         Z7ATlCOaOgY5X25ASW4ps0Q2fSkcNCFUdcWz3uLZO9+j/5lsHZQZR4r05E9Pi4oJEElv
         hQPLpMHVznxRc8HMdvuXF59ETXPbgHvKwcrxq+57CACQVzCpXQiQNrOyk91AgEYdHlNK
         y02jIW+GVgceh0i4uEp/YnlCoeCSjIxeIpOlJe/EdoIQyT4xqJ3IGhwQ8M9W/eq4jO0g
         B2vA==
X-Gm-Message-State: AOAM531eX+e3zbp/TJziGswHQpJB7sUbS//I5uzrI2uJ6mSQAt6ZNpFv
        wRaso9vUuW73GnOLs8nqWHcQFjInj/viPOYlrcTPLa9no3vY1FLUMEXCHLs45GbDbat4LRbTsh9
        vfUglzNGkLlfN7IjVw8Vs
X-Received: by 2002:a05:622a:15c7:b0:304:ec84:7718 with SMTP id d7-20020a05622a15c700b00304ec847718mr19463469qty.585.1654807653646;
        Thu, 09 Jun 2022 13:47:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgpUnY7IQDH6aK6jZt0jxFCvpcyKFtWVYwuZSsbAU59vpK2BBfKEseR84cpC2E8O5Xplxu6A==
X-Received: by 2002:a05:622a:15c7:b0:304:ec84:7718 with SMTP id d7-20020a05622a15c700b00304ec847718mr19463448qty.585.1654807653308;
        Thu, 09 Jun 2022 13:47:33 -0700 (PDT)
Received: from downhome.. (ec2-3-215-55-7.compute-1.amazonaws.com. [3.215.55.7])
        by smtp.gmail.com with ESMTPSA id d5-20020a05620a240500b006a6b1630e95sm5428568qkn.45.2022.06.09.13.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:47:31 -0700 (PDT)
From:   Rhett Aultman <rhett.aultman@samsara.com>
To:     linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc:     Oliver Neukum <oneukum@suse.org>,
        Alan Stern <stern@roland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rhett Aultman <rhett.aultman@samsara.com>
Subject: [PATCH v2 0/3] URB_FREE_COHERENT gs_usb memory leak fix
Date:   Thu,  9 Jun 2022 16:47:11 -0400
Message-Id: <20220609204714.2715188-1-rhett.aultman@samsara.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <alpine.DEB.2.22.394.2206031547001.1630869@thelappy>
References: <alpine.DEB.2.22.394.2206031547001.1630869@thelappy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: I4MkSqENreZI9SRSn_ZbaEaz0NdcMRad
X-Proofpoint-ORIG-GUID: I4MkSqENreZI9SRSn_ZbaEaz0NdcMRad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-09_15,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=869 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

This patchset is a v2 replacement for an earlier patch to resolve a
memory leak which can occur with successive iterations of calling
gs_can_open() and gs_can_close().  The central cause of this memory
leak, which is an issue common to many of the USB CAN drivers, is that
memory allocated for RX buffers using usb_alloc_coherent() and then kept
in the URB will be properly freed when the URB is killed.  This
assumption is incorrect, as memory allocated with usb_alloc_coherent()
must be freed with usb_free_coherent(), and there is no provision for this
in the existing URB code.

The common solution to this, found in v1 of my patches as well as in
already merged patches for other CAN USB drivers (see the patch for the
esd CAN-USB/2 driver here:
https://www.spinics.net/lists/linux-can/msg08203.html) is for the driver
itself to maintain an array of addresses of the buffers allocated with
usb_alloc_coherent() and to then iteratively call usb_free_coherent() on
them in their close function.  This solution requires a driver developer
to understand this unclear nuance, and it has historically been solved
in a piecemeal way one driver at a time (note: the gs_usb driver has had
this issue since the 3.x.x kernel series).

Rather than continue to place the burden of complexity on the drivers,
this patchset adds a new URB flag which allows the DMA buffer to be
correctly freed with the URB is killed.  This results in a much simpler
solution at the driver level and with minimal additional code in the USB
core.

Rhett Aultman (3):
  drivers: usb/core/urb: Add URB_FREE_COHERENT
  drivers: usb/core/urb: allow URB_FREE_COHERENT
  can: gs_usb: fix DMA memory leak on close

 drivers/net/can/usb/gs_usb.c | 2 +-
 drivers/usb/core/urb.c       | 5 ++++-
 include/linux/usb.h          | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.30.2

