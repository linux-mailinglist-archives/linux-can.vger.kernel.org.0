Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B4354B492
	for <lists+linux-can@lfdr.de>; Tue, 14 Jun 2022 17:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbiFNP1i (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 14 Jun 2022 11:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356438AbiFNP1Z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 14 Jun 2022 11:27:25 -0400
Received: from mx0a-0054a801.pphosted.com (mx0a-0054a801.pphosted.com [205.220.160.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B78443EC
        for <linux-can@vger.kernel.org>; Tue, 14 Jun 2022 08:26:46 -0700 (PDT)
Received: from pps.filterd (m0208801.ppops.net [127.0.0.1])
        by mx0b-0054a801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EDVN4G015641
        for <linux-can@vger.kernel.org>; Tue, 14 Jun 2022 08:26:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsara.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=samsaracom06092020;
 bh=N+ZpyJXTqFmXs7zEr5L34q80gYS+Io3SRLH79QvG/T4=;
 b=JOETpbuzaToD11dCop3crtcExIrhiJ9fnOajiZqdjm4oUbdDZohzFTBzhFCdueOQHXJT
 fMKKbRvFqtiqm4bVKp8K+I1SsRtzfpiz6h6785Wk1XLJPZrcNlM/hrljBSqmiSBLi9lL
 EYjl6+BHmiir1dxxFDZpgcsi3GyQ6ckIqkUQPXykvgbleKrHpTGAOB1jLjrnQazQtRtF
 x/cHCnHWp3xGq/MJGfbQ0Pxi4kZsgixGq/8AMY4XNgWKS6G+z1VANv1IS6nkwVOdpi6c
 JZH4LpVWyPfgQwIZdT5BWMH4vRCSxK3bvcwUW4sRyqLS3vtOMTmer8WwHQggOttMFMLo ng== 
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mx0b-0054a801.pphosted.com (PPS) with ESMTPS id 3gms9v28j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-can@vger.kernel.org>; Tue, 14 Jun 2022 08:26:45 -0700
Received: by mail-qk1-f198.google.com with SMTP id bj2-20020a05620a190200b005084968bb24so7679594qkb.23
        for <linux-can@vger.kernel.org>; Tue, 14 Jun 2022 08:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N+ZpyJXTqFmXs7zEr5L34q80gYS+Io3SRLH79QvG/T4=;
        b=Jbh7GnVirn2vLrSzHWjLAwTOwvH1YpDqx34WB9r67zUQhFgzAFgoCoNarOkrILg7+Y
         +hVrjpB40YhRqtqyJzeLk9Tx7Tr3bb/Thi/DDdMoBpXNs7whHZzYR8tgYt45oEDXuRov
         XTthQriwl8QqiI0baRCxqKHhBRO073n27f3RyvAlAl4yDV6s7VkjxbCKgv4oEO1XeIi8
         f7QlzLXfgBeI9n+/ODZvcuyd71g+4zefb/gnIliCQbHaU9wsJ6uW6wfin/pmENhNL5El
         ZEDyTYIRJsJbcjOxuvDq0ohxDXu3B8HhQYCGv4YoMQ9jntdGSwC2KMt9LAFLmGC5rL0w
         GvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N+ZpyJXTqFmXs7zEr5L34q80gYS+Io3SRLH79QvG/T4=;
        b=1sgunE7gpew2WliIG91i3D8H9WYb2ofTspM6UpK9Xdmm12AWpH7mSGoRJzx5qXOuVW
         cKRAJg10qDNUid+XVi3zFI/jYClKOj3EsaQSYOHL4VsyNhZf7kwb1oYSBKsPR8D02i3i
         cDoLO6rTN5eoqY5/VaPMl0e6Zh6+xYltTLm9XQxYwM+2LPeofMxUj63AREbc5g7N0St3
         YeOYfyYjx9as0TY8XtyAxVRfHmwm2SXbq2R9jkxRAiJUzmlOKmC+FBfqKx+ovdtRgj2Q
         9v0vg5c5bAatkU7b84Uo6hfZDYX0zsD23MwA2DWV9Fkklgmxx0Zb0CrbG4yH9qn3qRYj
         bJIQ==
X-Gm-Message-State: AOAM5331QZC38YNWUO5SdS07EJsPTKkOirkVq1BCqD/BKo4ApND6jrri
        pnz8rWJZVg4kItAVXcjVGy5nNkwqTX+8ysr8JUlOlT/KQEoUbvhFfrlZXoRIcYss96gOSF+alI3
        J2zHA+CvhL0cflYPr9q3L
X-Received: by 2002:ac8:7c4f:0:b0:304:e122:be6 with SMTP id o15-20020ac87c4f000000b00304e1220be6mr4658610qtv.275.1655220404377;
        Tue, 14 Jun 2022 08:26:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFJSw37P2wpprIvfzqSWpPx49wJIDgr5w7QSL40oye9iORgjeIN2KbSM/km6DS4jNGeOvPMg==
X-Received: by 2002:ac8:7c4f:0:b0:304:e122:be6 with SMTP id o15-20020ac87c4f000000b00304e1220be6mr4658590qtv.275.1655220404063;
        Tue, 14 Jun 2022 08:26:44 -0700 (PDT)
Received: from downhome.. (ec2-3-215-55-7.compute-1.amazonaws.com. [3.215.55.7])
        by smtp.gmail.com with ESMTPSA id k4-20020a05620a414400b006a743b360bcsm10199259qko.136.2022.06.14.08.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 08:26:43 -0700 (PDT)
From:   Rhett Aultman <rhett.aultman@samsara.com>
To:     linux-can <linux-can@vger.kernel.org>
Cc:     --cc=Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Rhett Aultman <rhett.aultman@samsara.com>
Subject: [PATCH v4 0/1] URB_FREE_COHERENT gs_usb memory leak fix
Date:   Tue, 14 Jun 2022 11:26:29 -0400
Message-Id: <20220614152630.2255641-1-rhett.aultman@samsara.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220610213335.3077375-1-rhett.aultman@samsara.com>
References: <20220610213335.3077375-1-rhett.aultman@samsara.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -yQ91AAvMwpyg2Zq5871be6MyW2UoRiz
X-Proofpoint-GUID: -yQ91AAvMwpyg2Zq5871be6MyW2UoRiz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_05,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 suspectscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxlogscore=984 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206140060
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patchset resolves a memory leak which can occur with successive
iterations of calling gs_can_open() and gs_can_close().  The central
cause of this memory leak, which is an issue common to many of the USB
CAN drivers, is that memory allocated for RX buffers using
usb_alloc_coherent() and then kept in the URB will be properly freed
when the URB is killed.  This assumption is incorrect, as memory
allocated with usb_alloc_coherent() must be freed with
usb_free_coherent(), and there is no provision for this in the existing
URB code.

The common solution to this, found in v1 of my patches as well as in
already merged patches for other CAN USB drivers is for the driver
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

This v4 patch only updates the commit message for one of the patches in
the v3 patchset.  No code has changed.

This patch depends on:
https://lore.kernel.org/all/20220610213335.3077375-2-rhett.aultman@samsara.com

** Changelog **

v3 -> v4:

  * Add Fixes tag and correct formatting for reference to prior commit

v2 -> v3:

  * Resolve style nits in gs_usb.c
  * Squash commits in urb.c and correct authorship

v1 -> v2:

  * Add URB_FREE_COHERENT flag to urb.c
  * Use URB_FREE_COHERENT flag rather than arrays of buffers in gs_usb.c


Rhett Aultman (1):
  can: gs_usb: fix DMA memory leak on close

 drivers/net/can/usb/gs_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.30.2

