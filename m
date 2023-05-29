Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E126714A88
	for <lists+linux-can@lfdr.de>; Mon, 29 May 2023 15:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjE2Nov (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 May 2023 09:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjE2Nor (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 May 2023 09:44:47 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115EB8E
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:46 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2af29b37bd7so34849751fa.1
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1685367884; x=1687959884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kfb8jEOCvi7etT7or4n95CsCpdDAsL2PKRW85iGysfY=;
        b=R9PZT468xPBOY4Tgz2QzUg+mjy7H3gmeauJyP9zaWTdj5vFmfFbo+f7zbqGevvAUeL
         TYjOxE5Yon0g/8c4RtEhLPz1n5FpajKFZbXnJ/7bA9kYB7bbIlOQGwvXQW7ZE9vvptqp
         2xG4/XCOdBYOZRB8/N0251zD98cEu/vzpNnmFtnOXUsRqMvFPGVVa7ummieVbLNlsIWZ
         xj9j76mw/Qud206MORQ6WKuMyZF3JxpgVY6/9P4sKQtYQ9hs72THn3+Mn30iwFJNiELG
         cJq21OCK0S765u4drRCNo4eMltf+k9IoBJ3JfvbJzUIP1kSxyRyj1d1zG8h2eR8eVgYu
         Bgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367884; x=1687959884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kfb8jEOCvi7etT7or4n95CsCpdDAsL2PKRW85iGysfY=;
        b=Rkue7W1+87Kf3Rfxy3IgcHysi5AxH7ffUNRApJTbzn1Y5r2IjoLwMP+UMuRkVXANod
         SaYn/2Schw55QuVcrR+oDUOatVu72ULN3lkq2WSJQSOFo2te/KtjXPPKSaB47i9aHObL
         WwfNgxmy8lWTr52Ay+SZj9beQJfLjy2GLlU5LwJu2gYRqtqZN/DNeKwqbpUQcNamdi+M
         t8tKje5/7whFRYuKoBpc1VLdDixekDY9BtIwsjtRePbAdVxn8KISARaIvIWQIKAFzyY5
         VoFEiiu+IWn+USlNVPRred0kDVKGHiSJfPFzaHvj415pqmzaxTeEvaQtORzHiFOOzoWw
         CkVw==
X-Gm-Message-State: AC+VfDw7/qqLaZPP8Ggncz4D0KnP+70BTKzyKTaXsl0YMJz93FV/oRMu
        sz0jW59nIG+2gx6lAROCCUKPPlVHQ7v228lXhRk=
X-Google-Smtp-Source: ACHHUZ70EIUH6MTTCzWduECaw2CunuqfomFqz64mXaSEI/4vDXP6w3dJZP2xSaWIfH2ozumsHIgN+A==
X-Received: by 2002:ac2:424e:0:b0:4ee:dafa:cb00 with SMTP id m14-20020ac2424e000000b004eedafacb00mr3534612lfl.60.1685367884248;
        Mon, 29 May 2023 06:44:44 -0700 (PDT)
Received: from freke.kvaser.se (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id s7-20020a19ad47000000b004ebae99cc1dsm580lfd.159.2023.05.29.06.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:44:43 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 00/14] can: kvaser_pciefd: Fixes and improvments
Date:   Mon, 29 May 2023 15:42:34 +0200
Message-Id: <20230529134248.752036-1-extja@kvaser.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch series contains various non critical fixes and improvments for
the kvaser_pciefd driver.

Jimmy Assarsson (14):
  can: kvaser_pciefd: Remove useless write to interrupt register
  can: kvaser_pciefd: Remove handler for unused
    KVASER_PCIEFD_PACK_TYPE_EFRAME_ACK
  can: kvaser_pciefd: Add function to set skb hwtstamps
  can: kvaser_pciefd: Set hardware timestamp on transmitted packets
  can: kvaser_pciefd: Define unsigned constants with type suffix 'U'
  can: kvaser_pciefd: Remove SPI flash parameter read functionality
  can: kvaser_pciefd: Sort includes in alphabetic order
  can: kvaser_pciefd: Rename device ID defines
  can: kvaser_pciefd: Change return type for
    kvaser_pciefd_{receive,transmit,set_tx}_irq()
  can: kvaser_pciefd: Sort register definitions
  can: kvaser_pciefd: Use FIELD_{GET,PREP} and GENMASK where appropriate
  can: kvaser_pciefd: Add len8_dlc support
  can: kvaser_pciefd: Refactor code
  can: kvaser_pciefd: Use TX FIFO size read from CAN controller

 drivers/net/can/Kconfig         |   3 +-
 drivers/net/can/kvaser_pciefd.c | 955 ++++++++++++--------------------
 2 files changed, 342 insertions(+), 616 deletions(-)

-- 
Changes in v2:
  - Add new patches, to replace opencoded masking+shifting with
    FIELD_{GET,PREP} and GENMASK, suggested by Vincent MAILHOL [1]

[1] https://lore.kernel.org/linux-can/5b10f6cd-c96c-3198-3df4-557e5e91b2e7@kvaser.com/T/#m14c3851e70cfb8c903388e068968a4a379d183e6

2.40.0

