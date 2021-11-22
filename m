Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950F6458C9B
	for <lists+linux-can@lfdr.de>; Mon, 22 Nov 2021 11:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbhKVKtq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Nov 2021 05:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbhKVKtq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Nov 2021 05:49:46 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7215C061714
        for <linux-can@vger.kernel.org>; Mon, 22 Nov 2021 02:46:39 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f18so78758130lfv.6
        for <linux-can@vger.kernel.org>; Mon, 22 Nov 2021 02:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wuprcCzJz0EmXc1SE/2ky8W7hZ6gSGjF0nw9cYB1gCQ=;
        b=r9YtxbybrGBr+auu4rx2uoR9H9Jm9ecmh+VeP61E/AeSjxTWySxphi9EL/9NSpP4lT
         5frCpTbwRMB/MCsiYk//Vf1AgpariinQC+8qCZ6GFtZcN6bUPPXoGTH3u4j46VFg2GaT
         fFwrRacO3k1xIVtwOLFyKQR3lRHnwXwXidaLZAqxz0mgliWUWhkMYpc5tiv7Dkn2wfPq
         JWKqixe0voxrsnTOf5M1pGfvkN8USXnCoFOTwq7VuazQEXza9DzkoiA7+pSloin2Osmj
         rHi1Tpzb4JJkuVOPlTfd6HaXJ6MRpAs4kMkz04ZetizYmd1V1n7pkvtSwRhuwHG2vdpn
         ZGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wuprcCzJz0EmXc1SE/2ky8W7hZ6gSGjF0nw9cYB1gCQ=;
        b=V1E99kmtcmvQHBbcqZPoSfp0s6gXknNBvdcDhEM0FKaza1iMnEVJ/Y+ZYkj1HXajOU
         EP4QmAFTHFFM50IjCYk4lquup47AdiO/0MKWZjwa4oLvuh9iAQyzURfgaGiyFP/hOs+H
         4luCshcEhCcxxKVVDDmMwQ9Cr68CkIAlodruQVwAg/Ut3ZPPplEg0ZY/hgjR/yftfuxO
         lNIMZtusrCipLEZ+WzF07ZCn5FTO2p3p6MG208L3Ormcrualy4QhAJY6n2sf2+vkhvQZ
         heSttz8doOajRpWGqpv87Nja7eaGEjvusY4UDhydvnD5IjJWiRCno6Qlyi7mNt2bbbTv
         byAw==
X-Gm-Message-State: AOAM532N0kO5LwiYees5kX3XWCDnK53Tyq7k15DT6kDkXubCUUkIds5y
        UZC0795BoEecq51t5vF2Ux20bA==
X-Google-Smtp-Source: ABdhPJwOABsSxGBKDPfr0l0ADAVn8o4ZcYF24gt2lFlOuUOEAgoIPViPmZf4oCO480Cq02iyZm4hNw==
X-Received: by 2002:ac2:4564:: with SMTP id k4mr55435628lfm.380.1637577997883;
        Mon, 22 Nov 2021 02:46:37 -0800 (PST)
Received: from boger-laptop.lan (81.5.99.121.dhcp.mipt-telecom.ru. [81.5.99.121])
        by smtp.gmail.com with ESMTPSA id bi24sm923538lfb.49.2021.11.22.02.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 02:46:37 -0800 (PST)
From:   Evgeny Boger <boger@wirenboard.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Evgeny Boger <boger@wirenboard.com>, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-can@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: [PATCH 0/3] add support for Allwinner R40 CAN controller
Date:   Mon, 22 Nov 2021 13:46:13 +0300
Message-Id: <20211122104616.537156-1-boger@wirenboard.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Allwinner R40 (also known as A40i, T3, V40) has a CAN controller. The
controller is the same as in earlier A10 and A20 SoCs, but needs reset
line to be deasserted before use.

This patch series introduce new compatible for R40 CAN controller,
add support for reset line in driver and add the corresponding nodes
to the SoC .dtsi file.

The CAN IP was documented in early V40 datasheet [1]. It also fully
supported in vendor BSP. However, CAN description was removed from
more recent A40i, T3 and R40 user manuals and datasheets.
Anyway, we verified that the CAN controller is indeed there and tested
it extensively on A40i-based custom hardware [2].

[1] https://linux-sunxi.org/File:Allwinner_V40_Datasheet_V1.0.pdf
[2] https://wirenboard.com/en/product/wiren-board-7/

Evgeny Boger (3):
  dt-bindings: net: can: add support for Allwinner R40 CAN controller
  can: sun4i_can: add support for R40 CAN controller
  ARM: dts: sun8i: r40: add node for CAN controller

 .../net/can/allwinner,sun4i-a10-can.yaml      | 24 ++++++++
 arch/arm/boot/dts/sun8i-r40.dtsi              | 19 ++++++
 drivers/net/can/sun4i_can.c                   | 61 ++++++++++++++++++-
 3 files changed, 103 insertions(+), 1 deletion(-)

-- 
2.25.1
