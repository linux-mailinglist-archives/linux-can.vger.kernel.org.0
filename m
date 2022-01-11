Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7987048B16F
	for <lists+linux-can@lfdr.de>; Tue, 11 Jan 2022 16:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243870AbiAKP5g (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jan 2022 10:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243649AbiAKP5g (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jan 2022 10:57:36 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9986C06173F
        for <linux-can@vger.kernel.org>; Tue, 11 Jan 2022 07:57:35 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id s30so30128307lfo.7
        for <linux-can@vger.kernel.org>; Tue, 11 Jan 2022 07:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0nTUgBUzWqYITQnAEDWeHOtQPiYS2wv61d5KwBi3uYs=;
        b=t84dYxCCv052E4gw3UFG/bbNlvC8YH8gRdSgmtYiwENmKguYf09md0nJys7744EKcC
         Gb18/zBvF7TLIj8+vZBwHGt+hft0CIAnff82KzRuskCyFc8yQOJw6Nu6hcXE99ke0sAm
         1tAe+v9OsXmA80J5pSeGvWogw5cMcB/vs5exZWVIINMYL8DeWujfwdVFf+RIm+suxIoS
         6knSFycPXx9hDxLxMhOv0ymGkjJ7nd3loxPGiSTqrx6JuowFH4HxehN5hG3v84ncX3+b
         6zqraG1VyL0SdOUHNRAtcoEqagW5t7uEvEQsqRz3VpCoWQLqQqc8XIBNZoyYoCgRAsd7
         DQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0nTUgBUzWqYITQnAEDWeHOtQPiYS2wv61d5KwBi3uYs=;
        b=Ka58Sbh8JcBb00WqnhvqdTZPzVWB6F8wLVBIAYO4O3addMD9GOpTOrrWYhSawCPPx9
         liexatsQbyBE6P7yT6w0odOKfh4rrC9AXhmEu3aLuNETr5T2s/JRmJp6E+fgDuElGynQ
         Bqe3d9ng/IuMRYFDztjAlUYh1fcChiWDgO1AWlS3sOr/3hr23UauiAcNmTwT1ZnPy4cw
         LlrwpCNaWWQFkV1bTBzra89V9T66l5d9ua0kSajc4G5GsfyvFMqfriH7HJUvUczc4w4v
         ibKPMESUeoX+CcjqWyR3JCiqJV2fWk0fOD8JzymZFOA1C5h5y7Jdobpz4epS1UnzLARk
         GiBw==
X-Gm-Message-State: AOAM531gjK0sk2t9o3q78ZBgYPy1d+Y/eSKfmam6NvnI+uaSUHlMSHGw
        NX2EvxJEaGzgYEBHR/rasrAa6A==
X-Google-Smtp-Source: ABdhPJxDkpX6B9o6w77LG43w7VqtyI0FEwgWWHHETUr5EU+pxPzv92RWWzfNd7pnF/3igejqxXgdoQ==
X-Received: by 2002:a05:651c:160c:: with SMTP id f12mr913606ljq.462.1641916654069;
        Tue, 11 Jan 2022 07:57:34 -0800 (PST)
Received: from boger-laptop.lan (81.5.110.253.dhcp.mipt-telecom.ru. [81.5.110.253])
        by smtp.gmail.com with ESMTPSA id y7sm1370706lfa.92.2022.01.11.07.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 07:57:33 -0800 (PST)
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
Subject: [PATCH v2 0/3] add support for Allwinner R40 CAN controller
Date:   Tue, 11 Jan 2022 18:57:06 +0300
Message-Id: <20220111155709.56501-1-boger@wirenboard.com>
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

Changes in v2:
  - sort pinmux nodes alphabetically and mark them with omit-if-no-ref

Evgeny Boger (3):
  dt-bindings: net: can: add support for Allwinner R40 CAN controller
  can: sun4i_can: add support for R40 CAN controller
  ARM: dts: sun8i: r40: add node for CAN controller

 .../net/can/allwinner,sun4i-a10-can.yaml      | 24 ++++++++
 arch/arm/boot/dts/sun8i-r40.dtsi              | 21 +++++++
 drivers/net/can/sun4i_can.c                   | 61 ++++++++++++++++++-
 3 files changed, 105 insertions(+), 1 deletion(-)

-- 
2.25.1
