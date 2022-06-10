Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED23546F45
	for <lists+linux-can@lfdr.de>; Fri, 10 Jun 2022 23:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243046AbiFJVdw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 10 Jun 2022 17:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348676AbiFJVdu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Jun 2022 17:33:50 -0400
Received: from mx0a-0054a801.pphosted.com (mx0a-0054a801.pphosted.com [205.220.160.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE03C2E9F4
        for <linux-can@vger.kernel.org>; Fri, 10 Jun 2022 14:33:45 -0700 (PDT)
Received: from pps.filterd (m0208803.ppops.net [127.0.0.1])
        by mx0b-0054a801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ABZdQ8011130
        for <linux-can@vger.kernel.org>; Fri, 10 Jun 2022 14:33:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsara.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=samsaracom06092020;
 bh=Li3HWhvCFgkv15xRJEXyVdR7MUK2E/lvUdg04ioS9y8=;
 b=WxEQ+2jZaKXPwCf6zWtGK9KyJd6NGg3aQ8AadknolxwgcWfRDXoe4ViGHtlvkKER0+t9
 GMWYFrHof6zmjzwwqDEXb1tS4FXtTWyHfaYz6A5EQLu8LGFq6NBaN5P19qtvQ02Hkpsj
 DAj8WC+Dhc0Yes22xVDEjOKpTihOsJdlpogGleaRBS5XYAdoG7sZDYQECNEd1bQePl1t
 5RP2a1J8A6y6OOSSk2YRPPXbodvLyD771H7lX9VSXrvoWwlU0Bh0oZ9Uwjf5e2ZOpBr9
 CIN1w91IGgsC2IubbxLg3u+EHSh8J39nAyxxRP66XYzB5NK7FJ+Yx7yyi9UqZGEflQGs Zg== 
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
        by mx0b-0054a801.pphosted.com (PPS) with ESMTPS id 3gkut90svv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-can@vger.kernel.org>; Fri, 10 Jun 2022 14:33:45 -0700
Received: by mail-qv1-f70.google.com with SMTP id ke5-20020a056214300500b00461fc78b983so341396qvb.17
        for <linux-can@vger.kernel.org>; Fri, 10 Jun 2022 14:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Li3HWhvCFgkv15xRJEXyVdR7MUK2E/lvUdg04ioS9y8=;
        b=c9/lS/fNo7eNT7eYho8fMvCLBY6LbOhBGKKC5AeW/HtMvIvD2P8GWMRiOh2wPG4Bls
         rEVkIpoNGx0MEsRofph8VFamysIBRfLtl2HpOf3v8iZF2tE/0kxcWKuLkcTV96KkurjW
         KfzaDPFn0xjFhrL9IGUU0xJ4Hpe/w0nKZFtCJsFJetXDva/jDyEek9mT3wwTHV2VLg1y
         EvbXRz9e+mS8Wm5U89nohjukYruvVMq7t+tLDCAThGtgnaKFqTG79jPQwZlrfncKzftm
         bEBwjsWRARW2AwhkNi+KITihpRM19ILY7X7HBncUNC6zM/rdGOHvxAB31oY+I4hFXe0R
         MeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Li3HWhvCFgkv15xRJEXyVdR7MUK2E/lvUdg04ioS9y8=;
        b=Ehs+lSODkYwXQZT025zeCJHMU6MdFeIExThHXkiQzhshR7AkNDAt/jhXci9JCz+/8m
         vbMWrj4dwhRoB/5a+C7iWDJFhVm+RWC4w2zDmQvM1fTl8dHMPzhjkyYI+YmHWY+XD5XH
         AZNqcbiQ+BWLLiwWPwdCFoeR73IMYixV1lCRS2TfNpi5Z46et5r8iNsuswsSDX5A/wFf
         01wTTXiWtgJ9vEjz0u7z9ohnacUBPmOS/J8sC5LpPPnOeryPmy1UMFqLH3FJ/HEu5ug+
         vz/QAgyauedtC7w825iGE9NnZSQLzTFuPzXUSwXvB5oVhR7+JOnTIZavkk7qtbzP6itS
         4wKQ==
X-Gm-Message-State: AOAM532hbjT4IC2ReHZEzb8CFI2X9Ps82wIV5Uk8JVdrGDsJemj65vFo
        V8ZAhz7LtVKKRnvWG2yDTBIjP3kuyYBecKwMGtSw2HE6zewji1MnBXEHJi1Y4Jl6AdzqdcFIvJN
        3YlEnQSpU66qIMX1oB5mG
X-Received: by 2002:a05:6214:230a:b0:461:e824:46fa with SMTP id gc10-20020a056214230a00b00461e82446famr89774726qvb.30.1654896823898;
        Fri, 10 Jun 2022 14:33:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxflMr0d2+AczmOukF2sVAsbvioPM5OAQbT2oks7aLf/3q7rWrvNITJKStDbNVpxs7u/50tVA==
X-Received: by 2002:a05:6214:230a:b0:461:e824:46fa with SMTP id gc10-20020a056214230a00b00461e82446famr89774701qvb.30.1654896823541;
        Fri, 10 Jun 2022 14:33:43 -0700 (PDT)
Received: from downhome.. (ec2-3-215-55-7.compute-1.amazonaws.com. [3.215.55.7])
        by smtp.gmail.com with ESMTPSA id b11-20020a05622a020b00b00304d8cdddfesm139742qtx.86.2022.06.10.14.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 14:33:42 -0700 (PDT)
From:   Rhett Aultman <rhett.aultman@samsara.com>
To:     linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc:     --cc=Oliver Neukum <oneukum@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rhett Aultman <rhett.aultman@samsara.com>
Subject: [PATCH v3 0/2] URB_FREE_COHERENT gs_usb memory leak fix
Date:   Fri, 10 Jun 2022 17:33:33 -0400
Message-Id: <20220610213335.3077375-1-rhett.aultman@samsara.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220609204714.2715188-1-rhett.aultman@samsara.com>
References: <20220609204714.2715188-1-rhett.aultman@samsara.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ebjiso4cfdxP6PBMB9EArG6pWVKt2Fhg
X-Proofpoint-ORIG-GUID: Ebjiso4cfdxP6PBMB9EArG6pWVKt2Fhg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_09,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 priorityscore=1501
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

This patchset resolves a to memory leak which can occur with successive
iterations of calling gs_can_open() and gs_can_close().  The central
cause of this memory leak, which is an issue common to many of the USB
CAN drivers, is that memory allocated for RX buffers using
usb_alloc_coherent() and then kept in the URB will be properly freed
when the URB is killed.  This assumption is incorrect, as memory
allocated with usb_alloc_coherent() must be freed with
usb_free_coherent(), and there is no provision for this in the existing
URB code.

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

** Changelog **

v2 -> v3:

  * Resolve style nits in gs_usb.c
  * Squash commits in urb.c and correct authorship

v1 -> v2:

  * Add URB_FREE_COHERENT flag to urb.c
  * Use URB_FREE_COHERENT flag rather than arrays of buffers in gs_usb.c

Rhett Aultman (1):
  can: gs_usb: fix DMA memory leak on close

Vincent Mailhol (1):
  drivers: usb/core/urb: Add URB_FREE_COHERENT

 drivers/net/can/usb/gs_usb.c | 2 +-
 drivers/usb/core/urb.c       | 5 ++++-
 include/linux/usb.h          | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.30.2

