Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA811580EE5
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 10:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbiGZI1X (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 04:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiGZI1V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 04:27:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C3C2FFDC
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d7so12667043plr.9
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uGfV/qvToULgoAf7TGPlZFrR+YDa/MsR+K4o/VBmaVg=;
        b=hp2gSD06eGB8IME2JR8dOnXxxSX/LgYWabbG3A0/7YnzsExHQdVx+mqbPpb3AwKmAZ
         GcSRES7kNB9WfMz1tHA48+3vZf2Koqpuo5TEfXVgHejS2u25DLz00WwxHLwnhSVfPGJj
         DZxgwZJ+BM6l4KNE+bh6x94mmVT9DPbiSyNbkP0+jZGSCqDMAwpjnSlYatzhilmI+F9y
         4Pz89p1pd7N6CRbDqKEWcVfeAr1s7Nc7l30Avv680cr/cL7se2TjIF103LKVLNLkBhQe
         GtaiXsesIt+csnLJuz8iF43j5dT9cS23grkY4eVVNNTTsh7kGjuryAyR7e3cRARuBnj7
         5JGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uGfV/qvToULgoAf7TGPlZFrR+YDa/MsR+K4o/VBmaVg=;
        b=fPo16yIE8mux0AtdFaHAi47yLTSdBispePoD4xCXaq3GeUnT/r/nOwOvS5LWxWVxQM
         BzbVn992XJx1sIJry8ssfyDUgkG272Z6uf3czVa1Q+tJSINArPRpMZozFMQfpF3H1jcj
         ezSaCkD85kq0YqA9f79Wf809ih+3fUMAdqljcsEVaCMW9wgvUzfdYTGKipW60EFVkRQZ
         M27zpcB9RkTI71fPBeSkwiJnLB+EE8bVwLoFfGsVbs6PomwPx7VmuamGVxVp5bLTMv1T
         uXzvH13txL8FOGSejqkPqJpq22Y5y+2UOh9N/Qq6/fnCvoa1oAddVOI3i/iOzhVBImHp
         uB1Q==
X-Gm-Message-State: AJIora8/ZmllvNw8EgR+tvG7fVi3vh3cZH4BfQu8e3pFm/uYeZuSiApB
        vAymkVZVI28PB1HfbPwEjo21LIfjyuu1Vg==
X-Google-Smtp-Source: AGRyM1uLZs3MpYrkmO/RHy0BIJpodRt8peOAgqztgxaqRibdmVROr+y23zUb/Ewt+zmCDFk+nO2bjw==
X-Received: by 2002:a17:90b:4b11:b0:1f2:baa4:35db with SMTP id lx17-20020a17090b4b1100b001f2baa435dbmr8674513pjb.195.1658824039677;
        Tue, 26 Jul 2022 01:27:19 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e1d100b0016bf10203d9sm10689751pla.144.2022.07.26.01.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 01:27:19 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 00/10] can: remove litteral strings used for driver names and remove DRV_VERSION
Date:   Tue, 26 Jul 2022 17:26:57 +0900
Message-Id: <20220726082707.58758-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
References: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is a cleanup series.

The patches 1 to 8 get rid of any hardcoded strings and instead relies
on the KBUILD_MODNAME macros to get the device name. Patch 9 replaces
the ES58X_MODULE_NAME macro with KBUILD_MODNAME in
etas_es58x. Finally, also in etas_es58x, patch 10 removes the
DRV_VERSION so that the module uses the default behavior and advertise
the kernel version instead of a custom version.


* Changelog *

v1 -> v2:

  * The patch for esd_usb contained some changes for ems_usb.

  * v1 assumed that KBUILD_MODNAME could only be used when the file
    basename and the module had the same name (e.g. vcan.c for the
    vcan.ko). The fact is that KBUILD_NAME extends to the module name
    and can thus be used even if the basename is different
    (e.g. slcan-core.c and slcan.ko)

  * Add patch #9: can: etas_es58x: replace ES58X_MODULE_NAME with
    KBUILD_MODNAME

v1:

This series are the first 9 patches of:
https://lore.kernel.org/linux-can/20220725133208.432176-1-mailhol.vincent@wanadoo.fr/T/

The initial intent of those 9 patches was to do so cleanup in order to
implement ethtool_ops::get_drvinfo but this appeared to be useless:
https://lore.kernel.org/linux-can/20220725140911.2djwxfrx3kdmjeuc@pengutronix.de/

Instead, those patch are send as a standalone series


Vincent Mailhol (10):
  can: can327: use KBUILD_MODNAME instead of hard coded names
  can: ems_usb: use KBUILD_MODNAME instead of hard coded names
  can: slcan: use KBUILD_MODNAME and define pr_fmt to replace hardcoded
    names
  can: softing: use KBUILD_MODNAME instead of hard coded names
  can: esd_usb: use KBUILD_MODNAME instead of hard coded names
  can: gs_ubs: use KBUILD_MODNAME instead of hard coded names
  can: kvaser_usb: use KBUILD_MODNAME instead of hard coded names
  can: ubs_8dev: use KBUILD_MODNAME instead of hard coded names
  can: etas_es58x: replace ES58X_MODULE_NAME with KBUILD_MODNAME
  can: etas_es58x: remove DRV_VERSION

 drivers/net/can/can327.c                         |  4 ++--
 drivers/net/can/slcan/slcan-core.c               | 14 ++++++++------
 drivers/net/can/softing/softing_main.c           |  4 ++--
 drivers/net/can/usb/ems_usb.c                    |  4 ++--
 drivers/net/can/usb/esd_usb.c                    |  2 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c      | 14 +++++---------
 drivers/net/can/usb/gs_usb.c                     |  6 +++---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c |  2 +-
 drivers/net/can/usb/usb_8dev.c                   |  4 ++--
 9 files changed, 26 insertions(+), 28 deletions(-)

-- 
2.35.1

