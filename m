Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7287C6F6238
	for <lists+linux-can@lfdr.de>; Thu,  4 May 2023 01:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjECXvZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 May 2023 19:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECXvY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 May 2023 19:51:24 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36338A6C
        for <linux-can@vger.kernel.org>; Wed,  3 May 2023 16:51:21 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-76978e7cd59so275751839f.2
        for <linux-can@vger.kernel.org>; Wed, 03 May 2023 16:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683157881; x=1685749881;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcZ85UohRTnIlpcVoJh324dST1aeKdAB/UA/Qi32hS0=;
        b=FPHqbRqh95PVVPYBLBiC+qcuysiTI2OasdcGAPNgn7Dfj6RNyGSLReH62ngbZsc0o0
         lz4fhfDX21SWLVLKMLN9ZrHG+Z2uybGXJRS+xYyn5GJOn73WGGksoyieFpbhXOEYj6KG
         zXF6x6+W4bYQ+3j4LO267WfFIZZF8SZBrl5kouHJ0JKGz7i9CDeEgKO+Y1QM7D4BLHtx
         12JTLrHwTJjdIreDTrO8Lbh96NEGFQAiD0d6cHdLQjZxCmgi3zMIaXsXLFu2mQWpgFWs
         ReZ8O7rMqBLnz7BeWq2ajc1aA5XRyf7dz2HUhUDp8YOR90H/Dd7GgEx+vXYtscXQAVrT
         ZG8Q==
X-Gm-Message-State: AC+VfDy2U03JgFIT1bI/YuoQP5H3Uk6zBTGjKlESP/THSNDVcVw7F9d0
        R/bB8BV/hszcCjiOy+XnY1Y580pP043lp1M09QjWLGsA8Ly9
X-Google-Smtp-Source: ACHHUZ7Bf2UNPAy6HXsUp7lRc0mXPoN88gh/boNNoZyrLkLf7rtC9mZT8aNT0c9J8Qez6j0MPSy/gM8e2N9XAxh1nMIZgRQwIOzs
MIME-Version: 1.0
X-Received: by 2002:a02:3306:0:b0:40f:8b6d:c549 with SMTP id
 c6-20020a023306000000b0040f8b6dc549mr11170398jae.2.1683157880999; Wed, 03 May
 2023 16:51:20 -0700 (PDT)
Date:   Wed, 03 May 2023 16:51:20 -0700
In-Reply-To: <00000000000065fe6705cad8850e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000991adc05fad2bb84@google.com>
Subject: Re: [syzbot] [can?] WARNING in j1939_session_deactivate
From:   syzbot <syzbot+535e5aae63c0d0433473@syzkaller.appspotmail.com>
To:     davem@davemloft.net, idosch@nvidia.com, jacob.e.keller@intel.com,
        jiri@nvidia.com, kernel@pengutronix.de, kuba@kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
        pabeni@redhat.com, robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit b20b8aec6ffc07bb547966b356780cd344f20f5b
Author: Ido Schimmel <idosch@nvidia.com>
Date:   Wed Feb 15 07:31:39 2023 +0000

    devlink: Fix netdev notifier chain corruption

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=120779c4280000
start commit:   7cd8b1542a7b ptp_pch: Load module automatically if ID matc..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=9290a409049988d4
dashboard link: https://syzkaller.appspot.com/bug?extid=535e5aae63c0d0433473
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1488b8e0b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14eabe3f300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: devlink: Fix netdev notifier chain corruption

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
