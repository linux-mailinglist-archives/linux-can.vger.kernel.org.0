Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFD85FA0E4
	for <lists+linux-can@lfdr.de>; Mon, 10 Oct 2022 17:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJJPIw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Oct 2022 11:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJJPIv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Oct 2022 11:08:51 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E8066116
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 08:08:50 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id x18so5026038ljm.1
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 08:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jitku5OoK7gw3Z7JdGWTj1nFEhkZJv+jO0xkOiUsfTE=;
        b=tezV1eijbWBQsA3hx7lr489n153SIjrfiuJJwtti3Kxb7gIy+7Fm18fhGa+6rYR4N1
         HrNdqcY5p3h9YSIZECdBZYDSjipqdU0fw+Pf2pFf2gHDS3IBaVJKnM1m1oADSih44Yt0
         6HnW97/3UdPUhy9M/zuWMDcMrrZ9KX/N99zB7/31GI8KKxNm9EB5EhpBjZN1ow52AtJh
         sS99f4Xq0TVaoUMfmIyMpsGAXHHrE3oH7idJFi/VNKRr/fJ7dWjBeLRC1R8TjJmKF7C6
         djCDZU99johk4lDcIXrnezEiUt7xrofui1e6ZRdw0dZr65mej/eaSLNdPb3tvSfmn+h7
         Fv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jitku5OoK7gw3Z7JdGWTj1nFEhkZJv+jO0xkOiUsfTE=;
        b=M9WSVNcYbULmVUn2K7FxJfSyW8FnPGvIJWnBbuveMfckjtpaYSvS4oWZtywGEF/fqK
         fjdwvKi/HPucJF5cMvSNMcJFkLuOYM7rsYuhhlae2KHHQt3HDZHrDUdwawbL31VjD5l8
         ggXGICjwWxPH1PFO94tSK2ov/gEwSIVlFlTwPb+94mAYtfAzqyw1zBlYIA7QsT+Z4mRP
         VN/SFs8WTUJQ8cvsobdheT1zlJhH8N/Sqmycl/OgBRPayXDJ2o0+rUHjDhlbVDY4RG07
         6tyGljg3GmTBGpxP9Ci8wDHEkUFPTHV37mhTTraN76UJwDx30Ey6neCeLqUu6lfGm202
         9OAQ==
X-Gm-Message-State: ACrzQf0a5mHhbtBkdwYzev7d5pc3sn6Z+CzPsD/oai8b9GVlreDPWU0N
        hO8m7kEvxTNwGtw3NuPtvwB1glhoexycLg==
X-Google-Smtp-Source: AMsMyM5Pqs+VWegNa5J2+zLChGVilX7NWMoVkSP0Uh12gWYsPIDbkrZepVsQl8a+1WB5uuRTaRhcUA==
X-Received: by 2002:a2e:9d8f:0:b0:26e:36f7:a250 with SMTP id c15-20020a2e9d8f000000b0026e36f7a250mr6590196ljj.134.1665414529227;
        Mon, 10 Oct 2022 08:08:49 -0700 (PDT)
Received: from archyz.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id q7-20020ac24a67000000b0049ebc44994fsm1450280lfp.128.2022.10.10.08.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 08:08:46 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>, stable@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v5 0/4] can: kvaser_usb: Various fixes
Date:   Mon, 10 Oct 2022 17:08:25 +0200
Message-Id: <20221010150829.199676-1-extja@kvaser.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Changes in v5:
 - Split series [1], keept only critical bug fixes that should go into
   stable, since v4 got rejected [2].
   Non-critical fixes are posted in a separate series.

[1]
https://lore.kernel.org/linux-can/20220903182344.139-1-extja@kvaser.com
[2]
https://lore.kernel.org/linux-can/20220920192708.jcvyph3ec7lscuqj@pengutronix.de
Anssi Hannula (4):
  can: kvaser_usb_leaf: Fix overread with an invalid command
  can: kvaser_usb: Fix use of uninitialized completion
  can: kvaser_usb_leaf: Fix TX queue out of sync after restart
  can: kvaser_usb_leaf: Fix CAN state after restart

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  2 +
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |  3 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c |  2 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 79 +++++++++++++++++++
 4 files changed, 84 insertions(+), 2 deletions(-)

-- 
2.38.0

