Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045F5484240
	for <lists+linux-can@lfdr.de>; Tue,  4 Jan 2022 14:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiADNUt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 Jan 2022 08:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiADNUq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Jan 2022 08:20:46 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8D8C061761
        for <linux-can@vger.kernel.org>; Tue,  4 Jan 2022 05:20:44 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b13so148389435edd.8
        for <linux-can@vger.kernel.org>; Tue, 04 Jan 2022 05:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/GkwF7Da5XIamKReKsj0HsZhSVJSApc2Gxuc5P0F58=;
        b=Orcz1Ulcpgxql5P3geTM4KS23mA4oqud5iffrm073yQbrJxGUBcEMP5qDl5yBdDLQI
         AkkRJeK0J2hxjMSkDJ/LI0n8tZaXDcEU8IsmptJNOyU/nfjPGY6b6EPr6vi/WVV7vlPW
         dcqTdvgIn4kjdLIVjHudOJWHuI2jvgO4PwYlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/GkwF7Da5XIamKReKsj0HsZhSVJSApc2Gxuc5P0F58=;
        b=JIJHdbtZ/mmSVtYj4MLH9C7UPCxLxFLmtUM7AOcKuJXRRzWAURNf+JNLcx2sZzCr8W
         wPo67nxkUsa8qmkUF6CNk2yl8RbDSV/ytgtzrMkdegfbOWM2GSDZisprGLpBkfZC1z5W
         c2V0PHWpBtMQ+YAXb+EWvIQ2WzWvu7LdFGI51UhARYOA9UzNsmGyxja4Nbe2Gcm2yzWh
         VMdcmn4m/J2+djgOhawtQtr7MQ5jn05T1GVKo3M/Yjd/wf/greRpMeZmMIdvMfNk7UyC
         ewkefg6lty7yiDZVNwifZBXPh3lpXxYUX13c95KyELBkIOTH7uUExIvFDP/Du19IvFr9
         tUdA==
X-Gm-Message-State: AOAM533nmY01ye+ayxoelVQwn5K9wv5m8F5C9xKnrnqUWmx24J+YR6IN
        677WKv+V1GjzzhxguutE+ut8NQ==
X-Google-Smtp-Source: ABdhPJyJMtxLvzivI2st83HvXyyfiTOFhY2WMHimu9EkqSxFO2LU/qKMIFCwsOUEHgckh0mm3Sj7Hw==
X-Received: by 2002:a05:6402:491:: with SMTP id k17mr48221773edv.333.1641302442702;
        Tue, 04 Jan 2022 05:20:42 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-244-92-231.retail.telecomitalia.it. [95.244.92.231])
        by smtp.gmail.com with ESMTPSA id y13sm14765575edq.77.2022.01.04.05.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 05:20:42 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC PATCH 0/2] Change flexcan features at runtime
Date:   Tue,  4 Jan 2022 14:20:24 +0100
Message-Id: <20220104132026.3062763-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This series was born from the review https://lkml.org/lkml/2022/1/2/127
by Marc Kleine-Budde. The ethtool module is minimal and lacks the
callback to change the setting at runtime (this has yet to be defined).
I'm certainly not an expert but might it make sense to use the
set_features() callback? Although I understand that it belongs to
`struct net_device_ops' and not to 'struct ethtool_ops'.


Dario Binacchi (2):
  can: flexcan: allow to change quirks at runtime
  can: flexcan: add ethtool support

 drivers/net/can/Makefile                      |   3 +
 drivers/net/can/flexcan.h                     | 107 +++++++++++++
 drivers/net/can/flexcan_ethtool.c             |  29 ++++
 drivers/net/can/{flexcan.c => flexcan_main.c} | 144 ++++--------------
 4 files changed, 166 insertions(+), 117 deletions(-)
 create mode 100644 drivers/net/can/flexcan.h
 create mode 100644 drivers/net/can/flexcan_ethtool.c
 rename drivers/net/can/{flexcan.c => flexcan_main.c} (92%)

-- 
2.32.0

