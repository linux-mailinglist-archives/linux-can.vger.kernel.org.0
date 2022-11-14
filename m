Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944EA6285A1
	for <lists+linux-can@lfdr.de>; Mon, 14 Nov 2022 17:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbiKNQkt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Nov 2022 11:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbiKNQkZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Nov 2022 11:40:25 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47502263C
        for <linux-can@vger.kernel.org>; Mon, 14 Nov 2022 08:39:07 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so11207143pjk.1
        for <linux-can@vger.kernel.org>; Mon, 14 Nov 2022 08:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORGbHx6DAAf7O166A6uRGBnAcitb+//oCFeeQtRlTVk=;
        b=eqpwiUw6wMDuppML75pAdj1U0q11iIOG+oK8n2003PxcuPkKHa8gO0do6Rc7q4dbjF
         bszEoLTAve+Hph3htx921faxyt9NVBzS7ANmHPyhKpR4NPzD3rdJq2rlq6EsvKOHkB3O
         NygxEkwabqYVOF/cSmdXko66/rAFjsogXH9xsNLqPuEtUaqsLZxmwNn/gOtZLe8uF9wx
         ceMUJbzGpkugcqiioIzoRiJp06WmAS+Eu91E5i75/iQ0A3/uiyOXRgCxMLCd9FMDSq/w
         Xrw2lu1idVHeVZXkabB3oUXoKDxoleJ9VVwoRNzG7sAw7tVAnskIhppyt9RRg+fS3PL0
         /xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ORGbHx6DAAf7O166A6uRGBnAcitb+//oCFeeQtRlTVk=;
        b=IkdB6Ulr8zYJxpsi7yBm+ysVXW8794uxpTtzQMVHxhLnPlFS88UTfpyIVD/vsuD4fI
         atZ2GrmwifzCuy0WOP/zK7NRmWIqtOqZ12P3PBUR6isF1M9GpuDXSNdK880DhK5YX6ud
         zygkk9RikXbcxBqJKj3YAXngSBIRstjKLrRsLVdUm5BqsPDZTn9ErKfyfWZlnsxO2gmk
         eIWXXF/ctyC7DCSUX2Yf6bS144wZ3Wmv72yjcbvzm5AZv9Ef2zmgPlM9O2tBUbxie+Z4
         WF1Mpry4R0xwC2+z2MCHT4rFHqsggHGpvOtvUROHY8rb73P1Kxn/v4UqKlBCG7Yqme2X
         8dSg==
X-Gm-Message-State: ANoB5pn0/fmq6A4TGqCnsWJcfJilkD3xD90pNeVuPzXFIhiuP1BxqoIf
        ntLq9H3yBAmU3F78q6rBZClDlmrzANGgRA==
X-Google-Smtp-Source: AA0mqf5Nc/yXiUL3NaB8YMgktaOcMSm7GtS9QSdOaEsD57yH7vFt9LvLcag1WXjOJHSY1I8oq8yi6g==
X-Received: by 2002:a17:90a:73cf:b0:213:7f5:a972 with SMTP id n15-20020a17090a73cf00b0021307f5a972mr14789206pjk.159.1668443946522;
        Mon, 14 Nov 2022 08:39:06 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id g190-20020a6252c7000000b0057255b82bd1sm807183pfb.217.2022.11.14.08.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:39:06 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH can-utils-dev v3 0/6] can-utils-dev: a set of update and cleanup patches
Date:   Tue, 15 Nov 2022 01:38:42 +0900
Message-Id: <20221114163848.3398-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
References: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This series contain cleanup patches and update of header files. There
is no real relation between each patch (aside of 2/6 and 3/6 which
form a pair) so I will end the cover letter here and let you refer to
the short description.

* Changelog *

v2 -> v3:

  * reorder the patches so that related changes are next to each
    other (especially patch 2/6 and 3/6).

  * patch 2/6: new patch to update include/linux/can/error.h with the
    latest hearder from Linux 6.0.0.

  * patch 3/6: do not use an #ifdef anymore and make sure that the
    code still work if run on old kernel version lower than 6.0.0.

  * patch 6/6: rewrite commit description to point out that there is a
    local copy of the linux headers under include/linux/.

v1 -> v2:

  * patch 2/5: add a note in commit message to explain that slcanpty.c
    debug is deactivated by default.

  * patch 2/5: make the compiler check the pr_debug() syntax even if
    debug is off.

  * reorder the patches so that the lib.c and the candump.c patches
    are next to each other in the series.

Vincent Mailhol (6):
  slcanpty: remove redundant asc2nibble()
  include: update linux/can/error.h
  lib: snprintf_can_error_frame: print counter errors if CAN_ERR_CNT is
    set
  lib: add pr_debug() macro
  candump: add global variable progname
  candump: use linux/net_tstamp.h instead of redefining values ourselves

 Makefile                           |  2 ++
 canbusload.c                       |  9 ++---
 candump.c                          | 58 +++++++++++++-----------------
 canlogserver.c                     | 12 +++----
 include/linux/can/error.h          | 20 ++++++++++-
 lib.c                              |  2 +-
 lib.h                              |  7 ++++
 mcp251xfd/mcp251xfd-dev-coredump.c | 10 +-----
 slcanpty.c                         | 27 +++-----------
 9 files changed, 67 insertions(+), 80 deletions(-)

-- 
2.37.4

