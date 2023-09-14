Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56507A02A4
	for <lists+linux-can@lfdr.de>; Thu, 14 Sep 2023 13:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbjINLaM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Sep 2023 07:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjINLaL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Sep 2023 07:30:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE10A8
        for <linux-can@vger.kernel.org>; Thu, 14 Sep 2023 04:30:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c1e780aa95so5981405ad.3
        for <linux-can@vger.kernel.org>; Thu, 14 Sep 2023 04:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694691007; x=1695295807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bsKYKkUbeI9DiBtbhXijP4wNgi1W+EBaTGjNJbZunsA=;
        b=hTQTPvke6gScJ65NGGO41gpaSBHOMbnGF705uzm1EDxY7ZUlk3z/qyeaca/jM98QsF
         VxdTRSNi+F8oMyqnvbtsAF4sonhUbVHROWaYFA+/5N19KjlcLeITW2o6v7FyHWl89z4C
         aCbJ3BKTkkkPRRgasuF/DE0RpwkSRQFXj78n0JoLuKGZJzQmGO2CtToCbRLqZvqKVZN9
         biHjnDHi7LmxqzcUxdOC6fg4fMLN92UaIwHmUihCyRQVydPmmcOw/QuVvXpiu1ZNzt6p
         J8YlwgrpCej87VCod/I0E013QhCYAlSazAvqFhIqcdTUj6k5L/1C1hD2gR7yq41XuhDw
         X8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691007; x=1695295807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsKYKkUbeI9DiBtbhXijP4wNgi1W+EBaTGjNJbZunsA=;
        b=V024Vincyjnoh1aD8c95+w6uudnJVtCAo/9ll+m/tkR0GHOj5IHYHf/1dLf9pW5xSr
         X/+lGEPF1LQDEkFxD9UrdrEvwCY2T2xknzF5VzP8IlquQjskFSvgoALQL5304MgUAi4U
         FoIwQUScmvCiR294VAKNQ2SXPA4fd9xcZzukhURxcdmhBvQ0baG1C1l5Sn3K+4z7Fe8b
         iudafskyyB5P7nZgVOLpH52dTTiKBk2sJZhTNim7+dJlfe5jttTsOz5Jf+RI+YkgUZj0
         VIotF4QafVxeJeApdppHwpCETa/DaCj0zA2G0RI65ObrVtfvAEa7kLibZkp4uBfy39Yv
         gWlA==
X-Gm-Message-State: AOJu0YyyP783+7MEVF3qmfIG3yVPp70jQXV5iY+IOudixcDRXDi/t/mS
        OaLR7WW5AiycyhIbrtRtO4Q=
X-Google-Smtp-Source: AGHT+IHWJkX3vHTz7nrFG3t2/Wx7kkh11h3XZTAKXPoUmGbAP/qQFyrxQ7qHsj9IhRsWNg79HefTLA==
X-Received: by 2002:a17:902:eecd:b0:1c2:702:61af with SMTP id h13-20020a170902eecd00b001c2070261afmr4956424plb.38.1694691006721;
        Thu, 14 Sep 2023 04:30:06 -0700 (PDT)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b001b87d3e845bsm1350765pll.149.2023.09.14.04.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:30:06 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 0/2] can: etas_es58x: clean-up of new GCC W=1 and old checkpath warnings
Date:   Thu, 14 Sep 2023 20:29:52 +0900
Message-Id: <20230914112954.3067242-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The kernel recently added new warnings, one of which triggers a known
false positive on the etas_es58x module. In an effort to keep
es58x_etas free of any W=1 and W=2 (excluding those produced by
foreign headers), add a workaround to silence it.

While at it, this series also fix a checkpatch warning which I knew
existed for a long time but was too lazy to tackle.

Vincent Mailhol (2):
  can: etas_es58x: silence -Wformat-truncation
  can: etas_es58x: add missing a blank line after declaration

 drivers/net/can/usb/etas_es58x/es58x_core.c   |  1 +
 .../net/can/usb/etas_es58x/es58x_devlink.c    | 38 +++++++++++++------
 2 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.25.1

