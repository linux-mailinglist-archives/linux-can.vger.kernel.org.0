Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485226FDF51
	for <lists+linux-can@lfdr.de>; Wed, 10 May 2023 15:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbjEJN4t (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 May 2023 09:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237071AbjEJN4k (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 May 2023 09:56:40 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFC6D870
        for <linux-can@vger.kernel.org>; Wed, 10 May 2023 06:56:20 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-76998d984b0so1051391839f.2
        for <linux-can@vger.kernel.org>; Wed, 10 May 2023 06:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683726979; x=1686318979;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7rPmA5T/DfNFh6+Hz1avxZ3Hk2kQmi9go+AbLGRdwj0=;
        b=Ib3fRc8VC9CDCEsVVA0oEDHdSajMiGvzwRC+c1k+qyWoDJ82stUk+9k9oM+gPPBhcz
         iQ2rN6woBmRU+aBJZOkx645IfSpZm/a0BEvmevrIA3NkjwVNCHALjwcaVZgA25XKlqgF
         vksSBJMwb1FEnm0OaRyP8oV5lbv2IWfguzUXRikjDtZ94L4j4QysgmR/RIQwRGIkY8Vz
         8xrjMafR7ENcLZFynpJDsaWz/amFRPWEEYlyC3pzmpVtipZOAxgty1uWn8hAnUw7kL6W
         3rTBIMCYS/u5lCIt47SxSaOp9T+aJWHe2O4r5HVHzX99reXAqrHn//WYRDV7HVBLFx+5
         rnCw==
X-Gm-Message-State: AC+VfDw7CbDm57nhjZbEYqTOvvw6p+RDrig1mEpZtAEYemjB1uFfXbbR
        36/QNltp76a0kSBcQ9uDR4kNM5ViHKN3omNeCsCe+POcPtDHfYY=
X-Google-Smtp-Source: ACHHUZ5E3y0GeU7lA/5S4rIqDNFzXlin/4FRqfI9VlKEotF0GMKU+pdJ7QlrEkItixDXtqXSXB7IOEgQiABWm/sEBoUEjkI/dC8z
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2164:b0:40f:9ac9:50f2 with SMTP id
 p4-20020a056638216400b0040f9ac950f2mr3184921jak.3.1683726979557; Wed, 10 May
 2023 06:56:19 -0700 (PDT)
Date:   Wed, 10 May 2023 06:56:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083f3d305fb573cd9@google.com>
Subject: [syzbot] Monthly can report (May 2023)
From:   syzbot <syzbot+listb432a87c0f88c0caf1d8@syzkaller.appspotmail.com>
To:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        mkl@pengutronix.de, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello can maintainers/developers,

This is a 31-day syzbot report for the can subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/can

During the period, 0 new issues were detected and 0 were fixed.
In total, 12 issues are still open and 45 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 277     Yes   possible deadlock in j1939_sk_queue_drop_all
                  https://syzkaller.appspot.com/bug?extid=3bd970a1887812621b4c
<2> 7       No    KCSAN: data-race in bcm_can_tx / bcm_tx_setup (3)
                  https://syzkaller.appspot.com/bug?extid=e1786f049e71693263bf
<3> 3       Yes   KASAN: use-after-free Read in j1939_xtp_rx_dat_one (3)
                  https://syzkaller.appspot.com/bug?extid=a9dce1ff45c3bbeceb3a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
